use mizer_node_api::*;

pub struct FaderNode {
    value: f64,
    outputs: Vec<NumericSender>,
}

impl FaderNode {
    pub fn new() -> Self {
        FaderNode {
            value: 0f64,
            outputs: Vec::new(),
        }
    }
}

impl ProcessingNode for FaderNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("FaderNode")
            .with_properties(vec![NodeProperty::numeric("value")])
            .with_outputs(vec![NodeOutput::numeric("value")])
    }

    fn set_numeric_property(&mut self, property: &str, value: f64) {
        if property == "value" {
            self.value = value;
            for tx in &self.outputs {
                tx.send(value);
            }
        }
    }
}
impl SourceNode for FaderNode {}
impl DestinationNode for FaderNode {
    fn connect_to_numeric_input(&mut self, output: &str, node: &mut impl SourceNode, input: &str) -> ConnectionResult {
        if output == "value" {
            let (sender, channel) = NumericChannel::new();
            node.connect_numeric_input(input, channel)?;
            self.outputs.push(sender);
            Ok(())
        } else {
            Err(ConnectionError::InvalidOutput(output.to_string()))
        }
    }
}
