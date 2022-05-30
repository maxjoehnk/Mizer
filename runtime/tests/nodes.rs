use crate::utils::add_node;
use mizer_module::Runtime;
use mizer_node::{NodeLink, NodePath, PortType, ProcessingNode};
use mizer_nodes::{Node, OscillatorNode, SequenceNode};
use mizer_runtime::*;

mod utils;

#[test]
fn oscillator() {
    run_pipeline_with_node(OscillatorNode::default(), 60)
}

#[test]
fn sequence() {
    let node = SequenceNode {
        steps: vec![
            (0., 0.).into(),
            (1., 0.5, true).into(),
            (2., 1.).into(),
            (3., 0.75).into(),
            (3.5, 1.).into(),
        ],
    };
    run_pipeline_with_node(node, 240)
}

fn run_pipeline_with_node<N: Into<Node> + ProcessingNode + 'static>(node: N, frames: usize) {
    let clock = utils::TestClock::default();
    let sink = utils::TestSink::new();
    let mut runtime = CoordinatorRuntime::with_clock(clock);
    let node_type = node.node_type();
    add_node(
        runtime.injector_mut(),
        node_type,
        Some(node.into()),
        sink.clone(),
    );

    for _ in 0..frames {
        runtime.process();
    }

    let frames = sink.frames();
    insta::assert_debug_snapshot!(frames);
}
