use crate::pipeline_access::PipelineAccess;
use crate::NodeDowncast;
use mizer_commander::{Command, RefMut};
use mizer_node::{NodePath, NodeType, PipelineNode};
use mizer_nodes::*;
use mizer_pipeline::ProcessingNodeExt;
use serde::{Deserialize, Serialize};
use std::hash::{Hash, Hasher};
use std::ops::DerefMut;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UpdateNodeCommand {
    pub path: NodePath,
    pub config: Node,
}

impl Hash for UpdateNodeCommand {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.path.hash(state)
    }
}

impl<'a> Command<'a> for UpdateNodeCommand {
    type Dependencies = RefMut<PipelineAccess>;
    type State = Node;
    type Result = ();

    fn label(&self) -> String {
        format!("Update Node '{}'", self.path)
    }

    fn apply(
        &self,
        pipeline_access: &mut PipelineAccess,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        log::debug!("Updating {:?} with {:?}", self.path, self.config);

        let node = pipeline_access
            .nodes
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown Node {}", self.path))?;
        let previous_config: Node = NodeDowncast::downcast(node);
        let node: &mut dyn ProcessingNodeExt = node.deref_mut();
        update_pipeline_node(node.as_pipeline_node_mut(), &self.config)?;

        let mut node = pipeline_access
            .nodes_view
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown Node {}", self.path))?;
        let node = node.value_mut();
        update_pipeline_node(node.deref_mut(), &self.config)?;

        Ok(((), previous_config))
    }

    fn revert(
        &self,
        pipeline_access: &mut PipelineAccess,
        state: Self::State,
    ) -> anyhow::Result<()> {
        let node = pipeline_access
            .nodes
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown Node {}", self.path))?;
        let node: &mut dyn ProcessingNodeExt = node.deref_mut();
        update_pipeline_node(node.as_pipeline_node_mut(), &state)?;

        let mut node = pipeline_access
            .nodes_view
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown Node {}", self.path))?;
        let node = node.value_mut();
        update_pipeline_node(node.deref_mut(), &state)?;

        Ok(())
    }
}

