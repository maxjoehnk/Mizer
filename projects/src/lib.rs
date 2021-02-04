use lazy_static::lazy_static;
use mizer_oscillator_nodes::OscillatorType;
use mizer_sequence_nodes::SequenceStep;
use mizer_video_nodes::VideoEffectType;
use regex::{Regex, RegexBuilder};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::convert::TryFrom;
use std::fs::File;
use std::path::Path;

lazy_static! {
    static ref CHANNEL_REGEX: Regex = RegexBuilder::new(
        r"^(?P<fc>[a-z\-]*)@(?P<fi>[a-z0-9\-]*)\s->\s(?P<tc>[a-z\-]*)@(?P<ti>[a-z0-9\-]*)$"
    )
    .case_insensitive(true)
    .build()
    .unwrap();
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Project {
    #[serde(default)]
    pub nodes: Vec<Node>,
    #[serde(default)]
    pub channels: Vec<Channel>,
    #[serde(default)]
    pub fixtures: Vec<FixtureConfig>,
}

impl Project {
    pub fn load_file<P: AsRef<Path>>(path: P) -> anyhow::Result<Project> {
        let file = File::open(path)?;
        let project = serde_yaml::from_reader(file)?;

        Ok(project)
    }

    pub fn load(content: &str) -> anyhow::Result<Project> {
        let project = serde_yaml::from_str(content)?;

        Ok(project)
    }
}

#[derive(Clone, Serialize, Deserialize, PartialEq)]
#[serde(try_from = "String", into = "String")]
pub struct Channel {
    pub from_id: String,
    pub from_channel: String,
    pub to_id: String,
    pub to_channel: String,
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
                to_channel,
            })
        } else {
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
        write!(
            f,
            "{}@{} -> {}@{}",
            self.from_channel, self.from_id, self.to_channel, self.to_id
        )
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Node {
    pub id: String,
    #[serde(flatten)]
    pub config: NodeConfig,
    #[serde(default)]
    pub properties: HashMap<String, f64>,
    #[serde(default)]
    pub designer: NodeDesignerConfig,
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct NodeDesignerConfig {
    pub position: NodePosition,
    pub scale: f64,
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct NodePosition {
    pub x: f64,
    pub y: f64,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
#[serde(tag = "type", content = "config", rename_all = "kebab-case")]
pub enum NodeConfig {
    ArtnetOutput {
        host: String,
        port: Option<u16>,
    },
    PixelPattern {
        pattern: mizer_pixel_nodes::Pattern,
    },
    PixelDmx {
        width: u64,
        height: u64,
        start_universe: Option<u16>,
    },
    OpcOutput {
        host: String,
        port: Option<u16>,
        width: u64,
        height: u64,
    },
    ConvertToDmx {
        universe: Option<u16>,
        channel: Option<u16>,
    },
    Oscillator {
        #[serde(rename = "type")]
        oscillator_type: OscillatorType,
    },
    Clock {
        speed: f64,
    },
    SacnOutput,
    Script(String),
    OscInput {
        host: Option<String>,
        port: u16,
        path: String,
    },
    Fader,
    VideoFile {
        file: String,
    },
    VideoEffect {
        #[serde(rename = "type")]
        effect_type: VideoEffectType,
    },
    VideoTransform,
    VideoColorBalance,
    VideoOutput,
    Fixture {
        #[serde(rename = "fixture")]
        fixture_id: String,
    },
    Sequence {
        steps: Vec<SequenceStep>,
    },
    MidiInput {},
    MidiOutput {},
    IldaFile {
        file: String,
    },
    Laser {
        device: String,
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct FixtureConfig {
    pub id: String,
    pub fixture: String,
    pub channel: u8,
    pub universe: Option<u16>,
    #[serde(default)]
    pub mode: Option<String>,
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::collections::HashMap;

    #[test]
    fn load_empty_project() -> anyhow::Result<()> {
        let content = "nodes: []\nchannels: []";

        let result = Project::load(content)?;

        assert_eq!(result.nodes.len(), 0, "no nodes");
        assert_eq!(result.channels.len(), 0, "no channels");
        assert_eq!(result.fixtures.len(), 0, "no fixtures");
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
          designer:
            position:
              x: 1
              y: 2
            scale: 3
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.nodes.len(), 1);
        assert_eq!(
            result.nodes[0],
            Node {
                id: "opc-output-0".into(),
                config: NodeConfig::OpcOutput {
                    host: "0.0.0.0".into(),
                    port: None,
                    width: 10,
                    height: 20
                },
                designer: NodeDesignerConfig {
                    position: NodePosition {
                        x: 1.,
                        y: 2.
                    },
                    scale: 3.,
                },
                properties: HashMap::new(),
            }
        );
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

        let result = Project::load(content)?;

        assert_eq!(result.nodes.len(), 2);
        assert_eq!(result.channels.len(), 1);
        assert_eq!(
            result.nodes[0],
            Node {
                id: "pixel-pattern-0".into(),
                config: NodeConfig::PixelPattern {
                    pattern: mizer_pixel_nodes::Pattern::RgbIterate
                },
                designer: Default::default(),
                properties: HashMap::new(),
            }
        );
        assert_eq!(
            result.nodes[1],
            Node {
                id: "opc-output-0".into(),
                config: NodeConfig::OpcOutput {
                    host: "127.0.0.1".into(),
                    port: None,
                    width: 25,
                    height: 50
                },
                designer: Default::default(),
                properties: HashMap::new(),
            }
        );
        assert_eq!(
            result.channels[0],
            Channel {
                from_id: "pixel-pattern-0".into(),
                from_channel: "output".into(),
                to_id: "opc-output-0".into(),
                to_channel: "pixels".into()
            }
        );
        Ok(())
    }

    #[test]
    fn load_channel_should_support_uppercase() -> anyhow::Result<()> {
        let content = r#"
        nodes: []
        channels:
          - Output@pixel-pattern-0 -> pixels@opc-output-0
        "#;

        let result = Project::load(content)?;

        assert_eq!(
            result.channels[0],
            Channel {
                from_id: "pixel-pattern-0".into(),
                from_channel: "Output".into(),
                to_id: "opc-output-0".into(),
                to_channel: "pixels".into()
            }
        );
        Ok(())
    }

    #[test]
    fn load_properties() -> anyhow::Result<()> {
        let mut expected = HashMap::new();
        expected.insert("value".to_string(), 0.5f64);
        let content = r#"
        nodes:
        - type: fader
          id: fader-0
          properties:
            value: 0.5
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.nodes.len(), 1);
        assert_eq!(
            result.nodes[0],
            Node {
                id: "fader-0".into(),
                config: NodeConfig::Fader,
                designer: Default::default(),
                properties: expected,
            }
        );
        Ok(())
    }

    #[test]
    fn load_fixtures() -> anyhow::Result<()> {
        let content = r#"
        fixtures:
        - id: fixture-0
          fixture: fixture-definition-ref
          channel: 1
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.fixtures.len(), 1);
        assert_eq!(
            result.fixtures[0],
            FixtureConfig {
                id: "fixture-0".into(),
                fixture: "fixture-definition-ref".into(),
                channel: 1,
                universe: None,
                mode: None,
            }
        );
        Ok(())
    }

    #[test]
    fn load_fixtures_with_mode() -> anyhow::Result<()> {
        let content = r#"
        fixtures:
        - id: fixture-1
          fixture: another-fixture
          channel: 5
          mode: 2-channel
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.fixtures.len(), 1);
        assert_eq!(
            result.fixtures[0],
            FixtureConfig {
                id: "fixture-1".into(),
                fixture: "another-fixture".into(),
                channel: 5,
                universe: None,
                mode: Some("2-channel".into()),
            }
        );
        Ok(())
    }

    #[test]
    fn load_fixtures_with_universe() -> anyhow::Result<()> {
        let content = r#"
        fixtures:
        - id: fixture-1
          fixture: another-fixture
          channel: 5
          universe: 1
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.fixtures.len(), 1);
        assert_eq!(
            result.fixtures[0],
            FixtureConfig {
                id: "fixture-1".into(),
                fixture: "another-fixture".into(),
                channel: 5,
                universe: Some(1),
                mode: None,
            }
        );
        Ok(())
    }
}
