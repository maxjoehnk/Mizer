use enum_iterator::Sequence;
use gstreamer::prelude::*;
use gstreamer::{update_registry, Element, ElementFactory};
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::{GstreamerNode, PIPELINE};

const EFFECT_TYPE_SETTING: &str = "Effect Type";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct VideoEffectNode {
    #[serde(rename = "type")]
    pub effect_type: VideoEffectType,
}

pub struct VideoEffectState {
    node: Element,
}

impl ConfigurableNode for VideoEffectNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(enum EFFECT_TYPE_SETTING, self.effect_type)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(enum setting, EFFECT_TYPE_SETTING, self.effect_type);

        update_fallback!(setting)
    }
}

impl PipelineNode for VideoEffectNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Effect".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!("input", PortType::Gstreamer),
            output_port!("output", PortType::Gstreamer),
        ]
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
        let effect = ElementFactory::make(&format!(
            "gleffects_{}",
            effect_type.to_string().to_lowercase()
        ))
        .build()
        .unwrap();
        pipeline.add(&effect).unwrap();

        VideoEffectState { node: effect }
    }
}

impl GstreamerNode for VideoEffectState {
    fn link_to(&self, target: &dyn GstreamerNode) -> anyhow::Result<()> {
        self.node.link(target.sink())?;
        Ok(())
    }

    fn unlink_from(&self, target: &dyn GstreamerNode) {
        self.node.unlink(target.sink());
    }

    fn sink(&self) -> &Element {
        &self.node
    }
}

#[derive(
    Debug,
    Default,
    Copy,
    Clone,
    Serialize,
    Deserialize,
    PartialEq,
    Eq,
    Sequence,
    TryFromPrimitive,
    IntoPrimitive,
)]
#[serde(rename_all = "lowercase")]
#[repr(u8)]
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
    #[default]
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
        write!(f, "{:?}", self)
    }
}
