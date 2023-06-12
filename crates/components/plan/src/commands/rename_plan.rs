use crate::commands::update_plan;
use crate::PlanStorage;
use mizer_commander::{Command, Ref};
use serde::{Deserialize, Serialize};
use std::mem::swap;

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct RenamePlanCommand {
    pub id: String,
    pub name: String,
}

impl<'a> Command<'a> for RenamePlanCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = String;
    type Result = ();

    fn label(&self) -> String {
        format!("Rename Plan to {}", self.name)
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let previous_name = update_plan(plans_access, &self.id, |plan| {
            let mut name = self.name.clone();
            swap(&mut plan.name, &mut name);

            Ok(name)
        })?;

        Ok(((), previous_name))
    }

    fn revert(&self, plans_access: &PlanStorage, name: Self::State) -> anyhow::Result<()> {
        update_plan(plans_access, &self.name, |plan| {
            plan.name = name;

            Ok(())
        })?;

        Ok(())
    }
}
