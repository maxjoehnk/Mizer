use crate::commands::update_plan;
use crate::{FixturePosition, PlanStorage};
use mizer_commander::{Command, Ref};
use mizer_fixtures::FixtureId;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct AddFixturesToPlanCommand {
    pub id: String,
    pub fixture_ids: Vec<FixtureId>,
}

impl<'a> Command<'a> for AddFixturesToPlanCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!("Add fixtures to Plan {}", self.id)
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        update_plan(plans_access, &self.id, |plan| {
            for (i, fixture_id) in self.fixture_ids.iter().enumerate() {
                plan.fixtures.push(FixturePosition {
                    fixture: *fixture_id,
                    x: i as i32,
                    y: 0,
                    width: 1,
                    height: 1,
                });
            }
        });

        Ok(((), ()))
    }

    fn revert(&self, plans_access: &PlanStorage, _: Self::State) -> anyhow::Result<()> {
        update_plan(plans_access, &self.id, |plan| {
            plan.fixtures
                .retain(|p| self.fixture_ids.contains(&p.fixture));
        });

        Ok(())
    }
}
