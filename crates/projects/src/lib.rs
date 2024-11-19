use std::convert::TryFrom;
use std::fs::File;
use std::io::Read;
use std::net::Ipv4Addr;
use std::path::Path;

use indexmap::IndexMap;
use lazy_static::lazy_static;
use regex::{Regex, RegexBuilder};
use serde::{Deserialize, Serialize};

use mizer_fixtures::fixture::FixtureConfiguration;
use mizer_fixtures::programmer::Group;
use mizer_layouts::ControlConfig;
use mizer_node::{NodeCommentArea, NodeDesigner, NodePath, PortId};
use mizer_plan::Plan;
use mizer_protocol_mqtt::MqttAddress;
use mizer_protocol_osc::OscAddress;
use mizer_sequencer::{Effect, Sequence};
use mizer_surfaces::Surface;
use mizer_timecode::{TimecodeControl, TimecodeTrack};

use crate::fixtures::PresetsStore;
use crate::media::Media;
use crate::versioning::{migrate, Migrations};

mod connections;
mod effects;
mod fixtures;
pub mod history;
mod media;
mod sequencer;
mod surfaces;
mod timecode;
mod versioning;

lazy_static! {
    static ref CHANNEL_REGEX: Regex = RegexBuilder::new(
        r"^(?P<fc>[a-z0-9\-\+/ ]*)@(?P<fi>[a-z0-9\-/]*)\s->\s(?P<tc>[a-z0-9\-\+/ ]*)@(?P<ti>[a-z0-9\-/]*)$"
    )
    .case_insensitive(true)
    .build()
    .unwrap();
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Project {
    #[serde(default)]
    pub version: usize,
    #[serde(default)]
    pub playback: PlaybackSettings,
    #[serde(default)]
    pub nodes: Vec<Node>,
    #[serde(default)]
    pub channels: Vec<Channel>,
    #[serde(default)]
    pub comments: Vec<NodeCommentArea>,
    #[serde(default)]
    pub media: Media,
    #[serde(default)]
    pub layouts: IndexMap<String, Vec<ControlConfig>>,
    #[serde(default)]
    pub connections: Vec<ConnectionConfig>,
    #[serde(default)]
    pub fixtures: Vec<FixtureConfig>,
    #[serde(default)]
    pub groups: Vec<Group>,
    #[serde(default)]
    pub presets: PresetsStore,
    #[serde(default)]
    pub sequences: Vec<Sequence>,
    #[serde(default)]
    pub effects: Vec<Effect>,
    #[serde(default)]
    pub plans: Vec<Plan>,
    #[serde(default)]
    pub timecodes: Timecodes,
    #[serde(default)]
    pub surfaces: Vec<Surface>,
}

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq)]
pub struct PlaybackSettings {
    pub fps: f64,
}

impl Default for PlaybackSettings {
    fn default() -> Self {
        Self { fps: 60. }
    }
}

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Timecodes {
    pub timecodes: Vec<TimecodeTrack>,
    pub controls: Vec<TimecodeControl>,
}

impl Project {
    pub fn new() -> Self {
        Self {
            version: Migrations::latest_version(),
            ..Default::default()
        }
    }

    #[profiling::function]
    pub fn load_file<P: AsRef<Path>>(path: P) -> anyhow::Result<Project> {
        let mut file = File::open(path)?;
        let mut project_file = String::new();
        file.read_to_string(&mut project_file)?;
        migrate(&mut project_file)?;
        let project = serde_yaml::from_str(&project_file)?;

        Ok(project)
    }

    pub fn load(content: &str) -> anyhow::Result<Project> {
        let mut content = content.to_string();
        migrate(&mut content)?;
        let project = serde_yaml::from_str(&content)?;

        Ok(project)
    }

    // TODO: do file persistence on background thread
    #[profiling::function]
    pub fn save_file<P: AsRef<Path>>(&self, path: P) -> anyhow::Result<()> {
        let file = File::create(path)?;
        serde_yaml::to_writer(file, &self)?;

        Ok(())
    }
}

pub trait ProjectManagerMut {
    fn new_project(&mut self) {}
    fn load(&mut self, project: &Project) -> anyhow::Result<()>;
    fn save(&self, project: &mut Project);
    fn clear(&mut self);
}

pub trait ProjectManager {
    fn new_project(&self) {}
    fn load(&self, project: &Project) -> anyhow::Result<()>;
    fn save(&self, project: &mut Project);
    fn clear(&self);
}

#[derive(Clone, Serialize, Deserialize, PartialEq, Eq)]
#[serde(try_from = "String", into = "String")]
pub struct Channel {
    pub from_path: NodePath,
    pub from_channel: PortId,
    pub to_path: NodePath,
    pub to_channel: PortId,
}

impl TryFrom<String> for Channel {
    type Error = String;

