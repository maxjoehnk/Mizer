use crate::WorkerPortId;
use rb::SpscRb;

pub struct AudioBuffer {
    buffer: SpscRb<f32>,
}

#[derive(Clone)]
pub struct AudioBufferRef {
}

impl AudioBufferRef {
    pub fn write(&mut self, data: &[f32]) {

    }

    pub fn read(&mut self, data: &mut [f32]) {

    }
}

pub trait AudioWorkerNode: Send {
    fn process(&mut self, context: &mut dyn AudioWorkerNodeContext);
}

pub trait CreateAudioWorkerContext {
    fn get_buffer(&self) -> AudioBufferRef;

    fn sample_rate(&self) -> u32;
}

pub trait AudioWorkerNodeContext {
    fn read_input(&self, port: WorkerPortId, buffer: &[f32]) -> Option<usize>;

    fn write_output(&mut self, port: WorkerPortId, cb: &dyn FnMut(&mut [f32]));
}
