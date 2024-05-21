use crate::commands::update_plan;
use crate::{ImageId, PlanImage, PlanStorage};
use mizer_commander::{Command, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RemovePlanImageCommand {
    pub plan_id: String,
    pub image_id: ImageId,
}

impl<'a> Command<'a> for RemovePlanImageCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = PlanImage;
    type Result = ();

    fn label(&self) -> String {
        format!("Remove Image {} from plan {}", self.image_id, self.plan_id)
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let image = update_plan(plans_access, &self.plan_id, |plan| {
            let index = plan
                .images
                .iter()
                .position(|i| i.id == self.image_id)
                .ok_or_else(|| anyhow::anyhow!("Unknown image {}", &self.image_id))?;

            Ok(plan.images.remove(index))
        })?;

        Ok(((), image))
    }

    fn revert(&self, plans_access: &PlanStorage, state: Self::State) -> anyhow::Result<()> {
        update_plan(plans_access, &self.plan_id, |plan| {
            plan.images.push(state);

            Ok(())
        })?;

        Ok(())
    }
}
