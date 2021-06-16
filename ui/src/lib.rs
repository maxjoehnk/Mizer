use nativeshell::{
    codec::Value,
    shell::{exec_bundle, register_observatory_listener, Context, ContextOptions},
};

use mizer_api::handlers::Handlers;
use nativeshell::shell::MessageManager;
use crate::plugin::channels::*;

mod plugin;

nativeshell::include_flutter_plugins!();

pub fn run(handlers: Handlers) -> anyhow::Result<()> {
    exec_bundle();
    register_observatory_listener("mizer".into());

    let context = Context::new(ContextOptions {
        app_namespace: "Mizer".into(),
        flutter_plugins: flutter_get_plugins(),
        ..Default::default()
    })?;

    let _fixtures = FixturesChannel::new(handlers.fixtures).channel(context.clone());
    let _nodes = NodesChannel::new(handlers.nodes).channel(context.clone());
    let _layouts = LayoutsChannel::new(handlers.layouts).channel(context.clone());
    let _media = MediaChannel::new(handlers.media).channel(context.clone());
    let _transport = TransportChannel::new(handlers.transport).channel(context.clone());

    context
        .window_manager
        .borrow_mut()
        .create_window(Value::Null, None);
    context.run_loop.borrow().run();

    Ok(())
}
