use std::path::PathBuf;

use anyhow::Context;
use directories_next::ProjectDirs;
use rolling_file::{BasicRollingFileAppender, RollingConditionBasic, RollingFileAppender};
use tracing::{Level, Subscriber};
use tracing_appender::non_blocking::{NonBlocking, WorkerGuard};
use tracing_subscriber::filter::{EnvFilter, LevelFilter};
use tracing_subscriber::prelude::*;
use tracing_subscriber::registry::LookupSpan;
use tracing_subscriber::Layer;

use mizer::Flags;

pub fn init(flags: &Flags) -> anyhow::Result<LoggingGuard> {
    let (logging_guard, file_layer) = file_layer();

    let registry = tracing_subscriber::registry()
        .with(console_layer())
        .with(sentry_tracing::layer())
        .with(file_layer);

    #[cfg(feature = "debug-ui")]
    let registry = registry.with(debug_ui_layer(flags));

    #[cfg(all(target_os = "macos", feature = "oslog"))]
    let registry = registry.with(macos_oslog_layer());

    registry.try_init().context("Initializing logger")?;

    Ok(LoggingGuard(logging_guard))
}

fn console_layer<S: Subscriber + for<'a> LookupSpan<'a>>() -> impl Layer<S> {
    tracing_subscriber::fmt::layer()
        .with_file(true)
        .with_line_number(true)
        .with_target(true)
        .with_level(true)
        .with_thread_names(true)
        .with_filter(EnvFilter::from_default_env())
}

#[cfg(feature = "debug-ui")]
fn debug_ui_layer<S: Subscriber + for<'a> LookupSpan<'a>>(flags: &Flags) -> Option<impl Layer<S>> {
    flags
        .debug
        .then(|| mizer_debug_ui_egui::add_tracing_collector())
}

#[cfg(all(target_os = "macos", feature = "oslog"))]
fn macos_oslog_layer<S: Subscriber + for<'a> LookupSpan<'a>>() -> impl Layer<S> {
    tracing_oslog::OsLogger::new("live.mizer", "default")
}

fn file_layer<S: Subscriber + for<'a> LookupSpan<'a>>(
) -> (Option<WorkerGuard>, Option<impl Layer<S>>) {
    if let Ok(file_target) = file_target() {
        let (file_appender, guard) = NonBlocking::new(file_target);
        let file_layer = tracing_subscriber::fmt::layer()
            .with_thread_names(true)
            .with_target(true)
            .with_level(true)
            .with_file(false)
            .with_line_number(false)
            .json()
            .with_writer(file_appender)
            .with_filter(LevelFilter::from_level(Level::DEBUG));

        (Some(guard), Some(file_layer))
    } else {
        (None, None)
    }
}

#[derive(Default)]
pub struct LoggingGuard(Option<WorkerGuard>);

fn file_target() -> anyhow::Result<RollingFileAppender<RollingConditionBasic>> {
    let path = if let Some(dir) = ProjectDirs::from("live", "mizer", "Mizer") {
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
    .context("Creating tracing file appender")?;

    Ok(file_appender)
}
