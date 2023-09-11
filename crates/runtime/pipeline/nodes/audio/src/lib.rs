use dasp::frame::Stereo;
use dasp::signal::{from_interleaved_samples_iter, FromInterleavedSamplesIterator};
use dasp::Signal;
pub use file::*;
pub use input::*;
pub use meter::*;
pub use mix::*;
use mizer_node::{NodeContext, PortId};
pub use output::*;
use std::vec::IntoIter;
pub use volume::*;

pub(crate) const SAMPLE_RATE: u32 = 48_000;
pub(crate) const TRANSFER_SIZE: usize = (SAMPLE_RATE / 60) as usize;

mod file;
mod input;
mod meter;
mod mix;
mod output;
mod volume;

trait AudioContextExt {
    type InputSignal: Signal<Frame = Stereo<f64>>;

    fn input_signal<TPort: Into<PortId>>(&self, name: TPort) -> Option<Self::InputSignal>;
    fn output_signal<TPort: Into<PortId>>(
        &self,
        name: TPort,
        signal: impl Signal<Frame = Stereo<f64>>,
    );
}

impl<T: NodeContext> AudioContextExt for T {
    type InputSignal = FromInterleavedSamplesIterator<IntoIter<f64>, Stereo<f64>>;

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
            .take(TRANSFER_SIZE * 2) // Stereo Signal so take twice the sample count
            .collect();
        self.write_port(name, buffer);
    }
}
