use structopt::StructOpt;
use tokio::task::LocalSet;

use mizer::{build_runtime, Flags};
use mizer_session::Session;
use mizer_api::handlers::Handlers;

use std::sync::mpsc;

mod logger;

#[cfg(not(feature = "ui"))]
fn main() -> anyhow::Result<()> {
    let flags = init();

    run_headless(flags)
}

#[cfg(feature = "ui")]
fn main() -> anyhow::Result<()> {
    let flags = init();
    let headless = flags.headless;

    if headless {
        run_headless(flags)
    }else {
        run(flags)
    }
}

#[cfg(feature = "ui")]
fn run(flags: Flags) -> anyhow::Result<()> {
    let handlers = setup_runtime(flags)?;

    let handlers = handlers.recv()?;

    mizer_ui::run(handlers);

    Ok(())
}

fn run_headless(flags: Flags) -> anyhow::Result<()> {
    let runtime = build_tokio_runtime();

    start_runtime(runtime, flags, None).unwrap();

    Ok(())
}

fn init() -> Flags {
    logger::init();
    let flags = Flags::from_args();
    log::debug!("flags: {:?}", flags);

    flags
}

fn setup_runtime(flags: Flags) -> anyhow::Result<mpsc::Receiver<Handlers>> {
    let (tx, rx) = mpsc::channel();
    std::thread::Builder::new()
        .name("Task Runtime".into())
        .spawn(move || {
            let runtime = build_tokio_runtime();

            start_runtime(runtime, flags, Some(tx)).unwrap();
        })?;
    Ok(rx)
}

fn build_tokio_runtime() -> tokio::runtime::Runtime {
    log::trace!("Starting tokio runtime");
    tokio::runtime::Builder::new()
        .enable_all()
        .thread_name("mizer-tokio-runtime")
        .threaded_scheduler()
        .build()
        .unwrap()
}

fn start_runtime(mut runtime: tokio::runtime::Runtime, flags: Flags, handler_out: Option<mpsc::Sender<Handlers>>) -> anyhow::Result<()> {
    let local = LocalSet::new();
    // TODO: integrate discovery mode
    Session::new()?;

    let mut mizer = runtime.enter(|| build_runtime(runtime.handle().clone(), flags))?;
    if let Some(handler_out) = handler_out {
        handler_out.send(mizer.handlers.clone())?;
    }
    local.block_on(&mut runtime, mizer.run());

    Ok(())
}
