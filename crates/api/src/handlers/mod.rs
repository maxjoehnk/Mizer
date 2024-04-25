use mizer_connections::midi_device_profile::MidiDeviceProfileRegistry;
use mizer_fixtures::library::FixtureLibrary;
use mizer_fixtures::manager::FixtureManager;
use mizer_media::MediaServer;
use mizer_module::ApiInjector;
use mizer_sequencer::{EffectEngine, Sequencer};
use mizer_status_bus::StatusBus;
use mizer_surfaces::SurfaceRegistryApi;
use mizer_timecode::TimecodeManager;

use crate::RuntimeApi;

pub use self::connections::*;
pub use self::effects::*;
pub use self::fixtures::*;
pub use self::layouts::*;
pub use self::mappings::*;
pub use self::media::*;
pub use self::nodes::*;
pub use self::plans::*;
pub use self::programmer::*;
pub use self::sequencer::*;
pub use self::session::*;
pub use self::settings::*;
pub use self::status::*;
pub use self::surfaces::*;
pub use self::timecode::*;
pub use self::transport::*;

mod connections;
mod effects;
mod fixtures;
mod layouts;
mod mappings;
mod media;
mod nodes;
mod plans;
mod programmer;
mod sequencer;
mod session;
mod settings;
mod status;
mod surfaces;
mod timecode;
mod transport;

#[derive(Clone)]
pub struct Handlers<R: RuntimeApi> {
    pub connections: ConnectionsHandler<R>,
    pub fixtures: FixturesHandler<R>,
    pub layouts: LayoutsHandler<R>,
    pub media: MediaHandler,
    pub nodes: NodesHandler<R>,
    pub session: SessionHandler<R>,
    pub transport: TransportHandler<R>,
    pub sequencer: SequencerHandler<R>,
    pub programmer: ProgrammerHandler<R>,
    pub settings: SettingsHandler<R>,
    pub effects: EffectsHandler<R>,
    pub plans: PlansHandler<R>,
    pub mappings: MappingsHandler<R>,
    pub timecode: TimecodeHandler<R>,
    pub status: StatusHandler,
    pub surfaces: SurfacesHandler<R>,
}

impl<R: RuntimeApi> Handlers<R> {
    pub fn new(runtime: R, api_injector: ApiInjector, status_bus: StatusBus) -> Self {
        let fixture_manager: FixtureManager = api_injector.require_service();
        let fixture_library: FixtureLibrary = api_injector.require_service();
        let media_server: MediaServer = api_injector.require_service();
        let sequencer: Sequencer = api_injector.require_service();
        let effect_engine: EffectEngine = api_injector.require_service();
        let timecode_manager: TimecodeManager = api_injector.require_service();
        let surface_registry_api: SurfaceRegistryApi = api_injector.require_service();
        let midi_device_registry: MidiDeviceProfileRegistry = api_injector.require_service();

        Handlers {
            connections: ConnectionsHandler::new(runtime.clone()),
            fixtures: FixturesHandler::new(
                fixture_manager.clone(),
                fixture_library,
                runtime.clone(),
            ),
            layouts: LayoutsHandler::new(runtime.clone()),
            media: MediaHandler::new(media_server),
            nodes: NodesHandler::new(runtime.clone()),
            session: SessionHandler::new(runtime.clone()),
            transport: TransportHandler::new(runtime.clone()),
            sequencer: SequencerHandler::new(sequencer.clone(), runtime.clone()),
            effects: EffectsHandler::new(effect_engine, runtime.clone()),
            programmer: ProgrammerHandler::new(fixture_manager.clone(), sequencer, runtime.clone()),
            settings: SettingsHandler::new(runtime.clone(), midi_device_registry),
            plans: PlansHandler::new(fixture_manager, runtime.clone()),
            mappings: MappingsHandler::new(runtime.clone()),
            timecode: TimecodeHandler::new(timecode_manager, runtime.clone()),
            status: StatusHandler::new(status_bus),
            surfaces: SurfacesHandler::new(runtime, surface_registry_api),
        }
    }
}
