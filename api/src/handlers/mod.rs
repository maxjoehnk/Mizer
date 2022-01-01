pub use self::connections::*;
pub use self::fixtures::*;
pub use self::layouts::*;
pub use self::media::*;
pub use self::nodes::*;
pub use self::programmer::*;
pub use self::sequencer::*;
pub use self::session::*;
pub use self::settings::*;
pub use self::transport::*;
use crate::RuntimeApi;
use mizer_fixtures::library::FixtureLibrary;
use mizer_fixtures::manager::FixtureManager;
use mizer_media::api::MediaServerApi;
use mizer_sequencer::Sequencer;
use mizer_settings::Settings;
use pinboard::NonEmptyPinboard;
use std::sync::Arc;

mod connections;
mod fixtures;
mod layouts;
mod media;
mod nodes;
mod programmer;
mod sequencer;
mod session;
mod settings;
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
    pub settings: SettingsHandler,
}

impl<R: RuntimeApi> Handlers<R> {
    pub fn new(
        runtime: R,
        fixture_manager: FixtureManager,
        fixture_library: FixtureLibrary,
        media_server: MediaServerApi,
        sequencer: Sequencer,
        settings: Arc<NonEmptyPinboard<Settings>>,
    ) -> Self {
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
            programmer: ProgrammerHandler::new(fixture_manager, sequencer, runtime),
            settings: SettingsHandler::new(settings),
        }
    }
}
