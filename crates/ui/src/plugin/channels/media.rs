use crate::plugin::channels::MethodReplyExt;
use mizer_api::handlers::MediaHandler;
use mizer_util::AsyncRuntime;
use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

pub struct MediaChannel<AR> {
    handler: MediaHandler,
    runtime: AR,
}

impl<AR: AsyncRuntime + 'static> MethodCallHandler for MediaChannel<AR> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "createTag" => {
                if let Value::String(name) = call.args {
                    let response = self.handler.create_tag(name);

                    resp.respond_result(response);
                }
            }
            "getMedia" => {
                let response = self.handler.get_media();

                resp.respond_result(response);
            }
            "getTagsWithMedia" => {
                let response = self.handler.get_tags_with_media();

                resp.respond_result(response);
            }
            "importMedia" => {
                if let Value::List(files) = call.args {
                    let files = files
                        .into_iter()
                        .filter_map(|v| match v {
                            Value::String(s) => Some(s),
                            _ => None,
                        })
                        .collect();
                    let response = self.runtime.block_on(self.handler.import_media(files));
                    resp.respond_unit_result(response);
                }
            }
            "removeMedia" => {
                if let Value::String(id) = call.args {
                    let response = self.handler.remove_media(id);
                    resp.respond_unit_result(response);
                }
            }
            "getFolders" => match self.handler.get_folders() {
                Ok(folders) => {
                    resp.send_ok(Value::List(
                        folders.into_iter().map(Value::String).collect::<Vec<_>>(),
                    ));
                }
                Err(err) => {
                    resp.respond_error(err);
                }
            },
            "addFolder" => {
                if let Value::String(path) = call.args {
                    let response = self.runtime.block_on(self.handler.add_folder(path));
                    resp.respond_unit_result(response);
                }
            }
            "removeFolder" => {
                if let Value::String(path) = call.args {
                    let response = self.handler.remove_folder(path);
                    resp.respond_unit_result(response);
                }
            }
            _ => resp.not_implemented(),
        }
    }
}

impl<AR: AsyncRuntime + 'static> MediaChannel<AR> {
    pub fn new(handler: MediaHandler, runtime: AR) -> Self {
        Self { handler, runtime }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/media", self)
    }
}
