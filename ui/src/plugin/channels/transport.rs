use mizer_api::handlers::TransportHandler;
use flutter_engine::channel::{Channel, MethodChannel, MethodCallHandler, MethodCall};
use flutter_engine::codec::STANDARD_CODEC;
use mizer_api::models::TransportState;
use crate::plugin::channels::MethodCallExt;

#[derive(Clone)]
pub struct TransportChannel {
    handler: TransportHandler
}

impl MethodCallHandler for TransportChannel {
    fn on_method_call(&mut self, call: MethodCall) {
        match call.method().as_str() {
            "setState" => {
                if let Err(err) = self.set_state(call.args()) {
                    call.respond_error(err);
                }else {
                    call.success_empty();
                }
            }
            _ => call.not_implemented()
        }
    }
}

impl TransportChannel {
    pub fn new(handler: TransportHandler) -> Self {
        Self {
            handler
        }
    }

    pub fn channel(self) -> impl Channel {
        MethodChannel::new("mizer.live/transport", self, &STANDARD_CODEC)
    }

    fn set_state(&self, state: TransportState) -> anyhow::Result<()> {
        self.handler.set_state(state);
        Ok(())
    }
}
