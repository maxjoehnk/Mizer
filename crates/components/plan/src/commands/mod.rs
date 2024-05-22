use std::sync::Arc;

use pinboard::NonEmptyPinboard;

pub use add_fixtures_to_plan::*;
pub use add_image::*;
pub use add_plan::*;
pub use add_screen::*;
pub use align_fixtures::*;
pub use move_fixtures_in_plan::*;
pub use move_image::*;
pub use remove_image::*;
pub use remove_plan::*;
pub use rename_plan::*;
pub use resize_image::*;
pub use spread_fixtures::*;

use crate::{ImageId, Plan, PlanImage};

mod add_fixtures_to_plan;
mod add_image;
mod add_plan;
mod add_screen;
mod align_fixtures;
mod move_fixtures_in_plan;
mod move_image;
mod remove_image;
mod remove_plan;
mod rename_plan;
mod resize_image;
mod spread_fixtures;

pub(crate) fn update_plan<Cb: FnOnce(&mut Plan) -> anyhow::Result<R>, R>(
    plans_access: &Arc<NonEmptyPinboard<Vec<Plan>>>,
    plan_id: &str,
    update: Cb,
) -> anyhow::Result<R> {
    let mut plans = plans_access.read();
    let plan = plans
        .iter_mut()
        .find(|plan| plan.name == plan_id)
        .ok_or_else(|| anyhow::anyhow!("Plan {plan_id} not found"))?;
    let result = update(plan)?;
    plans_access.set(plans);

    Ok(result)
}

pub(crate) fn update_image<Cb: FnOnce(&mut PlanImage) -> R, R>(
    plans_access: &Arc<NonEmptyPinboard<Vec<Plan>>>,
    plan_id: &str,
    image_id: ImageId,
    update: Cb,
) -> anyhow::Result<R> {
    let mut plans = plans_access.read();
    let plan = plans
        .iter_mut()
        .find(|plan| plan.name == plan_id)
        .ok_or_else(|| anyhow::anyhow!("Plan {plan_id} not found"))?;
    let image = plan
        .images
        .iter_mut()
        .find(|image| image.id == image_id)
        .ok_or_else(|| anyhow::anyhow!("Image {image_id} not found"))?;
    let result = update(image);
    plans_access.set(plans);

    Ok(result)
}
