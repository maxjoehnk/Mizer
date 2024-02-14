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
    texture_format: wgpu::TextureFormat,
}

const BIND_GROUP_LABEL: &str = "Texture Source Stage Bind Group";

impl Texture {
    pub fn new(context: &WgpuContext, provider: &mut impl TextureProvider) -> anyhow::Result<Self> {
        let texture = context.create_texture(
            provider.width(),
            provider.height(),
            provider.texture_format(),
            wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
            None,
        );

        let view = texture.create_view(&wgpu::TextureViewDescriptor::default());
        let sampler = context.create_sampler();
        let bind_group_layout = context.create_texture_bind_group_layout(Some("Texture"));
        let bind_group = context.create_texture_bind_group(
            &bind_group_layout,
            &view,
            &sampler,
            BIND_GROUP_LABEL,
        );

        let mut texture = Self {
            texture,
            view,
            sampler,
            bind_group,
            bind_group_layout,
            texture_format: provider.texture_format(),
        };
        if let Err(err) = texture.render(context, provider) {
            log::error!("Failed initially render texture: {err:?}");
        }

        Ok(texture)
    }

    pub fn render(
        &mut self,
        context: &WgpuContext,
        provider: &mut impl TextureProvider,
    ) -> anyhow::Result<()> {
        profiling::scope!("Texture::render");
        let width = provider.width();
        let height = provider.height();
        if self.texture.width() != width || self.texture.height() != height {
            log::debug!(
                "Texture size changed from {}x{} to {}x{}",
                self.texture.width(),
                self.texture.height(),
                width,
                height
            );
            self.recreate_texture(context, width, height);
        }
        if let Some(data) = provider.data()? {
            let expected_bytes = width as usize * height as usize * 4;
            if data.len() != expected_bytes {
                anyhow::bail!(
                    "Texture data size mismatch: expected {} bytes, got {} bytes",
                    expected_bytes,
                    data.len()
                );
            }
            context.write_texture(&self.texture, data.as_ref(), width, height);
        }

        Ok(())
    }

    fn recreate_texture(&mut self, context: &WgpuContext, width: u32, height: u32) {
        profiling::scope!("Texture::recreate_texture");
        self.texture.destroy();
        self.texture = context.create_texture(
            width,
            height,
            self.texture_format,
            wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
            None,
        );
        self.view = self
            .texture
            .create_view(&wgpu::TextureViewDescriptor::default());
        self.bind_group = context.create_texture_bind_group(
            &self.bind_group_layout,
            &self.view,
            &self.sampler,
            BIND_GROUP_LABEL,
        );
    }
}
