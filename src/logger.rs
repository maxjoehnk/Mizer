use directories_next::ProjectDirs;
use tracing_subscriber::filter::EnvFilter;
use tracing_subscriber::prelude::*;
use tracing_subscriber::Layer;

#[cfg(not(target_os = "macos"))]
pub fn init() -> anyhow::Result<()> {
    let stdout_subscriber = tracing_subscriber::FmtSubscriber::builder()
        .with_env_filter(EnvFilter::from_default_env())
        .with_file(true)
        .with_line_number(true)
        .with_target(true)
        .with_level(true)
        .with_thread_names(true)
        .finish();
    let file_appender = if let Some(dir) = ProjectDirs::from("me", "maxjoehnk", "Mizer") {
        tracing_appender::rolling::daily(dir.data_dir(), "mizer.log")
    } else {
        tracing_appender::rolling::daily(".", "mizer.log")
    };
    let file_layer = tracing_subscriber::fmt::layer()
        .with_thread_names(true)
        .with_file(true)
        .with_target(true)
        .with_level(true)
        .with_line_number(true)
        .json()
        .with_writer(file_appender)
        .boxed();
    stdout_subscriber
        .with(sentry_tracing::layer())
        .with(file_layer)
        .try_init()?;

    Ok(())
}

#[cfg(target_os = "macos")]
pub fn init() -> anyhow::Result<()> {
    use log::LevelFilter;
    use oslog::*;

    OsLogger::new("live.mizer")
        .level_filter(LevelFilter::Debug)
        .init()?;

    Ok(())
}
