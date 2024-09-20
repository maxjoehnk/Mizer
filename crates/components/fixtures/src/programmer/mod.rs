use std::collections::HashMap;
use std::hash::{Hash, Hasher};
use std::ops::Deref;
use std::sync::Arc;

use futures::stream::Stream;
use indexmap::IndexSet;
use pinboard::NonEmptyPinboard;
use postage::prelude::Sink;
use postage::watch;
use serde::{Deserialize, Serialize};

pub use groups::*;
pub use presets::*;

use crate::channels::{FixtureChannel, FixtureChannelValue, FixtureColorChannel, FixtureValue};
use crate::contracts::FixtureController;
use crate::selection::FixtureSelection;
use crate::{FixtureId, GroupId};

mod default_presets;
mod groups;
mod presets;

pub struct Programmer {
    highlight: bool,
    offline: bool,
    active_selection: FixtureSelection,
    active_channels: FixtureProgrammer,
    running_effects: Vec<ProgrammedEffect>,
    tracked_selections: Vec<(FixtureSelection, FixtureProgrammer)>,
    message_bus: watch::Sender<ProgrammerState>,
    message_subscriber: watch::Receiver<ProgrammerState>,
    programmer_view: Arc<NonEmptyPinboard<ProgrammerState>>,
    has_written_to_selection: bool,
    x: Option<usize>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ProgrammedEffect {
    pub effect_id: u32,
    pub fixtures: FixtureSelection,
    pub rate: f64,
    pub offset: Option<f64>,
}

impl Hash for ProgrammedEffect {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.effect_id.hash(state);
        self.fixtures.hash(state);
    }
}

impl PartialEq for ProgrammedEffect {
    fn eq(&self, other: &Self) -> bool {
        self.effect_id == other.effect_id && self.fixtures == other.fixtures
    }
}

impl Eq for ProgrammedEffect {}

#[derive(Debug, Clone, Deserialize, Serialize, Eq, PartialEq, Hash)]
pub struct ProgrammedPreset {
    pub preset_id: PresetId,
    pub fixtures: FixtureSelection,
}

