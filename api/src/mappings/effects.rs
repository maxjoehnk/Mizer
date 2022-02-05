use crate::models;
use mizer_sequencer::effects;
use protobuf::SingularPtrField;

impl From<effects::Effect> for models::Effect {
    fn from(effect: effects::Effect) -> Self {
        Self {
            id: effect.id,
            name: effect.name,
            steps: effect.steps.into_iter()
                .map(models::EffectStep::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<effects::EffectStep> for models::EffectStep {
    fn from(step: effects::EffectStep) -> Self {
        Self {
            channels: step.channels.into_iter()
                .map(models::EffectChannel::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<effects::EffectChannel> for models::EffectChannel {
    fn from(step: effects::EffectChannel) -> Self {
        Self {
            control: step.control.into(),
            value: SingularPtrField::some(step.value.into()),
            control_point: Some(step.control_point.into()),
            ..Default::default()
        }
    }
}

impl From<effects::EffectControlPoint> for models::EffectChannel_oneof_control_point {
    fn from(control_point: effects::EffectControlPoint) -> Self {
        match control_point {
            effects::EffectControlPoint::Simple => Self::simple(Default::default()),
            effects::EffectControlPoint::Quadratic(c) => Self::quadratic(models::QuadraticControlPoint {
                c0a: c[0],
                c0b: c[1],
                ..Default::default()
            }),
            effects::EffectControlPoint::Cubic(c0, c1) => Self::cubic(models::CubicControlPoint {
                c0a: c0[0],
                c0b: c0[1],
                c1a: c1[0],
                c1b: c1[1],
                ..Default::default()
            }),
        }
    }
}
