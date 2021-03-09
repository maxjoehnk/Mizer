use gstreamer::prelude::*;
use gstreamer::{Element, ElementFactory};
use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::{GstreamerNode, PIPELINE};

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

impl Default for VideoEffectType {
    fn default() -> Self {
        VideoEffectType::Fisheye
    }
}

impl std::fmt::Display for VideoEffectType {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        let name = format!("{:?}", self).to_lowercase();
        write!(f, "{}", name)
    }
}

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct VideoEffectNode {
    #[serde(rename = "type")]
    effect_type: VideoEffectType,
}

pub struct VideoEffectState {
    node: Element,
}

impl PipelineNode for VideoEffectNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "VideoEffectNode".into(),
        }
    }

    fn introspect_port(&self, _: &PortId) -> Option<PortMetadata> {
        PortMetadata {
            port_type: PortType::Gstreamer,
            ..Default::default()
        }
        .into()
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![("input".into(), PortMetadata {
            port_type: PortType::Gstreamer,
            direction: PortDirection::Input,
            ..Default::default()
        }), ("output".into(), PortMetadata {
            port_type: PortType::Gstreamer,
            direction: PortDirection::Output,
            ..Default::default()
        })]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoEffect
    }
}

impl ProcessingNode for VideoEffectNode {
    type State = VideoEffectState;

    fn process(&self, _: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        VideoEffectState::new(self.effect_type)
    }
}

impl VideoEffectState {
    fn new(effect_type: VideoEffectType) -> Self {
        let pipeline = PIPELINE.lock().unwrap();
        let effect = ElementFactory::make(&format!("gleffects_{}", effect_type), None).unwrap();
        pipeline.add(&effect).unwrap();

        VideoEffectState { node: effect }
    }
}

impl GstreamerNode for VideoEffectState {
    fn link_to(&self, target: &dyn GstreamerNode) -> anyhow::Result<()> {
        self.node.link(target.sink())?;
        Ok(())
    }

    fn sink(&self) -> &Element {
        &self.node
    }
}