#[derive(Debug, Clone, Default)]
pub struct ProgrammerState {
    pub selection: Vec<Vec<FixtureId>>,
    pub active_fixtures: Vec<FixtureId>,
    pub tracked_fixtures: Vec<FixtureId>,
    pub fixture_effects: Vec<FixtureId>,
    pub active_groups: Vec<GroupId>,
    pub highlight: bool,
    pub offline: bool,
    pub channels: Vec<ProgrammerChannel>,
    pub selection_block_size: Option<usize>,
    pub selection_wings: Option<usize>,
    pub selection_groups: Option<usize>,
    pub effects: Vec<ProgrammedEffect>,
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

#[derive(Clone, Debug, Default)]
pub struct FixtureProgrammer {
    channels: HashMap<FixtureChannel, FixtureValue>,
    presets: Vec<PresetId>,
}

impl FixtureProgrammer {
    fn clear(&mut self) {
        *self = Default::default();
    }
}

#[derive(Debug, Clone)]
pub struct ProgrammerChannel {
    pub fixtures: Vec<FixtureId>,
    pub value: ProgrammerControlValue,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum ProgrammerControlValue {
    Control(FixtureChannelValue),
    Preset(PresetId),
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ProgrammerControl {
    pub fixtures: FixtureSelection,
    pub channel: FixtureChannel,
    pub value: FixtureValue,
}

impl Default for Programmer {
    fn default() -> Self {
        let (tx, rx) = watch::channel();
        Self {
            active_selection: Default::default(),
            active_channels: Default::default(),
            offline: false,
            highlight: false,
            running_effects: Default::default(),
            tracked_selections: Default::default(),
            message_bus: tx,
            message_subscriber: rx,
            programmer_view: Arc::new(NonEmptyPinboard::new(Default::default())),
            has_written_to_selection: false,
            x: None,
        }
    }
}

impl Programmer {
    pub fn new() -> Self {
        Self::default()
    }

    pub(crate) fn run(&self, fixture_controller: &impl FixtureController, presets: &Presets) {
        profiling::scope!("Programmer::run");
        tracing::trace!("Programmer::run");
        if self.offline {
            return;
        }
        let mut values = HashMap::new();
        for (selection, state) in self.get_selections().into_iter() {
            tracing::trace!("{:?} => {:?}", selection, state);
            for fixture_id in selection.get_fixtures().iter().flatten() {
                for (control, value) in &state.channels {
                    values.insert((*fixture_id, *control), *value);
                }
                for preset in &state.presets {
                    let preset_values = presets
                        .get_preset_values(*preset)
                        .into_iter()
                        .flat_map(|control| control.into_channel_values());
                    for value in preset_values {
                        values.insert((*fixture_id, value.channel), value.value);
                    }
                }
            }
        }
        for ((fixture_id, control), value) in values {
            fixture_controller.write(fixture_id, control, value);
        }
        if self.highlight {
            if let Some(x) = self.x {
                if let Some(fixtures) = self.active_selection.get_fixtures().get(x) {
                    for fixture_id in fixtures {
                        fixture_controller.highlight(*fixture_id);
                    }
                }
            } else {
                for fixture_id in self.active_selection.get_fixtures().iter().flatten() {
                    fixture_controller.highlight(*fixture_id);
                }
            }
        }
    }

    pub fn active_selection(&self) -> FixtureSelection {
        self.active_selection.clone()
    }

    pub fn clear(&mut self) {
        if !self.active_selection.is_empty() {
            if self.has_written_to_selection {
                self.tracked_selections
                    .push((self.active_selection.clone(), self.active_channels.clone()));
            }
            self.active_selection.clear();
            self.active_channels.clear();
        } else {
            self.tracked_selections.clear();
            self.running_effects.clear();
            self.active_selection.clear();
            self.active_channels.clear();
            self.active_selection.groups = None;
            self.active_selection.block_size = None;
            self.active_selection.wings = None;
            self.set();
        }
    }

    #[tracing::instrument(skip(self))]
    pub fn select_fixtures(&mut self, fixtures: Vec<FixtureId>) {
        tracing::trace!("select_fixtures");
        if self.has_written_to_selection {
            self.has_written_to_selection = false;
            self.tracked_selections
                .push((self.active_selection.clone(), self.active_channels.clone()));
            self.active_selection.clear();
            self.active_channels.clear();
        }
        self.active_selection.add_fixtures(fixtures);
    }

    #[tracing::instrument(skip(self))]
    pub fn unselect_fixtures(&mut self, fixtures: Vec<FixtureId>) {
        tracing::trace!("unselect_fixtures");
        for fixture in fixtures {
            self.active_selection.remove(&fixture);
        }
    }

    pub fn set_block_size(&mut self, block_size: usize) {
        self.active_selection.block_size = if block_size == 0 {
            None
        } else {
            Some(block_size)
        };
        self.clamp_x();
    }

    pub fn set_groups(&mut self, groups: usize) {
        self.active_selection.groups = if groups == 0 { None } else { Some(groups) };
        self.clamp_x();
    }

    pub fn set_wings(&mut self, wings: usize) {
        self.active_selection.wings = if wings == 0 { None } else { Some(wings) };
        self.clamp_x();
    }

    pub fn set_offline(&mut self, offline: bool) {
        self.offline = offline;
    }

    pub fn next(&mut self) {
        if self.x.is_none() {
            self.x = Some(0);
            return;
        }
        let x = self.x.unwrap_or_default();
        let mut x = x.saturating_add(1);
        if x >= self.active_selection.get_fixtures().len() {
            x = 0;
        }
        self.x = Some(x);
    }

    pub fn prev(&mut self) {
        if self.x.is_none() {
            self.x = Some(self.active_selection.get_fixtures().len().saturating_sub(1));
            return;
        }
        let x = self.x.unwrap_or_default();
        let (mut x, overflow) = x.overflowing_sub(1);
        if overflow {
            x = self.active_selection.get_fixtures().len().saturating_sub(1);
        }
        self.x = Some(x);
    }

    fn clamp_x(&mut self) {
        if let Some(x) = self.x {
            self.x = Some(x.clamp(
                0,
                self.active_selection.get_fixtures().len().saturating_sub(1),
            ));
        }
    }

    pub fn set(&mut self) {
        self.x = None;
    }

    pub fn shuffle(&mut self) {
        self.active_selection.shuffle();
    }

    pub fn select_group(&mut self, group: &Group) {
        self.active_selection = group.selection.deref().clone();
    }

    // TODO: this should probably only be true when only the group is selected
    // This requires tracking of the active group
    pub fn is_group_active(&self, group: &Group) -> bool {
        group.fixtures().into_iter().flatten().all(|id| {
            self.get_selections()
                .iter()
                .any(|(selection, _)| selection.contains(&id))
        })
    }

    pub fn call_preset(&mut self, preset_id: PresetId) {
        self.active_channels
            .presets
            .retain(|id| id.preset_type() != preset_id.preset_type());
        self.active_channels.presets.push(preset_id);
        self.has_written_to_selection = true;
    }

    pub fn call_effect(&mut self, effect_id: u32) {
        self.running_effects.push(ProgrammedEffect {
            effect_id,
            fixtures: self.active_selection.clone(),
            rate: 1f64,
            offset: None,
        });
    }

    pub fn write_rate(&mut self, effect_id: u32, effect_rate: f64) {
        if let Some(effect) = self
            .running_effects
            .iter_mut()
            .find(|e| e.effect_id == effect_id)
        {
            effect.rate = effect_rate;
        }
    }

    pub fn write_offset(&mut self, effect_id: u32, effect_offset: Option<f64>) {
        if let Some(effect) = self
            .running_effects
            .iter_mut()
            .find(|e| e.effect_id == effect_id)
        {
            effect.offset = effect_offset;
        }
    }

    pub fn write_control(&mut self, channel: FixtureChannel, value: FixtureValue) {
        let programmer = &mut self.active_channels;
        programmer.channels.insert(channel, value);
        self.has_written_to_selection = true;
    }

    pub fn set_highlight(&mut self, highlight: bool) {
        self.highlight = highlight;
    }

    pub fn get_controls(&self) -> Vec<ProgrammerControl> {
        self.get_selections()
            .iter()
            .flat_map(|(fixtures, channels)| {
                channels
                    .channels
                    .iter()
                    .map(|(channel, value)| ProgrammerControl {
                        fixtures: fixtures.clone(),
                        channel: *channel,
                        value: *value,
                    })
                    .collect::<Vec<_>>()
            })
            .collect()
    }

    pub fn get_channels(&self) -> Vec<ProgrammerChannel> {
        let mut controls: HashMap<FixtureChannel, Vec<(Vec<FixtureId>, ProgrammerControlValue)>> =
            HashMap::new();
        let selections = self.get_selections();
        for (selection, state) in selections.iter() {
            let values = state
                .presets
                .iter()
                .map(|preset_id| ProgrammerControlValue::Preset(*preset_id))
                .chain(state.channels.iter().map(|(channel, value)| (*channel, *value)).map(|value| ProgrammerControlValue::Control(value.into())));
            for value in values {
                let channel = match value {
                    ProgrammerControlValue::Control(channel) => channel.channel,
                    ProgrammerControlValue::Preset(PresetId::Intensity(_)) => FixtureChannel::Intensity,
                    ProgrammerControlValue::Preset(PresetId::Shutter(_)) => FixtureChannel::Shutter(1),
                    ProgrammerControlValue::Preset(PresetId::Color(_)) => FixtureChannel::ColorMixer(FixtureColorChannel::Red),
                    ProgrammerControlValue::Preset(PresetId::Position(_)) => FixtureChannel::Pan,
                };
                let values = controls.entry(channel).or_default();
                if let Some((fixtures, _)) = values.iter_mut().find(|(_, v)| &value == v) {
                    for fixture_id in selection.get_fixtures().iter().flatten() {
                        fixtures.push(*fixture_id)
                    }
                } else {
                    let selection = selection.get_fixtures().iter().flatten().copied().collect();
                    values.push((selection, value));
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

    fn get_selections(&self) -> Vec<(FixtureSelection, FixtureProgrammer)> {
        let mut selections = self.tracked_selections.clone();
        selections.push((self.active_selection.clone(), self.active_channels.clone()));

        selections
    }

    fn get_tracked_selections(&self) -> Vec<(FixtureSelection, FixtureProgrammer)> {
        if self.has_written_to_selection {
            self.get_selections()
        } else {
            self.tracked_selections.clone()
        }
    }

    pub fn bus(&self) -> impl Stream<Item = ProgrammerState> {
        self.message_subscriber.clone()
    }

    pub fn view(&self) -> ProgrammerView {
        ProgrammerView(self.programmer_view.clone())
    }

    pub(crate) fn emit_state<'a>(&mut self, groups: Vec<impl Deref<Target = Group> + 'a>) {
        profiling::scope!("Programmer::emit_state");
        let state = ProgrammerState {
            tracked_fixtures: self
                .get_tracked_selections()
                .iter()
                .flat_map(|(selection, _)| selection.get_fixtures())
                .flatten()
                .collect(),
            selection: self.active_selection.get_fixtures(),
            active_fixtures: self
                .active_selection
                .get_fixtures()
                .into_iter()
                .flatten()
                .collect(),
            active_groups: groups
                .iter()
                .filter(|g| self.is_group_active(g))
                .map(|g| g.id)
                .collect(),
            fixture_effects: self
                .running_effects
                .iter()
                .flat_map(|e| {
                    e.fixtures
                        .get_fixtures()
                        .iter()
                        .flatten()
                        .copied()
                        .collect::<Vec<_>>()
                })
                .collect(),
            highlight: self.highlight,
            offline: self.offline,
            channels: self.get_channels(),
            selection_block_size: self.active_selection.block_size,
            selection_groups: self.active_selection.groups,
            selection_wings: self.active_selection.wings,
            effects: self.running_effects.clone(),
        };
        self.programmer_view.set(state.clone());
        tracing::trace!("sending programmer msg");
        if let Err(err) = self.message_bus.try_send(state) {
            tracing::error!("Error sending programmer msg {:?}", err);
        }
    }

    pub fn active_effects(&self) -> impl Iterator<Item = &ProgrammedEffect> {
        self.running_effects.iter()
    }

    pub fn active_presets(&self) -> Vec<ProgrammedPreset> {
        self.active_channels
            .presets
            .iter()
            .map(|preset_id| ProgrammedPreset {
                preset_id: *preset_id,
                fixtures: self.active_selection.clone(),
            })
            .chain(
                self.tracked_selections
                    .iter()
                    .flat_map(|(selection, programmer)| {
                        programmer.presets.iter().map(|preset_id| ProgrammedPreset {
                            preset_id: *preset_id,
                            fixtures: selection.clone(),
                        })
                    }),
            )
            .collect()
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
    use crate::channels::{FixtureChannel, FixtureChannelValue, FixtureValue};
    use crate::contracts::*;
    use crate::programmer::{Group, Presets, Programmer, ProgrammerControlValue, ProgrammerState};
    use crate::selection::FixtureSelection;
    use crate::FixtureId;
    use mockall::predicate;
    use spectral::prelude::*;
    use test_case::test_case;

    #[test]
    fn selecting_fixtures_should_select_fixtures() {
        let mut programmer = Programmer::new();
        let fixtures = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];

        programmer.select_fixtures(fixtures.clone());

        let state = get_state(&mut programmer);
        assert_that!(state.active_fixtures).is_equal_to(fixtures);
    }

    #[test]
    fn selecting_fixtures_in_multiple_steps_should_combine_selections() {
        let mut programmer = Programmer::new();
        let expected = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];

        programmer.select_fixtures(vec![FixtureId::Fixture(1)]);
        programmer.select_fixtures(vec![FixtureId::Fixture(2)]);

        let state = get_state(&mut programmer);
        assert_that!(state.active_fixtures).is_equal_to(expected);
    }

    #[test]
    fn writing_controls_should_set_values_for_selection() {
        let mut programmer = Programmer::new();
        let selection = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];
        programmer.select_fixtures(selection.clone());
        let value = FixtureChannelValue::new(FixtureChannel::Intensity, FixtureValue::Percent(1.0));

        programmer.write_control(value.channel, value.value);

        let value = ProgrammerControlValue::Control(value);
        let state = get_state(&mut programmer);
        let channel = &state.channels[0];
        assert_that!(channel.fixtures.iter()).contains_all_of(&selection.iter());
        assert_that!(channel.value).is_equal_to(value);
    }

    #[test]
    fn writing_controls_should_track_selection() {
        let mut programmer = Programmer::new();
        let selection = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];
        programmer.select_fixtures(selection.clone());
        let value = FixtureChannelValue::new(FixtureChannel::Intensity, FixtureValue::Percent(1.0));

        programmer.write_control(value.channel, value.value);

        let state = get_state(&mut programmer);
        assert_that!(state.tracked_fixtures).is_equal_to(&selection);
    }

    #[test]
    fn selecting_fixtures_after_writing_controls_should_track_previous_selection() {
        let mut programmer = Programmer::new();
        let first_selection = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];
        let second_selection = vec![FixtureId::Fixture(3), FixtureId::Fixture(4)];
        programmer.select_fixtures(first_selection.clone());
        let value = FixtureChannelValue::new(FixtureChannel::Intensity, FixtureValue::Percent(1.0));
        programmer.write_control(value.channel, value.value);

        programmer.select_fixtures(second_selection.clone());

        let value = ProgrammerControlValue::Control(value);
        let state = get_state(&mut programmer);
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

        let state = get_state(&mut programmer);
        assert_that!(state.active_fixtures).is_empty();
    }

    #[test]
    fn clearing_after_writing_should_clear_only_active_selection() {
        let mut programmer = Programmer::new();
        let selection = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];
        programmer.select_fixtures(selection.clone());
        let value = FixtureChannelValue::new(FixtureChannel::Intensity, FixtureValue::Percent(1.0));
        programmer.write_control(value.channel, value.value);

        programmer.clear();

        let value = ProgrammerControlValue::Control(value);
        let state = get_state(&mut programmer);
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
        let value = FixtureChannelValue::new(FixtureChannel::Intensity, FixtureValue::Percent(1.0));

        programmer.clear();
        programmer.clear();

        let state = get_state(&mut programmer);
        assert_that!(state.tracked_fixtures).is_empty();
        assert_that!(state.active_fixtures).is_empty();
        assert_that!(state.channels).is_empty();
    }

