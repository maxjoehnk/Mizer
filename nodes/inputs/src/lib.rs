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

    fn set_numeric_property<S: Into<String>>(&mut self, property: S, value: f64) {
        if property.into() == "value" {
            self.value = value;
            for tx in &self.outputs {
                tx.send(value);
            }
        }
    }
}
impl InputNode for FaderNode {}
impl OutputNode for FaderNode {
    fn connect_to_numeric_input(&mut self, output: &str, node: &mut impl InputNode, input: &str) -> ConnectionResult {
        if output == "value" {
            let (sender, channel) = NumericChannel::new();
            self.outputs.push(sender);
            node.connect_numeric_input(input, channel)?;
            Ok(())
        } else {
            Err(ConnectionError::InvalidOutput)
        }
    }
}
