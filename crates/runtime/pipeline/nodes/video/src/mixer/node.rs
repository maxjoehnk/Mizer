use crate::mixer::wgpu_pipeline::MixerWgpuPipeline;
use anyhow::anyhow;
use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};
use serde::{Deserialize, Serialize};
use std::ops::Deref;

const INPUTS_PORT: &str = "Inputs";
const OUTPUT_PORT: &str = "Output";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct VideoMixerNode;

impl ConfigurableNode for VideoMixerNode {}

impl PipelineNode for VideoMixerNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Video Mixer".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
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
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let wgpu_pipeline = context.inject::<WgpuPipeline>().unwrap();
        let texture_registry = context.inject::<TextureRegistry>().unwrap();

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
            .render(wgpu_context, inputs.as_slice(), &output);
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
