use anyhow::Context;
use cpal::traits::{DeviceTrait, HostTrait, StreamTrait};
use cpal::{Device, DeviceId, SampleFormat, Stream};
use mizer_node::*;
use rb::{RB, RbConsumer, RbError, RbInspector, RbProducer, SpscRb};
use rubato::{FixedAsync, Slip};
use serde::{Deserialize, Serialize};
use std::str::FromStr;

use crate::{AudioContext, AudioInputNode, AudioInputNodeState, CHANNEL_COUNT, OUTPUT_BUFFER_SIZE, device_settings};

const AUDIO_DEVICE: &str = "Device";
const LEFT_CHANNEL: &str = "Left Channel";
const RIGHT_CHANNEL: &str = "Right Channel";

const AUDIO_INPUT: &str = "Stereo";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct AudioOutputNode {
    #[serde(default = "default_device")]
    device: String,
    #[serde(default = "default_left_channel")]
    left_channel: u32,
    #[serde(default = "default_right_channel")]
    right_channel: u32,
}

impl Default for AudioOutputNode {
    fn default() -> Self {
        Self {
            device: default_device(),
            left_channel: default_left_channel(),
            right_channel: default_right_channel(),
        }
    }
}

fn default_device() -> String {
    let Some(device) = cpal::default_host().default_output_device() else {
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

impl ConfigurableNode for AudioOutputNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        let (devices, max_channels) = if let Ok(devices) = cpal::default_host().output_devices() {
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

impl PipelineNode for AudioOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Audio Output".to_string(),
            preview_type: PreviewType::Waveform,
            category: NodeCategory::Audio,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(AUDIO_INPUT, PortType::Multi)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::AudioOutput
    }
}

impl ProcessingNode for AudioOutputNode {
    type State = (Option<AudioOutputNodeState>, Option<DeviceId>);

    fn process(&self, context: &impl NodeContext, (state, last_device_id): &mut Self::State) -> anyhow::Result<()> {
        let Ok(device_id) = DeviceId::from_str(&self.device) else {
            return Ok(());
        };
        if state.is_none() || matches!(state.as_ref(), Some(AudioOutputNodeState { device_id: id, .. }) if id != &device_id) {
            if last_device_id.is_none() || matches!(last_device_id.as_ref(), Some(id) if id != &device_id) {
                last_device_id.replace(device_id.clone());
                tracing::debug!("Creating audio output state for device {device_id}");
                *state = AudioOutputNodeState::new(device_id, context).context("Creating audio output state")?;
            }
        }
        if let Some(state) = state {
            if let Some(buffer) = context.read_port::<_, Vec<f64>>(AUDIO_INPUT) {
                state.write(buffer, (self.left_channel, self.right_channel))?;
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn debug_ui<'a>(&self, ui: &mut impl DebugUiDrawHandle<'a>, (state, _): &Self::State) {
        if let Some(state) = state {
            ui.label(format!(
                "Device: {:?}",
                state
                    .device
                    .description()
                    .map(|d| d.name().to_string())
                    .unwrap_or_else(|err| format!("Unable to get device name: {err:?}"))
            ));
            ui.label(format!(
                "Buffer: {}/{}",
                state.buffer.count(),
                state.buffer.capacity()
            ));
            ui.plot(
                "buffer",
                0.,
                state.buffer.capacity() as f64,
                &[state.buffer.count() as f64],
            );
        }
    }
}

pub struct AudioOutputNodeState {
    resampler: Slip<f64>,
    device_id: DeviceId,
    buffer: SpscRb<f32>,
    device: Device,
    stream: Stream,
    channel_count: usize,
}

impl AudioOutputNodeState {
    fn new(device_id: DeviceId, audio_context: &impl AudioContext) -> anyhow::Result<Option<Self>> {
        tracing::debug!("Opening audio output device");
        if let Some(device) = cpal::default_host().device_by_id(&device_id) {
            let config = device.supported_output_configs()?;
            let configs = config.collect::<Vec<_>>();
            tracing::debug!("Supported Output Configs: {configs:?}");
            if let Some(config) = configs.into_iter().filter(|c| {
                    c.sample_format() == SampleFormat::F32
                    && c.min_sample_rate() <= audio_context.sample_rate()
                    && c.max_sample_rate() >= audio_context.sample_rate()
            }).max_by_key(|c| c.channels()) {
                let config = config.with_sample_rate(audio_context.sample_rate());
                let channel_count = config.channels() as usize;

                let buffer = SpscRb::new(
                    audio_context.transfer_size_per_channel() * channel_count * OUTPUT_BUFFER_SIZE,
                );

                tracing::debug!("Selected stream config: {config:?}");

                let consumer = buffer.consumer();

                tracing::debug!("Building output stream");
                let stream = device.build_output_stream(
                    config.config(),
                    move |data: &mut [f32], _: &cpal::OutputCallbackInfo| {
                        tracing::trace!("Reading {} frames", data.len());
                        if let Err(err) = consumer.read(data) {
                            tracing::error!("Unable to read from ring buffer: {err:?}");
                        }
                    },
                    move |err| tracing::error!("Playback error: {err:?}"),
                    None,
                )?;

                tracing::debug!("Starting output stream");
                stream.play()?;

                let resampler = Slip::new(audio_context.transfer_size_per_channel(), 2, FixedAsync::Input)?;

                Ok(Some(Self {
                    resampler,
                    device_id,
                    buffer,
                    device,
                    stream,
                    channel_count,
                }))
            } else {
                tracing::warn!("Unable to find supported stream config for Audio Output");

                Ok(None)
            }
        } else {
            tracing::warn!("Selected device is not available {}", device_id);

            Ok(None)
        }
    }

    fn write(&self, buffer: Vec<f64>, channels: (u32, u32)) -> anyhow::Result<()> {
        tracing::trace!("Received {} frames", buffer.len());
        // TODO: count dropped frames
        self.buffer
            .producer()
            .write(
                &buffer
                    .chunks(CHANNEL_COUNT)
                    .flat_map(|frame| {
                        let left = frame[0] as f32;
                        let right = frame[1] as f32;

                        let mut buffer = vec![0f32; self.channel_count];
                        buffer[channels.0 as usize] = left;
                        buffer[channels.1 as usize] = right;

                        buffer
                    })
                    .collect::<Vec<_>>(),
            )
            .or_else(|err| {
                match err {
                    RbError::Full => tracing::warn!("Buffer Overrun"),
                    RbError::Empty => tracing::warn!("Buffer Underrun"),
                    _ => anyhow::bail!("Unable to write to Ringbuffer: {err:?}")
                };

                Ok(0)
            })?;

        Ok(())
    }
}
