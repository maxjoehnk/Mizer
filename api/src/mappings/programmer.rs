use mizer_fixtures::definition::FixtureControlValue;
use protobuf::{EnumOrUnknown, MessageField};

use crate::models::*;

impl WriteControlRequest {
    pub fn as_controls(self) -> FixtureControlValue {
        use crate::models::fixtures::FixtureControl::*;

        match (self.control.unwrap(), self.value) {
            (INTENSITY, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Intensity(value)
            }
            (SHUTTER, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Shutter(value)
            }
            (FOCUS, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Focus(value)
            }
            (ZOOM, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Zoom(value)
            }
            (PRISM, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Iris(value)
            }
            (IRIS, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Iris(value)
            }
            (FROST, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Frost(value)
            }
            (PAN, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Pan(value)
            }
            (TILT, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Tilt(value)
            }
            (COLOR_MIXER, Some(write_control_request::Value::Color(value))) => {
                FixtureControlValue::ColorMixer(value.red, value.green, value.blue)
            }
            (COLOR_WHEEL, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::ColorWheel(value)
            }
            (GENERIC, Some(write_control_request::Value::Generic(value))) => {
                FixtureControlValue::Generic(value.name, value.value)
            }
            (GOBO, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Gobo(value)
            }
            _ => unreachable!(),
        }
    }
}

impl From<mizer_fixtures::programmer::ProgrammerState> for ProgrammerState {
    fn from(state: mizer_fixtures::programmer::ProgrammerState) -> Self {
        Self {
            active_fixtures: state
                .active_fixtures
                .into_iter()
                .map(FixtureId::from)
                .collect(),
            fixtures: state
                .tracked_fixtures
                .into_iter()
                .map(FixtureId::from)
                .collect(),
            highlight: state.highlight,
            ..Default::default()
        }
    }
}

impl From<PresetId> for mizer_fixtures::programmer::PresetId {
    fn from(id: PresetId) -> Self {
        use preset_id::PresetType::*;
        match id.type_.unwrap() {
            Intensity => Self::Intensity(id.id),
            Shutter => Self::Shutter(id.id),
            Color => Self::Color(id.id),
            Position => Self::Position(id.id),
        }
    }
}

impl From<mizer_fixtures::programmer::PresetId> for PresetId {
    fn from(id: mizer_fixtures::programmer::PresetId) -> Self {
        use mizer_fixtures::programmer::PresetId::*;

        match id {
            Intensity(id) => Self {
                id,
                type_: EnumOrUnknown::new(preset_id::PresetType::Intensity),
                ..Default::default()
            },
            Shutter(id) => Self {
                id,
                type_: EnumOrUnknown::new(preset_id::PresetType::Shutter),
                ..Default::default()
            },
            Color(id) => Self {
                id,
                type_: EnumOrUnknown::new(preset_id::PresetType::Color),
                ..Default::default()
            },
            Position(id) => Self {
                id,
                type_: EnumOrUnknown::new(preset_id::PresetType::Position),
                ..Default::default()
            },
        }
    }
}

impl
    From<(
        mizer_fixtures::programmer::PresetId,
        mizer_fixtures::programmer::Preset<f64>,
    )> for Preset
{
    fn from(
        (id, preset): (
            mizer_fixtures::programmer::PresetId,
            mizer_fixtures::programmer::Preset<f64>,
        ),
    ) -> Self {
        Self {
            id: MessageField::some(id.into()),
            value: Some(preset::Value::Fader(preset.value)),
            label: preset.label,
            ..Default::default()
        }
    }
}

impl
    From<(
        mizer_fixtures::programmer::PresetId,
        mizer_fixtures::programmer::Preset<mizer_fixtures::programmer::Color>,
    )> for Preset
{
    fn from(
        (id, preset): (
            mizer_fixtures::programmer::PresetId,
            mizer_fixtures::programmer::Preset<mizer_fixtures::programmer::Color>,
        ),
    ) -> Self {
        Self {
            id: MessageField::some(id.into()),
            value: Some(preset::Value::Color(preset.value.into())),
            label: preset.label,
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::programmer::Color> for preset::Color {
    fn from((red, green, blue): mizer_fixtures::programmer::Color) -> Self {
        Self {
            red,
            green,
            blue,
            ..Default::default()
        }
    }
}

impl
    From<(
        mizer_fixtures::programmer::PresetId,
        mizer_fixtures::programmer::Preset<mizer_fixtures::programmer::Position>,
    )> for Preset
{
    fn from(
        (id, preset): (
            mizer_fixtures::programmer::PresetId,
            mizer_fixtures::programmer::Preset<mizer_fixtures::programmer::Position>,
        ),
    ) -> Self {
        Self {
            id: MessageField::some(id.into()),
            value: Some(preset::Value::Position(preset.value.into())),
            label: preset.label,
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::programmer::Position> for preset::Position {
    fn from((pan, tilt): mizer_fixtures::programmer::Position) -> Self {
        Self {
            pan,
            tilt,
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::programmer::Group> for Group {
    fn from(group: mizer_fixtures::programmer::Group) -> Self {
        Self {
            id: group.id,
            name: group.name,
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::programmer::ProgrammerChannel> for ProgrammerChannel {
    fn from(channel: mizer_fixtures::programmer::ProgrammerChannel) -> Self {
        use FixtureControlValue::*;
        let (control, value) = match channel.value {
            Intensity(value) => (
                FixtureControl::INTENSITY,
                programmer_channel::Value::Fader(value),
            ),
            Shutter(value) => (
                FixtureControl::SHUTTER,
                programmer_channel::Value::Fader(value),
            ),
            Pan(value) => (FixtureControl::PAN, programmer_channel::Value::Fader(value)),
            Tilt(value) => (
                FixtureControl::TILT,
                programmer_channel::Value::Fader(value),
            ),
            Focus(value) => (
                FixtureControl::FOCUS,
                programmer_channel::Value::Fader(value),
            ),
            Zoom(value) => (
                FixtureControl::ZOOM,
                programmer_channel::Value::Fader(value),
            ),
            Prism(value) => (
                FixtureControl::PRISM,
                programmer_channel::Value::Fader(value),
            ),
            Iris(value) => (
                FixtureControl::IRIS,
                programmer_channel::Value::Fader(value),
            ),
            Frost(value) => (
                FixtureControl::FROST,
                programmer_channel::Value::Fader(value),
            ),
            ColorMixer(red, green, blue) => (
                FixtureControl::COLOR_MIXER,
                programmer_channel::Value::Color(crate::models::fixtures::ColorMixerChannel {
                    red,
                    green,
                    blue,
                    ..Default::default()
                }),
            ),
            ColorWheel(value) => (
                FixtureControl::COLOR_WHEEL,
                programmer_channel::Value::Fader(value),
            ),
            Gobo(value) => (
                FixtureControl::GOBO,
                programmer_channel::Value::Fader(value),
            ),
            Generic(name, value) => (
                FixtureControl::GENERIC,
                programmer_channel::Value::Generic(programmer_channel::GenericValue {
                    value,
                    name,
                    ..Default::default()
                }),
            ),
        };

        Self {
            fixtures: channel.fixtures.into_iter().map(FixtureId::from).collect(),
            control: control.into(),
            value: Some(value),
            ..Default::default()
        }
    }
}

impl From<store_request::Mode> for mizer_command_executor::StoreMode {
    fn from(mode: store_request::Mode) -> Self {
        match mode {
            store_request::Mode::Merge => Self::Merge,
            store_request::Mode::AddCue => Self::AddCue,
            store_request::Mode::Overwrite => Self::Overwrite,
        }
    }
}
