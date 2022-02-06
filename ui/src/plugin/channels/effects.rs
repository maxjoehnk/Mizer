use nativeshell::shell::{MethodChannel, MethodCallHandler, EngineHandle, Context};
use nativeshell::codec::{MethodCall, MethodCallReply, Value};

use mizer_api::handlers::{EffectsHandler};
use mizer_api::models::Effects;

use crate::plugin::channels::MethodReplyExt;

#[derive(Clone)]
pub struct EffectsChannel {
    handler: EffectsHandler
}

impl MethodCallHandler for EffectsChannel {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        log::debug!("mizer.live/layouts -> {}", call.method);
        match call.method.as_str() {
            "getEffects" => {
                let effects = self.get_effects();

                resp.respond_msg(effects);
            }
            _ => resp.not_implemented(),
        }
    }
}

impl EffectsChannel {
    pub fn new(handler: EffectsHandler) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/effects", self)
    }

    pub fn get_effects(&self) -> Effects {
        self.handler.get_effects()
    }
}
