use anyhow::anyhow;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

use super::wgpu_pipeline::TextureOpacityWgpuPipeline;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";
const OPACITY_PORT: &str = "Opacity";

const OPACITY_SETTING: &str = "Opacity";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct TextureOpacityNode {
    pub opacity: f64,
}

impl Default for TextureOpacityNode {
    fn default() -> Self {
        Self { opacity: 1.0 }
    }
}

pub struct TextureOpacityState {
    pipeline: TextureOpacityWgpuPipeline,
    target_texture: TextureHandle,
}

impl ConfigurableNode for TextureOpacityNode {
    fn settings(&self, _injector: &dyn InjectDyn) -> Vec<NodeSetting> {
        vec![setting!(OPACITY_SETTING, self.opacity).min(0.0).max(1.0)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, OPACITY_SETTING, self.opacity);

        Ok(())
    }
}

impl PipelineNode for TextureOpacityNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Texture Opacity".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Texture),
            input_port!(OPACITY_PORT, PortType::Single),
            output_port!(OUTPUT_PORT, PortType::Texture),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::TextureOpacity
    }
}

impl ProcessingNode for TextureOpacityNode {
    type State = Option<TextureOpacityState>;

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

        let opacity = context
            .read_port::<_, f64>(OPACITY_PORT)
            .unwrap_or(self.opacity);

        if state.is_none() {
            *state = Some(TextureOpacityState::new(wgpu_context, texture_registry));
        }

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_PORT, state.target_texture);
        state.pipeline.write_params(wgpu_context, opacity as f32);
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

impl TextureOpacityState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> Self {
        Self {
            pipeline: TextureOpacityWgpuPipeline::new(context),
            target_texture: texture_registry.register(
                context,
                1920,
                1080,
                Some("Texture opacity target"),
            ),
        }
    }
}
