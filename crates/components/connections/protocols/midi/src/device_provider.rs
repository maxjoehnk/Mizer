use std::path::Path;
use std::sync::Arc;

use dashmap::DashMap;
use midir::{MidiInputPort, MidiOutputPort};
use parking_lot::RwLock;
use regex::Regex;

use mizer_midi_device_profiles::{load_profiles, DeviceProfile};

use crate::device::MidiDevice;

lazy_static::lazy_static! {
    static ref LINUX_MIDI_PORT_NAME: Regex = Regex::new("(.*) ([0-9]+:[0-9]+)").unwrap();
}

#[derive(Clone)]
pub struct MidiDeviceIdentifier {
    pub name: String,
    pub(crate) input: Option<MidiInputPort>,
    pub(crate) output: Option<MidiOutputPort>,
    pub profile: Option<DeviceProfile>,
}

impl MidiDeviceIdentifier {
    pub fn connect(self) -> anyhow::Result<MidiDevice> {
        MidiDevice::new(self)
    }
}

impl std::fmt::Debug for MidiDeviceIdentifier {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("MidiDeviceIdentifier")
            .field("name", &self.name)
            .field("has_input", &self.input.is_some())
            .field("has_output", &self.output.is_some())
            .finish()
    }
}

#[derive(Default)]
pub struct MidiDeviceProvider {
    pub(crate) profile_registry: MidiDeviceProfileRegistry,
    pub(crate) available_devices: Arc<DashMap<String, MidiDeviceIdentifier>>,
}

#[derive(Clone, Default)]
pub struct MidiDeviceProfileRegistry {
    pub(crate) profiles: Arc<RwLock<Vec<DeviceProfile>>>,
}

impl MidiDeviceProfileRegistry {
    pub fn list_device_profiles(&self) -> Vec<DeviceProfile> {
        self.profiles.read().clone()
    }
    
    pub fn find_profile(&self, name: &str) -> Option<DeviceProfile> {
        let profiles = self.profiles.read();
        profiles
            .iter()
            .find(|profile| profile.matches(name))
            .cloned()
    }

    pub fn load_device_profiles<P: AsRef<Path>>(&self, paths: &[P]) -> anyhow::Result<usize> {
        let mut profiles = self.profiles.write();
        *profiles = Default::default();
        for path in paths {
            let device_profiles = load_profiles(path)?;
            profiles.extend(device_profiles);
        }

        Ok(profiles.len())
    }
}

impl MidiDeviceProvider {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn load_device_profiles<P: AsRef<Path>>(&mut self, paths: &[P]) -> anyhow::Result<()> {
        self.profile_registry.load_device_profiles(paths)?;
        
        Ok(())
    }

    pub fn list_device_profiles(&self) -> Vec<DeviceProfile> {
        self.profile_registry.list_device_profiles()
    }

    pub fn find_device(&self, name: &str) -> anyhow::Result<Option<MidiDeviceIdentifier>> {
        profiling::scope!("MidiDeviceProvider::find_device");

        Ok(self
            .available_devices
            .get(name)
            .map(|entry| entry.value().clone()))
    }

    pub(crate) fn list_devices(&self) -> anyhow::Result<Vec<MidiDeviceIdentifier>> {
        profiling::scope!("MidiDeviceProvider::list_devices");

        Ok(self
            .available_devices
            .iter()
            .map(|entry| entry.value().clone())
            .collect())
    }
}
