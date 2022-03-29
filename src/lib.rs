use std::path::PathBuf;
use std::sync::Arc;
use std::time::Duration;

use anyhow::Context;
use pinboard::NonEmptyPinboard;
use rayon::prelude::*;

use mizer_api::handlers::Handlers;
use mizer_devices::DeviceModule;
use mizer_fixtures::library::{FixtureLibrary, FixtureLibraryProvider};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::FixtureModule;
use mizer_gdtf_provider::GdtfProvider;
use mizer_media::api::MediaServerApi;
use mizer_media::{MediaDiscovery, MediaServer};
use mizer_message_bus::MessageBus;
use mizer_module::{Module, Runtime};
use mizer_open_fixture_library_provider::OpenFixtureLibraryProvider;
use mizer_project_files::{history::ProjectHistory, Project, ProjectManager, ProjectManagerMut};
use mizer_protocol_dmx::*;
use mizer_protocol_midi::{MidiConnectionManager, MidiModule};
use mizer_qlcplus_provider::QlcPlusProvider;
use mizer_runtime::DefaultRuntime;
use mizer_sequencer::{EffectEngine, EffectsModule, Sequencer, SequencerModule};
use mizer_session::SessionState;
use mizer_settings::Settings;

pub use crate::api::*;
pub use crate::flags::Flags;

mod api;
mod flags;

const FRAME_DELAY_60FPS: Duration = Duration::from_millis(16);

pub fn build_runtime(
    handle: tokio::runtime::Handle,
    flags: Flags,
) -> anyhow::Result<(Mizer, ApiHandler)> {
    let settings = Settings::load()?;
    let settings = Arc::new(NonEmptyPinboard::new(settings));
    log::trace!("Building mizer runtime...");
    let mut runtime = DefaultRuntime::new();
    let (api_handler, api) = Api::setup(&runtime);

    let sequencer = register_sequencer_module(&mut runtime)?;
    let effect_engine = register_effects_module(&mut runtime)?;
    register_device_module(&mut runtime, &handle)?;
    register_dmx_module(&mut runtime)?;
    register_midi_module(&mut runtime, &settings.read())?;
    let (fixture_manager, fixture_library) = register_fixtures_module(&mut runtime, &settings.read())?;

    let media_server = MediaServer::new()?;
    let media_server_api = media_server.get_api_handle();
    handle.spawn(media_server.run_api());

    let handlers = Handlers::new(
        api,
        fixture_manager,
        fixture_library,
        media_server_api.clone(),
        sequencer,
        effect_engine,
        settings.clone(),
    );

    let grpc = setup_grpc_api(&flags, handle.clone(), handlers.clone())?;
    setup_media_api(handle, &flags, media_server_api.clone())?;
    let has_project_file = flags.file.is_some();
    let mut mizer = Mizer {
        project_path: flags.file.clone(),
        flags,
        runtime,
        grpc,
        handlers,
        settings,
        media_server_api,
        session_events: MessageBus::new(),
        project_history: ProjectHistory,
    };
    if has_project_file {
        mizer.load_project()?;
    } else {
        mizer.new_project();
    }

    Ok((mizer, api_handler))
}

pub struct Mizer {
    flags: Flags,
    runtime: DefaultRuntime,
    #[allow(dead_code)]
    grpc: Option<mizer_grpc_api::Server>,
    pub handlers: Handlers<Api>,
    project_path: Option<PathBuf>,
    settings: Arc<NonEmptyPinboard<Settings>>,
    media_server_api: MediaServerApi,
    session_events: MessageBus<SessionState>,
    project_history: ProjectHistory,
}

impl Mizer {
    pub async fn run(&mut self, api_handler: &ApiHandler) {
        profiling::register_thread!("Main Loop");
        log::trace!("Entering main loop...");
        loop {
            let before = std::time::Instant::now();
            api_handler.handle(self);
            self.runtime.process();
            let after = std::time::Instant::now();
            let frame_time = after.duration_since(before);
            metrics::histogram!("mizer.frame_time", frame_time);
            if frame_time <= FRAME_DELAY_60FPS {
                tokio::time::sleep(FRAME_DELAY_60FPS - frame_time).await;
            }
            profiling::finish_frame!();
        }
    }

