use std::fs;
use std::ops::Add;
use std::path::Path;

use mizer_node::mocks::NodeContextMock;
use mizer_node::ProcessingNode;
use mizer_util::clock::{Clock, TestClock};

const FRAMES: usize = 60 * 4;

pub fn graph_node_with_frames<P: ProcessingNode>(
    node: P,
    name: &str,
    frames: usize,
) -> anyhow::Result<()> {
    graph_node_internal(node, name, |_| 0., frames)
}

pub fn graph_node<P: ProcessingNode>(node: P, name: &str) -> anyhow::Result<()> {
    graph_node_with_inputs(node, name, |_| 0.)
}

pub fn graph_node_with_inputs<P: ProcessingNode, I: Fn(usize) -> f64>(
    node: P,
    name: &str,
    input: I,
) -> anyhow::Result<()> {
    graph_node_internal(node, name, input, FRAMES)
}

fn graph_node_internal<P: ProcessingNode, I: Fn(usize) -> f64>(
    node: P,
    name: &str,
    input: I,
    frames: usize,
) -> anyhow::Result<()> {
    let mut context = NodeContextMock::new();
    let mut state = node.create_state();
    let mut clock = TestClock::default();
    let mut history_ticks = Vec::new();

    for i in 0..frames {
        let frame = clock.tick();
        history_ticks.push(frame.frame);
        context.when_clock().returns(frame);
        context.when_read_port("value").returns(Some(input(i)));

        node.process(&context, &mut state)?;
    }

    let dir = Path::new("tests/snapshots");
    generate_script_file(&dir, name)?;
    generate_data_file(&dir, name, &context.history.borrow(), &history_ticks)?;
    generate_plot(&dir, name)?;
    cleanup_sources(&dir, name)?;
    test_snapshot(name, &context.history.borrow());

    Ok(())
}

fn generate_script_file(dir: &Path, name: &str) -> anyhow::Result<()> {
    let script = format!("set xlabel 'Frames'\nset ylabel 'Value'\nset yrange[0:1]\nunset key\nset term svg enhanced\nset output '{}.svg'\nplot '{}.dat' with filledcurves x1\n", name, name);
    fs::write(dir.join(format!("{}.gnu", name)), script)?;

    Ok(())
}

fn generate_data_file(
    dir: &Path,
    name: &str,
    values: &[f64],
    frames: &[f64],
) -> anyhow::Result<()> {
    assert_eq!(values.len(), frames.len());

    let data = values
        .into_iter()
        .zip(frames)
        .map(|(value, frame)| format!("{} {}", frame, value))
        .reduce(|lhs, rhs| lhs.add("\n").add(&rhs))
        .unwrap_or_default();
    fs::write(dir.join(format!("{}.dat", name)), data)?;

    Ok(())
}

fn generate_plot(dir: &Path, name: &str) -> anyhow::Result<()> {
    let result = std::process::Command::new("gnuplot")
        .arg(format!("{}.gnu", name))
        .current_dir(dir)
        .spawn()?
        .wait()?;

    assert!(result.success(), "gnuplot failed to run");

    Ok(())
}

fn cleanup_sources(dir: &Path, name: &str) -> anyhow::Result<()> {
    let script = dir.join(format!("{}.gnu", name));
    std::fs::remove_file(&script)?;
    let data = dir.join(format!("{}.dat", name));
    std::fs::remove_file(&data)?;

    Ok(())
}

fn test_snapshot(name: &str, values: &[f64]) {
    insta::assert_debug_snapshot!(name, values);
}
