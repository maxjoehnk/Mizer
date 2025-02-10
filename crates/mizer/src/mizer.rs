use std::path::{Path, PathBuf};
use std::time::Duration;

use anyhow::Context;

use mizer_api::handlers::Handlers;
use mizer_console::ConsoleCategory;
use mizer_media::{MediaDiscovery, MediaServer};
use mizer_message_bus::MessageBus;
use mizer_module::{ProjectHandlerContext, ProjectLoadingError, ProjectLoadingResult, Runtime};
use mizer_project_files::{history::ProjectHistory, HandlerContext, SHOWFILE_EXTENSION};
use mizer_runtime::DefaultRuntime;
use mizer_session::SessionState;
use mizer_status_bus::{ProjectStatus, StatusBus};

use crate::api::*;
use crate::flags::Flags;
use crate::project_handler::ErasedProjectHandler;

pub struct Mizer {
    pub flags: Flags,
    pub runtime: DefaultRuntime,
    pub handlers: Handlers<Api>,
    pub project_path: Option<PathBuf>,
    pub media_server_api: MediaServer,
    pub session_events: MessageBus<SessionState>,
    pub project_history: ProjectHistory,
    pub status_bus: StatusBus,
    pub(crate) project_handlers: Vec<Box<dyn ErasedProjectHandler>>,
}

pub(crate) struct NewProjectContext;

impl ProjectHandlerContext for NewProjectContext {
    fn report_issue(&mut self, issue: impl Into<String>) {
        mizer_console::error!(ConsoleCategory::Projects, "{}", issue.into());
    }
}

impl Mizer {
    pub fn run(&mut self, api_handler: &ApiHandler) {
        profiling::register_thread!("Main Loop");
        tracing::trace!("Entering main loop...");
        let histogram = metrics::histogram!("mizer.frame_time");
        let mut last_start = std::time::Instant::now();
        loop {
            let frame_delay = Duration::from_secs_f64(1f64 / self.runtime.fps());
            let before = std::time::Instant::now();
            api_handler.handle(self);
            self.runtime.process();
            let last_frame_duration = before - last_start;
            self.status_bus
                .send_fps(1f64 / last_frame_duration.as_secs_f64());
            last_start = before;
            let after = std::time::Instant::now();
            let frame_time = after.duration_since(before);
            histogram.record(frame_time);
            if frame_time <= frame_delay {
                // MacOS seems to have really inaccurate timers, so we increase the accuracy of spin_sleep
                #[cfg(target_os = "macos")]
                {
                    let sleeper = spin_sleep::SpinSleeper::new(5_000_000);
                    sleeper.sleep(frame_delay - frame_time);
                }
                #[cfg(not(target_os = "macos"))]
                spin_sleep::sleep(frame_delay - frame_time);
            }
            profiling::finish_frame!();
        }
    }

    #[profiling::function]
    pub fn new_project(&mut self) -> anyhow::Result<()> {
        tracing::info!("Creating new project...");
        mizer_util::message!("New Project", 0);
        self.runtime
            .add_status_message("Creating new project...", None);
        let injector = self.runtime.injector_mut();
        let mut context = NewProjectContext;
        for project_handler in &mut self.project_handlers {
            project_handler.new_project(&mut context, injector)?;
        }
        self.send_session_update();
        self.runtime
            .add_status_message("Created new project", Some(Duration::from_secs(10)));
        self.status_bus.send_current_project(ProjectStatus::New);
        mizer_console::info(ConsoleCategory::Projects, "New project created");

        Ok(())
    }

    #[profiling::function]
    pub fn load_project_from(&mut self, path: PathBuf) -> ProjectLoadingResult {
        self.project_path = Some(path);
        self.load_project()
    }

