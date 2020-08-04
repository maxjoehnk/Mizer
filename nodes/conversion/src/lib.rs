use mizer_node_api::*;

pub struct ConvertToDmxNode {
    channel: u16,
    universe: u16,
    outputs: Vec<DmxSender>,
    inputs: Vec<NumericChannel>,
}

impl ConvertToDmxNode {
    pub fn new(universe: Option<u16>, channel: Option<u16>) -> Self {
        let universe = universe.unwrap_or_default();
        let channel = channel.unwrap_or_default();
        log::trace!("New ConvertToDmxNode({}.{:0>3})", universe + 1, channel + 1);

        ConvertToDmxNode {
            universe,
            channel,
            outputs: Vec::new(),
            inputs: Vec::new(),
        }
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
