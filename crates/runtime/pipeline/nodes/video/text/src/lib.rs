use std::fmt::Display;

use anyhow::{anyhow, Context};
use enum_iterator::Sequence;
use font_kit::source::SystemSource;
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};
use wgpu_glyph::ab_glyph::FontArc;
use wgpu_glyph::{FontId, GlyphBrush, GlyphBrushBuilder, Section, Text};

use mizer_node::*;
use mizer_wgpu::wgpu::util::StagingBelt;
use mizer_wgpu::wgpu::CommandBuffer;
use mizer_wgpu::{wgpu, TextureHandle, TextureRegistry, TextureView, WgpuContext, WgpuPipeline};

const OUTPUT_PORT: &str = "Output";
const COLOR_PORT: &str = "Color";
const FONT_SIZE_PORT: &str = "Font Size";

const TEXT_SETTING: &str = "Text";
const FONT_SETTING: &str = "Font";
const FONT_SIZE_SETTING: &str = "Font Size";
const FONT_WEIGHT_SETTING: &str = "Font Weight";
const ITALIC_SETTING: &str = "Italic";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct VideoTextNode {
    pub text: String,
    pub font: String,
    pub font_size: f64,
    pub italic: bool,
    pub font_weight: FontWeight,
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

impl Default for VideoTextNode {
    fn default() -> Self {
        Self {
            text: "Hello World!".into(),
            font: "Arial".into(),
            font_size: 32.0,
            italic: false,
            font_weight: Default::default(),
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
            setting!(FONT_SIZE_SETTING, self.font_size).max_hint(100.0),
            setting!(enum FONT_WEIGHT_SETTING, self.font_weight),
            setting!(ITALIC_SETTING, self.italic),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(text setting, TEXT_SETTING, self.text);
        update!(select setting, FONT_SETTING, self.font);
        update!(float setting, FONT_SIZE_SETTING, self.font_size);
        update!(enum setting, FONT_WEIGHT_SETTING, self.font_weight);
        update!(bool setting, ITALIC_SETTING, self.italic);

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

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(COLOR_PORT, PortType::Color),
            input_port!(FONT_SIZE_PORT, PortType::Single),
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
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let texture_registry = context.inject::<TextureRegistry>().unwrap();
        let video_pipeline = context.inject::<WgpuPipeline>().unwrap();

        let color = context.read_port(COLOR_PORT).unwrap_or(Color::WHITE);
        let font_size = context.read_port(FONT_SIZE_PORT).unwrap_or(self.font_size);

        if state.is_none() {
            *state = Some(
                TextTextureState::new(wgpu_context, texture_registry, self.font.clone())
                    .context("Creating text texture state")?,
            );
        }

        let state = state.as_mut().unwrap();
        state.change_font(wgpu_context, &self.font)?;
        context.write_port(OUTPUT_PORT, state.transfer_texture);
        let texture = texture_registry
            .get(&state.transfer_texture)
            .ok_or_else(|| anyhow!("Texture not found in registry"))?;
        let text = Text::new(&self.text)
            .with_font_id(state.get_font_id(self.font_weight, self.italic))
            .with_color(color)
            .with_scale(font_size as f32);
        let stage = state
            .render(wgpu_context, &texture, text)
            .context("Rendering texture source pipeline")?;
        video_pipeline.add_stage(stage);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        None
    }
}

pub struct TextTextureState {
    transfer_texture: TextureHandle,
    glyph_brush: GlyphBrush<()>,
    staging_belt: StagingBelt,
    font_family: String,
    fonts: Vec<(font_kit::font::Font, FontId)>,
}

impl TextTextureState {
    fn new(
        context: &WgpuContext,
        registry: &TextureRegistry,
        font_family: String,
    ) -> anyhow::Result<Self> {
        let transfer_texture = registry.register(context, 1920, 1080, None);
        let fonts = load_fonts(&font_family)?;
        let font_arcs = get_font_arcs(&fonts);
        let fonts = fonts
            .into_iter()
            .enumerate()
            .map(|(i, font)| (font, FontId(i)))
            .collect();
        let glyph_brush = GlyphBrushBuilder::using_fonts(font_arcs)
            .build(&context.device, wgpu::TextureFormat::Bgra8UnormSrgb);
        let staging_belt = StagingBelt::new(1024);

        Ok(Self {
            transfer_texture,
            glyph_brush,
            staging_belt,
            font_family,
            fonts,
        })
    }

    fn change_font(&mut self, context: &WgpuContext, font_family: &str) -> anyhow::Result<()> {
        if self.font_family == font_family {
            return Ok(());
        }

        let fonts = load_fonts(font_family)?;
        let font_arcs = get_font_arcs(&fonts);
        self.font_family = font_family.to_string();
        self.glyph_brush = GlyphBrushBuilder::using_fonts(font_arcs)
            .build(&context.device, wgpu::TextureFormat::Bgra8UnormSrgb);
        self.fonts = fonts
            .into_iter()
            .enumerate()
            .map(|(i, font)| (font, FontId(i)))
            .collect();

        Ok(())
    }

    fn get_font_id(&self, weight: FontWeight, italic: bool) -> FontId {
        self.fonts
            .iter()
            .find(|(font, _)| {
                (font.properties().style == font_kit::properties::Style::Italic) == italic
                    && weight == font.properties().weight
            })
            .or_else(|| self.fonts.first())
            .map(|(_, id)| *id)
            .unwrap_or_default()
    }

    fn render(
        &mut self,
        context: &WgpuContext,
        target: &TextureView,
        text: Text,
    ) -> anyhow::Result<CommandBuffer> {
        profiling::scope!("TextTextureState::render");
        self.staging_belt.recall();
        let mut encoder = context
            .device
            .create_command_encoder(&wgpu::CommandEncoderDescriptor {
                label: Some("Text Render Encoder"),
            });
        {
            let _ = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
                label: Some("Text Render Pass"),
                color_attachments: &[Some(wgpu::RenderPassColorAttachment {
                    view: target,
                    resolve_target: None,
                    ops: wgpu::Operations {
                        load: wgpu::LoadOp::Clear(wgpu::Color {
                            r: 0.0,
                            g: 0.0,
                            b: 0.0,
                            a: 1.0,
                        }),
                        store: true,
                    },
                })],
                depth_stencil_attachment: None,
            });
        }

        self.glyph_brush.queue(Section {
            screen_position: (0.0, 0.0),
            bounds: (1920.0, 1080.0),
            text: vec![text],
            ..Default::default()
        });
        if let Err(err) = self.glyph_brush.draw_queued(
            &context.device,
            &mut self.staging_belt,
            &mut encoder,
            target,
            1920,
            1080,
        ) {
            log::error!("Error drawing text: {err}");
        }

        self.staging_belt.finish();

        Ok(encoder.finish())
    }
}

fn load_fonts(font_family: &str) -> anyhow::Result<Vec<font_kit::font::Font>> {
    let family = SystemSource::new().select_family_by_name(font_family)?;
    let fonts = family
        .fonts()
        .iter()
        .flat_map(|handle| match handle.load() {
            Ok(font) => Some(font),
            Err(err) => {
                log::error!("Unable to load font: {err:?}");

                None
            }
        })
        .collect();

    Ok(fonts)
}

fn get_font_arcs(fonts: &[font_kit::font::Font]) -> Vec<FontArc> {
    fonts
        .iter()
        .flat_map(|font| {
            let font_data = font.copy_font_data()?;
            match FontArc::try_from_vec(font_data.to_vec()) {
                Ok(font) => Some(font),
                Err(err) => {
                    log::error!("Unable to load font: {err:?}");

                    None
                }
            }
        })
        .collect()
}
