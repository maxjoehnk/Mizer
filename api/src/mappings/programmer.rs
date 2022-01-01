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
