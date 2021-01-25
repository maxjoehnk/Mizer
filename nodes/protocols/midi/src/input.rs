use mizer_protocol_midi::*;
use mizer_node_api::*;

pub struct MidiInputNode {

}

impl MidiInputNode {
    pub fn new() -> Self {
        MidiInputNode {}
    }
}

impl ProcessingNode for MidiInputNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("MidiInputNode")
            .with_outputs(vec![NodeOutput::numeric("value")])
    }
}

impl SourceNode for MidiInputNode {}
impl DestinationNode for MidiInputNode {}