    #[test]
    fn writing_two_active_selection_should_keep_tracked_values() {
        let mut programmer = Programmer::new();
        let first_fixtures = vec![FixtureId::Fixture(1)];
        let first_value =
            FixtureChannelValue::new(FixtureChannel::Intensity, FixtureValue::Percent(1.0));
        let second_fixtures = vec![FixtureId::Fixture(2)];
        let second_value =
            FixtureChannelValue::new(FixtureChannel::Intensity, FixtureValue::Percent(0.5));
        programmer.select_fixtures(first_fixtures.clone());
        programmer.write_control(first_value.channel, first_value.value);

        programmer.select_fixtures(second_fixtures.clone());
        programmer.write_control(second_value.channel, second_value.value);

        let state = get_state(&mut programmer);
        assert_that!(state.tracked_fixtures)
            .is_equal_to(&vec![FixtureId::Fixture(1), FixtureId::Fixture(2)]);
        assert_that!(state.channels).has_length(2);
        let first_channel = &state.channels[0];
        assert_that!(first_channel.value)
            .is_equal_to(&ProgrammerControlValue::Control(first_value));
        assert_that!(first_channel.fixtures).is_equal_to(&first_fixtures);
        let second_channel = &state.channels[1];
        assert_that!(second_channel.value)
            .is_equal_to(&ProgrammerControlValue::Control(second_value));
        assert_that!(second_channel.fixtures).is_equal_to(&second_fixtures);
    }

