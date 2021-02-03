use crate::nodes::Node;
use crate::nodes::*;
use mizer_fixtures::manager::FixtureManager;
use mizer_node_api::*;
use mizer_project_files::{NodeConfig, Project};
use mizer_devices::DeviceManager;
use crate::{NodeTemplate, NodeType};
use crate::Node::PixelPatternNode;

pub(crate) trait NodeBuilder {
    fn build<'a>(self, context: &mut dyn NodeContext)
                 -> Node<'a>;
}

impl NodeBuilder for mizer_project_files::NodeConfig {
    fn build<'a>(
        self,
        context: &mut dyn NodeContext,
    ) -> Node<'a> {
        match self {
            NodeConfig::Fader => FaderNode::new().into(),
            NodeConfig::ConvertToDmx { universe, channel } => {
                ConvertToDmxNode::new(universe, channel).into()
            }
            NodeConfig::ArtnetOutput { host, port } => ArtnetOutputNode::new(host, port).into(),
            NodeConfig::SacnOutput => StreamingAcnOutputNode::new().into(),
            NodeConfig::Oscillator { oscillator_type } => {
                OscillatorNode::new(oscillator_type, context.connect_default_clock()).into()
            }
            NodeConfig::Clock { speed } => ClockNode::new(speed).into(),
            NodeConfig::OscInput { host, port, path } => OscInputNode::new(host, Some(port), path).into(),
            NodeConfig::VideoFile { file } => VideoFileNode::new(file).into(),
            NodeConfig::VideoOutput => VideoOutputNode::new().into(),
            NodeConfig::VideoEffect { effect_type } => VideoEffectNode::new(effect_type).into(),
            NodeConfig::VideoColorBalance => VideoColorBalanceNode::new().into(),
            NodeConfig::VideoTransform => VideoTransformNode::new().into(),
            NodeConfig::Script(script) => ScriptingNode::new(script.as_str()).into(),
            NodeConfig::PixelPattern { pattern } => PixelPatternGeneratorNode::new(pattern).into(),
            NodeConfig::PixelDmx {
                width,
                height,
                start_universe,
            } => PixelDmxNode::new(width, height, start_universe).into(),
            NodeConfig::OpcOutput {
                host,
                port,
                width,
                height,
            } => OpcOutputNode::new(host, port, (width, height)).into(),
            NodeConfig::Fixture { fixture_id } => {
                FixtureNode::new(context.fixture_manager().get_fixture(&fixture_id).as_deref().cloned().unwrap()).into()
            }
            NodeConfig::Sequence { steps } => {
                SequenceNode::new(steps, context.connect_default_clock()).into()
            }
            NodeConfig::MidiInput { .. } => MidiInputNode::new().into(),
            NodeConfig::MidiOutput { .. } => MidiOutputNode::new().into(),
            NodeConfig::IldaFile { file } => IldaNode::new(&file).unwrap().into(),
            NodeConfig::Laser { device } => LaserNode::new(context.device_manager().clone(), device).into(),
        }
    }
}

impl NodeBuilder for NodeType {
    fn build<'a>(self, context: &mut dyn NodeContext) -> Node<'a> {
        match self {
            NodeType::Fader => FaderNode::create(context).into(),
            NodeType::ConvertToDmx => ConvertToDmxNode::create(context).into(),
            NodeType::ArtnetOutput => ArtnetOutputNode::create(context).into(),
            NodeType::StreamingAcnOutput => StreamingAcnOutputNode::create(context).into(),
            NodeType::Oscillator => OscillatorNode::create(context).into(),
            NodeType::Clock => ClockNode::create(context).into(),
            NodeType::OscInput => OscInputNode::create(context).into(),
            NodeType::VideoFile => VideoFileNode::create(context).into(),
            NodeType::VideoOutput => VideoOutputNode::create(context).into(),
            NodeType::VideoEffect => VideoEffectNode::create(context).into(),
            NodeType::VideoColorBalance => VideoColorBalanceNode::create(context).into(),
            NodeType::VideoTransform => VideoTransformNode::create(context).into(),
            NodeType::Scripting => ScriptingNode::create(context).into(),
            NodeType::PixelPattern => PixelPatternGeneratorNode::create(context).into(),
            NodeType::PixelOutput => PixelDmxNode::create(context).into(),
            NodeType::OpcOutput => OpcOutputNode::create(context).into(),
            NodeType::Fixture => FixtureNode::create(context).into(),
            NodeType::Sequence => SequenceNode::create(context).into(),
            NodeType::MidiInput => MidiInputNode::create(context).into(),
            NodeType::MidiOutput => MidiOutputNode::create(context).into(),
            NodeType::Ilda => IldaNode::create(context).into(),
            NodeType::Laser => LaserNode::create(context).into(),
        }
    }
}
