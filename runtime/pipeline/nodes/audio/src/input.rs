use anyhow::Context;
use cpal::traits::{DeviceTrait, HostTrait, StreamTrait};
use cpal::{Device, SampleFormat, SampleRate, Stream};
use rb::{Producer, RbConsumer, RbProducer, SpscRb, RB};
use serde::{Deserialize, Serialize};

use crate::{BUFFER_SIZE, SAMPLE_RATE};
use mizer_node::*;

const AUDIO_OUTPUT: &str = "Stereo";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct AudioInputNode;

impl PipelineNode for AudioInputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(AudioInputNode).to_string(),
            preview_type: PreviewType::Waveform,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            AUDIO_OUTPUT.into(),
            PortMetadata {
                direction: PortDirection::Output,
                port_type: PortType::Multi,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::AudioInput
    }
}

impl ProcessingNode for AudioInputNode {
    type State = Option<AudioInputNodeState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if state.is_none() {
            *state = AudioInputNodeState::new().context("Creating audio input state")?;
        }
        if let Some(state) = state {
            let buffer = state.read()?;

            context.write_port(AUDIO_OUTPUT, buffer);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {}
}

pub struct AudioInputNodeState {
    buffer: SpscRb<f32>,
    device: Device,
    stream: Stream,
}

impl AudioInputNodeState {
    fn new() -> anyhow::Result<Option<Self>> {
        tracing::trace!("Opening audio input device");
        if let Some(device) = cpal::default_host().default_input_device() {
            let buffer = SpscRb::new(BUFFER_SIZE * 2);

            let config = device.supported_input_configs()?;
            let configs = config.collect::<Vec<_>>();
            tracing::trace!("Supported Input Configs: {configs:?}");
            if let Some(config) = configs
                .into_iter()
                .find(|c| c.channels() == 2 && c.sample_format() == SampleFormat::F32)
            {
                let config = config.with_sample_rate(SampleRate(SAMPLE_RATE));

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
                tracing::warn!("Unable to find supported stream config for Audio Output");

                Ok(None)
            }
        } else {
            Ok(None)
        }
    }

    fn read(&mut self) -> anyhow::Result<Vec<f64>> {
        let mut buffer = vec![0.; BUFFER_SIZE];
        let count = self
            .buffer
            .consumer()
            .read(&mut buffer)
            .map_err(|err| anyhow::anyhow!("Unable to read from Ringbuffer: {err:?}"))?;

        Ok(buffer[0..count].iter().map(|f| *f as f64).collect())
    }
}
