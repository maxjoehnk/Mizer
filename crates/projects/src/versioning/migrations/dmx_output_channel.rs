use indexmap::IndexMap;
use serde::{Deserialize, Serialize};
use serde_yaml::Value;

use crate::versioning::migrations::ProjectFileMigration;

#[derive(Clone, Copy)]
pub struct DmxOutputChannel;

impl ProjectFileMigration for DmxOutputChannel {
    const VERSION: usize = 6;

    fn migrate(&self, project_file: &mut String) -> anyhow::Result<()> {
        profiling::scope!("DmxOutputChannel::migrate");
        let mut project: ProjectConfig = serde_yaml::from_str(project_file)?;
        project.adapt();

        *project_file = serde_yaml::to_string(&project)?;

        Ok(())
    }
}

#[derive(Debug, Serialize, Deserialize)]
struct ProjectConfig {
    nodes: Vec<Node>,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

impl ProjectConfig {
    fn adapt(&mut self) {
        for node in self.nodes.iter_mut() {
            if let NodeConfig::DmxOutput(config) = &mut node.node_config {
                config.channel = (config.channel + 1).min(512);
                
            }
        }
    }
}

#[derive(Debug, Serialize, Deserialize)]
struct Node {
    #[serde(rename = "config")]
    node_config: NodeConfig,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(untagged)]
enum NodeConfig {
    DmxOutput(DmxOutputConfig),
    Other(IndexMap<String, Value>),
    Unit,
}

#[derive(Default, Debug, Serialize, Deserialize, PartialEq, Eq)]
struct DmxOutputConfig {
    universe: u16,
    channel: u16,
}

#[cfg(test)]
mod tests {
    use super::*;
    use test_case::test_case;

    #[test]
    fn parse_old_config() {
        let text: &str = r#"
type: dmx-output
path: /dmx-output-0
config:
  universe: 1
  channel: 0
designer:
  position:
    x: 0
    y: 0
  scale: 1"#;

        let config: Node = serde_yaml::from_str(text).unwrap();

        assert_eq!(
            NodeConfig::DmxOutput(DmxOutputConfig {
                universe: 1,
                channel: 0
            }),
            config.node_config
        )
    }

    #[test_case(0, 1)]
    #[test_case(2, 3)]
    #[test_case(512, 512)]
    fn adapt_should_increase_dmx_channel_by_one(channel: u16, expected: u16) {
        let mut config = ProjectConfig {
            nodes: vec![Node {
                node_config: NodeConfig::DmxOutput(DmxOutputConfig {
                    universe: 1,
                    channel,
                }),
                other: Default::default(),
            }],
            other: Default::default(),
        };

        config.adapt();

        assert_eq!(
            NodeConfig::DmxOutput(DmxOutputConfig {
                universe: 1,
                channel: expected
            }),
            config.nodes[0].node_config
        );
    }
}
