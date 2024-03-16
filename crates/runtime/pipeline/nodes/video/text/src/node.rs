use std::fmt::Display;

use anyhow::{anyhow, Context};
use enum_iterator::Sequence;
use font_kit::source::SystemSource;
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureRegistry, WgpuContext, WgpuPipeline};

use crate::state::{TextStyle, TextTextureState};

const OUTPUT_PORT: &str = "Output";

const INPUT_COLOR_PORT: &str = "Color";
const INPUT_FONT_SIZE_PORT: &str = "Font Size";
const INPUT_LINE_HEIGHT_PORT: &str = "Line Height";
const INPUT_TEXT_PORT: &str = "Text";

const TEXT_SETTING: &str = "Text";
const FONT_SETTING: &str = "Font";
const FONT_SIZE_SETTING: &str = "Font Size";
const LINE_HEIGHT_SETTING: &str = "Line Height";
const FONT_WEIGHT_SETTING: &str = "Font Weight";
const ITALIC_SETTING: &str = "Italic";
const TEXT_ALIGN_SETTING: &str = "Text Align";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct VideoTextNode {
    pub text: String,
    pub font: String,
    pub font_size: f64,
    #[serde(default = "default_line_height")]
    pub line_height: f64,
    pub italic: bool,
    pub font_weight: FontWeight,
    #[serde(default)]
    pub align: TextAlign,
}

fn default_line_height() -> f64 {
    32.0
}

#[derive(
    Debug,
    Default,
    Clone,
    Copy,
    PartialEq,
    Deserialize,
    Serialize,
    Sequence,
    IntoPrimitive,
    TryFromPrimitive,
)]
#[repr(u8)]
pub enum FontWeight {
    Thin,
    ExtraLight,
    Light,
    #[default]
    Normal,
    Medium,
    SemiBold,
    Bold,
    ExtraBold,
    Black,
}

impl PartialEq<font_kit::properties::Weight> for FontWeight {
    fn eq(&self, other: &font_kit::properties::Weight) -> bool {
        use font_kit::properties::Weight;

        match self {
            Self::Thin => *other == Weight::THIN,
            Self::ExtraLight => *other == Weight::EXTRA_LIGHT,
            Self::Light => *other == Weight::LIGHT,
            Self::Normal => *other == Weight::NORMAL,
            Self::Medium => *other == Weight::MEDIUM,
            Self::SemiBold => *other == Weight::SEMIBOLD,
            Self::Bold => *other == Weight::BOLD,
            Self::ExtraBold => *other == Weight::EXTRA_BOLD,
            Self::Black => *other == Weight::BLACK,
        }
    }
}

impl Display for FontWeight {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            FontWeight::Thin => write!(f, "Thin"),
            FontWeight::ExtraLight => write!(f, "Extra Light"),
            FontWeight::Light => write!(f, "Light"),
            FontWeight::Normal => write!(f, "Normal"),
            FontWeight::Medium => write!(f, "Medium"),
            FontWeight::SemiBold => write!(f, "Semi Bold"),
            FontWeight::Bold => write!(f, "Bold"),
            FontWeight::ExtraBold => write!(f, "Extra Bold"),
            FontWeight::Black => write!(f, "Black"),
        }
    }
}

#[derive(
    Debug,
    Default,
    Clone,
    Copy,
    PartialEq,
    Deserialize,
    Serialize,
    Sequence,
    IntoPrimitive,
    TryFromPrimitive,
)]
#[repr(u8)]
pub enum TextAlign {
    #[default]
    Start,
    Middle,
    End,
}

impl Display for TextAlign {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{:?}", self)
    }
}

impl Default for VideoTextNode {
    fn default() -> Self {
        Self {
            text: "Hello World!".into(),
            font: "Arial".into(),
            font_size: 32.0,
            line_height: default_line_height(),
            italic: false,
            font_weight: Default::default(),
            align: Default::default(),
        }
    }
}

impl ConfigurableNode for VideoTextNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        let fonts = SystemSource::new()
            .all_families()
            .unwrap_or_default()
            .into_iter()
            .map(SelectVariant::from)
            .collect();

        vec![
            setting!(TEXT_SETTING, &self.text).multiline(),
            setting!(select FONT_SETTING, &self.font, fonts),
            setting!(FONT_SIZE_SETTING, self.font_size)
                .min(0.)
                .step_size(1.)
                .max_hint(100.0),
            setting!(LINE_HEIGHT_SETTING, self.line_height)
                .min(0.)
                .step_size(1.)
                .max_hint(100.0),
            setting!(enum FONT_WEIGHT_SETTING, self.font_weight),
            setting!(ITALIC_SETTING, self.italic),
            setting!(enum TEXT_ALIGN_SETTING, self.align),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(text setting, TEXT_SETTING, self.text);
        update!(select setting, FONT_SETTING, self.font);
        update!(float setting, FONT_SIZE_SETTING, self.font_size);
        update!(float setting, LINE_HEIGHT_SETTING, self.line_height);
        update!(enum setting, FONT_WEIGHT_SETTING, self.font_weight);
        update!(bool setting, ITALIC_SETTING, self.italic);
        update!(enum setting, TEXT_ALIGN_SETTING, self.align);

        update_fallback!(setting)
    }
}

impl PipelineNode for VideoTextNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Render Text".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_COLOR_PORT, PortType::Color),
            input_port!(INPUT_FONT_SIZE_PORT, PortType::Single),
            input_port!(INPUT_LINE_HEIGHT_PORT, PortType::Single),
            input_port!(INPUT_TEXT_PORT, PortType::Text),
            output_port!(OUTPUT_PORT, PortType::Texture),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoText
    }
}

impl ProcessingNode for VideoTextNode {
    type State = Option<TextTextureState>;

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

        let color = context.read_port(INPUT_COLOR_PORT).unwrap_or(Color::WHITE);
        let font_size = context
            .read_port(INPUT_FONT_SIZE_PORT)
            .unwrap_or(self.font_size);
        let line_height = context
            .read_port(INPUT_LINE_HEIGHT_PORT)
            .unwrap_or(self.line_height);

        if state.is_none() {
            *state = Some(
                TextTextureState::new(wgpu_context, texture_registry)
                    .context("Creating text texture state")?,
            );
        }

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_PORT, state.transfer_texture);
        let texture = texture_registry
            .get(&state.transfer_texture)
            .ok_or_else(|| anyhow!("Texture not found in registry"))?;

        let style = TextStyle {
            font_family: &self.font,
            font_weight: self.font_weight,
            font_size,
            line_height,
            color,
            italic: self.italic,
            align: self.align,
        };

        let option = context.text_input(INPUT_TEXT_PORT).read();
        let text = option
            .as_ref()
            .map(|text| text.as_str())
            .unwrap_or(&self.text);

        state
            .draw_text(wgpu_context, text, style)
            .context("preparing text")?;

        let stage = state
            .render(wgpu_context, &texture)
            .context("Rendering texture source pipeline")?;
        wgpu_pipeline.add_stage(stage);

        Ok(())
    }

    fn post_process(
        &self,
        _context: &impl NodeContext,
        state: &mut Self::State,
    ) -> anyhow::Result<()> {
        if let Some(state) = state.as_mut() {
            state.cleanup();
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        None
    }
}
