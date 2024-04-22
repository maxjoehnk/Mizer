use std::ops::DerefMut;
use std::path::Path;

use dashmap::DashMap;

use mizer_midi_device_profiles::DeviceProfile;

use crate::{MidiDevice, MidiDeviceIdentifier, MidiDeviceProvider};

pub struct MidiConnectionManager {
    provider: MidiDeviceProvider,
    devices: DashMap<String, MidiDevice>,
}

impl MidiConnectionManager {
    pub fn new(provider: MidiDeviceProvider) -> Self {
        Self {
            provider,
            devices: DashMap::new(),
        }
    }

    pub fn load_device_profiles<P: AsRef<Path>>(&mut self, path: &[P]) -> anyhow::Result<()> {
        self.provider.load_device_profiles(path)
    }

    pub fn request_device<'a>(
        &'a self,
        name: &str,
    ) -> anyhow::Result<Option<impl DerefMut<Target = MidiDevice> + 'a>> {
        profiling::scope!("MidiConnectionManager::request_device");
        if !self.devices.contains_key(name) {
            if let Some(device) = self.provider.find_device(name)? {
                self.devices.insert(name.to_string(), device.connect()?);
            } else {
                return Ok(None);
            }
        }
        if let Some(device) = self.devices.get_mut(name) {
            Ok(Some(device))
        } else {
            Ok(None)
        }
    }

    pub fn list_available_devices(&self) -> Vec<MidiDeviceIdentifier> {
        self.provider.list_devices().unwrap_or_default()
    }

    pub fn list_available_device_profiles(&self) -> Vec<DeviceProfile> {
        self.provider.list_device_profiles()
    }
}
