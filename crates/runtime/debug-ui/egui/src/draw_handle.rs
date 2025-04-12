use egui::load::SizedTexture;
use egui::{CollapsingHeader, ColorImage, Ui, Widget};
use egui_plot::PlotBounds;
use std::cell::RefCell;
use std::rc::Rc;

use mizer_debug_ui::{DebugUiDrawHandle, DebugUiResponse};

use crate::{EguiState, EguiTextureMap, PlotState};

pub struct EguiDrawHandle<'a> {
    ui: &'a mut Ui,
    state: Rc<RefCell<EguiState>>,
    context: Option<egui::Id>,
}

impl<'a> EguiDrawHandle<'a> {
    pub(crate) fn new(ui: &'a mut Ui, state: Rc<RefCell<EguiState>>) -> Self {
        Self {
            ui,
            state,
            context: None,
        }
    }

    pub fn in_context(&mut self, context: &String) {
        self.context = Some(egui::Id::new(context));
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
            let mut handle = EguiDrawHandle::new(ui, Rc::clone(&self.state));

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
        key: Option<&'_ str>,
        add_content: impl FnOnce(&mut Self::DrawHandle<'_>),
    ) {
        let title = title.into();
        let mut header = CollapsingHeader::new(title);
        if let Some(key) = key {
            header = header.id_salt(key);
        }
        header.show(self.ui, |ui| {
            let mut handle = EguiDrawHandle::new(ui, Rc::clone(&self.state));

            add_content(&mut handle);
        });
    }

    fn columns(&mut self, count: usize, add_contents: impl FnOnce(&mut [Self::DrawHandle<'_>])) {
        self.ui.columns(count, |columns| {
            let mut cols = columns
                .iter_mut()
                .map(|ui| EguiDrawHandle::new(ui, Rc::clone(&self.state)))
                .collect::<Vec<_>>();

            add_contents(&mut cols);
        });
    }

    fn progress_bar(&mut self, progress: f32) {
        self.ui.add(egui::ProgressBar::new(progress));
    }

    fn plot(&mut self, id: &'static str, min: f64, max: f64, values: &[f64]) {
        let mut state = self.state.borrow_mut();
        let state = state
            .contexts
            .entry(self.context.unwrap_or(self.ui.id()))
            .or_default();
        let plot_data = state.plots.entry(id).or_insert_with(|| PlotState {
            data: Vec::new(),
            min,
            max,
        });

        plot_data.data.extend_from_slice(values);
        if plot_data.data.len() > 500 {
            plot_data.data.drain(0..(plot_data.data.len() - 500));
        }

        egui_plot::Plot::new(id)
            .allow_zoom(false)
            .allow_drag(false)
            .allow_scroll(false)
            .legend(egui_plot::Legend::default())
            .show(self.ui, |plot_ui| {
                plot_ui.set_plot_bounds(PlotBounds::from_min_max(
                    [0.0, plot_data.min],
                    [plot_data.data.len() as f64, plot_data.max],
                ));
                plot_ui.line(egui_plot::Line::new(egui_plot::PlotPoints::from_ys_f64(
                    &plot_data.data,
                )));
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
            self.ui.image(SizedTexture {
                id: texture.id(),
                size: texture.size_vec2(),
            });
        }
    }
}

pub(crate) trait DebugUiDrawHandleExt {
    fn add(&mut self, widget: impl Widget);
}

impl DebugUiDrawHandleExt for EguiDrawHandle<'_> {
    fn add(&mut self, widget: impl Widget) {
        self.ui.add(widget);
    }
}
