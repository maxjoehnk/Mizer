use crate::context::WgpuContext;
use crate::window::WindowSurface;
use std::sync::{Arc, Mutex};

#[derive(Default)]
pub struct WgpuPipeline {
    buffers: Arc<Mutex<Vec<wgpu::CommandBuffer>>>,
    surfaces: Arc<Mutex<Vec<WindowSurface>>>,
}

impl WgpuPipeline {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn add_stage(&self, buffer: wgpu::CommandBuffer) {
        profiling::scope!("WgpuPipeline::add_stage");
        log::trace!("Adding stage to pipeline");
        self.buffers.lock().unwrap().push(buffer);
    }

    pub fn add_surface(&self, surface: WindowSurface) {
        profiling::scope!("WgpuPipeline::add_surface");
        log::trace!("Adding surface to pipeline");
        self.surfaces.lock().unwrap().push(surface);
    }

    pub fn render(&self, context: &WgpuContext) {
        profiling::scope!("WgpuPipeline::render");
        let mut buffers = self.buffers.lock().unwrap();
        let commands = buffers.drain(..).collect::<Vec<_>>();
        log::trace!("Submitting {} command buffers", commands.len());
        context.queue.submit(commands);
        let mut surfaces = self.surfaces.lock().unwrap();
        let surfaces = surfaces.drain(..).collect::<Vec<_>>();
        log::trace!("Presenting {} surfaces", surfaces.len());
        for surface in surfaces {
            surface.present();
        }
    }
}
