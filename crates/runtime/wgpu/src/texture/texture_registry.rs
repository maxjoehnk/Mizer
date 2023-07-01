use crate::{TextureView, WgpuContext};
use dashmap::DashMap;

#[derive(Debug, Clone, Copy, Hash, PartialEq, Eq)]
pub struct TextureHandle(uuid::Uuid);

#[derive(Default)]
pub struct TextureRegistry {
    textures: DashMap<TextureHandle, wgpu::Texture>,
}

impl TextureRegistry {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn register(
        &self,
        context: &WgpuContext,
        width: u32,
        height: u32,
        label: Option<&str>,
    ) -> TextureHandle {
        let texture = context.create_texture(
            width,
            height,
            wgpu::TextureFormat::Bgra8UnormSrgb,
            wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING,
            label,
        );
        let handle = TextureHandle(uuid::Uuid::new_v4());
        self.textures.insert(handle, texture);

        handle
    }

    pub fn get(&self, handle: &TextureHandle) -> Option<TextureView> {
        let texture = self.textures.get(&handle)?;
        let texture_view = texture.create_view(&wgpu::TextureViewDescriptor::default());
        let texture_view = TextureView(texture_view);

        Some(texture_view)
    }

    pub fn remove(&self, handle: TextureHandle) -> Option<()> {
        self.textures.remove(&handle).map(|_| ())
    }
}
