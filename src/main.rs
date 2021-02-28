use std::time::Duration;

use structopt::StructOpt;

#[cfg(feature = "export_metrics")]
use metrics_runtime::{exporters::HttpExporter, observers::PrometheusBuilder, Receiver};

use mizer_project_files::Project;

use crate::flags::Flags;
use anyhow::Context;
use mizer_fixtures::library::{FixtureLibrary, FixtureLibraryProvider};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::{FixtureModule};
use mizer_media::{MediaServer, MediaDiscovery};
use mizer_open_fixture_library_provider::OpenFixtureLibraryProvider;
use mizer_devices::DeviceModule;
use mizer_runtime::CoordinatorRuntime;
use mizer_protocol_dmx::*;
use mizer_module::{Module, Runtime};

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
        .load("components/fixtures/open-fixture-library/.fixtures.json")
        .context("loading open fixture library")?;
    log::info!("Loading open fixture library...Done");

    let providers: Vec<Box<dyn FixtureLibraryProvider>> = vec![
        Box::new(ofl_provider)
    ];

    let (device_module, device_manager) = DeviceModule::new();
    handle.spawn(device_manager.clone().start_discovery());

    let mut runtime = CoordinatorRuntime::new();
    DmxModule.register(&mut runtime)?;
    let (fixture_module, fixture_manager) = FixtureModule::new(providers);
    fixture_module.register(&mut runtime)?;
    device_module.register(&mut runtime)?;
    log::info!("Loading projects...");
    for file in flags.files {
        let project = Project::load_file(&file)?;
        {
            let injector = runtime.injector();
            let manager = injector.get().unwrap();
            let library = injector.get().unwrap();
            load_fixtures(manager, library, &project);
        }
        runtime
            .load_project(project)
            .context("loading project")?;
    }
    log::info!("Loading projects...Done");

    if flags.generate_graph {
        runtime.generate_pipeline_graph()?;
    }

    let media_server = MediaServer::new().await?;
    let media_server_api = media_server.open_api(&handle)?;
    // TODO: get paths from project file
    let media_discovery = MediaDiscovery::new(media_server_api.clone(), "examples/media");
    // TODO: watch path for file changes
    media_discovery.discover().await?;

    let _grpc_api = mizer_grpc_api::start(
        handle.clone(),
        runtime.api(),
        fixture_manager,
        media_server_api.clone(),
    )?;
    mizer_media::http_api::start(media_server_api)?;

    loop {
        let before = std::time::Instant::now();
        runtime.process();
        let after = std::time::Instant::now();
        let frame_time = after.duration_since(before);
        metrics::timing!("mizer.frame_time", frame_time);
        if frame_time <= FRAME_DELAY_60FPS {
            tokio::time::delay_for(FRAME_DELAY_60FPS - frame_time).await;
        }
    }
}

fn load_fixtures(
    fixture_manager: &FixtureManager,
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
                fixture.output.clone(),
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
