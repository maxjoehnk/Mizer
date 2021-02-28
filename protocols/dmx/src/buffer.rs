use std::collections::HashMap;
use std::sync::Mutex;

#[derive(Default)]
pub struct DmxBuffer {
    pub buffers: Mutex<HashMap<u16, [u8; 512]>>,
}

impl DmxBuffer {
    pub fn write_single(&self, universe: u16, channel: u8, value: u8) {
        log::trace!("writing {}:{} => {}", universe, channel, value);
        let mut universe_buffer = self.buffers.lock().unwrap();
        if !universe_buffer.contains_key(&universe) {
            universe_buffer.insert(universe, [0; 512]);
        }
        let buffer = universe_buffer.get_mut(&universe).unwrap();
        buffer[channel as usize] = value;
    }

    pub fn write_bulk(&self, universe: u16, channel: u8, values: &[u8]) {
        let mut universe_buffer = self.buffers.lock().unwrap();
        if !universe_buffer.contains_key(&universe) {
            universe_buffer.insert(universe, [0; 512]);
        }
        let buffer = universe_buffer.get_mut(&universe).unwrap();
        for (i, value) in values.iter().enumerate() {
            buffer[i + channel as usize - 1usize] = *value;
        }
    }
}
