use mizer_node::*;
use serde::{Deserialize, Serialize};

const AUDIO_INPUT: &str = "Stereo";
const AUDIO_OUTPUT: &str = "Stereo";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct AudioMixNode;

impl PipelineNode for AudioMixNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(AudioMixNode).to_string(),
            preview_type: PreviewType::Waveform,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(AUDIO_INPUT, PortType::Multi, multiple),
            output_port!(AUDIO_OUTPUT, PortType::Multi),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::AudioMix
    }
}

impl ProcessingNode for AudioMixNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let ports = context.read_changed_ports::<_, Vec<f64>>(AUDIO_INPUT);

        let ports = ports.into_iter().flatten().collect::<Vec<_>>();

        if ports.is_empty() {
            return Ok(());
        }

        let mut buffer = Vec::<f64>::new();

        for i in 0..ports[0].len() {
            buffer.push(ports.iter().map(|frames| frames[i]).sum());
        }

        context.write_port(AUDIO_OUTPUT, buffer);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, _config: &Self) {}
}
