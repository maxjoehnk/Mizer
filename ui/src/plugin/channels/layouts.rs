use mizer_api::handlers::LayoutsHandler;
use mizer_api::models::*;
use crate::plugin::channels::{MethodReplyExt, MethodCallExt};
use nativeshell::codec::{MethodCall, Value, MethodCallReply};
use nativeshell::shell::{MethodCallHandler, EngineHandle, MethodChannel, Context};
use std::rc::Rc;
use mizer_api::RuntimeApi;

#[derive(Clone)]
pub struct LayoutsChannel<R: RuntimeApi> {
    handler: LayoutsHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for LayoutsChannel<R> {
    fn on_method_call(&mut self, call: MethodCall<Value>, resp: MethodCallReply<Value>, _: EngineHandle) {
        match call.method.as_str() {
            "getLayouts" => {
                let response = self.get_layouts();

                resp.respond_msg(response);
            }
            "addLayout" => {
                if let Value::String(name) = call.args {
                    let response = self.add_layout(name);

                    resp.respond_msg(response);
                }
            }
            "removeLayout" => {
                if let Value::String(id) = call.args {
                    let response = self.remove_layout(id);

                    resp.respond_msg(response);
                }
            }
            "renameLayout" => {
                let response = call.arguments().map(|req: RenameLayoutRequest| self.rename_layout(req.id, req.name));

                resp.respond_result(response);
            }
            _ => resp.not_implemented()
        }
    }
}

impl<R: RuntimeApi + 'static> LayoutsChannel<R> {
    pub fn new(handler: LayoutsHandler<R>) -> Self {
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

    fn add_layout(&self, name: String) -> Layouts {
        self.handler.add_layout(name)
    }

    fn remove_layout(&self, id: String) -> Layouts {
        self.handler.remove_layout(id)
    }

    fn rename_layout(&self, id: String, name: String) -> Layouts {
        self.handler.rename_layout(id, name)
    }
}
