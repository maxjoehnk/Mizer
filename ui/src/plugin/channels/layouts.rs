use mizer_api::handlers::LayoutsHandler;
use mizer_api::models::*;
use crate::plugin::channels::MethodReplyExt;
use nativeshell::codec::{MethodCall, Value, MethodCallReply};
use nativeshell::shell::{MethodCallHandler, EngineHandle, MethodChannel, Context};
use std::rc::Rc;

#[derive(Clone)]
pub struct LayoutsChannel {
    handler: LayoutsHandler,
}

impl MethodCallHandler for LayoutsChannel {
    fn on_method_call(&mut self, call: MethodCall<Value>, resp: MethodCallReply<Value>, _: EngineHandle) {
        match call.method.as_str() {
            "getLayouts" => {
                let response = self.get_layouts();

                resp.respond_msg(response);
            }
            _ => resp.not_implemented()
        }
    }
}

impl LayoutsChannel {
    pub fn new(handler: LayoutsHandler) -> Self {
        Self {
            handler
        }
    }

    pub fn channel(self, context: Rc<Context>) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/layouts", self)
    }

    fn get_layouts(&self) -> Layouts {
        self.handler.get_layouts()
    }
}
