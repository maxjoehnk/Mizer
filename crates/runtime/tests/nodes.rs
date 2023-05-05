use crate::utils::add_node;
use mizer_module::Runtime;
use mizer_node::ProcessingNode;
use mizer_nodes::{Node, OscillatorNode, SequenceNode};
use mizer_runtime::*;

mod utils;

#[test]
fn oscillator() {
    let frames = run_pipeline_with_node(OscillatorNode::default(), 60, "Value");
    insta::assert_debug_snapshot!(frames);
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
    let frames = run_pipeline_with_node(node, 240, "Output");
    insta::assert_debug_snapshot!(frames);
}

fn run_pipeline_with_node<N: Into<Node> + ProcessingNode + 'static>(
    node: N,
    frames: usize,
    port: &str,
) -> Vec<f64> {
    let clock = utils::TestClock::default();
    let sink = utils::TestSink::new();
    let mut runtime = CoordinatorRuntime::with_clock(clock, false);
    let node_type = node.node_type();
    add_node(
        runtime.injector_mut(),
        node_type,
        Some(node.into()),
        sink.clone(),
        port,
    );

    for _ in 0..frames {
        runtime.process();
    }

    sink.frames()
}
