use mizer_clock::Clock;
use mizer_module::Runtime;
use mizer_node::{NodeLink, PortType};
use mizer_nodes::OscillatorNode;
use mizer_runtime::*;

mod utils;

#[test]
fn main() {
    env_logger::init();
    let clock = utils::TestClock::default();
    let sink = utils::TestSink::new();
    let mut runtime = CoordinatorRuntime::with_clock(clock);
    runtime.add_node("/oscillator1".into(), OscillatorNode::default());
    runtime.add_node("/output1".into(), sink.clone());
    runtime
        .add_link(NodeLink {
            source: "/oscillator1".into(),
            source_port: "value".into(),
            target: "/output1".into(),
            target_port: "input".into(),
            local: false,
            port_type: PortType::Single,
        })
        .unwrap();

    run_for_one_second(runtime);

    let frames = sink.frames();
    insta::assert_debug_snapshot!(frames);
}

fn run_for_one_second<TClock: Clock>(mut runtime: CoordinatorRuntime<TClock>) {
    for _ in 0..60 {
        runtime.process();
    }
}
