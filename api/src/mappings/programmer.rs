use protobuf::SingularPtrField;
use crate::models::FixtureId;
use mizer_fixtures::definition::{ColorChannel, FixtureFaderControl};

use crate::models::programmer::*;

impl WriteControlRequest {
    pub fn as_controls(self) -> Vec<(FixtureFaderControl, f64)> {
        use crate::models::FixtureControl::*;

        match (self.control, self.value) {
            (INTENSITY, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureFaderControl::Intensity, value)]
            }
            (SHUTTER, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureFaderControl::Shutter, value)]
            }
            (FOCUS, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureFaderControl::Focus, value)]
            }
            (ZOOM, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureFaderControl::Zoom, value)]
            }
            (PRISM, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureFaderControl::Iris, value)]
            }
            (IRIS, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureFaderControl::Iris, value)]
            }
            (FROST, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureFaderControl::Frost, value)]
            }
            (PAN, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureFaderControl::Pan, value)]
            }
            (TILT, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureFaderControl::Tilt, value)]
            }
            (COLOR, Some(WriteControlRequest_oneof_value::color(value))) => vec![
                (FixtureFaderControl::Color(ColorChannel::Red), value.red),
                (FixtureFaderControl::Color(ColorChannel::Green), value.green),
                (FixtureFaderControl::Color(ColorChannel::Blue), value.blue),
            ],
            (GENERIC, Some(WriteControlRequest_oneof_value::generic(value))) => {
                vec![(FixtureFaderControl::Generic(value.name), value.value)]
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


impl From<(mizer_fixtures::programmer::PresetId, mizer_fixtures::programmer::Preset<f64>)> for Preset {
    fn from((id, preset): (mizer_fixtures::programmer::PresetId, mizer_fixtures::programmer::Preset<f64>)) -> Self {
        Self {
            id: SingularPtrField::some(id.into()),
            value: Some(Preset_oneof_value::fader(preset.value)),
            _label: preset.label.map(|label| Preset_oneof__label::label(label)),
            ..Default::default()
        }
    }
}

impl From<(mizer_fixtures::programmer::PresetId, mizer_fixtures::programmer::Preset<mizer_fixtures::programmer::Color>)> for Preset {
    fn from((id, preset): (mizer_fixtures::programmer::PresetId, mizer_fixtures::programmer::Preset<mizer_fixtures::programmer::Color>)) -> Self {
        Self {
            id: SingularPtrField::some(id.into()),
            value: Some(Preset_oneof_value::color(preset.value.into())),
            _label: preset.label.map(|label| Preset_oneof__label::label(label)),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::programmer::Color> for Preset_Color {
    fn from((red, green, blue ): mizer_fixtures::programmer::Color) -> Self {
        Self {
            red,
            green,
            blue,
            ..Default::default()
        }
    }
}

impl From<(mizer_fixtures::programmer::PresetId, mizer_fixtures::programmer::Preset<mizer_fixtures::programmer::Position>)> for Preset {
    fn from((id, preset): (mizer_fixtures::programmer::PresetId, mizer_fixtures::programmer::Preset<mizer_fixtures::programmer::Position>)) -> Self {
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
