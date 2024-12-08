use anyhow::anyhow;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

mod wgpu_pipeline;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";
const HUE_PORT: &str = "Hue";
const SATURATION_PORT: &str = "Saturation";
const VALUE_PORT: &str = "Value";

const HUE_SETTING: &str = "Hue";
const SATURATION_SETTING: &str = "Saturation";
const VALUE_SETTING: &str = "Value";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct VideoHsvNode {
    pub hue: f64,
    pub saturation: f64,
    #[serde(alias = "brightness")]
    pub value: f64,
}

impl Default for VideoHsvNode {
    fn default() -> Self {
        Self {
            hue: 0.0,
            saturation: 1.0,
            value: 1.0,
        }
    }
}

pub struct VideoHsvState {
    pipeline: wgpu_pipeline::HsvWgpuPipeline,
    target_texture: TextureHandle,
}

impl ConfigurableNode for VideoHsvNode {
    fn settings(&self, _injector: &dyn InjectDyn) -> Vec<NodeSetting> {
        vec![
            setting!(HUE_SETTING, self.hue).min(0.0).max(360.0),
            setting!(SATURATION_SETTING, self.saturation)
                .min(0.0)
                .max_hint(1.0),
            setting!(VALUE_SETTING, self.value).min(0.0).max_hint(1.0),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, HUE_SETTING, self.hue);
        update!(float setting, SATURATION_SETTING, self.saturation);
        update!(float setting, VALUE_SETTING, self.value);

        update_fallback!(setting)
    }
}

impl PipelineNode for VideoHsvNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Video HSV".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Texture),
            output_port!(OUTPUT_PORT, PortType::Texture),
            input_port!(VALUE_PORT, PortType::Single),
            input_port!(HUE_PORT, PortType::Single),
            input_port!(SATURATION_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoHsv
    }
}

impl ProcessingNode for VideoHsvNode {
    type State = Option<VideoHsvState>;

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
        let value = context
            .read_port::<_, f64>(VALUE_PORT)
            .unwrap_or(self.value);
        let hue = context
            .read_port::<_, f64>(HUE_PORT)
            .map(|hue| hue * 360.)
            .unwrap_or(self.hue);
        let saturation = context
            .read_port::<_, f64>(SATURATION_PORT)
            .unwrap_or(self.saturation);

        if state.is_none() {
            *state = Some(VideoHsvState::new(wgpu_context, texture_registry)?);
        }

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_PORT, state.target_texture);
        state
            .pipeline
            .write_hsv_uniform(wgpu_context, hue as f32, saturation as f32, value as f32);
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

impl VideoHsvState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> anyhow::Result<Self> {
        Ok(Self {
            pipeline: wgpu_pipeline::HsvWgpuPipeline::new(context)?,
            target_texture: texture_registry.register(
                context,
                1920,
                1080,
                Some("Color balance target"),
            ),
        })
    }
}
