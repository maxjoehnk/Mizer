use crate::*;
use mizer_nodes::{MidiInputNode, SequencerNode};

pub fn create_sequencer_stop_mapping(sequence_id: u32, midi_input: MidiInputNode) -> NodeTemplate {
    NodeTemplate {
        nodes: node_templates! {
            "sequence" => NodeRequest::New(Node::Sequencer(SequencerNode {
                sequence_id
            })),
            "midi" => NodeRequest::New(Node::MidiInput(midi_input))
        },
        links: vec![link_template!("midi", "value" => "sequence", "Stop")],
    }
}
