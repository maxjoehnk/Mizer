use futures::{Stream, StreamExt};
use mizer_command_executor::*;
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

    pub fn monitor_midi(
        &self,
        name: String,
    ) -> anyhow::Result<impl Stream<Item = MonitorMidiResponse>> {
        let stream = self
            .runtime
            .get_midi_monitor(name)?
            .into_stream()
            .map(|event| {
                log::warn!("event: {:?}", event);

                event
            })
            .map(MonitorMidiResponse::from);

        Ok(stream)
    }

    pub fn add_sacn(&self, name: String) -> anyhow::Result<()> {
        self.runtime.run_command(AddSacnOutputCommand { name })?;

        Ok(())
    }

    pub fn add_artnet(&self, name: String, host: String, port: Option<u16>) -> anyhow::Result<()> {
        self.runtime
            .run_command(AddArtnetOutputCommand { name, host, port })?;

        Ok(())
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

    pub fn delete_connection(&self, connection: Connection) -> anyhow::Result<()> {
        if let Some(Connection_oneof_connection::dmx(dmx)) = connection.connection {
            self.runtime
                .run_command(DeleteOutputCommand { name: dmx.outputId })?;

            Ok(())
        } else {
            unimplemented!()
        }
    }

    pub fn configure_connection(&self, update: ConfigureConnectionRequest) -> anyhow::Result<()> {
        if let Some(ConfigureConnectionRequest_oneof_config::dmx(connection)) = update.config {
            if let Some(DmxConnection_oneof_config::artnet(config)) = connection.config {
                self.runtime.run_command(ConfigureArtnetOutputCommand {
                    id: connection.outputId,
                    name: config.name,
                    host: config.host,
                    port: Some(config.port as u16),
                })?;

                Ok(())
            } else {
                unimplemented!()
            }
        } else {
            unimplemented!()
        }
    }
}
