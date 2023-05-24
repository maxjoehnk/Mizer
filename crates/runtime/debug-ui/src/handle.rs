#[cfg(feature = "compile")]
use egui::{CentralPanel, CollapsingHeader, ColorImage, Response, ScrollArea, TextureHandle, Ui};
#[cfg(feature = "compile")]
use std::collections::HashMap;

#[cfg(feature = "compile")]
pub type TextureMap = HashMap<u64, TextureHandle>;

#[cfg(not(feature = "compile"))]
pub type TextureMap = ();

pub struct DebugUiRenderHandle<'a> {
    #[cfg(feature = "compile")]
    context: &'a egui::Context,
    #[cfg(feature = "compile")]
    textures: &'a mut TextureMap,
    #[cfg(not(feature = "compile"))]
    _lifetime: std::marker::PhantomData<&'a ()>,
}

#[cfg(feature = "compile")]
impl<'a> DebugUiRenderHandle<'a> {
    pub(crate) fn new(
        context: &'a egui::Context,
        textures: &'a mut HashMap<u64, TextureHandle>,
    ) -> Self {
        Self { context, textures }
    }

    pub fn draw(&mut self, call: impl FnOnce(&mut DebugUiDrawHandle, &mut TextureMap)) {
        CentralPanel::default().show(self.context, |ui| {
            ScrollArea::vertical().show(ui, |ui| {
                let mut draw_handle = DebugUiDrawHandle::new(ui);
                call(&mut draw_handle, self.textures);
            });
        });
    }
}

pub struct DebugUiDrawHandle<'a> {
    #[cfg(feature = "compile")]
    ui: &'a mut Ui,
    #[cfg(not(feature = "compile"))]
    _lifetime: std::marker::PhantomData<&'a ()>,
}

impl<'a> DebugUiDrawHandle<'a> {
    #[cfg(feature = "compile")]
    pub(crate) fn new(ui: &'a mut Ui) -> Self {
        Self { ui }
    }

    #[cfg(feature = "compile")]
    pub fn horizontal(&mut self, cb: impl FnOnce(&mut DebugUiDrawHandle)) {
        self.ui.horizontal(|ui| {
            let mut handle = DebugUiDrawHandle::new(ui);

            cb(&mut handle);
        });
    }

    #[cfg(not(feature = "compile"))]
    pub fn horizontal(&mut self, _cb: impl FnOnce(&mut DebugUiDrawHandle)) {}

    #[cfg(feature = "compile")]
    pub fn button(&mut self, text: impl Into<String>) -> DebugUiResponse {
        let text = text.into();
        self.ui.button(text).into()
    }

    #[cfg(not(feature = "compile"))]
    pub fn button(&mut self, text: impl Into<String>) -> DebugUiResponse {
        DebugUiResponse
    }

    #[cfg(feature = "compile")]
    pub fn heading(&mut self, text: impl Into<String>) {
        let text = text.into();
        self.ui.heading(text);
    }

    #[cfg(not(feature = "compile"))]
    pub fn heading(&mut self, _text: impl Into<String>) {}

    #[cfg(feature = "compile")]
    pub fn label(&mut self, text: impl Into<String>) {
        let text = text.into();
        self.ui.label(text);
    }

    #[cfg(not(feature = "compile"))]
    pub fn label(&mut self, _text: impl Into<String>) {}

    #[cfg(feature = "compile")]
    pub fn collapsing_header(
        &mut self,
        title: impl Into<String>,
        add_content: impl FnOnce(&mut DebugUiDrawHandle),
    ) {
        let title = title.into();
        CollapsingHeader::new(title).show(self.ui, |ui| {
            let mut handle = DebugUiDrawHandle::new(ui);

            add_content(&mut handle);
        });
    }

    #[cfg(not(feature = "compile"))]
    pub fn collapsing_header(
        &mut self,
        _title: impl Into<String>,
        _add_content: impl FnOnce(&mut DebugUiDrawHandle),
    ) {
    }

    #[cfg(feature = "compile")]
    pub fn columns(&mut self, count: usize, add_contents: impl FnOnce(&mut [DebugUiDrawHandle])) {
        self.ui.columns(count, |columns| {
            let mut cols = columns
                .iter_mut()
                .map(DebugUiDrawHandle::new)
                .collect::<Vec<_>>();

            add_contents(&mut cols);
        });
    }

    #[cfg(not(feature = "compile"))]
    pub fn columns(&mut self, _count: usize, _add_contents: impl FnOnce(&mut [DebugUiDrawHandle])) {
    }

    #[cfg(feature = "compile")]
    pub fn image<I: std::hash::Hash>(
        &mut self,
        image_id: I,
        data: &[u8],
        textures: &mut TextureMap,
    ) {
        use std::collections::hash_map::DefaultHasher;
        use std::hash::Hasher;

        let mut hasher = DefaultHasher::new();
        image_id.hash(&mut hasher);
        let hash = hasher.finish();
        if let std::collections::hash_map::Entry::Vacant(e) = textures.entry(hash) {
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
        if let Some(texture) = textures.get(&hash) {
            self.ui.image(texture, texture.size_vec2());
        }
    }
}

#[cfg(feature = "compile")]
pub struct DebugUiResponse(Response);

#[cfg(not(feature = "compile"))]
pub struct DebugUiResponse;

#[cfg(feature = "compile")]
impl From<Response> for DebugUiResponse {
    fn from(response: Response) -> Self {
        Self(response)
    }
}

impl DebugUiResponse {
    #[inline]
    #[cfg(feature = "compile")]
    pub fn clicked(&self) -> bool {
        self.0.clicked()
    }

    #[inline]
    #[cfg(not(feature = "compile"))]
    pub fn clicked(&self) -> bool {
        false
    }
}
