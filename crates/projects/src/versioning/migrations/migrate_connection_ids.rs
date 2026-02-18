use std::collections::HashMap;
use std::sync::LazyLock;
use indexmap::IndexMap;
use itertools::Itertools;
use regex::Regex;
use serde::{Serialize, Deserialize};
use serde_yaml::Value;
use crate::versioning::migrations::ProjectFileMigration;

static CONNECTION_ID_REGEX: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"^([a-z-]+)-(\d+)$").unwrap());

#[derive(Clone, Copy)]
pub struct MigrateConnectionIds;

impl ProjectFileMigration for MigrateConnectionIds {
    const VERSION: usize = 7;

    fn migrate(&self, project_file: &mut String) -> anyhow::Result<()> {
        profiling::scope!("MigrateConnectionIds::migrate");
        let mut project: ProjectConfig = serde_yaml::from_str(project_file)?;

        project.adapt();

        *project_file = serde_yaml::to_string(&project)?;

        Ok(())
    }
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
struct ProjectConfig {
    #[serde(default)]
    nodes: Vec<Node>,
    #[serde(default)]
    connections: Vec<Connection>,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

impl ProjectConfig {
    fn adapt(&mut self) {
        let connection_types = {
            let mut connection_types = HashMap::new();
            connection_types.insert("artnet-output", "dmx");
            connection_types.insert("sacn", "dmx");
            connection_types.insert("artnet-input", "dmx-input");
            connection_types.insert("osc", "osc");

            connection_types
        };

        let mut id_mappings = HashMap::new();
        let mut highest_ids = HashMap::new();
        for (type_name, ids) in self.connections.iter()
            .flat_map(|c| CONNECTION_ID_REGEX.captures(&c.id))
            .map(|m| (m[1].to_string(), m[2].parse::<usize>().unwrap()))
            .chunk_by(|(type_name, _)| type_name.clone()).into_iter() {
            let highest_id = ids.map(|(_, v)| v).max().unwrap_or(0);
            highest_ids.insert(type_name, highest_id);
        }

        for connection in self.connections.iter_mut() {
            if connection_types.contains_key(connection.connection_type.as_str()) {
                if CONNECTION_ID_REGEX.is_match(&connection.id) {
                    continue;
                }
                let type_name = connection_types[connection.connection_type.as_str()].to_string();
                let new_type_id = *highest_ids.entry(type_name.clone()).or_insert(0) + 1;
                let new_id = format!("{type_name}-{}", new_type_id);
                tracing::debug!(
                    "Connection ID {} is not in the expected format. It will be renamed to {new_id}",
                    connection.id
                );
                id_mappings.insert(connection.id.clone(), new_id.clone());
                connection.id = new_id;
                highest_ids.insert(type_name, new_type_id);
            }
        }

        for node in self.nodes.iter_mut() {
            if matches!(node.node_type.as_str(), "osc-input" | "osc-output") {
                if let NodeConfig::Osc { connection, .. } = &mut node.node_config {
                    *connection = id_mappings.get(connection).unwrap_or(connection).clone();
                }
            }
            if matches!(node.node_type.as_str(), "dmx-input") {
                if let NodeConfig::DmxInput { input, .. } = &mut node.node_config {
                    *input = id_mappings.get(input).unwrap_or(input).clone();
                }
            }
        }
    }
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
struct Node {
    #[serde(rename = "type")]
    node_type: String,
    #[serde(rename = "config")]
    node_config: NodeConfig,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(untagged)]
enum NodeConfig {
    Osc { connection: String, #[serde(flatten)] other: IndexMap<String, Value> },
    DmxInput { input: String, #[serde(flatten)] other: IndexMap<String, Value> },
    Other(IndexMap<String, Value>),
    Unit,
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
struct Connection {
    id: String,
    #[serde(rename = "type")]
    connection_type: String,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::versioning::migrations::ProjectFileMigration;

    #[test]
    fn migrate_artnet_output_id() -> anyhow::Result<()> {
        let input: &str = r#"---
nodes: []
connections:
  - id: Node
    type: artnet-output
    host: 10.0.10.10
    port: 6454
"#;
        let expected: &str = r#"---
nodes: []
connections:
  - id: dmx-1
    type: artnet-output
    host: 10.0.10.10
    port: 6454
"#;
        let mut buffer = input.to_string();

        MigrateConnectionIds.migrate(&mut buffer)?;

        assert_eq!(buffer, expected);
        Ok(())
    }

    #[test]
    fn migrate_multiple_artnet_output_ids_should_not_fill_holes() -> anyhow::Result<()> {
        let input: &str = r#"---
nodes: []
connections:
  - id: dmx-0
    type: artnet-output
    host: 10.0.10.10
    port: 6454
  - id: Node
    type: artnet-output
    host: 10.0.10.11
    port: 6454
  - id: dmx-2
    type: sacn-output
    priority: 100
"#;
        let expected: &str = r#"---
nodes: []
connections:
  - id: dmx-0
    type: artnet-output
    host: 10.0.10.10
    port: 6454
  - id: dmx-3
    type: artnet-output
    host: 10.0.10.11
    port: 6454
  - id: dmx-2
    type: sacn-output
    priority: 100
"#;
        let mut buffer = input.to_string();

        MigrateConnectionIds.migrate(&mut buffer)?;

        assert_eq!(buffer, expected);
        Ok(())
    }

    #[test]
    fn migrate_osc_id() -> anyhow::Result<()> {
        let input: &str = r#"---
nodes: []
connections:
  - id: Node
    type: osc
    protocol: udp
    output_host: 127.0.0.1
    output_port: 8000
    input_port: 7000
"#;
        let expected: &str = r#"---
nodes: []
connections:
  - id: osc-1
    type: osc
    protocol: udp
    output_host: 127.0.0.1
    output_port: 8000
    input_port: 7000
"#;
        let mut buffer = input.to_string();

        MigrateConnectionIds.migrate(&mut buffer)?;

        assert_eq!(buffer, expected);
        Ok(())
    }

    #[test]
    fn migrate_osc_id_in_node_config() -> anyhow::Result<()> {
        let input: &str = r#"---
nodes:
  - path: /osc-input-0
    type: osc-input
    config:
      connection: Node
      path: /Node/1/value
      argument_type: float
  - path: /some-node
    type: osc-output
    config:
      connection: Node
      path: /Node/1/value
      argument_type: float
connections:
  - id: Node
    type: osc
    protocol: udp
    output_host: 127.0.0.1
    output_port: 8000
    input_port: 7000
"#;
        let expected: &str = r#"---
nodes:
  - path: /osc-input-0
    type: osc-input
    config:
      connection: osc-1
      path: /Node/1/value
      argument_type: float
  - path: /some-node
    type: osc-output
    config:
      connection: osc-1
      path: /Node/1/value
      argument_type: float
connections:
  - id: osc-1
    type: osc
    protocol: udp
    output_host: 127.0.0.1
    output_port: 8000
    input_port: 7000
"#;
        let mut buffer = input.to_string();

        MigrateConnectionIds.migrate(&mut buffer)?;

        assert_configs(&buffer, expected)
    }

    #[test]
    fn migrate_artnet_input_id_in_node_config() -> anyhow::Result<()> {
        let input: &str = r#"---
nodes:
  - path: /dmx-input-0
    type: dmx-input
    config:
      input: Node
      universe: 1
      channel: 1
connections:
  - id: Node
    type: artnet-input
    port: 6545
    host: 0.0.0.0
"#;
        let expected: &str = r#"---
nodes:
  - path: /dmx-input-0
    type: dmx-input
    config:
      input: dmx-input-1
      universe: 1
      channel: 1
connections:
  - id: dmx-input-1
    type: artnet-input
    port: 6545
    host: 0.0.0.0
"#;
        let mut buffer = input.to_string();

        MigrateConnectionIds.migrate(&mut buffer)?;

        assert_configs(&buffer, expected)
    }


    fn assert_configs(result: &str, expected: &str) -> anyhow::Result<()> {
        let result: ProjectConfig = serde_yaml::from_str(result)?;
        let expected: ProjectConfig = serde_yaml::from_str(expected)?;
        assert_eq!(result, expected);

        Ok(())
    }
}
