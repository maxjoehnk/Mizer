use anyhow::anyhow;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

use super::wgpu_pipeline::InvertWgpuPipeline;

const INPUT_TEXTURE_PORT: &str = "Input";
const OUTPUT_TEXTURE_PORT: &str = "Output";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct InvertNode;

pub struct InvertState {
    pipeline: InvertWgpuPipeline,
    target_texture: TextureHandle,
}

impl ConfigurableNode for InvertNode {}

impl PipelineNode for InvertNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Invert".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_TEXTURE_PORT, PortType::Texture),
            output_port!(OUTPUT_TEXTURE_PORT, PortType::Texture),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Invert
    }
}

impl ProcessingNode for InvertNode {
    type State = Option<InvertState>;

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
            *state = Some(InvertState::new(wgpu_context, texture_registry)?);
        }

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_TEXTURE_PORT, state.target_texture);
        let output = texture_registry
            .get(&state.target_texture)
            .ok_or_else(|| anyhow!("Missing target texture"))?;
        if let Some(input) = context.read_texture(INPUT_TEXTURE_PORT) {
            let stage = state.pipeline.render(wgpu_context, &output, &input)?;

            wgpu_pipeline.add_stage(stage);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl InvertState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> anyhow::Result<Self> {
        Ok(Self {
            pipeline: InvertWgpuPipeline::new(context)?,
            target_texture: texture_registry.register(context, 1920, 1080, Some("Invert target")),
        })
    }
}