    fn new_project(&mut self) {
        #[cfg(feature = "tracing")]
        profiling::tracy_client::message("New Project", 0);
        self.close_project();
        let injector = self.runtime.injector_mut();
        let fixture_manager = injector.get::<FixtureManager>().unwrap();
        fixture_manager.new();
        let effects_engine = injector.get_mut::<EffectEngine>().unwrap();
        effects_engine.new();
        let sequencer = injector.get::<Sequencer>().unwrap();
        sequencer.new();
        let dmx_manager = injector.get_mut::<DmxConnectionManager>().unwrap();
        dmx_manager.new();
        self.runtime.new();
        self.send_session_update();
    }

    fn load_project_from(&mut self, path: PathBuf) -> anyhow::Result<()> {
        self.close_project();
        self.project_path = Some(path);
        self.load_project()?;

        Ok(())
    }

    fn load_project(&mut self) -> anyhow::Result<()> {
        #[cfg(feature = "tracing")]
        profiling::tracy_client::message("Loading Project", 0);
        if let Some(ref path) = self.project_path {
            let mut media_paths = Vec::new();
            log::info!("Loading project {:?}...", path);
            let project = Project::load_file(path)?;
            media_paths.extend(project.media_paths.clone());
            {
                let injector = self.runtime.injector_mut();
                let manager: &FixtureManager = injector.get().unwrap();
                manager.load(&project).context("loading fixtures")?;
                let effects_engine = injector.get_mut::<EffectEngine>().unwrap();
                effects_engine.load(&project)?;
                let sequencer = injector.get::<Sequencer>().unwrap();
                sequencer.load(&project)?;
                let dmx_manager = injector.get_mut::<DmxConnectionManager>().unwrap();
                dmx_manager.load(&project)?;
            }
            import_media_files(&media_paths, &self.media_server_api)?;
            self.runtime.load(&project).context("loading project")?;
            log::info!("Loading project...Done");

            if self.flags.generate_graph {
                self.runtime.generate_pipeline_graph()?;
            }
            self.project_history.add_project(path)?;
            self.send_session_update();
        }

        Ok(())
    }

    fn save_project_as(&mut self, path: PathBuf) -> anyhow::Result<()> {
        self.project_path = Some(path.clone());
        self.save_project()?;
        self.project_history.add_project(&path)?;
        self.send_session_update();

        Ok(())
    }

    fn save_project(&self) -> anyhow::Result<()> {
        #[cfg(feature = "tracing")]
        profiling::tracy_client::message("Saving Project", 0);
        if let Some(ref file) = self.project_path {
            log::info!("Saving project to {:?}...", file);
            let mut project = Project::new();
            self.runtime.save(&mut project);
            let injector = self.runtime.injector();
            let fixture_manager = injector.get::<FixtureManager>().unwrap();
            fixture_manager.save(&mut project);
            let dmx_manager = injector.get::<DmxConnectionManager>().unwrap();
            dmx_manager.save(&mut project);
            let sequencer = injector.get::<Sequencer>().unwrap();
            sequencer.save(&mut project);
            let effects_engine = injector.get::<EffectEngine>().unwrap();
            effects_engine.save(&mut project);
            project.save_file(file)?;
            log::info!("Saving project...Done");
        }
        Ok(())
    }

    fn close_project(&mut self) {
        #[cfg(feature = "tracing")]
        profiling::tracy_client::message("Closing Project", 0);
        self.runtime.clear();
        let injector = self.runtime.injector_mut();
        let fixture_manager = injector.get::<FixtureManager>().unwrap();
        fixture_manager.clear();
        let dmx_manager = injector.get_mut::<DmxConnectionManager>().unwrap();
        dmx_manager.clear();
        let sequencer = injector.get::<Sequencer>().unwrap();
        sequencer.clear();
        self.project_path = None;
        self.media_server_api.clear();
        let effects_engine = injector.get_mut::<EffectEngine>().unwrap();
        effects_engine.clear();
        self.send_session_update();
    }

