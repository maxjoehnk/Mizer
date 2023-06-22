use self::migrations::*;
use enum_iterator::all;
use indexmap::IndexMap;
use serde::{Deserialize, Serialize};

#[macro_use]
mod migration;
mod migrations;

migrations! {
    RenamePorts,
    ReworkMidiConfig,
    ReworkLayoutControlsToNotUseNodes,
    MigratePositionPresets,
}

impl Migrations {
    pub fn latest_version() -> usize {
        all::<Self>()
            .map(|migration| migration.version())
            .max()
            .unwrap_or_default()
    }
}

#[profiling::function]
pub fn migrate(project: &mut String) -> anyhow::Result<()> {
    let version = get_version(project)?;
    let mut migrations = all::<Migrations>()
        .filter(|migration| migration.version() > version)
        .collect::<Vec<_>>();
    migrations.sort_by_key(|migration| migration.version());

    for migration in migrations {
        migration.migrate(project)?;
    }

    Ok(())
}

#[profiling::function]
fn get_version(file: &str) -> anyhow::Result<usize> {
    let project_file: ProjectVersion = serde_yaml::from_str(file)?;

    Ok(project_file.version)
}

#[profiling::function]
fn write_version(file: &mut String, version: usize) -> anyhow::Result<()> {
    let mut project_file: ProjectVersionWithContent = serde_yaml::from_str(file)?;
    project_file.version = version;
    *file = serde_yaml::to_string(&project_file)?;

    Ok(())
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
struct ProjectVersion {
    #[serde(default)]
    pub version: usize,
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
struct ProjectVersionWithContent {
    #[serde(default)]
    pub version: usize,
    #[serde(flatten)]
    content: IndexMap<String, serde_yaml::Value>,
}
