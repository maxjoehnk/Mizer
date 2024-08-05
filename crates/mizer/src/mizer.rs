use std::path::PathBuf;
use std::time::Duration;

use anyhow::Context;

use mizer_api::handlers::Handlers;
use mizer_console::ConsoleCategory;
use mizer_fixtures::manager::FixtureManager;
use mizer_media::{MediaDiscovery, MediaServer};
use mizer_message_bus::MessageBus;
use mizer_module::Runtime;
use mizer_project_files::{history::ProjectHistory, Project, ProjectManager, ProjectManagerMut};
use mizer_protocol_dmx::*;
use mizer_protocol_mqtt::MqttConnectionManager;
use mizer_protocol_osc::OscConnectionManager;
use mizer_runtime::DefaultRuntime;
use mizer_sequencer::{EffectEngine, Sequencer};
use mizer_session::SessionState;
use mizer_status_bus::{ProjectStatus, StatusBus};
use mizer_surfaces::SurfaceRegistry;
use mizer_timecode::TimecodeManager;

use crate::api::*;
use crate::flags::Flags;

pub struct Mizer {
    pub flags: Flags,
    pub runtime: DefaultRuntime,
    pub handlers: Handlers<Api>,
    pub project_path: Option<PathBuf>,
    pub media_server_api: MediaServer,
    pub session_events: MessageBus<SessionState>,
    pub project_history: ProjectHistory,
    pub status_bus: StatusBus,
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
    pub fn new_project(&mut self) {
        tracing::info!("Creating new project...");
        mizer_util::message!("New Project", 0);
        self.runtime
            .add_status_message("Creating new project...", None);
        self.close_project();
        let injector = self.runtime.injector_mut();
        let fixture_manager = injector.get::<FixtureManager>().unwrap();
        fixture_manager.new_project();
        let effects_engine = injector.get_mut::<EffectEngine>().unwrap();
        effects_engine.new_project();
        let sequencer = injector.get::<Sequencer>().unwrap();
        sequencer.new_project();
        let timecode_manager = injector.get::<TimecodeManager>().unwrap();
        timecode_manager.new_project();
        let dmx_manager = injector.get_mut::<DmxConnectionManager>().unwrap();
        dmx_manager.new_project();
        let mqtt_manager = injector.get_mut::<MqttConnectionManager>().unwrap();
        mqtt_manager.new_project();
        let osc_manager = injector.get_mut::<OscConnectionManager>().unwrap();
        osc_manager.new_project();
        let surface_registry = injector.get_mut::<SurfaceRegistry>().unwrap();
        surface_registry.new_project();
        self.runtime.new_project();
        self.send_session_update();
        self.runtime
            .add_status_message("Created new project", Some(Duration::from_secs(10)));
        self.status_bus.send_current_project(ProjectStatus::New);
        mizer_console::info(ConsoleCategory::Projects, "New project created");
    }

    #[profiling::function]
    pub fn load_project_from(&mut self, path: PathBuf) -> anyhow::Result<()> {
        self.close_project();
        self.project_path = Some(path);
        self.load_project()?;

        Ok(())
    }

