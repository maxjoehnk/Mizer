use anyhow::anyhow;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

use super::wgpu_pipeline::ColorizeTextureWgpuPipeline;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";
const COLOR_PORT: &str = "Color";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct ColorizeTextureNode;

pub struct ColorizeTextureState {
    pipeline: ColorizeTextureWgpuPipeline,
    target_texture: TextureHandle,
}

impl ConfigurableNode for ColorizeTextureNode {}

impl PipelineNode for ColorizeTextureNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Colorize Texture".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Texture),
            output_port!(OUTPUT_PORT, PortType::Texture),
            input_port!(COLOR_PORT, PortType::Color),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ColorizeTexture
    }
}

impl ProcessingNode for ColorizeTextureNode {
    type State = Option<ColorizeTextureState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let wgpu_pipeline = context.inject::<WgpuPipeline>().unwrap();
        let texture_registry = context.inject::<TextureRegistry>().unwrap();
        let color = context
            .read_port::<_, Color>(COLOR_PORT)
            .unwrap_or(Color::WHITE);

        if state.is_none() {
            *state = Some(ColorizeTextureState::new(wgpu_context, texture_registry));
        }

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_PORT, state.target_texture);
        state.pipeline.write_params(
            wgpu_context,
            color.red as f32,
            color.green as f32,
            color.blue as f32,
        );
        let output = texture_registry
            .get(&state.target_texture)
            .ok_or_else(|| anyhow!("Missing target texture"))?;
        if let Some(input) = context.read_texture(INPUT_PORT) {
            let stage = state.pipeline.render(wgpu_context, &output, &input);

            wgpu_pipeline.add_stage(stage);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl ColorizeTextureState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> Self {
        Self {
            pipeline: ColorizeTextureWgpuPipeline::new(context),
            target_texture: texture_registry.register(
                context,
                1920,
                1080,
                Some("Colorize texture target"),
            ),
        }
    }
}
