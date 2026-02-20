use crate::draw_handle::DebugUiDrawHandleExt;
use crate::{get_tracing_collector, EguiDebugUi};
use egui_tracing::EventCollector;
use mizer_debug_ui::{DebugUi, DebugUiDrawHandle, DebugUiPane, Injector, NodeStateAccess};

pub struct LoggingPane(EventCollector);

impl LoggingPane {
    pub fn new() -> Self {
        Self(get_tracing_collector())
    }
}

impl DebugUiPane<EguiDebugUi> for LoggingPane {
    fn title(&self) -> &'static str {
        "Logs"
    }

    fn render<'a>(
        &mut self,
        _injector: &Injector,
        _state_access: &dyn NodeStateAccess,
        ui: &mut <EguiDebugUi as DebugUi>::DrawHandle<'a>,
        _textures: &mut <<EguiDebugUi as DebugUi>::DrawHandle<'a> as DebugUiDrawHandle<'a>>::TextureMap,
    ) {
        ui.add(egui_tracing::Logs::new(self.0.clone()));
    }
}
