pub use static_texture::StaticTexture;
pub use texture_provider::TextureProvider;
pub use texture_registry::*;

use crate::context::WgpuContext;

mod static_texture;
mod texture_provider;
mod texture_registry;

pub struct Texture {
    pub texture: wgpu::Texture,
    pub view: wgpu::TextureView,
    pub sampler: wgpu::Sampler,
    pub bind_group: wgpu::BindGroup,
    pub bind_group_layout: wgpu::BindGroupLayout,
}

impl Texture {
    pub fn new(context: &WgpuContext, provider: &mut impl TextureProvider) -> anyhow::Result<Self> {
        let texture = context.create_texture(
            provider.width(),
            provider.height(),
            wgpu::TextureFormat::Rgba8UnormSrgb,
            wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
            None,
        );

        let view = texture.create_view(&wgpu::TextureViewDescriptor::default());
        let sampler = context.create_sampler();
        let bind_group_layout =
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
                            count: None,
                        },
                        wgpu::BindGroupLayoutEntry {
                            binding: 1,
                            visibility: wgpu::ShaderStages::FRAGMENT,
                            ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
                            count: None,
                        },
                    ],
                    label: None,
                });
        let bind_group = context
            .device
            .create_bind_group(&wgpu::BindGroupDescriptor {
                layout: &bind_group_layout,
                entries: &[
                    wgpu::BindGroupEntry {
                        binding: 0,
                        resource: wgpu::BindingResource::TextureView(&view),
                    },
                    wgpu::BindGroupEntry {
                        binding: 1,
                        resource: wgpu::BindingResource::Sampler(&sampler),
                    },
                ],
                label: None,
            });

        let texture = Self {
            texture,
            view,
            sampler,
            bind_group,
            bind_group_layout,
        };
        if let Err(err) = texture.render(context, provider) {
            log::error!("Failed initially render texture: {err:?}");
        }

        Ok(texture)
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        provider: &mut impl TextureProvider,
    ) -> anyhow::Result<()> {
        let width = provider.width();
        let height = provider.height();
        if let Some(data) = provider.data()? {
            context.write_texture(&self.texture, data.as_ref(), width, height);
        }

        Ok(())
    }
}