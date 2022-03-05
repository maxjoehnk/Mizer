use std::collections::HashMap;
use std::sync::Mutex;

#[derive(Default)]
pub struct DmxBuffer {
    pub buffers: Mutex<HashMap<u16, [u8; 512]>>,
}

impl DmxBuffer {
    pub fn write_single(&self, universe: u16, channel: u16, value: u8) {
        assert!(channel < 512, "DMX Channel is above 512");
        log::trace!("writing {}:{} => {}", universe, channel, value);
        let mut universe_buffer = self.buffers.lock().unwrap();
        universe_buffer.entry(universe).or_insert_with(|| [0; 512]);
        let buffer = universe_buffer.get_mut(&universe).unwrap();
        buffer[channel as usize] = value;
    }

    pub fn write_bulk(&self, universe: u16, channel: u16, values: &[u8]) {
        assert!(channel < 512, "DMX Channel is above 512");
        assert!(
            channel as usize + values.len() <= 512,
            "DMX Channel is above 512"
        );
        let mut universe_buffer = self.buffers.lock().unwrap();
        universe_buffer.entry(universe).or_insert_with(|| [0; 512]);
        let buffer = universe_buffer.get_mut(&universe).unwrap();
        for (i, value) in values.iter().enumerate() {
            buffer[i + channel as usize - 1usize] = *value;
        }
    }
}
