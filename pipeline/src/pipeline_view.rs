use std::sync::Arc;
use dashmap::DashMap;
use crate::Node;
use std::collections::HashMap;
use mizer_project_files::{Channel, NodeDesignerConfig};

#[derive(Clone, Debug)]
pub struct PipelineView {
    // nodes: Arc<DashMap<String, Node<'a>>>,
    node_definitions: HashMap<String, NodeDefinition>,
    channels: Vec<Channel>, // TODO: these need to be shared
}

impl PipelineView {
    pub(crate) fn new(nodes: &Arc<DashMap<String, Node>>, designer: &Arc<DashMap<String, NodeDesigner>>, channels: Vec<Channel>) -> Self {
        PipelineView {
            // nodes: Arc::clone(nodes),
            node_definitions: definitions_from_nodes(Arc::clone(nodes), designer),
            channels,
        }
    }

    pub fn get_nodes(&self) -> Vec<(String, NodeDefinition)> {
        self.node_definitions
            .iter()
            .map(|(key, node)| (key.clone(), node.clone()))
            .collect()
    }

    pub fn get_channels(&self) -> &[Channel] {
        &self.channels[..]
    }
}

fn definitions_from_nodes(nodes: Arc<DashMap<String, Node>>, designer: &Arc<DashMap<String, NodeDesigner>>) -> HashMap<String, NodeDefinition> {
    let mut definitions = HashMap::new();
    for item in nodes.iter() {
        let id = item.key();
        let node = item.value();
        definitions.insert(id.clone(), NodeDefinition {
            node_type: node.into(),
            designer: designer.get(id).unwrap().clone(),
        });
    }

    definitions
}

#[derive(Clone, Debug)]
pub struct NodeDefinition {
    pub designer: NodeDesigner,
    pub node_type: NodeType,
}

#[derive(Clone, Debug, Default)]
pub struct NodeDesigner {
    pub x: f64,
    pub y: f64,
    pub scale: f64,
}

impl From<NodeDesignerConfig> for NodeDesigner {
    fn from(config: NodeDesignerConfig) -> Self {
        NodeDesigner {
            x: config.position.x,
            y: config.position.y,
            scale: config.scale,
        }
    }
}

#[derive(Clone, Debug)]
pub enum NodeType {
    Fader,
    ConvertToDmx,
    ArtnetOutput,
    StreamingAcnOutput,
    Oscillator,
    Clock,
    OscInput,
    VideoFile,
    VideoOutput,
    VideoEffect,
    VideoColorBalance,
    VideoTransform,
    Scripting,
    PixelOutput,
    PixelPattern,
    OpcOutput,
    Fixture,
    Sequence,
    MidiInput,
    MidiOutput,
    Laser,
    Ilda
}

impl<'a> From<&Node<'a>> for NodeType {
    fn from(node: &Node<'a>) -> Self {
        match node {
            Node::Fader(_) => NodeType::Fader,
            Node::ConvertToDmxNode(_) => NodeType::ConvertToDmx,
            Node::ArtnetOutputNode(_) => NodeType::ArtnetOutput,
            Node::StreamingAcnOutputNode(_) => NodeType::StreamingAcnOutput,
            Node::OscillatorNode(_) => NodeType::Oscillator,
            Node::ClockNode(_) => NodeType::Clock,
            Node::OscInputNode(_) => NodeType::OscInput,
            Node::VideoFileNode(_) => NodeType::VideoFile,
            Node::VideoOutputNode(_) => NodeType::VideoOutput,
            Node::VideoEffectNode(_) => NodeType::VideoEffect,
            Node::VideoColorBalanceNode(_) => NodeType::VideoColorBalance,
            Node::VideoTransformNode(_) => NodeType::VideoTransform,
            Node::ScriptingNode(_) => NodeType::Scripting,
            Node::PixelOutputNode(_) => NodeType::PixelOutput,
            Node::PixelPatternNode(_) => NodeType::PixelPattern,
            Node::OpcOutputNode(_) => NodeType::OpcOutput,
            Node::FixtureNode(_) => NodeType::Fixture,
            Node::SequenceNode(_) => NodeType::Sequence,
            Node::MidiInputNode(_) => NodeType::MidiInput,
            Node::MidiOutputNode(_) => NodeType::MidiOutput,
            Node::LaserNode(_) => NodeType::Laser,
            Node::IldaNode(_) => NodeType::Ilda,
        }
    }
}