    #[test]
    fn selecting_same_fixture_twice_should_only_keep_one_id() {
        let mut programmer = Programmer::new();
        let fixtures = vec![FixtureId::Fixture(1)];

        programmer.select_fixtures(fixtures.clone());
        programmer.select_fixtures(fixtures.clone());

        let state = get_state(&mut programmer);
        assert_that!(state.active_fixtures).is_equal_to(&fixtures);
    }

    #[test]
    fn get_controls_should_return_written_values() {
        let mut programmer = Programmer::new();
        let selection = vec![FixtureId::Fixture(1), FixtureId::Fixture(2)];
        programmer.select_fixtures(selection.clone());
        let value = FixtureChannelValue::new(FixtureChannel::Intensity, FixtureValue::Percent(1.0));
        programmer.write_control(value.channel, value.value);

        let result = programmer.get_controls();

        assert_that!(result).has_length(1);
        let control = &result[0];
        assert_that!(control.fixtures).is_equal_to(&FixtureSelection::new(selection));
        assert_that!(control.value).is_equal_to(value.value);
        assert_that!(control.channel).is_equal_to(value.channel);
    }

    #[test]
    fn get_controls_should_return_writing_two_active_selection() {
        let mut programmer = Programmer::new();
        let first_fixtures = vec![FixtureId::Fixture(1)];
        let first_value =
            FixtureChannelValue::new(FixtureChannel::Intensity, FixtureValue::Percent(1.0));
        let second_fixtures = vec![FixtureId::Fixture(2)];
        let second_value =
            FixtureChannelValue::new(FixtureChannel::Intensity, FixtureValue::Percent(0.5));
        programmer.select_fixtures(first_fixtures.clone());
        programmer.write_control(first_value.channel, first_value.value);
        programmer.select_fixtures(second_fixtures.clone());
        programmer.write_control(second_value.channel, second_value.value);

        let result = programmer.get_controls();

        assert_that!(result).has_length(2);
        let first_control = &result[0];
        assert_that!(first_control.fixtures).is_equal_to(&FixtureSelection::new(first_fixtures));
        assert_that!(first_control.value).is_equal_to(FixtureValue::Percent(1.));
        assert_that!(first_control.channel).is_equal_to(FixtureChannel::Intensity);
        let second_control = &result[1];
        assert_that!(second_control.fixtures).is_equal_to(&FixtureSelection::new(second_fixtures));
        assert_that!(second_control.value).is_equal_to(FixtureValue::Percent(0.5));
        assert_that!(second_control.channel).is_equal_to(FixtureChannel::Intensity);
    }

