use crate::PIPELINE;
use gstreamer::prelude::*;
use gstreamer::{Element, ElementFactory};
use mizer_node_api::*;

pub struct VideoColorBalanceNode {
    node: Element,
}

impl VideoColorBalanceNode {
    pub fn new() -> Self {
        let pipeline = PIPELINE.lock().unwrap();
        let node = ElementFactory::make("glcolorbalance", None).unwrap();
        pipeline.add(&node).unwrap();

        VideoColorBalanceNode { node }
    }
}

impl Default for VideoColorBalanceNode {
    fn default() -> Self {
        VideoColorBalanceNode::new()
    }
}

impl ProcessingNode for VideoColorBalanceNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("VideoColorBalanceNode")
            .with_inputs(vec![
                NodeInput::new("input", NodeChannel::Video),
                NodeInput::numeric("brightness"),
                NodeInput::numeric("contrast"),
                NodeInput::numeric("hue"),
                NodeInput::numeric("saturation"),
            ])
            .with_outputs(vec![NodeOutput::new("output", NodeChannel::Video)])
            .with_properties(vec![
                NodeProperty::numeric("brightness"),
                NodeProperty::numeric("contrast"),
                NodeProperty::numeric("hue"),
                NodeProperty::numeric("saturation"),
            ])
    }

    fn set_numeric_property(&mut self, property: &str, value: f64) {
        match property {
            "brightness" => self.node.set_property("brightness", &value).unwrap(),
            "contrast" => self.node.set_property("contrast", &value).unwrap(),
            "hue" => self.node.set_property("hue", &value).unwrap(),
            "saturation" => self.node.set_property("saturation", &value).unwrap(),
            _ => {}
        }
    }
}
impl SourceNode for VideoColorBalanceNode {
    fn connect_video_input(&mut self, input: &str, source: &impl ElementExt) -> ConnectionResult {
        if input == "input" {
            source.link(&self.node)?;
            Ok(())
        } else {
            Err(ConnectionError::InvalidInput)
        }
    }
}
impl DestinationNode for VideoColorBalanceNode {
    fn connect_to_video_input(
        &mut self,
        output: &str,
        node: &mut impl SourceNode,
        input: &str,
    ) -> ConnectionResult {
        if output == "output" {
            node.connect_video_input(input, &self.node)
        } else {
            Err(ConnectionError::InvalidOutput(output.to_string()))
        }
    }
}
