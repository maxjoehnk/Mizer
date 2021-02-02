use crate::nodes::Node;
use crate::nodes::*;
use anyhow::{anyhow, Context};
use mizer_fixtures::manager::FixtureManager;
use mizer_node_api::*;
use mizer_project_files::{NodeConfig, Project};
use mizer_devices::DeviceManager;

pub(crate) trait NodeBuilder {
    fn build<'a>(self, fixture_manager: &FixtureManager, device_manager: &DeviceManager, default_clock: &mut ClockNode)
                 -> Node<'a>;
}

impl NodeBuilder for mizer_project_files::NodeConfig {
    fn build<'a>(
        self,
        fixture_manager: &FixtureManager,
        device_manager: &DeviceManager,
        default_clock: &mut ClockNode,
    ) -> Node<'a> {
        match self {
            NodeConfig::Fader => FaderNode::new().into(),
            NodeConfig::ConvertToDmx { universe, channel } => {
                ConvertToDmxNode::new(universe, channel).into()
            }
            NodeConfig::ArtnetOutput { host, port } => ArtnetOutputNode::new(host, port).into(),
            NodeConfig::SacnOutput => StreamingAcnOutputNode::new().into(),
            NodeConfig::Oscillator { oscillator_type } => {
                OscillatorNode::new(oscillator_type, default_clock.get_clock_channel()).into()
            }
            NodeConfig::Clock { speed } => ClockNode::new(speed).into(),
            NodeConfig::OscInput { host, port, path } => OscInputNode::new(host, port, path).into(),
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
                FixtureNode::new(fixture_manager.get_fixture(&fixture_id).cloned().unwrap()).into()
            }
            NodeConfig::Sequence { steps } => {
                SequenceNode::new(steps, default_clock.get_clock_channel()).into()
            }
            NodeConfig::MidiInput { .. } => MidiInputNode::new().into(),
            NodeConfig::MidiOutput { .. } => MidiOutputNode::new().into(),
            NodeConfig::IldaFile { file } => IldaNode::new(&file).unwrap().into(),
            NodeConfig::Laser { device } => LaserNode::new(device_manager.clone(), device).into(),
        }
    }
}
