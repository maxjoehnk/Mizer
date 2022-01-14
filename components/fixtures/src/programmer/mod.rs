use std::collections::HashMap;
use std::sync::Arc;

use dashmap::DashMap;
use postage::prelude::Sink;
use postage::watch;
use pinboard::NonEmptyPinboard;

use futures::stream::Stream;

use crate::definition::{ColorChannel, ColorGroup, FixtureControl, FixtureControlValue, FixtureFaderControl};
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
    programmer_view: Arc<NonEmptyPinboard<ProgrammerState>>,
}

#[derive(Debug, Clone, Default)]
pub struct ProgrammerState {
    pub fixtures: Vec<FixtureId>,
    pub highlight: bool,
    pub channels: Vec<ProgrammerChannel>,
}

#[derive(Debug, Default)]
pub struct FixtureProgrammer {
    intensity: Option<f64>,
    shutter: Option<f64>,
    color: Option<ColorGroup<f64>>,
    pan: Option<f64>,
    tilt: Option<f64>,
    focus: Option<f64>,
    zoom: Option<f64>,
    prism: Option<f64>,
    iris: Option<f64>,
    frost: Option<f64>,
    generic: HashMap<String, f64>,
}

impl FixtureProgrammer {
    fn clear(&mut self) {
        *self = Default::default();
    }

    fn controls(&self) -> impl Iterator<Item = FixtureControlValue> + '_ {
        let intensity = self.intensity.iter().map(|value| FixtureControlValue::Intensity(*value));
        let shutter = self.shutter.iter().map(|value| FixtureControlValue::Shutter(*value));
        let color = self.color.iter().map(|value| FixtureControlValue::Color(value.red, value. green, value.blue));
        let pan = self.pan.iter().map(|value| FixtureControlValue::Pan(*value));
        let tilt = self.tilt.iter().map(|value| FixtureControlValue::Tilt(*value));
        let focus = self.focus.iter().map(|value| FixtureControlValue::Focus(*value));
        let zoom = self.zoom.iter().map(|value| FixtureControlValue::Zoom(*value));
        let prism = self.prism.iter().map(|value| FixtureControlValue::Prism(*value));
        let iris = self.iris.iter().map(|value| FixtureControlValue::Iris(*value));
        let frost = self.frost.iter().map(|value| FixtureControlValue::Frost(*value));
        let generic = self.generic.iter().map(|(key, value)| FixtureControlValue::Generic(key.clone(), *value));

        intensity
            .chain(shutter)
            .chain(color)
            .chain(pan)
            .chain(tilt)
            .chain(focus)
            .chain(zoom)
            .chain(prism)
            .chain(iris)
            .chain(frost)
            .chain(generic)
    }

    fn fader_controls(&self) -> impl Iterator<Item = (FixtureFaderControl, f64)> + '_ {
        let intensity = self.intensity.iter().map(|value| (FixtureFaderControl::Intensity, *value));
        let shutter = self.shutter.iter().map(|value| (FixtureFaderControl::Shutter, *value));
        let color = self.color.iter().flat_map(|value| vec![
            (FixtureFaderControl::Color(ColorChannel::Red), value.red),
            (FixtureFaderControl::Color(ColorChannel::Green), value.green),
            (FixtureFaderControl::Color(ColorChannel::Blue), value.blue),
        ]);
        let pan = self.pan.iter().map(|value| (FixtureFaderControl::Pan, *value));
        let tilt = self.tilt.iter().map(|value| (FixtureFaderControl::Tilt, *value));
        let focus = self.focus.iter().map(|value| (FixtureFaderControl::Focus, *value));
        let zoom = self.zoom.iter().map(|value| (FixtureFaderControl::Zoom, *value));
        let prism = self.prism.iter().map(|value| (FixtureFaderControl::Prism, *value));
        let iris = self.iris.iter().map(|value| (FixtureFaderControl::Iris, *value));
        let frost = self.frost.iter().map(|value| (FixtureFaderControl::Frost, *value));
        let generic = self.generic.iter().map(|(key, value)| (FixtureFaderControl::Generic(key.clone()), *value));

        intensity
            .chain(shutter)
            .chain(color)
            .chain(pan)
            .chain(tilt)
            .chain(focus)
            .chain(zoom)
            .chain(prism)
            .chain(iris)
            .chain(frost)
            .chain(generic)
    }
}

#[derive(Debug, Clone)]
pub struct ProgrammerChannel {
    pub fixtures: Vec<FixtureId>,
    pub value: FixtureControlValue,
}

