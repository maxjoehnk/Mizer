use crate::models;
use mizer_sequencer::effects;
use protobuf::{EnumOrUnknown, MessageField};

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
            ..Default::default()
        }
    }
}

impl From<effects::EffectStep> for models::EffectStep {
    fn from(step: effects::EffectStep) -> Self {
        Self {
            value: MessageField::some(step.value.into()),
            control_point: Some(step.control_point.into()),
            ..Default::default()
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
            control: EnumOrUnknown::new(channel.control.into()),
            steps: channel
                .steps
                .into_iter()
                .map(models::EffectStep::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<effects::EffectControlPoint> for models::effect_step::Control_point {
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

impl From<models::effect_step::Control_point> for effects::EffectControlPoint {
    fn from(control_point: models::effect_step::Control_point) -> Self {
        match control_point {
            models::effect_step::Control_point::Simple(_) => Self::Simple,
            models::effect_step::Control_point::Quadratic(point) => {
                Self::Quadratic([point.c0a, point.c0b])
            }
            models::effect_step::Control_point::Cubic(point) => {
                Self::Cubic([point.c0a, point.c0b], [point.c1a, point.c1b])
            }
        }
    }
}
