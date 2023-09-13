use egui::{CentralPanel, ScrollArea};

use mizer_debug_ui::DebugUiRenderHandle;

use crate::draw_handle::EguiDrawHandle;
use crate::EguiTextureMap;

pub struct EguiRenderHandle<'a> {
    context: &'a egui::Context,
    textures: &'a mut EguiTextureMap,
}

impl<'a> DebugUiRenderHandle<'a> for EguiRenderHandle<'a> {
    type DrawHandle<'b> = EguiDrawHandle<'b>;
    type TextureMap = EguiTextureMap;

    fn draw(&mut self, call: impl FnOnce(&mut Self::DrawHandle<'_>, &mut Self::TextureMap)) {
        CentralPanel::default().show(self.context, |ui| {
            ScrollArea::vertical().show(ui, |ui| {
                let mut draw_handle = EguiDrawHandle::new(ui);
                call(&mut draw_handle, self.textures);
            });
        });
    }
}

impl<'a> EguiRenderHandle<'a> {
    pub(crate) fn new(context: &'a egui::Context, textures: &'a mut EguiTextureMap) -> Self {
        Self { context, textures }
    }
}
