use crate::*;
use mizer_nodes::MidiInputNode;

pub fn create_programmer_highlight_mapping(midi_input: MidiInputNode) -> NodeTemplate {
    NodeTemplate {
        nodes: node_templates! {
            "programmer" => NodeRequest::Existing("/programmer-0".into()),
            "midi" => NodeRequest::New(Node::MidiInput(midi_input))
        },
        links: vec![link_template!("midi", "value" => "programmer", "Highlight")],
    }
}
