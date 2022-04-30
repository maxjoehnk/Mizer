use std::collections::HashMap;
use std::sync::Arc;

use dashmap::DashMap;
use pinboard::NonEmptyPinboard;
use postage::prelude::Sink;
use postage::watch;

use futures::stream::Stream;
use indexmap::{IndexMap, IndexSet};

use crate::definition::{
    ColorChannel, ColorGroup, FixtureControl, FixtureControlValue, FixtureFaderControl,
};
use crate::fixture::{Fixture, IFixtureMut};
use crate::FixtureId;

pub use groups::*;
pub use presets::*;

mod default_presets;
mod groups;
mod presets;

pub struct Programmer {
    highlight: bool,
    selected_fixtures: IndexMap<FixtureId, FixtureProgrammer>,
    active_fixtures: IndexSet<FixtureId>,
    fixtures: Arc<DashMap<u32, Fixture>>,
    message_bus: watch::Sender<ProgrammerState>,
    message_subscriber: watch::Receiver<ProgrammerState>,
    programmer_view: Arc<NonEmptyPinboard<ProgrammerState>>,
    has_written_to_selection: bool,
}

#[derive(Debug, Clone, Default)]
pub struct ProgrammerState {
    pub active_fixtures: Vec<FixtureId>,
    pub tracked_fixtures: Vec<FixtureId>,
    pub highlight: bool,
    pub channels: Vec<ProgrammerChannel>,
}

impl ProgrammerState {
    pub fn all_fixtures(&self) -> Vec<FixtureId> {
        self.active_fixtures
            .iter()
            .chain(self.tracked_fixtures.iter())
            .copied()
            .collect::<IndexSet<_>>()
            .into_iter()
            .collect()
    }
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
    gobo: Option<f64>,
    generic: HashMap<String, f64>,
}

