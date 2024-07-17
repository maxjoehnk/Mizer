use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::MediaHandler;
use mizer_api::proto::media::*;
use mizer_api::RuntimeApi;
use mizer_util::AsyncRuntime;

use crate::plugin::channels::{MethodCallExt, MethodReplyExt};

pub struct MediaChannel<AR, R> {
    handler: MediaHandler<R>,
    runtime: AR,
}

impl<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static> MethodCallHandler for MediaChannel<AR, R> {
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
            "removeTag" => {
                if let Value::String(id) = call.args {
                    let response = self.handler.remove_tag(id);

                    resp.respond_unit_result(response);
                }
            }
            "addTagToMedia" => {
                let response = call.arguments().and_then(|req: AddTagToMediaRequest| {
                    self.handler.add_tag_to_media(req.media_id, req.tag_id)
                });

                resp.respond_unit_result(response);
            }
            "removeTagFromMedia" => {
                let response = call.arguments().and_then(|req: RemoveTagFromMediaRequest| {
                    self.handler.remove_tag_from_media(req.media_id, req.tag_id)
                });

                resp.respond_unit_result(response);
            }
            "getMedia" => {
                let response = self.handler.get_media();

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
            "relinkMedia" => {
                let response = call.arguments().and_then(|req| self.handler.relink_media(req));
                
                resp.respond_unit_result(response);
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

impl<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static> MediaChannel<AR, R> {
    pub fn new(handler: MediaHandler<R>, runtime: AR) -> Self {
        Self { handler, runtime }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/media", self)
    }
}
