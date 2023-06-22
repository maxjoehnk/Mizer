use indexmap::IndexMap;
use serde::{Deserialize, Serialize};
use serde_yaml::Value;

use crate::versioning::migrations::ProjectFileMigration;

#[derive(Clone, Copy)]
pub struct MigratePositionPresets;

impl ProjectFileMigration for MigratePositionPresets {
    const VERSION: usize = 4;

    fn migrate(&self, project_file: &mut String) -> anyhow::Result<()> {
        profiling::scope!("MigratePositionPresets::migrate");
        let project: ProjectConfig<OldPosition> = serde_yaml::from_str(project_file)?;
        let project: ProjectConfig<NewPosition> = project.into();

        *project_file = serde_yaml::to_string(&project)?;

        Ok(())
    }
}

impl From<ProjectConfig<OldPosition>> for ProjectConfig<NewPosition> {
    fn from(config: ProjectConfig<OldPosition>) -> Self {
        Self {
            presets: PresetsConfig {
                position: config
                    .presets
                    .position
                    .into_iter()
                    .map(Preset::from)
                    .collect(),
                other: config.presets.other,
            },
            other: config.other,
        }
    }
}

impl From<Preset<OldPosition>> for Preset<NewPosition> {
    fn from(value: Preset<OldPosition>) -> Self {
        Self {
            value: value.value.into(),
            other: value.other,
        }
    }
}

impl From<OldPosition> for NewPosition {
    fn from((pan, tilt): OldPosition) -> Self {
        NewPosition::PanTilt(pan, tilt)
    }
}

#[derive(Debug, Serialize, Deserialize)]
struct ProjectConfig<T: Serialize> {
    presets: PresetsConfig<T>,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

#[derive(Debug, Serialize, Deserialize)]
struct PresetsConfig<T: Serialize> {
    position: Vec<Preset<T>>,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

#[derive(Debug, Serialize, Deserialize)]
struct Preset<T: Serialize> {
    value: T,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

type OldPosition = (f64, f64);

#[derive(Debug, Deserialize, Serialize, Clone, Copy, PartialEq)]
enum NewPosition {
    Pan(f64),
    Tilt(f64),
    PanTilt(f64, f64),
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parse_old_config() {
        let text: &str = r#"
value:
  - 1.0
  - 0.0"#;

        let preset: Preset<OldPosition> = serde_yaml::from_str(text).unwrap();

        assert_eq!((1.0, 0.0), preset.value)
    }
}
