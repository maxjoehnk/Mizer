use mizer_fixtures::channels::{FixtureChannel, FixtureColorChannel, SubFixtureChannelMode};
use mizer_fixtures::definition::{
    FixtureDefinition,
};
use mizer_open_fixture_library_provider::{
    Capability, Channel, FixtureManufacturer, Matrix, MatrixPixels, Mode,
    OpenFixtureLibraryFixtureDefinition,
};

macro_rules! hashmap {
    ($( $key: expr => $val: expr ),*) => {{
         let mut map = ::std::collections::HashMap::new();
         $( map.insert($key, $val); )*
         map
    }}
}

#[test]
fn should_map_pixels_to_sub_fixtures() {
    let definition = create_definition();

    let fixture = FixtureDefinition::from(definition);

    let mode = &fixture.modes[0];
    assert_eq!(mode.children.len(), 3);
    assert_sub_fixture(&mode.children[0], 1);
    assert_sub_fixture(&mode.children[1], 2);
    assert_sub_fixture(&mode.children[2], 3);
}

fn assert_sub_fixture(sub_fixture: &SubFixtureChannelMode, index: u32) {
    assert_eq!(sub_fixture.id, index);
    assert_eq!(sub_fixture.name.to_string(), format!("Pixel {}", index));
    assert_eq!(sub_fixture.channels.len(), 3);
    assert!(sub_fixture.channels.contains_key(&FixtureChannel::ColorMixer(FixtureColorChannel::Red)));
    assert!(sub_fixture.channels.contains_key(&FixtureChannel::ColorMixer(FixtureColorChannel::Green)));
    assert!(sub_fixture.channels.contains_key(&FixtureChannel::ColorMixer(FixtureColorChannel::Blue)));
}

#[test]
fn should_expose_sub_channels() {
    let definition = create_definition();

    let fixture = FixtureDefinition::from(definition);

    let mode = &fixture.modes[0];
    assert_eq!(mode.get_channels().len(), 9);
}

#[test]
fn should_create_delegate_channels() {
    let definition = create_definition();

    let fixture = FixtureDefinition::from(definition);

    let mode = &fixture.modes[0];
    assert!(mode.controls.color_mixer.is_some());
    assert_eq!(
        mode.controls.color_mixer.as_ref().unwrap(),
        &ColorGroup::Rgb {
            red: FixtureControlChannel::Delegate,
            green: FixtureControlChannel::Delegate,
            blue: FixtureControlChannel::Delegate,
            amber: None,
            white: None,
        }
    );
}

fn create_definition() -> OpenFixtureLibraryFixtureDefinition {
    OpenFixtureLibraryFixtureDefinition {
        name: Default::default(),
        short_name: Default::default(),
        physical: Default::default(),
        manufacturer: FixtureManufacturer {
            name: Default::default(),
        },
        categories: Default::default(),
        fixture_key: Default::default(),
        modes: vec![Mode {
            name: Default::default(),
            channels: vec![
                Some("Red 1".into()),
                Some("Green 1".into()),
                Some("Blue 1".into()),
                Some("Red 2".into()),
                Some("Green 2".into()),
                Some("Blue 2".into()),
                Some("Red 3".into()),
                Some("Green 3".into()),
                Some("Blue 3".into()),
            ],
            short_name: None,
        }],
        available_channels: hashmap![
            "Red 1".into() => Channel {
                default_value: None,
                pixel_key: Some("1".into()),
                capabilities: vec![
                    Capability::ColorIntensity {
                         color: "#ff0000".into()
                    }
                ],
                fine_channel_aliases: Default::default()
            },
            "Red 2".into() => Channel {
                default_value: None,
                pixel_key: Some("2".into()),
                capabilities: vec![
                    Capability::ColorIntensity {
                         color: "#ff0000".into()
                    }
                ],
                fine_channel_aliases: Default::default()
            },
            "Red 3".into() => Channel {
                default_value: None,
                pixel_key: Some("3".into()),
                capabilities: vec![
                    Capability::ColorIntensity {
                         color: "#ff0000".into()
                    }
                ],
                fine_channel_aliases: Default::default()
            },
            "Green 1".into() => Channel {
                default_value: None,
                pixel_key: Some("1".into()),
                capabilities: vec![
                    Capability::ColorIntensity {
                         color: "#00ff00".into()
                    }
                ],
                fine_channel_aliases: Default::default()
            },
            "Green 2".into() => Channel {
                default_value: None,
                pixel_key: Some("2".into()),
                capabilities: vec![
                    Capability::ColorIntensity {
                         color: "#00ff00".into()
                    }
                ],
                fine_channel_aliases: Default::default()
            },
            "Green 3".into() => Channel {
                default_value: None,
                pixel_key: Some("3".into()),
                capabilities: vec![
                    Capability::ColorIntensity {
                         color: "#00ff00".into()
                    }
                ],
                fine_channel_aliases: Default::default()
            },
            "Blue 1".into() => Channel {
                default_value: None,
                pixel_key: Some("1".into()),
                capabilities: vec![
                    Capability::ColorIntensity {
                         color: "#0000ff".into()
                    }
                ],
                fine_channel_aliases: Default::default()
            },
            "Blue 2".into() => Channel {
                default_value: None,
                pixel_key: Some("2".into()),
                capabilities: vec![
                    Capability::ColorIntensity {
                         color: "#0000ff".into()
                    }
                ],
                fine_channel_aliases: Default::default()
            },
            "Blue 3".into() => Channel {
                default_value: None,
                pixel_key: Some("3".into()),
                capabilities: vec![
                    Capability::ColorIntensity {
                         color: "#0000ff".into()
                    }
                ],
                fine_channel_aliases: Default::default()
            }
        ],
        matrix: Some(Matrix {
            pixels: MatrixPixels::PixelKeys(vec![vec![vec![
                Some("1".into()),
                Some("2".into()),
                Some("3".into()),
            ]]]),
        }),
        wheels: Default::default(),
    }
}
