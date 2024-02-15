use dasp::frame::Stereo;
use dasp::Signal;
use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::AudioContextExt;

const VOLUME_INPUT: &str = "Volume";
const AUDIO_INPUT: &str = "Stereo";
const AUDIO_OUTPUT: &str = "Stereo";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct AudioVolumeNode;

impl ConfigurableNode for AudioVolumeNode {}

impl PipelineNode for AudioVolumeNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Audio Volume".to_string(),
            preview_type: PreviewType::Waveform,
            category: NodeCategory::Audio,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(VOLUME_INPUT, PortType::Single),
            input_port!(AUDIO_INPUT, PortType::Multi),
            output_port!(AUDIO_OUTPUT, PortType::Multi),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::AudioVolume
    }
}

impl ProcessingNode for AudioVolumeNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(output) = self.process(context) {
            context.output_signal(AUDIO_OUTPUT, output);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl AudioVolumeNode {
    fn process(&self, context: &impl NodeContext) -> Option<impl Signal<Frame = Stereo<f64>>> {
        let volume = context.read_port::<_, f64>(VOLUME_INPUT)?;
        let input = context.input_signal(AUDIO_INPUT)?;

        Some(input.scale_amp(volume))
    }
}
