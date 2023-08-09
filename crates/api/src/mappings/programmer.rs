use mizer_fixtures::definition::FixtureControlValue;

use crate::proto::fixtures::*;
use crate::proto::programmer::*;

impl WriteControlRequest {
    pub fn as_controls(self) -> FixtureControlValue {
        use crate::proto::fixtures::FixtureControl::*;

        match (self.control(), self.value) {
            (Intensity, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Intensity(value)
            }
            (Shutter, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Shutter(value)
            }
            (Focus, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Focus(value)
            }
            (Zoom, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Zoom(value)
            }
            (Prism, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Iris(value)
            }
            (Iris, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Iris(value)
            }
            (Frost, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Frost(value)
            }
            (Pan, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Pan(value)
            }
            (Tilt, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::Tilt(value)
            }
            (ColorMixer, Some(write_control_request::Value::Color(value))) => {
                FixtureControlValue::ColorMixer(value.red, value.green, value.blue)
            }
            (ColorWheel, Some(write_control_request::Value::Fader(value))) => {
                FixtureControlValue::ColorWheel(value)
            }
            (Generic, Some(write_control_request::Value::Generic(value))) => {
                FixtureControlValue::Generic(value.name, value.value)
            }
            (Gobo, Some(write_control_request::Value::Fader(value))) => {
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
        match id.r#type() {
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
                r#type: preset_id::PresetType::Intensity as i32,
                ..Default::default()
            },
            Shutter(id) => Self {
                id,
                r#type: preset_id::PresetType::Shutter as i32,
                ..Default::default()
            },
            Color(id) => Self {
                id,
                r#type: preset_id::PresetType::Color as i32,
                ..Default::default()
            },
            Position(id) => Self {
                id,
                r#type: preset_id::PresetType::Position as i32,
                ..Default::default()
            },
        }
    }
}

impl From<preset_id::PresetType> for mizer_fixtures::programmer::PresetType {
    fn from(value: preset_id::PresetType) -> Self {
        match value {
            preset_id::PresetType::Intensity => Self::Intensity,
            preset_id::PresetType::Shutter => Self::Shutter,
            preset_id::PresetType::Color => Self::Color,
            preset_id::PresetType::Position => Self::Position,
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
            id: Some(id.into()),
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
            id: Some(id.into()),
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
            id: Some(id.into()),
            value: Some(preset::Value::Position(preset.value.into())),
            label: preset.label,
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::programmer::Position> for preset::Position {
    fn from(position: mizer_fixtures::programmer::Position) -> Self {
        use mizer_fixtures::programmer::Position::*;

        match position {
            Pan(pan) => Self {
                pan: Some(pan),
                ..Default::default()
            },
            Tilt(tilt) => Self {
                tilt: Some(tilt),
                ..Default::default()
            },
            PanTilt(pan, tilt) => Self {
                pan: Some(pan),
                tilt: Some(tilt),
                ..Default::default()
            },
        }
    }
}

impl From<mizer_fixtures::programmer::Group> for Group {
    fn from(group: mizer_fixtures::programmer::Group) -> Self {
        Self {
            id: group.id.into(),
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
                FixtureControl::Intensity,
                programmer_channel::Value::Fader(value),
            ),
            Shutter(value) => (
                FixtureControl::Shutter,
                programmer_channel::Value::Fader(value),
            ),
            Pan(value) => (FixtureControl::Pan, programmer_channel::Value::Fader(value)),
            Tilt(value) => (
                FixtureControl::Tilt,
                programmer_channel::Value::Fader(value),
            ),
            Focus(value) => (
                FixtureControl::Focus,
                programmer_channel::Value::Fader(value),
            ),
            Zoom(value) => (
                FixtureControl::Zoom,
                programmer_channel::Value::Fader(value),
            ),
            Prism(value) => (
                FixtureControl::Prism,
                programmer_channel::Value::Fader(value),
            ),
            Iris(value) => (
                FixtureControl::Iris,
                programmer_channel::Value::Fader(value),
            ),
            Frost(value) => (
                FixtureControl::Frost,
                programmer_channel::Value::Fader(value),
            ),
            ColorMixer(red, green, blue) => (
                FixtureControl::ColorMixer,
                programmer_channel::Value::Color(crate::proto::fixtures::ColorMixerChannel {
                    red,
                    green,
                    blue,
                    ..Default::default()
                }),
            ),
            ColorWheel(value) => (
                FixtureControl::ColorWheel,
                programmer_channel::Value::Fader(value),
            ),
            Gobo(value) => (
                FixtureControl::Gobo,
                programmer_channel::Value::Fader(value),
            ),
            Generic(name, value) => (
                FixtureControl::Generic,
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
