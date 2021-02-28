use ::sacn::DmxSource;
use crate::DmxOutput;
use crate::buffer::DmxBuffer;

pub struct SacnOutput {
    source: DmxSource,
    buffer: DmxBuffer,
}

impl SacnOutput {
    pub fn new() -> Self {
        SacnOutput {
            source: DmxSource::new("mizer").unwrap(),
            buffer: Default::default(),
        }
    }
}

impl DmxOutput for SacnOutput {
    fn write_single(&self, universe: u16, channel: u8, value: u8) {
        self.buffer.write_single(universe, channel, value)
    }

    fn write_bulk(&self, universe: u16, channel: u8, values: &[u8]) {
        self.buffer.write_bulk(universe, channel, values)
    }

    fn flush(&self) {
        let universe_buffer = self.buffer.buffers.lock().unwrap();
        for (universe, buffer) in universe_buffer.iter() {
            self.source.send(*universe, buffer);
        }
    }
}
