use std::ops::Deref;

use dashmap::mapref::one::Ref;
pub use wgpu;

pub use context::WgpuContext;
pub use module::WgpuModule;
pub use node_pipeline::{NodePipeline, NodePipelineBuilder};
pub use pipeline::{BufferHandle, WgpuPipeline};
pub use texture::*;
pub use texture_source_stage::TextureSourceStage;
pub use vertex::Vertex;

mod context;
mod module;
mod node_pipeline;
mod pipeline;
mod processor;
mod texture;
mod texture_source_stage;
mod vertex;
pub mod window;

pub enum TextureView<'a> {
    Borrowed(&'a wgpu::TextureView),
    MapRef(Ref<'a, TextureHandle, wgpu::TextureView>),
}

impl<'a> Deref for TextureView<'a> {
    type Target = wgpu::TextureView;

    fn deref(&self) -> &Self::Target {
        match self {
            TextureView::Borrowed(view) => view,
            TextureView::MapRef(view) => view,
        }
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
