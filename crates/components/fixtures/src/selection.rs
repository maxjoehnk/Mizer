use crate::FixtureId;
use itertools::Itertools;
use rand::prelude::*;
use serde::{Deserialize, Serialize};
use std::ops::{Deref, DerefMut};

#[derive(Default, Debug, Hash, Clone, PartialEq, Eq, Serialize, Deserialize)]
pub struct FixtureSelection {
    fixtures: Vec<FixtureId>,
    pub block_size: Option<usize>,
    pub groups: Option<usize>,
    pub wings: Option<usize>,
}

#[derive(Default, Debug, Hash, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(from = "BackwardsCompatibleFixtureSelectionChoice")]
#[repr(transparent)]
pub struct BackwardsCompatibleFixtureSelection(FixtureSelection);

impl Deref for BackwardsCompatibleFixtureSelection {
    type Target = FixtureSelection;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl DerefMut for BackwardsCompatibleFixtureSelection {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.0
    }
}

#[derive(Debug, Clone, Deserialize)]
#[serde(untagged)]
enum BackwardsCompatibleFixtureSelectionChoice {
    List(Vec<FixtureId>),
    Selection(FixtureSelection),
}

impl From<BackwardsCompatibleFixtureSelectionChoice> for BackwardsCompatibleFixtureSelection {
    fn from(value: BackwardsCompatibleFixtureSelectionChoice) -> Self {
        use BackwardsCompatibleFixtureSelectionChoice::*;

        match value {
            List(ids) => Self(FixtureSelection::new(ids)),
            Selection(selection) => Self(selection),
        }
    }
}

impl<T: Into<FixtureSelection>> From<T> for BackwardsCompatibleFixtureSelection {
    fn from(value: T) -> Self {
        let fixture_selection = value.into();

        Self(fixture_selection)
    }
}

impl From<Vec<FixtureId>> for FixtureSelection {
    fn from(fixtures: Vec<FixtureId>) -> Self {
        Self::new(fixtures)
    }
}

impl FixtureSelection {
    pub fn new(fixtures: Vec<FixtureId>) -> Self {
        Self {
            fixtures,
            ..Default::default()
        }
    }

    pub fn add_fixture(&mut self, fixture: FixtureId) {
        self.fixtures.push(fixture);
    }

    pub fn add_fixtures(&mut self, fixtures: Vec<FixtureId>) {
        for fixture in fixtures {
            if self.fixtures.contains(&fixture) {
                continue;
            }
            self.add_fixture(fixture);
        }
    }

    pub fn remove(&mut self, fixture: &FixtureId) {
        if let Some(position) = self.fixtures.iter().position(|f| f == fixture) {
            self.fixtures.remove(position);
        }
    }

    pub fn clear(&mut self) {
        self.fixtures.clear();
    }

    pub fn is_empty(&self) -> bool {
        self.fixtures.is_empty()
    }

    pub fn contains(&self, id: &FixtureId) -> bool {
        self.fixtures.contains(id)
    }

    pub fn overlaps(&self, other: &FixtureSelection) -> bool {
        self.fixtures.overlaps(&other.fixtures)
    }

    pub fn retain<F: FnMut(&FixtureId) -> bool>(&mut self, f: F) {
        self.fixtures.retain(f);
    }

    pub fn shuffle(&mut self) {
        self.fixtures.shuffle(&mut thread_rng());
    }

    pub fn total_fixtures(&self) -> usize {
        self.fixtures.len()
    }

