use std::sync::mpsc::Receiver;

use wgpu::SurfaceTexture;
use winit::window::Fullscreen;

pub use event_loop::*;
pub use module::*;

use crate::{TextureView, WgpuContext};

mod event_loop;
mod module;
mod processor;

pub struct WindowRef {
    window: winit::window::Window,
    surface: wgpu::Surface,
    surface_config: wgpu::SurfaceConfiguration,
    events: Receiver<WindowEvent>,
}

impl Drop for WindowRef {
    fn drop(&mut self) {
        log::debug!("Dropping window");
        self.window.set_visible(false);
    }
}

#[derive(Debug, Clone, Copy, Eq, PartialEq)]
pub enum WindowEvent {
    Resized { width: u32, height: u32 },
}

impl WindowRef {
    pub fn handle_events(&mut self, context: &WgpuContext) {
        while let Ok(event) = self.events.try_recv() {
            match event {
                WindowEvent::Resized { width, height } => {
                    self.resize(context, width, height);
                }
            }
        }
    }

    fn resize(&mut self, context: &WgpuContext, width: u32, height: u32) {
        self.surface_config.width = width;
        self.surface_config.height = height;
        self.surface
            .configure(&context.device, &self.surface_config);
    }

    pub fn surface(&self) -> anyhow::Result<WindowSurface> {
        Ok(WindowSurface {
            texture: self.surface.get_current_texture()?,
        })
    }

    pub fn set_title(&mut self, name: &str) {
        profiling::scope!("WindowRef::set_title");
        self.window.set_title(name);
    }

    pub fn set_fullscreen(&mut self, fullscreen: bool, screen: Option<Screen>) {
        profiling::scope!("WindowRef::set_fullscreen");
        if fullscreen {
            self.window
                .set_fullscreen(Some(Fullscreen::Borderless(screen.map(|s| s.handle))));
        } else {
            self.window.set_fullscreen(None);
        }
    }
}

pub struct WindowSurface {
    texture: SurfaceTexture,
}

impl WindowSurface {
    pub fn view(&self) -> TextureView {
        TextureView(
            self.texture
                .texture
                .create_view(&wgpu::TextureViewDescriptor::default()),
        )
    }

    pub fn present(self) {
        self.texture.present();
    }
}
