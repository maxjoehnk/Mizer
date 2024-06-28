use crate::commands::update_plan;
use crate::PlanStorage;
use mizer_commander::{Command, Ref};
use mizer_fixtures::FixtureId;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TransformFixturesInPlanCommand {
    pub id: String,
    pub fixture_ids: Vec<FixtureId>,
    pub rotation: f64,
}

impl<'a> Command<'a> for TransformFixturesInPlanCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = HashMap<FixtureId, (f64, f64)>;
    type Result = ();

    fn label(&self) -> String {
        format!("Transform fixtures in Plan {}", self.id)
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut fixtures = HashMap::new();
        update_plan(plans_access, &self.id, |plan| {
            let relevant_positions = plan
                .fixtures
                .iter_mut()
                .filter(|position| self.fixture_ids.contains(&position.fixture))
                .collect::<Vec<_>>();
            
            let min_x = relevant_positions.iter().map(|p| p.x).min_by(|a, b| a.partial_cmp(b).unwrap()).unwrap();
            let min_y = relevant_positions.iter().map(|p| p.y).min_by(|a, b| a.partial_cmp(b).unwrap()).unwrap();
            let max_x = relevant_positions.iter().map(|p| p.x).max_by(|a, b| a.partial_cmp(b).unwrap()).unwrap();
            let max_y = relevant_positions.iter().map(|p| p.y).max_by(|a, b| a.partial_cmp(b).unwrap()).unwrap();
            let center_x = (min_x + max_x) / 2.;
            let center_y = (min_y + max_y) / 2.;
            let rotation = self.rotation * (std::f64::consts::PI / 180.0);
            for position in plan
                .fixtures
                .iter_mut()
                .filter(|position| self.fixture_ids.contains(&position.fixture))
            {
                // TODO: add test checking whether undo works
                fixtures.insert(position.fixture, (position.x, position.y));
                
                let temp_x = position.x - center_x;
                let temp_y = position.y - center_y;
                
                let rotated_x = temp_x * rotation.cos() - temp_y * rotation.sin();
                let rotated_y = temp_x * rotation.sin() + temp_y * rotation.cos();
                
                position.x = rotated_x + center_x;
                position.y = rotated_y + center_y;
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
                position.x = offset.0;
                position.y = offset.1;
            }

            Ok(())
        })?;

        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::{Plan, FixtureId, FixturePosition};
    use std::sync::Arc;
    use pinboard::{NonEmptyPinboard};

    #[test]
    fn test_transform_fixtures_by_90deg_in_plan() {
        let plan = Plan {
            name: "test".to_string(),
            fixtures: generate_fixtures_along_y_axis(10, 0.),
            screens: vec![],
            images: vec![],
        };
        let fixtures = plan.fixtures.iter().map(|p| p.fixture).collect();
        let plans: PlanStorage = Arc::new(NonEmptyPinboard::new(vec![plan]));
        let command = TransformFixturesInPlanCommand {
            id: "test".to_string(),
            fixture_ids: fixtures,
            rotation: 90.0,
        };

        command.apply(&plans).unwrap();

        let plan = plans.read().into_iter().next().unwrap();
        let expected: Vec<_> =
            (0..10)
                .map(|i| position(i as u32, 4.5 - i as f64, 4.5))
                .collect();

        assert_eq!(plan.fixtures, expected);
    }

    fn generate_fixtures_along_y_axis(count: usize, x: f64) -> Vec<FixturePosition> {
        (0..count)
            .map(|i| position(i as u32, x, i as f64))
            .collect()
    }

    fn generate_fixtures_along_x_axis(count: usize, y: f64, x_start: f64) -> Vec<FixturePosition> {
        (0..count)
            .map(|i| position(i as u32, x_start + i as f64, y))
            .collect()
    }

    fn position(id: u32, x: f64, y: f64) -> FixturePosition {
        FixturePosition {
            fixture: FixtureId::Fixture(id),
            x,
            y,
            width: 1.0,
            height: 1.0,
        }
    }
}
