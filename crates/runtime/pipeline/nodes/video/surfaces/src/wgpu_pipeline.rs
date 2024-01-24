use wgpu::util::DeviceExt;

use mizer_surfaces::{SurfaceTransform, SurfaceTransformPoint};
use mizer_wgpu::wgpu::StoreOp;
use mizer_wgpu::{wgpu, TextureView, Vertex, WgpuContext, RECT_INDICES, RECT_VERTICES};

pub struct SurfaceMappingWgpuPipeline {
    sampler: wgpu::Sampler,
    texture_bind_group_layout: wgpu::BindGroupLayout,
    render_pipeline: wgpu::RenderPipeline,
    vertex_buffer: wgpu::Buffer,
    index_buffer: wgpu::Buffer,
}

impl SurfaceMappingWgpuPipeline {
    pub fn new(context: &WgpuContext) -> Self {
        let sampler = context.create_sampler();
        let texture_bind_group_layout =
            context.create_texture_bind_group_layout(Some("Surface Mapping Texture Bind Group"));
        let shader = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shader.wgsl"));
        let render_pipeline = context.create_standard_pipeline(
            &[&texture_bind_group_layout],
            &shader,
            Some("Surface Mapping Pipeline"),
        );

        let vertex_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Surface Mapping Vertex Buffer"),
                contents: bytemuck::cast_slice(RECT_VERTICES),
                usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
            });

        let index_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Surface Mapping Index Buffer"),
                contents: bytemuck::cast_slice(RECT_INDICES),
                usage: wgpu::BufferUsages::INDEX,
            });

        Self {
            sampler,
            texture_bind_group_layout,
            render_pipeline,
            vertex_buffer,
            index_buffer,
        }
    }

    pub fn write_transform(
        &self,
        context: &WgpuContext,
        input: SurfaceTransform,
        output: SurfaceTransform,
    ) {
        profiling::scope!("Surface MappingWgpuPipeline::write_transform");
        let vertices = &[
            Vertex {
                position: transform_point_to_position(output.top_right),
                tex_coords: transform_point_to_tex_coord(input.top_right),
            },
            Vertex {
                position: transform_point_to_position(output.top_left),
                tex_coords: transform_point_to_tex_coord(input.top_left),
            },
            Vertex {
                position: transform_point_to_position(output.bottom_left),
                tex_coords: transform_point_to_tex_coord(input.bottom_left),
            },
            Vertex {
                position: transform_point_to_position(output.bottom_right),
                tex_coords: transform_point_to_tex_coord(input.bottom_right),
            },
        ];
        context
            .queue
            .write_buffer(&self.vertex_buffer, 0, bytemuck::cast_slice(vertices));
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        target: &TextureView,
        source: &TextureView,
    ) -> wgpu::CommandBuffer {
        profiling::scope!("Surface MappingWgpuPipeline::render");
        let texture_bind_group = context.create_texture_bind_group(
            &self.texture_bind_group_layout,
            source,
            &self.sampler,
            "Surface Mapping Texture Bind Group",
        );
        let mut encoder = context
            .device
            .create_command_encoder(&wgpu::CommandEncoderDescriptor {
                label: Some("Surface Mapping Render Encoder"),
            });
        {
            let mut render_pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
                label: Some("Surface Mapping Render Pass"),
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
            render_pass.draw_indexed(0..(RECT_INDICES.len() as u32), 0, 0..1);
        }

        encoder.finish()
    }
}

fn transform_point_to_tex_coord(point: SurfaceTransformPoint) -> [f32; 2] {
    [point.x as f32, point.y as f32]
}

fn transform_point_to_position(point: SurfaceTransformPoint) -> [f32; 3] {
    let x: f64 = point.x * 2. - 1.;
    let y: f64 = (point.y * 2. - 1.) * -1.;

    [x as f32, y as f32, 0.0]
}
