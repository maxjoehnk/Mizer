use std::path::PathBuf;
use std::sync::Arc;
use std::time::Duration;

use anyhow::Context;
use pinboard::NonEmptyPinboard;

use mizer_api::handlers::Handlers;
use mizer_command_executor::CommandExecutorModule;
use mizer_devices::DeviceModule;
use mizer_fixtures::library::FixtureLibrary;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::FixtureModule;
use mizer_media::{MediaDiscovery, MediaModule, MediaServer};
use mizer_message_bus::MessageBus;
use mizer_module::{Module, Runtime};
use mizer_project_files::{history::ProjectHistory, Project, ProjectManager, ProjectManagerMut};
use mizer_protocol_dmx::*;
use mizer_protocol_midi::{MidiConnectionManager, MidiModule};
use mizer_protocol_mqtt::{MqttConnectionManager, MqttModule};
use mizer_protocol_osc::module::OscModule;
use mizer_protocol_osc::OscConnectionManager;
use mizer_runtime::DefaultRuntime;
use mizer_sequencer::{EffectEngine, EffectsModule, Sequencer, SequencerModule};
use mizer_session::SessionState;
use mizer_settings::{Settings, SettingsManager};
use mizer_timecode::{TimecodeManager, TimecodeModule};
use mizer_wgpu::{window::WindowModule, WgpuModule};

pub use crate::api::*;
use crate::fixture_libraries_loader::FixtureLibrariesLoader;
pub use crate::flags::Flags;

mod api;
mod fixture_libraries_loader;
mod flags;

const FRAME_DELAY_60FPS: Duration = Duration::from_millis(16);

pub fn build_runtime(
    handle: tokio::runtime::Handle,
    flags: Flags,
) -> anyhow::Result<(Mizer, ApiHandler)> {
    let mut settings = SettingsManager::new().context("Failed to load default settings")?;
    settings
        .load()
        .context("Failed to load settings from disk")?;
    let settings = Arc::new(NonEmptyPinboard::new(settings));
    log::trace!("Building mizer runtime...");
    let mut runtime = DefaultRuntime::new(flags.debug);

    let sequencer =
        register_sequencer_module(&mut runtime).context("Failed to register sequencer module")?;
    let effect_engine =
        register_effects_module(&mut runtime).context("Failed to register effects module")?;
    let timecode_manager =
        register_timecode_module(&mut runtime).context("Failed to register timecode module")?;
    register_device_module(&mut runtime, &handle).context("Failed to register devices module")?;
    register_dmx_module(&mut runtime).context("failed to register dmx module")?;
    register_mqtt_module(&mut runtime).context("failed to register mqtt module")?;
    register_osc_module(&mut runtime).context("failed to register osc module")?;
    register_midi_module(&mut runtime, &settings.read().settings)
        .context("Failed to register midi module")?;
    handle
        .block_on(register_wgpu_module(&mut runtime))
        .context("Failed to register wgpu module")?;
    let (fixture_manager, fixture_library) =
        register_fixtures_module(&mut runtime, &settings.read().settings)
            .context("Failed to register fixtures module")?;
    let (module, command_executor_api) = CommandExecutorModule::new();
    module.register(&mut runtime)?;

    FixtureLibrariesLoader(fixture_library.clone()).queue_load();

    let media_server = register_media_module(&mut runtime)?;

    let (api_handler, api) = Api::setup(&runtime, command_executor_api, settings);

    let handlers = Handlers::new(
        api,
        fixture_manager,
        fixture_library,
        media_server.clone(),
        sequencer,
        effect_engine,
        timecode_manager,
    );

    let project_file = flags.file.clone();
    let mut mizer = Mizer {
        project_path: flags.file.clone(),
        flags,
        runtime,
        handlers,
        media_server_api: media_server,
        session_events: MessageBus::new(),
        project_history: ProjectHistory,
    };
    if project_file.is_some() {
        mizer.load_project().context(format!(
            "Failed to load project file {:?}",
            project_file.unwrap()
        ))?;
    } else {
        mizer.new_project();
    }

    Ok((mizer, api_handler))
}

pub struct Mizer {
    flags: Flags,
    runtime: DefaultRuntime,
    pub handlers: Handlers<Api>,
    project_path: Option<PathBuf>,
    media_server_api: MediaServer,
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