    pub fn get_fixtures(&self) -> Vec<Vec<FixtureId>> {
        profiling::scope!("FixtureSelection::get_fixtures");
        // Itertools panics when fixture list is empty
        if self.fixtures.is_empty() {
            return Default::default();
        }
        let mut fixtures: Vec<Vec<_>> = self
            .fixtures
            .iter()
            .cloned()
            .chunks(1)
            .into_iter()
            .map(|chunk| chunk.collect())
            .collect();
        if let Some(block_size) = self.block_size {
            fixtures = fixtures
                .into_iter()
                .chunks(block_size)
                .into_iter()
                .map(|chunk| chunk.flatten().collect::<Vec<_>>())
                .collect();
        }
        if let Some(groups) = self.groups {
            fixtures = fixtures.into_iter().enumerate().fold(
                vec![vec![]; groups],
                |mut acc, (i, mut ids)| {
                    acc[i % groups].append(&mut ids);

                    acc
                },
            );
        }
        if let Some(wings) = self.wings {
            let groups = div_ceil(fixtures.len(), wings);
            fixtures = fixtures
                .into_iter()
                .chunks(groups)
                .into_iter()
                .map(|chunk| chunk.collect::<Vec<_>>())
                .enumerate()
                .map(|(i, mut chunk)| {
                    if i % 2 == 1 {
                        chunk.reverse();
                    }

                    chunk
                })
                .fold(vec![vec![]; groups], |mut acc, group| {
                    for (i, mut ids) in group.into_iter().enumerate() {
                        if let Some(acc) = acc.get_mut(i) {
                            acc.append(&mut ids);
                        }
                    }

                    acc
                });
        }

        fixtures
    }
}

// Copied from std until feature = "int_roundings", issue = "88581" is stable
// NOTE: There is an attribute which can fail compilation when this feature is stable but I can't remember the name
pub const fn div_ceil(lhs: usize, rhs: usize) -> usize {
    let d = lhs / rhs;
    let r = lhs % rhs;
    if r > 0 && rhs > 0 {
        d + 1
    } else {
        d
    }
}

trait VecExtension {
    fn overlaps(&self, other: &Self) -> bool;
}

impl<T: PartialEq> VecExtension for Vec<T> {
    fn overlaps(&self, other: &Self) -> bool {
        for item in other.iter() {
            if self.contains(item) {
                return true;
            }
        }
        false
    }
}

#[cfg(test)]
mod tests {
    use crate::selection::FixtureSelection;
    use crate::FixtureId;
    use test_case::test_case;

    #[test_case(2)]
    #[test_case(5)]
    fn total_fixtures_should_return_len_of_fixtures(count: usize) {
        let state = FixtureSelection::new(fixture_list(count));

        let result = state.total_fixtures();

        assert_eq!(count, result);
    }

    #[test_case(2)]
    #[test_case(5)]
    fn get_fixtures_should_return_plain_fixture_list(count: usize) {
        let fixtures = fixture_list(count);
        let expected: Vec<_> = fixtures.clone().into_iter().map(|id| vec![id]).collect();
        let state = FixtureSelection::new(fixtures);

        let result = state.get_fixtures();

        assert_eq!(expected, result);
    }

    #[test_case(4, 2, vec![vec![1, 2], vec![3, 4]])]
    #[test_case(4, 1, vec![vec![1], vec![2], vec![3], vec![4]])]
    #[test_case(10, 3, vec![vec![1, 2, 3], vec![4, 5, 6], vec![7, 8, 9], vec![10]])]
    fn get_fixtures_should_group_by_block_size(
        count: usize,
        block_size: usize,
        expected_ids: Vec<Vec<u32>>,
    ) {
        let expected = gen_ids(expected_ids);
        let fixtures = fixture_list(count);
        let mut state = FixtureSelection::new(fixtures);
        state.block_size = Some(block_size);

        let result = state.get_fixtures();

        assert_eq!(expected, result);
    }

    #[test_case(4, 2, vec![vec![1, 3], vec![2, 4]])]
    #[test_case(4, 4, vec![vec![1], vec![2], vec![3], vec![4]])]
    #[test_case(10, 3, vec![vec![1, 4, 7, 10], vec![2, 5, 8], vec![3, 6, 9]])]
    fn get_fixtures_should_group_by_groups(
        count: usize,
        groups: usize,
        expected_ids: Vec<Vec<u32>>,
    ) {
        let expected = gen_ids(expected_ids);
        let fixtures = fixture_list(count);
        let mut state = FixtureSelection::new(fixtures);
        state.groups = Some(groups);

        let result = state.get_fixtures();

        assert_eq!(expected, result);
    }

