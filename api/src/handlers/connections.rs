use std::collections::HashMap;

use crate::models::*;
use crate::RuntimeApi;

#[derive(Clone, Default)]
pub struct ConnectionsHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> ConnectionsHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    pub fn get_connections(&self) -> Connections {
        let connections = self
            .runtime
            .get_connections()
            .into_iter()
            .map(Connection::from)
            .collect();

        Connections {
            connections,
            ..Default::default()
        }
    }

    pub fn monitor_dmx(&self, output_id: String) -> anyhow::Result<HashMap<u16, [u8; 512]>> {
        self.runtime.get_dmx_monitor(output_id)
    }

    pub fn add_sacn(&self, name: String) -> anyhow::Result<()> {
        self.runtime.add_sacn_connection(name)
    }

    pub fn add_artnet(&self, name: String, host: String, port: Option<u16>) -> anyhow::Result<()> {
        self.runtime.add_artnet_connection(name, host, port)
    }

    pub fn get_midi_device_profiles(&self) -> MidiDeviceProfiles {
        let profiles = self
            .runtime
            .get_midi_device_profiles()
            .into_iter()
            .map(MidiDeviceProfile::from)
            .collect();

        MidiDeviceProfiles {
            profiles,
            ..Default::default()
        }
    }
}