fn update_pipeline_node(node: &mut dyn PipelineNode, config: &Node) -> anyhow::Result<()> {
    let node_type = node.node_type();
    match (node_type, config) {
        (NodeType::DmxOutput, Node::DmxOutput(config)) => {
            let node: &mut DmxOutputNode = node.downcast_mut()?;
            node.channel = config.channel;
            node.universe = config.universe;
        }
        (NodeType::Oscillator, Node::Oscillator(config)) => {
            let node: &mut OscillatorNode = node.downcast_mut()?;
            node.oscillator_type = config.oscillator_type;
            node.min = config.min;
            node.max = config.max;
            node.offset = config.offset;
            node.ratio = config.ratio;
            node.reverse = config.reverse;
        }
        (NodeType::Clock, Node::Clock(config)) => {
            let node: &mut ClockNode = node.downcast_mut()?;
            node.speed = config.speed;
        }
        (NodeType::Fixture, Node::Fixture(config)) => {
            let node: &mut FixtureNode = node.downcast_mut()?;
            node.fixture_id = config.fixture_id;
        }
        (NodeType::Programmer, Node::Programmer(_)) => {}
        (NodeType::Group, Node::Group(_)) => {}
        (NodeType::Preset, Node::Preset(_)) => {}
        (NodeType::OscOutput, Node::OscOutput(config)) => {
            let node: &mut OscOutputNode = node.downcast_mut()?;
            node.path = config.path.clone();
            node.host = config.host.clone();
            node.port = config.port;
            node.argument_type = config.argument_type;
        }
        (NodeType::OscInput, Node::OscInput(config)) => {
            let node: &mut OscInputNode = node.downcast_mut()?;
            node.path = config.path.clone();
            node.host = config.host.clone();
            node.port = config.port;
            node.argument_type = config.argument_type;
        }
        (NodeType::Button, Node::Button(config)) => {
            let node: &mut ButtonNode = node.downcast_mut()?;
            node.toggle = config.toggle;
        }
        (NodeType::Fader, Node::Fader(_)) => {}
        (NodeType::IldaFile, Node::IldaFile(config)) => {
            let node: &mut IldaFileNode = node.downcast_mut()?;
            node.file = config.file.clone();
        }
        (NodeType::Laser, Node::Laser(config)) => {
            let node: &mut LaserNode = node.downcast_mut()?;
            node.device_id = config.device_id.clone();
        }
        (NodeType::MidiInput, Node::MidiInput(config)) => {
            let node: &mut MidiInputNode = node.downcast_mut()?;
            node.device = config.device.clone();
            node.config = config.config.clone();
        }
        (NodeType::MidiOutput, Node::MidiOutput(config)) => {
            let node: &mut MidiOutputNode = node.downcast_mut()?;
            node.device = config.device.clone();
            node.config = config.config.clone();
        }
        (NodeType::OpcOutput, Node::OpcOutput(config)) => {
            let node: &mut OpcOutputNode = node.downcast_mut()?;
            node.host = config.host.clone();
            node.port = config.port;
            node.width = config.width;
            node.height = config.height;
        }
        (NodeType::PixelDmx, Node::PixelDmx(config)) => {
            let node: &mut PixelDmxNode = node.downcast_mut()?;
            node.height = config.height;
            node.width = config.width;
            node.output = config.output.clone();
            node.start_universe = config.start_universe;
        }
        (NodeType::PixelPattern, Node::PixelPattern(config)) => {
            let node: &mut PixelPatternGeneratorNode = node.downcast_mut()?;
            node.pattern = config.pattern;
        }
        (NodeType::Scripting, Node::Scripting(config)) => {
            let node: &mut ScriptingNode = node.downcast_mut()?;
            node.script = config.script.clone();
        }
        (NodeType::VideoColorBalance, Node::VideoColorBalance(_)) => {}
        (NodeType::VideoEffect, Node::VideoEffect(config)) => {
            let node: &mut VideoEffectNode = node.downcast_mut()?;
            node.effect_type = config.effect_type;
        }
        (NodeType::VideoFile, Node::VideoFile(config)) => {
            let node: &mut VideoFileNode = node.downcast_mut()?;
            node.file = config.file.clone();
        }
        (NodeType::VideoOutput, Node::VideoOutput(_)) => {}
        (NodeType::VideoTransform, Node::VideoTransform(_)) => {}
        (NodeType::Gamepad, Node::Gamepad(config)) => {
            let node: &mut GamepadNode = node.downcast_mut()?;
            node.device_id = config.device_id.clone();
            node.control = config.control.clone();
        }
        (NodeType::Threshold, Node::Threshold(config)) => {
            let node: &mut ThresholdNode = node.downcast_mut()?;
            node.lower_threshold = config.lower_threshold;
            node.upper_threshold = config.upper_threshold;
            node.active_value = config.active_value;
            node.inactive_value = config.inactive_value;
        }
        (NodeType::Envelope, Node::Envelope(config)) => {
            let node: &mut EnvelopeNode = node.downcast_mut()?;
            node.attack = config.attack;
            node.decay = config.decay;
            node.sustain = config.sustain;
            node.release = config.release;
        }
        (NodeType::Encoder, Node::Encoder(config)) => {
            let node: &mut EncoderNode = node.downcast_mut()?;
            node.hold_rate = config.hold_rate;
        }
        (NodeType::Math, Node::Math(config)) => {
            let node: &mut MathNode = node.downcast_mut()?;
            node.mode = config.mode;
        }
        (NodeType::Merge, Node::Merge(config)) => {
            let node: &mut MergeNode = node.downcast_mut()?;
            node.mode = config.mode;
        }
        (NodeType::MqttInput, Node::MqttInput(config)) => {
            let node: &mut MqttInputNode = node.downcast_mut()?;
            node.connection = config.connection.clone();
            node.path = config.path.clone();
        }
        (NodeType::MqttOutput, Node::MqttOutput(config)) => {
            let node: &mut MqttOutputNode = node.downcast_mut()?;
            node.connection = config.connection.clone();
            node.path = config.path.clone();
        }
        (node_type, node) => log::warn!(
            "invalid node type {:?} for given update {:?}",
            node_type,
            node
        ),
    }
    Ok(())
}
