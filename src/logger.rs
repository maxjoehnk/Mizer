use tracing_subscriber::filter::EnvFilter;

#[cfg(not(target_os = "macos"))]
pub fn init() {
    tracing_subscriber::FmtSubscriber::builder()
        .with_env_filter(EnvFilter::from_default_env())
        .with_file(true)
        .with_line_number(true)
        .with_target(true)
        .with_level(true)
        .with_thread_names(true)
        .try_init()
        .unwrap();
}

#[cfg(target_os = "macos")]
pub fn init() {
    use log::LevelFilter;
    use oslog::*;

    OsLogger::new("live.mizer")
        .level_filter(LevelFilter::Debug)
        .init()
        .unwrap();
}
