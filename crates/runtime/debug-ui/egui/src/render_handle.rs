use egui::{CentralPanel, Ui, WidgetText};
use egui_tiles::{TileId, UiResponse};
use std::cell::RefCell;
use std::rc::Rc;

use mizer_debug_ui::{DebugUiPane, DebugUiRenderHandle, NodeStateAccess};
use mizer_module::{InjectionScope};

use crate::draw_handle::EguiDrawHandle;
use crate::{EguiDebugUi, EguiState, EguiTextureMap};

pub struct EguiRenderHandle<'a> {
    context: &'a egui::Context,
    textures: &'a mut EguiTextureMap,
    tree: &'a mut egui_tiles::Tree<Pane>,
    state: Rc<RefCell<EguiState>>,
}

pub(crate) type Pane = Box<dyn DebugUiPane<EguiDebugUi>>;

struct DockTreeBehavior<'a> {
    injector: &'a InjectionScope<'a>,
    textures: &'a mut EguiTextureMap,
    state: Rc<RefCell<EguiState>>,
    state_access: &'a dyn NodeStateAccess,
}

impl<'a> egui_tiles::Behavior<Pane> for DockTreeBehavior<'a> {
    fn pane_ui(&mut self, ui: &mut Ui, _tile_id: TileId, pane: &mut Pane) -> UiResponse {
        let mut draw_handle = EguiDrawHandle::new(ui, Rc::clone(&self.state));

        pane.render(
            self.injector,
            self.state_access,
            &mut draw_handle,
            self.textures,
        );

        UiResponse::None
    }

    fn tab_title_for_pane(&mut self, pane: &Pane) -> WidgetText {
        pane.title().into()
    }
}

impl<'a> DebugUiRenderHandle<'a> for EguiRenderHandle<'a> {
    type DrawHandle<'b> = EguiDrawHandle<'b>;
    type TextureMap = EguiTextureMap;

    fn draw(&mut self, injector: &InjectionScope, state_access: &dyn NodeStateAccess) {
        let mut tree_behavior = DockTreeBehavior {
            injector,
            state: Rc::clone(&self.state),
            textures: self.textures,
            state_access,
        };

        CentralPanel::default().show(self.context, |ui| self.tree.ui(&mut tree_behavior, ui));
    }
}

impl<'a> EguiRenderHandle<'a> {
    pub(crate) fn new(
        context: &'a egui::Context,
        textures: &'a mut EguiTextureMap,
        tree: &'a mut egui_tiles::Tree<Pane>,
        state: Rc<RefCell<EguiState>>,
    ) -> Self {
        Self {
            context,
            textures,
            tree,
            state,
        }
    }
}
