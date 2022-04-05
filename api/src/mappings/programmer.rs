use crate::models::{FixtureControl, FixtureId};
use mizer_fixtures::definition::FixtureControlValue;
use protobuf::SingularPtrField;

use crate::models::programmer::*;

impl WriteControlRequest {
    pub fn as_controls(self) -> FixtureControlValue {
        use crate::models::FixtureControl::*;

        match (self.control, self.value) {
            (INTENSITY, Some(WriteControlRequest_oneof_value::fader(value))) => {
                FixtureControlValue::Intensity(value)
            }
            (SHUTTER, Some(WriteControlRequest_oneof_value::fader(value))) => {
                FixtureControlValue::Shutter(value)
            }
            (FOCUS, Some(WriteControlRequest_oneof_value::fader(value))) => {
                FixtureControlValue::Focus(value)
            }
            (ZOOM, Some(WriteControlRequest_oneof_value::fader(value))) => {
                FixtureControlValue::Zoom(value)
            }
            (PRISM, Some(WriteControlRequest_oneof_value::fader(value))) => {
                FixtureControlValue::Iris(value)
            }
            (IRIS, Some(WriteControlRequest_oneof_value::fader(value))) => {
                FixtureControlValue::Iris(value)
            }
            (FROST, Some(WriteControlRequest_oneof_value::fader(value))) => {
                FixtureControlValue::Frost(value)
            }
            (PAN, Some(WriteControlRequest_oneof_value::fader(value))) => {
                FixtureControlValue::Pan(value)
            }
            (TILT, Some(WriteControlRequest_oneof_value::fader(value))) => {
                FixtureControlValue::Tilt(value)
            }
            (COLOR, Some(WriteControlRequest_oneof_value::color(value))) => {
                FixtureControlValue::Color(value.red, value.green, value.blue)
            }
            (GENERIC, Some(WriteControlRequest_oneof_value::generic(value))) => {
                FixtureControlValue::Generic(value.name, value.value)
            }
            (GOBO, Some(WriteControlRequest_oneof_value::fader(value))) => {
                FixtureControlValue::Gobo(value)
            }
            _ => unreachable!(),
        }
    }
}

impl From<mizer_fixtures::programmer::ProgrammerState> for ProgrammerState {
    fn from(state: mizer_fixtures::programmer::ProgrammerState) -> Self {
        Self {
            fixtures: state.fixtures.into_iter().map(FixtureId::from).collect(),
            highlight: state.highlight,
            ..Default::default()
        }
    }
}

impl From<PresetId> for mizer_fixtures::programmer::PresetId {
    fn from(id: PresetId) -> Self {
        use PresetId_PresetType::*;
        match id.field_type {
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
                field_type: PresetId_PresetType::Intensity,
                ..Default::default()
            },
            Shutter(id) => Self {
                id,
                field_type: PresetId_PresetType::Shutter,
                ..Default::default()
            },
            Color(id) => Self {
                id,
                field_type: PresetId_PresetType::Color,
                ..Default::default()
            },
            Position(id) => Self {
                id,
                field_type: PresetId_PresetType::Position,
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
            id: SingularPtrField::some(id.into()),
            value: Some(Preset_oneof_value::fader(preset.value)),
            _label: preset.label.map(|label| Preset_oneof__label::label(label)),
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
            id: SingularPtrField::some(id.into()),
            value: Some(Preset_oneof_value::color(preset.value.into())),
            _label: preset.label.map(|label| Preset_oneof__label::label(label)),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::programmer::Color> for Preset_Color {
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
            id: SingularPtrField::some(id.into()),
            value: Some(Preset_oneof_value::position(preset.value.into())),
            _label: preset.label.map(|label| Preset_oneof__label::label(label)),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::programmer::Position> for Preset_Position {
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
                ProgrammerChannel_oneof_value::fader(value),
            ),
            Shutter(value) => (
                FixtureControl::SHUTTER,
                ProgrammerChannel_oneof_value::fader(value),
            ),
            Pan(value) => (
                FixtureControl::PAN,
                ProgrammerChannel_oneof_value::fader(value),
            ),
            Tilt(value) => (
                FixtureControl::TILT,
                ProgrammerChannel_oneof_value::fader(value),
            ),
            Focus(value) => (
                FixtureControl::FOCUS,
                ProgrammerChannel_oneof_value::fader(value),
            ),
            Zoom(value) => (
                FixtureControl::ZOOM,
                ProgrammerChannel_oneof_value::fader(value),
            ),
            Prism(value) => (
                FixtureControl::PRISM,
                ProgrammerChannel_oneof_value::fader(value),
            ),
            Iris(value) => (
                FixtureControl::IRIS,
                ProgrammerChannel_oneof_value::fader(value),
            ),
            Frost(value) => (
                FixtureControl::FROST,
                ProgrammerChannel_oneof_value::fader(value),
            ),
            Color(red, green, blue) => (
                FixtureControl::COLOR,
                ProgrammerChannel_oneof_value::color(crate::models::ColorChannel {
                    red,
                    green,
                    blue,
                    ..Default::default()
                }),
            ),
            Gobo(value) => (
                FixtureControl::GOBO,
                ProgrammerChannel_oneof_value::fader(value),
            ),
            Generic(name, value) => (
                FixtureControl::GENERIC,
                ProgrammerChannel_oneof_value::generic(ProgrammerChannel_GenericValue {
                    value,
                    name,
                    ..Default::default()
                }),
            ),
        };

        Self {
            fixtures: channel.fixtures.into_iter().map(FixtureId::from).collect(),
            control,
            value: Some(value),
            ..Default::default()
        }
    }
}
