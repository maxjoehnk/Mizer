use std::path::PathBuf;

use anyhow::Context;
use directories_next::ProjectDirs;
use rolling_file::{BasicRollingFileAppender, RollingConditionBasic, RollingFileAppender};
use tracing::Level;
use tracing_appender::non_blocking::{NonBlocking, WorkerGuard};
use tracing_subscriber::filter::{EnvFilter, LevelFilter};
use tracing_subscriber::prelude::*;
use tracing_subscriber::Layer;

#[cfg(not(target_os = "macos"))]
pub fn init() -> anyhow::Result<LoggingGuard> {
    let stdout_layer = tracing_subscriber::fmt::layer()
        .with_file(true)
        .with_line_number(true)
        .with_target(true)
        .with_level(true)
        .with_thread_names(true)
        .with_filter(EnvFilter::from_default_env())
        .boxed();

    let registry = tracing_subscriber::registry()
        .with(stdout_layer)
        .with(sentry_tracing::layer());

    let mut logging_guard = None;

    if let Ok(file_target) = file_target() {
        let (file_appender, guard) = NonBlocking::new(file_target);
        logging_guard = Some(guard);
        let file_layer = tracing_subscriber::fmt::layer()
            .with_thread_names(true)
            .with_target(true)
            .with_level(true)
            .with_file(false)
            .with_line_number(false)
            .json()
            .with_writer(file_appender)
            .with_filter(LevelFilter::from_level(Level::DEBUG))
            .boxed();

        registry
            .with(file_layer)
            .try_init()
            .context("Initializing logger")?;
    } else {
        registry.try_init().context("Initializing logger")?;
    }

    Ok(LoggingGuard(logging_guard))
}

pub struct LoggingGuard(Option<WorkerGuard>);

#[cfg(target_os = "macos")]
pub fn init() -> anyhow::Result<()> {
    use log::LevelFilter;
    use oslog::*;

    OsLogger::new("live.mizer")
        .level_filter(LevelFilter::Debug)
        .init()?;

    Ok(())
}

fn file_target() -> anyhow::Result<RollingFileAppender<RollingConditionBasic>> {
    let path = if let Some(dir) = ProjectDirs::from("me", "maxjoehnk", "Mizer") {
        dir.data_dir().join("mizer.log")
    } else {
        PathBuf::from("mizer.log")
    };
    let file_appender = BasicRollingFileAppender::new(
        path,
        RollingConditionBasic::new()
            .daily()
            .max_size(1024 * 1024 * 10),
        4,
    )
    .context("Creating log file appender")?;

    Ok(file_appender)
}
