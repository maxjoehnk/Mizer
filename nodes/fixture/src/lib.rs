use mizer_node_api::*;
use mizer_fixtures::fixture::Fixture;
use std::collections::HashMap;

pub struct FixtureNode {
    fixture: Fixture,
    outputs: Vec<BatchedDmxSender>,
    inputs: HashMap<String, Vec<NumericChannel>>,
}

impl FixtureNode {
    pub fn new(fixture: Fixture) -> Self {
        let mut node = FixtureNode {
            fixture,
            outputs: Default::default(),
            inputs: Default::default()
        };
        for input in node.get_inputs() {
            node.inputs.insert(input.name, Default::default());
        }
        node
    }

    fn get_inputs(&self) -> Vec<NodeInput> {
        self.fixture.get_channels()
            .into_iter()
            .map(|channel| NodeInput::numeric(channel.name))
            .collect()
    }
}

impl ProcessingNode for FixtureNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("FixtureNode")
            .with_outputs(vec![NodeOutput::dmx("output")])
            .with_inputs(self.get_inputs())
    }

    fn process(&mut self) {
        for (name, channels) in self.inputs.iter() {
            for channel in channels {
                if let Some(value) = channel.recv_last().unwrap() {
                    self.fixture.write(name, value);
                }
            }
        }
        let buffer = self.fixture.get_dmx_values();
        for output in self.outputs.iter() {
            output[0].send(buffer.to_vec());
        }
    }
}

impl InputNode for FixtureNode {
    fn connect_numeric_input(&mut self, input: &str, channel: NumericChannel) -> ConnectionResult {
        if let Some(channels) = self.inputs.get_mut(input) {
            channels.push(channel);
            Ok(())
        }else {
            Err(ConnectionError::InvalidInput)
        }
    }
}

impl OutputNode for FixtureNode {
    fn connect_to_dmx_input(&mut self, output: &str, node: &mut impl InputNode, input: &str) -> ConnectionResult {
        if output == "output" {
            let (tx, channel) = DmxChannel::batched(self.fixture.universe, 1);
            node.connect_dmx_input(input, &[channel])?;
            self.outputs.push(tx);
            Ok(())
        } else {
            Err(ConnectionError::InvalidOutput(output.to_string()))
        }
    }
}
