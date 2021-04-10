use mizer_api::handlers::LayoutsHandler;
use flutter_engine::channel::{MethodCallHandler, MethodCall, Channel, MethodChannel};
use flutter_engine::codec::STANDARD_CODEC;
use mizer_api::models::*;
use crate::plugin::channels::MethodCallExt;

#[derive(Clone)]
pub struct LayoutsChannel {
    handler: LayoutsHandler,
}

impl MethodCallHandler for LayoutsChannel {
    fn on_method_call(&mut self, call: MethodCall) {
        match call.method().as_str() {
            "getLayouts" => {
                let response = self.get_layouts();

                call.respond_msg(response);
            }
            _ => call.not_implemented()
        }
    }
}

impl LayoutsChannel {
    pub fn new(handler: LayoutsHandler) -> Self {
        Self {
            handler
        }
    }

    pub fn channel(self) -> impl Channel {
        MethodChannel::new("mizer.live/layouts", self, &STANDARD_CODEC)
    }

    fn get_layouts(&self) -> Layouts {
        self.handler.get_layouts()
    }
}
