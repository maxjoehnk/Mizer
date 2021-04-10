use structopt::StructOpt;
use tokio::task::LocalSet;

use mizer::{build_runtime, Flags};
use mizer_session::Session;

fn main() -> anyhow::Result<()> {
    env_logger::init();
    let flags = Flags::from_args();
    log::debug!("flags: {:?}", flags);

    setup_runtime(flags)?;
    mizer_ui::run();

    Ok(())
}

fn setup_runtime(flags: Flags) -> anyhow::Result<()> {
    std::thread::Builder::new()
        .name("Task Runtime".into())
        .spawn(|| {
            log::trace!("Starting tokio runtime");
            let runtime = tokio::runtime::Builder::new()
                .enable_all()
                .thread_name("mizer-tokio-runtime")
                .threaded_scheduler()
                .build()
                .unwrap();

            start_runtime(runtime, flags).unwrap();
        })?;
    Ok(())
}

fn start_runtime(mut runtime: tokio::runtime::Runtime, flags: Flags) -> anyhow::Result<()> {
    let local = LocalSet::new();
    // TODO: integrate discovery mode
    Session::new()?;

    let mut mizer = runtime.block_on(build_runtime(flags))?;
    local.block_on(&mut runtime, mizer.run());

    Ok(())
}
