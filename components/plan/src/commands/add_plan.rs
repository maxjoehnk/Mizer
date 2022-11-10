use crate::{Plan, PlanStorage};
use mizer_commander::{Command, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct AddPlanCommand {
    pub name: String,
}

impl<'a> Command<'a> for AddPlanCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!("Add Plan {}", self.name)
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut plans = plans_access.read();
        plans.push(Plan {
            name: self.name.clone(),
            fixtures: Default::default(),
            screens: Default::default(),
        });
        plans_access.set(plans);

        Ok(((), ()))
    }

    fn revert(&self, plans_access: &PlanStorage, _: Self::State) -> anyhow::Result<()> {
        let mut plans = plans_access.read();
        plans.retain(|plan| plan.name != self.name);
        plans_access.set(plans);

        Ok(())
    }
}
