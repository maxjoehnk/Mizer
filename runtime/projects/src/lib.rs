use std::collections::HashMap;
use std::convert::TryFrom;
use std::fs::File;
use std::path::Path;

use lazy_static::lazy_static;
use regex::{Regex, RegexBuilder};
use serde::{Deserialize, Serialize};
use mizer_fixtures::programmer::Group;

use mizer_layouts::ControlConfig;
use mizer_node::{NodeDesigner, NodePath, PortId};
use mizer_sequencer::Sequence;
use crate::fixtures::PresetsStore;

mod connections;
mod fixtures;
mod sequencer;

lazy_static! {
    static ref CHANNEL_REGEX: Regex = RegexBuilder::new(
        r"^(?P<fc>[a-z0-9\-\+ ]*)@(?P<fi>[a-z0-9\-/]*)\s->\s(?P<tc>[a-z0-9\-\+ ]*)@(?P<ti>[a-z0-9\-/]*)$"
    )
    .case_insensitive(true)
    .build()
    .unwrap();
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Project {
    #[serde(default)]
    pub nodes: Vec<Node>,
    #[serde(default)]
    pub channels: Vec<Channel>,
    #[serde(default, rename = "media")]
    pub media_paths: Vec<String>,
    #[serde(default)]
    pub layouts: HashMap<String, Vec<ControlConfig>>,
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
}

impl Project {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn load_file<P: AsRef<Path>>(path: P) -> anyhow::Result<Project> {
        let file = File::open(path)?;
        let project: Project = serde_yaml::from_reader(file)?;

        Ok(project)
    }

    pub fn load(content: &str) -> anyhow::Result<Project> {
        let project = serde_yaml::from_str(content)?;

        Ok(project)
    }

    // TODO: do file persistance on background thread
    pub fn save_file<P: AsRef<Path>>(&self, path: P) -> anyhow::Result<()> {
        let file = File::create(path)?;
        serde_yaml::to_writer(file, &self)?;

        Ok(())
    }
}

pub trait ProjectManagerMut {
    fn new(&mut self) {}
    fn load(&mut self, project: &Project) -> anyhow::Result<()>;
    fn save(&self, project: &mut Project);
    fn clear(&mut self);
}

pub trait ProjectManager {
    fn new(&self) {}
    fn load(&self, project: &Project) -> anyhow::Result<()>;
    fn save(&self, project: &mut Project);
    fn clear(&self);
}

#[derive(Clone, Serialize, Deserialize, PartialEq)]
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
    pub config: NodeConfig,
    #[serde(default)]
    pub designer: NodeDesigner,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
#[serde(tag = "type", content = "config", rename_all = "kebab-case")]
pub enum NodeConfig {
    DmxOutput(mizer_nodes::DmxOutputNode),
    PixelPattern(mizer_nodes::PixelPatternGeneratorNode),
    PixelDmx(mizer_nodes::PixelDmxNode),
    OpcOutput(mizer_nodes::OpcOutputNode),
    Oscillator(mizer_nodes::OscillatorNode),
    Clock(mizer_nodes::ClockNode),
    Script(mizer_nodes::ScriptingNode),
    Select(mizer_nodes::SelectNode),
    Merge(mizer_nodes::MergeNode),
    Fixture(mizer_nodes::FixtureNode),
    Programmer(mizer_nodes::ProgrammerNode),
    Sequencer(mizer_nodes::SequencerNode),
    OscInput(mizer_nodes::OscInputNode),
    OscOutput(mizer_nodes::OscOutputNode),
    MidiInput(mizer_nodes::MidiInputNode),
    MidiOutput(mizer_nodes::MidiOutputNode),
    Fader(mizer_nodes::FaderNode),
    Button(mizer_nodes::ButtonNode),
    VideoFile(mizer_nodes::VideoFileNode),
    VideoEffect(mizer_nodes::VideoEffectNode),
    VideoTransform(mizer_nodes::VideoTransformNode),
    VideoColorBalance(mizer_nodes::VideoColorBalanceNode),
    VideoOutput(mizer_nodes::VideoOutputNode),
    Sequence(mizer_nodes::SequenceNode),
    Envelope(mizer_nodes::EnvelopeNode),
    IldaFile(mizer_nodes::IldaFileNode),
    Laser(mizer_nodes::LaserNode),
    ColorHsv(mizer_nodes::HsvColorNode),
    ColorRgb(mizer_nodes::RgbColorNode),
}

impl From<NodeConfig> for mizer_nodes::Node {
    fn from(node: NodeConfig) -> Self {
        match node {
            NodeConfig::Clock(node) => Self::Clock(node),
            NodeConfig::Oscillator(node) => Self::Oscillator(node),
            NodeConfig::DmxOutput(node) => Self::DmxOutput(node),
            NodeConfig::Script(node) => Self::Scripting(node),
            NodeConfig::Sequence(node) => Self::Sequence(node),
            NodeConfig::Envelope(node) => Self::Envelope(node),
            NodeConfig::Fixture(node) => Self::Fixture(node),
            NodeConfig::Programmer(node) => Self::Programmer(node),
            NodeConfig::Sequencer(node) => Self::Sequencer(node),
            NodeConfig::Select(node) => Self::Select(node),
            NodeConfig::Merge(node) => Self::Merge(node),
            NodeConfig::IldaFile(node) => Self::IldaFile(node),
            NodeConfig::Laser(node) => Self::Laser(node),
            NodeConfig::Fader(node) => Self::Fader(node),
            NodeConfig::Button(node) => Self::Button(node),
            NodeConfig::MidiInput(node) => Self::MidiInput(node),
            NodeConfig::MidiOutput(node) => Self::MidiOutput(node),
            NodeConfig::OpcOutput(node) => Self::OpcOutput(node),
            NodeConfig::PixelPattern(node) => Self::PixelPattern(node),
            NodeConfig::PixelDmx(node) => Self::PixelDmx(node),
            NodeConfig::OscInput(node) => Self::OscInput(node),
            NodeConfig::OscOutput(node) => Self::OscOutput(node),
            NodeConfig::VideoFile(node) => Self::VideoFile(node),
            NodeConfig::VideoColorBalance(node) => Self::VideoColorBalance(node),
            NodeConfig::VideoOutput(node) => Self::VideoOutput(node),
            NodeConfig::VideoEffect(node) => Self::VideoEffect(node),
            NodeConfig::VideoTransform(node) => Self::VideoTransform(node),
            NodeConfig::ColorHsv(node) => Self::ColorHsv(node),
            NodeConfig::ColorRgb(node) => Self::ColorRgb(node),
        }
    }
}

impl From<mizer_nodes::Node> for NodeConfig {
    fn from(node: mizer_nodes::Node) -> Self {
        match node {
            mizer_nodes::Node::Clock(node) => Self::Clock(node),
            mizer_nodes::Node::Oscillator(node) => Self::Oscillator(node),
            mizer_nodes::Node::DmxOutput(node) => Self::DmxOutput(node),
            mizer_nodes::Node::Scripting(node) => Self::Script(node),
            mizer_nodes::Node::Sequence(node) => Self::Sequence(node),
            mizer_nodes::Node::Envelope(node) => Self::Envelope(node),
            mizer_nodes::Node::Fixture(node) => Self::Fixture(node),
            mizer_nodes::Node::Programmer(node) => Self::Programmer(node),
            mizer_nodes::Node::Sequencer(node) => Self::Sequencer(node),
            mizer_nodes::Node::Select(node) => Self::Select(node),
            mizer_nodes::Node::Merge(node) => Self::Merge(node),
            mizer_nodes::Node::IldaFile(node) => Self::IldaFile(node),
            mizer_nodes::Node::Laser(node) => Self::Laser(node),
            mizer_nodes::Node::Fader(node) => Self::Fader(node),
            mizer_nodes::Node::Button(node) => Self::Button(node),
            mizer_nodes::Node::MidiInput(node) => Self::MidiInput(node),
            mizer_nodes::Node::MidiOutput(node) => Self::MidiOutput(node),
            mizer_nodes::Node::OpcOutput(node) => Self::OpcOutput(node),
            mizer_nodes::Node::PixelPattern(node) => Self::PixelPattern(node),
            mizer_nodes::Node::PixelDmx(node) => Self::PixelDmx(node),
            mizer_nodes::Node::OscInput(node) => Self::OscInput(node),
            mizer_nodes::Node::OscOutput(node) => Self::OscOutput(node),
            mizer_nodes::Node::VideoFile(node) => Self::VideoFile(node),
            mizer_nodes::Node::VideoColorBalance(node) => Self::VideoColorBalance(node),
            mizer_nodes::Node::VideoOutput(node) => Self::VideoOutput(node),
            mizer_nodes::Node::VideoEffect(node) => Self::VideoEffect(node),
            mizer_nodes::Node::VideoTransform(node) => Self::VideoTransform(node),
            mizer_nodes::Node::ColorHsv(node) => Self::ColorHsv(node),
            mizer_nodes::Node::ColorRgb(node) => Self::ColorRgb(node),
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct FixtureConfig {
    pub id: u32,
    pub name: String,
    pub fixture: String,
    pub channel: u8,
    pub universe: Option<u16>,
    #[serde(default)]
    pub mode: Option<String>,
    pub output: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct ConnectionConfig {
    pub id: String,
    pub name: String,
    #[serde(flatten)]
    pub config: ConnectionTypes,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
#[serde(tag = "type", rename_all = "kebab-case")]
pub enum ConnectionTypes {
    Sacn,
    Artnet { host: String, port: Option<u16> },
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
                config: NodeConfig::OpcOutput(mizer_nodes::OpcOutputNode {
                    host: "0.0.0.0".into(),
                    port: 7890,
                    width: 10,
                    height: 20
                }),
                designer: NodeDesigner {
                    hidden: false,
                    position: NodePosition { x: 1., y: 2. },
                    scale: 3.,
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
          - output@/pixel-pattern-0 -> pixels@/opc-output-0
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.nodes.len(), 2);
        assert_eq!(result.channels.len(), 1);
        assert_eq!(
            result.nodes[0],
            Node {
                path: "/pixel-pattern-0".into(),
                config: NodeConfig::PixelPattern(mizer_nodes::PixelPatternGeneratorNode {
                    pattern: mizer_pixel_nodes::Pattern::RgbIterate
                }),
                designer: Default::default(),
            }
        );
        assert_eq!(
            result.nodes[1],
            Node {
                path: "/opc-output-0".into(),
                config: NodeConfig::OpcOutput(mizer_nodes::OpcOutputNode {
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
                from_channel: "output".into(),
                to_path: "/opc-output-0".into(),
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
          - Output@/pixel-pattern-0 -> pixels@/opc-output-0
        "#;

        let result = Project::load(content)?;

        assert_eq!(
            result.channels[0],
            Channel {
                from_path: "/pixel-pattern-0".into(),
                from_channel: "Output".into(),
                to_path: "/opc-output-0".into(),
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
          path: /fader-0
          config: {}
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.nodes.len(), 1);
        assert_eq!(
            result.nodes[0],
            Node {
                path: "/fader-0".into(),
                config: NodeConfig::Fader(mizer_nodes::FaderNode {}),
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
                output: Some("output".into()),
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
                output: None,
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
                output: None,
                universe: Some(1),
                mode: None,
            }
        );
        Ok(())
    }
}
