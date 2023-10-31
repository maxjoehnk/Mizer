use crate::proto::timecode::*;

impl From<mizer_timecode::TimecodeTrack> for Timecode {
    fn from(value: mizer_timecode::TimecodeTrack) -> Self {
        Self {
            id: value.id.into(),
            name: value.name,
            controls: value
                .controls
                .into_iter()
                .map(TimecodeControlValues::from)
                .collect(),
        }
    }
}

impl From<mizer_timecode::TimecodeControlValues> for TimecodeControlValues {
    fn from(value: mizer_timecode::TimecodeControlValues) -> Self {
        Self {
            control_id: value.id.into(),
            steps: value
                .spline
                .steps
                .into_iter()
                .map(timecode_control_values::Step::from)
                .collect(),
        }
    }
}

impl From<mizer_util::SplineStep> for timecode_control_values::Step {
    fn from(value: mizer_util::SplineStep) -> Self {
        Self {
            x: value.x,
            y: value.y,
            c0a: value.c0a,
            c0b: value.c0b,
            c1a: value.c1a,
            c1b: value.c1b,
        }
    }
}

impl From<mizer_timecode::TimecodeControl> for TimecodeControl {
    fn from(value: mizer_timecode::TimecodeControl) -> Self {
        Self {
            id: value.id.into(),
            name: value.name,
        }
    }
}
