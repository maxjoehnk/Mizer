use std::ops::Deref;

use dashmap::DashMap;

use crate::{TextureView, WgpuContext};

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
    texture_views: DashMap<TextureHandle, wgpu::TextureView>,
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
        self.register_with(
            context,
            width,
            height,
            crate::TEXTURE_FORMAT,
            wgpu::TextureUsages::RENDER_ATTACHMENT
                | wgpu::TextureUsages::TEXTURE_BINDING
                | wgpu::TextureUsages::COPY_SRC,
            label,
        )
    }

    pub fn register_with(
        &self,
        context: &WgpuContext,
        width: u32,
        height: u32,
        format: wgpu::TextureFormat,
        usages: wgpu::TextureUsages,
        label: Option<&str>,
    ) -> TextureHandle {
        profiling::scope!("TextureRegistry::register_with_usages");
        let texture = context.create_texture(width, height, format, usages, label);
        let view = texture.create_view(&wgpu::TextureViewDescriptor::default());
        let handle = TextureHandle::new();
        self.textures.insert(handle, texture);
        self.texture_views.insert(handle, view);

        handle
    }

    pub fn get(&self, handle: &TextureHandle) -> Option<TextureView> {
        profiling::scope!("TextureRegistry::get");
        let texture_view = self.texture_views.get(handle)?;

        Some(TextureView::MapRef(texture_view))
    }

    pub fn remove(&self, handle: TextureHandle) -> Option<()> {
        self.textures.remove(&handle).map(|_| ())?;
        self.texture_views.remove(&handle).map(|_| ())?;

        Some(())
    }

    pub fn get_texture_ref<'a>(
        &'a self,
        handle: &'a TextureHandle,
    ) -> Option<impl Deref<Target = wgpu::Texture> + 'a> {
        let texture = self.textures.get(handle)?;

        Some(texture)
    }
}
