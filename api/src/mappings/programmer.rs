use crate::models::programmer::*;

impl From<WriteChannelsRequest_oneof_value> for mizer_fixtures::programmer::FixtureValue {
    fn from(value: WriteChannelsRequest_oneof_value) -> Self {
        match value {
            WriteChannelsRequest_oneof_value::color(color) => {
                Self::Color(color.red, color.green, color.blue)
            }
            WriteChannelsRequest_oneof_value::fader(value) => Self::Fader(value),
        }
    }
}
