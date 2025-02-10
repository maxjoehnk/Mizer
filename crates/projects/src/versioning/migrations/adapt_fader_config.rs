use indexmap::IndexMap;
use serde::{Deserialize, Serialize};
use serde_yaml::Value;

use crate::versioning::migrations::ProjectFileMigration;

#[derive(Clone, Copy)]
pub struct AdaptFaderConfig;

impl ProjectFileMigration for AdaptFaderConfig {
    const VERSION: u32 = 5;

    fn migrate(&self, project_file: &mut Vec<u8>) -> anyhow::Result<()> {
        profiling::scope!("AdaptFaderConfig::migrate");
        let project: ProjectConfig<OldFaderConfig> = serde_yaml::from_slice(&project_file)?;
        let project: ProjectConfig<NewFaderConfig> = project.into();

        *project_file = serde_yaml::to_vec(&project)?;

        Ok(())
    }
}

impl From<ProjectConfig<OldFaderConfig>> for ProjectConfig<NewFaderConfig> {
    fn from(config: ProjectConfig<OldFaderConfig>) -> Self {
        Self {
            nodes: config
                .nodes
                .into_iter()
                .map(Node::<NewFaderConfig>::from)
                .collect(),
            other: config.other,
        }
    }
}

impl From<Node<OldFaderConfig>> for Node<NewFaderConfig> {
    fn from(value: Node<OldFaderConfig>) -> Self {
        Self {
            fader_config: value.fader_config.into(),
            other: value.other,
        }
    }
}

impl From<NodeConfig<OldFaderConfig>> for NodeConfig<NewFaderConfig> {
    fn from(value: NodeConfig<OldFaderConfig>) -> Self {
        match value {
            NodeConfig::Fader(_) => Self::Fader(NewFaderConfig::default()),
            NodeConfig::Other(config) => Self::Other(config),
            NodeConfig::Unit => Self::Unit,
        }
    }
}

#[derive(Debug, Serialize, Deserialize)]
struct ProjectConfig<T: Serialize> {
    nodes: Vec<Node<T>>,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

#[derive(Debug, Serialize, Deserialize)]
struct Node<T: Serialize> {
    #[serde(rename = "config")]
    fader_config: NodeConfig<T>,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(untagged)]
enum NodeConfig<T: Serialize> {
    Fader(T),
    Other(IndexMap<String, Value>),
    Unit,
}

#[derive(Default, Debug, Serialize, Deserialize, PartialEq, Eq)]
struct OldFaderConfig;

#[derive(Default, Debug, Serialize, Deserialize, PartialEq, Eq)]
struct NewFaderConfig {}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parse_old_config() {
        let text: &str = r#"
type: fader
path: /fader-0
config: ~
designer:
  position:
    x: 0
    y: 0
  scale: 1"#;

        let config: Node<OldFaderConfig> = serde_yaml::from_str(text).unwrap();

        assert_eq!(NodeConfig::Fader(OldFaderConfig), config.fader_config)
    }
}
