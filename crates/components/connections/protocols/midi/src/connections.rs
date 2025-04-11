use std::ops::DerefMut;
use std::path::Path;

use dashmap::DashMap;

use crate::{MidiDevice, MidiDeviceIdentifier, MidiDeviceProvider};

pub struct MidiConnectionManager {
    pub(crate) provider: MidiDeviceProvider,
    devices: DashMap<String, MidiDevice>,
}

impl MidiConnectionManager {
    pub fn new(provider: MidiDeviceProvider) -> Self {
        Self {
            provider,
            devices: DashMap::new(),
        }
    }

    pub(crate) fn change_device_profile(
        &self,
        device: &str,
        profile_id: Option<&str>,
    ) -> anyhow::Result<Option<String>> {
        let profile = if let Some(profile_id) = profile_id {
            let Some(profile) = self.provider.profile_registry.get_profile(profile_id) else {
                anyhow::bail!("Profile not found");
            };

            Some(profile)
        } else {
            None
        };

        if let Some(mut device) = self.devices.get_mut(device) {
            device.profile = profile.clone();
        }
        if let Some(mut device) = self.provider.available_devices.get_mut(device) {
            let previous = if let Some(profile) = profile {
                device.profile.replace(profile)
            } else {
                device.profile.take()
            };

            Ok(previous.map(|p| p.id))
        } else {
            anyhow::bail!("Device not connected");
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
        if !self.provider.available_devices.contains_key(name) {
            self.devices.remove(name);
            return Ok(None);
        }
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

    pub fn clear(&self) -> anyhow::Result<()> {
        // TODO: this will only clear previously connected devices
        tracing::info!("Clearing all {} MIDI device outputs", self.devices.len());
        for mut device in self.devices.iter_mut() {
            device.value_mut().clear_outputs()?;
        }

        Ok(())
    }
}
