use crate::commands::update_image;
use crate::{ImageId, PlanStorage};
use mizer_commander::{Command, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ResizePlanImageCommand {
    pub plan: String,
    pub image: ImageId,
    pub width: f64,
    pub height: f64,
}

impl<'a> Command<'a> for ResizePlanImageCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = (f64, f64);
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Resize Image in plan {} to ({}, {})",
            self.plan, self.width, self.height
        )
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let previous = update_image(plans_access, &self.plan, self.image, |image| {
            let old = (image.width, image.height);
            image.width = self.width;
            image.height = self.height;

            old
        })?;

        Ok(((), previous))
    }

    fn revert(
        &self,
        plans_access: &PlanStorage,
        (width, height): Self::State,
    ) -> anyhow::Result<()> {
        update_image(plans_access, &self.plan, self.image, |image| {
            image.width = width;
            image.height = height;
        })?;

        Ok(())
    }
}
