use crate::*;
use mizer_node::NodePath;
use mizer_nodes::MidiInputNode;

pub fn create_control_mapping(control: NodePath, midi_input: MidiInputNode) -> NodeTemplate {
    NodeTemplate {
        nodes: node_templates! {
            "control" => NodeRequest::Existing(control),
            "midi" => NodeRequest::New(Node::MidiInput(midi_input))
        },
        links: vec![link_template!("midi", "Output" => "control", "Input")],
    }
}
