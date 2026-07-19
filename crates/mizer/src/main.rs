#![windows_subsystem = "windows"]
use clap::Parser;
use std::sync::mpsc;

use mizer::{build_runtime, load_settings, Api, Flags, SettingsStore};
use mizer_api::handlers::Handlers;
use mizer_session::Session;

use crate::logger::LoggingGuard;

mod async_runtime;
mod logger;

#[cfg(not(feature = "ui"))]
fn main() -> anyhow::Result<()> {
    let (flags, _logging_guard, _sentry_guard) = init()?;
    let settings_manager = load_settings()?;

    run_headless(flags, settings_manager)
}

#[cfg(feature = "ui")]
fn main() -> anyhow::Result<()> {
    mizer_ui::init()?;
    let (flags, _logging_guard, _sentry_guard) = init()?;
    let headless = flags.headless;
    let settings_manager = load_settings()?;

    if headless {
        run_headless(flags, settings_manager)
    } else {
        ui::run(flags, settings_manager)
    }
}

fn run_headless(flags: Flags, settings_manager: SettingsStore) -> anyhow::Result<()> {
    let runtime = build_tokio_runtime();

    start_runtime(runtime.handle(), settings_manager, flags, None).unwrap();

    Ok(())
}

fn init() -> anyhow::Result<(Flags, LoggingGuard, Option<sentry::ClientInitGuard>)> {
    mizer_util::tracing::init();
    let flags = Flags::parse();
    let logging_guard = logger::init(&flags)?;
    tracing::debug!("flags: {:?}", flags);
    tracing::info!("Initializing Mizer");
    let sentry_guard = setup_sentry();
    init_ffmpeg()?;
    #[cfg(target_os = "macos")]
    {
        use anyhow::Context;
        coremidi_hotplug_notification::receive_device_updates(|| {})
            .map_err(|err| anyhow::anyhow!(err))
            .context("Registering coremidi callback for MIDI device hotplug")?;
    }

    Ok((flags, logging_guard, sentry_guard))
}

fn setup_sentry() -> Option<sentry::ClientInitGuard> {
    let sentry_key = option_env!("SENTRY_KEY")?;
    tracing::info!("Initializing sentry");
    let guard = sentry::init((
        sentry_key,
        sentry::ClientOptions {
            release: sentry::release_name!(),
            traces_sample_rate: 1.0,
            default_integrations: true,
            attach_stacktrace: true,
            session_mode: sentry::SessionMode::Application,
            ..Default::default()
        },
    ));
    sentry::configure_scope(|scope| {
        if let Some(commit) = option_env!("GIT_COMMIT") {
            scope.set_tag("commit", commit);
        }
    });

    Some(guard)
}

fn init_ffmpeg() -> anyhow::Result<()> {
    ffmpeg_the_third::init()?;
    ffmpeg_the_third::log::set_level(ffmpeg_the_third::log::Level::Warning);

    Ok(())
}

fn build_tokio_runtime() -> tokio::runtime::Runtime {
    tracing::trace!("Starting tokio runtime");
    tokio::runtime::Builder::new_multi_thread()
        .enable_all()
        .thread_name("mizer-tokio-runtime")
        .build()
        .unwrap()
}

fn start_runtime(
    runtime: &tokio::runtime::Handle,
    settings_store: SettingsStore,
    flags: Flags,
    handler_out: Option<mpsc::Sender<Handlers<Api>>>,
) -> anyhow::Result<()> {
    // TODO: integrate discovery mode
    Session::discover()?;

    let _guard = runtime.enter();

    let (mut mizer, api_handler) = build_runtime(runtime.clone(), settings_store, flags)?;
    if let Some(handler_out) = handler_out {
        handler_out.send(mizer.handlers.clone())?;
    }
    mizer.run(&api_handler);

    Ok(())
}

#[cfg(feature = "ui")]
mod ui {
    use std::sync::mpsc;

    use anyhow::Context;
    use mizer::{Api, Flags, SettingsStore};
    use mizer_api::handlers::Handlers;
    use mizer_ui::LifecycleHandler;

    use crate::async_runtime::TokioRuntime;

    pub fn run(flags: Flags, settings_manager: SettingsStore) -> anyhow::Result<()> {
        let tokio = super::build_tokio_runtime();
        keep_screen_awake(settings_manager.clone());
        let handlers = setup_runtime(tokio.handle(), settings_manager, flags)?;

        let handlers = handlers.recv().context("internal api setup")?;

        let runtime = TokioRuntime::new(tokio.handle());

        let tokio = AsyncRuntime(tokio);

        mizer_ui::run(handlers, runtime, tokio)?;

        Ok(())
    }

    fn setup_runtime(
        handle: &tokio::runtime::Handle,
        settings_store: SettingsStore,
        flags: Flags,
    ) -> anyhow::Result<mpsc::Receiver<Handlers<Api>>> {
        let (tx, rx) = mpsc::channel();
        let handle = handle.clone();
        std::thread::Builder::new()
            .name("Pipeline Runtime".into())
            .spawn(move || {
                if let Err(err) = super::start_runtime(&handle, settings_store, flags, Some(tx)) {
                    tracing::error!("{err:?}");
                    std::process::exit(1);
                }
            })?;
        Ok(rx)
    }

    struct AsyncRuntime(tokio::runtime::Runtime);

    impl LifecycleHandler for AsyncRuntime {
        fn shutdown(self) {
            // TODO: this is no clean exit.
            self.0.shutdown_background();
        }
    }

    fn keep_screen_awake(settings_store: SettingsStore) {
        std::thread::spawn(move || {
            let mut awake = None;
            loop {
                let should_keep_awake = settings_store.read().settings.general.keep_screen_awake;
                if update_awake_handle(&mut awake, should_keep_awake).is_err() {
                    return;
                }

                std::thread::sleep(std::time::Duration::from_mins(5));
            }
        });
    }

    fn update_awake_handle(handle: &mut Option<keepawake::KeepAwake>, should_keep_awake: bool) -> anyhow::Result<()> {
        if handle.is_some() == should_keep_awake {
            return Ok(());
        }
        if !should_keep_awake {
            *handle = None;
            return Ok(());
        }

        match try_keep_screen_awake() {
            Ok(awake) => {
                *handle = Some(awake);
                Ok(())
            },
            Err(err) => {
                tracing::warn!(err = %err, "Unable to keep display awake");
                Err(err.into())
            }
        }

    }

    fn try_keep_screen_awake() -> keepawake::Result<keepawake::KeepAwake> {
        keepawake::Builder::default()
            .display(true)
            .idle(true)
            .app_reverse_domain("live.mizer")
            .app_name("Mizer")
            .create()
    }
}