    fn try_from(value: String) -> Result<Self, Self::Error> {
        if let Some(captures) = CHANNEL_REGEX.captures(&value) {
            let from_path = captures.name("fi").unwrap().as_str().into();
            let from_channel = captures.name("fc").unwrap().as_str().into();
            let to_path = captures.name("ti").unwrap().as_str().into();
            let to_channel = captures.name("tc").unwrap().as_str().into();

            Ok(Channel {
                from_path,
                from_channel,
                to_path,
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
            self.from_channel, self.from_path, self.to_channel, self.to_path
        )
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Node {
    pub path: NodePath,
    #[serde(flatten)]
    pub config: mizer_nodes::Node,
    #[serde(default)]
    pub designer: NodeDesigner,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct FixtureConfig {
    pub id: u32,
    pub name: String,
    pub fixture: String,
    pub channel: u16,
    pub universe: Option<u16>,
    #[serde(default)]
    pub mode: Option<String>,
    #[serde(default)]
    pub configuration: FixtureConfiguration,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct ConnectionConfig {
    pub id: String,
    pub name: String,
    #[serde(flatten)]
    pub config: ConnectionTypes,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
#[serde(tag = "type", rename_all = "kebab-case")]
pub enum ConnectionTypes {
    Sacn {
        priority: Option<u8>,
    },
    #[serde(alias = "artnet")]
    ArtnetOutput {
        host: String,
        port: Option<u16>,
    },
    ArtnetInput {
        host: Ipv4Addr,
        port: Option<u16>,
    },
    Mqtt(MqttAddress),
    Osc(OscAddress),
}

#[cfg(test)]
mod tests {
    use std::collections::HashMap;

    use mizer_node::NodePosition;

    use super::*;

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
          path: /opc-output-0
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
                path: "/opc-output-0".into(),
                config: mizer_nodes::Node::OpcOutput(mizer_nodes::OpcOutputNode {
                    host: "0.0.0.0".into(),
                    port: 7890,
                    width: 10,
                    height: 20
                }),
                designer: NodeDesigner {
                    hidden: false,
                    position: NodePosition { x: 1., y: 2. },
                    scale: 3.,
                    color: Default::default(),
                },
            }
        );
        Ok(())
    }

    #[test]
    fn load_channel() -> anyhow::Result<()> {
        let content = r#"
        nodes:
          - type: pixel-pattern
            path: /pixel-pattern-0
            config:
              pattern: rgb-iterate
          - type: opc-output
            path: /opc-output-0
            config:
              host: 127.0.0.1
              width: 25
              height: 50
        channels:
          - Output@/pixel-pattern-0 -> Pixels@/opc-output-0
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.nodes.len(), 2);
        assert_eq!(result.channels.len(), 1);
        assert_eq!(
            result.nodes[0],
            Node {
                path: "/pixel-pattern-0".into(),
                config: mizer_nodes::Node::PixelPattern(mizer_nodes::PixelPatternGeneratorNode {
                    pattern: mizer_pixel_nodes::Pattern::RgbIterate
                }),
                designer: Default::default(),
            }
        );
        assert_eq!(
            result.nodes[1],
            Node {
                path: "/opc-output-0".into(),
                config: mizer_nodes::Node::OpcOutput(mizer_nodes::OpcOutputNode {
                    host: "127.0.0.1".into(),
                    port: 7890,
                    width: 25,
                    height: 50
                }),
                designer: Default::default(),
            }
        );
        assert_eq!(
            result.channels[0],
            Channel {
                from_path: "/pixel-pattern-0".into(),
                from_channel: "Output".into(),
                to_path: "/opc-output-0".into(),
                to_channel: "Pixels".into()
            }
        );
        Ok(())
    }

    #[test]
    fn load_channel_should_support_uppercase() -> anyhow::Result<()> {
        let content = r#"
        nodes: []
        channels:
          - Output@/pixel-pattern-0 -> Pixels@/opc-output-0
        "#;

        let result = Project::load(content)?;

        assert_eq!(
            result.channels[0],
            Channel {
                from_path: "/pixel-pattern-0".into(),
                from_channel: "Output".into(),
                to_path: "/opc-output-0".into(),
                to_channel: "Pixels".into()
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
          path: /fader-0
          config: {}
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.nodes.len(), 1);
        assert_eq!(
            result.nodes[0],
            Node {
                path: "/fader-0".into(),
                config: mizer_nodes::Node::Fader(mizer_nodes::FaderNode::default()),
                designer: Default::default(),
            }
        );
        Ok(())
    }

    #[test]
    fn load_fixtures() -> anyhow::Result<()> {
        let content = r#"
        fixtures:
        - id: 1
          name: My Fixture
          fixture: fixture-definition-ref
          output: output
          channel: 1
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.fixtures.len(), 1);
        assert_eq!(
            result.fixtures[0],
            FixtureConfig {
                id: 1,
                name: "My Fixture".into(),
                fixture: "fixture-definition-ref".into(),
                channel: 1,
                universe: None,
                mode: None,
                configuration: Default::default(),
            }
        );
        Ok(())
    }

    #[test]
    fn load_fixtures_with_mode() -> anyhow::Result<()> {
        let content = r#"
        fixtures:
        - id: 1
          name: My Fixture
          fixture: another-fixture
          channel: 5
          mode: 2-channel
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.fixtures.len(), 1);
        assert_eq!(
            result.fixtures[0],
            FixtureConfig {
                id: 1,
                name: "My Fixture".into(),
                fixture: "another-fixture".into(),
                channel: 5,
                universe: None,
                mode: Some("2-channel".into()),
                configuration: Default::default(),
            }
        );
        Ok(())
    }

    #[test]
    fn load_fixtures_with_universe() -> anyhow::Result<()> {
        let content = r#"
        fixtures:
        - id: 1
          name: My Fixture
          fixture: another-fixture
          channel: 5
          universe: 1
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.fixtures.len(), 1);
        assert_eq!(
            result.fixtures[0],
            FixtureConfig {
                id: 1,
                name: "My Fixture".into(),
                fixture: "another-fixture".into(),
                channel: 5,
                universe: Some(1),
                mode: None,
                configuration: Default::default(),
            }
        );
        Ok(())
    }
}
