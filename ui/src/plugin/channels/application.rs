use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::SettingsHandler;

use crate::plugin::channels::MethodReplyExt;
use crate::LifecycleHandler;

pub struct ApplicationChannel<LH: LifecycleHandler + 'static> {
    handler: SettingsHandler,
    lifecycle_handler: Option<LH>,
}

impl<LH: LifecycleHandler + 'static> MethodCallHandler for ApplicationChannel<LH> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        reply: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "exit" => {
                if let Some(handler) = self.lifecycle_handler.take() {
                    handler.shutdown();
                }
                reply.send_ok(Value::Null);
            }
            "loadSettings" => {
                let settings = self.handler.get_settings();

                reply.respond_msg(settings);
            }
            _ => reply.not_implemented(),
        }
    }
}

impl<LH: LifecycleHandler + 'static> ApplicationChannel<LH> {
    pub fn new(handler: SettingsHandler, lifecycle_handler: LH) -> Self {
        Self {
            handler,
            lifecycle_handler: Some(lifecycle_handler),
        }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/application", self)
    }
}
