use mizer_fixtures::definition::{
    AxisGroup, ChannelResolution, ColorChannel, ColorGroup, ColorWheelGroup,
    FixtureChannelDefinition, FixtureControlChannel, FixtureControls, FixtureDefinition,
    FixtureFaderControl, FixtureMode, GenericControl, GoboGroup, SubFixtureControlChannel,
    SubFixtureDefinition,
};
use mizer_fixtures::fixture::{Fixture, IFixtureMut};
use test_case::test_case;

#[test_case(1f64, 255, FixtureFaderControl::Intensity, "Brightness")]
#[test_case(0f64, 0, FixtureFaderControl::Intensity, "Intensity")]
#[test_case(0.5f64, 127, FixtureFaderControl::Intensity, "Channel 1")]
#[test_case(1f64, 255, FixtureFaderControl::Shutter, "Shutter")]
#[test_case(0f64, 0, FixtureFaderControl::Pan, "Pan")]
fn write_fader_control_should_output_given_value(
    value: f64,
    expected: u8,
    control: FixtureFaderControl,
    name: &str,
) {
    let controls = create_controls(name.to_string(), control.clone());
    let mode = single_channel_mode(name, controls);
    let mut fixture = create_test_fixture([mode]);

    fixture.write_fader_control(control, value);
    let result = fixture.get_dmx_values();

    assert_eq!(expected, result[0]);
}

#[test_case((1f64, 1f64, 1f64), (255, 255, 255))]
#[test_case((1f64, 0f64, 0f64), (255, 0, 0))]
#[test_case((0f64, 1f64, 0f64), (0, 255, 0))]
#[test_case((0f64, 0f64, 1f64), (0, 0, 255))]
fn write_fader_control_should_output_mixed_colors(value: (f64, f64, f64), expected: (u8, u8, u8)) {
    let controls = FixtureControls {
        color_mixer: Some(ColorGroup {
            red: "Red".to_string(),
            green: "Green".to_string(),
            blue: "Blue".to_string(),
            white: None,
            amber: None,
        }),
        ..Default::default()
    };
    let mode = FixtureMode::new(
        Default::default(),
        vec![
            FixtureChannelDefinition {
                name: "Red".into(),
                resolution: ChannelResolution::Coarse(0),
            },
            FixtureChannelDefinition {
                name: "Green".into(),
                resolution: ChannelResolution::Coarse(1),
            },
            FixtureChannelDefinition {
                name: "Blue".into(),
                resolution: ChannelResolution::Coarse(2),
            },
        ],
        controls.into(),
        Default::default(),
    );
    let mut fixture = create_test_fixture([mode]);

    fixture.write_fader_control(FixtureFaderControl::Intensity, 1f64);
    fixture.write_fader_control(FixtureFaderControl::ColorMixer(ColorChannel::Red), value.0);
    fixture.write_fader_control(
        FixtureFaderControl::ColorMixer(ColorChannel::Green),
        value.1,
    );
    fixture.write_fader_control(FixtureFaderControl::ColorMixer(ColorChannel::Blue), value.2);
    let result = fixture.get_dmx_values();

    assert_eq!(expected.0, result[0]);
    assert_eq!(expected.1, result[1]);
    assert_eq!(expected.2, result[2]);
}

#[test_case(1f64, 255, FixtureFaderControl::Intensity, "Brightness")]
#[test_case(0f64, 0, FixtureFaderControl::Intensity, "Intensity")]
#[test_case(0.5f64, 127, FixtureFaderControl::Intensity, "Channel 1")]
#[test_case(1f64, 255, FixtureFaderControl::Shutter, "Shutter")]
#[test_case(0f64, 0, FixtureFaderControl::Pan, "Pan")]
fn write_fader_control_should_output_given_value_for_sub_fixture(
    value: f64,
    expected: u8,
    control: FixtureFaderControl,
    name: &str,
) {
    let sub_fixture_controls = create_controls(
        SubFixtureControlChannel::Channel(name.into()),
        control.clone(),
    );
    let sub_fixture = SubFixtureDefinition::new(1, Default::default(), sub_fixture_controls);
    let mode = FixtureMode::new(
        Default::default(),
        vec![FixtureChannelDefinition {
            name: name.into(),
            resolution: ChannelResolution::Coarse(0),
        }],
        Default::default(),
        vec![sub_fixture],
    );
    let mut fixture = create_test_fixture([mode]);
    let mut sub_fixture = fixture
        .sub_fixture_mut(1)
        .expect("Sub fixture with id 1 should exist");

    sub_fixture.write_fader_control(control, value);
    let result = fixture.get_dmx_values();

    assert_eq!(expected, result[0]);
}

