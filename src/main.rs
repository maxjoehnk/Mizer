use std::time::Duration;

#[cfg(feature = "export_metrics")]
use metrics_runtime::{Receiver, exporters::HttpExporter, observers::PrometheusBuilder};

use crate::pipeline::Pipeline;
use mizer_project_files::load_project_file;

mod nodes;
mod pipeline;

const FRAME_DELAY_60FPS: Duration = Duration::from_millis(16);

fn main() -> anyhow::Result<()> {
    env_logger::init();
    #[cfg(feature = "export_metrics")]
    setup_metrics();

    let mut pipeline = build_pipeline()?;

    loop {
        let before = std::time::Instant::now();
        pipeline.process();
        let after = std::time::Instant::now();
        let frame_time = after.duration_since(before);
        metrics::timing!("mizer.frame_time", frame_time);
        if frame_time <= FRAME_DELAY_60FPS {
            std::thread::sleep(FRAME_DELAY_60FPS - frame_time);
        }
    }
}

fn build_pipeline() -> anyhow::Result<Pipeline<'static>> {
    let mut pipeline = Pipeline::default();
    let artnet = load_project_file("examples/artnet.yml")?;
    pipeline.load_project(artnet)?;
    let pixels = load_project_file("examples/pixels.yml")?;
    pipeline.load_project(pixels)?;
    let video = load_project_file("examples/video.yml")?;
    pipeline.load_project(video)?;
    log::trace!("{:#?}", pipeline);

    Ok(pipeline)
}

#[cfg(feature = "export_metrics")]
fn setup_metrics() {
    let receiver = Receiver::builder().build().expect("failed to create metrics receiver");
    let controller = receiver.controller();
    receiver.install();

    std::thread::spawn(move || {
        smol::run(HttpExporter::new(
            controller,
            PrometheusBuilder::new(),
            "0.0.0.0:8888".parse().unwrap()
        ).async_run())
    });
}

