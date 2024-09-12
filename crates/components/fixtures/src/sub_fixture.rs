use crate::channel_evaluator::ChannelValues;
use crate::channels::{FixtureChannel, FixtureValue, SubFixtureChannelMode};
use crate::fixture::{IFixture, IFixtureMut};
use crate::FixturePriority;

#[derive(Debug)]
pub struct SubFixtureMut<'a> {
    pub(crate) channel_values: &'a mut ChannelValues,
    pub(crate) definition: &'a SubFixtureChannelMode,
}

#[derive(Debug)]
pub struct SubFixture<'a> {
    pub(crate) channel_values: &'a ChannelValues,
    pub(crate) definition: &'a SubFixtureChannelMode,
}

impl<'a> IFixtureMut for SubFixtureMut<'a> {
    fn write_channel(&mut self, channel: FixtureChannel, value: FixtureValue, priority: FixturePriority) {
        profiling::scope!("SubFixtureMut::write_channel");
        self.channel_values.write_priority(channel, value, priority);
    }
}

impl<'a> IFixture for SubFixtureMut<'a> {
    fn read_channel(&self, channel: FixtureChannel) -> Option<f64> {
        profiling::scope!("SubFixtureMut::read_channel");
        self.channel_values.get(channel)
    }
}

impl<'a> IFixture for SubFixture<'a> {
    fn read_channel(&self, channel: FixtureChannel) -> Option<f64> {
        profiling::scope!("SubFixture::read_channel");
        self.channel_values.get(channel)
    }
}