#[test_case(1f64, 255, FixtureFaderControl::Intensity, "Brightness")]
#[test_case(0f64, 0, FixtureFaderControl::Intensity, "Intensity")]
#[test_case(0.5f64, 127, FixtureFaderControl::Intensity, "Channel 1")]
#[test_case(1f64, 255, FixtureFaderControl::Shutter, "Shutter")]
#[test_case(0f64, 0, FixtureFaderControl::Pan, "Pan")]
fn write_fader_control_should_delegate_to_sub_fixtures(
    value: f64,
    expected: u8,
    control: FixtureFaderControl,
    name: &str,
) {
    let controls = create_controls(FixtureControlChannel::Delegate, control.clone());
    let sub_fixture_controls = create_controls(
        SubFixtureControlChannel::Channel(name.into()),
        control.clone(),
    );
    let sub_fixture = SubFixtureDefinition::new(1, Default::default(), sub_fixture_controls);
    let mode = FixtureMode::new(
        Default::default(),
        vec![FixtureChannelDefinition {
            name: name.into(),
            resolution: ChannelResolution::Coarse(0),
        }],
        controls,
        vec![sub_fixture],
    );
    let mut fixture = create_test_fixture([mode]);

    fixture.write_fader_control(control, value);
    let result = fixture.get_dmx_values();

    assert_eq!(expected, result[0]);
}

#[test_case(2)]
#[test_case(5)]
fn write_fader_control_should_delegate_to_all_sub_fixtures(count: u16) {
    let controls = create_controls(
        FixtureControlChannel::Delegate,
        FixtureFaderControl::Intensity,
    );
    let mut sub_fixtures = vec![];
    let mut channels = vec![];
    for i in 0..count {
        let name = format!("Pixel{}", i);
        let sub_fixture_controls = create_controls(
            SubFixtureControlChannel::Channel(name.clone()),
            FixtureFaderControl::Intensity,
        );
        let sub_fixture =
            SubFixtureDefinition::new(i.into(), Default::default(), sub_fixture_controls);
        sub_fixtures.push(sub_fixture);
        channels.push(FixtureChannelDefinition {
            name,
            resolution: ChannelResolution::Coarse(i),
        })
    }
    let mode = FixtureMode::new(Default::default(), channels, controls, sub_fixtures);
    let mut fixture = create_test_fixture([mode]);

    fixture.write_fader_control(FixtureFaderControl::Intensity, 1f64);
    let result = fixture.get_dmx_values();

    for i in 0..count {
        assert_eq!(255, result[i as usize]);
    }
}

#[test_case(2, (1f64, 1f64, 1f64), (255, 255, 255))]
#[test_case(5, (1f64, 0f64, 0f64), (255, 0, 0))]
fn write_fader_control_should_delegate_color_mixing_to_all_sub_fixtures(
    count: u16,
    value: (f64, f64, f64),
    expected: (u8, u8, u8),
) {
    let controls = FixtureControls {
        color_mixer: Some(ColorGroup {
            red: FixtureControlChannel::Delegate,
            green: FixtureControlChannel::Delegate,
            blue: FixtureControlChannel::Delegate,
            amber: None,
            white: None,
        }),
        intensity: Some(FixtureControlChannel::Delegate),
        ..Default::default()
    };
    let mut sub_fixtures = vec![];
    let mut channels = vec![];
    for i in 0..count {
        let sub_fixture_controls = FixtureControls {
            color_mixer: Some(ColorGroup {
                red: SubFixtureControlChannel::Channel(format!("Red{i}")),
                green: SubFixtureControlChannel::Channel(format!("Green{i}")),
                blue: SubFixtureControlChannel::Channel(format!("Blue{i}")),
                amber: None,
                white: None,
            }),
            ..Default::default()
        };
        let sub_fixture =
            SubFixtureDefinition::new(i.into(), Default::default(), sub_fixture_controls);
        sub_fixtures.push(sub_fixture);
        channels.push(FixtureChannelDefinition {
            name: format!("Red{i}"),
            resolution: ChannelResolution::Coarse(i * 3),
        });
        channels.push(FixtureChannelDefinition {
            name: format!("Green{i}"),
            resolution: ChannelResolution::Coarse(i * 3 + 1),
        });
        channels.push(FixtureChannelDefinition {
            name: format!("Blue{i}"),
            resolution: ChannelResolution::Coarse(i * 3 + 2),
        });
    }
    let mode = FixtureMode::new(Default::default(), channels, controls, sub_fixtures);
    let mut fixture = create_test_fixture([mode]);

    fixture.write_fader_control(FixtureFaderControl::Intensity, 1f64);
    fixture.write_fader_control(FixtureFaderControl::ColorMixer(ColorChannel::Red), value.0);
    fixture.write_fader_control(
        FixtureFaderControl::ColorMixer(ColorChannel::Green),
        value.1,
    );
    fixture.write_fader_control(FixtureFaderControl::ColorMixer(ColorChannel::Blue), value.2);
    let result = fixture.get_dmx_values();

    for i in 0..count {
        assert_eq!(expected.0, result[(i * 3) as usize]);
        assert_eq!(expected.1, result[(i * 3 + 1) as usize]);
        assert_eq!(expected.2, result[(i * 3 + 2) as usize]);
    }
}

