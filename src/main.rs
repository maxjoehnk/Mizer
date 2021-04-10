use structopt::StructOpt;
use tokio::task::LocalSet;

use mizer::{build_runtime, Flags};
use mizer_session::Session;
use mizer_api::handlers::Handlers;

use std::sync::mpsc;

fn main() -> anyhow::Result<()> {
    env_logger::init();
    let flags = Flags::from_args();
    log::debug!("flags: {:?}", flags);

    let handlers = setup_runtime(flags)?;

    let handlers = handlers.recv()?;

    mizer_ui::run(handlers);

    Ok(())
}

fn setup_runtime(flags: Flags) -> anyhow::Result<mpsc::Receiver<Handlers>> {
    let (tx, rx) = mpsc::channel();
    std::thread::Builder::new()
        .name("Task Runtime".into())
        .spawn(move || {
            log::trace!("Starting tokio runtime");
            let runtime = tokio::runtime::Builder::new()
                .enable_all()
                .thread_name("mizer-tokio-runtime")
                .threaded_scheduler()
                .build()
                .unwrap();

            start_runtime(runtime, flags, tx).unwrap();
        })?;
    Ok(rx)
}

fn start_runtime(mut runtime: tokio::runtime::Runtime, flags: Flags, handler_out: mpsc::Sender<Handlers>) -> anyhow::Result<()> {
    let local = LocalSet::new();
    // TODO: integrate discovery mode
    Session::new()?;

    let mut mizer = runtime.enter(|| build_runtime(runtime.handle().clone(), flags))?;
    handler_out.send(mizer.handlers.clone())?;
    local.block_on(&mut runtime, mizer.run());

    Ok(())
}
