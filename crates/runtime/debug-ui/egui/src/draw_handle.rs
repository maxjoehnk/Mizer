use egui::{CollapsingHeader, ColorImage, Ui};

use mizer_debug_ui::{DebugUiDrawHandle, DebugUiResponse};

use crate::EguiTextureMap;

pub struct EguiDrawHandle<'a> {
    ui: &'a mut Ui,
}

impl<'a> EguiDrawHandle<'a> {
    pub(crate) fn new(ui: &'a mut Ui) -> Self {
        Self { ui }
    }
}

pub struct EguiResponse(egui::Response);

impl From<egui::Response> for EguiResponse {
    fn from(response: egui::Response) -> Self {
        Self(response)
    }
}

impl DebugUiResponse for EguiResponse {
    #[inline]
    fn clicked(&self) -> bool {
        self.0.clicked()
    }
}

impl<'a> DebugUiDrawHandle<'a> for EguiDrawHandle<'a> {
    type Response = EguiResponse;
    type DrawHandle<'b> = EguiDrawHandle<'b>;
    type TextureMap = EguiTextureMap;

    fn horizontal(&mut self, cb: impl FnOnce(&mut Self::DrawHandle<'_>)) {
        self.ui.horizontal(|ui| {
            let mut handle = EguiDrawHandle::new(ui);

            cb(&mut handle);
        });
    }

    fn button(&mut self, text: impl Into<String>) -> Self::Response {
        let text = text.into();
        self.ui.button(text).into()
    }

    fn heading(&mut self, text: impl Into<String>) {
        let text = text.into();
        self.ui.heading(text);
    }

    fn label(&mut self, text: impl Into<String>) {
        let text = text.into();
        self.ui.label(text);
    }

    fn collapsing_header(
        &mut self,
        title: impl Into<String>,
        add_content: impl FnOnce(&mut Self::DrawHandle<'_>),
    ) {
        let title = title.into();
        CollapsingHeader::new(title).show(self.ui, |ui| {
            let mut handle = EguiDrawHandle::new(ui);

            add_content(&mut handle);
        });
    }

    fn columns(&mut self, count: usize, add_contents: impl FnOnce(&mut [Self::DrawHandle<'_>])) {
        self.ui.columns(count, |columns| {
            let mut cols = columns
                .iter_mut()
                .map(EguiDrawHandle::new)
                .collect::<Vec<_>>();

            add_contents(&mut cols);
        });
    }

    fn image<I: std::hash::Hash>(
        &mut self,
        image_id: I,
        data: &[u8],
        textures: &mut Self::TextureMap,
    ) {
        use std::collections::hash_map::DefaultHasher;
        use std::hash::Hasher;

        let mut hasher = DefaultHasher::new();
        image_id.hash(&mut hasher);
        let hash = hasher.finish();
        if let std::collections::hash_map::Entry::Vacant(e) = textures.0.entry(hash) {
            if let Ok(image) = image::load_from_memory(data) {
                let size = [image.width() as _, image.height() as _];
                let image_buffer = image.to_rgba8();
                let pixels = image_buffer.as_flat_samples();
                let image = ColorImage::from_rgba_unmultiplied(size, pixels.as_slice());
                let handle =
                    self.ui
                        .ctx()
                        .load_texture(format!("image-{hash}"), image, Default::default());

                e.insert(handle);
            }
        }
        if let Some(texture) = textures.0.get(&hash) {
            self.ui.image(texture, texture.size_vec2());
        }
    }
}
