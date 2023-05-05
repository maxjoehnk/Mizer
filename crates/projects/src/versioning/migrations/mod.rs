pub use rename_ports::*;

use crate::Project;

mod rename_ports;

pub trait ProjectMigration: Clone + Copy {
    const VERSION: usize;

    fn migrate(&self, project: &mut Project) -> anyhow::Result<()>;
}
