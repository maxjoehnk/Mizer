use std::sync::Arc;

use anyhow::Context;
use pinboard::NonEmptyPinboard;

use mizer_api::handlers::Handlers;
use mizer_api::start_remote_api;
use mizer_command_executor::CommandExecutorModule;
use mizer_console::ConsoleModule;
#[cfg(feature = "debug-ui")]
use mizer_debug_ui_egui::EguiDebugUiModule;
use mizer_devices::DeviceModule;
use mizer_fixtures::library::FixtureLibrary;
use mizer_fixtures::FixtureModule;
use mizer_layouts::LayoutsModule;
use mizer_media::MediaModule;
use mizer_message_bus::MessageBus;
use mizer_module::{ApiInjector, Module, ModuleContext, Runtime};
use mizer_plan::PlansModule;
use mizer_project_files::history::ProjectHistory;
use mizer_protocol_citp::CitpModule;
use mizer_protocol_dmx::*;
use mizer_protocol_midi::MidiModule;
use mizer_protocol_mqtt::MqttModule;
use mizer_protocol_osc::module::OscModule;
use mizer_runtime::{DefaultRuntime, RuntimeModule};
use mizer_sequencer::{EffectsModule, SequencerModule};
use mizer_session::Session;
use mizer_settings::{Settings, SettingsManager};
use mizer_surfaces::SurfaceModule;
use mizer_timecode::TimecodeModule;
use mizer_vector::VectorModule;
use mizer_wgpu::{window::WindowModule, WgpuModule};

use crate::api::*;
use crate::fixture_libraries_loader::MizerFixtureLoader;
use crate::flags::Flags;
use crate::module_context::SetupContext;
use crate::Mizer;

fn load_modules(context: &mut SetupContext, flags: &Flags) {
    ConsoleModule.try_load(context);
    FixtureModule::<MizerFixtureLoader>::default().try_load(context);
    SequencerModule.try_load(context);
    EffectsModule.try_load(context);
    TimecodeModule.try_load(context);
    DeviceModule.try_load(context);
    MqttModule.try_load(context);
    OscModule.try_load(context);
    MidiModule.try_load(context);
    WgpuModule.try_load(context).then(WindowModule);
    VectorModule.try_load(context);
    LayoutsModule.try_load(context);
    PlansModule.try_load(context);
    SurfaceModule.try_load(context);
    CommandExecutorModule.try_load(context);
    MediaModule.try_load(context);
    CitpModule.try_load(context);
    DmxModule.try_load(context);
    RuntimeModule.try_load(context);

    #[cfg(feature = "debug-ui")]
    if flags.debug {
        EguiDebugUiModule(context.take_debug_ui_panes()).try_load(context);
    }
}

pub fn build_runtime(
    handle: tokio::runtime::Handle,
    flags: Flags,
) -> anyhow::Result<(Mizer, ApiHandler)> {
    tracing::trace!("Building mizer runtime...");
    let settings_manager = load_settings()?;
    let runtime = DefaultRuntime::new();
    let mut api_injector = ApiInjector::new();
    api_injector.provide(settings_manager.clone());
    let mut context = SetupContext {
        runtime,
        api_injector,
        settings: settings_manager.read().settings,
        handle: handle.clone(),
        debug_ui_panes: Vec::new(),
    };

    load_modules(&mut context, &flags);

    let status_bus = context.runtime.access().status_bus;
    context.provide_api(status_bus.handle());

    let (api_handler, api) = Api::setup(
        &context.runtime,
        context.api_injector.clone(),
        Arc::clone(&settings_manager),
    );

    let handlers = Handlers::new(api, context.api_injector.clone(), status_bus.clone());

    let remote_api_port = start_remote_api(handlers.clone())?;

    Session::new(remote_api_port)?;

    let mut mizer = Mizer {
        project_path: flags.file.clone(),
        flags,
        runtime: context.runtime,
        handlers,
        media_server_api: context.api_injector.require_service(),
        session_events: MessageBus::new(),
        project_history: ProjectHistory,
        status_bus,
    };

    if let Some(fixture_library) = mizer.runtime.injector().get::<FixtureLibrary>() {
        fixture_library.wait_for_load();
    }

    open_project(&mut mizer, settings_manager.read().settings)?;

    Ok((mizer, api_handler))
}

fn load_settings() -> anyhow::Result<Arc<NonEmptyPinboard<SettingsManager>>> {
    let mut settings_manager = SettingsManager::new().context("Failed to load default settings")?;
    settings_manager
        .load()
        .context("Failed to load settings from disk")?;
    let settings_manager = Arc::new(NonEmptyPinboard::new(settings_manager));

    Ok(settings_manager)
}

fn open_project(mizer: &mut Mizer, settings: Settings) -> anyhow::Result<()> {
    if let Some(project_file) = mizer.project_path.clone() {
        mizer
            .load_project()
            .context(format!("Failed to load project file {project_file:?}"))?;
    } else if settings.general.auto_load_last_project {
        let history = ProjectHistory.load()?;
        if let Some(last_project) = history.first() {
            tracing::info!("Loading last project {:?}", last_project);
            if let Err(err) = mizer.load_project_from(last_project.path.clone()) {
                tracing::error!("Failed to load last project: {:?}", err);
                mizer_console::error!(mizer_console::ConsoleCategory::Projects, "Failed to load last project");
            }
        } else {
            mizer.new_project();
        }
    } else {
        mizer.new_project();
    }

    Ok(())
}
