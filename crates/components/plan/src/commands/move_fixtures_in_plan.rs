use crate::commands::update_plan;
use crate::PlanStorage;
use mizer_commander::{Command, Ref};
use mizer_fixtures::FixtureId;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct MoveFixturesInPlanCommand {
    pub id: String,
    pub fixture_ids: Vec<FixtureId>,
    pub offset: (i32, i32),
}

impl<'a> Command<'a> for MoveFixturesInPlanCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = HashMap<FixtureId, (i32, i32)>;
    type Result = ();

    fn label(&self) -> String {
        format!("Move fixtures in Plan {}", self.id)
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut fixtures = HashMap::new();
        update_plan(plans_access, &self.id, |plan| {
            for position in plan
                .fixtures
                .iter_mut()
                .filter(|position| self.fixture_ids.contains(&position.fixture))
            {
                // TODO: add test checking whether undo works
                position.x += self.offset.0;
                position.y += self.offset.1;
                fixtures.insert(position.fixture, (position.x, position.y));
            }

            Ok(())
        })?;

        Ok(((), fixtures))
    }

    fn revert(&self, plans_access: &PlanStorage, state: Self::State) -> anyhow::Result<()> {
        update_plan(plans_access, &self.id, |plan| {
            for position in plan
                .fixtures
                .iter_mut()
                .filter(|position| self.fixture_ids.contains(&position.fixture))
            {
                let offset = state.get(&position.fixture).unwrap();
                position.x += offset.0;
                position.y += offset.1;
            }

            Ok(())
        })?;

        Ok(())
    }
}
