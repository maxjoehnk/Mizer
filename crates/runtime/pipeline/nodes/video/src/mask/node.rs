use anyhow::{anyhow, Context};
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

use super::wgpu_pipeline::TextureMaskWgpuPipeline;

const INPUT_PORT: &str = "Input";
const MASK_PORT: &str = "Mask";
const OUTPUT_PORT: &str = "Output";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct TextureMaskNode;

pub struct TextureMaskState {
    pipeline: TextureMaskWgpuPipeline,
    target_texture: TextureHandle,
}

impl ConfigurableNode for TextureMaskNode {}

impl PipelineNode for TextureMaskNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Mask".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Texture),
            input_port!(MASK_PORT, PortType::Texture),
            output_port!(OUTPUT_PORT, PortType::Texture),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::TextureMask
    }
}

impl ProcessingNode for TextureMaskNode {
    type State = Option<TextureMaskState>;

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
            *state = Some(TextureMaskState::new(wgpu_context, texture_registry)?);
        }

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_PORT, state.target_texture);
        let output = texture_registry
            .get(&state.target_texture)
            .ok_or_else(|| anyhow!("Missing target texture"))?;
        if let Some((input, mask)) = context
            .read_texture(INPUT_PORT)
            .zip(context.read_texture(MASK_PORT))
        {
            let stage = state
                .pipeline
                .render(wgpu_context, &output, &input, &mask)
                .context("Queuing Texture Mask Pipeline")?;

            wgpu_pipeline.add_stage(stage);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl TextureMaskState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> anyhow::Result<Self> {
        Ok(Self {
            pipeline: TextureMaskWgpuPipeline::new(context)
                .context("Creating Texture Mask Render Pipeline")?,
            target_texture: texture_registry.register(
                context,
                1920,
                1080,
                Some("Colorize texture target"),
            ),
        })
    }
}
