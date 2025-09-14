use crate::manager::{FadeTimings, FixtureValueSource};
use crate::FixturePriority;
use serde::{Deserialize, Serialize};
use std::collections::{HashMap, HashSet};
use std::fmt;
use std::ops::Add;
use std::time::{Duration, Instant};

#[derive(Debug, Default, Clone)]
pub(crate) struct ChannelsWithValues {
    values: HashMap<String, ChannelValues>,
}

#[derive(Debug, Clone, PartialEq, Serialize)]
pub(crate) struct ChannelValues {
    master: Option<f64>,
    pub(crate) values: Vec<ChannelValue>,
    pub(crate) previous_values: Vec<ChannelValue>,
    // TODO: This should probably support multiple fades but to reduce complexity we will always replace the last one for now
    pub(crate) active_fade: Option<FadeState>,
    value: Option<f64>,
    is_flushed: bool,
}

#[derive(Debug, Clone, PartialEq, Serialize)]
pub(crate) struct FadeState {
    pub priority: FixturePriority,
    #[serde(skip)]
    pub start_time: Instant,
    pub duration: Duration,
    pub start_value: RawChannelValue,
}

impl FadeState {
    pub fn from_value(value: &ChannelValue) -> Option<Self> {
        let Some(fade_out) = value.fade_timings.fade_out else {
            return None;
        };

        Some(FadeState {
            priority: value.priority,
            start_time: Instant::now(),
            duration: fade_out,
            start_value: value.value,
        })
    }

    pub fn fade(&mut self, target_value: f64) -> Option<f64> {
        let elapsed = self.start_time.elapsed();
        if elapsed >= self.duration {
            return None;
        }

        let progress = elapsed.as_secs_f64() / self.duration.as_secs_f64();
        let value = match self.start_value {
            RawChannelValue::Absolute(start_value) => start_value + (target_value - start_value) * progress,
            RawChannelValue::Relative(start_value) => target_value + (start_value - (start_value * progress)),
        };
        Some(value.clamp(0., 1.))
    }

    pub(crate) fn remaining(&self) -> Duration {
        let elapsed = self.start_time.elapsed();
        if elapsed >= self.duration {
            return Duration::ZERO;
        }

        self.duration - elapsed
    }
}

#[derive(Debug, Clone, PartialEq, Serialize)]
pub(crate) struct ChannelValue<TValue = RawChannelValue> {
    pub priority: FixturePriority,
    pub value: TValue,
    pub source: Option<FixtureValueSource>,
    pub fade_timings: FadeTimings,
}

impl ChannelValue {
    fn try_to_absolute(&self) -> Option<ChannelValue<f64>> {
        match self.value {
            RawChannelValue::Absolute(value) => Some(ChannelValue {
                priority: self.priority,
                value,
                source: self.source.clone(),
                fade_timings: self.fade_timings,
            }),
            RawChannelValue::Relative(_) => None,
        }
    }

    fn try_to_relative(&self) -> Option<ChannelValue<f64>> {
        match self.value {
            RawChannelValue::Relative(value) => Some(ChannelValue {
                priority: self.priority,
                value,
                source: self.source.clone(),
                fade_timings: self.fade_timings,
            }),
            RawChannelValue::Absolute(_) => None,
        }
    }
}

// TODO: Find a better name for ChannelValue and RawChannelValue
#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub enum RawChannelValue {
    Absolute(f64),
    Relative(f64),
}

impl fmt::Display for RawChannelValue {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Absolute(value) => write!(f, "{:.2}", value),
            Self::Relative(value) if value.is_sign_positive() => write!(f, "+{:.2}", value),
            Self::Relative(value) => write!(f, "-{:.2}", value),
        }
    }
}

impl Add for RawChannelValue {
    type Output = Self;

