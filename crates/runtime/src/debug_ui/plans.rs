use mizer_debug_ui_impl::DebugUiDrawHandle;
use mizer_plan::PlanStorage;

pub(super) fn plans_debug_ui<'a>(ui: &mut impl DebugUiDrawHandle<'a>, plans: &PlanStorage) {
    ui.collapsing_header("Plans", |ui| {
        let plans = plans.read();
        for plan in plans {
            ui.collapsing_header(plan.name, |_ui| {});
        }
    });
}
