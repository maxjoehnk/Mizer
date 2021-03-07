use structopt::StructOpt;

use mizer::{build_runtime, Flags};

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    env_logger::init();
    let flags = Flags::from_args();
    log::debug!("flags: {:?}", flags);

    // TODO: pins cpu, reduce cpu usage
    // let _session = if flags.join {
    //     Session::discover()?
    // } else {
    //     Session::new()?
    // };
    let mut mizer = build_runtime(flags).await?;
    mizer.run().await;

    Ok(())
}
