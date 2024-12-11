use anyhow::anyhow;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

use super::wgpu_pipeline;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";
const COLOR_PORT: &str = "Color";
const BORDER_WIDTH_PORT: &str = "Border Width";

const BORDER_WIDTH_SETTING: &str = "Border Width";
const TOP_BORDER_SETTING: &str = "Top Border";
const RIGHT_BORDER_SETTING: &str = "Right Border";
const BOTTOM_BORDER_SETTING: &str = "Bottom Border";
const LEFT_BORDER_SETTING: &str = "Left Border";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct TextureBorderNode {
    pub border_width: f64,
    pub top_border: bool,
    pub right_border: bool,
    pub bottom_border: bool,
    pub left_border: bool,
}

impl Default for TextureBorderNode {
    fn default() -> Self {
        Self {
            border_width: 1f64,
            top_border: true,
            right_border: true,
            bottom_border: true,
            left_border: true,
        }
    }
}

pub struct TextureBorderState {
    pipeline: wgpu_pipeline::BorderWgpuPipeline,
    target_texture: TextureHandle,
}

impl ConfigurableNode for TextureBorderNode {
    fn settings(&self, _injector: &dyn InjectDyn) -> Vec<NodeSetting> {
        vec![
            setting!(BORDER_WIDTH_SETTING, self.border_width)
                .min(0.0)
                .max_hint(1000.0),
            setting!(TOP_BORDER_SETTING, self.top_border),
            setting!(RIGHT_BORDER_SETTING, self.right_border),
            setting!(BOTTOM_BORDER_SETTING, self.bottom_border),
            setting!(LEFT_BORDER_SETTING, self.left_border),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, BORDER_WIDTH_SETTING, self.border_width);
        update!(bool setting, TOP_BORDER_SETTING, self.top_border);
        update!(bool setting, RIGHT_BORDER_SETTING, self.right_border);
        update!(bool setting, BOTTOM_BORDER_SETTING, self.bottom_border);
        update!(bool setting, LEFT_BORDER_SETTING, self.left_border);

        update_fallback!(setting)
    }
}

impl PipelineNode for TextureBorderNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Texture Border".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Texture),
            output_port!(OUTPUT_PORT, PortType::Texture),
            input_port!(COLOR_PORT, PortType::Color),
            input_port!(BORDER_WIDTH_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::TextureBorder
    }
}

impl ProcessingNode for TextureBorderNode {
    type State = Option<TextureBorderState>;

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
        let border_width = context
            .read_port::<_, f64>(BORDER_WIDTH_PORT)
            .unwrap_or(self.border_width);
        let color = context
            .read_port::<_, Color>(COLOR_PORT)
            .unwrap_or(Color::BLACK);

        if state.is_none() {
            *state = Some(TextureBorderState::new(wgpu_context, texture_registry)?);
        }

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_PORT, state.target_texture);
        state.pipeline.write_params(
            wgpu_context,
            color,
            border_width,
            (
                self.top_border,
                self.right_border,
                self.bottom_border,
                self.left_border,
            ),
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

impl TextureBorderState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> anyhow::Result<Self> {
        Ok(Self {
            pipeline: wgpu_pipeline::BorderWgpuPipeline::new(context)?,
            target_texture: texture_registry.register(context, 1920, 1080, Some("Border target")),
        })
    }
}
