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
        let node = VideoFileNode::build_node(file.into());
        VideoFileNode::link_decoder(&node);

        node
    }

    fn build_node(file: String) -> VideoFileNode {
        let pipeline = PIPELINE.lock().unwrap();
        let file_src = ElementFactory::make("filesrc", None).unwrap();
        let decoder = ElementFactory::make("decodebin", None).unwrap();
        let upload = ElementFactory::make("glupload", None).unwrap();
        let convert = ElementFactory::make("glcolorconvert", None).unwrap();
        pipeline.add(&file_src).unwrap();
        pipeline.add(&decoder).unwrap();
        pipeline.add(&upload).unwrap();
        pipeline.add(&convert).unwrap();
        file_src.set_property("location", &glib::Value::from(&file)).unwrap();
        file_src.link(&decoder).unwrap();
        upload.link(&convert).unwrap();

        VideoFileNode {
            file,
            file_src,
            decoder,
            upload,
            convert,
        }
    }

    fn link_decoder(node: &VideoFileNode) {
        let sink = node.upload.get_static_pad("sink").unwrap();
        node.decoder.connect_pad_added(move |_, pad| {
            pad.link(&sink).unwrap();
            let pipeline = PIPELINE.lock().unwrap();
            gstreamer::debug_bin_to_dot_file(&*pipeline, DebugGraphDetails::ALL, "pad");
        });
    }
}

impl ProcessingNode for VideoFileNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("VideoFileNode")
            .with_outputs(vec![NodeOutput::new("output", NodeChannel::Video)])
    }
}
impl SourceNode for VideoFileNode {}
impl DestinationNode for VideoFileNode {
    fn connect_to_video_input(&mut self, output: &str, node: &mut impl SourceNode, input: &str) -> ConnectionResult {
        if output == "output" {
            node.connect_video_input(input, &self.convert)
        } else {
            Err(ConnectionError::InvalidOutput(output.to_string()))
        }
    }
}
