use serde::{Deserialize, Serialize};
use std::convert::TryFrom;
use lazy_static::lazy_static;
use regex::Regex;
use std::collections::HashMap;
use std::fs::File;
use std::path::Path;
use mizer_oscillator_nodes::OscillatorType;
use mizer_video_nodes::VideoEffectType;

lazy_static! {
    static ref CHANNEL_REGEX: Regex = Regex::new(r"^(?P<fc>[a-z\-]*)@(?P<fi>[a-z0-9\-]*)\s->\s(?P<tc>[a-z\-]*)@(?P<ti>[a-z0-9\-]*)$").unwrap();
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Project {
    pub nodes: Vec<Node>,
    #[serde(default)]
    pub channels: Vec<Channel>
}

#[derive(Clone, Serialize, Deserialize, PartialEq)]
#[serde(try_from = "String", into = "String")]
pub struct Channel {
    pub from_id: String,
    pub from_channel: String,
    pub to_id: String,
    pub to_channel: String
}

impl TryFrom<String> for Channel {
    type Error = String;

    fn try_from(value: String) -> Result<Self, Self::Error> {
        if let Some(captures) = CHANNEL_REGEX.captures(&value) {
            let from_id = captures.name("fi").unwrap().as_str().into();
            let from_channel = captures.name("fc").unwrap().as_str().into();
            let to_id = captures.name("ti").unwrap().as_str().into();
            let to_channel = captures.name("tc").unwrap().as_str().into();

            Ok(Channel {
                from_id,
                from_channel,
                to_id,
                to_channel
            })
        }else {
            Err("invalid channel format".into())
        }
    }
}

impl From<Channel> for String {
    fn from(channel: Channel) -> Self {
        format!("{:?}", channel)
    }
}

impl std::fmt::Debug for Channel {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}@{} -> {}@{}", self.from_channel, self.from_id, self.to_channel, self.to_id)
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Node {
    pub id: String,
    #[serde(flatten)]
    pub config: NodeConfig,
    #[serde(default)]
    pub properties: HashMap<String, f64>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
#[serde(tag = "type", content = "config", rename_all = "kebab-case")]
pub enum NodeConfig {
    ArtnetOutput {
        host: String,
        port: Option<u16>
    },
    PixelPattern {
        pattern: mizer_pixel_nodes::Pattern
    },
    PixelDmx {
        width: u64,
        height: u64,
        start_universe: Option<u16>
    },
    OpcOutput {
        host: String,
        port: Option<u16>,
        width: u64,
        height: u64
    },
    ConvertToDmx {
        universe: Option<u16>,
        channel: Option<u16>
    },
    Oscillator {
        #[serde(rename = "type")]
        oscillator_type: OscillatorType
    },
    Clock {
        speed: f64
    },
    Script(String),
    OscInput {
        host: Option<String>,
        port: u16,
        path: String
    },
    Fader,
    VideoFile {
        file: String
    },
    VideoEffect {
        #[serde(rename = "type")]
        effect_type: VideoEffectType
    },
    VideoTransform,
    VideoColorBalance,
    VideoOutput
}

pub fn load_project_file<P: AsRef<Path>>(path: P) -> anyhow::Result<Project> {
    let file = File::open(path)?;
    let project = serde_yaml::from_reader(file)?;

    Ok(project)
}

pub fn load_project(content: &str) -> anyhow::Result<Project> {
    let project = serde_yaml::from_str(content)?;

    Ok(project)
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::collections::HashMap;

    #[test]
    fn load_empty_project() -> anyhow::Result<()> {
        let content = "nodes: []\nchannels: []";

        let result: Project = serde_yaml::from_str(content)?;

        assert_eq!(result.nodes.len(), 0);
        assert_eq!(result.channels.len(), 0);
        Ok(())
    }

    #[test]
    fn load_single_node() -> anyhow::Result<()> {
        let content = r#"
        nodes:
        - type: opc-output
          id: opc-output-0
          config:
            host: 0.0.0.0
            width: 10
            height: 20
        "#;

        let result: Project = serde_yaml::from_str(content)?;

        assert_eq!(result.nodes.len(), 1);
        assert_eq!(result.nodes[0], Node {
            id: "opc-output-0".into(),
            config: NodeConfig::OpcOutput {
                host: "0.0.0.0".into(),
                port: None,
                width: 10,
                height: 20
            },
            properties: HashMap::new(),
        });
        Ok(())
    }

    #[test]
    fn load_channel() -> anyhow::Result<()> {
        let content = r#"
        nodes:
          - type: pixel-pattern
            id: pixel-pattern-0
            config:
              pattern: rgb-iterate
          - type: opc-output
            id: opc-output-0
            config:
              host: 127.0.0.1
              width: 25
              height: 50
        channels:
          - output@pixel-pattern-0 -> pixels@opc-output-0
        "#;

        let result: Project = serde_yaml::from_str(content)?;

        assert_eq!(result.nodes.len(), 2);
        assert_eq!(result.channels.len(), 1);
        assert_eq!(result.nodes[0], Node {
            id: "pixel-pattern-0".into(),
            config: NodeConfig::PixelPattern {
                pattern: mizer_pixel_nodes::Pattern::RgbIterate
            },
            properties: HashMap::new(),
        });
        assert_eq!(result.nodes[1], Node {
            id: "opc-output-0".into(),
            config: NodeConfig::OpcOutput {
                host: "127.0.0.1".into(),
                port: None,
                width: 25,
                height: 50
            },
            properties: HashMap::new(),
        });
        assert_eq!(result.channels[0], Channel {
            from_id: "pixel-pattern-0".into(),
            from_channel: "output".into(),
            to_id: "opc-output-0".into(),
            to_channel: "pixels".into()
        });
        Ok(())
    }

    #[test]
    fn load_properties() -> anyhow::Result<()> {
        let content = r#"
        nodes:
        - type: fader
          id: fader-0
          properties:
            value: 0.5
        "#;

        let result: Project = serde_yaml::from_str(content)?;

        let mut expected = HashMap::new();
        expected.insert("value".to_string(), 0.5f64);
        assert_eq!(result.nodes.len(), 1);
        assert_eq!(result.nodes[0], Node {
            id: "fader-0".into(),
            config: NodeConfig::Fader,
            properties: expected,
        });
        Ok(())
    }
}
