use mizer_fixtures::definition::*;
use mizer_qlcplus_provider::QlcPlusFixtureDefinition;
use strong_xml::XmlRead;

const GENERIC_RGB_DEFINITION: &str = include_str!("Generic-Generic-RGB.qxf");
const GENERIC_RGBW_DEFINITION: &str = include_str!("Generic-Generic-RGBW.qxf");
const GENERIC_SMOKE_DEFINITION: &str = include_str!("Generic-Generic-Smoke.qxf");

#[test]
fn generic_rgb() {
    let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGB_DEFINITION).unwrap();
    let definition = FixtureDefinition::from(file);

    assert_eq!(definition.name, "Generic RGB");
    assert_eq!(definition.modes.len(), 5);
    assert_eq!(definition.modes[0].name, "RGB");
    assert_eq!(definition.modes[0].channels.len(), 3);
    assert_eq!(definition.modes[1].name, "GRB");
    assert_eq!(definition.modes[1].channels.len(), 3);
    assert_eq!(definition.modes[2].name, "BGR");
    assert_eq!(definition.modes[2].channels.len(), 3);
    assert_eq!(definition.modes[3].name, "RGB Dimmer");
    assert_eq!(definition.modes[3].channels.len(), 4);
    assert_eq!(definition.modes[4].name, "Dimmer RGB");
    assert_eq!(definition.modes[4].channels.len(), 4);
    for mode in &definition.modes {
        assert_eq!(
            mode.controls.color,
            Some(ColorGroup {
                red: FixtureControlChannel::Channel("Red".into()),
                green: FixtureControlChannel::Channel("Green".into()),
                blue: FixtureControlChannel::Channel("Blue".into()),
            })
        );
    }
    assert_eq!(
        definition.modes[3].controls.intensity,
        Some(FixtureControlChannel::Channel("Dimmer".into()))
    );
    assert_eq!(
        definition.modes[4].controls.intensity,
        Some(FixtureControlChannel::Channel("Dimmer".into()))
    );
}

#[test]
fn generic_rgbw() {
    let file = QlcPlusFixtureDefinition::from_str(GENERIC_RGBW_DEFINITION).unwrap();
    let definition = FixtureDefinition::from(file);

    assert_eq!(definition.name, "Generic RGBW");
    assert_eq!(definition.modes.len(), 6);
    assert_eq!(definition.modes[0].name, "RGBW");
    assert_eq!(definition.modes[0].channels.len(), 4);
    assert_eq!(definition.modes[1].name, "WRGB");
    assert_eq!(definition.modes[1].channels.len(), 4);
    assert_eq!(definition.modes[2].name, "RGBW Dimmer");
    assert_eq!(definition.modes[2].channels.len(), 5);
    assert_eq!(definition.modes[3].name, "WRGB Dimmer");
    assert_eq!(definition.modes[3].channels.len(), 5);
    assert_eq!(definition.modes[4].name, "Dimmer RGBW");
    assert_eq!(definition.modes[4].channels.len(), 5);
    assert_eq!(definition.modes[5].name, "Dimmer WRGB");
    assert_eq!(definition.modes[5].channels.len(), 5);
    for mode in &definition.modes {
        assert_eq!(
            mode.controls.color,
            Some(ColorGroup {
                red: FixtureControlChannel::Channel("Red".into()),
                green: FixtureControlChannel::Channel("Green".into()),
                blue: FixtureControlChannel::Channel("Blue".into()),
            })
        );
    }
    assert_eq!(
        definition.modes[2].controls.intensity,
        Some(FixtureControlChannel::Channel("Dimmer".into()))
    );
    assert_eq!(
        definition.modes[3].controls.intensity,
        Some(FixtureControlChannel::Channel("Dimmer".into()))
    );
    assert_eq!(
        definition.modes[4].controls.intensity,
        Some(FixtureControlChannel::Channel("Dimmer".into()))
    );
    assert_eq!(
        definition.modes[5].controls.intensity,
        Some(FixtureControlChannel::Channel("Dimmer".into()))
    );
}

#[test]
fn generic_smoke() {
    let file = QlcPlusFixtureDefinition::from_str(GENERIC_SMOKE_DEFINITION);

    println!("{:#?}", file);
    assert!(file.is_ok());
}
