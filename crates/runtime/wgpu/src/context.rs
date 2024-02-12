use std::ops::{Deref, DerefMut};

use wgpu::{CommandEncoder, StoreOp};

use crate::Vertex;

pub struct WgpuContext {
    pub(crate) instance: wgpu::Instance,
    pub(crate) adapter: wgpu::Adapter,
    pub device: wgpu::Device,
    pub queue: wgpu::Queue,
}

impl WgpuContext {
    pub async fn new() -> anyhow::Result<Self> {
        let instance = wgpu::Instance::new(wgpu::InstanceDescriptor {
            backends: wgpu::Backends::VULKAN,
            ..Default::default()
        });
        let adapter = instance
            .request_adapter(&wgpu::RequestAdapterOptions {
                force_fallback_adapter: false,
                compatible_surface: None,
                power_preference: wgpu::PowerPreference::HighPerformance,
            })
            .await
            .ok_or_else(|| anyhow::anyhow!("No compatible video adapter available"))?;
        let (device, queue) = adapter
            .request_device(
                &wgpu::DeviceDescriptor {
                    features: wgpu::Features::DEPTH_CLIP_CONTROL
                        | wgpu::Features::TEXTURE_BINDING_ARRAY
                        | wgpu::Features::SAMPLED_TEXTURE_AND_STORAGE_BUFFER_ARRAY_NON_UNIFORM_INDEXING,
                    ..Default::default()
                },
                None,
            )
            .await?;
        device.on_uncaptured_error(Box::new(|error| match error {
            wgpu::Error::OutOfMemory { source } => {
                tracing::error!(source, "wgpu out of memory");
            }
            wgpu::Error::Validation {
                description,
                source,
            } => {
                tracing::error!(source, "wgpu validation error: {}", description);
            }
        }));

        Ok(Self {
            instance,
            adapter,
            device,
            queue,
        })
    }

    pub fn create_texture(
        &self,
        width: u32,
        height: u32,
        format: wgpu::TextureFormat,
        usage: wgpu::TextureUsages,
        label: Option<&str>,
    ) -> wgpu::Texture {
        profiling::scope!("WgpuContext::create_texture");
        let size = wgpu::Extent3d {
            width,
            height,
            depth_or_array_layers: 1,
        };

        let texture = self.device.create_texture(&wgpu::TextureDescriptor {
            label,
            size,
            mip_level_count: 1,
            sample_count: 1,
            dimension: wgpu::TextureDimension::D2,
            format,
            usage,
            view_formats: &[format],
        });

        texture
    }

    pub fn create_sampler(&self) -> wgpu::Sampler {
        profiling::scope!("WgpuContext::create_sampler");
        self.device.create_sampler(&wgpu::SamplerDescriptor {
            address_mode_u: wgpu::AddressMode::ClampToEdge,
            address_mode_v: wgpu::AddressMode::ClampToEdge,
            address_mode_w: wgpu::AddressMode::ClampToEdge,
            mag_filter: wgpu::FilterMode::Linear,
            min_filter: wgpu::FilterMode::Nearest,
            mipmap_filter: wgpu::FilterMode::Nearest,
            ..Default::default()
        })
    }

    pub fn write_texture(&self, texture: &wgpu::Texture, data: &[u8], width: u32, height: u32) {
        profiling::scope!("WgpuContext::write_texture");
        let size = wgpu::Extent3d {
            width,
            height,
            depth_or_array_layers: 1,
        };

        self.queue.write_texture(
            wgpu::ImageCopyTexture {
                texture,
                mip_level: 0,
                origin: wgpu::Origin3d::ZERO,
                aspect: wgpu::TextureAspect::All,
            },
            data,
            wgpu::ImageDataLayout {
                offset: 0,
                bytes_per_row: Some(4 * size.width),
                rows_per_image: Some(size.height),
            },
            size,
        );
    }

