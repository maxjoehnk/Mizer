use crate::commands::update_plan;
use crate::PlanStorage;
use mizer_commander::{Command, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct RenamePlanCommand {
    pub id: String,
    pub name: String,
}

impl<'a> Command<'a> for RenamePlanCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!("Rename Plan to {}", self.name)
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        update_plan(plans_access, &self.id, |plan| {
            plan.name = self.name.clone();
        });

        Ok(((), ()))
    }

    fn revert(&self, plans_access: &PlanStorage, _: Self::State) -> anyhow::Result<()> {
        update_plan(plans_access, &self.name, |plan| {
            plan.name = self.id.clone();
        });

        Ok(())
    }
}
