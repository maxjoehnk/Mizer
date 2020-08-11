use mizer_node_api::*;

pub struct ConvertToDmxNode {
    channel: u16,
    universe: u16,
    outputs: Vec<DmxSender>,
    inputs: Vec<NumericChannel>,
}

impl ConvertToDmxNode {
    pub fn new(universe: Option<u16>, channel: Option<u16>) -> Self {
        let universe = universe.unwrap_or(1);
        let channel = channel.unwrap_or(1);
        log::trace!("New ConvertToDmxNode({}.{:0>3})", universe, channel);

        ConvertToDmxNode {
            universe,
            channel,
            outputs: Vec::new(),
            inputs: Vec::new(),
        }
    }
}

impl Default for ConvertToDmxNode {
    fn default() -> Self {
        ConvertToDmxNode::new(None, None)
    }
}

impl ProcessingNode for ConvertToDmxNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("ConvertToDmxNode")
            .with_inputs(vec![NodeInput::numeric("value")])
            .with_outputs(vec![NodeOutput::dmx("dmx")])
    }

    fn process(&mut self) {
        let mut last = None;
        for channel in &self.inputs {
            match channel.recv() {
                Ok(Some(value)) => last = Some(value),
                Ok(None) => {},
                Err(err) => println!("{:?}", err),
            }
        }
        if let Some(value) = last {
            let bounded = (value as i64).min(255).max(0) as u8;
            for tx in &self.outputs {
                tx.send(bounded);
            }
        }
    }
}
impl InputNode for ConvertToDmxNode {
    fn connect_numeric_input(&mut self, input: &str, channel: NumericChannel) -> ConnectionResult {
        if input == "value" {
            self.inputs.push(channel);
            Ok(())
        }else {
            Err(ConnectionError::InvalidInput)
        }
    }
}
impl OutputNode for ConvertToDmxNode {
    fn connect_to_dmx_input(&mut self, output: &str, node: &mut impl InputNode, input: &str) -> ConnectionResult {
        if output == "dmx" {
            let (tx, channel) = DmxChannel::new(self.universe, self.channel);
            node.connect_dmx_input(input, &[channel])?;
            self.outputs.push(tx);
            Ok(())
        } else {
            Err(ConnectionError::InvalidOutput(output.to_string()))
        }
    }
}

#[cfg(test)]
mod tests {
    use mizer_node_api::*;
    use test_case::test_case;
    use super::*;

    #[test_case("input")]
    #[test_case("another input")]
    fn convert_numeric_to_dmx_should_connect_to_dmx_input(input: &str) {
        let mut receiver = TestNode::default();
        let mut node = ConvertToDmxNode::new(None, None);

        node.connect_to_dmx_input("dmx", &mut receiver, input).unwrap();

        assert_eq!(receiver.dmx_channels.get(input).unwrap().len(), 1);
        let channel = receiver.dmx_channels.get(input).unwrap().get(0).unwrap();
        assert_eq!(channel.universe, 1);
        assert_eq!(channel.channel, 1);
    }

    #[test_case(1, 2)]
    #[test_case(2, 5)]
    #[test_case(256, 512)]
    fn convert_numeric_to_dmx_should_set_universe_and_channel(universe: u16, channel: u16) {
        let mut receiver = TestNode::default();
        let mut node = ConvertToDmxNode::new(Some(universe), Some(channel));

        node.connect_to_dmx_input("dmx", &mut receiver, "input").unwrap();

        let dmx_channel = receiver.dmx_channels.get("input").unwrap().get(0).unwrap();
        assert_eq!(dmx_channel.universe, universe);
        assert_eq!(dmx_channel.channel, channel);
    }

    #[test_case(0f64, 0u8)]
    #[test_case(1f64, 1u8)]
    #[test_case(255f64, 255u8)]
    #[test_case(256f64, 255u8; "upper bound")]
    #[test_case(-1f64, 0u8; "lower bound")]
    fn convert_numeric_to_dmx_should_emit_values(input: f64, expected: u8) {
        let mut receiver = TestNode::default();
        let mut node = ConvertToDmxNode::default();
        let (tx, rx) = NumericChannel::new();
        node.connect_numeric_input("value", rx).unwrap();
        node.connect_to_dmx_input("dmx", &mut receiver, "input").unwrap();
        let dmx_channel = receiver.dmx_channels.get("input").unwrap().get(0).unwrap();

        tx.send(input);
        node.process();

        assert_eq!(dmx_channel.recv().unwrap(), Some(expected));
    }
}
