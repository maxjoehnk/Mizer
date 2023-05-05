use mizer_debug_ui::DebugUiDrawHandle;
use mizer_plan::PlanStorage;

pub(super) fn plans_debug_ui(ui: &mut DebugUiDrawHandle, plans: &PlanStorage) {
    ui.collapsing_header("Plans", |ui| {
        let plans = plans.read();
        for plan in plans {
            ui.collapsing_header(plan.name, |_ui| {});
        }
    });
}
