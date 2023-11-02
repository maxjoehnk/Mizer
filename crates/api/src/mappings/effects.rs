use mizer_fixtures::definition;
use mizer_sequencer::effects;

use crate::proto::effects as models;

impl From<effects::Effect> for models::Effect {
    fn from(effect: effects::Effect) -> Self {
        Self {
            id: effect.id,
            name: effect.name,
            channels: effect
                .channels
                .into_iter()
                .map(models::EffectChannel::from)
                .collect(),
        }
    }
}

impl From<effects::EffectStep> for models::EffectStep {
    fn from(step: effects::EffectStep) -> Self {
        Self {
            value: Some(step.value.into()),
            control_point: Some(step.control_point.into()),
        }
    }
}

impl From<models::EffectStep> for effects::EffectStep {
    fn from(step: models::EffectStep) -> Self {
        Self {
            value: step.value.unwrap().into(),
            control_point: step.control_point.unwrap().into(),
        }
    }
}

impl From<effects::EffectChannel> for models::EffectChannel {
    fn from(channel: effects::EffectChannel) -> Self {
        Self {
            control: models::EffectControl::from(channel.control) as i32,
            steps: channel
                .steps
                .into_iter()
                .map(models::EffectStep::from)
                .collect(),
        }
    }
}

impl From<definition::FixtureFaderControl> for models::EffectControl {
    fn from(value: definition::FixtureFaderControl) -> Self {
        use definition::FixtureFaderControl;
        match value {
            FixtureFaderControl::Intensity => Self::Intensity,
            FixtureFaderControl::Shutter => Self::Shutter,
            FixtureFaderControl::ColorMixer(definition::ColorChannel::Red) => Self::ColorMixerRed,
            FixtureFaderControl::ColorMixer(definition::ColorChannel::Green) => {
                Self::ColorMixerGreen
            }
            FixtureFaderControl::ColorMixer(definition::ColorChannel::Blue) => Self::ColorMixerBlue,
            FixtureFaderControl::ColorWheel => Self::ColorWheel,
            FixtureFaderControl::Pan => Self::Pan,
            FixtureFaderControl::Tilt => Self::Tilt,
            FixtureFaderControl::Focus => Self::Focus,
            FixtureFaderControl::Zoom => Self::Zoom,
            FixtureFaderControl::Prism => Self::Prism,
            FixtureFaderControl::Iris => Self::Iris,
            FixtureFaderControl::Gobo => Self::Gobo,
            FixtureFaderControl::Frost => Self::Frost,
            FixtureFaderControl::Generic(_) => Self::Generic,
        }
    }
}

impl From<models::EffectControl> for definition::FixtureFaderControl {
    fn from(value: models::EffectControl) -> Self {
        match value {
            models::EffectControl::Intensity => Self::Intensity,
            models::EffectControl::Shutter => Self::Shutter,
            models::EffectControl::ColorMixerRed => Self::ColorMixer(definition::ColorChannel::Red),
            models::EffectControl::ColorMixerGreen => {
                Self::ColorMixer(definition::ColorChannel::Green)
            }
            models::EffectControl::ColorMixerBlue => {
                Self::ColorMixer(definition::ColorChannel::Blue)
            }
            models::EffectControl::ColorWheel => Self::ColorWheel,
            models::EffectControl::Pan => Self::Pan,
            models::EffectControl::Tilt => Self::Tilt,
            models::EffectControl::Focus => Self::Focus,
            models::EffectControl::Zoom => Self::Zoom,
            models::EffectControl::Prism => Self::Prism,
            models::EffectControl::Iris => Self::Iris,
            models::EffectControl::Gobo => Self::Gobo,
            models::EffectControl::Frost => Self::Frost,
            models::EffectControl::Generic => unimplemented!(),
        }
    }
}

impl From<effects::EffectControlPoint> for models::effect_step::ControlPoint {
    fn from(control_point: effects::EffectControlPoint) -> Self {
        match control_point {
            effects::EffectControlPoint::Simple => Self::Simple(Default::default()),
            effects::EffectControlPoint::Quadratic(c) => {
                Self::Quadratic(models::QuadraticControlPoint {
                    c0a: c[0],
                    c0b: c[1],
                    ..Default::default()
                })
            }
            effects::EffectControlPoint::Cubic(c0, c1) => Self::Cubic(models::CubicControlPoint {
                c0a: c0[0],
                c0b: c0[1],
                c1a: c1[0],
                c1b: c1[1],
                ..Default::default()
            }),
        }
    }
}

impl From<models::effect_step::ControlPoint> for effects::EffectControlPoint {
    fn from(control_point: models::effect_step::ControlPoint) -> Self {
        match control_point {
            models::effect_step::ControlPoint::Simple(_) => Self::Simple,
            models::effect_step::ControlPoint::Quadratic(point) => {
                Self::Quadratic([point.c0a, point.c0b])
            }
            models::effect_step::ControlPoint::Cubic(point) => {
                Self::Cubic([point.c0a, point.c0b], [point.c1a, point.c1b])
            }
        }
    }
}
