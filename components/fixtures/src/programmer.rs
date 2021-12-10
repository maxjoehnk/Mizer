use std::collections::HashMap;
use std::sync::Arc;

use dashmap::{DashMap};

use crate::fixture::{Fixture, IFixtureMut};
use crate::definition::FixtureControl;
use crate::FixtureId;

#[derive(Debug)]
pub struct Programmer {
    pub highlight: bool,
    selected_fixtures: HashMap<FixtureId, FixtureProgrammer>,
    fixtures: Arc<DashMap<u32, Fixture>>,
}

#[derive(Debug, Default)]
pub struct FixtureProgrammer {
    controls: HashMap<FixtureControl, f64>,
}

#[derive(Debug)]
pub struct ProgrammerChannel {
    pub fixtures: Vec<FixtureId>,
    pub control: FixtureControl,
    pub value: f64,
}

impl Programmer {
    pub fn new(fixtures: Arc<DashMap<u32, Fixture>>) -> Self {
        Self {
            fixtures,
            highlight: false,
            selected_fixtures: Default::default(),
        }
    }

    pub fn run(&self) {
        log::trace!("Programmer::run");
        for (fixture_id, state) in self.selected_fixtures.iter() {
            log::trace!("{:?} => {:?}", fixture_id, state);
            match fixture_id {
                FixtureId::Fixture(fixture_id) => {
                    if let Some(mut fixture) = self.fixtures.get_mut(fixture_id) {
                        for (control, value) in state.controls.iter() {
                            fixture.write_control(control.clone(), *value);
                        }
                        if self.highlight {
                            fixture.highlight();
                        }
                    }
                }
                FixtureId::SubFixture(fixture_id, sub_fixture_id) => {
                    if let Some(mut fixture) = self.fixtures.get_mut(fixture_id) {
                        if let Some(mut sub_fixture) = fixture.sub_fixture_mut(*sub_fixture_id) {
                            for (control, value) in state.controls.iter() {
                                sub_fixture.write_control(control.clone(), *value);
                            }
                            if self.highlight {
                                sub_fixture.highlight();
                            }
                        }
                    }
                }
            }
        }
    }

    pub fn clear(&mut self) {
        for (_, state) in self.selected_fixtures.iter_mut() {
            state.controls.clear();
        }
    }

    pub fn select_fixtures(&mut self, fixtures: Vec<FixtureId>) {
        let selected_fixtures = self.selected_fixtures.keys().copied().collect::<Vec<_>>();
        for id in selected_fixtures {
            if !fixtures.contains(&id) {
                self.selected_fixtures.remove(&id);
            }
        }
        for id in fixtures {
            self.selected_fixtures.entry(id).or_default();
        }
    }

    pub fn write_control(&mut self, control: FixtureControl, value: f64) {
        for (_, programmer) in self.selected_fixtures.iter_mut() {
            programmer.controls.insert(control.clone(), value);
        }
    }

    pub fn get_controls(&self) -> Vec<ProgrammerChannel> {
        let mut controls: HashMap<FixtureControl, (Vec<FixtureId>, f64)> = HashMap::new();
        for (fixture_id, state) in self.selected_fixtures.iter() {
            for (control, value) in state.controls.iter() {
                let entry = controls
                    .entry(control.clone())
                    .or_insert((Vec::new(), *value));
                if entry.1 == *value {
                    entry.0.push(*fixture_id);
                } else {
                    controls.insert(control.clone(), (vec![*fixture_id], *value));
                }
            }
        }
        controls
            .into_iter()
            .map(|(control, (fixtures, value))| ProgrammerChannel {
                value,
                control,
                fixtures,
            })
            .collect()
    }
}
