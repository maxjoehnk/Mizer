use nativeshell::{
    codec::Value,
    shell::{Context, ContextOptions, exec_bundle, register_observatory_listener},
};
use nativeshell::shell::ContextRef;

use mizer_api::handlers::Handlers;
use mizer_api::RuntimeApi;
use mizer_util::AsyncRuntime;

use crate::plugin::channels::*;

mod plugin;

nativeshell::include_flutter_plugins!();

pub fn run<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static, LH: LifecycleHandler + 'static>(
    handlers: Handlers<R>,
    async_runtime: AR,
    lifecycle_handler: LH,
) -> anyhow::Result<()> {
    exec_bundle();
    register_observatory_listener("mizer".into());

    let context = Context::new(ContextOptions {
        app_namespace: "Mizer".into(),
        flutter_plugins: flutter_get_plugins(),
        ..Default::default()
    })?;

    let lifecycle_handler = HookLifecycleHandler::new(context.weak(), lifecycle_handler);

    let _connections =
        ConnectionsChannel::new(handlers.connections.clone()).channel(context.weak());
    let _midi_monitor_events =
        MonitorMidiEventChannel::new(handlers.connections, async_runtime.clone(), context.weak())
            .event_channel(context.weak());
    let _fixtures = FixturesChannel::new(handlers.fixtures).channel(context.weak());
    let _nodes = NodesChannel::new(handlers.nodes).channel(context.weak());
    let _layouts = LayoutsChannel::new(handlers.layouts).channel(context.weak());
    let _media = MediaChannel::new(handlers.media).channel(context.weak());
    let _transport = TransportChannel::new(handlers.transport.clone()).channel(context.weak());
    let _transport_events =
        TransportEventChannel::new(handlers.transport, async_runtime.clone(), context.weak())
            .event_channel(context.weak());
    let _session = SessionChannel::new(handlers.session.clone()).channel(context.weak());
    let _session_events =
        MonitorSessionChannel::new(handlers.session, async_runtime.clone(), context.weak())
            .event_channel(context.weak());
    let _sequencer = SequencerChannel::new(handlers.sequencer).channel(context.weak());
    let _programmer = ProgrammerChannel::new(handlers.programmer.clone()).channel(context.weak());
    let _programmer_events =
        ProgrammerEventChannel::new(handlers.programmer, async_runtime, context.weak())
            .event_channel(context.weak());
    let _application = ApplicationChannel::new(handlers.settings, lifecycle_handler).channel(context.weak());

    context
        .window_manager
        .borrow_mut()
        .create_window(Value::Null, None)?;
    context.run_loop.borrow().run();

    Ok(())
}

pub trait LifecycleHandler {
    fn shutdown(self);
}

impl LifecycleHandler for ContextRef {
    fn shutdown(self) {
        // TODO: this is no clean exit.
        self.run_loop.borrow().stop();
        self.engine_manager.borrow_mut().shut_down().unwrap();
    }
}

struct HookLifecycleHandler<LH: LifecycleHandler + 'static> {
    context_handler: Context,
    app_handler: LH,
}

impl<LH: LifecycleHandler + 'static> HookLifecycleHandler<LH> {
    fn new(context: Context, handler: LH) -> Self {
        Self {
            context_handler: context,
            app_handler: handler,
        }
    }
}

impl<LH: LifecycleHandler + 'static> LifecycleHandler for HookLifecycleHandler<LH> {
    fn shutdown(self) {
        if let Some(context) = self.context_handler.get() {
            context.shutdown();
        }
        self.app_handler.shutdown();
    }
}
