use crate::commands::update_image;
use crate::{ImageId, PlanStorage};
use mizer_commander::{Command, Ref};
use serde::{Deserialize, Serialize};
use std::hash::{Hash, Hasher};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MovePlanImageCommand {
    pub plan: String,
    pub image: ImageId,
    pub x: f64,
    pub y: f64,
}

impl Hash for MovePlanImageCommand {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.plan.hash(state);
        self.x.to_bits().hash(state);
        self.y.to_bits().hash(state);
    }
}

impl<'a> Command<'a> for MovePlanImageCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = (f64, f64);
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Move Image in plan {} to ({}, {})",
            self.plan, self.x, self.y
        )
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let previous = update_image(plans_access, &self.plan, self.image, |image| {
            let old = (image.x, image.y);
            image.x = self.x;
            image.y = self.y;

            old
        })?;

        Ok(((), previous))
    }

    fn revert(&self, plans_access: &PlanStorage, (x, y): Self::State) -> anyhow::Result<()> {
        update_image(plans_access, &self.plan, self.image, |image| {
            image.x = x;
            image.y = y;
        })?;

        Ok(())
    }
}
