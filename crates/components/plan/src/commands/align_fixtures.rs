use std::collections::HashMap;

use itertools::Itertools;
use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};
use mizer_fixtures::FixtureId;

use crate::commands::update_plan;
use crate::PlanStorage;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AlignFixturesInPlanCommand {
    pub id: String,
    pub fixture_ids: Vec<FixtureId>,
    pub direction: AlignFixturesDirection,
    pub groups: u32,
    pub row_gap: u32,
    pub column_gap: u32,
}

#[derive(Debug, Clone, Serialize, Deserialize, Eq, PartialEq)]
pub enum AlignFixturesDirection {
    LeftToRight,
    TopToBottom,
}

impl<'a> Command<'a> for AlignFixturesInPlanCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = HashMap<FixtureId, (f64, f64)>;
    type Result = ();

    fn label(&self) -> String {
        format!("Align fixtures in Plan {}", self.id)
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let column_gap = self.column_gap as usize + 1;
        let row_gap = self.row_gap as usize + 1;
        let mut fixtures = HashMap::new();
        update_plan(plans_access, &self.id, |plan| {
            let initial_position = plan
                .fixtures
                .iter()
                .find(|position| self.fixture_ids.contains(&position.fixture))
                .cloned();

            if let Some(initial_position) = initial_position {
                for (group_index, group) in plan
                    .fixtures
                    .iter_mut()
                    .filter(|position| self.fixture_ids.contains(&position.fixture))
                    .chunks(self.groups as usize)
                    .into_iter()
                    .enumerate()
                {
                    for (fixture_index, position) in group.into_iter().enumerate() {
                        let (x, y) = if self.direction == AlignFixturesDirection::LeftToRight {
                            let x = initial_position.x
                                + (fixture_index * column_gap) as f64 * position.width;
                            let y = initial_position.y
                                + (group_index * row_gap) as f64 * position.height;

                            (x, y)
                        } else {
                            let x = initial_position.x
                                + (group_index * column_gap) as f64 * position.width;
                            let y = initial_position.y
                                + (fixture_index * row_gap) as f64 * position.height;

                            (x, y)
                        };
                        fixtures.insert(position.fixture, (position.x, position.y));
                        position.x = x;
                        position.y = y;
                    }
                }
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
