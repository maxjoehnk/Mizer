use mizer_fixtures::definition::{ColorChannel, FixtureControl};
use crate::models::FixtureId;

use crate::models::programmer::*;

impl WriteControlRequest {
    pub fn as_controls(self) -> Vec<(FixtureControl, f64)> {
        use crate::models::FixtureControl::*;

        match (self.control, self.value) {
            (INTENSITY, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureControl::Intensity, value)]
            }
            (SHUTTER, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureControl::Shutter, value)]
            }
            (FOCUS, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureControl::Focus, value)]
            }
            (ZOOM, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureControl::Zoom, value)]
            }
            (PRISM, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureControl::Iris, value)]
            }
            (IRIS, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureControl::Iris, value)]
            }
            (FROST, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureControl::Frost, value)]
            }
            (PAN, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureControl::Pan, value)]
            }
            (TILT, Some(WriteControlRequest_oneof_value::fader(value))) => {
                vec![(FixtureControl::Tilt, value)]
            }
            (COLOR, Some(WriteControlRequest_oneof_value::color(value))) => vec![
                (FixtureControl::Color(ColorChannel::Red), value.red),
                (FixtureControl::Color(ColorChannel::Green), value.green),
                (FixtureControl::Color(ColorChannel::Blue), value.blue),
            ],
            (GENERIC, Some(WriteControlRequest_oneof_value::generic(value))) => {
                vec![(FixtureControl::Generic(value.name), value.value)]
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