    fn add(self, other: Self) -> Self::Output {
        match (self, other) {
            (RawChannelValue::Absolute(a), RawChannelValue::Absolute(b)) => {
                RawChannelValue::Absolute(a + b)
            }
            (RawChannelValue::Relative(a), RawChannelValue::Relative(b)) => {
                RawChannelValue::Relative(a + b)
            }
            (RawChannelValue::Absolute(a), RawChannelValue::Relative(b)) => {
                RawChannelValue::Absolute(a + b)
            }
            (RawChannelValue::Relative(a), RawChannelValue::Absolute(b)) => {
                RawChannelValue::Absolute(a + b)
            }
        }
    }
}

impl From<f64> for RawChannelValue {
    fn from(value: f64) -> Self {
        Self::Absolute(value)
    }
}

impl Default for ChannelValues {
    fn default() -> Self {
        ChannelValues {
            master: None,
            values: Vec::with_capacity(10),
            previous_values: Vec::with_capacity(10),
            active_fade: Default::default(),
            is_flushed: true,
            value: None,
        }
    }
}

impl ChannelValues {
    pub fn insert<TValue: Into<RawChannelValue>>(
        &mut self,
        value: TValue,
        priority: FixturePriority,
        source: Option<FixtureValueSource>,
        fade_timings: FadeTimings,
    ) {
        self.is_flushed = false;
        self.values.push(ChannelValue {
            priority,
            value: value.into(),
            source,
            fade_timings,
        });
    }

    pub(crate) fn set_master(&mut self, master: f64) {
        self.master = Some(master.clamp(0., 1.));
    }

    // TODO: pretty sure this needs to be reworked for the relative values to work properly
    pub(crate) fn flush(&mut self) {
        profiling::scope!("ChannelValues::flush");
        if self.is_flushed {
            return;
        }

        let active_value = self.get_value().map(|v| v.value);

        let current_sources = self
            .values
            .iter()
            .filter_map(|v| v.source.as_ref().map(|s| s.id))
            .collect::<HashSet<_>>();

        let next_fade = self
            .previous_values
            .iter()
            .filter(|v| v.priority.is_htp() || v.priority.is_ltp())
            .filter_map(|v| {
                let Some(source) = v.source.as_ref() else {
                    return None;
                };
                if current_sources.contains(&source.id) {
                    return None;
                }

                FadeState::from_value(v)
            })
            .last();

        if let Some(next_fade) = next_fade {
            tracing::debug!("Starting fade {next_fade:?}");
            self.active_fade = Some(next_fade);
        }

        if let Some(active_fade) = &mut self.active_fade {
            if let Some(value) = active_fade.fade(active_value.unwrap_or(0.)) {
                self.value = Some(value);
            } else {
                tracing::debug!("Fade finished {active_fade:?}");
                self.active_fade = None;
                self.value = active_value;
            }
        } else {
            self.value = active_value;
        }

        self.is_flushed = true;
    }

    pub fn get(&self) -> Option<f64> {
        profiling::scope!(
            "ChannelValue::get",
            &format!("values: {}", self.values.len())
        );

        let target_value = {
            if let Some(ChannelValue { value, .. }) = self
                .values
                .iter()
                .filter_map(|value| value.try_to_absolute())
                .find(|value| value.priority.is_highlight())
            {
                return Some(value);
            }

            if let Some(ChannelValue { value, .. }) = self
                .values
                .iter()
                .find(|value| value.priority.is_programmer())
            {
                return match value {
                    RawChannelValue::Absolute(value) => Some(*value),
                    RawChannelValue::Relative(value) => Some(self.value.unwrap_or(0.) + *value),
                }
            }

            self.value
        };

        self.master
            .and_then(|master| target_value.map(|value| value * master.clamp(0., 1.)))
            .or(target_value)
    }

