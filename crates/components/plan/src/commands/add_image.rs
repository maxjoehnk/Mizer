use crate::commands::update_plan;
use crate::{ImageId, PlanImage, PlanStorage};
use mizer_commander::{Command, Ref};
use mizer_util::Base64Image;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AddPlanImageCommand {
    pub plan: String,
    pub data: Base64Image,
    pub x: f64,
    pub y: f64,
    pub width: f64,
    pub height: f64,
    pub transparency: f64,
}

impl<'a> Command<'a> for AddPlanImageCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = ImageId;
    type Result = ();

    fn label(&self) -> String {
        format!("Add Image to plan {}", self.plan)
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let id = ImageId::new();
        update_plan(plans_access, &self.plan, |plan| {
            plan.images.push(PlanImage {
                id,
                x: self.x,
                y: self.y,
                width: self.width,
                height: self.height,
                transparency: self.transparency,
                data: self.data.clone(),
            });

            Ok(())
        })?;

        Ok(((), id))
    }

    fn revert(&self, plans_access: &PlanStorage, id: Self::State) -> anyhow::Result<()> {
        update_plan(plans_access, &self.plan, |plan| {
            plan.images.retain(|image| image.id != id);

            Ok(())
        })?;

        Ok(())
    }
}