impl FixtureProgrammer {
    fn controls(&self) -> impl Iterator<Item = FixtureControlValue> + '_ {
        let intensity = self
            .intensity
            .iter()
            .map(|value| FixtureControlValue::Intensity(*value));
        let shutter = self
            .shutter
            .iter()
            .map(|value| FixtureControlValue::Shutter(*value));
        let color = self
            .color
            .iter()
            .map(|value| FixtureControlValue::Color(value.red, value.green, value.blue));
        let pan = self
            .pan
            .iter()
            .map(|value| FixtureControlValue::Pan(*value));
        let tilt = self
            .tilt
            .iter()
            .map(|value| FixtureControlValue::Tilt(*value));
        let focus = self
            .focus
            .iter()
            .map(|value| FixtureControlValue::Focus(*value));
        let zoom = self
            .zoom
            .iter()
            .map(|value| FixtureControlValue::Zoom(*value));
        let prism = self
            .prism
            .iter()
            .map(|value| FixtureControlValue::Prism(*value));
        let iris = self
            .iris
            .iter()
            .map(|value| FixtureControlValue::Iris(*value));
        let frost = self
            .frost
            .iter()
            .map(|value| FixtureControlValue::Frost(*value));
        let gobo = self
            .gobo
            .iter()
            .map(|value| FixtureControlValue::Gobo(*value));
        let generic = self
            .generic
            .iter()
            .map(|(key, value)| FixtureControlValue::Generic(key.clone(), *value));

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
            .chain(gobo)
            .chain(generic)
    }

    fn fader_controls(&self) -> impl Iterator<Item = (FixtureFaderControl, f64)> + '_ {
        let intensity = self
            .intensity
            .iter()
            .map(|value| (FixtureFaderControl::Intensity, *value));
        let shutter = self
            .shutter
            .iter()
            .map(|value| (FixtureFaderControl::Shutter, *value));
        let color = self.color.iter().flat_map(|value| {
            vec![
                (FixtureFaderControl::Color(ColorChannel::Red), value.red),
                (FixtureFaderControl::Color(ColorChannel::Green), value.green),
                (FixtureFaderControl::Color(ColorChannel::Blue), value.blue),
            ]
        });
        let pan = self
            .pan
            .iter()
            .map(|value| (FixtureFaderControl::Pan, *value));
        let tilt = self
            .tilt
            .iter()
            .map(|value| (FixtureFaderControl::Tilt, *value));
        let focus = self
            .focus
            .iter()
            .map(|value| (FixtureFaderControl::Focus, *value));
        let zoom = self
            .zoom
            .iter()
            .map(|value| (FixtureFaderControl::Zoom, *value));
        let prism = self
            .prism
            .iter()
            .map(|value| (FixtureFaderControl::Prism, *value));
        let iris = self
            .iris
            .iter()
            .map(|value| (FixtureFaderControl::Iris, *value));
        let frost = self
            .frost
            .iter()
            .map(|value| (FixtureFaderControl::Frost, *value));
        let gobo = self
            .gobo
            .iter()
            .map(|value| (FixtureFaderControl::Gobo, *value));
        let generic = self
            .generic
            .iter()
            .map(|(key, value)| (FixtureFaderControl::Generic(key.clone()), *value));

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
            .chain(gobo)
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
            active_fixtures: Default::default(),
            message_bus: tx,
            message_subscriber: rx,
            programmer_view: Arc::new(NonEmptyPinboard::new(Default::default())),
            has_written_to_selection: false,
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
                    }
                }
                FixtureId::SubFixture(fixture_id, sub_fixture_id) => {
                    if let Some(mut fixture) = self.fixtures.get_mut(fixture_id) {
                        if let Some(mut sub_fixture) = fixture.sub_fixture_mut(*sub_fixture_id) {
                            for (control, value) in state.fader_controls() {
                                sub_fixture.write_control(control.clone(), value);
                            }
                        }
                    }
                }
            }
        }
        if self.highlight {
            for fixture_id in self.active_fixtures.iter() {
                match fixture_id {
                    FixtureId::Fixture(fixture_id) => {
                        if let Some(mut fixture) = self.fixtures.get_mut(fixture_id) {
                            fixture.highlight();
                        }
                    }
                    FixtureId::SubFixture(fixture_id, sub_fixture_id) => {
                        if let Some(mut fixture) = self.fixtures.get_mut(fixture_id) {
                            if let Some(mut sub_fixture) = fixture.sub_fixture_mut(*sub_fixture_id)
                            {
                                sub_fixture.highlight();
                            }
                        }
                    }
                }
            }
        }
    }

    pub fn clear(&mut self) {
        if !self.active_fixtures.is_empty() {
            self.active_fixtures.clear();
        } else {
            self.selected_fixtures.clear();
        }
        self.emit_state();
    }

    pub fn select_fixtures(&mut self, fixtures: Vec<FixtureId>) {
        if self.has_written_to_selection {
            self.active_fixtures.clear();
            self.has_written_to_selection = false;
        }
        for fixture in fixtures {
            self.active_fixtures.insert(fixture);
        }
        self.emit_state();
    }

    pub fn select_group(&mut self, group: &Group) {
        self.select_fixtures(group.fixtures.clone());
    }

    pub fn is_group_active(&self, group: &Group) -> bool {
        group
            .fixtures
            .iter()
            .all(|id| self.selected_fixtures.contains_key(id))
    }

    pub fn call_preset(&mut self, presets: &Presets, preset_id: PresetId) {
        let values = presets.get_preset_values(preset_id);
        for value in values {
            self.write_control(value);
        }
    }

    pub fn write_control(&mut self, value: FixtureControlValue) {
        for fixture_id in self.active_fixtures.iter() {
            let programmer = self.selected_fixtures.entry(*fixture_id).or_default();
            match value {
                FixtureControlValue::Intensity(value) => programmer.intensity = Some(value),
                FixtureControlValue::Shutter(value) => programmer.shutter = Some(value),
                FixtureControlValue::Color(red, green, blue) => {
                    programmer.color = Some(ColorGroup { red, green, blue })
                }
                FixtureControlValue::Pan(value) => programmer.pan = Some(value),
                FixtureControlValue::Tilt(value) => programmer.tilt = Some(value),
                FixtureControlValue::Focus(value) => programmer.focus = Some(value),
                FixtureControlValue::Zoom(value) => programmer.zoom = Some(value),
                FixtureControlValue::Prism(value) => programmer.prism = Some(value),
                FixtureControlValue::Iris(value) => programmer.iris = Some(value),
                FixtureControlValue::Frost(value) => programmer.frost = Some(value),
                FixtureControlValue::Gobo(value) => programmer.gobo = Some(value),
                FixtureControlValue::Generic(ref name, value) => {
                    programmer.generic.insert(name.clone(), value);
                }
            }
        }
        self.has_written_to_selection = true;
        self.emit_state();
    }

    pub fn set_highlight(&mut self, highlight: bool) {
        self.highlight = highlight;
        self.emit_state();
    }

    pub fn get_controls(&self) -> Vec<ProgrammerControl> {
        let mut controls: HashMap<FixtureFaderControl, Vec<(Vec<FixtureId>, f64)>> = HashMap::new();
        for (fixture_id, state) in self.selected_fixtures.iter() {
            for (control, value) in state.fader_controls() {
                let values = controls.entry(control.clone()).or_default();
                if let Some((fixtures, _)) = values
                    .iter_mut()
                    .find(|(_, v)| (value - v).abs() < f64::EPSILON)
                {
                    fixtures.push(*fixture_id)
                } else {
                    values.push((vec![*fixture_id], value));
                }
            }
        }
        controls
            .into_iter()
            .flat_map(|(control, fixtures)| {
                fixtures
                    .into_iter()
                    .map(move |(fixtures, value)| ProgrammerControl {
                        control: control.clone(),
                        fixtures,
                        value,
                    })
            })
            .collect()
    }

    fn get_channels(&self) -> Vec<ProgrammerChannel> {
        let mut controls: HashMap<FixtureControl, Vec<(Vec<FixtureId>, FixtureControlValue)>> =
            HashMap::new();
        for (fixture_id, state) in self.selected_fixtures.iter() {
            for value in state.controls() {
                let values = controls.entry(value.clone().into()).or_default();
                if let Some((fixtures, _)) = values.iter_mut().find(|(_, v)| &value == v) {
                    fixtures.push(*fixture_id)
                } else {
                    values.push((vec![*fixture_id], value));
                }
            }
        }
        controls
            .into_iter()
            .flat_map(|(_, fixtures)| {
                fixtures
                    .into_iter()
                    .map(|(fixtures, value)| ProgrammerChannel { fixtures, value })
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
            tracked_fixtures: self.selected_fixtures.keys().copied().collect(),
            active_fixtures: self.active_fixtures.iter().copied().collect(),
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

trait OptionExt<T> {
    fn keep_or_replace(&mut self, value: Option<T>);
}

impl<T> OptionExt<T> for Option<T> {
    fn keep_or_replace(&mut self, value: Option<T>) {
        if let Some(value) = value {
            *self = Some(value);
        }
    }
}

#[cfg(test)]
mod tests {
    use crate::definition::{FixtureControlValue, FixtureFaderControl};
    use crate::programmer::Programmer;
    use crate::FixtureId;
    use dashmap::DashMap;
    use spectral::prelude::*;
    use std::sync::Arc;

    #[test]
    fn selecting_fixtures_should_select_fixtures() {
        let fixtures = Arc::new(DashMap::new());
        let mut programmer = Programmer::new(fixtures);
        let fixtures = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];

        programmer.select_fixtures(fixtures.clone());

        let state = programmer.view().read();
        assert_that!(state.active_fixtures).is_equal_to(fixtures);
    }

    #[test]
    fn selecting_fixtures_in_multiple_steps_should_combine_selections() {
        let fixtures = Arc::new(DashMap::new());
        let mut programmer = Programmer::new(fixtures);
        let expected = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];

        programmer.select_fixtures(vec![FixtureId::Fixture(1)]);
        programmer.select_fixtures(vec![FixtureId::Fixture(2)]);

        let state = programmer.view().read();
        assert_that!(state.active_fixtures).is_equal_to(expected);
    }

    #[test]
    fn writing_controls_should_set_values_for_selection() {
        let fixtures = Arc::new(DashMap::new());
        let mut programmer = Programmer::new(fixtures);
        let selection = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];
        programmer.select_fixtures(selection.clone());
        let value = FixtureControlValue::Intensity(1.);

        programmer.write_control(value.clone());

        let state = programmer.view().read();
        let channel = &state.channels[0];
        assert_that!(channel.fixtures.iter()).contains_all_of(&selection.iter());
        assert_that!(channel.value).is_equal_to(value);
    }

    #[test]
    fn writing_controls_should_track_selection() {
        let fixtures = Arc::new(DashMap::new());
        let mut programmer = Programmer::new(fixtures);
        let selection = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];
        programmer.select_fixtures(selection.clone());
        let value = FixtureControlValue::Intensity(1.);

        programmer.write_control(value);

        let state = programmer.view().read();
        assert_that!(state.tracked_fixtures).is_equal_to(&selection);
    }

    #[test]
    fn selecting_fixtures_after_writing_controls_should_track_previous_selection() {
        let fixtures = Arc::new(DashMap::new());
        let mut programmer = Programmer::new(fixtures);
        let first_selection = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];
        let second_selection = vec![FixtureId::Fixture(3), FixtureId::Fixture(4)];
        programmer.select_fixtures(first_selection.clone());
        let value = FixtureControlValue::Intensity(1.);
        programmer.write_control(value.clone());

        programmer.select_fixtures(second_selection.clone());

        let state = programmer.view().read();
        assert_that!(state.active_fixtures).is_equal_to(&second_selection);
        assert_that!(state.tracked_fixtures).is_equal_to(&first_selection);
        let tracked_channel = &state.channels[0];
        assert_that!(tracked_channel.fixtures).is_equal_to(&first_selection);
        assert_that!(tracked_channel.value).is_equal_to(value);
    }

    #[test]
    fn clearing_fresh_selection_should_clear_active_fixtures() {
        let fixtures = Arc::new(DashMap::new());
        let mut programmer = Programmer::new(fixtures);
        let fixtures = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];
        programmer.select_fixtures(fixtures);

        programmer.clear();

        let state = programmer.view().read();
        assert_that!(state.active_fixtures).is_empty();
    }

    #[test]
    fn clearing_after_writing_should_clear_only_active_selection() {
        let fixtures = Arc::new(DashMap::new());
        let mut programmer = Programmer::new(fixtures);
        let selection = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];
        programmer.select_fixtures(selection.clone());
        let value = FixtureControlValue::Intensity(1.);
        programmer.write_control(value.clone());

        programmer.clear();

        let state = programmer.view().read();
        assert_that!(state.tracked_fixtures).is_equal_to(&selection);
        assert_that!(state.active_fixtures).is_empty();
        let channel = &state.channels[0];
        assert_that!(channel.fixtures).is_equal_to(&selection);
        assert_that!(channel.value).is_equal_to(value);
    }

    #[test]
    fn clearing_twice_after_writing_should_clear_active_and_tracked_selection() {
        let fixtures = Arc::new(DashMap::new());
        let mut programmer = Programmer::new(fixtures);
        programmer.select_fixtures(vec![FixtureId::Fixture(1), FixtureId::Fixture(2)]);
        programmer.write_control(FixtureControlValue::Intensity(1.));

        programmer.clear();
        programmer.clear();

        let state = programmer.view().read();
        assert_that!(state.tracked_fixtures).is_empty();
        assert_that!(state.active_fixtures).is_empty();
        assert_that!(state.channels).is_empty();
    }

    #[test]
    fn writing_two_active_selection_should_keep_tracked_values() {
        let fixtures = Arc::new(DashMap::new());
        let mut programmer = Programmer::new(fixtures);
        let first_fixtures = vec![FixtureId::Fixture(1)];
        let first_value = FixtureControlValue::Intensity(1.);
        let second_fixtures = vec![FixtureId::Fixture(2)];
        let second_value = FixtureControlValue::Intensity(0.5);
        programmer.select_fixtures(first_fixtures.clone());
        programmer.write_control(first_value.clone());

        programmer.select_fixtures(second_fixtures.clone());
        programmer.write_control(second_value.clone());

        let state = programmer.view().read();
        assert_that!(state.tracked_fixtures)
            .is_equal_to(&vec![FixtureId::Fixture(1), FixtureId::Fixture(2)]);
        assert_that!(state.channels).has_length(2);
        let first_channel = &state.channels[0];
        assert_that!(first_channel.value).is_equal_to(&first_value);
        assert_that!(first_channel.fixtures).is_equal_to(&first_fixtures);
        let second_channel = &state.channels[1];
        assert_that!(second_channel.value).is_equal_to(&second_value);
        assert_that!(second_channel.fixtures).is_equal_to(&second_fixtures);
    }

    #[test]
    fn selecting_same_fixture_twice_should_only_keep_one_id() {
        let fixtures = Arc::new(DashMap::new());
        let mut programmer = Programmer::new(fixtures);
        let fixtures = vec![FixtureId::Fixture(1)];

        programmer.select_fixtures(fixtures.clone());
        programmer.select_fixtures(fixtures.clone());

        let state = programmer.view().read();
        assert_that!(state.active_fixtures).is_equal_to(&fixtures);
    }

    #[test]
    fn get_controls_should_return_written_values() {
        let fixtures = Arc::new(DashMap::new());
        let mut programmer = Programmer::new(fixtures);
        let selection = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];
        programmer.select_fixtures(selection.clone());
        let value = FixtureControlValue::Intensity(1.);
        programmer.write_control(value);

        let result = programmer.get_controls();

        assert_that!(result).has_length(1);
        let control = &result[0];
        assert_that!(control.fixtures).is_equal_to(&selection);
        assert_that!(control.value).is_equal_to(1.);
        assert_that!(control.control).is_equal_to(FixtureFaderControl::Intensity);
    }

    #[test]
    fn get_controls_should_return_writing_two_active_selection() {
        let fixtures = Arc::new(DashMap::new());
        let mut programmer = Programmer::new(fixtures);
        let first_fixtures = vec![FixtureId::Fixture(1)];
        let first_value = FixtureControlValue::Intensity(1.);
        let second_fixtures = vec![FixtureId::Fixture(2)];
        let second_value = FixtureControlValue::Intensity(0.5);
        programmer.select_fixtures(first_fixtures.clone());
        programmer.write_control(first_value);
        programmer.select_fixtures(second_fixtures.clone());
        programmer.write_control(second_value);

        let result = programmer.get_controls();

        assert_that!(result).has_length(2);
        let first_control = &result[0];
        assert_that!(first_control.fixtures).is_equal_to(&first_fixtures);
        assert_that!(first_control.value).is_equal_to(1.);
        assert_that!(first_control.control).is_equal_to(FixtureFaderControl::Intensity);
        let second_control = &result[1];
        assert_that!(second_control.fixtures).is_equal_to(&second_fixtures);
        assert_that!(second_control.value).is_equal_to(0.5);
        assert_that!(second_control.control).is_equal_to(FixtureFaderControl::Intensity);
    }
}
