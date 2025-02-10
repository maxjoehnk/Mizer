use indexmap::IndexMap;
use mizer_fixtures::programmer::PresetId;
use serde::{Deserialize, Serialize};
use serde_yaml::Value;

use crate::versioning::migrations::ProjectFileMigration;

#[derive(Clone, Copy)]
pub struct ReworkLayoutControlsToNotUseNodes;

impl ProjectFileMigration for ReworkLayoutControlsToNotUseNodes {
    const VERSION: u32 = 3;

    fn migrate(&self, project_file: &mut Vec<u8>) -> anyhow::Result<()> {
        profiling::scope!("ReworkLayoutControlsToNotUseNodes::migrate");
        let project: ProjectConfig<OldControlConfig> = serde_yaml::from_slice(&project_file)?;
        let project: ProjectConfig<NewControlConfig> = project.into();

        *project_file = serde_yaml::to_vec(&project)?;

        Ok(())
    }
}

impl From<ProjectConfig<OldControlConfig>> for ProjectConfig<NewControlConfig> {
    fn from(config: ProjectConfig<OldControlConfig>) -> Self {
        Self {
            layouts: config
                .layouts
                .into_iter()
                .map(|(id, controls)| {
                    (
                        id,
                        controls
                            .into_iter()
                            .filter_map(|control| {
                                let node = config
                                    .nodes
                                    .iter()
                                    .find(|node| node.path == control.config.node)
                                    .map(|node| &node.node_config)?;
                                let config = match node {
                                    NodeConfig::Preset(preset) => NewControlConfig::Preset {
                                        preset_id: preset.id,
                                    },
                                    NodeConfig::Group(group) => {
                                        NewControlConfig::Group { group_id: group.id }
                                    }
                                    NodeConfig::Sequence(sequence) => NewControlConfig::Sequencer {
                                        sequence_id: sequence.id,
                                    },
                                    _ => NewControlConfig::Node {
                                        path: control.config.node,
                                    },
                                };
                                Some(Control {
                                    config,
                                    other: control.other,
                                })
                            })
                            .collect(),
                    )
                })
                .collect(),
            nodes: config.nodes,
            other: config.other,
        }
    }
}

#[derive(Debug, Serialize, Deserialize)]
struct ProjectConfig<T: Serialize> {
    #[serde(default = "IndexMap::new")]
    layouts: IndexMap<String, Vec<Control<T>>>,
    #[serde(default)]
    nodes: Vec<Node>,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

#[derive(Debug, Serialize, Deserialize)]
struct Control<T: Serialize> {
    #[serde(flatten)]
    config: T,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

#[derive(Debug, Serialize, Deserialize)]
struct Node {
    path: String,
    #[serde(rename = "config")]
    node_config: NodeConfig,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(untagged)]
enum NodeConfig {
    Preset(PresetConfig),
    Group(GroupConfig),
    Sequence(SequenceConfig),
    Other(IndexMap<String, Value>),
    Unit,
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
struct PresetConfig {
    id: PresetId,
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
struct GroupConfig {
    id: u32,
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
struct SequenceConfig {
    #[serde(rename = "sequence")]
    id: u32,
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
struct OldControlConfig {
    node: String,
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(untagged)]
enum NewControlConfig {
    Node { path: String },
    Sequencer { sequence_id: u32 },
    Group { group_id: u32 },
    Preset { preset_id: PresetId },
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn migration_should_migrate_button_control() {
        let input = br#"
layouts:
    Test:
        - node: /test
nodes:
    - path: /test
      type: button
      config:
        toggle: false
        "#;
        let mut input = input.to_vec();

        ReworkLayoutControlsToNotUseNodes
            .migrate(&mut input)
            .unwrap();

        let config: ProjectConfig<NewControlConfig> = serde_yaml::from_slice(&input).unwrap();
        assert_eq!(
            NewControlConfig::Node {
                path: "/test".to_string()
            },
            config.layouts["Test"][0].config
        );
    }

    #[test]
    fn migration_should_migrate_group_control() {
        let input = br#"
layouts:
    Test:
        - node: /test
nodes:
    - path: /test
      type: group
      config:
        id: 1
        "#;
        let mut input = input.to_vec();

        ReworkLayoutControlsToNotUseNodes
            .migrate(&mut input)
            .unwrap();

        let config: ProjectConfig<NewControlConfig> = serde_yaml::from_slice(&input).unwrap();
        assert_eq!(
            NewControlConfig::Group { group_id: 1 },
            config.layouts["Test"][0].config
        );
    }

    #[test]
    fn migration_should_migrate_preset_control() {
        let input = br#"
layouts:
    Test:
        - node: /test
nodes:
    - path: /test
      type: preset
      config:
        id:
          Intensity: 1
        "#;
        let mut input = input.to_vec();

        ReworkLayoutControlsToNotUseNodes
            .migrate(&mut input)
            .unwrap();

        let config: ProjectConfig<NewControlConfig> = serde_yaml::from_slice(&input).unwrap();
        assert_eq!(
            NewControlConfig::Preset {
                preset_id: PresetId::Intensity(1),
            },
            config.layouts["Test"][0].config
        );
    }

    #[test]
    fn migration_should_migrate_sequence_control() {
        let input = br#"
layouts:
    Test:
        - node: /test
nodes:
    - path: /test
      type: sequence
      config:
        sequence: 1
        "#;
        let mut input = input.to_vec();

        ReworkLayoutControlsToNotUseNodes
            .migrate(&mut input)
            .unwrap();

        let config: ProjectConfig<NewControlConfig> = serde_yaml::from_slice(&input).unwrap();
        assert_eq!(
            NewControlConfig::Sequencer { sequence_id: 1 },
            config.layouts["Test"][0].config
        );
    }
}
