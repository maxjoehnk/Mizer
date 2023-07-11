use crate::{Texture, TextureProvider, TextureView, WgpuContext, RECT_INDICES, RECT_VERTICES};
use wgpu::util::DeviceExt;

pub struct TextureSourceStage {
    texture: Texture,
    pipeline: wgpu::RenderPipeline,
    vertex_buffer: wgpu::Buffer,
    index_buffer: wgpu::Buffer,
}

impl TextureSourceStage {
    pub fn new(
        context: &WgpuContext,
        texture_provider: &mut impl TextureProvider,
    ) -> anyhow::Result<Self> {
        let texture = Texture::new(context, texture_provider)?;
        let shader = context
            .device
            .create_shader_module(wgpu::include_wgsl!("texture_source_stage.wgsl"));

        let render_pipeline = context.create_standard_pipeline(
            &[&texture.bind_group_layout],
            &shader,
            Some("Texture Source Stage Render Pipeline"),
        );

        let vertex_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Texture Source Stage Vertex Buffer"),
                contents: bytemuck::cast_slice(RECT_VERTICES),
                usage: wgpu::BufferUsages::VERTEX,
            });

        let index_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Texture Source Stage Index Buffer"),
                contents: bytemuck::cast_slice(RECT_INDICES),
                usage: wgpu::BufferUsages::INDEX,
            });

        Ok(Self {
            texture,
            pipeline: render_pipeline,
            vertex_buffer,
            index_buffer,
        })
    }

    pub fn render(
        &mut self,
        context: &WgpuContext,
        target: &TextureView,
        texture_provider: &mut impl TextureProvider,
    ) -> anyhow::Result<wgpu::CommandBuffer> {
        profiling::scope!("TextureSourceStage::render");
        self.texture.render(context, texture_provider)?;
        let mut encoder = context
            .device
            .create_command_encoder(&wgpu::CommandEncoderDescriptor {
                label: Some("Texture Source Stage Render Encoder"),
            });
        {
            let mut render_pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
                label: Some("Texture Source Stage Render Pass"),
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
            render_pass.set_pipeline(&self.pipeline);
            render_pass.set_vertex_buffer(0, self.vertex_buffer.slice(..));
            render_pass.set_index_buffer(self.index_buffer.slice(..), wgpu::IndexFormat::Uint16);
            render_pass.set_bind_group(0, &self.texture.bind_group, &[]);
            render_pass.draw_indexed(0..(RECT_INDICES.len() as u32), 0, 0..1);
        }

        Ok(encoder.finish())
    }
}
