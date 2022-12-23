use mizer_fixtures::definition::{self, ChannelResolution, PhysicalFixtureData};
use mizer_fixtures::fixture::IFixture;
use protobuf::MessageField;

use crate::models;
use crate::models::fixtures::*;

impl From<mizer_fixtures::definition::FixtureDefinition> for FixtureDefinition {
    fn from(definition: mizer_fixtures::definition::FixtureDefinition) -> Self {
        let physical: FixturePhysicalData = definition.physical.into();
        FixtureDefinition {
            id: definition.id,
            name: definition.name,
            manufacturer: definition.manufacturer,
            modes: definition
                .modes
                .into_iter()
                .map(FixtureMode::from)
                .collect(),
            tags: definition.tags,
            physical: MessageField::some(physical),
            provider: definition.provider.to_string(),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::definition::PhysicalFixtureData> for FixturePhysicalData {
    fn from(physical_data: PhysicalFixtureData) -> Self {
        let mut data = FixturePhysicalData::new();
        if let Some(dimensions) = physical_data.dimensions {
            data.width = dimensions.width;
            data.height = dimensions.height;
            data.depth = dimensions.depth;
        }
        if let Some(weight) = physical_data.weight {
            data.weight = weight;
        }

        data
    }
}

impl From<mizer_fixtures::definition::FixtureMode> for FixtureMode {
    fn from(mode: mizer_fixtures::definition::FixtureMode) -> Self {
        FixtureMode {
            name: mode.name,
            channels: mode
                .channels
                .into_iter()
                .map(FixtureChannel::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::definition::FixtureChannelDefinition> for FixtureChannel {
    fn from(channel: mizer_fixtures::definition::FixtureChannelDefinition) -> Self {
        FixtureChannel {
            name: channel.name,
            resolution: Some(channel.resolution.into()),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::definition::ChannelResolution> for fixture_channel::Resolution {
    fn from(resolution: mizer_fixtures::definition::ChannelResolution) -> Self {
        match resolution {
            ChannelResolution::Coarse(coarse) => {
                fixture_channel::Resolution::Coarse(fixture_channel::CoarseResolution {
                    channel: coarse.into(),
                    ..Default::default()
                })
            }
            ChannelResolution::Fine(fine, coarse) => {
                fixture_channel::Resolution::Fine(fixture_channel::FineResolution {
                    fineChannel: fine.into(),
                    coarseChannel: coarse.into(),
                    ..Default::default()
                })
            }
            ChannelResolution::Finest(finest, fine, coarse) => {
                fixture_channel::Resolution::Finest(fixture_channel::FinestResolution {
                    finestChannel: finest.into(),
                    fineChannel: fine.into(),
                    coarseChannel: coarse.into(),
                    ..Default::default()
                })
            }
        }
    }
}

impl FixtureControls {
    fn build_fader(control: FixtureControl, value: Option<f64>) -> Self {
        FixtureControls {
            control: control.into(),
            value: value.map(|value| {
                fixture_controls::Value::Fader(FaderChannel {
                    value,
                    ..Default::default()
                })
            }),
            ..Default::default()
        }
    }

    pub fn with_values<TChannel>(
        fixture: &impl IFixture,
        fixture_controls: mizer_fixtures::definition::FixtureControls<TChannel>,
    ) -> Vec<Self> {
        let mut controls = Vec::new();
        if fixture_controls.intensity.is_some() {
            let value =
                fixture.read_control(mizer_fixtures::definition::FixtureFaderControl::Intensity);
            controls.push(FixtureControls::build_fader(
                FixtureControl::INTENSITY,
                value,
            ));
        }
        if fixture_controls.shutter.is_some() {
            let value =
                fixture.read_control(mizer_fixtures::definition::FixtureFaderControl::Shutter);
            controls.push(FixtureControls::build_fader(FixtureControl::SHUTTER, value));
        }
        if fixture_controls.iris.is_some() {
            let value = fixture.read_control(mizer_fixtures::definition::FixtureFaderControl::Iris);
            controls.push(FixtureControls::build_fader(FixtureControl::IRIS, value));
        }
        if fixture_controls.zoom.is_some() {
            let value = fixture.read_control(mizer_fixtures::definition::FixtureFaderControl::Zoom);
            controls.push(FixtureControls::build_fader(FixtureControl::ZOOM, value));
        }
        if fixture_controls.frost.is_some() {
            let value =
                fixture.read_control(mizer_fixtures::definition::FixtureFaderControl::Frost);
            controls.push(FixtureControls::build_fader(FixtureControl::FROST, value));
        }
        if fixture_controls.prism.is_some() {
            let value =
                fixture.read_control(mizer_fixtures::definition::FixtureFaderControl::Prism);
            controls.push(FixtureControls::build_fader(FixtureControl::PRISM, value));
        }
        if fixture_controls.focus.is_some() {
            let value =
                fixture.read_control(mizer_fixtures::definition::FixtureFaderControl::Focus);
            controls.push(FixtureControls::build_fader(FixtureControl::FOCUS, value));
        }
        if let Some(channel) = fixture_controls.pan {
            let value = fixture.read_control(mizer_fixtures::definition::FixtureFaderControl::Pan);
            controls.push(FixtureControls {
                control: FixtureControl::PAN.into(),
                value: Some(fixture_controls::Value::Axis(AxisChannel::with_value(
                    &channel, value,
                ))),
                ..Default::default()
            });
        }
        if let Some(channel) = fixture_controls.tilt {
            let value = fixture.read_control(mizer_fixtures::definition::FixtureFaderControl::Pan);
            controls.push(FixtureControls {
                control: FixtureControl::TILT.into(),
                value: Some(fixture_controls::Value::Axis(AxisChannel::with_value(
                    &channel, value,
                ))),
                ..Default::default()
            });
        }
        if fixture_controls.color_mixer.is_some() {
            controls.push(FixtureControls {
                control: FixtureControl::COLOR_MIXER.into(),
                value: Some(fixture_controls::Value::ColorMixer(ColorMixerChannel {
                    red: fixture
                        .read_control(mizer_fixtures::definition::FixtureFaderControl::ColorMixer(
                            mizer_fixtures::definition::ColorChannel::Red,
                        ))
                        .unwrap_or_default(),
                    green: fixture
                        .read_control(mizer_fixtures::definition::FixtureFaderControl::ColorMixer(
                            mizer_fixtures::definition::ColorChannel::Red,
                        ))
                        .unwrap_or_default(),
                    blue: fixture
                        .read_control(mizer_fixtures::definition::FixtureFaderControl::ColorMixer(
                            mizer_fixtures::definition::ColorChannel::Red,
                        ))
                        .unwrap_or_default(),
                    ..Default::default()
                })),
                ..Default::default()
            })
        }
        if let Some(color_wheel) = fixture_controls.color_wheel {
            controls.push(FixtureControls {
                control: FixtureControl::COLOR_WHEEL.into(),
                value: Some(fixture_controls::Value::ColorWheel(ColorWheelChannel {
                    colors: color_wheel
                        .colors
                        .into_iter()
                        .map(ColorWheelSlot::from)
                        .collect(),
                    value: fixture
                        .read_control(mizer_fixtures::definition::FixtureFaderControl::ColorWheel)
                        .unwrap_or_default(),
                    ..Default::default()
                })),
                ..Default::default()
            })
        }
        if let Some(gobo) = fixture_controls.gobo {
            controls.push(FixtureControls {
                control: FixtureControl::GOBO.into(),
                value: Some(fixture_controls::Value::Gobo(GoboChannel {
                    gobos: gobo.gobos.into_iter().map(Gobo::from).collect(),
                    value: fixture
                        .read_control(mizer_fixtures::definition::FixtureFaderControl::Gobo)
                        .unwrap_or_default(),
                    ..Default::default()
                })),
                ..Default::default()
            })
        }
        for channel in fixture_controls.generic {
            let value = fixture.read_control(
                mizer_fixtures::definition::FixtureFaderControl::Generic(channel.label.clone()),
            );
            controls.push(FixtureControls {
                control: FixtureControl::GENERIC.into(),
                value: value.map(|value| {
                    fixture_controls::Value::Generic(GenericChannel {
                        name: channel.label,
                        value,
                        ..Default::default()
                    })
                }),
                ..Default::default()
            });
        }

        controls
    }
}

impl From<mizer_fixtures::definition::ColorWheelSlot> for ColorWheelSlot {
    fn from(color: mizer_fixtures::definition::ColorWheelSlot) -> Self {
        Self {
            name: color.name,
            value: color.value,
            colors: color.color.into_iter().collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::definition::Gobo> for Gobo {
    fn from(gobo: mizer_fixtures::definition::Gobo) -> Self {
        Self {
            name: gobo.name,
            value: gobo.value,
            image: gobo.image.map(gobo::Image::from),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::definition::GoboImage> for gobo::Image {
    fn from(image: mizer_fixtures::definition::GoboImage) -> Self {
        use mizer_fixtures::definition::GoboImage::*;
        match image {
            Raster(bytes) => Self::Raster(*bytes),
            Svg(svg) => Self::Svg(svg),
        }
    }
}

impl From<f64> for GenericChannel {
    fn from(value: f64) -> Self {
        Self {
            value,
            ..Default::default()
        }
    }
}

impl AxisChannel {
    fn with_value<TChannel>(
        axis: &mizer_fixtures::definition::AxisGroup<TChannel>,
        value: Option<f64>,
    ) -> Self {
        AxisChannel {
            value: value.unwrap_or_default(),
            angle_from: axis
                .angle
                .map(|angle| angle.from as f64)
                .unwrap_or_default(),
            angle_to: axis.angle.map(|angle| angle.to as f64).unwrap_or_default(),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::FixtureId> for FixtureId {
    fn from(id: mizer_fixtures::FixtureId) -> Self {
        match id {
            mizer_fixtures::FixtureId::Fixture(fixture_id) => Self {
                id: Some(fixture_id::Id::Fixture(fixture_id)),
                ..Default::default()
            },
            mizer_fixtures::FixtureId::SubFixture(fixture_id, child_id) => Self {
                id: Some(fixture_id::Id::SubFixture(SubFixtureId {
                    fixture_id,
                    child_id,
                    ..Default::default()
                })),
                ..Default::default()
            },
        }
    }
}

impl From<FixtureId> for mizer_fixtures::FixtureId {
    fn from(id: FixtureId) -> Self {
        match id.id {
            Some(fixture_id::Id::Fixture(fixture_id)) => Self::Fixture(fixture_id),
            Some(fixture_id::Id::SubFixture(SubFixtureId {
                fixture_id,
                child_id,
                ..
            })) => Self::SubFixture(fixture_id, child_id),
            _ => unreachable!(),
        }
    }
}

impl From<definition::FixtureFaderControl> for models::FixtureControl {
    fn from(control: definition::FixtureFaderControl) -> Self {
        use definition::FixtureFaderControl::*;

        match control {
            Intensity => Self::INTENSITY,
            Shutter => Self::SHUTTER,
            Pan => Self::PAN,
            Tilt => Self::TILT,
            Prism => Self::PRISM,
            Iris => Self::IRIS,
            Frost => Self::FROST,
            ColorMixer(_) => Self::COLOR_MIXER,
            ColorWheel => Self::COLOR_WHEEL,
            Generic(_) => Self::GENERIC,
            Zoom => Self::ZOOM,
            Focus => Self::FOCUS,
            Gobo => Self::GOBO,
        }
    }
}

impl From<models::FixtureFaderControl> for definition::FixtureFaderControl {
    fn from(control: models::FixtureFaderControl) -> Self {
        use models::FixtureControl::*;

        let color_mixer_channel = control.color_mixer_channel.map(|channel| {
            use models::fixture_fader_control::ColorMixerControlChannel::*;

            match channel.unwrap() {
                RED => definition::ColorChannel::Red,
                GREEN => definition::ColorChannel::Green,
                BLUE => definition::ColorChannel::Blue,
            }
        });

        let generic_channel = control.generic_channel;

        match control.control.unwrap() {
            INTENSITY => Self::Intensity,
            SHUTTER => Self::Shutter,
            FOCUS => Self::Focus,
            ZOOM => Self::Zoom,
            FROST => Self::Frost,
            COLOR_MIXER => {
                if let Some(color) = color_mixer_channel {
                    Self::ColorMixer(color)
                } else {
                    unreachable!("ColorMixer control without color channel")
                }
            }
            COLOR_WHEEL => Self::ColorWheel,
            GOBO => Self::Gobo,
            PAN => Self::Pan,
            TILT => Self::Tilt,
            PRISM => Self::Prism,
            GENERIC => {
                if let Some(generic) = generic_channel {
                    Self::Generic(generic)
                } else {
                    unreachable!("Generic control without generic channel name")
                }
            }
            IRIS => Self::Iris,
        }
    }
}
