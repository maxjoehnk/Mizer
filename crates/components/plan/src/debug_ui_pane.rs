use crate::PlanStorage;
use mizer_module::*;

pub struct PlanDebugUiPane;

impl<S: DebugUi> DebugUiPane<S> for PlanDebugUiPane {
    fn title(&self) -> &'static str {
        "Plans"
    }

    fn render<'a>(
        &mut self,
        injector: &Injector,
        _state_access: &dyn NodeStateAccess,
        ui: &mut S::DrawHandle<'a>,
        _textures: &mut <S::DrawHandle<'a> as DebugUiDrawHandle<'a>>::TextureMap,
    ) {
        let plans = injector.inject::<PlanStorage>();
        let plans = plans.read();
        for plan in plans {
            ui.collapsing_header(plan.name, |_ui| {});
        }
    }
}
