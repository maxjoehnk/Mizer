use anyhow::anyhow;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

use crate::rgb::wgpu_pipeline::RgbWgpuPipeline;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";
const RED_PORT: &str = "Red";
const GREEN_PORT: &str = "Green";
const BLUE_PORT: &str = "Blue";

const RED_SETTING: &str = "Red";
const GREEN_SETTING: &str = "Green";
const BLUE_SETTING: &str = "Blue";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct VideoRgbNode {
    pub red: f64,
    pub green: f64,
    pub blue: f64,
}

impl Default for VideoRgbNode {
    fn default() -> Self {
        Self {
            red: 1.0,
            green: 1.0,
            blue: 1.0,
        }
    }
}

pub struct RgbState {
    pipeline: RgbWgpuPipeline,
    target_texture: TextureHandle,
}

impl ConfigurableNode for VideoRgbNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(RED_SETTING, self.red).min(0.0).max_hint(1.0),
            setting!(GREEN_SETTING, self.green).min(0.0).max_hint(1.0),
            setting!(BLUE_SETTING, self.blue).min(0.0).max_hint(1.0),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, RED_SETTING, self.red);
        update!(float setting, GREEN_SETTING, self.green);
        update!(float setting, BLUE_SETTING, self.blue);

        update_fallback!(setting)
    }
}

impl PipelineNode for VideoRgbNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Video RGB".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Texture),
            output_port!(OUTPUT_PORT, PortType::Texture),
            input_port!(RED_PORT, PortType::Single),
            input_port!(GREEN_PORT, PortType::Single),
            input_port!(BLUE_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoRgb
    }
}

impl ProcessingNode for VideoRgbNode {
    type State = Option<RgbState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let wgpu_pipeline = context.inject::<WgpuPipeline>().unwrap();
        let texture_registry = context.inject::<TextureRegistry>().unwrap();
        let red = context.read_port::<_, f64>(RED_PORT).unwrap_or(self.red);
        let green = context
            .read_port::<_, f64>(GREEN_PORT)
            .unwrap_or(self.green);
        let blue = context.read_port::<_, f64>(BLUE_PORT).unwrap_or(self.blue);

        if state.is_none() {
            *state = Some(RgbState::new(wgpu_context, texture_registry)?);
        }

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_PORT, state.target_texture);
        state
            .pipeline
            .write_params(wgpu_context, red as f32, green as f32, blue as f32);
        let output = texture_registry
            .get(&state.target_texture)
            .ok_or_else(|| anyhow!("Missing target texture"))?;
        if let Some(input) = context.read_texture(INPUT_PORT) {
            let stage = state.pipeline.render(wgpu_context, &input, &output)?;

            wgpu_pipeline.add_stage(stage);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl RgbState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> anyhow::Result<Self> {
        Ok(Self {
            pipeline: RgbWgpuPipeline::new(context, &[1.0, 1.0, 1.0])?,
            target_texture: texture_registry.register(context, 1920, 1080, Some("RGB target")),
        })
    }
}
