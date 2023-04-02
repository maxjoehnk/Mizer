use anyhow::Context;
use cpal::traits::{DeviceTrait, HostTrait, StreamTrait};
use cpal::{Device, SampleFormat, SampleRate, Stream};
use rb::{Producer, RbConsumer, RbProducer, SpscRb, RB};
use serde::{Deserialize, Serialize};

use crate::{BUFFER_SIZE, SAMPLE_RATE};
use mizer_node::*;

const AUDIO_INPUT: &str = "Stereo";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct AudioOutputNode {}

impl PipelineNode for AudioOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(AudioOutputNode).to_string(),
            preview_type: PreviewType::Waveform,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            AUDIO_INPUT.into(),
            PortMetadata {
                direction: PortDirection::Input,
                port_type: PortType::Multi,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::AudioOutput
    }
}

impl ProcessingNode for AudioOutputNode {
    type State = Option<AudioOutputNodeState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if state.is_none() {
            *state = AudioOutputNodeState::new().context("Creating audio output state")?;
        }
        if let Some(state) = state {
            if let Some(buffer) = context.read_port::<_, Vec<f64>>(AUDIO_INPUT) {
                state.write(buffer)?;
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {}
}

pub struct AudioOutputNodeState {
    buffer: SpscRb<f32>,
    device: Device,
    stream: Stream,
}

impl AudioOutputNodeState {
    fn new() -> anyhow::Result<Option<Self>> {
        tracing::trace!("Opening audio output device");
        if let Some(device) = cpal::default_host().default_output_device() {
            let buffer = SpscRb::new(BUFFER_SIZE * 2);

            let config = device.supported_output_configs()?;
            let configs = config.collect::<Vec<_>>();
            tracing::trace!("Supported Output Configs: {configs:?}");
            if let Some(config) = configs
                .into_iter()
                .find(|c| c.channels() == 2 && c.sample_format() == SampleFormat::F32)
            {
                let config = config.with_sample_rate(SampleRate(SAMPLE_RATE));

                tracing::debug!("Selected stream config: {config:?}");

                let consumer = buffer.consumer();

                tracing::trace!("Building output stream");
                let stream = device.build_output_stream(
                    &config.config(),
                    move |data: &mut [f32], _: &cpal::OutputCallbackInfo| {
                        tracing::trace!("Reading {} frames", data.len());
                        if let Err(err) = consumer.read(data) {
                            tracing::error!("Unable to read from ring buffer: {err:?}");
                        }
                    },
                    move |err| tracing::error!("Playback error: {err:?}"),
                    None,
                )?;

                tracing::trace!("Starting output stream");
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

    fn write(&self, buffer: Vec<f64>) -> anyhow::Result<()> {
        tracing::trace!("Received {} frames", buffer.len());
        self.buffer
            .producer()
            .write(
                &buffer
                    .into_iter()
                    .map(|frame| frame as f32)
                    .collect::<Vec<_>>(),
            )
            .map_err(|err| anyhow::anyhow!("Unable to write to Ringbuffer: {err:?}"))?;

        Ok(())
    }
}
