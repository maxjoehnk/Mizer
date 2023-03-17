use mizer_clock::Clock;
use mizer_debug_ui::{DebugUiDrawHandle, TextureMap};
use mizer_layouts::LayoutStorage;
use mizer_plan::PlanStorage;

use crate::debug_ui::layouts::layouts_debug_ui;
use crate::debug_ui::plans::plans_debug_ui;
use crate::CoordinatorRuntime;

mod layouts;
mod plans;

impl<TClock: Clock> CoordinatorRuntime<TClock> {
    pub(crate) fn debug_ui(
        ui: &mut DebugUiDrawHandle,
        textures: &mut TextureMap,
        layouts: &LayoutStorage,
        plans: &PlanStorage,
    ) {
        layouts_debug_ui(ui, textures, layouts);
        plans_debug_ui(ui, plans);
    }
}
