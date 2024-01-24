use dasp::ring_buffer::Fixed;
use dasp::signal::rms::SignalRms;
use dasp::Signal;
use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::{AudioContextExt, TRANSFER_SIZE};

const AUDIO_INPUT: &str = "Stereo";
const VOLUME_OUTPUT: &str = "Volume";
const VOLUME_L_OUTPUT: &str = "Volume (L)";
const VOLUME_R_OUTPUT: &str = "Volume (R)";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct AudioMeterNode;

impl ConfigurableNode for AudioMeterNode {}

impl PipelineNode for AudioMeterNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Audio Meter".to_string(),
            preview_type: PreviewType::History,
            category: NodeCategory::Audio,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            output_port!(VOLUME_OUTPUT, PortType::Single),
            output_port!(VOLUME_L_OUTPUT, PortType::Single),
            output_port!(VOLUME_R_OUTPUT, PortType::Single),
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
        if let Some(signal) = context.input_signal(AUDIO_INPUT) {
            let buffer = Fixed::from(vec![[0.0; 2]; TRANSFER_SIZE]);
            let rms = signal.rms(buffer).until_exhausted().last().unwrap();
            let stereo_rms = rms.into_iter().sum::<f64>() / 2.0;
            context.write_port(VOLUME_OUTPUT, stereo_rms);
            context.write_port(VOLUME_L_OUTPUT, rms[0]);
            context.write_port(VOLUME_R_OUTPUT, rms[1]);
            context.push_history_value(stereo_rms);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
