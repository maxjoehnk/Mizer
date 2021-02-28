use mizer_module::Runtime;
use mizer_node::{NodeLink, NodePath, PortType, ProcessingNode};
use mizer_nodes::{OscillatorNode, SequenceNode};
use mizer_runtime::*;

mod utils;

#[test]
fn oscillator() {
    run_pipeline_with_node("/oscillator", OscillatorNode::default(), 60)
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
    run_pipeline_with_node("/sequence", node, 240)
}

fn run_pipeline_with_node<P: Into<NodePath> + 'static, N: ProcessingNode + 'static>(
    path: P,
    node: N,
    frames: usize,
) {
    let path = path.into();
    let clock = utils::TestClock::default();
    let sink = utils::TestSink::new();
    let mut runtime = CoordinatorRuntime::with_clock(clock);
    runtime.add_node(path.clone(), node);
    runtime.add_node("/sink".into(), sink.clone());
    runtime
        .add_link(NodeLink {
            source: path.clone(),
            source_port: "value".into(),
            target: "/sink".into(),
            target_port: "input".into(),
            local: true,
            port_type: PortType::Single,
        })
        .unwrap();

    for _ in 0..frames {
        runtime.process();
    }

    let frames = sink.frames();
    insta::assert_debug_snapshot!(frames);
}
