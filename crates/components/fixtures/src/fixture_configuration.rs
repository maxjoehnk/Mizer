use std::collections::HashMap;
use std::hash::{Hash, Hasher};
use serde::{Deserialize, Serialize};
use mizer_util::LerpExt;
use crate::channels::FixtureChannel;

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct FixtureConfiguration {
    #[serde(default)]
    pub invert_pan: bool,
    #[serde(default)]
    pub invert_tilt: bool,
    #[serde(default)]
    pub reverse_pixel_order: bool,
    #[serde(default)]
    pub limits: HashMap<FixtureChannel, ChannelLimit>,
}

#[derive(Debug, Default, Copy, Clone, Deserialize, Serialize, PartialEq)]
pub struct ChannelLimit {
    #[serde(default)]
    pub min: Option<f64>,
    #[serde(default)]
    pub max: Option<f64>,
}

impl Hash for ChannelLimit {
    fn hash<H: Hasher>(&self, state: &mut H) {
        if let Some(min) = self.min {
            min.to_bits().hash(state);
        } else {
            0u64.hash(state);
        }
        if let Some(max) = self.max {
            max.to_bits().hash(state);
        } else {
            0u64.hash(state);
        }
    }
}

impl ChannelLimit {
    fn adapt_read(&self, value: f64) -> f64 {
        let min = self.min.unwrap_or(0.);
        let max = self.max.unwrap_or(1.);

        value.linear_extrapolate((min, max), (0., 1.))
    }

    fn adapt_write(&self, value: f64) -> f64 {
        let min = self.min.unwrap_or(0.);
        let max = self.max.unwrap_or(1.);

        value.linear_extrapolate((0., 1.), (min, max))
    }
}

impl FixtureConfiguration {
    pub(crate) fn adapt_write(&self, control: FixtureChannel, value: f64) -> f64 {
        let value = self.adapt_pan_tilt(control, value);
        let value = self.adapt_write_limits(control, value);

        value
    }

    pub(crate) fn adapt_read(&self, control: FixtureChannel, value: f64) -> f64 {
        let value = self.adapt_pan_tilt(control, value);
        let value = self.adapt_read_limits(control, value);

        value
    }

    fn adapt_pan_tilt(&self, control: FixtureChannel, value: f64) -> f64 {
        match control {
            FixtureChannel::Pan if self.invert_pan => (1. - value).abs(),
            FixtureChannel::Tilt if self.invert_tilt => (1. - value).abs(),
            _ => value,
        }
    }

    fn adapt_write_limits(&self, control: FixtureChannel, value: f64) -> f64 {
        if let Some(limits) = self.limits.get(&control) {
            limits.adapt_write(value)
        } else {
            value
        }
    }

    fn adapt_read_limits(&self, control: FixtureChannel, value: f64) -> f64 {
        if let Some(limits) = self.limits.get(&control) {
            limits.adapt_read(value)
        } else {
            value
        }
    }
}
