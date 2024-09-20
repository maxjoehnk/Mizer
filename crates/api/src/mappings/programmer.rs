use crate::proto::fixtures::*;
use crate::proto::programmer::*;

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
            },
            Shutter(id) => Self {
                id,
                r#type: preset_id::PresetType::Shutter as i32,
            },
            Color(id) => Self {
                id,
                r#type: preset_id::PresetType::Color as i32,
            },
            Position(id) => Self {
                id,
                r#type: preset_id::PresetType::Position as i32,
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
        }
    }
}

impl From<mizer_fixtures::programmer::Color> for preset::Color {
    fn from((red, green, blue): mizer_fixtures::programmer::Color) -> Self {
        Self { red, green, blue }
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
            },
        }
    }
}

impl From<mizer_fixtures::programmer::Group> for Group {
    fn from(group: mizer_fixtures::programmer::Group) -> Self {
        Self {
            id: group.id.into(),
            name: group.name,
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

impl From<StoreGroupMode> for mizer_command_executor::StoreGroupMode {
    fn from(mode: StoreGroupMode) -> Self {
        match mode {
            StoreGroupMode::Overwrite => Self::Overwrite,
            StoreGroupMode::Merge => Self::Merge,
            StoreGroupMode::Subtract => Self::Subtract,
        }
    }
}
