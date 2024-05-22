use crate::commands::update_plan;
use crate::{PlanScreen, PlanStorage, ScreenId};
use mizer_commander::{Command, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AddPlanScreenCommand {
    pub plan: String,
    pub x: f64,
    pub y: f64,
    pub width: f64,
    pub height: f64,
}

impl<'a> Command<'a> for AddPlanScreenCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = ScreenId;
    type Result = ();

    fn label(&self) -> String {
        format!("Add Screen to plan {}", self.plan)
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let id = update_plan(plans_access, &self.plan, |plan| {
            let id = plan
                .screens
                .iter()
                .map(|screen| screen.id)
                .max()
                .unwrap_or_default()
                .next();
            plan.screens.push(PlanScreen {
                id,
                x: self.x,
                y: self.y,
                width: self.width,
                height: self.height,
            });

            Ok(id)
        })?;

        Ok(((), id))
    }

    fn revert(&self, plans_access: &PlanStorage, id: Self::State) -> anyhow::Result<()> {
        update_plan(plans_access, &self.plan, |plan| {
            plan.screens.retain(|screen| screen.id != id);

            Ok(())
        })?;

        Ok(())
    }
}
