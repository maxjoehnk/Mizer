use mizer_api::handlers::TransportHandler;
use mizer_api::models::TransportState;
use crate::plugin::channels::{MethodReplyExt};
use nativeshell::codec::{MethodCall, Value, MethodCallReply};
use protobuf::ProtobufEnum;
use nativeshell::shell::{MethodChannel, Context, MethodCallHandler, EngineHandle};
use std::rc::Rc;

#[derive(Clone)]
pub struct TransportChannel {
    handler: TransportHandler
}

impl MethodCallHandler for TransportChannel {
    fn on_method_call(&mut self, call: MethodCall<Value>, resp: MethodCallReply<Value>, _: EngineHandle) {
        match call.method.as_str() {
            "setState" => {
                if let Value::I64(state) = call.args {
                    let state = TransportState::from_i32(state as i32).unwrap();
                    if let Err(err) = self.set_state(state) {
                        resp.respond_error(err);
                    }else {
                        resp.send_ok(Value::Null);
                    }
                }
            }
            _ => resp.not_implemented()
        }
    }
}

impl TransportChannel {
    pub fn new(handler: TransportHandler) -> Self {
        Self {
            handler
        }
    }

    pub fn channel(self, context: Rc<Context>) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/transport", self)
    }

    fn set_state(&self, state: TransportState) -> anyhow::Result<()> {
        self.handler.set_state(state);
        Ok(())
    }
}
