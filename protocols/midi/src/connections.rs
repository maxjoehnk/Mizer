use crate::{MidiDevice, MidiDeviceProvider};
use dashmap::DashMap;
use std::ops::DerefMut;

pub struct MidiConnectionManager {
    provider: MidiDeviceProvider,
    devices: DashMap<String, MidiDevice>,
}

impl MidiConnectionManager {
    pub fn new() -> Self {
        let provider = MidiDeviceProvider::new();
        if let Ok(devices) = provider.list_devices() {
            log::debug!("Connected devices: {:?}", devices);
        }
        Self {
            provider,
            devices: Default::default(),
        }
    }

    pub fn request_device<'a>(&'a self, name: &str) -> anyhow::Result<Option<impl DerefMut<Target=MidiDevice> + 'a>> {
        if !self.devices.contains_key(name) {
            if let Some(device) = self.provider.find_device(name)? {
                self.devices.insert(name.to_string(), device.connect()?);
            }
        }
        if let Some(device) = self.devices.get_mut::<'a>(name) {
            Ok(Some(device))
        }else {
            Ok(None)
        }
    }
}
