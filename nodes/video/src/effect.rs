use mizer_node_api::*;
use gstreamer::{Element, ElementFactory};
use gstreamer::prelude::*;
use crate::PIPELINE;

pub struct VideoEffectNode {
    effect_type: VideoEffectType,
    effect: Element,
}

#[derive(Debug, Copy, Clone)]
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
    Laplacian
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
            effect_type
        }
    }
}

impl ProcessingNode for VideoEffectNode {}
impl InputNode for VideoEffectNode {
    fn connect_video_input(&mut self, source: &impl ElementExt) {
        source.link(&self.effect).unwrap();
    }
}
impl OutputNode for VideoEffectNode {
    fn connect_to_video_input(&mut self, input: &mut impl InputNode) {
        input.connect_video_input(&self.effect);
    }
}
