use midir::{MidiInput, MidiInputPort, MidiOutput, MidiOutputPort};
use std::collections::HashMap;
use mizer_midi_device_profiles::{DeviceProfile, load_profiles};

use crate::device::MidiDevice;

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

pub struct MidiDeviceProvider {
    profiles: Vec<DeviceProfile>,
}

impl MidiDeviceProvider {
    pub fn new() -> Self {
        MidiDeviceProvider {
            profiles: Vec::new(),
        }
    }

    pub fn load_device_profiles(&mut self, path: &str) -> anyhow::Result<()> {
        self.profiles = load_profiles(path)?;

        Ok(())
    }

    pub fn list_device_profiles(&self) -> Vec<DeviceProfile> {
        self.profiles.clone()
    }

    pub fn find_device(&self, name: &str) -> anyhow::Result<Option<MidiDeviceIdentifier>> {
        let devices = self.list_devices()?;

        Ok(devices.into_iter().find(|device| device.name == name))
    }

    pub fn list_devices(&self) -> anyhow::Result<Vec<MidiDeviceIdentifier>> {
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

        let devices = ports
            .into_iter()
            .map(|(name, (input, output))| MidiDeviceIdentifier {
                profile: self.profiles.iter().find(|profile| profile.matches(&name)).cloned(),
                name,
                input,
                output,
            })
            .collect();

        Ok(devices)
    }
}
