use mizer_node_api::*;
use gstreamer::{Element, ElementFactory, DebugGraphDetails};
use gstreamer::prelude::*;
use crate::PIPELINE;

pub struct VideoFileNode {
    file: String,
    file_src: Element,
    decoder: Element,
    upload: Element,
    convert: Element,
}

impl VideoFileNode {
    pub fn new<S: Into<String>>(file: S) -> Self {
        let file = file.into();
        let node = {
            let pipeline = PIPELINE.lock().unwrap();
            let file_src = ElementFactory::make("filesrc", None).unwrap();
            let decoder = ElementFactory::make("decodebin", None).unwrap();
            let convert = ElementFactory::make("glcolorconvert", None).unwrap();
            let upload = ElementFactory::make("glupload", None).unwrap();
            pipeline.add(&file_src).unwrap();
            pipeline.add(&decoder).unwrap();
            pipeline.add(&convert).unwrap();
            pipeline.add(&upload).unwrap();
            file_src.set_property("location", &glib::Value::from(&file)).unwrap();
            file_src.link(&decoder).unwrap();
            upload.link(&convert).unwrap();
            VideoFileNode {
                file,
                file_src,
                decoder,
                upload,
                convert
            }
        };
        let sink = node.upload.get_static_pad("sink").unwrap();
        node.decoder.connect_pad_added(move |_, pad| {
            pad.link(&sink).unwrap();
            let pipeline = PIPELINE.lock().unwrap();
            gstreamer::debug_bin_to_dot_file(&*pipeline, DebugGraphDetails::ALL, "pad");
        });
        node
    }
}

impl ProcessingNode for VideoFileNode {}
impl InputNode for VideoFileNode {}
impl OutputNode for VideoFileNode {
    fn connect_to_video_input(&mut self, input: &mut impl InputNode) {
        input.connect_video_input(&self.convert);
    }
}
