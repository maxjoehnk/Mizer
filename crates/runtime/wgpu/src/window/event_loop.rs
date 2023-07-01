use dashmap::DashMap;
use std::sync::mpsc::Sender;

use winit::event_loop::{EventLoop, EventLoopBuilder};
use winit::platform::x11::EventLoopBuilderExtX11;
use winit::window::WindowId;

use crate::WgpuContext;

use super::{WindowEvent, WindowRef};

pub(crate) type WindowEvents = DashMap<WindowId, Sender<WindowEvent>>;

pub struct EventLoopHandle {
    pub(crate) event_loop: EventLoop<()>,
    pub(crate) window_events: WindowEvents,
}

impl EventLoopHandle {
    pub fn new() -> Self {
        let event_loop = EventLoopBuilder::new().with_any_thread(true).build();

        Self {
            event_loop,
            window_events: DashMap::new(),
        }
    }

    pub fn new_window(
        &self,
        context: &WgpuContext,
        title: Option<&str>,
    ) -> anyhow::Result<WindowRef> {
        let (tx, rx) = std::sync::mpsc::channel();
        let window = winit::window::WindowBuilder::new()
            .with_title(title.unwrap_or("Mizer"))
            .build(&self.event_loop)
            .unwrap();
        let surface = unsafe { context.instance.create_surface(&window) }?;
        let surface_caps = surface.get_capabilities(&context.adapter);
        let surface_format = surface_caps
            .formats
            .iter()
            .copied()
            .find(|f| f.is_srgb())
            .unwrap_or(surface_caps.formats[0]);
        let config = wgpu::SurfaceConfiguration {
            usage: wgpu::TextureUsages::RENDER_ATTACHMENT,
            format: surface_format,
            width: window.inner_size().width,
            height: window.inner_size().height,
            present_mode: surface_caps.present_modes[0],
            alpha_mode: surface_caps.alpha_modes[0],
            view_formats: vec![],
        };
        surface.configure(&context.device, &config);
        self.window_events.insert(window.id(), tx);

        Ok(WindowRef {
            window,
            surface,
            surface_config: config,
            events: rx,
        })
    }
}
