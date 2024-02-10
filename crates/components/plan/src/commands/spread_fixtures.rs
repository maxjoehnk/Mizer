use std::collections::HashMap;

use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};
use mizer_fixtures::FixtureId;

use crate::commands::update_plan;
use crate::{FixturePosition, PlanStorage};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct SpreadFixturesInPlanCommand {
    pub plan_id: String,
    pub fixture_ids: Vec<FixtureId>,
    pub geometry: SpreadFixturesGeometry,
}

#[derive(Debug, Clone, Serialize, Deserialize, Hash, Eq, PartialEq)]
pub enum SpreadFixturesGeometry {
    Square,
    Triangle,
}

impl<'a> Command<'a> for SpreadFixturesInPlanCommand {
    type Dependencies = Ref<PlanStorage>;
    type State = HashMap<FixtureId, (f64, f64)>;
    type Result = ();

    fn label(&self) -> String {
        format!("Spread fixtures in Plan {}", self.plan_id)
    }

    fn apply(&self, plans_access: &PlanStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut fixtures = HashMap::new();
        update_plan(plans_access, &self.plan_id, |plan| {
            let initial_position = plan
                .fixtures
                .iter()
                .find(|position| self.fixture_ids.contains(&position.fixture))
                .cloned();

            let fixture_positions = self
                .fixture_ids
                .iter()
                .filter_map(|id| {
                    plan.fixtures
                        .iter()
                        .find(|position| position.fixture == *id)
                        .copied()
                })
                .collect::<Vec<_>>();

            if let Some(initial_position) = initial_position {
                fixtures = self
                    .geometry
                    .spread((initial_position.x, initial_position.y), &fixture_positions);

                plan.fixtures.iter_mut().for_each(|position| {
                    if let Some((x, y)) = fixtures.get(&position.fixture) {
                        position.x = *x;
                        position.y = *y;
                    }
                });
            }

            Ok(())
        })?;

        Ok(((), fixtures))
    }

