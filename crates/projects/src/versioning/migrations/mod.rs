use crate::project_file::ProjectArchive;
pub use adapt_fader_config::*;
pub use archive_file::*;
pub use migrate_position_presets::*;
pub use rename_ports::*;
pub use rework_layout_controls_to_not_use_nodes::*;
pub use rework_midi_config::*;

mod adapt_fader_config;
mod archive_file;
mod migrate_position_presets;
mod rename_ports;
mod rework_layout_controls_to_not_use_nodes;
mod rework_midi_config;

pub trait ProjectFileMigration: Clone + Copy {
    const VERSION: u32;

    fn migrate(&self, project_file: &mut Vec<u8>) -> anyhow::Result<()>;
}

pub trait ProjectArchiveMigration: Clone + Copy {
    const VERSION: u32;

    fn migrate(&self, project_archive: &mut ProjectArchive) -> anyhow::Result<()>;
}
