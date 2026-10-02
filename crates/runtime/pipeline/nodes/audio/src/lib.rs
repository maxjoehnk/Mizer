use cpal::traits::{DeviceTrait, HostTrait};
use cpal::{Device, DeviceId, DeviceType, SampleFormat};
pub use dasp::Signal;
use dasp::frame::Stereo;
use dasp::signal::{FromInterleavedSamplesIterator, from_interleaved_samples_iter};
use std::str::FromStr;
use std::sync::Arc;
use std::vec::IntoIter;

pub use file::*;
pub use input::*;
pub use meter::*;
pub use mix::*;
use mizer_node::*;
pub use output::*;
pub use volume::*;

pub(crate) const CHANNEL_COUNT: usize = 2;
pub(crate) const SAMPLE_RATE: u32 = 48_000;
const BUFFER_SIZE: usize = 4;

// TODO: decrease buffer size if possible
pub(crate) const INPUT_BUFFER_SIZE: usize = BUFFER_SIZE;
pub(crate) const OUTPUT_BUFFER_SIZE: usize = BUFFER_SIZE;

mod file;
mod input;
mod meter;
mod mix;
mod output;
mod volume;

pub trait AudioContext {
    type InputSignal: Signal<Frame = Stereo<f64>>;

    fn transfer_size_per_channel(&self) -> usize;
    fn sample_rate(&self) -> u32 {
        SAMPLE_RATE
    }

    fn input_signal<TPort: Into<PortId>>(&self, name: TPort) -> Option<Self::InputSignal>;
    fn output_signal<TPort: Into<PortId>>(
        &self,
        name: TPort,
        signal: impl Signal<Frame = Stereo<f64>>,
    );

    fn read_samples<TPort: Into<PortId>>(&self, name: TPort, buffer: &mut [f64], sample_rate: u32);
    fn output_samples<TPort: Into<PortId>>(&self, name: TPort, buffer: &mut [f64], sample_rate: u32);
}

impl<T: NodeContext> AudioContext for T {
    type InputSignal = FromInterleavedSamplesIterator<IntoIter<f64>, Stereo<f64>>;

    fn transfer_size_per_channel(&self) -> usize {
        (self.sample_rate() as f64 / self.fps().ceil()).ceil() as usize
    }

    fn input_signal<TPort: Into<PortId>>(&self, name: TPort) -> Option<Self::InputSignal> {
        let buffer: Vec<f64> = self.read_port(name)?;

        Some(from_interleaved_samples_iter(buffer))
    }

    fn output_signal<TPort: Into<PortId>>(
        &self,
        name: TPort,
        signal: impl Signal<Frame = Stereo<f64>>,
    ) {
        let buffer: Vec<f64> = signal
            .into_interleaved_samples()
            .into_iter()
            .take(self.transfer_size_per_channel() * CHANNEL_COUNT) // Stereo Signal so take twice the sample count
            .collect();
        self.write_port(name, buffer);
    }

    fn read_samples<TPort: Into<PortId>>(&self, name: TPort, buffer: &mut [f64], sample_rate: u32) {
        todo!()
    }

    fn output_samples<TPort: Into<PortId>>(&self, name: TPort, buffer: &mut [f64], sample_rate: u32) {
        todo!()
    }
}

pub(crate) fn device_settings(devices: impl Iterator<Item = Device>, device: &str) -> (Vec<SelectVariant>, u32) {
    let devices = devices
        .into_iter()
        .map(|device| {
            let id = device.id().map(|id| id.to_string()).unwrap_or_default();
            let name = Arc::from(
                device
                    .description()
                    .map(|desc| {
                        if desc.device_type() == DeviceType::Unknown {
                            return format!("{}", desc.name());
                        }
                        format!("{} ({})", desc.name(), desc.device_type())
                    })
                    .unwrap_or_default(),
            );

            SelectVariant::Item {
                label: name,
                value: id.into(),
            }
        })
        .collect();

    let max_channels = if let Some(device_id) = DeviceId::from_str(device).ok() {
        if let Some(device) = cpal::default_host().device_by_id(&device_id) {
            if let Ok(configs) = device.supported_input_configs() {
                configs
                    .filter(|config| config.sample_format() == SampleFormat::F32)
                    .map(|c| c.channels() as usize)
                    .max()
                    .unwrap_or(CHANNEL_COUNT)
            } else {
                CHANNEL_COUNT
            }
        } else {
            CHANNEL_COUNT
        }
    } else {
        CHANNEL_COUNT
    } as u32;

    (devices, max_channels)
}