    fn revert(&self, plans_access: &PlanStorage, state: Self::State) -> anyhow::Result<()> {
        update_plan(plans_access, &self.plan_id, |plan| {
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

impl SpreadFixturesGeometry {
    fn spread(
        &self,
        origin: (f64, f64),
        fixtures: &[FixturePosition],
    ) -> HashMap<FixtureId, (f64, f64)> {
        match self {
            SpreadFixturesGeometry::Square => Self::spread_square(origin, fixtures),
            SpreadFixturesGeometry::Triangle => Self::spread_triangle(origin, fixtures),
        }
    }

    fn spread_square(
        origin: (f64, f64),
        fixtures: &[FixturePosition],
    ) -> HashMap<FixtureId, (f64, f64)> {
        let mut hashmap = HashMap::with_capacity(fixtures.len());
        let side_length = fixtures.len() / 4;
        let width = fixtures
            .iter()
            .max_by(|lhs, rhs| lhs.width.partial_cmp(&rhs.width).unwrap())
            .unwrap()
            .width;
        let height = fixtures
            .iter()
            .max_by(|lhs, rhs| lhs.height.partial_cmp(&rhs.height).unwrap())
            .unwrap()
            .height;

        fixtures
            .chunks(side_length)
            .enumerate()
            .for_each(|(i, chunk)| {
                chunk.iter().enumerate().for_each(|(j, fixture)| {
                    let j = j as f64;
                    let side_length = side_length as f64;
                    let (x, y) = match i {
                        0 => (j * width, 0.),
                        1 => (side_length * width, j * height),
                        2 => ((side_length - j) * width, side_length * height),
                        3 => (0., (side_length - j) * height),
                        _ => (0., 0.),
                    };
                    hashmap.insert(fixture.fixture, (x, y));
                });
            });

        hashmap
    }

    fn spread_triangle(
        origin: (f64, f64),
        fixtures: &[FixturePosition],
    ) -> HashMap<FixtureId, (f64, f64)> {
        let mut hashmap = HashMap::with_capacity(fixtures.len());
        let side_length = fixtures.len() / 3;
        let size = fixtures
            .iter()
            .max_by(|lhs, rhs| lhs.width.partial_cmp(&rhs.width).unwrap())
            .unwrap()
            .width;

        fixtures
            .chunks(side_length)
            .enumerate()
            .for_each(|(i, chunk)| {
                chunk.iter().enumerate().for_each(|(j, fixture)| {
                    let j = j as f64 * size;
                    let side_length = side_length as f64 * size;
                    let (x, y) = match i {
                        0 => (j, side_length - j),
                        1 => (side_length + j, j),
                        2 => ((side_length - j) * 2., side_length),
                        _ => (0., 0.),
                    };
                    hashmap.insert(fixture.fixture, (x, y));
                });
            });

        hashmap
    }
}

#[cfg(test)]
mod tests {
    use itertools::Itertools;
    use spectral::assert_that;
    use std::collections::HashMap;
    use test_case::test_case;

    use mizer_fixtures::FixtureId;

    use crate::commands::SpreadFixturesGeometry;
    use crate::FixturePosition;

    #[test_case(4, vec![(0, 0), (1, 0), (1, 1), (0, 1)])]
    #[test_case(8, vec![(0, 0), (1, 0), (2, 0), (2, 1), (2, 2), (1, 2), (0, 2), (0, 1)])]
    #[test_case(12, vec![(0, 0), (1, 0), (2, 0), (3, 0), (3, 1), (3, 2), (3, 3), (2, 3), (1, 3), (0, 3), (0, 2), (0, 1)])]
    fn spread_square_should_align_fixtures_in_square(
        count: usize,
        expected_positions: Vec<(i32, i32)>,
    ) {
        let origin = (0.0, 0.0);
        let expected = convert_positions(expected_positions);
        let fixtures = generate_fixture_list(count);

        let result = SpreadFixturesGeometry::spread_square(origin, &fixtures);

        let result = convert_map_to_list(result);
        assert_that(&result).is_equal_to(&expected);
    }

    #[test_case(1.0, vec![(0., 0.), (1., 0.), (1., 1.), (0., 1.)])]
    #[test_case(0.5, vec![(0., 0.), (0.5, 0.), (0.5, 0.5), (0., 0.5)])]
    #[test_case(0.25, vec![(0., 0.), (0.25, 0.), (0.25, 0.25), (0., 0.25)])]
    fn spread_square_should_incorporate_fixture_size(
        size: f64,
        expected_positions: Vec<(f64, f64)>,
    ) {
        let origin = (0.0, 0.0);
        let fixtures = generate_fixture_list_with_size(4, size);
        let expected = convert_positions(expected_positions);

        let result = SpreadFixturesGeometry::spread_square(origin, &fixtures);

        let result = convert_map_to_list(result);
        assert_that(&result).is_equal_to(&expected);
    }

    #[test_case(vec![(0., 1.), (1., 0.), (2., 1.)])]
    #[test_case(vec![(0., 2.), (1., 1.), (2., 0.), (3., 1.), (4., 2.),  (2., 2.)])]
    #[test_case(vec![(0., 3.), (1., 2.), (2., 1.), (3., 0.), (4., 1.), (5., 2.), (6., 3.), (4., 3.), (2., 3.)])]
    fn spread_triangle_should_align_fixtures_in_triangle(expected_positions: Vec<(f64, f64)>) {
        let count = expected_positions.len();
        let origin = (0.0, 0.0);
        let expected = convert_positions(expected_positions);
        let fixtures = generate_fixture_list(count);

        let result = SpreadFixturesGeometry::spread_triangle(origin, &fixtures);

        let result = convert_map_to_list(result);
        assert_that(&result).is_equal_to(&expected);
    }

    #[test_case(1.0, vec![(0., 1.), (1., 0.), (2., 1.)])]
    #[test_case(0.5, vec![(0., 0.5), (0.5, 0.), (1., 0.5)])]
    #[test_case(0.25, vec![(0., 0.25), (0.25, 0.), (0.5, 0.25)])]
    fn spread_triangle_should_incorporate_fixture_size(
        size: f64,
        expected_positions: Vec<(f64, f64)>,
    ) {
        let origin = (0.0, 0.0);
        let fixtures = generate_fixture_list_with_size(3, size);
        let expected = convert_positions(expected_positions);

        let result = SpreadFixturesGeometry::spread_triangle(origin, &fixtures);

        let result = convert_map_to_list(result);
        assert_that(&result).is_equal_to(&expected);
    }

    fn generate_fixture_list(count: usize) -> Vec<FixturePosition> {
        generate_fixture_list_with_size(count, 1.0)
    }

    fn generate_fixture_list_with_size(count: usize, size: f64) -> Vec<FixturePosition> {
        (0..count)
            .map(|i| FixturePosition {
                fixture: FixtureId::Fixture(i as u32),
                x: 0.0,
                y: 0.0,
                width: size,
                height: size,
            })
            .collect::<Vec<_>>()
    }

    fn convert_positions<T: Into<f64>>(positions: Vec<(T, T)>) -> Vec<(FixtureId, (f64, f64))> {
        positions
            .into_iter()
            .enumerate()
            .map(|(id, (x, y))| (FixtureId::Fixture(id as u32), (x.into(), y.into())))
            .collect::<Vec<_>>()
    }

    fn convert_map_to_list(map: HashMap<FixtureId, (f64, f64)>) -> Vec<(FixtureId, (f64, f64))> {
        map.into_iter()
            .sorted_by_key(|(id, _)| *id)
            .collect::<Vec<_>>()
    }
}
