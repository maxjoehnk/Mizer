use crate::utils::add_node;
use mizer_clock::Clock;
use mizer_module::Runtime;
use mizer_node::{NodePath, NodeType};
use mizer_nodes::OscillatorNode;
use mizer_runtime::*;

mod utils;

#[test]
fn main() {
    let clock = utils::TestClock::default();
    let sink = utils::TestSink::new();
    let mut runtime = CoordinatorRuntime::with_clock(clock);
    add_node(
        runtime.injector_mut(),
        NodeType::Oscillator,
        None,
        sink.clone(),
    );

    run_for_one_second(runtime);

    let frames = sink.frames();
    insta::assert_debug_snapshot!(frames);
}

fn run_for_one_second<TClock: Clock>(mut runtime: CoordinatorRuntime<TClock>) {
    for _ in 0..60 {
        runtime.process();
    }
}
