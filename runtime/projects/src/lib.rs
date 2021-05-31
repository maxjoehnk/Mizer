use lazy_static::lazy_static;
use mizer_node::{NodeDesigner, NodePath, PortId};
use regex::{Regex, RegexBuilder};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::convert::TryFrom;
use std::fs::File;
use std::path::Path;
use mizer_layouts::ControlConfig;

lazy_static! {
    static ref CHANNEL_REGEX: Regex = RegexBuilder::new(
        r"^(?P<fc>[a-z\-]*)@(?P<fi>[a-z0-9\-/]*)\s->\s(?P<tc>[a-z\-]*)@(?P<ti>[a-z0-9\-/]*)$"
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
    #[serde(default, rename = "media")]
    pub media_paths: Vec<String>,
    #[serde(default)]
    pub layouts: HashMap<String, Vec<ControlConfig>>,
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
    pub properties: HashMap<String, f64>,
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
    Fixture(mizer_nodes::FixtureNode),
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
    IldaFile(mizer_nodes::IldaFileNode),
    Laser(mizer_nodes::LaserNode),
}

impl From<NodeConfig> for mizer_nodes::Node {
    fn from(node: NodeConfig) -> Self {
        match node {
            NodeConfig::Clock(node) => mizer_nodes::Node::Clock(node),
            NodeConfig::Oscillator(node) => mizer_nodes::Node::Oscillator(node),
            NodeConfig::DmxOutput(node) => mizer_nodes::Node::DmxOutput(node),
            NodeConfig::Script(node) => mizer_nodes::Node::Scripting(node),
            NodeConfig::Sequence(node) => mizer_nodes::Node::Sequence(node),
            NodeConfig::Fixture(node) => mizer_nodes::Node::Fixture(node),
            NodeConfig::IldaFile(node) => mizer_nodes::Node::IldaFile(node),
            NodeConfig::Laser(node) => mizer_nodes::Node::Laser(node),
            NodeConfig::Fader(node) => mizer_nodes::Node::Fader(node),
            NodeConfig::Button(node) => mizer_nodes::Node::Button(node),
            NodeConfig::MidiInput(node) => mizer_nodes::Node::MidiInput(node),
            NodeConfig::MidiOutput(node) => mizer_nodes::Node::MidiOutput(node),
            NodeConfig::OpcOutput(node) => mizer_nodes::Node::OpcOutput(node),
            NodeConfig::PixelPattern(node) => mizer_nodes::Node::PixelPattern(node),
            NodeConfig::PixelDmx(node) => mizer_nodes::Node::PixelDmx(node),
            NodeConfig::OscInput(node) => mizer_nodes::Node::OscInput(node),
            NodeConfig::OscOutput(node) => mizer_nodes::Node::OscOutput(node),
            NodeConfig::VideoFile(node) => mizer_nodes::Node::VideoFile(node),
            NodeConfig::VideoColorBalance(node) => mizer_nodes::Node::VideoColorBalance(node),
            NodeConfig::VideoOutput(node) => mizer_nodes::Node::VideoOutput(node),
            NodeConfig::VideoEffect(node) => mizer_nodes::Node::VideoEffect(node),
            NodeConfig::VideoTransform(node) => mizer_nodes::Node::VideoTransform(node),
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct FixtureConfig {
    pub id: u32,
    pub fixture: String,
    pub channel: u8,
    pub universe: Option<u16>,
    #[serde(default)]
    pub mode: Option<String>,
    pub output: String,
}

#[cfg(test)]
mod tests {
    use super::*;
    use mizer_node::NodePosition;
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
                    position: NodePosition { x: 1., y: 2. },
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
                properties: HashMap::new(),
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
                properties: Default::default(),
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
                properties: Default::default(),
            }
        );
        Ok(())
    }

    #[test]
    fn load_fixtures() -> anyhow::Result<()> {
        let content = r#"
        fixtures:
        - id: 1
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
                fixture: "fixture-definition-ref".into(),
                channel: 1,
                output: "output".into(),
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
          fixture: another-fixture
          channel: 5
          mode: 2-channel
          output: output
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.fixtures.len(), 1);
        assert_eq!(
            result.fixtures[0],
            FixtureConfig {
                id: 1,
                fixture: "another-fixture".into(),
                channel: 5,
                output: "output".into(),
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
          fixture: another-fixture
          output: output
          channel: 5
          universe: 1
        "#;

        let result = Project::load(content)?;

        assert_eq!(result.fixtures.len(), 1);
        assert_eq!(
            result.fixtures[0],
            FixtureConfig {
                id: 1,
                fixture: "another-fixture".into(),
                channel: 5,
                output: "output".into(),
                universe: Some(1),
                mode: None,
            }
        );
        Ok(())
    }
}
