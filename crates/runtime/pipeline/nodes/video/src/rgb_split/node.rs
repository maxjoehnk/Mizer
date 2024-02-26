use anyhow::anyhow;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

use crate::rgb::wgpu_pipeline::RgbWgpuPipeline;

const INPUT_PORT: &str = "Input";
const RED_PORT: &str = "Red";
const GREEN_PORT: &str = "Green";
const BLUE_PORT: &str = "Blue";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct VideoRgbSplitNode;

pub struct RgbSplitState {
    red_pipeline: RgbWgpuPipeline,
    red_target_texture: TextureHandle,
    green_pipeline: RgbWgpuPipeline,
    green_target_texture: TextureHandle,
    blue_pipeline: RgbWgpuPipeline,
    blue_target_texture: TextureHandle,
}

impl ConfigurableNode for VideoRgbSplitNode {}

impl PipelineNode for VideoRgbSplitNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Video RGB Split".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Texture),
            output_port!(RED_PORT, PortType::Texture),
            output_port!(GREEN_PORT, PortType::Texture),
            output_port!(BLUE_PORT, PortType::Texture),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoRgbSplit
    }
}

impl ProcessingNode for VideoRgbSplitNode {
    type State = Option<RgbSplitState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let Some(wgpu_context) = context.inject::<WgpuContext>() else {
            return Ok(());
        };
        let Some(wgpu_pipeline) = context.inject::<WgpuPipeline>() else {
            return Ok(());
        };
        let Some(texture_registry) = context.inject::<TextureRegistry>() else {
            return Ok(());
        };

        if state.is_none() {
            *state = Some(RgbSplitState::new(wgpu_context, texture_registry)?);
        }

        let state = state.as_mut().unwrap();
        context.write_port(RED_PORT, state.red_target_texture);
        context.write_port(GREEN_PORT, state.green_target_texture);
        context.write_port(BLUE_PORT, state.blue_target_texture);
        if let Some(input) = context.read_texture(INPUT_PORT) {
            let red_output = texture_registry
                .get(&state.red_target_texture)
                .ok_or_else(|| anyhow!("Missing target texture"))?;
            let stage = state
                .red_pipeline
                .render(wgpu_context, &input, &red_output)?;
            wgpu_pipeline.add_stage(stage);

            let green_output = texture_registry
                .get(&state.green_target_texture)
                .ok_or_else(|| anyhow!("Missing target texture"))?;
            let stage = state
                .green_pipeline
                .render(wgpu_context, &input, &green_output)?;
            wgpu_pipeline.add_stage(stage);

            let blue_output = texture_registry
                .get(&state.blue_target_texture)
                .ok_or_else(|| anyhow!("Missing target texture"))?;
            let stage = state
                .blue_pipeline
                .render(wgpu_context, &input, &blue_output)?;
            wgpu_pipeline.add_stage(stage);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl RgbSplitState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> anyhow::Result<Self> {
        Ok(Self {
            red_pipeline: RgbWgpuPipeline::new(context, &[1.0, 0.0, 0.0])?,
            red_target_texture: texture_registry.register(
                context,
                1920,
                1080,
                Some("RGB Split Red target"),
            ),
            green_pipeline: RgbWgpuPipeline::new(context, &[0.0, 1.0, 0.0])?,
            green_target_texture: texture_registry.register(
                context,
                1920,
                1080,
                Some("RGB Split Green target"),
            ),
            blue_pipeline: RgbWgpuPipeline::new(context, &[0.0, 0.0, 1.0])?,
            blue_target_texture: texture_registry.register(
                context,
                1920,
                1080,
                Some("RGB Split Blue target"),
            ),
        })
    }
}
