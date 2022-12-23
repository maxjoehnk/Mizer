use crate::plugin::channels::MethodReplyExt;
use mizer_api::handlers::MediaHandler;
use mizer_api::models::media::*;
use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

pub struct MediaChannel {
    handler: MediaHandler,
}

impl MethodCallHandler for MediaChannel {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "createTag" => {
                if let Value::String(name) = call.args {
                    let response = self.create_tag(name);

                    resp.respond_result(response);
                }
            }
            "getMedia" => {
                let response = self.get_media();

                resp.respond_result(response);
            }
            "getTagsWithMedia" => {
                let response = self.get_tags_with_media();

                resp.respond_result(response);
            }
            _ => resp.not_implemented(),
        }
    }
}

impl MediaChannel {
    pub fn new(handler: MediaHandler) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/media", self)
    }

    fn create_tag(&self, name: String) -> anyhow::Result<MediaTag> {
        smol::block_on(self.handler.create_tag(name))
    }

    fn get_media(&self) -> anyhow::Result<MediaFiles> {
        smol::block_on(self.handler.get_media())
    }

    fn get_tags_with_media(&self) -> anyhow::Result<GroupedMediaFiles> {
        smol::block_on(self.handler.get_tags_with_media())
    }
}
