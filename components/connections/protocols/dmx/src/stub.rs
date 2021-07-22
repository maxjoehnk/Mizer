use std::collections::HashMap;

use crate::buffer::DmxBuffer;
use crate::DmxOutput;

#[derive(Default)]
pub struct StubOutput {
    buffer: DmxBuffer,
}

impl StubOutput {
    pub fn new() -> Self {
        Default::default()
    }
}

impl DmxOutput for StubOutput {
    fn name(&self) -> String {
        "Stub".into()
    }

    fn write_single(&self, universe: u16, channel: u8, value: u8) {
        self.buffer.write_single(universe, channel, value)
    }

    fn write_bulk(&self, universe: u16, channel: u8, values: &[u8]) {
        self.buffer.write_bulk(universe, channel, values)
    }

    fn flush(&self) {}

    fn read_buffer(&self) -> HashMap<u16, [u8; 512]> {
        let buffer = self.buffer.buffers.lock().unwrap();
        buffer.clone()
    }
}
