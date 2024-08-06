use std::sync::Arc;

use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::TransportHandler;
use mizer_api::proto::transport::TransportState;
use mizer_api::RuntimeApi;
use mizer_ui_ffi::{FFIToPointer, Transport};

use crate::plugin::channels::MethodReplyExt;

pub struct TransportChannel<R: RuntimeApi> {
    handler: TransportHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for TransportChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "setState" => {
                if let Value::I64(state) = call.args {
                    let state = TransportState::try_from(state as i32).unwrap();
                    if let Err(err) = self.set_state(state) {
                        resp.respond_error(err);
                    } else {
                        resp.send_ok(Value::Null);
                    }
                }
            }
            "setBPM" => {
                if let Value::F64(bpm) = call.args {
                    if let Err(err) = self.set_bpm(bpm) {
                        resp.respond_error(err)
                    } else {
                        resp.send_ok(Value::Null);
                    }
                }
            }
            "setFPS" => {
                if let Value::F64(fps) = call.args {
                    if let Err(err) = self.handler.set_fps(fps) {
                        resp.respond_error(err)
                    } else {
                        resp.send_ok(Value::Null);
                    }
                }
            }
            "tap" => resp.respond_unit_result(self.handler.tap()),
            "resync" => resp.respond_unit_result(self.handler.resync()),
            "getTransportPointer" => match self.get_transport_pointer() {
                Ok(ptr) => resp.send_ok(Value::I64(ptr)),
                Err(err) => resp.respond_error(err),
            },
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> TransportChannel<R> {
    pub fn new(handler: TransportHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/transport", self)
    }

    fn set_state(&self, state: TransportState) -> anyhow::Result<()> {
        self.handler.set_state(state)?;
        Ok(())
    }

    fn set_bpm(&self, bpm: f64) -> anyhow::Result<()> {
        self.handler.set_bpm(bpm)?;
        Ok(())
    }

    fn get_transport_pointer(&self) -> anyhow::Result<i64> {
        let clock_ref = self.handler.clock_ref();
        let transport = Transport { clock_ref };
        let transport = Arc::new(transport);

        Ok(transport.to_pointer() as i64)
    }
}
