use std::ops::Deref;

pub use wgpu;

pub use context::WgpuContext;
pub use module::WgpuModule;
pub use pipeline::{BufferHandle, WgpuPipeline};
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

pub const RECT_VERTICES: &[Vertex] = &[
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

pub const RECT_INDICES: &[u16] = &[0, 1, 2, 0, 2, 3];
