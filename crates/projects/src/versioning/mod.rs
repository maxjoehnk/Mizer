use self::migrations::*;
use crate::Project;
use enum_iterator::all;

#[macro_use]
mod migration;
mod migrations;

migrations! {
    RenamePortsMigration,
}

impl Migrations {
    pub fn latest_version() -> usize {
        all::<Self>()
            .map(|migration| migration.version())
            .max()
            .unwrap_or_default()
    }
}

pub fn migrate(project: &mut Project) -> anyhow::Result<()> {
    let mut migrations = all::<Migrations>()
        .filter(|migration| migration.version() > project.version)
        .collect::<Vec<_>>();
    migrations.sort_by_key(|migration| migration.version());

    for migration in migrations {
        migration.migrate(project)?;
    }

    Ok(())
}
