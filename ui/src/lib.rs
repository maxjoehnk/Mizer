use nativeshell::{
    codec::Value,
    shell::{exec_bundle, register_observatory_listener, Context, ContextOptions},
};

use crate::plugin::channels::*;
use mizer_api::handlers::Handlers;
use mizer_api::RuntimeApi;
use mizer_util::AsyncRuntime;

mod plugin;

nativeshell::include_flutter_plugins!();

pub fn run<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static>(handlers: Handlers<R>, async_runtime: AR) -> anyhow::Result<()> {
    exec_bundle();
    register_observatory_listener("mizer".into());

    let context = Context::new(ContextOptions {
        app_namespace: "Mizer".into(),
        flutter_plugins: flutter_get_plugins(),
        ..Default::default()
    })?;

    let _connections = ConnectionsChannel::new(handlers.connections).channel(context.weak());
    let _fixtures = FixturesChannel::new(handlers.fixtures).channel(context.weak());
    let _nodes = NodesChannel::new(handlers.nodes).channel(context.weak());
    let _layouts = LayoutsChannel::new(handlers.layouts).channel(context.weak());
    let _media = MediaChannel::new(handlers.media).channel(context.weak());
    let _transport = TransportChannel::new(handlers.transport.clone()).channel(context.weak());
    let _transport_events = TransportEventChannel::new(handlers.transport, async_runtime, context.weak()).event_channel(context.weak());
    let _session = SessionChannel::new(handlers.session).channel(context.weak());

    context
        .window_manager
        .borrow_mut()
        .create_window(Value::Null, None)?;
    context.run_loop.borrow().run();

    Ok(())
}
