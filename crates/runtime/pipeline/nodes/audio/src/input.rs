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
        vec![output_port!(AUDIO_OUTPUT, PortType::Multi)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::AudioInput
    }
}

impl ProcessingNode for AudioInputNode {
    type State = Option<AudioInputNodeState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if state.is_none() {
            *state = AudioInputNodeState::new(context).context("Creating audio input state")?;
        }
        if let Some(state) = state {
            if let Some(buffer) = state.read(context)? {
                context.write_port(AUDIO_OUTPUT, buffer);
            }
        }

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
    fn new(audio_context: &impl AudioContext) -> anyhow::Result<Option<Self>> {
        tracing::trace!("Opening audio input device");
        if let Some(device) = cpal::default_host().default_input_device() {
            let buffer = SpscRb::new(
                audio_context.transfer_size_per_channel() * CHANNEL_COUNT * INPUT_BUFFER_SIZE,
            );

            let config = device.supported_input_configs()?;
            let configs = config.collect::<Vec<_>>();
            tracing::trace!("Supported Input Configs: {configs:?}");
            // TODO: find device with lowest buffer size
            if let Some(config) = configs.into_iter().find(|c| {
                c.channels() == 2
                    && c.sample_format() == SampleFormat::F32
                    && c.min_sample_rate() <= SampleRate(audio_context.sample_rate())
                    && c.max_sample_rate() >= SampleRate(audio_context.sample_rate())
            }) {
                let config = config.with_sample_rate(SampleRate(audio_context.sample_rate()));

                tracing::debug!("Selected stream config: {config:?}");

                let producer = buffer.producer();

                tracing::trace!("Building input stream");
                let stream = device.build_input_stream(
                    &config.config(),
                    move |data: &[f32], _: &cpal::InputCallbackInfo| {
                        tracing::trace!("Writing {} frames", data.len());
                        if let Err(err) = producer.write(data) {
                            tracing::error!("Unable to write to ring buffer: {err:?}");
                        }
                    },
                    move |err| tracing::error!("Playback error: {err:?}"),
                    None,
                )?;

                tracing::trace!("Starting input stream");
                stream.play()?;

                Ok(Some(Self {
                    buffer,
                    device,
                    stream,
                }))
            } else {
                tracing::warn!("Unable to find supported stream config for Audio Input");

                Ok(None)
            }
        } else {
            Ok(None)
        }
    }

    fn read(&mut self, audio_context: &impl AudioContext) -> anyhow::Result<Option<Vec<f64>>> {
        let mut buffer = vec![0.; audio_context.transfer_size_per_channel() * CHANNEL_COUNT];
        let consumer = self.buffer.consumer();
        let count = consumer.get(&mut buffer).unwrap_or(0);
        if count < buffer.len() {
            return Ok(None);
        }

        consumer
            .skip(count)
            .map_err(|err| anyhow::anyhow!("Unable to skip from Ringbuffer: {err:?}"))?;

        Ok(Some(buffer.into_iter().map(|f| f as f64).collect()))
    }
}
