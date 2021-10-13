use std::cell::RefCell;
use std::rc::Weak;

use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodInvokerProvider, RegisteredMethodCallHandler, MethodChannel};

use mizer_api::handlers::SettingsHandler;

use crate::plugin::channels::{MethodCallExt, MethodReplyExt};

pub struct SettingsChannel {
    handler: SettingsHandler,
}

impl MethodCallHandler for SettingsChannel {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        reply: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "loadSettings" => {
                let settings = self.handler.get_settings();

                reply.respond_msg(settings);
            }
            _ => reply.not_implemented(),
        }
    }
}

impl SettingsChannel {
    pub fn new(handler: SettingsHandler) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/settings", self)
    }
}
