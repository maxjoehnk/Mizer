use wgpu::util::DeviceExt;

use mizer_wgpu::{wgpu, TextureView, WgpuContext, RECT_INDICES, RECT_VERTICES};

pub struct TextureMaskWgpuPipeline {
    sampler: wgpu::Sampler,
    source_texture_bind_group_layout: wgpu::BindGroupLayout,
    mask_texture_bind_group_layout: wgpu::BindGroupLayout,
    render_pipeline: wgpu::RenderPipeline,
    vertex_buffer: wgpu::Buffer,
    index_buffer: wgpu::Buffer,
}

impl TextureMaskWgpuPipeline {
    pub fn new(context: &WgpuContext) -> Self {
        let sampler = context.create_sampler();
        let source_texture_bind_group_layout = context
            .create_texture_bind_group_layout(Some("Texture Mask Source Texture Bind Group"));
        let mask_texture_bind_group_layout =
            context.create_texture_bind_group_layout(Some("Texture Mask Mask Texture Bind Group"));
        let shader = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shader.wgsl"));
        let render_pipeline = context.create_standard_pipeline(
            &[
                &source_texture_bind_group_layout,
                &mask_texture_bind_group_layout,
            ],
            &shader,
            Some("Texture Mask Pipeline"),
        );

        let vertex_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Texture Mask Vertex Buffer"),
                contents: bytemuck::cast_slice(RECT_VERTICES),
                usage: wgpu::BufferUsages::VERTEX,
            });

        let index_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Texture Mask Index Buffer"),
                contents: bytemuck::cast_slice(RECT_INDICES),
                usage: wgpu::BufferUsages::INDEX,
            });

        Self {
            sampler,
            source_texture_bind_group_layout,
            mask_texture_bind_group_layout,
            render_pipeline,
            vertex_buffer,
            index_buffer,
        }
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        target: &TextureView,
        source: &TextureView,
        mask: &TextureView,
    ) -> wgpu::CommandBuffer {
        let source_texture_bind_group = context.create_texture_bind_group(
            &self.source_texture_bind_group_layout,
            source,
            &self.sampler,
            "Texture Mask Source Texture Bind Group",
        );
        let mask_texture_bind_group = context.create_texture_bind_group(
            &self.mask_texture_bind_group_layout,
            mask,
            &self.sampler,
            "Texture Mask Mask Texture Bind Group",
        );
        let mut encoder = context
            .device
            .create_command_encoder(&wgpu::CommandEncoderDescriptor {
                label: Some("Texture Mask Pipeline Render Encoder"),
            });
        {
            let mut render_pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
                label: Some("Texture Mask Render Pass"),
                color_attachments: &[Some(wgpu::RenderPassColorAttachment {
                    view: target,
                    resolve_target: None,
                    ops: wgpu::Operations {
                        load: wgpu::LoadOp::Clear(wgpu::Color {
                            r: 0.0,
                            g: 0.0,
                            b: 0.0,
                            a: 0.0,
                        }),
                        store: true,
                    },
                })],
                depth_stencil_attachment: None,
            });
            render_pass.set_pipeline(&self.render_pipeline);
            render_pass.set_vertex_buffer(0, self.vertex_buffer.slice(..));
            render_pass.set_index_buffer(self.index_buffer.slice(..), wgpu::IndexFormat::Uint16);
            render_pass.set_bind_group(0, &source_texture_bind_group, &[]);
            render_pass.set_bind_group(1, &mask_texture_bind_group, &[]);
            render_pass.draw_indexed(0..(RECT_INDICES.len() as u32), 0, 0..1);
        }

        encoder.finish()
    }
}
