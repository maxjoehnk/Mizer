use std::time::Duration;

use structopt::StructOpt;

#[cfg(feature = "export_metrics")]
use metrics_runtime::{exporters::HttpExporter, observers::PrometheusBuilder, Receiver};

use mizer_project_files::Project;

use crate::flags::Flags;
use mizer_pipeline::Pipeline;

mod flags;

const FRAME_DELAY_60FPS: Duration = Duration::from_millis(16);

fn main() -> anyhow::Result<()> {
    env_logger::init();
    let flags = Flags::from_args();

    #[cfg(feature = "export_metrics")]
    if flags.metrics {
        setup_metrics(flags.metrics_port);
    }

    let mut pipeline = Pipeline::default();
    let mut projects = vec![];
    for file in flags.files {
        let project = Project::load_file(&file)?;
        projects.push(project.clone());
        pipeline.load_project(project)?;
    }

    if flags.print_pipeline {
        log::info!("{:#?}", pipeline);
    }

    // TODO: add pipeline view for api access
    let mut pipeline2 = Pipeline::default();
    for project in &projects {
        pipeline2.load_project(project.clone())?;
    }
    mizer_grpc_api::start(projects, pipeline2);

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

#[cfg(feature = "export_metrics")]
fn setup_metrics(port: u16) {
    let receiver = Receiver::builder().build().expect("failed to create metrics receiver");
    let controller = receiver.controller();
    receiver.install();

    std::thread::spawn(move || {
        smol::run(HttpExporter::new(
            controller,
            PrometheusBuilder::new(),
            format!("0.0.0.0:{}", port).parse().unwrap(),
        ).async_run())
    });
}
