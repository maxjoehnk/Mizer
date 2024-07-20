use glyphon::{cosmic_text, Attrs, Buffer, Family, FontSystem, Metrics, Resolution, Shaping, SwashCache, TextArea, TextAtlas, TextBounds, TextRenderer, Cache, Viewport};

use mizer_node::Color;
use mizer_wgpu::wgpu::{CommandBuffer, MultisampleState};
use mizer_wgpu::{wgpu, TextureHandle, TextureRegistry, TextureView, WgpuContext};

use crate::node::{FontWeight, TextAlign};

pub struct TextTextureState {
    pub transfer_texture: TextureHandle,
    font_system: FontSystem,
    swash_cache: SwashCache,
    viewport: Viewport,
    atlas: TextAtlas,
    text_renderer: TextRenderer,
    buffer: Buffer,
}

pub struct TextStyle<'a> {
    pub font_family: &'a str,
    pub font_size: f64,
    pub line_height: f64,
    pub font_weight: FontWeight,
    pub italic: bool,
    pub color: Color,
    pub align: TextAlign,
}

impl<'a> From<TextStyle<'a>> for Attrs<'a> {
    fn from(value: TextStyle<'a>) -> Self {
        let red = float_to_byte(value.color.red);
        let green = float_to_byte(value.color.green);
        let blue = float_to_byte(value.color.blue);
        let alpha = float_to_byte(value.color.alpha);
        let color = glyphon::Color::rgba(red, green, blue, alpha);

        Attrs::new()
            .color(color)
            .family(Family::Name(value.font_family))
            .weight(value.font_weight.into())
            .style(if value.italic {
                glyphon::Style::Italic
            } else {
                glyphon::Style::Normal
            })
    }
}

impl From<FontWeight> for glyphon::Weight {
    fn from(value: FontWeight) -> Self {
        match value {
            FontWeight::Thin => Self::THIN,
            FontWeight::ExtraLight => Self::EXTRA_LIGHT,
            FontWeight::Light => Self::LIGHT,
            FontWeight::Normal => Self::NORMAL,
            FontWeight::Medium => Self::MEDIUM,
            FontWeight::SemiBold => Self::SEMIBOLD,
            FontWeight::Bold => Self::BOLD,
            FontWeight::ExtraBold => Self::EXTRA_BOLD,
            FontWeight::Black => Self::BLACK,
        }
    }
}

impl From<TextAlign> for cosmic_text::Align {
    fn from(value: TextAlign) -> Self {
        match value {
            TextAlign::Start => Self::Left,
            TextAlign::Middle => Self::Center,
            TextAlign::End => Self::Right,
        }
    }
}

fn float_to_byte(source: f64) -> u8 {
    let result = source * u8::MAX as f64;

    result.clamp(u8::MIN as f64, u8::MAX as f64).round() as u8
}

impl TextTextureState {
    pub fn new(context: &WgpuContext, registry: &TextureRegistry) -> anyhow::Result<Self> {
        let transfer_texture = registry.register(context, 1920, 1080, None);
        let mut font_system = FontSystem::new();
        let swash_cache = SwashCache::new();
        let cache = Cache::new(&context.device);
        let mut atlas = TextAtlas::new(
            &context.device,
            &context.queue,
            &cache,
            wgpu::TextureFormat::Bgra8UnormSrgb,
        );
        let text_renderer = TextRenderer::new(
            &mut atlas,
            &context.device,
            MultisampleState::default(),
            None,
        );
        let mut buffer = Buffer::new(&mut font_system, Metrics::new(32.0, 32.0));
        buffer.set_size(&mut font_system, Some(1920f32), Some(1080f32));
        buffer.shape_until_scroll(&mut font_system, true);
        let mut viewport = Viewport::new(&context.device, &cache);

        viewport.update(
            &context.queue,
            Resolution {
                width: 1920,
                height: 1080,
            },
        );

        Ok(Self {
            transfer_texture,
            font_system,
            swash_cache,
            viewport,
            atlas,
            text_renderer,
            buffer,
        })
    }

    pub fn draw_text(
        &mut self,
        context: &WgpuContext,
        text: &str,
        text_style: TextStyle,
    ) -> anyhow::Result<()> {
        profiling::scope!("TextTextureState::draw_text");
        self.buffer.set_metrics(
            &mut self.font_system,
            Metrics::new(text_style.font_size as f32, text_style.line_height as f32),
        );
        let align = text_style.align.into();
        self.buffer.set_text(
            &mut self.font_system,
            text,
            text_style.into(),
            Shaping::Advanced,
        );
        for line in self.buffer.lines.iter_mut() {
            line.set_align(Some(align));
        }
        self.buffer.shape_until_scroll(&mut self.font_system, true);
        self.text_renderer.prepare(
            &context.device,
            &context.queue,
            &mut self.font_system,
            &mut self.atlas,
            &self.viewport,
            [TextArea {
                buffer: &self.buffer,
                left: 0.,
                top: 0.,
                scale: 1.0,
                bounds: TextBounds::default(),
                default_color: glyphon::Color::rgb(0, 0, 0),
            }],
            &mut self.swash_cache,
        )?;

        Ok(())
    }

    pub fn render(
        &mut self,
        context: &WgpuContext,
        target: &TextureView,
    ) -> anyhow::Result<CommandBuffer> {
        profiling::scope!("TextTextureState::render");
        let mut buffer = context.create_command_buffer("Text Render Pass");
        {
            let mut pass = buffer.start_render_pass(target);
            self.text_renderer.render(&self.atlas, &self.viewport, &mut pass)?;
        }

        Ok(buffer.finish())
    }

    pub fn cleanup(&mut self) {
        self.atlas.trim();
    }
}
