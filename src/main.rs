use std::time::Duration;

use structopt::StructOpt;

#[cfg(feature = "export_metrics")]
use metrics_runtime::{exporters::HttpExporter, observers::PrometheusBuilder, Receiver};

use mizer_project_files::Project;

use crate::flags::Flags;
use anyhow::Context;
use mizer_fixtures::library::FixtureLibrary;
use mizer_fixtures::manager::FixtureManager;
use mizer_media::MediaServer;
use mizer_open_fixture_library_provider::OpenFixtureLibraryProvider;
use mizer_pipeline::Pipeline;
use mizer_devices::DeviceManager;

mod flags;

const FRAME_DELAY_60FPS: Duration = Duration::from_millis(16);

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    env_logger::init();
    let flags = Flags::from_args();

    #[cfg(feature = "export_metrics")]
    if flags.metrics {
        log::debug!("setting up metrics");
        setup_metrics(flags.metrics_port);
    }

    // TODO: pins cpu, reduce cpu usage
    // let _session = if flags.join {
    //     Session::discover()?
    // } else {
    //     Session::new()?
    // };
    run(flags).await
}

async fn run(flags: Flags) -> anyhow::Result<()> {
    let handle = tokio::runtime::Handle::try_current()?;

    log::info!("Loading open fixture library...");
    let mut ofl_provider = OpenFixtureLibraryProvider::new();
    ofl_provider
        .load("fixtures/open-fixture-library/.fixtures.json")
        .context("loading open fixture library")?;
    log::info!("Loading open fixture library...Done");

    let fixture_library = FixtureLibrary::new(vec![Box::new(ofl_provider)]);

    let mut fixture_manager = FixtureManager::new();
    let device_manager = DeviceManager::new();

    handle.spawn(device_manager.clone().start_discovery());

    log::info!("Loading projects...");
    let mut pipeline = Pipeline::default();
    let mut projects = vec![];
    for file in flags.files {
        let project = Project::load_file(&file)?;
        load_fixtures(&mut fixture_manager, &fixture_library, &project);
        projects.push(project.clone());
        pipeline
            .load_project(project, &fixture_manager, device_manager.clone())
            .context("loading project")?;
    }
    log::info!("Loading projects...Done");

    if flags.print_pipeline {
        log::info!("{:#?}", pipeline);
    }

    let media_server = MediaServer::new().await?;
    let media_server_api = media_server.open_api(&handle)?;

    let _grpc_api = mizer_grpc_api::start(
        handle.clone(),
        projects,
        fixture_manager,
        media_server_api.clone(),
    )?;
    mizer_media::http_api::start(media_server_api)?;

    loop {
        let before = std::time::Instant::now();
        pipeline.process();
        let after = std::time::Instant::now();
        let frame_time = after.duration_since(before);
        metrics::timing!("mizer.frame_time", frame_time);
        if frame_time <= FRAME_DELAY_60FPS {
            tokio::time::delay_for(FRAME_DELAY_60FPS - frame_time).await;
        }
    }
}

fn load_fixtures(
    fixture_manager: &mut FixtureManager,
    library: &FixtureLibrary,
    project: &Project,
) {
    for fixture in &project.fixtures {
        let def = library.get_definition(&fixture.fixture);
        if let Some(def) = def {
            fixture_manager.add_fixture(
                fixture.id.clone(),
                def,
                fixture.mode.clone(),
                fixture.channel,
                fixture.universe,
            );
        } else {
            log::warn!("No fixture definition for fixture id {}", fixture.fixture);
        }
    }
}

#[cfg(feature = "export_metrics")]
fn setup_metrics(port: u16) {
    let receiver = Receiver::builder()
        .build()
        .expect("failed to create metrics receiver");
    let controller = receiver.controller();
    receiver.install();

    std::thread::spawn(move || {
        smol::run(
            HttpExporter::new(
                controller,
                PrometheusBuilder::new(),
                format!("0.0.0.0:{}", port).parse().unwrap(),
            )
            .async_run(),
        )
    });
}
