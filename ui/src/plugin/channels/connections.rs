use mizer_api::handlers::ConnectionsHandler;
use crate::plugin::channels::MethodReplyExt;
use nativeshell::codec::{MethodCallReply, MethodCall, Value};
use nativeshell::shell::{MethodChannel, MethodCallHandler, EngineHandle, Context};
use std::rc::Rc;

#[derive(Clone)]
pub struct ConnectionsChannel {
    handler: ConnectionsHandler,
}

impl MethodCallHandler for ConnectionsChannel {
    fn on_method_call(&mut self, call: MethodCall<Value>, resp: MethodCallReply<Value>, _: EngineHandle) {
        match call.method.as_str() {
            "getConnections" => {
                let response = self.handler.get_connections();

                resp.respond_msg(response);
            }
            _ => resp.not_implemented()
        }
    }
}

impl ConnectionsChannel {
    pub fn new(handler: ConnectionsHandler) -> Self {
        Self {
            handler
        }
    }

    pub fn channel(self, context: Rc<Context>) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/connections", self)
    }
}
