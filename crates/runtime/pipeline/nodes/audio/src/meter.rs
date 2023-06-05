use mizer_node::*;
use serde::{Deserialize, Serialize};

const AUDIO_INPUT: &str = "Stereo";
const VOLUME_OUTPUT: &str = "Volume";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct AudioMeterNode;

impl ConfigurableNode for AudioMeterNode {}

impl PipelineNode for AudioMeterNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Audio Level".to_string(),
            preview_type: PreviewType::History,
            category: NodeCategory::Audio,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            output_port!(VOLUME_OUTPUT, PortType::Single),
            input_port!(AUDIO_INPUT, PortType::Multi),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::AudioMeter
    }
}

impl ProcessingNode for AudioMeterNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(buffer) = context.read_port::<_, Vec<f64>>(AUDIO_INPUT) {
            let volume = rms(buffer);
            context.write_port(VOLUME_OUTPUT, volume);
            context.push_history_value(volume);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

fn rms(buffer: Vec<f64>) -> f64 {
    let n = buffer.len() as f64;
    let mean_of_squares = (1. / n) * buffer.iter().map(|x| x * x).sum::<f64>();

    mean_of_squares.sqrt()
}
