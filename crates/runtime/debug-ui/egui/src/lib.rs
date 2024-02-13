use std::collections::HashMap;
use std::num::NonZeroU32;

use egui::{Context, TextureHandle, ViewportId};
use egui_wgpu::winit::Painter;
use egui_wgpu::WgpuConfiguration;
use egui_winit::State;
use winit::event::WindowEvent;

use mizer_debug_ui::*;
use mizer_wgpu::window::{EventLoopHandle, RawWindowRef};

use crate::draw_handle::EguiDrawHandle;
pub use crate::module::EguiDebugUiModule;
use crate::render_handle::EguiRenderHandle;

mod draw_handle;
mod module;
mod render_handle;

#[derive(Default)]
#[repr(transparent)]
pub struct EguiTextureMap(pub(crate) HashMap<u64, TextureHandle>);

pub struct EguiDebugUi {
    viewport_id: ViewportId,
    window: RawWindowRef,
    egui_context: Context,
    egui_state: Option<State>,
    painter: Painter,
    textures: EguiTextureMap,
}

impl DebugUi for EguiDebugUi {
    type RenderHandle<'a, 'b> = EguiRenderHandle<'a>;
    type DrawHandle<'a> = EguiDrawHandle<'a>;
    type TextureMap = EguiTextureMap;

    fn pre_render(&mut self) -> Self::RenderHandle<'_, '_> {
        self.handle_events();
        if let Some(state) = self.egui_state.as_mut() {
            let input = state.take_egui_input(&self.window);

            self.egui_context.begin_frame(input);
        }

        EguiRenderHandle::new(&self.egui_context, &mut self.textures)
    }

    fn render(&mut self) {
        self.paint();
    }
}

impl EguiDebugUi {
    #[cfg(target_os = "linux")]
    pub fn new(event_loop: &EventLoopHandle) -> anyhow::Result<Self> {
        let window = event_loop.new_raw_window(Some("Mizer Debug UI"))?;
        let context = Context::default();
        let viewport_id = ViewportId::default();

        let mut painter = Painter::new(WgpuConfiguration::default(), 1, None, false);
        futures::executor::block_on(painter.set_window(viewport_id, Some(&window)))?;

        Ok(EguiDebugUi {
            viewport_id,
            egui_context: context,
            egui_state: None,
            window,
            painter,
            textures: Default::default(),
        })
    }

    #[cfg(not(target_os = "linux"))]
    pub fn new(_event_loop: &EventLoopHandle) -> anyhow::Result<Self> {
        anyhow::bail!("Debug UI is not available on non Linux platforms")
    }

    fn handle_events(&mut self) -> bool {
        let mut repaint = false;
        let events = self.window.get_events();
        for event in events {
            if self.egui_state.is_none() {
                self.egui_state = Some(State::new(
                    self.egui_context.clone(),
                    self.viewport_id,
                    &self.window,
                    None,
                    None,
                ));
            }
            let state = self.egui_state.as_mut().unwrap();
            let response = state.on_window_event(&self.window, &event);
            if response.repaint {
                repaint = true;
            }
            if let WindowEvent::Resized(size) = event {
                self.painter.on_window_resized(
                    self.viewport_id,
                    NonZeroU32::new(size.width).unwrap(),
                    NonZeroU32::new(size.height).unwrap(),
                );
                repaint = true;
            }
        }

        repaint
    }

    fn paint(&mut self) {
        if let Some(state) = self.egui_state.as_mut() {
            let output = self.egui_context.end_frame();
            state.handle_platform_output(&self.window, output.platform_output);

            let clipped_primitives = self
                .egui_context
                .tessellate(output.shapes, self.egui_context.pixels_per_point());

            self.painter.paint_and_update_textures(
                self.viewport_id,
                self.egui_context.pixels_per_point(),
                [0., 0., 0., 1.],
                &clipped_primitives,
                &output.textures_delta,
                false,
            );
        }
    }
}
