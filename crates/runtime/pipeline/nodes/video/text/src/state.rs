use glyphon::{
    Attrs, Buffer, Family, FontSystem, Metrics, Resolution, Shaping, SwashCache, TextArea,
    TextAtlas, TextBounds, TextRenderer,
};

use mizer_node::Color;
use mizer_wgpu::wgpu::{CommandBuffer, MultisampleState, StoreOp};
use mizer_wgpu::{wgpu, TextureHandle, TextureRegistry, TextureView, WgpuContext};

use crate::node::FontWeight;

pub struct TextTextureState {
    pub transfer_texture: TextureHandle,
    font_system: FontSystem,
    cache: SwashCache,
    atlas: TextAtlas,
    text_renderer: TextRenderer,
    buffer: Buffer,
}

pub struct TextStyle<'a> {
    pub font_family: &'a str,
    pub font_size: f64,
    pub font_weight: FontWeight,
    pub italic: bool,
    pub color: Color,
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

fn float_to_byte(source: f64) -> u8 {
    let result = source * u8::MAX as f64;

    result.clamp(u8::MIN as f64, u8::MAX as f64).round() as u8
}

impl TextTextureState {
    pub fn new(context: &WgpuContext, registry: &TextureRegistry) -> anyhow::Result<Self> {
        let transfer_texture = registry.register(context, 1920, 1080, None);
        let mut font_system = FontSystem::new();
        let cache = SwashCache::new();
        let mut atlas = TextAtlas::new(
            &context.device,
            &context.queue,
            wgpu::TextureFormat::Bgra8UnormSrgb,
        );
        let text_renderer = TextRenderer::new(
            &mut atlas,
            &context.device,
            MultisampleState::default(),
            None,
        );
        let mut buffer = Buffer::new(&mut font_system, Metrics::new(32.0, 32.0));
        buffer.set_size(&mut font_system, 1920f32, 1080f32);
        buffer.shape_until_scroll(&mut font_system);

        Ok(Self {
            transfer_texture,
            font_system,
            cache,
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
            Metrics::new(text_style.font_size as f32, text_style.font_size as f32),
        );
        self.buffer.set_text(
            &mut self.font_system,
            text,
            text_style.into(),
            Shaping::Advanced,
        );
        self.text_renderer.prepare(
            &context.device,
            &context.queue,
            &mut self.font_system,
            &mut self.atlas,
            Resolution {
                width: 1920,
                height: 1080,
            },
            [TextArea {
                buffer: &self.buffer,
                left: 0.,
                top: 0.,
                scale: 1.0,
                bounds: TextBounds::default(),
                default_color: glyphon::Color::rgb(0, 0, 0),
            }],
            &mut self.cache,
        )?;

        Ok(())
    }

    pub fn render(
        &mut self,
        context: &WgpuContext,
        target: &TextureView,
    ) -> anyhow::Result<CommandBuffer> {
        profiling::scope!("TextTextureState::render");
        let mut encoder = context
            .device
            .create_command_encoder(&wgpu::CommandEncoderDescriptor {
                label: Some("Text Render Encoder"),
            });
        {
            let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
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
                        store: StoreOp::Store,
                    },
                })],
                depth_stencil_attachment: None,
                timestamp_writes: None,
                occlusion_query_set: None,
            });

            self.text_renderer.render(&self.atlas, &mut pass)?;
        }

        Ok(encoder.finish())
    }

    pub fn cleanup(&mut self) {
        self.atlas.trim();
    }
}
