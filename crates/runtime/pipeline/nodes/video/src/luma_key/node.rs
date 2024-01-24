use anyhow::anyhow;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

use super::wgpu_pipeline::LumaKeyWgpuPipeline;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";
const THRESHOLD_PORT: &str = "Threshold";

const THRESHOLD_SETTING: &str = "Threshold";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct LumaKeyNode {
    pub threshold: f64,
}

impl Default for LumaKeyNode {
    fn default() -> Self {
        Self { threshold: 0.1 }
    }
}

pub struct LumaKeyState {
    pipeline: LumaKeyWgpuPipeline,
    target_texture: TextureHandle,
}

impl ConfigurableNode for LumaKeyNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(THRESHOLD_SETTING, self.threshold)
            .min(0.0)
            .max(1.0)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, THRESHOLD_SETTING, self.threshold);

        Ok(())
    }
}

impl PipelineNode for LumaKeyNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Luma Key".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Texture),
            input_port!(THRESHOLD_PORT, PortType::Single),
            output_port!(OUTPUT_PORT, PortType::Texture),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::LumaKey
    }
}

impl ProcessingNode for LumaKeyNode {
    type State = Option<LumaKeyState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let wgpu_pipeline = context.inject::<WgpuPipeline>().unwrap();
        let texture_registry = context.inject::<TextureRegistry>().unwrap();
        let threshold = context
            .read_port::<_, f64>(THRESHOLD_PORT)
            .unwrap_or(self.threshold);

        if state.is_none() {
            *state = Some(LumaKeyState::new(wgpu_context, texture_registry)?);
        }

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_PORT, state.target_texture);
        state.pipeline.write_params(wgpu_context, threshold as f32);
        let output = texture_registry
            .get(&state.target_texture)
            .ok_or_else(|| anyhow!("Missing target texture"))?;
        if let Some(input) = context.read_texture(INPUT_PORT) {
            let stage = state.pipeline.render(wgpu_context, &output, &input)?;

            wgpu_pipeline.add_stage(stage);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl LumaKeyState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> anyhow::Result<Self> {
        Ok(Self {
            pipeline: LumaKeyWgpuPipeline::new(context)?,
            target_texture: texture_registry.register(context, 1920, 1080, Some("Luma Key target")),
        })
    }
}
