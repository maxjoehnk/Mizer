use crate::PIPELINE;
use gstreamer::prelude::*;
use gstreamer::{Element, ElementFactory};
use mizer_node_api::*;
use serde::{Deserialize, Serialize};

pub struct VideoEffectNode {
    effect_type: VideoEffectType,
    effect: Element,
}

#[derive(Debug, Copy, Clone, Serialize, Deserialize, PartialEq, Eq)]
#[serde(rename_all = "lowercase")]
pub enum VideoEffectType {
    /// Mirror Effect
    Mirror,
    /// Squeeze Effect
    Squeeze,
    /// Stretch Effect
    Stretch,
    /// Light Tunnel Effect
    Tunnel,
    /// FishEye Effect
    Fisheye,
    /// Twirl Effect
    Twirl,
    /// Bulge Effect
    Bulge,
    /// Square Effect
    Square,
    /// Heat Signature Effect
    Heat,
    /// Sepia Toning Effect
    Sepia,
    /// Cross Processing Effect
    XPro,
    /// Luma Cross Processing Effect
    LumaXPro,
    /// Glowing negative effect
    XRay,
    /// All Grey but Red Effect
    Sin,
    /// Glow Lighting Effect
    Glow,
    /// Sobel edge detection Effect
    Soebel,
    /// Blur with 9x9 separable convolution Effect
    Blur,
    /// Laplacian Convolution Demo Effect
    Laplacian,
}

impl std::fmt::Display for VideoEffectType {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        let name = format!("{:?}", self).to_lowercase();
        write!(f, "{}", name)
    }
}

impl VideoEffectNode {
    pub fn new(effect_type: VideoEffectType) -> Self {
        let pipeline = PIPELINE.lock().unwrap();
        let effect = ElementFactory::make(&format!("gleffects_{}", effect_type), None).unwrap();
        pipeline.add(&effect).unwrap();

        VideoEffectNode {
            effect,
            effect_type,
        }
    }
}

impl ProcessingNode for VideoEffectNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("VideoEffectNode")
            .with_inputs(vec![NodeInput::new("input", NodeChannel::Video)])
            .with_outputs(vec![NodeOutput::new("output", NodeChannel::Video)])
    }
}
impl SourceNode for VideoEffectNode {
    fn connect_video_input(&mut self, input: &str, source: &impl ElementExt) -> ConnectionResult {
        if input == "input" {
            source.link(&self.effect)?;
            Ok(())
        } else {
            Err(ConnectionError::InvalidInput)
        }
    }
}
impl DestinationNode for VideoEffectNode {
    fn connect_to_video_input(
        &mut self,
        output: &str,
        node: &mut impl SourceNode,
        input: &str,
    ) -> ConnectionResult {
        if output == "output" {
            node.connect_video_input(input, &self.effect)
        } else {
            Err(ConnectionError::InvalidOutput(output.to_string()))
        }
    }
}
