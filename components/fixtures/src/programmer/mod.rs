use std::collections::HashMap;
use std::sync::Arc;

use dashmap::DashMap;
use postage::prelude::Sink;
use postage::watch;

use futures::stream::Stream;

use crate::definition::FixtureFaderControl;
use crate::fixture::{Fixture, IFixtureMut};
use crate::FixtureId;

pub use groups::*;
pub use presets::*;

mod presets;
mod groups;
mod default_presets;

pub struct Programmer {
    highlight: bool,
    selected_fixtures: HashMap<FixtureId, FixtureProgrammer>,
    fixtures: Arc<DashMap<u32, Fixture>>,
    message_bus: watch::Sender<ProgrammerState>,
    message_subscriber: watch::Receiver<ProgrammerState>,
}

#[derive(Debug, Clone, Default)]
pub struct ProgrammerState {
    pub fixtures: Vec<FixtureId>,
    pub highlight: bool,
}

#[derive(Debug, Default)]
pub struct FixtureProgrammer {
    controls: HashMap<FixtureFaderControl, f64>,
}

#[derive(Debug)]
pub struct ProgrammerChannel {
    pub fixtures: Vec<FixtureId>,
    pub control: FixtureFaderControl,
    pub value: f64,
}

impl Programmer {
    pub fn new(fixtures: Arc<DashMap<u32, Fixture>>) -> Self {
        let (tx, rx) = watch::channel();
        Self {
            fixtures,
            highlight: false,
            selected_fixtures: Default::default(),
            message_bus: tx,
            message_subscriber: rx,
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
        self.emit_state();
    }

    pub fn write_control(&mut self, control: FixtureFaderControl, value: f64) {
        for (_, programmer) in self.selected_fixtures.iter_mut() {
            programmer.controls.insert(control.clone(), value);
        }
        self.emit_state();
    }

    pub fn store_highlight(&mut self, highlight: bool) {
        self.highlight = highlight;
        self.emit_state();
    }

    pub fn get_controls(&self) -> Vec<ProgrammerChannel> {
        let mut controls: HashMap<FixtureFaderControl, (Vec<FixtureId>, f64)> = HashMap::new();
        for (fixture_id, state) in self.selected_fixtures.iter() {
            for (control, value) in state.controls.iter() {
                let entry = controls
                    .entry(control.clone())
                    .or_insert((Vec::new(), *value));
                if (entry.1 - *value).abs() < f64::EPSILON {
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

    pub fn bus(&self) -> impl Stream<Item = ProgrammerState> {
        self.message_subscriber.clone()
    }

    fn emit_state(&mut self) {
        let state = ProgrammerState {
            fixtures: self.selected_fixtures.keys().copied().collect(),
            highlight: self.highlight,
        };
        log::trace!("sending programmer msg");
        if let Err(err) = self.message_bus.try_send(state) {
            log::error!("Error sending programmer msg {:?}", err);
        }
    }
}
