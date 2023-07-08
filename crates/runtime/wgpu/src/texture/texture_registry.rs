use crate::{TextureView, WgpuContext};
use dashmap::DashMap;

#[derive(Default, Debug, Clone, Copy, Hash, PartialEq, Eq)]
pub struct TextureHandle(uuid::Uuid);

impl TextureHandle {
    fn new() -> Self {
        Self(uuid::Uuid::new_v4())
    }
}

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
        profiling::scope!("TextureRegistry::register");
        let texture = context.create_texture(
            width,
            height,
            wgpu::TextureFormat::Bgra8UnormSrgb,
            wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING,
            label,
        );
        let handle = TextureHandle::new();
        self.textures.insert(handle, texture);

        handle
    }

    pub fn get(&self, handle: &TextureHandle) -> Option<TextureView> {
        profiling::scope!("TextureRegistry::get");
        let texture = self.textures.get(handle)?;
        let texture_view = texture.create_view(&wgpu::TextureViewDescriptor::default());
        let texture_view = TextureView(texture_view);

        Some(texture_view)
    }

    pub fn remove(&self, handle: TextureHandle) -> Option<()> {
        self.textures.remove(&handle).map(|_| ())
    }
}