    fn send_session_update(&self) {
        let history = self.project_history.load().unwrap_or_default();
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

fn register_sequencer_module(runtime: &mut DefaultRuntime) -> anyhow::Result<Sequencer> {
    let (module, sequencer) = SequencerModule::new();
    module.register(runtime)?;

    Ok(sequencer)
}

fn register_effects_module(runtime: &mut DefaultRuntime) -> anyhow::Result<EffectEngine> {
    let (module, engine) = EffectsModule::new();
    module.register(runtime)?;

    Ok(engine)
}

fn register_device_module(
    runtime: &mut DefaultRuntime,
    handle: &tokio::runtime::Handle,
) -> anyhow::Result<()> {
    let (device_module, device_manager) = DeviceModule::new();
    let handle = handle.clone();
    std::thread::spawn(move || {
        let local = tokio::task::LocalSet::new();
        local.spawn_local(device_manager.start_discovery());

        handle.block_on(local);
    });
    device_module.register(runtime)?;

    Ok(())
}

fn register_dmx_module(runtime: &mut DefaultRuntime) -> anyhow::Result<()> {
    DmxModule.register(runtime)
}

fn register_midi_module(runtime: &mut DefaultRuntime, settings: &Settings) -> anyhow::Result<()> {
    MidiModule.register(runtime)?;

    let connection_manager = runtime
        .injector_mut()
        .get_mut::<MidiConnectionManager>()
        .unwrap();
    if settings.paths.midi_device_profiles.exists() {
        connection_manager.load_device_profiles(&settings.paths.midi_device_profiles)?;
    }

    Ok(())
}

fn register_fixtures_module(
    runtime: &mut DefaultRuntime,
    settings: &Settings,
) -> anyhow::Result<(FixtureManager, FixtureLibrary)> {
    let providers = [load_ofl_provider, load_gdtf_provider, load_qlcplus_provider];
    let providers = providers
        .into_par_iter()
        .filter_map(|loader| loader(settings))
        .collect();

    let (fixture_module, fixture_manager, fixture_library) = FixtureModule::new(providers);
    fixture_module.register(runtime)?;

    Ok((fixture_manager, fixture_library))
}

fn load_ofl_provider(settings: &Settings) -> Option<Box<dyn FixtureLibraryProvider>> {
    settings
        .paths
        .fixture_libraries
        .open_fixture_library
        .as_ref()
        .map(|path| {
            log::info!("Loading open fixture library...");
            let mut ofl_provider =
                OpenFixtureLibraryProvider::new(path.to_string_lossy().to_string());
            if let Err(err) = ofl_provider.load() {
                log::warn!("Could not load open fixture library {:?}", err);
            } else {
                log::info!("Loading open fixture library...Done");
            }

            Box::new(ofl_provider) as Box<dyn FixtureLibraryProvider>
        })
}

fn load_gdtf_provider(settings: &Settings) -> Option<Box<dyn FixtureLibraryProvider>> {
    settings.paths.fixture_libraries.gdtf.as_ref().map(|path| {
        log::info!("Loading GDTF fixture library...");
        let mut gdtf_provider = GdtfProvider::new(path.to_string_lossy().to_string());
        if let Err(err) = gdtf_provider.load() {
            log::warn!("Could not load GDTF fixture library {:?}", err);
        } else {
            log::info!("Loading GDTF fixture library...Done");
        }

        Box::new(gdtf_provider) as Box<dyn FixtureLibraryProvider>
    })
}

fn load_qlcplus_provider(settings: &Settings) -> Option<Box<dyn FixtureLibraryProvider>> {
    settings
        .paths
        .fixture_libraries
        .qlcplus
        .as_ref()
        .map(|path| {
            log::info!("Loading QLC+ fixture library...");
            let mut qlcplus_provider = QlcPlusProvider::new(path.to_string_lossy().to_string());
            if let Err(err) = qlcplus_provider.load() {
                log::warn!("Could not load QLC+ fixture library {:?}", err);
            } else {
                log::info!("Loading QLC+ fixture library...Done");
            }

            Box::new(qlcplus_provider) as Box<dyn FixtureLibraryProvider>
        })
}

fn import_media_files(
    media_paths: &[String],
    media_server_api: &MediaServerApi,
) -> anyhow::Result<()> {
    let handle = tokio::runtime::Handle::try_current()?;
    for path in media_paths {
        let media_discovery = MediaDiscovery::new(media_server_api.clone(), path);
        handle.spawn(async move { media_discovery.discover().await });
    }
    Ok(())
}

fn setup_grpc_api(
    flags: &Flags,
    handle: tokio::runtime::Handle,
    handlers: Handlers<Api>,
) -> anyhow::Result<Option<mizer_grpc_api::Server>> {
    let grpc = if !flags.disable_grpc_api {
        Some(mizer_grpc_api::start(handle, handlers)?)
    } else {
        None
    };
    Ok(grpc)
}

fn setup_media_api(
    handle: tokio::runtime::Handle,
    flags: &Flags,
    media_server_api: MediaServerApi,
) -> anyhow::Result<()> {
    if !flags.disable_media_api {
        handle.spawn(mizer_media::http_api::start(media_server_api));
    }
    Ok(())
}
