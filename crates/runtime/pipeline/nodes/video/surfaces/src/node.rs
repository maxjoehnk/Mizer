use anyhow::anyhow;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_surfaces::{SurfaceId, SurfaceRegistry};
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

use crate::wgpu_pipeline::SurfaceMappingWgpuPipeline;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";

const SURFACE_SETTING: &str = "Surface";

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub struct SurfaceMappingNode {
    pub surface_id: SurfaceId,
}

impl Default for SurfaceMappingNode {
    fn default() -> Self {
        Self {
            surface_id: SurfaceId::new(),
        }
    }
}

impl ConfigurableNode for SurfaceMappingNode {
    fn settings(&self, injector: &dyn InjectDyn) -> Vec<NodeSetting> {
        let registry = injector.inject::<SurfaceRegistry>();
        let surfaces = registry
            .list_surfaces()
            .into_iter()
            .map(|surface| SelectVariant::Item {
                label: surface.name.into(),
                value: surface.id.to_string().into(),
            })
            .collect();

        vec![setting!(select SURFACE_SETTING, &self.surface_id.to_string(), surfaces).disabled()]
    }
}

impl PipelineNode for SurfaceMappingNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Surface".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Texture),
            output_port!(OUTPUT_PORT, PortType::Texture),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::SurfaceMapping
    }
}

impl ProcessingNode for SurfaceMappingNode {
    type State = Option<SurfaceMappingState>;

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
        let Some(surface_registry) = context.try_inject::<SurfaceRegistry>() else {
            return Ok(());
        };
        if state.is_none() {
            *state = Some(SurfaceMappingState::new(wgpu_context, texture_registry));
        }

        surface_registry.register_surface(self.surface_id);

        let surface = surface_registry
            .get(&self.surface_id)
            .ok_or_else(|| anyhow!("Missing surface"))?;

        let section = surface.sections.first().unwrap();

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_PORT, state.target_texture);
        state
            .pipeline
            .write_transform(wgpu_context, section.input, section.output);

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

pub struct SurfaceMappingState {
    pipeline: SurfaceMappingWgpuPipeline,
    target_texture: TextureHandle,
}

impl SurfaceMappingState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> Self {
        Self {
            pipeline: SurfaceMappingWgpuPipeline::new(context),
            target_texture: texture_registry.register(
                context,
                1920,
                1080,
                Some("Surface mapping target"),
            ),
        }
    }
}
