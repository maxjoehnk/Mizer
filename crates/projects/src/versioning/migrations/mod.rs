pub use rename_ports::*;
pub use rework_midi_config::*;

mod rename_ports;
mod rework_midi_config;

pub trait ProjectFileMigration: Clone + Copy {
    const VERSION: usize;

    fn migrate(&self, project_file: &mut String) -> anyhow::Result<()>;
}
