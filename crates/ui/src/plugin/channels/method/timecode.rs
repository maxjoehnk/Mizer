use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::TimecodeHandler;
use mizer_api::RuntimeApi;

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
}
