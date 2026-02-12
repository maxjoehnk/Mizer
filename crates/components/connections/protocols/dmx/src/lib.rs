use crate::buffer::DmxBuffer;
pub use crate::dmx_monitor::DmxMonitorHandle;
use crate::dmx_monitor::DmxMonitorInternalHandle;

pub use crate::inputs::*;
pub use crate::module::DmxModule;
pub use crate::outputs::*;

mod buffer;
pub mod commands;
mod dmx_monitor;
mod inputs;
mod module;
mod outputs;
mod processor;

pub struct DmxConnectionManager {
    dmx_monitor: DmxMonitorInternalHandle,
    buffer: DmxBuffer,
}

impl DmxConnectionManager {
    pub fn new(internal_monitor: DmxMonitorInternalHandle) -> Self {
        Self {
            dmx_monitor: internal_monitor,
            buffer: DmxBuffer::default(),
        }
    }

    pub fn flush(&mut self) {
        self.dmx_monitor.write(&self.buffer);
        self.dmx_monitor.flush();
    }

    pub fn get_writer(&self) -> impl DmxWriter + '_ {
        &self.buffer
    }
}

impl DmxWriter for &DmxBuffer {
    fn write_single(&self, universe: u16, channel: u16, value: u8) {
        DmxBuffer::write_single(self, universe, channel, value);
    }

    fn write_bulk(&self, universe: u16, channel: u16, values: &[u8]) {
        DmxBuffer::write_bulk(self, universe, channel, values);
    }
}
