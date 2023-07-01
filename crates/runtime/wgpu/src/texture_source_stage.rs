use crate::{Texture, TextureProvider, TextureView, Vertex, WgpuContext};
use wgpu::util::DeviceExt;

const VERTICES: &[Vertex] = &[
    Vertex {
        position: [1., 1., 0.0],
        tex_coords: [1., 0.],
    },
    Vertex {
        position: [-1., 1., 0.0],
        tex_coords: [0., 0.],
    },
    Vertex {
        position: [-1., -1., 0.0],
        tex_coords: [0., 1.],
    },
    Vertex {
        position: [1., -1., 0.0],
        tex_coords: [1., 1.],
    },
];

const INDICES: &[u16] = &[0, 1, 2, 0, 2, 3];

pub struct TextureSourceStage {
    texture: Texture,
    pipeline_layout: wgpu::PipelineLayout,
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

        let render_pipeline_layout =
            context
                .device
                .create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
                    label: Some("Texture Source Pipeline Layout"),
                    bind_group_layouts: &[&texture.bind_group_layout],
                    push_constant_ranges: &[],
                });

        let render_pipeline =
            context
                .device
                .create_render_pipeline(&wgpu::RenderPipelineDescriptor {
                    label: Some("Texture Source Stage Render Pipeline"),
                    layout: Some(&render_pipeline_layout),
                    vertex: wgpu::VertexState {
                        module: &shader,
                        entry_point: "vs_main",
                        buffers: &[Vertex::desc()],
                    },
                    fragment: Some(wgpu::FragmentState {
                        module: &shader,
                        entry_point: "fs_main",
                        targets: &[Some(wgpu::ColorTargetState {
                            format: wgpu::TextureFormat::Bgra8UnormSrgb,
                            blend: Some(wgpu::BlendState::REPLACE),
                            write_mask: wgpu::ColorWrites::ALL,
                        })],
                    }),
                    primitive: wgpu::PrimitiveState {
                        topology: wgpu::PrimitiveTopology::TriangleList,
                        strip_index_format: None,
                        front_face: wgpu::FrontFace::Ccw,
                        cull_mode: Some(wgpu::Face::Back),
                        polygon_mode: wgpu::PolygonMode::Fill,
                        conservative: false,
                        unclipped_depth: true,
                    },
                    depth_stencil: None,
                    multisample: wgpu::MultisampleState {
                        count: 1,
                        mask: !0,
                        alpha_to_coverage_enabled: false,
                    },
                    multiview: None,
                });

        let vertex_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Texture Source Stage Vertex Buffer"),
                contents: bytemuck::cast_slice(VERTICES),
                usage: wgpu::BufferUsages::VERTEX,
            });

        let index_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Texture Source Stage Index Buffer"),
                contents: bytemuck::cast_slice(INDICES),
                usage: wgpu::BufferUsages::INDEX,
            });

        Ok(Self {
            texture,
            pipeline_layout: render_pipeline_layout,
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
            render_pass.draw_indexed(0..(INDICES.len() as u32), 0, 0..1);
        }

        Ok(encoder.finish())
    }
}