    #[profiling::function]
    pub fn load_project(&mut self) -> anyhow::Result<()> {
        mizer_util::message!("Loading Project", 0);
        if let Some(ref path) = self.project_path {
            self.runtime.add_status_message("Loading project...", None);
            tracing::info!("Loading project {:?}...", path);
            let project = Project::load_file(path)?;
            {
                let injector = self.runtime.injector_mut();
                let manager: &FixtureManager = injector.get().unwrap();
                manager.load(&project).context("loading fixtures")?;
                let effects_engine = injector.get_mut::<EffectEngine>().unwrap();
                effects_engine.load(&project)?;
                let sequencer = injector.get::<Sequencer>().unwrap();
                sequencer.load(&project).context("loading sequences")?;
                let timecode_manager = injector.get::<TimecodeManager>().unwrap();
                timecode_manager
                    .load(&project)
                    .context("loading timecodes")?;
                let dmx_manager = injector.get_mut::<DmxConnectionManager>().unwrap();
                dmx_manager
                    .load(&project)
                    .context("loading dmx connections")?;
                let mqtt_manager = injector.get_mut::<MqttConnectionManager>().unwrap();
                mqtt_manager
                    .load(&project)
                    .context("loading mqtt connections")?;
                let osc_manager = injector.get_mut::<OscConnectionManager>().unwrap();
                osc_manager
                    .load(&project)
                    .context("loading osc connections")?;
                let surface_registry = injector.get_mut::<SurfaceRegistry>().unwrap();
                surface_registry
                    .load(&project)
                    .context("loading surfaces")?;
            }
            self.media_server_api
                .load(&project)
                .context("loading media files")?;
            start_media_discovery(&project.media.import_paths, &self.media_server_api)
                .context("starting media discovery")?;
            self.runtime.load(&project).context("loading project")?;
            tracing::info!("Loading project...Done");

            if self.flags.generate_graph {
                self.runtime.generate_pipeline_graph()?;
            }
            self.project_history
                .add_project(path)
                .context("updating history")?;
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
        }

        Ok(())
    }

    #[profiling::function]
    pub fn save_project_as(&mut self, path: PathBuf) -> anyhow::Result<()> {
        self.project_path = Some(path.clone());
        self.save_project()?;
        self.project_history.add_project(&path)?;
        self.send_session_update();

        Ok(())
    }

    #[profiling::function]
    pub fn save_project(&self) -> anyhow::Result<()> {
        mizer_util::message!("Saving Project", 0);
        if let Some(ref path) = self.project_path {
            self.runtime.add_status_message("Saving project...", None);
            tracing::info!("Saving project to {:?}...", path);
            let mut project = Project::new();
            self.runtime.save(&mut project);
            let injector = self.runtime.injector();
            let fixture_manager = injector.get::<FixtureManager>().unwrap();
            fixture_manager.save(&mut project);
            let dmx_manager = injector.get::<DmxConnectionManager>().unwrap();
            dmx_manager.save(&mut project);
            let mqtt_manager = injector.get::<MqttConnectionManager>().unwrap();
            mqtt_manager.save(&mut project);
            let osc_manager = injector.get::<OscConnectionManager>().unwrap();
            osc_manager.save(&mut project);
            let sequencer = injector.get::<Sequencer>().unwrap();
            sequencer.save(&mut project);
            let timecode_manager = injector.get::<TimecodeManager>().unwrap();
            timecode_manager.save(&mut project);
            let effects_engine = injector.get::<EffectEngine>().unwrap();
            effects_engine.save(&mut project);
            let surface_registry = injector.get::<SurfaceRegistry>().unwrap();
            surface_registry.save(&mut project);
            self.media_server_api.save(&mut project);
            project.save_file(path)?;
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
    pub fn close_project(&mut self) {
        mizer_util::message!("Closing Project", 0);
        self.runtime.clear();
        let injector = self.runtime.injector_mut();
        let fixture_manager = injector.get::<FixtureManager>().unwrap();
        fixture_manager.clear();
        let dmx_manager = injector.get_mut::<DmxConnectionManager>().unwrap();
        dmx_manager.clear();
        let mqtt_manager = injector.get_mut::<MqttConnectionManager>().unwrap();
        mqtt_manager.clear();
        let osc_manager = injector.get_mut::<OscConnectionManager>().unwrap();
        osc_manager.clear();
        let sequencer = injector.get::<Sequencer>().unwrap();
        sequencer.clear();
        let timecode_manager = injector.get::<TimecodeManager>().unwrap();
        timecode_manager.clear();
        self.project_path = None;
        self.media_server_api.clear();
        let effects_engine = injector.get_mut::<EffectEngine>().unwrap();
        effects_engine.clear();
        self.send_session_update();
        self.status_bus.send_current_project(ProjectStatus::None);
    }

    #[profiling::function]
    fn send_session_update(&self) {
        let history = match self.project_history.load() {
            Ok(history) => history,
            Err(err) => {
                tracing::error!("Error loading project history {:?}", err);
                Default::default()
            }
        };
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
