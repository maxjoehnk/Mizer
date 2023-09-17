use std::sync::Arc;

use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::StatusHandler;
use mizer_ui_ffi::{FFIToPointer, StatusApi};

use crate::plugin::channels::MethodReplyExt;

#[derive(Clone)]
pub struct StatusChannel {
    handler: StatusHandler,
}

impl MethodCallHandler for StatusChannel {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "getStatusPointer" => resp.send_ok(Value::I64(self.get_status_pointer())),
            _ => resp.not_implemented(),
        }
    }
}

impl StatusChannel {
    pub fn new(handler: StatusHandler) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/status", self)
    }

    fn get_status_pointer(&self) -> i64 {
        log::debug!("Acquiring state pointer for status");
        let fps_counter = self.handler.get_fps_counter();
        let status = StatusApi::new(fps_counter);
        let status = Arc::new(status);

        status.to_pointer() as i64
    }
}
