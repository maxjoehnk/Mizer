use structopt::StructOpt;

use mizer::{build_runtime, Api, Flags};
use mizer_api::handlers::Handlers;
use mizer_session::Session;

use std::sync::mpsc;

mod async_runtime;
mod logger;

#[cfg(not(feature = "ui"))]
fn main() -> anyhow::Result<()> {
    let _guard = setup_sentry();
    let flags = init()?;

    run_headless(flags)
}

#[cfg(feature = "ui")]
fn main() -> anyhow::Result<()> {
    let _guard = setup_sentry();
    let flags = init()?;
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

fn init() -> anyhow::Result<Flags> {
    mizer_util::tracing::init();
    logger::init()?;
    let flags = Flags::from_args();
    log::debug!("flags: {:?}", flags);

    Ok(flags)
}

fn build_tokio_runtime() -> tokio::runtime::Runtime {
    log::trace!("Starting tokio runtime");
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
    Session::new()?;
    Session::discover()?;

    let _guard = runtime.enter();

    let (mut mizer, api_handler) = build_runtime(runtime.clone(), flags)?;
    if let Some(handler_out) = handler_out {
        handler_out.send(mizer.handlers.clone())?;
    }
    runtime.block_on(mizer.run(&api_handler));

    Ok(())
}

#[cfg(feature = "ui")]
mod ui {
    use anyhow::Context;

    use crate::async_runtime::TokioRuntime;
    use mizer::{Api, Flags};
    use mizer_api::handlers::Handlers;

    use mizer_ui::LifecycleHandler;
    use std::sync::mpsc;

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
                    log::error!("{err:?}");
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
