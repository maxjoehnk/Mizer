use std::sync::Arc;
use dashmap::DashMap;
use crate::{Node, PipelineCommand};
use mizer_project_files::{Channel, NodeDesignerConfig};
pub use mizer_node_api::NodeChannel;
use mizer_node_api::{ProcessingNode, NodeInput, NodeOutput};
use crate::node_builder::NodeBuilder;

#[derive(Clone, Debug)]
pub struct NodeTemplate {
    pub designer: NodeDesigner,
    pub node_type: NodeType,
}

#[derive(Clone, Debug)]
pub struct PipelineView {
    worker_channel: flume::Sender<PipelineCommand>,
    node_definitions: DashMap<String, NodeDefinition>,
    channels: Vec<Channel>, // TODO: these need to be shared
}

impl PipelineView {
    pub(crate) fn new(nodes: &Arc<DashMap<String, Node>>, designer: &Arc<DashMap<String, NodeDesigner>>, channels: Vec<Channel>, worker_channel: flume::Sender<PipelineCommand>) -> Self {
        PipelineView {
            worker_channel,
            node_definitions: definitions_from_nodes(Arc::clone(nodes), designer),
            channels,
        }
    }

    pub fn get_nodes(&self) -> Vec<(String, NodeDefinition)> {
        self.node_definitions
            .iter()
            .map(|definition| (definition.key().clone(), definition.value().clone()))
            .collect()
    }

    pub fn get_channels(&self) -> &[Channel] {
        &self.channels[..]
    }

    pub fn add_node<T: Into<NodeTemplate>>(&self, node: T) -> anyhow::Result<(String, NodeDefinition)> {
        let node = node.into();
        let (sender, resp) = flume::bounded(1);

        let cmd = PipelineCommand::AddNode(node, sender.clone());
        self.worker_channel.send(cmd)?;
        let (id, definition) = resp.recv()?;

        log::debug!("received {:?}", &definition);

        self.node_definitions.insert(id.clone(), definition.clone());

        Ok((id, definition))
    }
}

fn definitions_from_nodes(nodes: Arc<DashMap<String, Node>>, designer: &Arc<DashMap<String, NodeDesigner>>) -> DashMap<String, NodeDefinition> {
    let definitions = DashMap::new();
    for item in nodes.iter() {
        let id = item.key();
        let node = item.value();
        let details = node.get_details();
        definitions.insert(id.clone(), NodeDefinition {
            node_type: node.into(),
            designer: designer.get(id).unwrap().clone(),
            inputs: details.inputs.into_iter().map(NodePortDefinition::from).collect(),
            outputs: details.outputs.into_iter().map(NodePortDefinition::from).collect(),
        });
    }

    definitions
}

#[derive(Clone, Debug)]
pub struct NodeDefinition {
    pub designer: NodeDesigner,
    pub node_type: NodeType,
    pub inputs: Vec<NodePortDefinition>,
    pub outputs: Vec<NodePortDefinition>,
}

#[derive(Clone, Debug)]
pub struct NodePortDefinition {
    pub name: String,
    pub channel: NodeChannel,
}

impl From<NodeInput> for NodePortDefinition {
    fn from(input: NodeInput) -> Self {
        NodePortDefinition {
            name: input.name,
            channel: input.channel_type
        }
    }
}

impl From<NodeOutput> for NodePortDefinition {
    fn from(output: NodeOutput) -> Self {
        NodePortDefinition {
            name: output.name,
            channel: output.channel_type,
        }
    }
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

#[derive(Clone, Debug, Copy)]
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

