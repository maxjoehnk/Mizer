use std::path::PathBuf;

use clap::Parser;

#[derive(Parser, Debug, Clone, Default)]
#[command(version, about)]
pub struct Flags {
    #[arg(long)]
    pub generate_graph: bool,
    #[arg(name = "FILE")]
    pub file: Option<PathBuf>,
    /// Open the debug ui
    #[cfg(feature = "debug-ui")]
    #[arg(long)]
    pub debug: bool,
    /// Join an existing session or start a new session
    #[arg(long)]
    pub join: bool,
    #[cfg(feature = "ui")]
    #[arg(long)]
    pub headless: bool,
}