    #[test_case(vec![FixtureId::Fixture(1)])]
    #[test_case(vec![FixtureId::Fixture(1), FixtureId::Fixture(2)])]
    #[test_case(vec![FixtureId::SubFixture(1, 2)])]
    fn run_should_highlight_selected_fixtures(fixtures: Vec<FixtureId>) {
        let presets = Presets::default();
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

        programmer.run(&fixture_controller, &presets);

        fixture_controller.checkpoint();
    }

    #[test]
    fn run_should_not_highlight_selected_fixtures() {
        let presets = Presets::default();
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        programmer.select_fixtures(vec![FixtureId::Fixture(1)]);
        programmer.set_highlight(false);
        fixture_controller
            .expect_highlight()
            .never()
            .with(predicate::eq(FixtureId::Fixture(1)))
            .return_const(());

        programmer.run(&fixture_controller, &presets);

        fixture_controller.checkpoint();
    }

    #[test]
    fn run_should_not_highlight_fixtures_after_clear() {
        let presets = Presets::default();
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

        programmer.run(&fixture_controller, &presets);

        fixture_controller.checkpoint();
    }

    #[test]
    fn run_should_not_highlight_fixtures_after_store() {
        let presets = Presets::default();
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        programmer.select_fixtures(vec![FixtureId::Fixture(1)]);
        programmer.set_highlight(true);
        programmer.write_control(FixtureChannel::Intensity, FixtureValue::Percent(1.));
        programmer.select_fixtures(vec![]);
        fixture_controller
            .expect_highlight()
            .never()
            .return_const(());
        fixture_controller.expect_write().return_const(());

        programmer.run(&fixture_controller, &presets);

        fixture_controller.checkpoint();
    }

