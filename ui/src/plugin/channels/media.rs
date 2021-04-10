use mizer_api::handlers::MediaHandler;
use flutter_engine::channel::*;
use flutter_engine::codec::STANDARD_CODEC;
use crate::plugin::channels::MethodCallExt;
use mizer_api::models::*;

pub struct MediaChannel {
    handler: MediaHandler,
}

impl MethodCallHandler for MediaChannel {
    fn on_method_call(&mut self, call: MethodCall) {
        match call.method().as_str() {
            "createTag" => {
                let response = self.create_tag(call.args());

                call.respond_result(response);
            }
            "getMedia" => {
                let response = self.get_media();

                call.respond_result(response);
            }
            "getTagsWithMedia" => {
                let response = self.get_tags_with_media();

                call.respond_result(response);
            }
            _ => call.not_implemented()
        }
    }
}

impl MediaChannel {
    pub fn new(handler: MediaHandler) -> Self {
        Self {
            handler
        }
    }

    pub fn channel(self) -> impl Channel {
        MethodChannel::new("mizer.live/media", self, &STANDARD_CODEC)
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