    #[profiling::function]
    fn new_project(&mut self) {
        mizer_util::message!("New Project", 0);
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
        self.runtime.new_project();
        self.send_session_update();
    }

    #[profiling::function]
    fn load_project_from(&mut self, path: PathBuf) -> anyhow::Result<()> {
        self.close_project();
        self.project_path = Some(path);
        self.load_project()?;

        Ok(())
    }

    #[profiling::function]
    fn load_project(&mut self) -> anyhow::Result<()> {
        mizer_util::message!("Loading Project", 0);
        if let Some(ref path) = self.project_path {
            log::info!("Loading project {:?}...", path);
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
            }
            self.media_server_api
                .load(&project)
                .context("loading media files")?;
            start_media_discovery(&project.media.import_paths, &self.media_server_api)
                .context("starting media discovery")?;
            self.runtime.load(&project).context("loading project")?;
            log::info!("Loading project...Done");

            if self.flags.generate_graph {
                self.runtime.generate_pipeline_graph()?;
            }
            self.project_history
                .add_project(path)
                .context("updating history")?;
            self.send_session_update();
        }

        Ok(())
    }

    #[profiling::function]
    fn save_project_as(&mut self, path: PathBuf) -> anyhow::Result<()> {
        self.project_path = Some(path.clone());
        self.save_project()?;
        self.project_history.add_project(&path)?;
        self.send_session_update();

        Ok(())
    }

    #[profiling::function]
    fn save_project(&self) -> anyhow::Result<()> {
        mizer_util::message!("Saving Project", 0);
        if let Some(ref file) = self.project_path {
            log::info!("Saving project to {:?}...", file);
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
            self.media_server_api.save(&mut project);
            project.save_file(file)?;
            log::info!("Saving project...Done");
        }
        Ok(())
    }

    #[profiling::function]
    fn close_project(&mut self) {
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
    }

    #[profiling::function]
    fn send_session_update(&self) {
        let history = match self.project_history.load() {
            Ok(history) => history,
            Err(err) => {
                log::error!("Error loading project history {:?}", err);
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

fn register_sequencer_module(runtime: &mut DefaultRuntime) -> anyhow::Result<Sequencer> {
    let (module, sequencer) = SequencerModule::new();
    module.register(runtime)?;

    Ok(sequencer)
}

fn register_media_module(runtime: &mut DefaultRuntime) -> anyhow::Result<MediaServer> {
    let (media_module, media_server) = MediaModule::new()?;
    media_module.register(runtime)?;

    Ok(media_server)
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

fn register_mqtt_module(runtime: &mut DefaultRuntime) -> anyhow::Result<()> {
    MqttModule.register(runtime)
}

fn register_osc_module(runtime: &mut DefaultRuntime) -> anyhow::Result<()> {
    OscModule.register(runtime)
}

fn register_timecode_module(runtime: &mut DefaultRuntime) -> anyhow::Result<TimecodeManager> {
    let (module, manager) = TimecodeModule::new();
    module.register(runtime)?;

    Ok(manager)
}

fn register_midi_module(runtime: &mut DefaultRuntime, settings: &Settings) -> anyhow::Result<()> {
    MidiModule.register(runtime)?;

    let connection_manager = runtime
        .injector_mut()
        .get_mut::<MidiConnectionManager>()
        .unwrap();
    connection_manager.load_device_profiles(&settings.paths.midi_device_profiles)?;

    Ok(())
}

fn register_fixtures_module(
    runtime: &mut DefaultRuntime,
    settings: &Settings,
) -> anyhow::Result<(FixtureManager, FixtureLibrary)> {
    let providers = FixtureLibrariesLoader::get_providers(&settings.paths.fixture_libraries);

    let (fixture_module, fixture_manager, fixture_library) = FixtureModule::new(providers);
    fixture_module.register(runtime)?;

    Ok((fixture_manager, fixture_library))
}

async fn register_wgpu_module(runtime: &mut DefaultRuntime) -> anyhow::Result<()> {
    let module = WgpuModule::new().await?;
    module.register(runtime)?;
    WindowModule.register(runtime)?;

    Ok(())
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
