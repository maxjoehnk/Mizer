use crate::WorkerPortId;
use dasp::frame::Stereo;
use dasp::signal::Signal;
use rb::SpscRb;

pub type AudioSignalDyn = dyn Signal<Frame = Stereo<f32>>;

pub struct AudioBuffer {
    buffer: SpscRb<f32>,
}

pub trait AudioBufferRef: Send {
    fn signal(&self) -> Box<AudioSignalDyn>;
}

pub trait AudioBufferRefMut: Send {
    fn write(&mut self, signal: Box<AudioSignalDyn>);
    
    fn write_frames(&mut self, data: &[f32]);
}

pub trait AudioWorkerNode {
    fn process(&mut self, context: &mut impl AudioWorkerNodeContext);
}

pub trait CreateAudioWorkerContext {
    fn create_buffer(&self) -> (Box<dyn AudioBufferRefMut>, Box<dyn AudioBufferRef>);

    fn sample_rate(&self) -> u32;
}

pub trait AudioWorkerNodeContext {
    fn input_signal(&self, port: WorkerPortId) -> Option<impl Signal<Frame=Stereo<f32>>>;

    fn output_signal(&mut self, port: WorkerPortId, signal: impl Signal<Frame=Stereo<f32>>);
    
    fn read_data<T>(&self, port: WorkerPortId) -> Option<T>;
    
    fn write_data<T>(&mut self, port: WorkerPortId, data: T);
}
