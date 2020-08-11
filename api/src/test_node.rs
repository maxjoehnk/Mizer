use std::collections::HashMap;
use crate::*;

#[derive(Default)]
pub struct TestNode {
    pub dmx_channels: HashMap<String, Vec<DmxChannel>>,
    pub numeric_channels: HashMap<String, Vec<NumericChannel>>,
}

impl ProcessingNode for TestNode {
    fn get_details(&self) -> NodeDetails {
        unimplemented!()
    }
}
impl InputNode for TestNode {
    fn connect_dmx_input(&mut self, input: &str, channels: &[DmxChannel]) -> ConnectionResult {
        let dmx_channels = self.dmx_channels.entry(input.to_string()).or_default();
        dmx_channels.extend_from_slice(channels);
        Ok(())
    }

    fn connect_numeric_input(&mut self, input: &str, channel: NumericChannel) -> ConnectionResult {
        self.numeric_channels.entry(input.to_string()).or_default().push(channel);
        Ok(())
    }
}
impl OutputNode for TestNode {}