    #[profiling::function]
    pub fn load_project(&mut self) -> ProjectLoadingResult {
        mizer_util::message!("Loading Project", 0);
        let mut warnings = Vec::new();
        let result: Result<_, ProjectLoadingError> = if let Some(ref path) = self.project_path {
            let result = load_project(path, &mut self.runtime, &mut warnings, &mut self.project_handlers);

            if self.flags.generate_graph {
                if let Err(err) = self.runtime.generate_pipeline_graph() {
                    tracing::error!("Error generating pipeline graph {err:?}");
                }
            }
            if let Err(err) = self.project_history
                .add_project(path) {
                tracing::error!("Error updating project history {:?}", err);
            }
            self.send_session_update();
            self.runtime.add_status_message(
                format!("Project loaded ({path:?})"),
                Some(Duration::from_secs(10)),
            );
            mizer_console::info!(
                ConsoleCategory::Projects,
                "Project loaded ({})",
                path.display()
            );
            self.status_bus.send_current_project(ProjectStatus::Loaded(
                path.file_name()
                    .map(|name| name.to_string_lossy().to_string())
                    .unwrap_or_default(),
            ));

            result
        }else {
            Err(ProjectLoadingError::Unknown(anyhow::format_err!("No project path")))
        };

        match result {
            Ok(migration_result) => {
                ProjectLoadingResult {
                    warnings,
                    migration_result,
                    error: None,
                }
            }
            Err(err) => {
                ProjectLoadingResult {
                    warnings,
                    migration_result: None,
                    error: Some(err),
                }
            }
        }
    }

    #[profiling::function]
    pub fn save_project_as(&mut self, mut path: PathBuf) -> anyhow::Result<()> {
        path.set_extension(SHOWFILE_EXTENSION);
        self.project_path = Some(path.clone());
        self.save_project()?;
        self.project_history.add_project(&path)?;
        self.send_session_update();

        Ok(())
    }

    #[profiling::function]
    pub fn save_project(&mut self) -> anyhow::Result<()> {
        mizer_util::message!("Saving Project", 0);
        if let Some(ref mut path) = self.project_path {
            let mut warnings = Vec::new();
            path.set_extension(SHOWFILE_EXTENSION);
            self.runtime.add_status_message("Saving project...", None);
            tracing::info!("Saving project to {:?}...", path);
            let mut context = HandlerContext::new(&mut warnings);
            for project_handler in &mut self.project_handlers {
                project_handler.save_project(&mut context, self.runtime.injector())?;
            }
            context.save(&path)?;
            tracing::info!("Saving project...Done");
            self.runtime.add_status_message(
                format!("Project saved ({path:?})"),
                Some(Duration::from_secs(10)),
            );
            mizer_console::info!(
                ConsoleCategory::Projects,
                "Project saved ({})",
                path.display()
            );
        }
        Ok(())
    }

    #[profiling::function]
    fn send_session_update(&self) {
        let history = self.project_history.load().unwrap_or_else(|err| {
            tracing::error!("Error loading project history {:?}", err);
            Default::default()
        });
        self.session_events.send(SessionState {
            project_path: self.project_path.clone().map(|path| {
                path.into_os_string()
                    .into_string()
                    .expect("Could not convert path to string")
            }),
            project_history: history
                .into_iter()
                .map(|history| history.path.to_string_lossy().to_string())
                .collect(),
        });
    }
}

// TODO: handle transparently by MediaServer
fn start_media_discovery(
    media_paths: &[PathBuf],
    media_server_api: &MediaServer,
) -> anyhow::Result<()> {
    let handle = tokio::runtime::Handle::try_current()?;
    for path in media_paths {
        let media_discovery = MediaDiscovery::new(media_server_api.clone(), path);
        handle.spawn(async move { media_discovery.discover().await });
    }
    Ok(())
}

fn load_project(path: &Path, runtime: &mut DefaultRuntime, warnings: &mut Vec<String>, project_handlers: &mut [Box<dyn ErasedProjectHandler>]) -> Result<Option<(u32, u32)>, ProjectLoadingError> {
    runtime.add_status_message("Loading project...", None);
    tracing::info!("Loading project {:?}...", path);
    let mut context = HandlerContext::open(path, warnings)?;
    for project_handler in project_handlers {
        project_handler.load_project(&mut context, runtime.injector_mut())?;
    }
    tracing::info!("Loading project...Done");

    Ok(context.migration_result())
}
