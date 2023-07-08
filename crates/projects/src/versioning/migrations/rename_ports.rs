use crate::versioning::migrations::ProjectFileMigration;
use crate::Channel;
use indexmap::IndexMap;
use mizer_node::{NodePath, NodeType};
use serde::{Deserialize, Serialize};
use serde_yaml::Value;

#[derive(Clone, Copy)]
pub struct RenamePorts;

impl ProjectFileMigration for RenamePorts {
    const VERSION: usize = 1;

    fn migrate(&self, project_file: &mut String) -> anyhow::Result<()> {
        profiling::scope!("RenamePorts::migrate");
        let mut project: ProjectConfig = serde_yaml::from_str(project_file)?;

        project.rename_input(NodeType::Select, "channel", "Channel");
        project.rename_input(NodeType::Select, "input", "Inputs");
        project.rename_output(NodeType::Select, "output", "Output");
        project.rename_input(NodeType::Merge, "input", "Inputs");
        project.rename_output(NodeType::Merge, "output", "Output");
        project.rename_input(NodeType::Threshold, "value", "Input");
        project.rename_output(NodeType::Threshold, "value", "Output");
        project.rename_input(NodeType::DataToNumber, "value", "Input");
        project.rename_output(NodeType::DataToNumber, "value", "Output");
        project.rename_input(NodeType::NumberToData, "value", "Input");
        project.rename_output(NodeType::NumberToData, "value", "Output");
        project.rename_input(NodeType::Envelope, "value", "Input");
        project.rename_output(NodeType::Envelope, "value", "Output");
        project.rename_input(NodeType::Oscillator, "interval", "Interval");
        project.rename_input(NodeType::Oscillator, "min", "Min");
        project.rename_input(NodeType::Oscillator, "max", "Max");
        project.rename_output(NodeType::Oscillator, "value", "Value");
        project.rename_input(NodeType::Ramp, "value", "Input");
        project.rename_output(NodeType::Ramp, "value", "Output");
        project.rename_output(NodeType::Sequence, "value", "Output");
        project.rename_input(NodeType::Delay, "value", "Input");
        project.rename_output(NodeType::Delay, "value", "Output");
        project.rename_output(NodeType::Value, "value", "Output");
        project.rename_input(NodeType::Button, "value", "Input");
        project.rename_output(NodeType::Button, "value", "Output");
        project.rename_input(NodeType::Fader, "value", "Input");
        project.rename_output(NodeType::Fader, "value", "Output");
        project.rename_input(NodeType::PixelDmx, "input", "Input");
        project.rename_output(NodeType::PixelPattern, "output", "Output");
        project.rename_input(NodeType::PlanScreen, "output", "Input");
        project.rename_input(NodeType::VideoHsv, "input", "Input");
        project.rename_output(NodeType::VideoHsv, "output", "Output");
        project.rename_input(NodeType::VideoHsv, "brightness", "Brightness");
        project.rename_input(NodeType::VideoHsv, "contrast", "Contrast");
        project.rename_input(NodeType::VideoHsv, "hue", "Hue");
        project.rename_input(NodeType::VideoHsv, "saturation", "Saturation");
        project.rename_output(NodeType::VideoFile, "output", "Output");
        project.rename_input(NodeType::VideoOutput, "input", "Input");
        project.rename_input(NodeType::VideoTransform, "input", "Input");
        project.rename_output(NodeType::VideoTransform, "output", "Output");
        project.rename_input(NodeType::VideoTransform, "rotate-x", "Rotate X");
        project.rename_input(NodeType::VideoTransform, "rotate-y", "Rotate Y");
        project.rename_input(NodeType::VideoTransform, "rotate-z", "Rotate Z");
        project.rename_input(NodeType::VideoTransform, "translate-x", "Translate X");
        project.rename_input(NodeType::VideoTransform, "translate-y", "Translate Y");
        project.rename_input(NodeType::VideoTransform, "translate-z", "Translate Z");
        project.rename_input(NodeType::VideoTransform, "scale-x", "Scale X");
        project.rename_input(NodeType::VideoTransform, "scale-y", "Scale Y");
        project.rename_input(NodeType::DmxOutput, "value", "Input");
        project.rename_output(NodeType::MidiInput, "value", "Output");
        project.rename_input(NodeType::MidiOutput, "value", "Input");
        project.rename_output(NodeType::MqttInput, "value", "Output");
        project.rename_input(NodeType::MqttOutput, "value", "Input");
        project.rename_input(NodeType::OpcOutput, "pixels", "Pixels");
        project.rename_output(NodeType::MqttInput, "value", "Output");
        project.rename_output(NodeType::OscInput, "number", "Number");
        project.rename_output(NodeType::OscInput, "color", "Color");
        project.rename_input(NodeType::OscOutput, "number", "Number");
        project.rename_input(NodeType::OscOutput, "color", "Color");
        project.rename_output(NodeType::IldaFile, "frames", "Frames");
        project.rename_input(NodeType::Laser, "input", "Frames");

        *project_file = serde_yaml::to_string(&project)?;

        Ok(())
    }
}

#[derive(Serialize, Deserialize)]
struct ProjectConfig {
    #[serde(default)]
    pub nodes: Vec<Node>,
    #[serde(default)]
    pub channels: Vec<Channel>,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

impl ProjectConfig {
    pub(super) fn rename_input(&mut self, node_type: NodeType, from: &str, to: &str) {
        let nodes = self.get_nodes_with_type(node_type);

        for channel in self.channels.iter_mut() {
            if &channel.to_channel == from {
                for node in &nodes {
                    if &channel.to_path == node {
                        channel.to_channel = to.into();
                    }
                }
            }
        }
    }

    pub(super) fn rename_output(&mut self, node_type: NodeType, from: &str, to: &str) {
        let nodes = self.get_nodes_with_type(node_type);

        for channel in self.channels.iter_mut() {
            if &channel.from_channel == from {
                for node in &nodes {
                    if &channel.from_path == node {
                        channel.from_channel = to.into();
                    }
                }
            }
        }
    }

    fn get_nodes_with_type(&mut self, node_type: NodeType) -> Vec<NodePath> {
        self.nodes
            .iter()
            .filter(|node| node.node_type == node_type)
            .map(|node| node.path.clone())
            .collect()
    }
}

#[derive(Serialize, Deserialize)]
struct Node {
    #[serde(rename = "type")]
    node_type: NodeType,
    path: NodePath,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}
