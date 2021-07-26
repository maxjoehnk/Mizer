use mizer_nodes::{OscillatorNode, OscillatorType};
use test_case::test_case;

mod node_grapher;

#[test_case(OscillatorType::Sine, "sine_oscillator")]
// #[test_case(OscillatorType::Saw, "saw_oscillator")] TODO: implement saw
#[test_case(OscillatorType::Square, "square_oscillator")]
#[test_case(OscillatorType::Triangle, "triangle_oscillator")]
fn oscillator(oscillator_type: OscillatorType, name: &str) -> anyhow::Result<()> {
    let node = OscillatorNode {
        oscillator_type,
        ..Default::default()
    };

    node_grapher::graph_node(node, name)
}

#[test]
fn long_oscillator() -> anyhow::Result<()> {
    let node = OscillatorNode {
        oscillator_type: OscillatorType::Sine,
        ratio: 8.,
        ..Default::default()
    };

    node_grapher::graph_node_with_frames(node, "long_sine_oscillator", 60 * 8)
}
