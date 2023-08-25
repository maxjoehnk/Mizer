use std::cell::RefCell;
use std::ops::DerefMut;
use std::path::Path;

use dashmap::DashMap;

use mizer_midi_device_profiles::DeviceProfile;

use crate::{MidiDevice, MidiDeviceIdentifier, MidiDeviceProvider};

pub struct MidiConnectionManager {
    provider: MidiDeviceProvider,
    devices: DashMap<String, MidiDevice>,
    requested_devices: RefCell<Vec<String>>,
}

impl MidiConnectionManager {
    pub(crate) fn search_available_devices(&mut self) -> anyhow::Result<()> {
        self.provider.load_available_devices()?;

        Ok(())
    }
}

impl Default for MidiConnectionManager {
    fn default() -> Self {
        Self {
            provider: MidiDeviceProvider::new(),
            devices: Default::default(),
            requested_devices: Default::default(),
        }
    }
}

impl MidiConnectionManager {
    pub fn new() -> Self {
        let mut connection_manager = Self::default();
        if let Ok(devices) = connection_manager
            .provider
            .load_available_devices()
            .and_then(|_| connection_manager.provider.list_devices())
        {
            log::debug!("Connected devices: {:?}", devices);
        }

        connection_manager
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
        self.provider.list_devices().unwrap_or_default()
    }

    pub fn list_available_device_profiles(&self) -> Vec<DeviceProfile> {
        self.provider.list_device_profiles()
    }

    pub(crate) fn clear_device_requests(&self) {
        let mut device_requests = self.requested_devices.borrow_mut();
        device_requests.clear();
    }
}