    #[test_case(FixtureChannel::Intensity, 1.)]
    #[test_case(FixtureChannel::Shutter, 0.5)]
    fn run_should_write_to_fixture(channel: FixtureChannel, value: f64) {
        let value = FixtureValue::Percent(value);
        let presets = Presets::default();
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        programmer.select_fixtures(vec![FixtureId::Fixture(1)]);
        programmer.write_control(channel, value);
        expect_write(
            &mut fixture_controller,
            FixtureId::Fixture(1),
            channel,
            value,
        );

        programmer.run(&fixture_controller, &presets);

        fixture_controller.checkpoint();
    }

    #[test_case(vec![FixtureId::Fixture(1)])]
    #[test_case(vec![FixtureId::Fixture(1), FixtureId::Fixture(2)])]
    #[test_case(vec![FixtureId::SubFixture(1, 2)])]
    fn run_should_write_to_multiple_fixtures(fixtures: Vec<FixtureId>) {
        let presets = Presets::default();
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        for fixture_id in &fixtures {
            expect_write(
                &mut fixture_controller,
                *fixture_id,
                FixtureChannel::Intensity,
                FixtureValue::Percent(1.),
            );
        }
        programmer.select_fixtures(fixtures);
        programmer.write_control(FixtureChannel::Intensity, FixtureValue::Percent(1.));

        programmer.run(&fixture_controller, &presets);

        fixture_controller.checkpoint();
    }

