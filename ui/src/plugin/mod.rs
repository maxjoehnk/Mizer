use flutter_engine::plugins::Plugin;
use flutter_engine::FlutterEngine;
use mizer_api::handlers::Handlers;
use self::channels::*;

mod channels;

pub struct MizerPlugin {
    handlers: Handlers
}

impl MizerPlugin {
    pub fn new(handlers: Handlers) -> Self {
        MizerPlugin {
            handlers,
        }
    }
}

impl Plugin for MizerPlugin {
    fn plugin_name() -> &'static str {
        "mizer"
    }

    fn init(&mut self, engine: &FlutterEngine) {
        engine.register_channel(FixturesChannel::new(self.handlers.fixtures.clone()).channel());
        engine.register_channel(NodesChannel::new(self.handlers.nodes.clone()).channel());
        engine.register_channel(LayoutsChannel::new(self.handlers.layouts.clone()).channel());
        engine.register_channel(MediaChannel::new(self.handlers.media.clone()).channel());
    }
}