    #[test_case(4, 2, vec![vec![1, 4], vec![2, 3]])]
    #[test_case(10, 2, vec![vec![1, 10], vec![2, 9], vec![3, 8], vec![4, 7], vec![5, 6]])]
    // #[test_case(10, 4, vec![vec![1, 5, 6, 10], vec![2, 4, 7, 9], vec![3, 8]])] wing count > 2 is not supported yet
    fn get_fixtures_should_group_by_wings(count: usize, wings: usize, expected_ids: Vec<Vec<u32>>) {
        let expected = gen_ids(expected_ids);
        let fixtures = fixture_list(count);
        let mut state = FixtureSelection::new(fixtures);
        state.wings = Some(wings);

        let mut result = state.get_fixtures();

        reorder_ids(&mut result);
        assert_eq!(expected, result);
    }

    #[test_case(8, 2, 2, vec![vec![1, 2, 7, 8], vec![3, 4, 5, 6]])]
    #[test_case(10, 2, 2, vec![vec![1, 2, 9, 10], vec![3, 4, 7, 8], vec![5, 6]])]
    fn get_fixtures_should_group_by_block_size_and_wings(
        count: usize,
        block_size: usize,
        wings: usize,
        expected_ids: Vec<Vec<u32>>,
    ) {
        let expected = gen_ids(expected_ids);
        let fixtures = fixture_list(count);
        let mut state = FixtureSelection::new(fixtures);
        state.wings = Some(wings);
        state.block_size = Some(block_size);

        let result = state.get_fixtures();

        assert_eq!(expected, result);
    }

    #[test_case(8, 2, 2, vec![vec![1, 2, 5, 6], vec![3, 4, 7, 8]])]
    #[test_case(10, 2, 2, vec![vec![1, 2, 5, 6, 9, 10], vec![3, 4, 7, 8]])]
    fn get_fixtures_should_group_by_block_size_and_groups(
        count: usize,
        block_size: usize,
        groups: usize,
        expected_ids: Vec<Vec<u32>>,
    ) {
        let expected = gen_ids(expected_ids);
        let fixtures = fixture_list(count);
        let mut state = FixtureSelection::new(fixtures);
        state.block_size = Some(block_size);
        state.groups = Some(groups);

        let mut result = state.get_fixtures();

        reorder_ids(&mut result);
        assert_eq!(expected, result);
    }

    #[test_case(8, 2, 2, vec![vec![1, 3, 6, 8], vec![2, 4, 5, 7]])]
    #[test_case(10, 2, 2, vec![vec![1, 3, 5, 6, 8, 10], vec![2, 4, 7, 9]])]
    #[ignore]
    fn get_fixtures_should_group_by_wings_and_groups(
        count: usize,
        wings: usize,
        groups: usize,
        expected_ids: Vec<Vec<u32>>,
    ) {
        let expected = gen_ids(expected_ids);
        let fixtures = fixture_list(count);
        let mut state = FixtureSelection::new(fixtures);
        state.wings = Some(wings);
        state.groups = Some(groups);

        let mut result = state.get_fixtures();

        reorder_ids(&mut result);
        assert_eq!(expected, result);
    }

    fn fixture_list(count: usize) -> Vec<FixtureId> {
        vec![1; count]
            .into_iter()
            .enumerate()
            .map(|(i, _)| FixtureId::Fixture(i as u32 + 1))
            .collect()
    }

    fn gen_ids(ids: Vec<Vec<u32>>) -> Vec<Vec<FixtureId>> {
        ids.into_iter()
            .map(|chunk| chunk.into_iter().map(FixtureId::Fixture).collect())
            .collect()
    }

    fn reorder_ids(fixtures: &mut Vec<Vec<FixtureId>>) {
        for ids in fixtures.iter_mut() {
            ids.sort();
        }
    }
}
