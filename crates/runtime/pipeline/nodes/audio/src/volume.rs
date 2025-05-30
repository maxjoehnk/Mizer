use dasp::Signal;
use serde::{Deserialize, Serialize};

use mizer_node::*;

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
            input_port!(AUDIO_INPUT, PortType::Audio),
            output_port!(AUDIO_OUTPUT, PortType::Audio),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::AudioVolume
    }
}

const VOLUME_PORT: WorkerPortId = WorkerPortId("volume");
const INPUT_PORT: WorkerPortId = WorkerPortId("input");
const OUTPUT_PORT: WorkerPortId = WorkerPortId("output");

const VOLUME_WORKER: WorkerNodeDefinition = WorkerNodeDefinition::builder()
    .name("Audio Volume")
    .audio()
    .build();

impl ProcessingNode for AudioVolumeNode {
    type State = ();

    fn worker_nodes(&self) -> &[&WorkerNodeDefinition] {
        &[&VOLUME_WORKER]
    }

    fn create_audio_worker(&self, context: &impl CreateAudioWorkerContext, definition: &WorkerNodeDefinition) -> anyhow::Result<Box<dyn AudioWorkerNode>> {
        match definition {
            VOLUME_WORKER => {
                Ok(Box::new(AudioVolumeWorkerNode))
            }
            _ => anyhow::bail!("Unknown worker definition")
        }
    }


    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let volume = context.read_port::<_, f64>(VOLUME_INPUT)?;

        context.write_worker_data(VOLUME_PORT, volume);
        context.audio_input(AUDIO_INPUT, INPUT_PORT);
        context.audio_output(AUDIO_OUTPUT, OUTPUT_PORT);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

struct AudioVolumeWorkerNode;

impl AudioWorkerNode for AudioVolumeWorkerNode {
    fn process(&mut self, context: &mut dyn AudioWorkerNodeContext) {
        let volume = context.read_data::<f64>(VOLUME_PORT).unwrap() as f32;
        let input = context.input_signal(INPUT_PORT).unwrap();

        context.output_signal(OUTPUT_PORT, input.scale_amp(volume))
    }
}
