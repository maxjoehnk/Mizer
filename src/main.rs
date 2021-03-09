use structopt::StructOpt;

use mizer::{build_runtime, Flags};
use mizer_session::Session;

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    env_logger::init();
    let flags = Flags::from_args();
    log::debug!("flags: {:?}", flags);

    // TODO: integrate discovery mode
    Session::new()?;

    let mut mizer = build_runtime(flags).await?;
    mizer.run().await;

    Ok(())
}
