use mizer_node_api::*;
use mizer_protocol_midi::*;

pub struct MidiOutputNode {}

impl MidiOutputNode {
    pub fn new() -> Self {
        MidiOutputNode {}
    }
}

impl ProcessingNode for MidiOutputNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("MidiOutputNode").with_inputs(vec![NodeInput::numeric("value")])
    }
}

impl SourceNode for MidiOutputNode {}
impl DestinationNode for MidiOutputNode {}
