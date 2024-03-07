use crate::pipeline_access::PipelineAccess;
use mizer_debug_ui_impl::{DebugUiImpl, NodeStateAccess};
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
        let pipeline_access = injector.inject::<PipelineAccess>();
        let nodes = pipeline_access.nodes.iter().collect::<Vec<_>>();

        for (path, node) in nodes {
            let state = state_access.get(path);
            let state = state.unwrap();
            let node = node.downcast();
            ui.collapsing_header(path.as_str(), |ui| node.debug_ui(ui, state));
        }
    }
}