    pub fn create_texture_bind_group_layout(&self, label: Option<&str>) -> wgpu::BindGroupLayout {
        profiling::scope!("WgpuContext::create_texture_bind_group_layout");
        self.device
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
                        count: None,
                    },
                    wgpu::BindGroupLayoutEntry {
                        binding: 1,
                        visibility: wgpu::ShaderStages::FRAGMENT,
                        ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
                        count: None,
                    },
                ],
                label,
            })
    }

    pub fn create_texture_bind_group(
        &self,
        bind_group_layout: &wgpu::BindGroupLayout,
        source: &wgpu::TextureView,
        sampler: &wgpu::Sampler,
        label: &str,
    ) -> wgpu::BindGroup {
        self.device.create_bind_group(&wgpu::BindGroupDescriptor {
            layout: bind_group_layout,
            entries: &[
                wgpu::BindGroupEntry {
                    binding: 0,
                    resource: wgpu::BindingResource::TextureView(source),
                },
                wgpu::BindGroupEntry {
                    binding: 1,
                    resource: wgpu::BindingResource::Sampler(sampler),
                },
            ],
            label: Some(label),
        })
    }

    pub fn create_standard_pipeline(
        &self,
        bind_group_layouts: &[&wgpu::BindGroupLayout],
        shader: &wgpu::ShaderModule,
        label: Option<&str>,
    ) -> wgpu::RenderPipeline {
        let pipeline_layout = self
            .device
            .create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
                label,
                bind_group_layouts,
                push_constant_ranges: &[],
            });
        self.device
            .create_render_pipeline(&wgpu::RenderPipelineDescriptor {
                label,
                layout: Some(&pipeline_layout),
                vertex: wgpu::VertexState {
                    module: shader,
                    entry_point: "vs_main",
                    buffers: &[Vertex::desc()],
                },
                fragment: Some(wgpu::FragmentState {
                    module: shader,
                    entry_point: "fs_main",
                    targets: &[Some(wgpu::ColorTargetState {
                        format: crate::TEXTURE_FORMAT,
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
            })
    }

    pub fn create_command_buffer<'label>(&self, label: &'label str) -> CommandBuffer<'label> {
        profiling::scope!("WgpuContext::start_render_pass");
        let encoder = self
            .device
            .create_command_encoder(&wgpu::CommandEncoderDescriptor { label: Some(label) });

        CommandBuffer { encoder, label }
    }
}

pub struct CommandBuffer<'label> {
    encoder: CommandEncoder,
    label: &'label str,
}

impl<'label> CommandBuffer<'label> {
    pub fn start_render_pass<'pass>(
        &'pass mut self,
        target: &'pass wgpu::TextureView,
    ) -> WgpuRenderPass<'pass> {
        self.create_clear_pass(target, 0.0, 0.0, 0.0, 0.0)
    }

    pub fn create_clear_pass<'pass>(
        &'pass mut self,
        target: &'pass wgpu::TextureView,
        red: f64,
        green: f64,
        blue: f64,
        alpha: f64,
    ) -> WgpuRenderPass<'pass> {
        profiling::scope!("CommandBuffer::start_render_pass");
        let pass = self.encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
            label: Some(self.label),
            color_attachments: &[Some(wgpu::RenderPassColorAttachment {
                view: target,
                resolve_target: None,
                ops: wgpu::Operations {
                    load: wgpu::LoadOp::Clear(wgpu::Color {
                        r: red,
                        g: green,
                        b: blue,
                        a: alpha,
                    }),
                    store: StoreOp::Store,
                },
            })],
            depth_stencil_attachment: None,
            occlusion_query_set: None,
            timestamp_writes: None,
        });

        WgpuRenderPass::new(pass)
    }

    pub fn finish(self) -> wgpu::CommandBuffer {
        self.encoder.finish()
    }
}

pub struct WgpuRenderPass<'pass> {
    render_pass: wgpu::RenderPass<'pass>,
}

impl<'pass> WgpuRenderPass<'pass> {
    fn new(render_pass: wgpu::RenderPass<'pass>) -> Self {
        Self { render_pass }
    }
}

impl<'pass> Deref for WgpuRenderPass<'pass> {
    type Target = wgpu::RenderPass<'pass>;

    fn deref(&self) -> &Self::Target {
        &self.render_pass
    }
}

impl<'pass> DerefMut for WgpuRenderPass<'pass> {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.render_pass
    }
}
