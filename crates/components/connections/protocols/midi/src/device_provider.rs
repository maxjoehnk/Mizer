use std::collections::HashMap;
use std::path::Path;

use midir::{MidiInput, MidiInputPort, MidiOutput, MidiOutputPort};
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
    profiles: Vec<DeviceProfile>,
    devices: Vec<MidiDeviceIdentifier>,
}

impl MidiDeviceProvider {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn load_device_profiles<P: AsRef<Path>>(&mut self, path: P) -> anyhow::Result<()> {
        self.profiles = load_profiles(path)?;

        Ok(())
    }

    pub fn list_device_profiles(&self) -> Vec<DeviceProfile> {
        self.profiles.clone()
    }

    pub fn find_device(&self, name: &str) -> anyhow::Result<Option<MidiDeviceIdentifier>> {
        profiling::scope!("MidiDeviceProvider::find_device");

        Ok(self
            .devices
            .iter()
            .find(|device| device.name == name)
            .cloned())
    }

    pub(crate) fn load_available_devices(&mut self) -> anyhow::Result<()> {
        profiling::scope!("MidiDeviceProvider::load_available_devices");
        let input_provider = MidiInput::new("mizer")?;
        let output_provider = MidiOutput::new("mizer")?;

        let input_ports = input_provider.ports();
        let output_ports = output_provider.ports();

        let mut ports = HashMap::new();

        for input in input_ports {
            let name = input_provider.port_name(&input)?;
            ports.insert(name, (Some(input), None));
        }
        for output in output_ports {
            let name = output_provider.port_name(&output)?;
            if let Some((_, output_port)) = ports.get_mut(&name) {
                output_port.replace(output);
            } else {
                ports.insert(name, (None, Some(output)));
            }
        }

        self.devices = ports
            .into_iter()
            .map(|(name, (input, output))| MidiDeviceIdentifier {
                profile: self.search_profile(&name),
                name: cleanup_name(name),
                input,
                output,
            })
            .collect();

        Ok(())
    }

    pub(crate) fn list_devices(&self) -> anyhow::Result<Vec<MidiDeviceIdentifier>> {
        profiling::scope!("MidiDeviceProvider::list_devices");

        Ok(self.devices.clone())
    }

    fn search_profile(&self, name: &str) -> Option<DeviceProfile> {
        profiling::scope!("MidiDeviceProvider::search_profile");
        self.profiles
            .iter()
            .find(|profile| profile.matches(name))
            .cloned()
    }
}

#[cfg(target_os = "linux")]
fn cleanup_name(name: String) -> String {
    LINUX_MIDI_PORT_NAME
        .captures_iter(&name)
        .next()
        .map(|s| s[1].to_string())
        .unwrap_or(name)
}

#[cfg(not(target_os = "linux"))]
fn cleanup_name(name: String) -> String {
    name
}