    #[test_case(vec![
        (FixtureChannel::Intensity, 1.),
        (FixtureChannel::Shutter, 0.5)
    ])]
    #[test_case(vec![
        (FixtureChannel::Pan, 0.),
        (FixtureChannel::Tilt, 0.25),
    ])]
    fn run_should_write_multiple_controls_to_fixture(controls: Vec<(FixtureChannel, f64)>) {
        let presets = Presets::default();
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        programmer.select_fixtures(vec![FixtureId::Fixture(1)]);
        for (channel, value) in controls {
            programmer.write_control(channel, FixtureValue::Percent(value));
            expect_write(
                &mut fixture_controller,
                FixtureId::Fixture(1),
                channel,
                FixtureValue::Percent(value),
            );
        }

        programmer.run(&fixture_controller, &presets);

        fixture_controller.checkpoint();
    }

    #[test]
    fn run_should_combine_multiple_fixture_and_control_values() {
        let mut fixture_controller = MockFixtureController::default();
        let mut programmer = Programmer::new();
        let presets = Presets::default();
        programmer.select_fixtures(vec![FixtureId::Fixture(1), FixtureId::Fixture(2)]);
        programmer.write_control(FixtureChannel::Intensity, FixtureValue::Percent(1.));
        programmer.select_fixtures(vec![FixtureId::Fixture(2), FixtureId::Fixture(3)]);
        programmer.write_control(FixtureChannel::Intensity, FixtureValue::Percent(0.5));
        expect_write(
            &mut fixture_controller,
            FixtureId::Fixture(1),
            FixtureChannel::Intensity,
            FixtureValue::Percent(1.),
        );
        expect_write(
            &mut fixture_controller,
            FixtureId::Fixture(2),
            FixtureChannel::Intensity,
            FixtureValue::Percent(0.5),
        );
        expect_write(
            &mut fixture_controller,
            FixtureId::Fixture(3),
            FixtureChannel::Intensity,
            FixtureValue::Percent(0.5),
        );

        programmer.run(&fixture_controller, &presets);

        fixture_controller.checkpoint();
    }

    fn expect_write(
        fixture_controller: &mut MockFixtureController,
        fixture_id: FixtureId,
        control: FixtureChannel,
        value: FixtureValue,
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

    fn get_state(programmer: &mut Programmer) -> ProgrammerState {
        programmer.emit_state(Vec::<&Group>::new());

        programmer.view().read()
    }
}
