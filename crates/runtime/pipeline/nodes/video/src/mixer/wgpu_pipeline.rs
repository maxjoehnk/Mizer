use mizer_wgpu::{TextureView, Vertex, WgpuContext, RECT_INDICES, RECT_VERTICES};
use std::num::NonZeroU32;
use wgpu::util::DeviceExt;
use wgpu::BufferUsages;

pub struct MixerWgpuPipeline {
    sampler: wgpu::Sampler,
    shader: wgpu::ShaderModule,
    texture_bind_group_layout: wgpu::BindGroupLayout,
    render_pipeline: wgpu::RenderPipeline,
    vertex_buffer: wgpu::Buffer,
    index_buffer: wgpu::Buffer,
    texture_count: usize,
    texture_count_bind_group_layout: wgpu::BindGroupLayout,
    texture_count_bind_group: wgpu::BindGroup,
    texture_count_buffer: wgpu::Buffer,
}

impl MixerWgpuPipeline {
    fn create_texture_layout(context: &WgpuContext, texture_count: usize) -> wgpu::BindGroupLayout {
        context
            .device
            .create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
                entries: &[
                    wgpu::BindGroupLayoutEntry {
                        binding: 0,
                        visibility: wgpu::ShaderStages::FRAGMENT,
                        ty: wgpu::BindingType::Texture {
                            multisampled: false,
                            view_dimension: wgpu::TextureViewDimension::D2,
                            sample_type: wgpu::TextureSampleType::Float { filterable: true },
                        },
                        count: Some(NonZeroU32::new(texture_count as u32).unwrap()),
                    },
                    wgpu::BindGroupLayoutEntry {
                        binding: 1,
                        visibility: wgpu::ShaderStages::FRAGMENT,
                        ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
                        count: None,
                    },
                ],
                label: None,
            })
    }

    fn create_render_pipeline(
        context: &WgpuContext,
        texture_bind_group_layout: &wgpu::BindGroupLayout,
        texture_count_bind_group_layout: &wgpu::BindGroupLayout,
        shader: &wgpu::ShaderModule,
    ) -> wgpu::RenderPipeline {
        let render_pipeline_layout =
            context
                .device
                .create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
                    label: Some("Mixer Pipeline Layout"),
                    bind_group_layouts: &[
                        texture_bind_group_layout,
                        texture_count_bind_group_layout,
                    ],
                    push_constant_ranges: &[],
                });

        let render_pipeline =
            context
                .device
                .create_render_pipeline(&wgpu::RenderPipelineDescriptor {
                    label: Some("Mixer Render Pipeline"),
                    layout: Some(&render_pipeline_layout),
                    vertex: wgpu::VertexState {
                        module: shader,
                        entry_point: "vs_main",
                        buffers: &[Vertex::desc()],
                    },
                    fragment: Some(wgpu::FragmentState {
                        module: shader,
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

        render_pipeline
    }

    pub fn new(context: &WgpuContext) -> Self {
        let sampler = context.create_sampler();
        let shader = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shader.wgsl"));
        let texture_bind_group_layout = Self::create_texture_layout(context, 1);
        let texture_count_bind_group_layout =
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
        let texture_count_buffer =
            context
                .device
                .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                    usage: BufferUsages::COPY_DST | BufferUsages::UNIFORM,
                    contents: &(1 as u32).to_ne_bytes(),
                    label: Some("Mixer Texture Count Buffer"),
                });
        let texture_count_bind_group =
            context
                .device
                .create_bind_group(&wgpu::BindGroupDescriptor {
                    label: Some("Mixer Texture Count Bind Group"),
                    layout: &texture_count_bind_group_layout,
                    entries: &[wgpu::BindGroupEntry {
                        binding: 0,
                        resource: texture_count_buffer.as_entire_binding(),
                    }],
                });

        let render_pipeline = Self::create_render_pipeline(
            context,
            &texture_bind_group_layout,
            &texture_count_bind_group_layout,
            &shader,
        );

        let vertex_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Mixer Vertex Buffer"),
                contents: bytemuck::cast_slice(RECT_VERTICES),
                usage: wgpu::BufferUsages::VERTEX,
            });

        let index_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Mixer Index Buffer"),
                contents: bytemuck::cast_slice(RECT_INDICES),
                usage: wgpu::BufferUsages::INDEX,
            });

        Self {
            sampler,
            shader,
            texture_bind_group_layout,
            render_pipeline,
            vertex_buffer,
            index_buffer,
            texture_count: 1,
            texture_count_buffer,
            texture_count_bind_group,
            texture_count_bind_group_layout,
        }
    }

    fn rebuild_pipeline(&mut self, context: &WgpuContext, texture_count: usize) {
        profiling::scope!("MixerWgpuPipeline::rebuild_pipeline");
        self.texture_bind_group_layout = Self::create_texture_layout(context, texture_count);
        self.render_pipeline = Self::create_render_pipeline(
            context,
            &self.texture_bind_group_layout,
            &self.texture_count_bind_group_layout,
            &self.shader,
        );
        self.texture_count = texture_count;
        context.queue.write_buffer(
            &self.texture_count_buffer,
            0,
            &(texture_count as u32).to_ne_bytes(),
        );
    }

    pub fn render(
        &mut self,
        context: &WgpuContext,
        sources: &[&wgpu::TextureView],
        target: &TextureView,
    ) -> wgpu::CommandBuffer {
        profiling::scope!("MixerWgpuPipeline::render");
        let texture_count = sources.len();
        if texture_count != self.texture_count {
            self.rebuild_pipeline(context, texture_count);
        }
        let texture_bind_group = context
            .device
            .create_bind_group(&wgpu::BindGroupDescriptor {
                layout: &self.texture_bind_group_layout,
                entries: &[
                    wgpu::BindGroupEntry {
                        binding: 0,
                        resource: wgpu::BindingResource::TextureViewArray(sources),
                    },
                    wgpu::BindGroupEntry {
                        binding: 1,
                        resource: wgpu::BindingResource::Sampler(&self.sampler),
                    },
                ],
                label: None,
            });
        let mut encoder = context
            .device
            .create_command_encoder(&wgpu::CommandEncoderDescriptor {
                label: Some("Mixer Render Encoder"),
            });
        {
            let mut render_pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
                label: Some("Mixer Render Pass"),
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
            render_pass.set_pipeline(&self.render_pipeline);
            render_pass.set_vertex_buffer(0, self.vertex_buffer.slice(..));
            render_pass.set_index_buffer(self.index_buffer.slice(..), wgpu::IndexFormat::Uint16);
            render_pass.set_bind_group(0, &texture_bind_group, &[]);
            render_pass.set_bind_group(1, &self.texture_count_bind_group, &[]);
            render_pass.draw_indexed(0..(RECT_INDICES.len() as u32), 0, 0..1);
        }

        encoder.finish()
    }
}
