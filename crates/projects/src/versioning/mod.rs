use crate::project_file::ProjectFile;
use enum_iterator::all;

use self::migrations::*;

#[macro_use]
mod migration;
mod migrations;

migrations! {
    RenamePorts,
    ReworkMidiConfig,
    ReworkLayoutControlsToNotUseNodes,
    MigratePositionPresets,
    AdaptFaderConfig,
    ArchiveFile,
}

yaml_migrations! {
    RenamePorts,
    ReworkMidiConfig,
    ReworkLayoutControlsToNotUseNodes,
    MigratePositionPresets,
    AdaptFaderConfig,
}

impl Migrations {
    pub fn latest_version() -> u32 {
        all::<Self>()
            .map(|migration| migration.version())
            .max()
            .unwrap_or_default()
    }
}

#[derive(Debug, Clone, Copy)]
pub struct MigrationResult {
    pub from_version: u32,
    pub to_version: u32,
}

#[profiling::function]
pub fn migrate(project_file: &mut ProjectFile) -> anyhow::Result<MigrationResult> {
    let version = project_file.get_version()?;
    let mut migrations = all::<Migrations>()
        .filter(|migration| migration.version() > version)
        .collect::<Vec<_>>();
    migrations.sort_by_key(|migration| migration.version());

    for migration in migrations {
        migration.migrate(project_file)?;
    }

    Ok(MigrationResult {
        from_version: version,
        to_version: Migrations::latest_version(),
    })
}
