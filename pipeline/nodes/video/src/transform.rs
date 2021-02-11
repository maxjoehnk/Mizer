use gstreamer::prelude::*;
use gstreamer::{Element, ElementFactory};

use mizer_node_api::*;

use crate::PIPELINE;

pub struct VideoTransformNode {
    element: Element,
    translate_x: Vec<NumericChannel>,
    translate_y: Vec<NumericChannel>,
    translate_z: Vec<NumericChannel>,
    scale_x: Vec<NumericChannel>,
    scale_y: Vec<NumericChannel>,
    rotate_x: Vec<NumericChannel>,
    rotate_y: Vec<NumericChannel>,
    rotate_z: Vec<NumericChannel>,
}

impl VideoTransformNode {
    pub fn new() -> Self {
        let pipeline = PIPELINE.lock().unwrap();
        let element = ElementFactory::make("gltransformation", None).unwrap();
        pipeline.add(&element).unwrap();

        VideoTransformNode {
            element,
            rotate_x: Default::default(),
            rotate_y: Default::default(),
            rotate_z: Default::default(),
            translate_x: Default::default(),
            translate_y: Default::default(),
            translate_z: Default::default(),
            scale_x: Default::default(),
            scale_y: Default::default(),
        }
    }
}

impl Default for VideoTransformNode {
    fn default() -> Self {
        VideoTransformNode::new()
    }
}

impl ProcessingNode for VideoTransformNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("VideoTransformNode")
            .with_inputs(vec![
                NodeInput::new("input", NodeChannel::Video),
                NodeInput::numeric("rotate-x"),
                NodeInput::numeric("rotate-y"),
                NodeInput::numeric("rotate-z"),
                NodeInput::numeric("translate-x"),
                NodeInput::numeric("translate-y"),
                NodeInput::numeric("translate-z"),
                NodeInput::numeric("scale-x"),
                NodeInput::numeric("scale-y"),
            ])
            .with_outputs(vec![NodeOutput::new("output", NodeChannel::Video)])
    }

    fn process(&mut self) {
        let props = vec![
            ("rotation-x", &self.rotate_x),
            ("rotation-y", &self.rotate_y),
            ("rotation-z", &self.rotate_z),
            ("translation-x", &self.translate_x),
            ("translation-y", &self.translate_y),
            ("translation-z", &self.translate_z),
            ("scale-x", &self.scale_x),
            ("scale-y", &self.scale_y),
        ];
        for (prop, channel) in props {
            if let Some(value) = channel
                .iter()
                .filter_map(|channel| channel.recv_last().ok().flatten())
                .last()
            {
                self.element.set_property(prop, &(value as f32)).unwrap();
            }
        }
    }
}

impl SourceNode for VideoTransformNode {
    fn connect_numeric_input(&mut self, input: &str, channel: NumericChannel) -> ConnectionResult {
        match input {
            "translate-x" => {
                self.translate_x.push(channel);
                Ok(())
            }
            "translate-y" => {
                self.translate_y.push(channel);
                Ok(())
            }
            "translate-z" => {
                self.translate_z.push(channel);
                Ok(())
            }
            "scale-x" => {
                self.scale_x.push(channel);
                Ok(())
            }
            "scale-y" => {
                self.scale_y.push(channel);
                Ok(())
            }
            "rotate-x" => {
                self.rotate_x.push(channel);
                Ok(())
            }
            "rotate-y" => {
                self.rotate_y.push(channel);
                Ok(())
            }
            "rotate-z" => {
                self.rotate_z.push(channel);
                Ok(())
            }
            _ => Err(ConnectionError::InvalidInput),
        }
    }

    fn connect_video_input(&mut self, input: &str, source: &impl ElementExt) -> ConnectionResult {
        if input == "input" {
            source.link(&self.element)?;
            Ok(())
        } else {
            Err(ConnectionError::InvalidInput)
        }
    }
}

impl DestinationNode for VideoTransformNode {
    fn connect_to_video_input(
        &mut self,
        output: &str,
        node: &mut impl SourceNode,
        input: &str,
    ) -> ConnectionResult {
        if output == "output" {
            node.connect_video_input(input, &self.element)
        } else {
            Err(ConnectionError::InvalidOutput(output.to_string()))
        }
    }
}
