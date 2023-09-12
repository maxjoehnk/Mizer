use std::collections::HashMap;

use ::sacn::DmxSource;

use super::DmxOutput;
use crate::buffer::DmxBuffer;

pub struct SacnOutput {
    pub priority: u8,
    source: DmxSource,
    buffer: DmxBuffer,
}

impl SacnOutput {
    pub fn new(priority: Option<u8>) -> Self {
        Self {
            source: DmxSource::new("mizer").unwrap(),
            buffer: Default::default(),
            priority: priority.unwrap_or(100),
        }
    }
}

impl Default for SacnOutput {
    fn default() -> Self {
        Self::new(None)
    }
}

impl DmxOutput for SacnOutput {
    fn name(&self) -> String {
        format!("sACN ({})", self.source.name())
    }

    fn write_single(&self, universe: u16, channel: u16, value: u8) {
        self.buffer.write_single(universe, channel, value)
    }

    fn write_bulk(&self, universe: u16, channel: u16, values: &[u8]) {
        self.buffer.write_bulk(universe, channel, values)
    }

    fn flush(&self) {
        profiling::scope!("SacnOutput::flush");
        let universe_buffer = self.buffer.buffers.lock().unwrap();
        for (universe, buffer) in universe_buffer.iter() {
            if let Err(err) = self
                .source
                .send_with_priority(*universe, buffer, self.priority)
            {
                log::error!("Unable to send dmx universe {:?}", err);
            }
        }
    }

    fn read_buffer(&self) -> HashMap<u16, [u8; 512]> {
        let buffers = self.buffer.buffers.lock().unwrap();
        buffers.clone()
    }
}
