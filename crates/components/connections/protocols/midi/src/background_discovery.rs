use std::collections::HashMap;
use std::sync::Arc;
use std::thread;
use std::time::Duration;

use dashmap::DashMap;
use midir::{MidiInput, MidiOutput};
use regex::Regex;

use mizer_midi_device_profiles::DeviceProfile;

use crate::{MidiDeviceIdentifier, MidiDeviceProfileRegistry, MidiDeviceProvider};

lazy_static::lazy_static! {
    static ref LINUX_MIDI_PORT_NAME: Regex = Regex::new("(.*) ([0-9]+:[0-9]+)").unwrap();
}

pub struct MidiBackgroundDiscovery {
    devices: Arc<DashMap<String, MidiDeviceIdentifier>>,
    profiles: MidiDeviceProfileRegistry,
}

impl MidiBackgroundDiscovery {
    pub fn new(provider: &MidiDeviceProvider) -> Self {
        Self {
            devices: Arc::clone(&provider.available_devices),
            profiles: provider.profile_registry.clone(),
        }
    }

    pub fn start(mut self) -> anyhow::Result<()> {
        thread::Builder::new()
            .name("MidiBackgroundDiscovery".into())
            .spawn(move || loop {
                if let Err(err) = self.load_available_devices() {
                    tracing::error!("Failed to load MIDI devices: {err:?}");
                }
                thread::sleep(Duration::from_secs(1));
            })?;

        Ok(())
    }

    pub(crate) fn load_available_devices(&mut self) -> anyhow::Result<()> {
        profiling::scope!("MidiBackgroundDiscovery::load_available_devices");
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

        let mut old_devices = self
            .devices
            .iter()
            .map(|entry| entry.key().clone())
            .collect::<Vec<_>>();
        for (name, (input, output)) in ports {
            let name = cleanup_name(name);
            let mut device = MidiDeviceIdentifier {
                name: name.clone(),
                input,
                output,
                profile: None,
            };
            if let Some(old_device) = self.devices.get(&name) {
                device.profile = old_device.profile.clone();
            } else  {
                tracing::info!("Connected device: {device:?}");
                mizer_console::debug!(
                    mizer_console::ConsoleCategory::Connections,
                    "Connected MIDI device: {name}",
                );
                device.profile = self.search_profile(&name);
            }
            old_devices.retain(|old_name| old_name != &name);
            self.devices.insert(name, device);
        }
        for name in old_devices {
            tracing::info!("Disconnected device: {name}");
            mizer_console::debug!(
                mizer_console::ConsoleCategory::Connections,
                "Disconnected MIDI device: {name}",
            );
            self.devices.remove(&name);
        }

        Ok(())
    }

    fn search_profile(&self, name: &str) -> Option<DeviceProfile> {
        profiling::scope!("MidiBackgroundDiscovery::search_profile");
        self.profiles.find_profile(name)
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
