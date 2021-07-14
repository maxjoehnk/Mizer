use mizer_nodes::{EnvelopeNode, SequenceNode};

mod node_grapher;

#[test]
fn envelope() -> anyhow::Result<()> {
    let node = EnvelopeNode {
        attack: 1.,
        release: 1.,
        decay: 1.,
        sustain: 0.5,
    };

    node_grapher::graph_node_with_inputs(node, "envelope", |i| if i > 180 { 0. } else { 1. })
}

#[test]
fn envelope_with_value_changes() -> anyhow::Result<()> {
    let node = EnvelopeNode {
        attack: 1.,
        release: 1.,
        decay: 1.,
        sustain: 0.5,
    };

    node_grapher::graph_node_with_inputs(node, "envelope_with_value_changes", |i| {
        if i <= 60 {
            0.25
        } else if i <= 120 {
            0.5
        } else if i <= 180 {
            0.75
        } else {
            1.
        }
    })
}
