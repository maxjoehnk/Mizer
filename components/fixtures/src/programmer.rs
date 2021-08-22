use std::collections::HashMap;
use std::sync::Arc;

use dashmap::{DashMap, Map};

use crate::fixture::{Fixture, FixtureChannelGroupType};

#[derive(Debug)]
pub struct Programmer {
    pub highlight: bool,
    selected_fixtures: HashMap<u32, FixtureProgrammer>,
    fixtures: Arc<DashMap<u32, Fixture>>,
}

#[derive(Debug, Default)]
pub struct FixtureProgrammer {
    channels: HashMap<String, f64>,
}

#[derive(Debug, Default)]
pub struct ProgrammerChannel {
    pub fixtures: Vec<u32>,
    pub channel: String,
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
                for (channel, value) in state.channels.iter() {
                    fixture.write(channel, *value);
                }
                if self.highlight {
                    fixture.highlight();
                }
            }
        }
    }

    pub fn clear(&mut self) {
        for (_, state) in self.selected_fixtures.iter_mut() {
            state.channels.clear();
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

    pub fn write_channels(&mut self, channel: String, value: FixtureValue) {
        for (fixture_id, programmer) in self.selected_fixtures.iter_mut() {
            if let Some(fixture) = self.fixtures._get_mut(fixture_id) {
                match &value {
                    FixtureValue::Color(r, g, b) => {
                        if let Some(color_group) = fixture
                            .current_mode
                            .groups
                            .iter()
                            .find(|g| g.name == channel)
                        {
                            if let FixtureChannelGroupType::Color(color_group) =
                                color_group.group_type.clone()
                            {
                                programmer.channels.insert(color_group.red.clone(), *r);
                                programmer.channels.insert(color_group.green.clone(), *g);
                                programmer.channels.insert(color_group.blue.clone(), *b);
                            }
                        }
                    }
                    FixtureValue::Fader(value) => {
                        programmer.channels.insert(channel.clone(), *value);
                    }
                }
            }
        }
    }

    pub fn get_channels(&self) -> Vec<ProgrammerChannel> {
        let mut channels: HashMap<String, (Vec<u32>, f64)> = HashMap::new();
        for (fixture_id, state) in self.selected_fixtures.iter() {
            for (channel, value) in state.channels.iter() {
                let entry = channels
                    .entry(channel.clone())
                    .or_insert((Vec::new(), *value));
                if entry.1 == *value {
                    entry.0.push(*fixture_id);
                } else {
                    channels.insert(channel.clone(), (vec![*fixture_id], *value));
                }
            }
        }
        channels
            .into_iter()
            .map(|(channel, (fixtures, value))| ProgrammerChannel {
                value,
                channel,
                fixtures,
            })
            .collect()
    }
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum FixtureValue {
    Fader(f64),
    Color(f64, f64, f64),
}
