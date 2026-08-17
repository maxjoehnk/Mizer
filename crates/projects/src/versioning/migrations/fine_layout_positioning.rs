use crate::versioning::migrations::ProjectFileMigration;
use indexmap::IndexMap;
use mizer_layouts::ControlPosition;
use serde::{Deserialize, Serialize};
use serde_yaml::Value;

#[derive(Clone, Copy)]
pub struct FineLayoutPositioning;

impl ProjectFileMigration for FineLayoutPositioning {
    const VERSION: usize = 7;

    fn migrate(&self, project_file: &mut String) -> anyhow::Result<()> {
        profiling::scope!("FineLayoutPositioning::migrate");
        let mut project: ProjectConfig = serde_yaml::from_str(project_file)?;
        project.adapt();

        *project_file = serde_yaml::to_string(&project)?;

        Ok(())
    }
}

#[derive(Debug, Serialize, Deserialize)]
struct ProjectConfig {
    layouts: IndexMap<String, Vec<Control>>,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

impl ProjectConfig {
    fn adapt(&mut self) {
        for (_, controls) in self.layouts.iter_mut() {
            for control in controls.iter_mut() {
                control.size.width *= 10;
                control.size.height *= 10;
                control.position.x *= 10;
                control.position.y *= 10;
            }
        }
    }
}

#[derive(Debug, Serialize, Deserialize)]
struct Control {
    size: ControlSize,
    position: ControlPosition,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

#[derive(Debug, Serialize, Deserialize, PartialEq)]
struct ControlSize {
    width: u64,
    height: u64,
}

#[derive(Debug, Serialize, Deserialize, PartialEq)]
struct Position {
    x: u64,
    y: u64,
}

#[cfg(test)]
mod tests {
    use super::*;
    use mizer_layouts::ControlPosition;
    use test_case::test_case;

    #[test]
    fn parse_old_config() {
        let text: &str = r#"
id: 60367366-c4f9-42d2-95fa-f140ced5f438
label: ~
path: /level-0
position:
  x: 1
  y: 1
size:
  width: 1
  height: 4
decoration:
  color: ~
  image: ~
behavior:
  sequencer:
    click_behavior: GoForward
hotkey: ~"#;

        let config: Control = serde_yaml::from_str(text).unwrap();

        assert_eq!(
            ControlSize {
                width: 1,
                height: 4,
            },
            config.size
        );
        assert_eq!(ControlPosition { x: 1, y: 1 }, config.position);
    }

    #[test_case((1, 4), (10, 40))]
    #[test_case((4, 1), (40, 10))]
    fn adapt_should_multiply_size_by_10(size: (u64, u64), expected: (u64, u64)) {
        let mut layouts = IndexMap::new();
        layouts.insert(
            "Default".to_string(),
            vec![Control {
                size: ControlSize {
                    width: size.0,
                    height: size.1,
                },
                position: ControlPosition { x: 1, y: 4 },
                other: Default::default(),
            }],
        );
        let mut config = ProjectConfig {
            layouts,
            other: Default::default(),
        };

        config.adapt();

        assert_eq!(
            ControlSize {
                width: expected.0,
                height: expected.1
            },
            config.layouts["Default"][0].size
        );
    }

    #[test_case((1, 4), (10, 40))]
    #[test_case((4, 1), (40, 10))]
    fn adapt_should_multiply_position_by_10(size: (u64, u64), expected: (u64, u64)) {
        let mut layouts = IndexMap::new();
        layouts.insert(
            "Default".to_string(),
            vec![Control {
                size: ControlSize {
                    width: 1,
                    height: 4,
                },
                position: ControlPosition {
                    x: size.0,
                    y: size.1,
                },
                other: Default::default(),
            }],
        );
        let mut config = ProjectConfig {
            layouts,
            other: Default::default(),
        };

        config.adapt();

        assert_eq!(
            ControlPosition {
                x: expected.0,
                y: expected.1
            },
            config.layouts["Default"][0].position
        );
    }
}
