use egui::{Context, TextureHandle};
use egui_wgpu::winit::Painter;
use egui_wgpu::WgpuConfiguration;
use egui_winit::State;
use std::collections::HashMap;
use winit::event::{Event, WindowEvent};
use winit::event_loop::{EventLoop, EventLoopBuilder};
use winit::platform::run_return::EventLoopExtRunReturn;
#[cfg(target_os = "linux")]
use winit::platform::x11::EventLoopBuilderExtX11;
use winit::window::Window;

use crate::handle::DebugUiRenderHandle;

pub struct DebugUi {
    event_loop: EventLoop<()>,
    window: Window,
    egui_context: Context,
    egui_state: Option<State>,
    painter: Painter,
    textures: HashMap<u64, TextureHandle>,
}

impl DebugUi {
    #[cfg(target_os = "linux")]
    pub fn new() -> anyhow::Result<Self> {
        let event_loop = EventLoopBuilder::new().with_any_thread(true).build();
        let window = Window::new(&event_loop)?;
        window.set_title("Mizer Debug UI");
        let context = Context::default();

        let mut painter = Painter::new(WgpuConfiguration::default(), 1, 0, false);
        futures::executor::block_on(unsafe { painter.set_window(Some(&window)) })?;

        Ok(DebugUi {
            egui_context: context,
            egui_state: None,
            event_loop,
            window,
            painter,
            textures: Default::default(),
        })
    }

    #[cfg(not(target_os = "linux"))]
    pub fn new() -> anyhow::Result<Self> {
        anyhow::bail!("Debug UI is not available on non Linux platforms")
    }

    pub fn pre_render(&mut self) -> DebugUiRenderHandle {
        self.handle_events();
        if let Some(state) = self.egui_state.as_mut() {
            let input = state.take_egui_input(&self.window);

            self.egui_context.begin_frame(input);
        }

        DebugUiRenderHandle::new(&self.egui_context, &mut self.textures)
    }

    pub fn render(&mut self) {
        self.paint();
    }

    fn handle_events(&mut self) -> bool {
        let mut repaint = false;
        self.event_loop.run_return(|event, target, control_flow| {
            if self.egui_state.is_none() {
                self.egui_state = Some(State::new(target));
            }
            let state = self.egui_state.as_mut().unwrap();
            match event {
                Event::WindowEvent { event, .. } => {
                    let response = state.on_event(&self.egui_context, &event);
                    if response.repaint {
                        repaint = true;
                    }
                    match event {
                        WindowEvent::Resized(size) => {
                            self.painter.on_window_resized(size.width, size.height);
                            repaint = true;
                        }
                        WindowEvent::ScaleFactorChanged { new_inner_size, .. } => {
                            self.painter
                                .on_window_resized(new_inner_size.width, new_inner_size.height);
                            repaint = true;
                        }
                        _ => {}
                    }
                }
                Event::RedrawRequested(_) => repaint = true,
                _ => {}
            }

            control_flow.set_exit();
        });

        repaint
    }

    fn paint(&mut self) {
        if let Some(state) = self.egui_state.as_mut() {
            let output = self.egui_context.end_frame();
            state.handle_platform_output(&self.window, &self.egui_context, output.platform_output);

            let clipped_primitives = self.egui_context.tessellate(output.shapes);

            self.painter.paint_and_update_textures(
                self.egui_context.pixels_per_point(),
                [0., 0., 0., 1.],
                &clipped_primitives,
                &output.textures_delta,
            );
        }
    }
}
