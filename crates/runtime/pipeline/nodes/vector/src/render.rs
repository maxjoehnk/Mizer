use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_vector::VectorWgpuRenderer;
use mizer_wgpu::{wgpu, TextureHandle, TextureRegistry, WgpuContext};

const VECTOR_INPUT_PORT: &str = "Vector";
const TEXTURE_OUTPUT_PORT: &str = "Output";

#[derive(Debug, Clone, Default, Serialize, Deserialize, Eq, PartialEq)]
pub struct RasterizeVectorNode;

impl ConfigurableNode for RasterizeVectorNode {}

impl PipelineNode for RasterizeVectorNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Rasterize Vector".to_string(),
            category: NodeCategory::Vector,
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(VECTOR_INPUT_PORT, PortType::Vector),
            output_port!(TEXTURE_OUTPUT_PORT, PortType::Texture),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::RasterizeVector
    }
}

impl ProcessingNode for RasterizeVectorNode {
    type State = Option<TextureHandle>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let Some(wgpu_context) = context.try_inject::<WgpuContext>() else {
            tracing::warn!("Wgpu context not available");
            return Ok(());
        };
        let Some(texture_registry) = context.try_inject::<TextureRegistry>() else {
            tracing::warn!("Texture registry not available");
            return Ok(());
        };
        let Some(vector_renderer) = context.try_inject::<VectorWgpuRenderer>() else {
            tracing::warn!("Vector renderer not available");
            return Ok(());
        };

        if state.is_none() {
            *state = Some(texture_registry.register_with(
                wgpu_context,
                1920,
                1080,
                wgpu::TextureFormat::Rgba8Unorm,
                wgpu::TextureUsages::COPY_SRC
                    | wgpu::TextureUsages::TEXTURE_BINDING
                    | wgpu::TextureUsages::STORAGE_BINDING,
                None,
            ));
        }

        let Some(vector) = context.vector_input(VECTOR_INPUT_PORT).read() else {
            return Ok(());
        };

        let Some(texture_handle) = state.as_ref() else {
            return Ok(());
        };
        let Some(texture) = texture_registry.get(texture_handle) else {
            return Ok(());
        };

        vector_renderer.render(&vector, wgpu_context, &texture)?;

        context.write_port(TEXTURE_OUTPUT_PORT, *texture_handle);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
