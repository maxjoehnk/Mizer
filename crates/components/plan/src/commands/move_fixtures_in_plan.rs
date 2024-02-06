use crate::commands::update_plan;
use crate::PlanStorage;
use mizer_commander::{Command, Ref};
use mizer_fixtures::FixtureId;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::hash::{Hash, Hasher};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MoveFixturesInPlanCommand {
    pub id: String,
    pub fixture_ids: Vec<FixtureId>,
    pub offset: (f64, f64),
}

impl Hash for MoveFixturesInPlanCommand {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.id.hash(state);
        self.fixture_ids.hash(state);
        self.offset.0.to_bits().hash(state);
        self.offset.1.to_bits().hash(state);
    }
}

impl<'a> Command<'a> for MoveFixturesInPlanCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = HashMap<FixtureId, (f64, f64)>;
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
