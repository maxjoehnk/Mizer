use std::path::PathBuf;

use structopt::StructOpt;

#[derive(StructOpt)]
pub struct Flags {
    #[structopt(long)]
    pub print_pipeline: bool,
    #[structopt(name = "FILE", parse(from_os_str))]
    pub files: Vec<PathBuf>,
    #[cfg(feature = "export_metrics")]
    #[structopt(long)]
    pub metrics: bool,
    #[cfg(feature = "export_metrics")]
    #[structopt(long, default_value = "8888")]
    pub metrics_port: u16,
    /// Join an existing session or start a new session
    #[structopt(long)]
    pub join: bool,
}
