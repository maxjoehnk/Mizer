use crate::{MidiDevice, MidiDeviceIdentifier, MidiDeviceProvider};
use dashmap::DashMap;
use mizer_midi_device_profiles::DeviceProfile;
use std::cell::RefCell;
use std::ops::DerefMut;
use std::path::Path;

pub struct MidiConnectionManager {
    provider: MidiDeviceProvider,
    devices: DashMap<String, MidiDevice>,
    requested_devices: RefCell<Vec<String>>,
}

impl Default for MidiConnectionManager {
    fn default() -> Self {
        let provider = MidiDeviceProvider::new();
        if let Ok(devices) = provider.list_devices() {
            log::debug!("Connected devices: {:?}", devices);
        }
        Self {
            provider,
            devices: Default::default(),
            requested_devices: Default::default(),
        }
    }
}

impl MidiConnectionManager {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn load_device_profiles<P: AsRef<Path>>(&mut self, path: P) -> anyhow::Result<()> {
        self.provider.load_device_profiles(path)
    }

    pub fn request_device<'a>(
        &'a self,
        name: &str,
    ) -> anyhow::Result<Option<impl DerefMut<Target = MidiDevice> + 'a>> {
        profiling::scope!("MidiConnectionManager::request_device");
        let mut device_requests = self.requested_devices.borrow_mut();
        let name_owned = name.to_string();
        if device_requests.contains(&name_owned) {
            return Ok(None);
        }
        if !self.devices.contains_key(name) {
            if let Some(device) = self.provider.find_device(name)? {
                self.devices.insert(name_owned, device.connect()?);
            } else {
                device_requests.push(name_owned);
            }
        }
        if let Some(device) = self.devices.get_mut(name) {
            Ok(Some(device))
        } else {
            Ok(None)
        }
    }

    pub fn list_available_devices(&self) -> Vec<MidiDeviceIdentifier> {
        self.provider.list_devices().unwrap()
    }

    pub fn list_available_device_profiles(&self) -> Vec<DeviceProfile> {
        self.provider.list_device_profiles()
    }

    pub(crate) fn clear_device_requests(&self) {
        let mut device_requests = self.requested_devices.borrow_mut();
        device_requests.clear();
    }
}