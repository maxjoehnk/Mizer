use futures::{Stream, StreamExt};
use std::sync::Arc;

use mizer_command_executor::*;
use mizer_devices::DeviceManager;
use mizer_gamepads::GamepadRef;

use crate::proto::connections::*;
use crate::RuntimeApi;

#[derive(Clone, Default)]
pub struct ConnectionsHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> ConnectionsHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_connections(&self) -> Connections {
        let connections = self.runtime.execute_query(ListConnectionsQuery).unwrap();
        let connections = connections.into_iter().map(Connection::from).collect();

        Connections { connections }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn monitor_dmx(&self) -> anyhow::Result<Vec<(u16, Arc<[u8; 512]>)>> {
        self.runtime.get_dmx_monitor()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn monitor_midi(
        &self,
        name: String,
    ) -> anyhow::Result<impl Stream<Item = MonitorMidiResponse>> {
        let stream = self
            .runtime
            .get_midi_monitor(name)?
            .into_stream()
            .map(|event| {
                tracing::warn!("event: {:?}", event);

                event
            })
            .map(MonitorMidiResponse::from);

        Ok(stream)
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn monitor_osc(
        &self,
        connection_id: String,
    ) -> anyhow::Result<impl Stream<Item = MonitorOscResponse>> {
        let stream = self
            .runtime
            .get_osc_monitor(connection_id)?
            .into_stream()
            .map(|event| {
                tracing::debug!("osc event: {:?}", event);

                event
            })
            .map(MonitorOscResponse::from);

        Ok(stream)
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_sacn_output(&self, name: String, priority: u8) -> anyhow::Result<()> {
        self.runtime
            .run_command(AddSacnOutputCommand { name, priority })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_artnet_output(
        &self,
        name: String,
        host: String,
        port: Option<u16>,
    ) -> anyhow::Result<()> {
        self.runtime
            .run_command(AddArtnetOutputCommand { name, host, port })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_artnet_input(
        &self,
        name: String,
        host: String,
        port: Option<u16>,
    ) -> anyhow::Result<()> {
        self.runtime.run_command(AddArtnetInputCommand {
            name,
            host: host.parse()?,
            port,
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_mqtt(
        &self,
        url: String,
        username: Option<String>,
        password: Option<String>,
    ) -> anyhow::Result<()> {
        self.runtime.run_command(AddMqttConnectionCommand {
            url,
            username,
            password,
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_osc(
        &self,
        output_host: String,
        output_port: u16,
        input_port: u16,
    ) -> anyhow::Result<()> {
        self.runtime.run_command(AddOscConnectionCommand {
            output_host,
            output_port,
            input_port,
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_midi_device_profiles(&self) -> MidiDeviceProfiles {
        let profiles = self
            .runtime
            .execute_query(ListMidiDeviceProfilesQuery)
            .unwrap();
        let profiles = profiles.into_iter().map(MidiDeviceProfile::from).collect();

        MidiDeviceProfiles { profiles }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn change_midi_device_profile(
        &self,
        device: String,
        profile_id: Option<String>,
    ) -> anyhow::Result<()> {
        self.runtime
            .run_command(ChangeMidiDeviceProfileCommand { device, profile_id })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn delete_connection(&self, connection: Connection) -> anyhow::Result<()> {
        if let Some(connection::Connection::DmxOutput(dmx)) = connection.connection {
            self.runtime.run_command(DeleteOutputCommand {
                name: dmx.output_id,
            })?;

            Ok(())
        } else if let Some(connection::Connection::DmxInput(dmx)) = connection.connection {
            self.runtime
                .run_command(DeleteInputCommand { id: dmx.id })?;

            Ok(())
        } else if let Some(connection::Connection::Mqtt(mqtt)) = connection.connection {
            self.runtime.run_command(DeleteMqttConnectionCommand {
                id: mqtt.connection_id,
            })?;

            Ok(())
        } else if let Some(connection::Connection::Osc(osc)) = connection.connection {
            self.runtime.run_command(DeleteOscConnectionCommand {
                id: osc.connection_id,
            })?;

            Ok(())
        } else {
            anyhow::bail!("Connection {connection:?} cannot be deleted.")
        }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn configure_connection(&self, update: ConfigureConnectionRequest) -> anyhow::Result<()> {
        match update.config {
            Some(configure_connection_request::Config::DmxOutput(connection)) => {
                match connection.config {
                    Some(dmx_output_connection::Config::Artnet(config)) => {
                        self.runtime.run_command(ConfigureArtnetOutputCommand {
                            id: connection.output_id,
                            name: config.name,
                            host: config.host,
                            port: Some(config.port as u16),
                        })?;

                        Ok(())
                    }
                    Some(dmx_output_connection::Config::Sacn(config)) => {
                        self.runtime.run_command(ConfigureSacnOutputCommand {
                            id: connection.output_id,
                            name: config.name,
                            priority: config.priority.clamp(0, 200) as u8,
                        })?;

                        Ok(())
                    }
                    _ => {
                        anyhow::bail!("Dmx Output {connection:?} cannot be configured")
                    }
                }
            }
            Some(configure_connection_request::Config::DmxInput(connection)) => {
                match connection.config {
                    Some(dmx_input_connection::Config::Artnet(config)) => {
                        self.runtime.run_command(ConfigureArtnetInputCommand {
                            id: connection.id,
                            name: config.name,
                            host: config.host.parse()?,
                            port: Some(config.port as u16),
                        })?;

                        Ok(())
                    }
                    _ => {
                        anyhow::bail!("Dmx Input {connection:?} cannot be configured")
                    }
                }
            }
            Some(configure_connection_request::Config::Mqtt(connection)) => {
                self.runtime.run_command(ConfigureMqttConnectionCommand {
                    connection_id: connection.connection_id,
                    url: connection.url,
                    username: connection.username,
                    password: connection.password,
                })?;

                Ok(())
            }
            Some(configure_connection_request::Config::Osc(connection)) => {
                self.runtime.run_command(ConfigureOscConnectionCommand {
                    connection_id: connection.connection_id,
                    output_host: connection.output_address,
                    output_port: connection.output_port as u16,
                    input_port: connection.input_port as u16,
                })?;

                Ok(())
            }
            _ => anyhow::bail!("Connection {:?} cannot be configured", update.config),
        }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_gamepad_ref(&self, name: String) -> anyhow::Result<Option<GamepadRef>> {
        self.runtime.get_gamepad_ref(name)
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_device_manager(&self) -> DeviceManager {
        self.runtime.get_device_manager()
    }
}
