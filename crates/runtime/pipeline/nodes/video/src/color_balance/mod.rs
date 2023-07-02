use anyhow::anyhow;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

mod wgpu_pipeline;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";
const BRIGHTNESS_PORT: &str = "Brightness";
const HUE_PORT: &str = "Hue";
const SATURATION_PORT: &str = "Saturation";

const HUE_SETTING: &str = "Hue";
const BRIGHTNESS_SETTING: &str = "Brightness";
const SATURATION_SETTING: &str = "Saturation";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct VideoColorBalanceNode {
    pub brightness: f64,
    pub hue: f64,
    pub saturation: f64,
}

impl Default for VideoColorBalanceNode {
    fn default() -> Self {
        Self {
            brightness: 1.0,
            hue: 0.0,
            saturation: 1.0,
        }
    }
}

pub struct VideoColorBalanceState {
    pipeline: wgpu_pipeline::ColorBalanceWgpuPipeline,
    target_texture: TextureHandle,
}

impl ConfigurableNode for VideoColorBalanceNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(HUE_SETTING, self.hue).min(0.0).max(360.0),
            setting!(SATURATION_SETTING, self.saturation)
                .min(0.0)
                .max_hint(1.0),
            setting!(BRIGHTNESS_SETTING, self.brightness)
                .min(0.0)
                .max_hint(1.0),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, HUE_SETTING, self.hue);
        update!(float setting, SATURATION_SETTING, self.saturation);
        update!(float setting, BRIGHTNESS_SETTING, self.brightness);

        update_fallback!(setting)
    }
}

impl PipelineNode for VideoColorBalanceNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Color Balance".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Texture),
            output_port!(OUTPUT_PORT, PortType::Texture),
            input_port!(BRIGHTNESS_PORT, PortType::Single),
            input_port!(HUE_PORT, PortType::Single),
            input_port!(SATURATION_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoColorBalance
    }
}

impl ProcessingNode for VideoColorBalanceNode {
    type State = Option<VideoColorBalanceState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let wgpu_pipeline = context.inject::<WgpuPipeline>().unwrap();
        let texture_registry = context.inject::<TextureRegistry>().unwrap();
        let brightness = context
            .read_port::<_, f64>(BRIGHTNESS_PORT)
            .unwrap_or(self.brightness);
        let hue = context
            .read_port::<_, f64>(HUE_PORT)
            .map(|hue| hue * 360.)
            .unwrap_or(self.hue);
        let saturation = context
            .read_port::<_, f64>(SATURATION_PORT)
            .unwrap_or(self.saturation);

        if state.is_none() {
            *state = Some(VideoColorBalanceState::new(wgpu_context, texture_registry));
        }

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_PORT, state.target_texture);
        state.pipeline.write_params(
            wgpu_context,
            hue as f32,
            saturation as f32,
            brightness as f32,
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

impl VideoColorBalanceState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> Self {
        Self {
            pipeline: wgpu_pipeline::ColorBalanceWgpuPipeline::new(context),
            target_texture: texture_registry.register(
                context,
                1920,
                1080,
                Some("Color balance target"),
            ),
        }
    }
}
