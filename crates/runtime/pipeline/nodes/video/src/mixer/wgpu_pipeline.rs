use std::num::NonZeroU32;

use wgpu::util::DeviceExt;
use wgpu::BufferUsages;

use mizer_wgpu::{wgpu, TextureView, WgpuContext, RECT_INDICES, RECT_VERTICES};

use crate::mixer::node::VideoMixerMode;

pub struct Shaders {
    add: wgpu::ShaderModule,
    darken: wgpu::ShaderModule,
    difference: wgpu::ShaderModule,
    hard_light: wgpu::ShaderModule,
    lighten: wgpu::ShaderModule,
    multiply: wgpu::ShaderModule,
    normal: wgpu::ShaderModule,
    overlay: wgpu::ShaderModule,
    screen: wgpu::ShaderModule,
    soft_light: wgpu::ShaderModule,
    subtract: wgpu::ShaderModule,
}

impl Shaders {
    fn new(context: &WgpuContext) -> Self {
        let add = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shaders/add.wgsl"));
        let darken = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shaders/darken.wgsl"));
        let difference = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shaders/difference.wgsl"));
        let hard_light = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shaders/hard_light.wgsl"));
        let lighten = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shaders/lighten.wgsl"));
        let normal = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shaders/normal.wgsl"));
        let multiply = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shaders/multiply.wgsl"));
        let overlay = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shaders/overlay.wgsl"));
        let screen = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shaders/screen.wgsl"));
        let soft_light = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shaders/soft_light.wgsl"));
        let subtract = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shaders/subtract.wgsl"));

        Self {
            add,
            darken,
            difference,
            hard_light,
            lighten,
            multiply,
            normal,
            overlay,
            screen,
            soft_light,
            subtract,
        }
    }

    fn get_shader(&self, mode: VideoMixerMode) -> &wgpu::ShaderModule {
        match mode {
            VideoMixerMode::Add => &self.add,
            VideoMixerMode::Darken => &self.darken,
            VideoMixerMode::Difference => &self.difference,
            VideoMixerMode::HardLight => &self.hard_light,
            VideoMixerMode::Lighten => &self.lighten,
            VideoMixerMode::Multiply => &self.multiply,
            VideoMixerMode::Normal => &self.normal,
            VideoMixerMode::Overlay => &self.overlay,
            VideoMixerMode::Screen => &self.screen,
            VideoMixerMode::SoftLight => &self.soft_light,
            VideoMixerMode::Subtract => &self.subtract,
        }
    }
}

pub struct MixerWgpuPipeline {
    sampler: wgpu::Sampler,
    shaders: Shaders,
    texture_bind_group_layout: wgpu::BindGroupLayout,
    render_pipeline: wgpu::RenderPipeline,
    vertex_buffer: wgpu::Buffer,
    index_buffer: wgpu::Buffer,
    texture_count: usize,
    texture_count_bind_group_layout: wgpu::BindGroupLayout,
    texture_count_bind_group: wgpu::BindGroup,
    texture_count_buffer: wgpu::Buffer,
    mode: VideoMixerMode,
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
        bind_group_layouts: &[&wgpu::BindGroupLayout],
        shader: &wgpu::ShaderModule,
    ) -> wgpu::RenderPipeline {
        context.create_standard_pipeline(bind_group_layouts, shader, Some("Mixer Pipeline"))
    }

    pub fn new(context: &WgpuContext) -> Self {
        let sampler = context.create_sampler();
        let shaders = Shaders::new(context);
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

        let mixer_mode = VideoMixerMode::Normal;
        let render_pipeline = Self::create_render_pipeline(
            context,
            &[&texture_bind_group_layout, &texture_count_bind_group_layout],
            shaders.get_shader(mixer_mode),
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
            shaders,
            texture_bind_group_layout,
            render_pipeline,
            vertex_buffer,
            index_buffer,
            texture_count: 1,
            texture_count_buffer,
            texture_count_bind_group,
            texture_count_bind_group_layout,
            mode: mixer_mode,
        }
    }

    fn rebuild_pipeline(
        &mut self,
        context: &WgpuContext,
        texture_count: usize,
        mode: VideoMixerMode,
    ) {
        profiling::scope!("MixerWgpuPipeline::rebuild_pipeline");
        self.texture_bind_group_layout = Self::create_texture_layout(context, texture_count);
        self.render_pipeline = Self::create_render_pipeline(
            context,
            &[
                &self.texture_bind_group_layout,
                &self.texture_count_bind_group_layout,
            ],
            &self.shaders.get_shader(mode),
        );
        self.texture_count = texture_count;
        self.mode = mode;
        context.queue.write_buffer(
            &self.texture_count_buffer,
            0,
            &(texture_count as i32).to_ne_bytes(),
        );
    }

    pub fn render(
        &mut self,
        context: &WgpuContext,
        sources: &[&wgpu::TextureView],
        target: &TextureView,
        mode: VideoMixerMode,
    ) -> wgpu::CommandBuffer {
        profiling::scope!("MixerWgpuPipeline::render");
        let texture_count = sources.len();
        if texture_count != self.texture_count || mode != self.mode {
            log::debug!(
                "Rebuilding Mixer Wgpu Pipeline because texture_count: {} mode: {}",
                texture_count != self.texture_count,
                mode != self.mode
            );
            self.rebuild_pipeline(context, texture_count, mode);
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
