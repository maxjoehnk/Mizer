use mizer_module::Runtime;
use mizer_node::ProcessingNode;
use mizer_nodes::{Node, OscillatorNode};
use mizer_runtime::*;

use crate::utils::add_node;

mod utils;

#[test]
fn oscillator() {
    let frames = run_pipeline_with_node(OscillatorNode::default(), 60, "Value");
    insta::assert_debug_snapshot!(frames);
}

fn run_pipeline_with_node<N: Into<Node> + ProcessingNode + 'static>(
    node: N,
    frames: usize,
    port: &str,
) -> Vec<f64> {
    let clock = utils::TestClock::default();
    let sink = utils::TestSink::new();
    let mut runtime = CoordinatorRuntime::with_clock(clock);
    let node_type = node.node_type();
    add_node(
        runtime.injector_mut(),
        node_type,
        Some(node.into()),
        sink.clone(),
        port,
    );
    runtime.plan();

    for _ in 0..frames {
        runtime.process();
    }

    sink.frames()
}
