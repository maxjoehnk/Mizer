use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::MappingsHandler;
use mizer_api::RuntimeApi;

use crate::plugin::channels::MethodReplyExt;
use crate::MethodCallExt;

#[derive(Clone)]
pub struct MappingsChannel<R: RuntimeApi> {
    handler: MappingsHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for MappingsChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        log::trace!("mizer.live/mappings -> {}", call.method);
        match call.method.as_str() {
            "addMapping" => match call.arguments().map(|req| self.handler.add_template(req)) {
                Ok(()) => resp.send_ok(Value::Null),
                Err(e) => resp.respond_error(e),
            },
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> MappingsChannel<R> {
    pub fn new(handler: MappingsHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/mappings", self)
    }
}
