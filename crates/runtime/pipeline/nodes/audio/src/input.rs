use anyhow::Context;
use cpal::traits::{DeviceTrait, HostTrait, StreamTrait};
use cpal::{Device, SampleFormat, SampleRate, Stream};
use rb::{RbConsumer, RbProducer, SpscRb, RB};
use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::{AudioContext, CHANNEL_COUNT, INPUT_BUFFER_SIZE};

const AUDIO_OUTPUT: &str = "Stereo";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct AudioInputNode;

impl ConfigurableNode for AudioInputNode {}

impl PipelineNode for AudioInputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Audio Input".to_string(),
            preview_type: PreviewType::Waveform,
            category: NodeCategory::Audio,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(AUDIO_OUTPUT, PortType::Audio)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::AudioInput
    }
}

const INPUT_WORKER_DEFINITION: WorkerNodeDefinition = WorkerNodeDefinition::builder()
    .name("AudioInput")
    .audio()
    .build();

impl ProcessingNode for AudioInputNode {
    type State = ();

    fn worker_nodes(&self) -> &[&WorkerNodeDefinition] {
        &[&INPUT_WORKER_DEFINITION]
    }

    fn create_audio_worker(&self, context: &impl CreateAudioWorkerContext, definition: &WorkerNodeDefinition) -> anyhow::Result<Box<dyn AudioWorkerNode>> {
        match definition {
            &INPUT_WORKER_DEFINITION => {
                let (write_buffer, read_buffer) = context.create_buffer();
                let worker = AudioInputWorker::new(write_buffer, read_buffer, context.sample_rate())?;

                Ok(Box::new(worker))
            }
            _ => anyhow::bail!("Unknown worker definition")
        }
    }

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        context.audio_output(AUDIO_OUTPUT, OUTPUT_WORKER_PORT);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

pub struct AudioInputNodeState {
    buffer: SpscRb<f32>,
    device: Device,
    stream: Stream,
}

impl AudioInputNodeState {
    fn read(&mut self, audio_context: &impl AudioContext) -> anyhow::Result<Option<Vec<f64>>> {
        let mut buffer = vec![0.; audio_context.transfer_size_per_channel() * CHANNEL_COUNT];
        let consumer = self.buffer.consumer();
        let count = consumer.get(&mut buffer).unwrap_or(0);
        if count < buffer.len() {
            return Ok(None);
        }

        consumer.skip(count)
            .map_err(|err| anyhow::anyhow!("Unable to skip from Ringbuffer: {err:?}"))?;

        Ok(Some(buffer.into_iter().map(|f| f as f64).collect()))
    }
}

const OUTPUT_WORKER_PORT: WorkerPortId = WorkerPortId("output");

pub struct AudioInputWorker {
    read_buffer: Box<dyn AudioBufferRef>,
    device: Device,
    stream: Stream,
}

impl AudioWorkerNode for AudioInputWorker {
    fn process(&mut self, context: &mut dyn AudioWorkerNodeContext) {
        context.output_signal(OUTPUT_WORKER_PORT, self.read_buffer.signal());
    }
}

impl AudioInputWorker {
    fn new(write_buffer: Box<dyn AudioBufferRefMut>, read_buffer: Box<dyn AudioBufferRef>, sample_rate: u32) -> anyhow::Result<Self> {
        let Some(device) = Self::find_audio_device()? else {
            anyhow::bail!("Unable to find audio device");
        };
        let Some(stream) = Self::open_stream(&device, sample_rate, write_buffer)? else {
            anyhow::bail!("Unable to open audio stream");
        };

        Ok(Self {
            read_buffer,
            device,
            stream,
        })
    }

    fn find_audio_device() -> anyhow::Result<Option<Device>> {
        tracing::trace!("Opening audio input device");
        let device = cpal::default_host().default_input_device();

        Ok(device)
    }

    fn open_stream(device: &Device, sample_rate: u32, mut buffer: Box<dyn AudioBufferRefMut>) -> anyhow::Result<Option<Stream>> {
        let sample_rate = SampleRate(sample_rate);
        let config = device.supported_input_configs()?;
        let configs = config.collect::<Vec<_>>();
        tracing::trace!("Supported Input Configs: {configs:?}");
        // TODO: find device with lowest buffer size
        if let Some(config) = configs.into_iter().find(|c| {
            c.channels() == 2
                && c.sample_format() == SampleFormat::F32
                && c.min_sample_rate() <= sample_rate
                && c.max_sample_rate() >= sample_rate
        }) {
            let config = config.with_sample_rate(sample_rate);

            tracing::debug!("Selected stream config: {config:?}");

            tracing::trace!("Building input stream");
            let stream = device.build_input_stream(
                &config.config(),
                move |data: &[f32], _: &cpal::InputCallbackInfo| {
                    tracing::trace!("Writing {} frames", data.len());
                    buffer.write_frames(data);
                },
                move |err| tracing::error!("Playback error: {err:?}"),
                None,
            )?;

            tracing::trace!("Starting input stream");
            stream.play()?;

            Ok(Some(stream))
        } else {
            tracing::warn!("Unable to find supported stream config for Audio Input");

            Ok(None)
        }
    }
}
