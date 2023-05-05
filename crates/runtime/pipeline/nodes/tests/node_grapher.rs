use plotters::coord::Shift;
use plotters::prelude::*;
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
    graph_node_internal(node, name, None, frames)
}

pub fn graph_node<P: ProcessingNode>(node: P, name: &str) -> anyhow::Result<()> {
    graph_node_internal(node, name, None, FRAMES)
}

pub fn graph_node_with_inputs<P: ProcessingNode, I: Fn(usize) -> f64 + 'static>(
    node: P,
    name: &str,
    port: &str,
    input: I,
) -> anyhow::Result<()> {
    graph_node_internal(node, name, Some((port, Box::new(input))), FRAMES)
}

fn graph_node_internal<P: ProcessingNode>(
    node: P,
    name: &str,
    input: Option<(&str, Box<dyn Fn(usize) -> f64>)>,
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
        if let Some((port, input)) = &input {
            context.when_read_port(*port).returns(Some(input(i)));
        }

        node.process(&context, &mut state)?;
    }

    let dir = Path::new("tests/snapshots");
    let file_path = dir.join(format!("{name}.svg"));
    let backend = setup_chart(&file_path)?;
    let mut chart = ChartBuilder::on(&backend)
        .x_label_area_size(40)
        .y_label_area_size(40)
        .build_cartesian_2d(-0f64..4f64, -0f64..1f64)?;
    chart
        .configure_mesh()
        .disable_mesh()
        .x_labels(5)
        .x_desc("Pan")
        .y_labels(5)
        .y_desc("Tilt")
        .draw()?;
    chart.draw_series(AreaSeries::new(
        history_ticks
            .iter()
            .zip(context.history.borrow().iter())
            .map(|(x, y)| (*x, *y)),
        0.0,
        MAGENTA,
    ))?;

    backend.present()?;

    test_snapshot(name, &context.history.borrow());

    Ok(())
}

fn setup_chart(path: &Path) -> anyhow::Result<DrawingArea<SVGBackend, Shift>> {
    let backend = SVGBackend::new(path, (600, 480)).into_drawing_area();
    backend.fill(&WHITE)?;
    let backend = backend.margin(8, 8, 8, 8);

    Ok(backend)
}

fn test_snapshot(name: &str, values: &[f64]) {
    insta::assert_debug_snapshot!(name, values);
}
