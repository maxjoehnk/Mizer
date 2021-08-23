use std::collections::HashMap;
use std::sync::Arc;

use dashmap::{DashMap};

use crate::fixture::{Fixture, FixtureControl};

#[derive(Debug)]
pub struct Programmer {
    pub highlight: bool,
    selected_fixtures: HashMap<u32, FixtureProgrammer>,
    fixtures: Arc<DashMap<u32, Fixture>>,
}

#[derive(Debug, Default)]
pub struct FixtureProgrammer {
    controls: HashMap<FixtureControl, f64>,
}

#[derive(Debug)]
pub struct ProgrammerChannel {
    pub fixtures: Vec<u32>,
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
            log::trace!("{} => {:?}", fixture_id, state);
            if let Some(mut fixture) = self.fixtures.get_mut(fixture_id) {
                for (control, value) in state.controls.iter() {
                    fixture.write_control(control.clone(), *value);
                }
                if self.highlight {
                    fixture.highlight();
                }
            }
        }
    }

    pub fn clear(&mut self) {
        for (_, state) in self.selected_fixtures.iter_mut() {
            state.controls.clear();
        }
    }

    pub fn select_fixtures(&mut self, fixtures: Vec<u32>) {
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
        let mut controls: HashMap<FixtureControl, (Vec<u32>, f64)> = HashMap::new();
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
