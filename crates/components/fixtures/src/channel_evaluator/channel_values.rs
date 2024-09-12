use std::collections::HashMap;
use crate::channels::{FixtureChannel, FixtureValue};
use crate::FixturePriority;

#[derive(Debug, Default, Clone)]
pub(crate) struct ChannelValues {
    values: HashMap<FixtureChannel, ChannelValue>,
}

#[derive(Debug, Clone, PartialEq)]
pub(crate) struct ChannelValue {
    values: Vec<(FixturePriority, FixtureValue)>,
}

impl Default for ChannelValue {
    fn default() -> Self {
        ChannelValue {
            values: Vec::with_capacity(10),
        }
    }
}

impl ChannelValue {
    pub fn insert(&mut self, value: FixtureValue, priority: FixturePriority) {
        self.values.push((priority, value));
    }

    pub fn get(&self) -> Option<f64> {
        profiling::scope!(
            "ChannelValue::get",
            &format!("values: {}", self.values.len())
        );
        // TODO: find highest htp value before ltp values
        self.values
            .iter()
            .max_by_key(|(priority, _)| *priority)
            .map(|(_, value)| {
                // let FixtureValue::Absolute(value) = value;
                let FixtureValue::Percent(value) = value;

                *value
            })
            .map(|value| value.clamp(0., 1.))
    }

    pub fn clear(&mut self) {
        self.values.clear();
    }
}

impl ChannelValues {
    pub fn insert(&mut self, channel: FixtureChannel, value: FixtureValue, priority: FixturePriority) {
        let values = self.values.entry(channel).or_default();
        values.insert(value, priority);
    }

    pub fn get(&self, channel: FixtureChannel) -> Option<f64> {
        self.values.get(&channel).and_then(|values| values.get())
    }

    pub fn iter(&self) -> impl Iterator<Item = (FixtureChannel, f64)> + '_ {
        self.values
            .iter()
            .filter_map(|(channel, values)| values.get().map(|value| (*channel, value)))
    }

    pub fn clear(&mut self) {
        for value in self.values.values_mut() {
            value.clear();
        }
    }

    pub(crate) fn write(&mut self, channel: FixtureChannel, value: FixtureValue) {
        self.write_priority(channel, value, Default::default());
    }

    pub(crate) fn write_priority(&mut self, channel: FixtureChannel, value: FixtureValue, priority: FixturePriority) {
        tracing::trace!("write {channel} -> {value} ({priority:?})");
        self.insert(channel, value, priority);
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;
    use crate::LTPPriority;

    #[test_case(LTPPriority::Lowest, 0.5, LTPPriority::High, 1.0, 1.0)]
    #[test_case(LTPPriority::Normal, 0.5, LTPPriority::Low, 1.0, 0.5)]
    #[test_case(LTPPriority::Low, 1.25, LTPPriority::High, 0.75, 0.75)]
    fn channel_value_should_return_value_with_highest_priority(
        level_a: LTPPriority,
        value_a: f64,
        level_b: LTPPriority,
        value_b: f64,
        expected: f64,
    ) {
        let mut channel_value = super::ChannelValue::default();
        channel_value.insert(value_a, level_a.into());
        channel_value.insert(value_b, level_b.into());

        let result = channel_value.get();

        assert_eq!(expected, result.unwrap());
    }
}
