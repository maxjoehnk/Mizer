use egui::panel::Side;
use egui::{CentralPanel, ScrollArea, SidePanel};
use std::cell::RefCell;
use std::rc::Rc;

use mizer_debug_ui::DebugUiRenderHandle;

use crate::draw_handle::EguiDrawHandle;
use crate::{get_tracing_collector, EguiState, EguiTextureMap};

pub struct EguiRenderHandle<'a> {
    context: &'a egui::Context,
    textures: &'a mut EguiTextureMap,
    state: Rc<RefCell<EguiState>>,
}

impl<'a> DebugUiRenderHandle<'a> for EguiRenderHandle<'a> {
    type DrawHandle<'b> = EguiDrawHandle<'b>;
    type TextureMap = EguiTextureMap;

    fn draw(&mut self, call: impl FnOnce(&mut Self::DrawHandle<'_>, &mut Self::TextureMap)) {
        CentralPanel::default().show(self.context, |ui| {
            ScrollArea::vertical().show(ui, |ui| {
                let mut draw_handle = EguiDrawHandle::new(ui, Rc::clone(&self.state));
                call(&mut draw_handle, self.textures);
            });
        });
        SidePanel::new(Side::Right, "Logs").show(self.context, |ui| {
            ui.add(egui_tracing::Logs::new(get_tracing_collector()))
        });
    }
}

impl<'a> EguiRenderHandle<'a> {
    pub(crate) fn new(
        context: &'a egui::Context,
        textures: &'a mut EguiTextureMap,
        state: Rc<RefCell<EguiState>>,
    ) -> Self {
        Self {
            context,
            textures,
            state,
        }
    }
}
