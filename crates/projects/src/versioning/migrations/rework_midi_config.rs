use indexmap::IndexMap;
use serde::{Deserialize, Serialize};
use serde_yaml::Value;

use crate::versioning::migrations::ProjectFileMigration;

#[derive(Clone, Copy)]
pub struct ReworkMidiConfigMigration;

impl ProjectFileMigration for ReworkMidiConfigMigration {
    const VERSION: usize = 2;

    fn migrate(&self, project_file: &mut String) -> anyhow::Result<()> {
        let project: ProjectConfig<OldMidiConfig> = serde_yaml::from_str(project_file)?;
        let project: ProjectConfig<NewMidiConfig> = project.into();

        *project_file = serde_yaml::to_string(&project)?;

        Ok(())
    }
}

impl From<ProjectConfig<OldMidiConfig>> for ProjectConfig<NewMidiConfig> {
    fn from(config: ProjectConfig<OldMidiConfig>) -> Self {
        Self {
            nodes: config
                .nodes
                .into_iter()
                .map(Node::<NewMidiConfig>::from)
                .collect(),
            other: config.other,
        }
    }
}

impl From<Node<OldMidiConfig>> for Node<NewMidiConfig> {
    fn from(value: Node<OldMidiConfig>) -> Self {
        Self {
            midi_config: value.midi_config.into(),
            other: value.other,
        }
    }
}

impl From<NodeConfig<OldMidiConfig>> for NodeConfig<NewMidiConfig> {
    fn from(value: NodeConfig<OldMidiConfig>) -> Self {
        match value {
            NodeConfig::Midi(config) => Self::Midi(MidiConfig {
                config: config.config.into(),
                device: config.device,
            }),
            NodeConfig::Other(config) => Self::Other(config),
            NodeConfig::Unit => Self::Unit,
        }
    }
}

impl From<OldMidiConfig> for NewMidiConfig {
    fn from(value: OldMidiConfig) -> Self {
        match value {
            OldMidiConfig::Note {
                channel,
                port,
                range,
            } => Self::Note {
                mode: NoteMode::Note,
                channel,
                port,
                range,
            },
            OldMidiConfig::CC {
                channel,
                port,
                range,
            } => Self::Note {
                mode: NoteMode::CC,
                channel,
                port,
                range,
            },
            OldMidiConfig::Control { page, control } => Self::Control { page, control },
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
    midi_config: NodeConfig<T>,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(untagged)]
enum NodeConfig<T: Serialize> {
    Midi(MidiConfig<T>),
    Other(IndexMap<String, Value>),
    Unit,
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
struct MidiConfig<T: Serialize> {
    #[serde(flatten)]
    config: T,
    device: String,
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(tag = "type", rename_all = "lowercase")]
enum OldMidiConfig {
    CC {
        #[serde(default = "default_channel")]
        channel: u8,
        port: u8,
        #[serde(default = "default_midi_range")]
        range: (u8, u8),
    },
    Note {
        #[serde(default = "default_channel")]
        channel: u8,
        port: u8,
        #[serde(default = "default_midi_range")]
        range: (u8, u8),
    },
    Control {
        page: String,
        control: String,
    },
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(tag = "type", rename_all = "lowercase")]
enum NewMidiConfig {
    Note {
        mode: NoteMode,
        channel: u8,
        port: u8,
        range: (u8, u8),
    },
    Control {
        page: String,
        control: String,
    },
}

#[derive(Debug, Serialize, Deserialize, PartialEq, Eq)]
enum NoteMode {
    CC,
    Note,
}

fn default_channel() -> u8 {
    1
}

fn default_midi_range() -> (u8, u8) {
    (0, 255)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parse_old_config() {
        let text: &str = r#"
type: midi-input
path: /midi-input-0
config:
  device: APC MINI:APC MINI MIDI 1 32:0
  type: cc
  port: 48
  range: [0, 127]
designer:
  position:
    x: 0
    y: 0
  scale: 1"#;

        let config: Node<OldMidiConfig> = serde_yaml::from_str(text).unwrap();

        assert_eq!(
            NodeConfig::Midi(MidiConfig {
                config: OldMidiConfig::CC {
                    range: (0, 127),
                    port: 48,
                    channel: 1,
                },
                device: "APC MINI:APC MINI MIDI 1 32:0".to_string()
            }),
            config.midi_config
        )
    }
}
