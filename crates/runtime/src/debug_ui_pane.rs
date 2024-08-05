use crate::Pipeline;
use mizer_debug_ui_impl::NodeStateAccess;
use mizer_module::*;
use mizer_nodes::NodeDowncast;

pub struct NodesDebugUiPane;

impl<TUi: DebugUi> DebugUiPane<TUi> for NodesDebugUiPane {
    fn title(&self) -> &'static str {
        "Nodes"
    }

    fn render<'a>(
        &mut self,
        injector: &Injector,
        state_access: &dyn NodeStateAccess,
        ui: &mut TUi::DrawHandle<'a>,
        _textures: &mut <TUi::DrawHandle<'a> as DebugUiDrawHandle<'a>>::TextureMap,
    ) {
        let pipeline = injector.inject::<Pipeline>();
        let nodes = pipeline.list_nodes();

        for (path, node) in nodes {
            let state = state_access.get(path);
            let state = state.unwrap();
            let node = node.downcast();
            ui.collapsing_header(path.as_str(), |ui| node.debug_ui(ui, state));
        }
    }
}
