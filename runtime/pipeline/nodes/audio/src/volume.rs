use mizer_node::*;
use serde::{Deserialize, Serialize};

const VOLUME_INPUT: &str = "Volume";
const AUDIO_INPUT: &str = "Stereo";
const AUDIO_OUTPUT: &str = "Stereo";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct AudioVolumeNode;

impl PipelineNode for AudioVolumeNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(AudioVolumeNode).to_string(),
            preview_type: PreviewType::Waveform,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                VOLUME_INPUT.into(),
                PortMetadata {
                    direction: PortDirection::Input,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                AUDIO_INPUT.into(),
                PortMetadata {
                    direction: PortDirection::Input,
                    port_type: PortType::Multi,
                    ..Default::default()
                },
            ),
            (
                AUDIO_OUTPUT.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Multi,
                    ..Default::default()
                },
            ),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::AudioVolume
    }
}

impl ProcessingNode for AudioVolumeNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(volume) = context.read_port::<_, f64>(VOLUME_INPUT) {
            if let Some(buffer) = context.read_port::<_, Vec<f64>>(AUDIO_INPUT) {
                let output: Vec<f64> = buffer.into_iter().map(|f| f * volume).collect();
                context.write_port(AUDIO_OUTPUT, output);
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {}
}
