use std::collections::HashMap;
use std::hash::{Hash, Hasher};
use std::sync::Arc;

use futures::stream::Stream;
use indexmap::{IndexMap, IndexSet};
use pinboard::NonEmptyPinboard;
use postage::prelude::Sink;
use postage::watch;
use serde::{Deserialize, Serialize};

pub use groups::*;
pub use presets::*;

use crate::contracts::FixtureController;
use crate::definition::{ColorChannel, FixtureControl, FixtureControlValue, FixtureFaderControl};
use crate::{FixtureId, RgbColor};

mod default_presets;
mod groups;
mod presets;

pub struct Programmer {
    highlight: bool,
    selected_fixtures: IndexMap<FixtureId, FixtureProgrammer>,
    active_fixtures: IndexSet<FixtureId>,
    running_effects: IndexSet<ProgrammedEffect>,
    message_bus: watch::Sender<ProgrammerState>,
    message_subscriber: watch::Receiver<ProgrammerState>,
    programmer_view: Arc<NonEmptyPinboard<ProgrammerState>>,
    has_written_to_selection: bool,
}

#[derive(Debug, Clone, Hash, PartialEq, Eq, Deserialize, Serialize)]
pub struct ProgrammedEffect {
    pub effect_id: u32,
    pub fixtures: Vec<FixtureId>,
}

#[derive(Debug, Clone, Default)]
pub struct ProgrammerState {
    pub active_fixtures: Vec<FixtureId>,
    pub tracked_fixtures: Vec<FixtureId>,
    pub fixture_effects: Vec<FixtureId>,
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
    color_mixer: Option<RgbColor>,
    color_wheel: Option<f64>,
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
        let color_mixer = self
            .color_mixer
            .iter()
            .map(|value| FixtureControlValue::ColorMixer(value.red, value.green, value.blue));
        let color_wheel = self
            .color_wheel
            .iter()
            .map(|value| FixtureControlValue::ColorWheel(*value));
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
            .chain(color_mixer)
            .chain(color_wheel)
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
        let color_mixer = self.color_mixer.iter().flat_map(|value| {
            vec![
                (
                    FixtureFaderControl::ColorMixer(ColorChannel::Red),
                    value.red,
                ),
                (
                    FixtureFaderControl::ColorMixer(ColorChannel::Green),
                    value.green,
                ),
                (
                    FixtureFaderControl::ColorMixer(ColorChannel::Blue),
                    value.blue,
                ),
            ]
        });
        let color_wheel = self
            .color_wheel
            .iter()
            .map(|value| (FixtureFaderControl::ColorWheel, *value));
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
            .chain(color_mixer)
            .chain(color_wheel)
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

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ProgrammerControl {
    pub fixtures: Vec<FixtureId>,
    pub control: FixtureFaderControl,
    pub value: f64,
}

impl Hash for ProgrammerControl {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.fixtures.hash(state);
        self.control.hash(state);
        self.value.to_bits().hash(state);
    }
}

impl Default for Programmer {
    fn default() -> Self {
        let (tx, rx) = watch::channel();
        Self {
            highlight: false,
            selected_fixtures: Default::default(),
            active_fixtures: Default::default(),
            running_effects: Default::default(),
            message_bus: tx,
            message_subscriber: rx,
            programmer_view: Arc::new(NonEmptyPinboard::new(Default::default())),
            has_written_to_selection: false,
        }
    }
}

impl Programmer {
    pub fn new() -> Self {
        Self::default()
    }

    pub(crate) fn run(&self, fixture_controller: &impl FixtureController) {
        profiling::scope!("Programmer::run");
        log::trace!("Programmer::run");
        for (fixture_id, state) in self.selected_fixtures.iter() {
            log::trace!("{:?} => {:?}", fixture_id, state);
            for (control, value) in state.fader_controls() {
                fixture_controller.write(*fixture_id, control.clone(), value);
            }
        }
        if self.highlight {
            for fixture_id in self.active_fixtures.iter() {
                fixture_controller.highlight(*fixture_id);
            }
        }
    }

    pub fn clear(&mut self) {
        if !self.active_fixtures.is_empty() {
            self.active_fixtures.clear();
        } else {
            self.selected_fixtures.clear();
            self.running_effects.clear();
        }
        self.emit_state();
    }

    #[tracing::instrument(skip(self))]
    pub fn select_fixtures(&mut self, fixtures: Vec<FixtureId>) {
        tracing::trace!("select_fixtures");
        if self.has_written_to_selection {
            self.active_fixtures.clear();
            self.has_written_to_selection = false;
        }
        for fixture in fixtures {
            self.active_fixtures.insert(fixture);
        }
        self.emit_state();
    }

