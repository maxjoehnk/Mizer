use std::sync::mpsc;
use anyhow::Context;

use structopt::StructOpt;

use mizer::{build_runtime, Api, Flags};
use mizer_api::handlers::Handlers;
use mizer_session::Session;

use crate::logger::LoggingGuard;

mod async_runtime;
mod logger;

#[cfg(not(feature = "ui"))]
fn main() -> anyhow::Result<()> {
    let _guard = setup_sentry();
    let (flags, _logging_guard) = init()?;

    run_headless(flags)
}

#[cfg(feature = "ui")]
fn main() -> anyhow::Result<()> {
    mizer_ui::init()?;
    let _guard = setup_sentry();
    let (flags, _logging_guard) = init()?;
    let headless = flags.headless;

    if headless {
        run_headless(flags)
    } else {
        ui::run(flags)
    }
}

fn setup_sentry() -> Option<sentry::ClientInitGuard> {
    let sentry_key = option_env!("SENTRY_KEY")?;
    let guard = sentry::init((
        sentry_key,
        sentry::ClientOptions {
            release: sentry::release_name!(),
            traces_sample_rate: 1.0,
            default_integrations: true,
            attach_stacktrace: true,
            ..Default::default()
        },
    ));

    Some(guard)
}

fn run_headless(flags: Flags) -> anyhow::Result<()> {
    let runtime = build_tokio_runtime();

    start_runtime(runtime.handle(), flags, None).unwrap();

    Ok(())
}

fn init() -> anyhow::Result<(Flags, LoggingGuard)> {
    mizer_util::tracing::init();
    let flags = Flags::from_args();
    let guard = logger::init(&flags)?;
    tracing::debug!("flags: {:?}", flags);
    init_ffmpeg()?;
    #[cfg(target_os = "macos")]
    coremidi_hotplug_notification::receive_device_updates(|| {})
        .map_err(|err| anyhow::anyhow!(err))
        .context("Registering coremidi callback for MIDI device hotplug")?;

    Ok((flags, guard))
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
    flags: Flags,
    handler_out: Option<mpsc::Sender<Handlers<Api>>>,
) -> anyhow::Result<()> {
    // TODO: integrate discovery mode
    Session::discover()?;

    let _guard = runtime.enter();

    let (mut mizer, api_handler) = build_runtime(runtime.clone(), flags)?;
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

    use mizer::{Api, Flags};
    use mizer_api::handlers::Handlers;
    use mizer_ui::LifecycleHandler;

    use crate::async_runtime::TokioRuntime;

    pub fn run(flags: Flags) -> anyhow::Result<()> {
        let tokio = super::build_tokio_runtime();
        let handlers = setup_runtime(tokio.handle(), flags)?;

        let handlers = handlers.recv().context("internal api setup")?;

        let runtime = TokioRuntime::new(tokio.handle());

        let tokio = AsyncRuntime(tokio);

        mizer_ui::run(handlers, runtime, tokio)?;

        Ok(())
    }

    fn setup_runtime(
        handle: &tokio::runtime::Handle,
        flags: Flags,
    ) -> anyhow::Result<mpsc::Receiver<Handlers<Api>>> {
        let (tx, rx) = mpsc::channel();
        let handle = handle.clone();
        std::thread::Builder::new()
            .name("Pipeline Runtime".into())
            .spawn(move || {
                if let Err(err) = super::start_runtime(&handle, flags, Some(tx)) {
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
}
