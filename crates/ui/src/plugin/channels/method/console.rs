use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{EngineHandle, MethodCallHandler, MethodChannel};
use nativeshell::Context;

use mizer_api::handlers::ConsoleHandler;
use mizer_api::proto::console::ConsoleHistory;

use crate::plugin::channels::MethodReplyExt;

#[derive(Clone)]
pub struct ConsoleChannel {
    handler: ConsoleHandler,
}

impl MethodCallHandler for ConsoleChannel {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "getConsoleHistory" => {
                let messages = self.handler.get_console_history();
                let response = ConsoleHistory { messages };

                resp.respond_msg(response);
            }
            _ => resp.not_implemented(),
        }
    }
}

impl ConsoleChannel {
    pub fn new(handler: ConsoleHandler) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/console", self)
    }
}
