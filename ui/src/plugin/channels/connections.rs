use crate::plugin::channels::MethodReplyExt;
use mizer_api::handlers::ConnectionsHandler;
use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};
use std::rc::Rc;
use mizer_api::RuntimeApi;

#[derive(Clone)]
pub struct ConnectionsChannel<R: RuntimeApi> {
    handler: ConnectionsHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for ConnectionsChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "getConnections" => {
                let response = self.handler.get_connections();

                resp.respond_msg(response);
            }
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> ConnectionsChannel<R> {
    pub fn new(handler: ConnectionsHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Rc<Context>) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/connections", self)
    }
}
