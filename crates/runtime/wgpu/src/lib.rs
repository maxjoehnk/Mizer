pub use context::WgpuContext;
pub use module::WgpuModule;
pub use pipeline::WgpuPipeline;
use std::ops::Deref;
pub use texture::*;
pub use texture_source_stage::TextureSourceStage;
pub use vertex::Vertex;

mod context;
mod module;
mod pipeline;
mod processor;
mod texture;
mod texture_source_stage;
mod vertex;
pub mod window;

pub struct TextureView(wgpu::TextureView);

impl Deref for TextureView {
    type Target = wgpu::TextureView;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}
