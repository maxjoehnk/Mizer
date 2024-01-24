use std::sync::Arc;

use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::TimecodeHandler;
use mizer_api::RuntimeApi;
use mizer_ui_ffi::{FFIToPointer, TimecodeApi};

use crate::plugin::channels::MethodReplyExt;
use crate::MethodCallExt;

#[derive(Clone)]
pub struct TimecodeChannel<R: RuntimeApi> {
    handler: TimecodeHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for TimecodeChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        log::trace!("mizer.live/timecode -> {}", call.method);
        match call.method.as_str() {
            "getTimecodes" => {
                let response = self.handler.get_timecodes();

                resp.respond_msg(response);
            }
            "addTimecode" => {
                let response = call
                    .arguments()
                    .and_then(|req| self.handler.add_timecode(req));

                resp.respond_unit_result(response);
            }
            "renameTimecode" => {
                let response = call
                    .arguments()
                    .and_then(|req| self.handler.rename_timecode(req));

                resp.respond_unit_result(response);
            }
            "deleteTimecode" => {
                let response = call
                    .arguments()
                    .and_then(|req| self.handler.delete_timecode(req));

                resp.respond_unit_result(response);
            }
            "addTimecodeControl" => {
                let response = call
                    .arguments()
                    .and_then(|req| self.handler.add_timecode_control(req));

                resp.respond_unit_result(response);
            }
            "renameTimecodeControl" => {
                let response = call
                    .arguments()
                    .and_then(|req| self.handler.rename_timecode_control(req));

                resp.respond_unit_result(response);
            }
            "deleteTimecodeControl" => {
                let response = call
                    .arguments()
                    .and_then(|req| self.handler.delete_timecode_control(req));

                resp.respond_unit_result(response);
            }
            "getTimecodePointer" => match self.get_timecode_pointer() {
                Ok(pointer) => resp.send_ok(Value::I64(pointer)),
                Err(err) => resp.respond_error(err),
            },
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> TimecodeChannel<R> {
    pub fn new(handler: TimecodeHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/timecode", self)
    }

    fn get_timecode_pointer(&self) -> anyhow::Result<i64> {
        let manager = self.handler.get_timecode_manager();
        let api = TimecodeApi::new(manager);
        let api = Arc::new(api);

        Ok(api.to_pointer() as i64)
    }
}
