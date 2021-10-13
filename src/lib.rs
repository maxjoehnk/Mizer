use std::path::PathBuf;
use std::time::Duration;

use anyhow::Context;

use mizer_api::handlers::Handlers;
use mizer_devices::DeviceModule;
use mizer_fixtures::library::{FixtureLibrary, FixtureLibraryProvider};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::FixtureModule;
use mizer_media::api::MediaServerApi;
use mizer_media::{MediaDiscovery, MediaServer};
use mizer_module::{Module, Runtime};
use mizer_open_fixture_library_provider::OpenFixtureLibraryProvider;
use mizer_project_files::{Project, ProjectManager, ProjectManagerMut};
use mizer_protocol_dmx::*;
use mizer_protocol_midi::MidiModule;
use mizer_runtime::DefaultRuntime;

pub use crate::api::*;
pub use crate::flags::Flags;
use mizer_sequencer::{SequencerModule, Sequencer};
use mizer_settings::Settings;
use pinboard::NonEmptyPinboard;
use std::sync::Arc;

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
    register_device_module(&mut runtime, &handle)?;
    register_dmx_module(&mut runtime)?;
    register_midi_module(&mut runtime)?;
    let (fixture_manager, fixture_library) = register_fixtures_module(&mut runtime)?;

    let media_server = MediaServer::new()?;
    let media_server_api = media_server.get_api_handle();
    handle.spawn(media_server.run_api());
    // import_media_files(&media_paths, &media_server_api)?;

    let handlers = Handlers::new(
        api,
        fixture_manager,
        fixture_library,
        media_server_api.clone(),
        sequencer,
        settings.clone(),
    );

    let grpc = setup_grpc_api(&flags, handle.clone(), handlers.clone())?;
    setup_media_api(handle, &flags, media_server_api)?;
    let has_project_file = flags.file.is_some();
    let mut mizer = Mizer {
        project_path: flags.file.clone(),
        flags,
        runtime,
        grpc,
        handlers,
        settings,
    };
    if has_project_file {
        mizer.load_project()?;
    }else {
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
}

impl Mizer {
    pub async fn run(&mut self, api_handler: &ApiHandler) {
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
        self.close_project();
        let injector = self.runtime.injector_mut();
        let fixture_manager = injector.get::<FixtureManager>().unwrap();
        fixture_manager.new();
        let dmx_manager = injector.get_mut::<DmxConnectionManager>().unwrap();
        dmx_manager.new();
    }

    fn load_project_from(&mut self, path: PathBuf) -> anyhow::Result<()> {
        self.project_path = Some(path);
        self.load_project()
    }

    fn load_project(&mut self) -> anyhow::Result<()> {
        self.close_project();
        if let Some(ref path) = self.project_path {
            let mut media_paths = Vec::new();
            log::info!("Loading project {:?}...", path);
            let project = Project::load_file(path)?;
            media_paths.extend(project.media_paths.clone());
            {
                let injector = self.runtime.injector_mut();
                let manager: &FixtureManager = injector.get().unwrap();
                manager.load(&project).context("loading fixtures")?;
                let sequencer = injector.get::<Sequencer>().unwrap();
                sequencer.load(&project)?;
                let dmx_manager = injector.get_mut::<DmxConnectionManager>().unwrap();
                dmx_manager.load(&project)?;
            }
            self.runtime.load(&project).context("loading project")?;
            log::info!("Loading project...Done");

            if self.flags.generate_graph {
                self.runtime.generate_pipeline_graph()?;
            }
        }

        Ok(())
    }

    fn save_project_as(&mut self, path: PathBuf) -> anyhow::Result<()> {
        self.project_path = Some(path);
        self.save_project()
    }

    fn save_project(&self) -> anyhow::Result<()> {
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
            project.save_file(file)?;
            log::info!("Saving project...Done");
        }
        Ok(())
    }

    fn close_project(&mut self) {
        self.runtime.clear();
        let injector = self.runtime.injector_mut();
        let fixture_manager = injector.get::<FixtureManager>().unwrap();
        fixture_manager.clear();
        let dmx_manager = injector.get_mut::<DmxConnectionManager>().unwrap();
        dmx_manager.clear();
        let sequencer = injector.get::<Sequencer>().unwrap();
        sequencer.clear();
    }
}

fn register_sequencer_module(
    runtime: &mut DefaultRuntime
) -> anyhow::Result<Sequencer> {
    let (module, sequencer) = SequencerModule::new();
    module.register(runtime)?;

    Ok(sequencer)
}

fn register_device_module(
    runtime: &mut DefaultRuntime,
    handle: &tokio::runtime::Handle,
) -> anyhow::Result<()> {
    let (device_module, device_manager) = DeviceModule::new();
    handle.spawn(device_manager.start_discovery());
    device_module.register(runtime)?;

    Ok(())
}

fn register_dmx_module(runtime: &mut DefaultRuntime) -> anyhow::Result<()> {
    DmxModule.register(runtime)
}

fn register_midi_module(runtime: &mut DefaultRuntime) -> anyhow::Result<()> {
    MidiModule.register(runtime)
}

fn register_fixtures_module(
    runtime: &mut DefaultRuntime,
) -> anyhow::Result<(FixtureManager, FixtureLibrary)> {
    let ofl_provider = load_ofl_provider()?;
    let providers: Vec<Box<dyn FixtureLibraryProvider>> = vec![Box::new(ofl_provider)];

    let (fixture_module, fixture_manager, fixture_library) = FixtureModule::new(providers);
    fixture_module.register(runtime)?;

    Ok((fixture_manager, fixture_library))
}

fn load_ofl_provider() -> anyhow::Result<OpenFixtureLibraryProvider> {
    log::info!("Loading open fixture library...");
    let mut ofl_provider = OpenFixtureLibraryProvider::new();
    if let Err(err) = ofl_provider.load("components/fixtures/open-fixture-library/.fixtures") {
        log::warn!("Could not load open fixture library {:?}", err);
    } else {
        log::info!("Loading open fixture library...Done");
    }

    Ok(ofl_provider)
}

// TODO: combine with project loading/saving
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
