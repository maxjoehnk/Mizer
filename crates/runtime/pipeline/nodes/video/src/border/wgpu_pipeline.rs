use wgpu::util::DeviceExt;

use mizer_node::Color;
use mizer_wgpu::wgpu::StoreOp;
use mizer_wgpu::{wgpu, TextureView, WgpuContext, RECT_INDICES, RECT_VERTICES};

#[derive(Default, Debug, Clone, Copy, PartialEq, bytemuck::Pod, bytemuck::Zeroable)]
#[repr(C)]
struct BorderSettings {
    pub color: [f32; 4],
    pub widths: [f32; 4],
}

pub struct BorderWgpuPipeline {
    sampler: wgpu::Sampler,
    texture_bind_group_layout: wgpu::BindGroupLayout,
    render_pipeline: wgpu::RenderPipeline,
    vertex_buffer: wgpu::Buffer,
    index_buffer: wgpu::Buffer,
    uniform_bind_group: wgpu::BindGroup,
    uniform_buffer: wgpu::Buffer,
}

impl BorderWgpuPipeline {
    pub fn new(context: &WgpuContext) -> Self {
        let sampler = context.create_sampler();
        let texture_bind_group_layout =
            context.create_texture_bind_group_layout(Some("Border Texture Bind Group"));
        let uniform_bind_group_layout =
            context
                .device
                .create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
                    entries: &[wgpu::BindGroupLayoutEntry {
                        binding: 0,
                        visibility: wgpu::ShaderStages::FRAGMENT,
                        ty: wgpu::BindingType::Buffer {
                            ty: wgpu::BufferBindingType::Uniform,
                            has_dynamic_offset: false,
                            min_binding_size: None,
                        },
                        count: None,
                    }],
                    label: None,
                });
        let uniform_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Border Color Buffer"),
                contents: bytemuck::cast_slice(&[BorderSettings::default()]),
                usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
            });
        let uniform_bind_group = context
            .device
            .create_bind_group(&wgpu::BindGroupDescriptor {
                label: None,
                entries: &[wgpu::BindGroupEntry {
                    binding: 0,
                    resource: uniform_buffer.as_entire_binding(),
                }],
                layout: &uniform_bind_group_layout,
            });
        let shader = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shader.wgsl"));
        let render_pipeline = context.create_standard_pipeline(
            &[&texture_bind_group_layout, &uniform_bind_group_layout],
            &shader,
            Some("Border Pipeline"),
        );

        let vertex_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Border Vertex Buffer"),
                contents: bytemuck::cast_slice(RECT_VERTICES),
                usage: wgpu::BufferUsages::VERTEX,
            });

        let index_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Border Index Buffer"),
                contents: bytemuck::cast_slice(RECT_INDICES),
                usage: wgpu::BufferUsages::INDEX,
            });

        Self {
            sampler,
            texture_bind_group_layout,
            render_pipeline,
            vertex_buffer,
            index_buffer,
            uniform_buffer,
            uniform_bind_group,
        }
    }

    pub fn write_params(
        &self,
        context: &WgpuContext,
        color: Color,
        border_width: f64,
        (top, right, bottom, left): (bool, bool, bool, bool),
    ) {
        profiling::scope!("BorderWgpuPipeline::write_params");
        let vertical_width = border_width as f32 / 1080f32;
        let horizontal_width = border_width as f32 / 1920f32;
        let settings = BorderSettings {
            color: [
                color.red as f32,
                color.green as f32,
                color.blue as f32,
                color.alpha as f32,
            ],
            widths: [
                left.then_some(horizontal_width).unwrap_or_default(),
                top.then_some(vertical_width).unwrap_or_default(),
                1f32 - right.then_some(horizontal_width).unwrap_or_default(),
                1f32 - bottom.then_some(vertical_width).unwrap_or_default(),
            ],
        };
        context
            .queue
            .write_buffer(&self.uniform_buffer, 0, bytemuck::cast_slice(&[settings]));
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        target: &TextureView,
        source: &TextureView,
    ) -> wgpu::CommandBuffer {
        let texture_bind_group = context.create_texture_bind_group(
            &self.texture_bind_group_layout,
            source,
            &self.sampler,
            "Border Texture Bind Group",
        );
        let mut encoder = context
            .device
            .create_command_encoder(&wgpu::CommandEncoderDescriptor {
                label: Some("Border Pipeline Render Encoder"),
            });
        {
            let mut render_pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
                label: Some("Border Render Pass"),
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
            render_pass.set_pipeline(&self.render_pipeline);
            render_pass.set_vertex_buffer(0, self.vertex_buffer.slice(..));
            render_pass.set_index_buffer(self.index_buffer.slice(..), wgpu::IndexFormat::Uint16);
            render_pass.set_bind_group(0, &texture_bind_group, &[]);
            render_pass.set_bind_group(1, &self.uniform_bind_group, &[]);
            render_pass.draw_indexed(0..(RECT_INDICES.len() as u32), 0, 0..1);
        }

        encoder.finish()
    }
}
