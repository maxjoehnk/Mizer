use anyhow::anyhow;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

use super::wgpu_pipeline;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";
const COLOR_PORT: &str = "Color";
const X_OFFSET_PORT: &str = "X Offset";
const Y_OFFSET_PORT: &str = "Y Offset";

const X_OFFSET_SETTING: &str = "X Offset";
const Y_OFFSET_SETTING: &str = "Y Offset";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct DropShadowNode {
    pub x_offset: f64,
    pub y_offset: f64,
}

impl Default for DropShadowNode {
    fn default() -> Self {
        Self {
            x_offset: 5.0,
            y_offset: 5.0,
        }
    }
}

pub struct DropShadowState {
    pipeline: wgpu_pipeline::DropShadowWgpuPipeline,
    target_texture: TextureHandle,
}

impl ConfigurableNode for DropShadowNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(Y_OFFSET_SETTING, self.y_offset)
                .min_hint(-50.0)
                .max_hint(50.0)
                .step_size(1.),
            setting!(X_OFFSET_SETTING, self.x_offset)
                .min_hint(-50.0)
                .max_hint(50.0)
                .step_size(1.),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, Y_OFFSET_SETTING, self.y_offset);
        update!(float setting, X_OFFSET_SETTING, self.x_offset);

        update_fallback!(setting)
    }
}

impl PipelineNode for DropShadowNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Drop Shadow".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Texture),
            output_port!(OUTPUT_PORT, PortType::Texture),
            input_port!(COLOR_PORT, PortType::Color),
            input_port!(X_OFFSET_PORT, PortType::Single),
            input_port!(Y_OFFSET_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::DropShadow
    }
}

impl ProcessingNode for DropShadowNode {
    type State = Option<DropShadowState>;

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
        let x_offset = context
            .read_port::<_, f64>(X_OFFSET_PORT)
            .unwrap_or(self.x_offset);
        let y_offset = context
            .read_port::<_, f64>(Y_OFFSET_PORT)
            .unwrap_or(self.y_offset);
        let color = context
            .read_port::<_, Color>(COLOR_PORT)
            .unwrap_or(Color::BLACK);

        if state.is_none() {
            *state = Some(DropShadowState::new(wgpu_context, texture_registry)?);
        }

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_PORT, state.target_texture);
        state.pipeline.write_params(
            wgpu_context,
            color,
            (x_offset / -1920f64, y_offset / -1080f64),
        );
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

impl DropShadowState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> anyhow::Result<Self> {
        Ok(Self {
            pipeline: wgpu_pipeline::DropShadowWgpuPipeline::new(context)?,
            target_texture: texture_registry.register(context, 1920, 1080, Some("Border target")),
        })
    }
}
