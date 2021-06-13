pub use self::fixtures::*;
pub use self::layouts::*;
pub use self::media::*;
pub use self::nodes::*;
pub use self::session::*;
pub use self::transport::*;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::library::FixtureLibrary;
use mizer_media::api::MediaServerApi;
use mizer_runtime::RuntimeApi;

mod fixtures;
mod layouts;
mod media;
mod nodes;
mod session;
mod transport;

#[derive(Clone)]
pub struct Handlers {
    pub fixtures: FixturesHandler,
    pub layouts: LayoutsHandler,
    pub media: MediaHandler,
    pub nodes: NodesHandler,
    pub session: SessionHandler,
    pub transport: TransportHandler,
}

impl Handlers {
    pub fn new(
        runtime: RuntimeApi,
        fixture_manager: FixtureManager,
        fixture_library: FixtureLibrary,
        media_server: MediaServerApi,
    ) -> Self {
        Handlers {
            fixtures: FixturesHandler::new(fixture_manager, fixture_library, runtime.clone()),
            layouts: LayoutsHandler::new(runtime.clone()),
            media: MediaHandler::new(media_server),
            nodes: NodesHandler::new(runtime.clone()),
            session: SessionHandler::new(),
            transport: TransportHandler::new(runtime),
        }
    }
}