#[test_case(1f64, 255, 255)]
#[test_case(0.5f64, 127, 255)]
fn write_fader_control_should_support_fine_values(value: f64, first_bytes: u8, second_bytes: u8) {
    let controls = create_controls("Intensity".to_string(), FixtureFaderControl::Intensity);
    let mode = FixtureMode::new(
        Default::default(),
        vec![FixtureChannelDefinition {
            name: "Intensity".into(),
            resolution: ChannelResolution::Fine(0, 1),
        }],
        controls.into(),
        Default::default(),
    );
    let mut fixture = create_test_fixture([mode]);

    fixture.write_fader_control(FixtureFaderControl::Intensity, value);
    let result = fixture.get_dmx_values();

    assert_eq!(first_bytes, result[0]);
    assert_eq!(second_bytes, result[1]);
}

#[test_case(1f64, 255, 255)]
#[test_case(0.5f64, 127, 255)]
fn write_fader_control_should_support_fine_values_for_sub_fixtures(
    value: f64,
    first_bytes: u8,
    second_bytes: u8,
) {
    let sub_fixture_controls = create_controls(
        SubFixtureControlChannel::Channel("Intensity".into()),
        FixtureFaderControl::Intensity,
    );
    let sub_fixture = SubFixtureDefinition::new(1, Default::default(), sub_fixture_controls);
    let mode = FixtureMode::new(
        Default::default(),
        vec![FixtureChannelDefinition {
            name: "Intensity".into(),
            resolution: ChannelResolution::Fine(0, 1),
        }],
        Default::default(),
        vec![sub_fixture],
    );
    let mut fixture = create_test_fixture([mode]);
    let mut sub_fixture = fixture
        .sub_fixture_mut(1)
        .expect("Sub fixture with id 1 should exist");

    sub_fixture.write_fader_control(FixtureFaderControl::Intensity, value);
    let result = fixture.get_dmx_values();

    assert_eq!(first_bytes, result[0]);
    assert_eq!(second_bytes, result[1]);
}

fn single_channel_mode(
    name: &str,
    controls: impl Into<FixtureControls<FixtureControlChannel>>,
) -> FixtureMode {
    FixtureMode::new(
        Default::default(),
        vec![FixtureChannelDefinition {
            name: name.into(),
            resolution: ChannelResolution::Coarse(0),
        }],
        controls.into(),
        Default::default(),
    )
}

fn create_controls<TChannel>(
    channel: TChannel,
    fader_control: FixtureFaderControl,
) -> FixtureControls<TChannel> {
    use FixtureFaderControl::*;
    let mut controls = FixtureControls::default();

    match fader_control {
        Intensity => controls.intensity = Some(channel),
        Shutter => controls.shutter = Some(channel),
        ColorWheel => {
            controls.color_wheel = Some(ColorWheelGroup {
                channel,
                colors: vec![],
            })
        }
        Pan => {
            controls.pan = Some(AxisGroup {
                channel,
                angle: None,
            })
        }
        Tilt => {
            controls.tilt = Some(AxisGroup {
                channel,
                angle: None,
            })
        }
        Focus => controls.focus = Some(channel),
        Zoom => controls.zoom = Some(channel),
        Prism => controls.prism = Some(channel),
        Iris => controls.iris = Some(channel),
        Frost => controls.frost = Some(channel),
        Gobo => {
            controls.gobo = Some(GoboGroup {
                channel,
                gobos: vec![],
            })
        }
        ColorMixer(_) => unimplemented!(),
        Generic(label) => controls.generic.push(GenericControl { channel, label }),
    }

    controls
}

fn create_test_fixture(modes: impl IntoIterator<Item = FixtureMode>) -> Fixture {
    let definition = test_definition(modes.into_iter().collect());
    Fixture::new(
        1,
        Default::default(),
        definition,
        None,
        None,
        0,
        None,
        Default::default(),
    )
}

fn test_definition(modes: Vec<FixtureMode>) -> FixtureDefinition {
    FixtureDefinition {
        id: Default::default(),
        name: Default::default(),
        modes,
        tags: Default::default(),
        manufacturer: Default::default(),
        physical: Default::default(),
        provider: "test",
    }
}