#[derive(Debug)]
pub struct ProgrammerControl {
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
            programmer_view: Arc::new(NonEmptyPinboard::new(Default::default()))
        }
    }

    pub fn run(&self) {
        log::trace!("Programmer::run");
        for (fixture_id, state) in self.selected_fixtures.iter() {
            log::trace!("{:?} => {:?}", fixture_id, state);
            match fixture_id {
                FixtureId::Fixture(fixture_id) => {
                    if let Some(mut fixture) = self.fixtures.get_mut(fixture_id) {
                        for (control, value) in state.fader_controls() {
                            fixture.write_control(control.clone(), value);
                        }
                        if self.highlight {
                            fixture.highlight();
                        }
                    }
                }
                FixtureId::SubFixture(fixture_id, sub_fixture_id) => {
                    if let Some(mut fixture) = self.fixtures.get_mut(fixture_id) {
                        if let Some(mut sub_fixture) = fixture.sub_fixture_mut(*sub_fixture_id) {
                            for (control, value) in state.fader_controls() {
                                sub_fixture.write_control(control.clone(), value);
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
            state.clear();
        }
        self.emit_state();
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

    pub fn write_control(&mut self, value: FixtureControlValue) {
        for (_, programmer) in self.selected_fixtures.iter_mut() {
            match value {
                FixtureControlValue::Intensity(value) => programmer.intensity = Some(value),
                FixtureControlValue::Shutter(value) => programmer.shutter = Some(value),
                FixtureControlValue::Color(red, green, blue) => programmer.color = Some(ColorGroup {
                    red,
                    green,
                    blue
                }),
                FixtureControlValue::Pan(value) => programmer.pan = Some(value),
                FixtureControlValue::Tilt(value) => programmer.tilt = Some(value),
                FixtureControlValue::Focus(value) => programmer.focus = Some(value),
                FixtureControlValue::Zoom(value) => programmer.zoom = Some(value),
                FixtureControlValue::Prism(value) => programmer.prism = Some(value),
                FixtureControlValue::Iris(value) => programmer.iris = Some(value),
                FixtureControlValue::Frost(value) => programmer.frost = Some(value),
                FixtureControlValue::Generic(ref name, value) => {
                    programmer.generic.insert(name.clone(), value);
                },
            }
        }
        self.emit_state();
    }

    pub fn store_highlight(&mut self, highlight: bool) {
        self.highlight = highlight;
        self.emit_state();
    }

    pub fn get_controls(&self) -> Vec<ProgrammerControl> {
        let mut controls: HashMap<FixtureFaderControl, (Vec<FixtureId>, f64)> = HashMap::new();
        for (fixture_id, state) in self.selected_fixtures.iter() {
            for (control, value) in state.fader_controls() {
                let entry = controls
                    .entry(control.clone())
                    .or_insert((Vec::new(), value));
                if (entry.1 - value).abs() < f64::EPSILON {
                    entry.0.push(*fixture_id);
                } else {
                    controls.insert(control.clone(), (vec![*fixture_id], value));
                }
            }
        }
        controls
            .into_iter()
            .map(|(control, (fixtures, value))| ProgrammerControl {
                value,
                control,
                fixtures,
            })
            .collect()
    }

    fn get_channels(&self) -> Vec<ProgrammerChannel> {
        let mut controls: HashMap<FixtureControl, (Vec<FixtureId>, FixtureControlValue)> = HashMap::new();
        for (fixture_id, state) in self.selected_fixtures.iter() {
            for value in state.controls() {
                let entry = controls
                    .entry(value.clone().into())
                    .or_insert((Vec::new(), value.clone()));
                if entry.1 == value {
                    entry.0.push(*fixture_id);
                } else {
                    controls.insert(value.clone().into(), (vec![*fixture_id], value));
                }
            }
        }
        controls
            .into_iter()
            .map(|(_, (fixtures, value))| ProgrammerChannel {
                value,
                fixtures,
            })
            .collect()
    }

    pub fn bus(&self) -> impl Stream<Item = ProgrammerState> {
        self.message_subscriber.clone()
    }

    pub fn view(&self) -> ProgrammerView {
        ProgrammerView(self.programmer_view.clone())
    }

    fn emit_state(&mut self) {
        let state = ProgrammerState {
            fixtures: self.selected_fixtures.keys().copied().collect(),
            highlight: self.highlight,
            channels: self.get_channels(),
        };
        println!("{:?}", state);
        self.programmer_view.set(state.clone());
        log::trace!("sending programmer msg");
        if let Err(err) = self.message_bus.try_send(state) {
            log::error!("Error sending programmer msg {:?}", err);
        }
    }
}

#[derive(Clone)]
pub struct ProgrammerView(Arc<NonEmptyPinboard<ProgrammerState>>);

impl ProgrammerView {
    pub fn read(&self) -> ProgrammerState {
        self.0.read()
    }
}
