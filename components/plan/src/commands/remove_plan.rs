use crate::{Plan, PlanStorage};
use mizer_commander::{Command, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct RemovePlanCommand {
    pub id: String,
}

impl<'a> Command<'a> for RemovePlanCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = Plan;
    type Result = ();

    fn label(&self) -> String {
        format!("Remove Plan {}", self.id)
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut plans = plans_access.read();
        let index = plans
            .iter()
            .position(|p| p.name == self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown plan {}", &self.id))?;
        let plan = plans.remove(index);
        plans_access.set(plans);

        Ok(((), plan))
    }

    fn revert(&self, plans_access: &PlanStorage, state: Self::State) -> anyhow::Result<()> {
        let mut plans = plans_access.read();
        plans.push(state);
        plans_access.set(plans);

        Ok(())
    }
}