    fn get_mapped_value<TMap: Fn(&ChannelValue) -> Option<ChannelValue<f64>>>(&self, map: TMap) -> Option<ChannelValue<f64>> {
        let ltp_highest = self
            .values
            .iter()
            .filter_map(&map)
            .filter(|value| value.priority.is_ltp())
            .max_by_key(|value| value.priority)
            .map(|channel_value| ChannelValue {
                value: channel_value.value.clamp(0., 1.),
                priority: channel_value.priority,
                source: channel_value.source.clone(),
                fade_timings: channel_value.fade_timings,
            });
        let htp_highest = self
            .values
            .iter()
            .filter_map(map)
            .filter(|ChannelValue { priority, .. }| priority.is_htp())
            .map(|channel_value| ChannelValue {
                value: channel_value.value.clamp(0., 1.),
                priority: channel_value.priority,
                source: channel_value.source.clone(),
                fade_timings: channel_value.fade_timings,
            })
            .max_by(|a, b| a.value.partial_cmp(&b.value).unwrap());

        match (ltp_highest, htp_highest) {
            (None, Some(value)) => Some(value),
            (Some(value), None) => Some(value),
            (Some(ltp), Some(htp)) if ltp.value > htp.value => Some(ltp),
            (Some(_), Some(htp)) => Some(htp),
            (None, None) => None,
        }
    }

    fn get_absolute_value(&self) -> Option<ChannelValue<f64>> {
        self.get_mapped_value(|value| value.try_to_absolute())
    }

    fn get_relative_value(&self) -> Option<ChannelValue<f64>> {
        self.get_mapped_value(|value| value.try_to_relative())
    }

    fn get_value(&self) -> Option<ChannelValue<f64>> {
        let absolute_value = self.get_absolute_value()?;
        let relative_value = self.get_relative_value();

        if let Some(relative_value) = relative_value {
            Some(ChannelValue {
                value: absolute_value.value + relative_value.value,
                priority: relative_value.priority,
                source: relative_value.source.clone(),
                fade_timings: relative_value.fade_timings,
            })
        } else {
            Some(absolute_value)
        }
    }

    pub fn clear(&mut self) {
        self.previous_values.clear();

        std::mem::swap(&mut self.values, &mut self.previous_values);

        self.value = None;
    }
}

impl ChannelsWithValues {
    pub(crate) fn flush(&mut self) {
        for value in self.values.values_mut() {
            value.flush();
        }
    }

    pub(crate) fn apply_master(&mut self, channel: &str, value: f64) {
        if let Some(channel) = self.values.get_mut(channel) {
            channel.set_master(value);
        }
    }

    pub fn insert<TValue: Into<RawChannelValue>>(
        &mut self,
        channel: &String,
        value: TValue,
        priority: FixturePriority,
        source: Option<FixtureValueSource>,
        fade_timings: FadeTimings,
    ) {
        // TODO: this should be actually measured
        // perf: we don't use entry here to avoid cloning the key when it's already in the map
        if let Some(values) = self.values.get_mut(channel) {
            values.insert(value, priority, source, fade_timings);
        } else {
            let mut values = ChannelValues::default();
            values.insert(value, priority, source, fade_timings);
            self.values.insert(channel.clone(), values);
        }
    }

    pub fn get(&self, channel: &str) -> Option<f64> {
        self.values.get(channel).and_then(|values| values.get())
    }

    pub fn iter(&self) -> impl Iterator<Item = (&str, f64)> {
        self.values
            .iter()
            .filter_map(|(channel, values)| values.get().map(|value| (channel.as_str(), value)))
    }

    pub fn clear(&mut self) {
        for value in self.values.values_mut() {
            value.clear();
        }
    }

    pub(crate) fn get_priorities(&self, channel: &str) -> Option<&ChannelValues> {
        self.values.get(channel)
    }

    pub(crate) fn write(&mut self, name: &String, value: f64) {
        self.write_priority(name, value, Default::default());
    }

    pub(crate) fn write_priority(&mut self, name: &String, value: f64, priority: FixturePriority) {
        tracing::trace!("write {name} -> {value} ({priority:?})");
        self.write_priority_with_timings(
            name,
            value,
            priority,
            Default::default(),
            Default::default(),
        );
    }

    pub(crate) fn write_priority_with_timings<TValue: Into<RawChannelValue>>(
        &mut self,
        name: &String,
        value: TValue,
        priority: FixturePriority,
        source: Option<FixtureValueSource>,
        fade_timings: FadeTimings,
    ) {
        let value = value.into();
        tracing::trace!("write {name} -> {value} ({priority:?}, {source:?}, {fade_timings:?})");
        self.insert(name, value, priority, source, fade_timings);
    }
}
