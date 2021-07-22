use crate::plugin::channels::MethodReplyExt;
use mizer_api::handlers::TransportHandler;
use mizer_api::models::TransportState;
use mizer_api::RuntimeApi;
use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};
use protobuf::ProtobufEnum;

#[derive(Clone)]
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
                    let state = TransportState::from_i32(state as i32).unwrap();
                    if let Err(err) = self.set_state(state) {
                        resp.respond_error(err);
                    } else {
                        resp.send_ok(Value::Null);
                    }
                }
            }
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
}
