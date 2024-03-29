use std::fmt::Display;
use std::ops::Deref;

use anyhow::anyhow;
use enum_iterator::Sequence;
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

use crate::mixer::wgpu_pipeline::MixerWgpuPipeline;

const INPUTS_PORT: &str = "Inputs";
const OUTPUT_PORT: &str = "Output";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct VideoMixerNode {
    #[serde(default)]
    mode: VideoMixerMode,
}

#[derive(
    Default,
    Debug,
    Clone,
    Copy,
    Deserialize,
    Serialize,
    PartialEq,
    Eq,
    Sequence,
    IntoPrimitive,
    TryFromPrimitive,
)]
#[repr(u8)]
pub enum VideoMixerMode {
    #[default]
    Normal,
    Add,
    Multiply,
    Subtract,
    Overlay,
    Screen,
    SoftLight,
    HardLight,
    Difference,
    Darken,
    Lighten,
}

impl Display for VideoMixerMode {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}

impl ConfigurableNode for VideoMixerNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(enum "Mode", self.mode)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(enum setting, "Mode", self.mode);

        update_fallback!(setting)
    }
}

impl PipelineNode for VideoMixerNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Video Mixer".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUTS_PORT, PortType::Texture, multiple),
            output_port!(OUTPUT_PORT, PortType::Texture),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoMixer
    }
}

impl ProcessingNode for VideoMixerNode {
    type State = Option<VideoMixerState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let Some(wgpu_context) = context.try_inject::<WgpuContext>() else {
            return Ok(());
        };
        let Some(wgpu_pipeline) = context.try_inject::<WgpuPipeline>() else {
            return Ok(());
        };
        let Some(texture_registry) = context.try_inject::<TextureRegistry>() else {
            return Ok(());
        };

        if state.is_none() {
            *state = Some(VideoMixerState::new(wgpu_context, texture_registry));
        }

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_PORT, state.target_texture);
        let output = texture_registry
            .get(&state.target_texture)
            .ok_or_else(|| anyhow!("Missing target texture"))?;
        let inputs = context.read_textures(INPUTS_PORT);
        let inputs = inputs
            .iter()
            .map(|texture| texture.deref())
            .collect::<Vec<_>>();
        if inputs.is_empty() {
            return Ok(());
        }
        let stage = state
            .pipeline
            .render(wgpu_context, inputs.as_slice(), &output, self.mode);
        wgpu_pipeline.add_stage(stage);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

pub struct VideoMixerState {
    pipeline: MixerWgpuPipeline,
    target_texture: TextureHandle,
}

impl VideoMixerState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> Self {
        let target_texture = texture_registry.register(context, 1920, 1080, None);
        let pipeline = MixerWgpuPipeline::new(context);

        Self {
            pipeline,
            target_texture,
        }
    }
}
