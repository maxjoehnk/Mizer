use crate::Plan;
pub use add_fixtures_to_plan::*;
pub use add_plan::*;
pub use move_fixtures_in_plan::*;
use pinboard::NonEmptyPinboard;
pub use remove_plan::*;
pub use rename_plan::*;
use std::sync::Arc;

mod add_fixtures_to_plan;
mod add_plan;
mod move_fixtures_in_plan;
mod remove_plan;
mod rename_plan;

pub(crate) fn update_plan<Cb: FnOnce(&mut Plan)>(
    plans_access: &Arc<NonEmptyPinboard<Vec<Plan>>>,
    plan_id: &str,
    update: Cb,
) {
    let mut plans = plans_access.read();
    if let Some(plan) = plans.iter_mut().find(|plan| plan.name == plan_id) {
        update(plan);
    }
    plans_access.set(plans);
}
