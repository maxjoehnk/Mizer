mod channels;

pub use crate::channels::*;

pub trait ProcessingNode: InputNode + OutputNode {
    fn process(&mut self) {}

    fn set_int_property<S: Into<String>>(&mut self, property: S, value: i64) {}
    fn set_float_property<S: Into<String>>(&mut self, property: S, value: f64) {}
}

pub trait InputNode {
    fn connect_dmx_input(&mut self, channels: &[DmxChannel]) {}
    fn connect_numeric_input(&mut self, channel: NumericChannel) {}
    fn connect_trigger_input(&mut self, channel: TriggerChannel) {}
    fn connect_clock_input(&mut self, channel: ClockChannel) {}
    fn connect_video_input(&mut self, source: &impl gstreamer::ElementExt) {}
}

pub trait OutputNode {
    fn connect_to_dmx_input(&mut self, input: &mut impl InputNode) {}
    fn connect_to_numeric_input(&mut self, input: &mut impl InputNode) {}
    fn connect_to_trigger_input(&mut self, input: &mut impl InputNode) {}
    fn connect_to_clock_input(&mut self, input: &mut impl InputNode) {}
    fn connect_to_video_input(&mut self, input: &mut impl InputNode) {}
}

mod deps {
    pub use crossbeam_channel::{Receiver, Sender, TryRecvError};
    pub use crossbeam_channel::unbounded as channel;
}
