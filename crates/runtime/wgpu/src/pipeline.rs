use std::sync::{Arc, Weak};

use parking_lot::{Mutex, MutexGuard};
use weak_table::{WeakHashSet, WeakKeyHashMap};
use wgpu::Extent3d;

use crate::context::WgpuContext;
use crate::window::WindowSurface;

const U32_SIZE: u32 = std::mem::size_of::<u32>() as u32;

#[derive(Default)]
pub struct WgpuPipeline {
    command_buffers: Arc<Mutex<Vec<wgpu::CommandBuffer>>>,
    surfaces: Arc<Mutex<Vec<WindowSurface>>>,
    transfer_buffers: Arc<Mutex<WeakKeyHashMap<Weak<BufferHandle>, wgpu::Buffer>>>,
    mapped_buffers: Arc<Mutex<WeakHashSet<Weak<BufferHandle>>>>,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct BufferHandle(uuid::Uuid);

impl BufferHandle {
    fn new() -> Self {
        Self(uuid::Uuid::new_v4())
    }
}

impl WgpuPipeline {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn add_stage(&self, buffer: wgpu::CommandBuffer) {
        profiling::scope!("WgpuPipeline::add_stage");
        tracing::trace!("Adding stage to pipeline");
        self.command_buffers.lock().push(buffer);
    }

    pub fn add_surface(&self, surface: WindowSurface) {
        profiling::scope!("WgpuPipeline::add_surface");
        tracing::trace!("Adding surface to pipeline");
        self.surfaces.lock().push(surface);
    }

    pub fn render(&self, context: &WgpuContext) {
        profiling::scope!("WgpuPipeline::render");
        let mut buffers = self.command_buffers.lock();
        let commands = buffers.drain(..).collect::<Vec<_>>();
        tracing::trace!("Submitting {} command buffers", commands.len());
        context.queue.submit(commands);
        let mut surfaces = self.surfaces.lock();
        let surfaces = surfaces.drain(..).collect::<Vec<_>>();
        tracing::trace!("Presenting {} surfaces", surfaces.len());
        for surface in surfaces {
            surface.present();
        }
    }

    pub fn create_export_buffer(
        &self,
        context: &WgpuContext,
        width: u32,
        height: u32,
    ) -> Arc<BufferHandle> {
        let buffer = context.device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("NDI Output Buffer"),
            size: (U32_SIZE * width * height) as wgpu::BufferAddress,
            usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
            mapped_at_creation: false,
        });
        let buffer_handle = BufferHandle::new();
        let buffer_handle = Arc::new(buffer_handle);
        tracing::debug!("Created new buffer {buffer_handle:?}");
        let mut transfer_buffers = self.transfer_buffers.lock();
        transfer_buffers.insert(Arc::clone(&buffer_handle), buffer);

        buffer_handle
    }

    pub fn export_to_buffer(
        &self,
        wgpu_context: &WgpuContext,
        texture: &wgpu::Texture,
        buffer_handle: Arc<BufferHandle>,
    ) {
        tracing::trace!("Queuing texture export to buffer {buffer_handle:?}");
        let transfer_buffers = self.transfer_buffers.lock();
        if let Some(buffer) = transfer_buffers.get(&buffer_handle) {
            let mut encoder =
                wgpu_context
                    .device
                    .create_command_encoder(&wgpu::CommandEncoderDescriptor {
                        label: Some("NDI Output Encoder"),
                    });
            encoder.copy_texture_to_buffer(
                wgpu::ImageCopyTexture {
                    texture,
                    mip_level: 0,
                    origin: wgpu::Origin3d::ZERO,
                    aspect: wgpu::TextureAspect::All,
                },
                wgpu::ImageCopyBuffer {
                    buffer,
                    layout: wgpu::ImageDataLayout {
                        offset: 0,
                        bytes_per_row: Some(U32_SIZE * 1920),
                        rows_per_image: Some(1080),
                    },
                },
                Extent3d {
                    width: 1920,
                    height: 1080,
                    depth_or_array_layers: 1,
                },
            );

            self.add_stage(encoder.finish());
            tracing::trace!("Queuing buffer mapping {buffer_handle:?}");
            self.mapped_buffers.lock().insert(buffer_handle);
        } else {
            tracing::warn!("Unknown buffer handle");
        }
    }

    pub(crate) fn map_buffers(&self, wgpu_context: &WgpuContext) {
        let transfer_buffers = self.transfer_buffers.lock();
        let mapped_buffers = self.mapped_buffers.lock();
        for handle in mapped_buffers.iter() {
            if let Some(buffer) = transfer_buffers.get(&handle) {
                tracing::trace!("Mapping buffer {handle:?}");
                let buffer_slice = buffer.slice(..);
                buffer_slice.map_async(wgpu::MapMode::Read, move |result| {
                    if let Err(err) = result {
                        tracing::error!("Failed to map buffer: {err:?}");
                    }
                });
            }
        }
        wgpu_context.device.poll(wgpu::Maintain::Wait);
    }

    pub fn get_buffer(&self, buffer_handle: &Arc<BufferHandle>) -> BufferAccess {
        tracing::trace!("Reading buffer {buffer_handle:?}");

        BufferAccess {
            transfer_buffers: self.transfer_buffers.lock(),
            mapped_buffers: self.mapped_buffers.lock(),
            handle: Arc::clone(buffer_handle),
        }
    }

    pub(crate) fn cleanup(&self) {
        self.transfer_buffers.lock().remove_expired();
        self.unmap_buffers();
    }

    pub(crate) fn unmap_buffers(&self) {
        let transfer_buffers = self.transfer_buffers.lock();
        let mut mapped_buffers = self.mapped_buffers.lock();
        for handle in mapped_buffers.iter() {
            if let Some(buffer) = transfer_buffers.get(&handle) {
                tracing::trace!("Unmapping buffer {handle:?}");
                buffer.unmap();
            }
        }
        mapped_buffers.clear();
    }
}

pub struct BufferAccess<'a> {
    transfer_buffers: MutexGuard<'a, WeakKeyHashMap<Weak<BufferHandle>, wgpu::Buffer>>,
    mapped_buffers: MutexGuard<'a, WeakHashSet<Weak<BufferHandle>>>,
    handle: Arc<BufferHandle>,
}

impl BufferAccess<'_> {
    pub fn read_mut(&self) -> Option<wgpu::BufferViewMut> {
        if !self.mapped_buffers.contains(&self.handle) {
            return None;
        }
        let buffer = self.transfer_buffers.get(&self.handle)?;
        let buffer_slice = buffer.slice(..);
        let data = buffer_slice.get_mapped_range_mut();

        Some(data)
    }
}
