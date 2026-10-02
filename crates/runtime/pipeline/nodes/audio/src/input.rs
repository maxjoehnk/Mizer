use anyhow::Context;
use audioadapter_buffers::owned::InterleavedOwned;
use cpal::traits::*;
use cpal::{Device, DeviceId, SampleFormat, Stream};
use rb::{RB, RbConsumer, RbProducer, SpscRb};
use rubato::{Async, FixedAsync, Indexing, Resampler, Slip};
use serde::{Deserialize, Serialize};
use std::fmt::{Debug, Formatter};
use std::str::FromStr;

use mizer_node::*;

use crate::{AudioContext, CHANNEL_COUNT, INPUT_BUFFER_SIZE, device_settings};

const AUDIO_DEVICE: &str = "Device";
const LEFT_CHANNEL: &str = "Left Channel";
const RIGHT_CHANNEL: &str = "Right Channel";

const AUDIO_OUTPUT: &str = "Stereo";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct AudioInputNode {
    #[serde(default = "default_device")]
    device: String,
    #[serde(default = "default_left_channel")]
    left_channel: u32,
    #[serde(default = "default_right_channel")]
    right_channel: u32,
}

impl Default for AudioInputNode {
    fn default() -> Self {
        Self {
            device: default_device(),
            left_channel: default_left_channel(),
            right_channel: default_right_channel(),
        }
    }
}

fn default_device() -> String {
    let Some(device) = cpal::default_host().default_input_device() else {
        return Default::default();
    };

    let Ok(id) = device.id() else {
        return Default::default();
    };

    id.to_string()
}

fn default_left_channel() -> u32 {
    0
}

fn default_right_channel() -> u32 {
    1
}

impl ConfigurableNode for AudioInputNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        let (devices, max_channels) = if let Ok(devices) = cpal::default_host().input_devices() {
            device_settings(devices.into_iter(), &self.device)
        }else {
            (Default::default(), 2)
        };

        vec![
            setting!(select AUDIO_DEVICE, &self.device, devices),
            setting!(LEFT_CHANNEL, self.left_channel).min(0u32).max(max_channels - 1),
            setting!(RIGHT_CHANNEL, self.right_channel).min(0u32).max(max_channels - 1)
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, AUDIO_DEVICE, self.device);
        update!(uint setting, LEFT_CHANNEL, self.left_channel);
        update!(uint setting, RIGHT_CHANNEL, self.right_channel);

        update_fallback!(setting)
    }
}

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
    type State = (Option<AudioInputNodeState>, Option<DeviceId>);

    fn process(&self, context: &impl NodeContext, (state, last_device_id): &mut Self::State) -> anyhow::Result<()> {
        let Ok(device_id) = DeviceId::from_str(&self.device) else {
            return Ok(());
        };
        if state.is_none() || matches!(state.as_ref(), Some(AudioInputNodeState { device_id: id, .. }) if id != &device_id) {
            if last_device_id.is_none() || matches!(last_device_id.as_ref(), Some(id) if id != &device_id) {
                last_device_id.replace(device_id.clone());
                tracing::debug!("Creating audio input state for device {device_id}");
                *state = AudioInputNodeState::new(device_id, context).context("Creating audio input state")?;
            }
        }
        if let Some(state) = state {
            if let Some(buffer) = state.read(context, (self.left_channel, self.right_channel))? {
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
    resampler: Slip<f64>,
    device_id: DeviceId,
    buffer: SpscRb<f32>,
    device: Device,
    stream: Stream,
    channel_count: usize,
}

impl Debug for AudioInputNodeState {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("AudioInputNodeState")
            .field("device_id", &self.device_id)
            .field("device", &self.device)
            .field("channel_count", &self.channel_count)
            .finish()
    }
}

impl AudioInputNodeState {
    fn new(device_id: DeviceId, audio_context: &impl AudioContext) -> anyhow::Result<Option<Self>> {
        tracing::debug!("Opening audio input device");
        if let Some(device) = cpal::default_host().device_by_id(&device_id) {
            let config = device.supported_input_configs()?;
            let configs = config.collect::<Vec<_>>();
            tracing::debug!("Supported Input Configs: {configs:?}");
            // TODO: find device with lowest buffer size
            if let Some(config) = configs.into_iter().filter(|c| {
                    c.sample_format() == SampleFormat::F32
                    && c.min_sample_rate() <= audio_context.sample_rate()
                    && c.max_sample_rate() >= audio_context.sample_rate()
            }).max_by_key(|c| c.channels()) {
                let config = config.with_sample_rate(audio_context.sample_rate());
                let channel_count = config.channels() as usize;

                let buffer = SpscRb::new(
                    audio_context.transfer_size_per_channel() * channel_count * INPUT_BUFFER_SIZE,
                );

                tracing::debug!("Selected stream config: {config:?}");

                let producer = buffer.producer();

                tracing::debug!("Building input stream");
                let stream = device.build_input_stream(
                    config.config(),
                    move |data: &[f32], _: &cpal::InputCallbackInfo| {
                        tracing::trace!("Writing {} frames", data.len());
                        if let Err(err) = producer.write(data) {
                            tracing::error!("Unable to write to ring buffer: {err:?}");
                        }
                    },
                    move |err| tracing::error!("Playback error: {err:?}"),
                    None,
                )?;

                tracing::debug!("Starting input stream");
                stream.play()?;

                let resampler = Slip::new(audio_context.transfer_size_per_channel(), 2, FixedAsync::Output)?;

                Ok(Some(Self {
                    resampler,
                    device_id,
                    buffer,
                    device,
                    stream,
                    channel_count,
                }))
            } else {
                tracing::warn!("Unable to find supported stream config for Audio Input");

                Ok(None)
            }
        } else {
            tracing::warn!("Selected device is not available {}", device_id);

            Ok(None)
        }
    }

    fn read(&mut self, audio_context: &impl AudioContext, channels: (u32, u32)) -> anyhow::Result<Option<Vec<f64>>> {
        let frames = self.resampler.input_frames_next();
        let mut buffer = vec![0.; frames * 2];
        let consumer = self.buffer.consumer();
        let count = consumer.get(&mut buffer).unwrap_or(0);
        if count < buffer.len() {
            return Ok(None);
        }

        consumer
            .skip(count)
            .map_err(|err| anyhow::anyhow!("Unable to skip from Ringbuffer: {err:?}"))?;

        let stereo_buffer = buffer.chunks_exact(CHANNEL_COUNT).flat_map(|chunk| [chunk[channels.0 as usize] as f64, chunk[channels.1 as usize] as f64]).collect::<Vec<_>>();
        let stereo_buffer = InterleavedOwned::new_from(stereo_buffer, 2, frames)?;

        let buffer = self.resampler.process(&stereo_buffer, None)?;

        Ok(Some(buffer.take_data()))
    }
}
