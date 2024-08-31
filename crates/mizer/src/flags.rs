use std::path::PathBuf;

use structopt::StructOpt;

#[derive(StructOpt, Debug, Clone, Default)]
pub struct Flags {
    #[structopt(long)]
    pub generate_graph: bool,
    #[structopt(name = "FILE", parse(from_os_str))]
    pub file: Option<PathBuf>,
    /// Open the debug ui
    #[cfg(feature = "debug-ui")]
    #[structopt(long)]
    pub debug: bool,
    /// Join an existing session or start a new session
    #[structopt(long)]
    pub join: bool,
    #[cfg(feature = "ui")]
    #[structopt(long)]
    pub headless: bool,
}