    #[tracing::instrument(skip(self))]
    pub fn unselect_fixtures(&mut self, fixtures: Vec<FixtureId>) {
        tracing::trace!("unselect_fixtures");
        for fixture in fixtures {
            self.active_fixtures.remove(&fixture);
            self.selected_fixtures.remove(&fixture);
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
            .all(|id| self.active_fixtures.contains(id) || self.selected_fixtures.contains_key(id))
    }

    pub fn call_preset(&mut self, presets: &Presets, preset_id: PresetId) {
        let values = presets.get_preset_values(preset_id);
        for value in values {
            self.write_control(value);
        }
    }

    pub fn call_effect(&mut self, effect_id: u32) {
        let fixtures = self.active_fixtures.iter().copied().collect();
        self.running_effects.insert(ProgrammedEffect {
            effect_id,
            fixtures,
        });
    }

    pub fn write_control(&mut self, value: FixtureControlValue) {
        for fixture_id in self.active_fixtures.iter() {
            let programmer = self.selected_fixtures.entry(*fixture_id).or_default();
            match value {
                FixtureControlValue::Intensity(value) => programmer.intensity = Some(value),
                FixtureControlValue::Shutter(value) => programmer.shutter = Some(value),
                FixtureControlValue::ColorMixer(red, green, blue) => {
                    programmer.color_mixer = Some(RgbColor { red, green, blue })
                }
                FixtureControlValue::ColorWheel(value) => programmer.color_wheel = Some(value),
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
            fixture_effects: self
                .running_effects
                .iter()
                .flat_map(|e| e.fixtures.clone())
                .collect(),
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

    pub fn active_fixtures(&self) -> Vec<FixtureId> {
        self.active_fixtures.iter().copied().collect()
    }

    pub fn active_effects(&self) -> impl Iterator<Item = &ProgrammedEffect> {
        self.running_effects.iter()
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
    use mockall::predicate;
    use spectral::prelude::*;
    use test_case::test_case;

    use crate::contracts::*;
    use crate::definition::{FixtureControlValue, FixtureFaderControl};
    use crate::programmer::Programmer;
    use crate::FixtureId;

    #[test]
    fn selecting_fixtures_should_select_fixtures() {
        let mut programmer = Programmer::new();
        let fixtures = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];

        programmer.select_fixtures(fixtures.clone());

        let state = programmer.view().read();
        assert_that!(state.active_fixtures).is_equal_to(fixtures);
    }

    #[test]
    fn selecting_fixtures_in_multiple_steps_should_combine_selections() {
        let mut programmer = Programmer::new();
        let expected = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];

        programmer.select_fixtures(vec![FixtureId::Fixture(1)]);
        programmer.select_fixtures(vec![FixtureId::Fixture(2)]);

        let state = programmer.view().read();
        assert_that!(state.active_fixtures).is_equal_to(expected);
    }

    #[test]
    fn writing_controls_should_set_values_for_selection() {
        let mut programmer = Programmer::new();
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
        let mut programmer = Programmer::new();
        let selection = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];
        programmer.select_fixtures(selection.clone());
        let value = FixtureControlValue::Intensity(1.);

        programmer.write_control(value);

        let state = programmer.view().read();
        assert_that!(state.tracked_fixtures).is_equal_to(&selection);
    }

    #[test]
    fn selecting_fixtures_after_writing_controls_should_track_previous_selection() {
        let mut programmer = Programmer::new();
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
        let mut programmer = Programmer::new();
        let fixtures = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];
        programmer.select_fixtures(fixtures);

        programmer.clear();

        let state = programmer.view().read();
        assert_that!(state.active_fixtures).is_empty();
    }

    #[test]
    fn clearing_after_writing_should_clear_only_active_selection() {
        let mut programmer = Programmer::new();
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
        let mut programmer = Programmer::new();
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
        let mut programmer = Programmer::new();
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
        let mut programmer = Programmer::new();
        let fixtures = vec![FixtureId::Fixture(1)];

        programmer.select_fixtures(fixtures.clone());
        programmer.select_fixtures(fixtures.clone());

        let state = programmer.view().read();
        assert_that!(state.active_fixtures).is_equal_to(&fixtures);
    }

    #[test]
    fn get_controls_should_return_written_values() {
        let mut programmer = Programmer::new();
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
        let mut programmer = Programmer::new();
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

    #[test_case(vec![FixtureId::Fixture(1)])]
    #[test_case(vec![FixtureId::Fixture(1), FixtureId::Fixture(2)])]
    #[test_case(vec![FixtureId::SubFixture(1, 2)])]
    fn run_should_highlight_selected_fixtures(fixtures: Vec<FixtureId>) {
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        for fixture_id in &fixtures {
            fixture_controller
                .expect_highlight()
                .with(predicate::eq(*fixture_id))
                .once()
                .return_const(());
        }
        programmer.select_fixtures(fixtures);
        programmer.set_highlight(true);

        programmer.run(&fixture_controller);

        fixture_controller.checkpoint();
    }

    #[test]
    fn run_should_not_highlight_selected_fixtures() {
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        programmer.select_fixtures(vec![FixtureId::Fixture(1)]);
        programmer.set_highlight(false);
        fixture_controller
            .expect_highlight()
            .never()
            .with(predicate::eq(FixtureId::Fixture(1)))
            .return_const(());

        programmer.run(&fixture_controller);

        fixture_controller.checkpoint();
    }

    #[test]
    fn run_should_not_highlight_fixtures_after_clear() {
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        programmer.select_fixtures(vec![FixtureId::Fixture(1)]);
        programmer.set_highlight(true);
        programmer.clear();
        fixture_controller
            .expect_highlight()
            .never()
            .with(predicate::eq(FixtureId::Fixture(1)))
            .return_const(());

        programmer.run(&fixture_controller);

        fixture_controller.checkpoint();
    }

    #[test]
    fn run_should_not_highlight_fixtures_after_store() {
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        programmer.select_fixtures(vec![FixtureId::Fixture(1)]);
        programmer.set_highlight(true);
        programmer.write_control(FixtureControlValue::Intensity(1.));
        programmer.select_fixtures(vec![]);
        fixture_controller
            .expect_highlight()
            .never()
            .return_const(());
        fixture_controller.expect_write().return_const(());

        programmer.run(&fixture_controller);

        fixture_controller.checkpoint();
    }

    #[test_case(FixtureControlValue::Intensity(1.), FixtureFaderControl::Intensity, 1.)]
    #[test_case(FixtureControlValue::Shutter(0.5), FixtureFaderControl::Shutter, 0.5)]
    fn run_should_write_to_fixture(
        control: FixtureControlValue,
        fader: FixtureFaderControl,
        value: f64,
    ) {
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        programmer.select_fixtures(vec![FixtureId::Fixture(1)]);
        programmer.write_control(control);
        expect_write(&mut fixture_controller, FixtureId::Fixture(1), fader, value);

        programmer.run(&fixture_controller);

        fixture_controller.checkpoint();
    }

    #[test_case(vec![FixtureId::Fixture(1)])]
    #[test_case(vec![FixtureId::Fixture(1), FixtureId::Fixture(2)])]
    #[test_case(vec![FixtureId::SubFixture(1, 2)])]
    fn run_should_write_to_multiple_fixtures(fixtures: Vec<FixtureId>) {
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        for fixture_id in &fixtures {
            expect_write(
                &mut fixture_controller,
                *fixture_id,
                FixtureFaderControl::Intensity,
                1.,
            );
        }
        programmer.select_fixtures(fixtures);
        programmer.write_control(FixtureControlValue::Intensity(1.));

        programmer.run(&fixture_controller);

        fixture_controller.checkpoint();
    }

    #[test_case(vec![
        (FixtureControlValue::Intensity(1.), FixtureFaderControl::Intensity, 1.),
        (FixtureControlValue::Shutter(0.5), FixtureFaderControl::Shutter, 0.5)
    ])]
    #[test_case(vec![
        (FixtureControlValue::Pan(0.), FixtureFaderControl::Pan, 0.),
        (FixtureControlValue::Tilt(0.25), FixtureFaderControl::Tilt, 0.25),
    ])]
    fn run_should_write_multiple_controls_to_fixture(
        controls: Vec<(FixtureControlValue, FixtureFaderControl, f64)>,
    ) {
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        programmer.select_fixtures(vec![FixtureId::Fixture(1)]);
        for (control, fader, value) in controls {
            programmer.write_control(control);
            expect_write(&mut fixture_controller, FixtureId::Fixture(1), fader, value);
        }

        programmer.run(&fixture_controller);

        fixture_controller.checkpoint();
    }

    #[test]
    fn run_should_combine_multiple_fixture_and_control_values() {
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        programmer.select_fixtures(vec![FixtureId::Fixture(1), FixtureId::Fixture(2)]);
        programmer.write_control(FixtureControlValue::Intensity(1.));
        programmer.select_fixtures(vec![FixtureId::Fixture(2), FixtureId::Fixture(3)]);
        programmer.write_control(FixtureControlValue::Intensity(0.5));
        expect_write(
            &mut fixture_controller,
            FixtureId::Fixture(1),
            FixtureFaderControl::Intensity,
            1.,
        );
        expect_write(
            &mut fixture_controller,
            FixtureId::Fixture(2),
            FixtureFaderControl::Intensity,
            0.5,
        );
        expect_write(
            &mut fixture_controller,
            FixtureId::Fixture(3),
            FixtureFaderControl::Intensity,
            0.5,
        );

        programmer.run(&fixture_controller);

        fixture_controller.checkpoint();
    }

    fn expect_write(
        fixture_controller: &mut MockFixtureController,
        fixture_id: FixtureId,
        control: FixtureFaderControl,
        value: f64,
    ) {
        fixture_controller
            .expect_write()
            .with(
                predicate::eq(fixture_id),
                predicate::eq(control),
                predicate::eq(value),
            )
            .return_const(());
    }
}
