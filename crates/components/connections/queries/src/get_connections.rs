use mizer_commander::{Query, Ref};
use mizer_connections::*;
use mizer_devices::DeviceManager;
use mizer_protocol_citp::CitpConnectionManager;
use mizer_protocol_dmx::{DmxConnectionManager, DmxInput, DmxOutput};
use mizer_protocol_midi::MidiConnectionManager;
use mizer_protocol_mqtt::MqttConnectionManager;
use mizer_protocol_osc::OscConnectionManager;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListConnectionsQuery;

impl<'a> Query<'a> for ListConnectionsQuery {
    type Dependencies = (
        Ref<MidiConnectionManager>,
        Ref<DmxConnectionManager>,
        Ref<MqttConnectionManager>,
        Ref<OscConnectionManager>,
        Ref<DeviceManager>,
        Ref<CitpConnectionManager>,
    );
    type Result = Vec<Connection>;

    fn query(
        &self,
        (midi_manager, dmx_manager, mqtt_manager, osc_manager, device_manager, citp_manager): (
            &MidiConnectionManager,
            &DmxConnectionManager,
            &MqttConnectionManager,
            &OscConnectionManager,
            &DeviceManager,
            &CitpConnectionManager,
        ),
    ) -> anyhow::Result<Self::Result> {
        let mut connections = Vec::new();
        connections.extend(self.midi_connections(midi_manager));
        connections.extend(self.dmx_outputs(dmx_manager));
        connections.extend(self.dmx_inputs(dmx_manager));
        connections.extend(self.mqtt_connections(mqtt_manager));
        connections.extend(self.osc_connections(osc_manager));
        connections.extend(self.citp_connections(citp_manager));
        connections.extend(self.devices(device_manager));

        Ok(connections)
    }
}

impl ListConnectionsQuery {
    fn midi_connections(
        &self,
        midi_manager: &MidiConnectionManager,
    ) -> impl Iterator<Item = Connection> {
        midi_manager
            .list_available_devices()
            .into_iter()
            .map(|device| MidiView {
                name: device.name,
                device_profile: device.profile.as_ref().map(|profile| profile.id.clone()),
            })
            .map(Connection::from)
    }

    fn dmx_outputs<'a>(
        &self,
        dmx_manager: &'a DmxConnectionManager,
    ) -> impl Iterator<Item = Connection> + 'a {
        dmx_manager
            .list_outputs()
            .into_iter()
            .map(|(id, output)| DmxOutputView {
                output_id: id.clone(),
                name: output.name(),
                config: match output {
                    mizer_protocol_dmx::DmxOutputConnection::Artnet(config) => {
                        DmxOutputConfig::Artnet {
                            host: config.host.clone(),
                            port: config.port,
                        }
                    }
                    mizer_protocol_dmx::DmxOutputConnection::Sacn(config) => {
                        DmxOutputConfig::Sacn {
                            priority: config.priority,
                        }
                    }
                },
            })
            .map(Connection::from)
    }

    fn dmx_inputs<'a>(
        &self,
        dmx_manager: &'a DmxConnectionManager,
    ) -> impl Iterator<Item = Connection> + 'a {
        dmx_manager
            .list_inputs()
            .into_iter()
            .map(|(id, input)| DmxInputView {
                input_id: id.clone(),
                name: input.name(),
                config: match input {
                    mizer_protocol_dmx::DmxInputConnection::Artnet(config) => {
                        DmxInputConfig::Artnet {
                            host: config.config.host.clone(),
                            port: config.config.port,
                        }
                    }
                },
            })
            .map(Connection::from)
    }

    fn mqtt_connections<'a>(
        &self,
        mqtt_manager: &'a MqttConnectionManager,
    ) -> impl Iterator<Item = Connection> + 'a {
        mqtt_manager
            .list_connections()
            .into_iter()
            .map(|(id, connection)| MqttView {
                connection_id: id.clone(),
                name: connection.address.url.to_string(),
                url: connection.address.url.to_string(),
                username: connection.address.username.clone(),
                password: connection.address.password.clone(),
            })
            .map(Connection::from)
    }

    fn osc_connections<'a>(
        &self,
        osc_manager: &'a OscConnectionManager,
    ) -> impl Iterator<Item = Connection> + 'a {
        osc_manager
            .list_connections()
            .into_iter()
            .map(|(id, connection)| OscView {
                connection_id: id.clone(),
                name: connection.name.clone(),
                output_host: connection.address.output_host.to_string(),
                output_port: connection.address.output_port,
                input_port: connection.address.input_port,
            })
            .map(Connection::from)
    }

    fn citp_connections<'a>(
        &self,
        citp_manager: &'a CitpConnectionManager,
    ) -> impl Iterator<Item = Connection> + 'a {
        citp_manager
            .list_connections()
            .into_iter()
            .map(|handle| CitpView {
                connection_id: handle.id,
                name: handle.name.to_string(),
                kind: handle.kind,
                state: handle.state.clone(),
            })
            .map(Connection::from)
    }

    fn devices<'a>(
        &self,
        device_manager: &'a DeviceManager,
    ) -> impl Iterator<Item = Connection> + 'a {
        device_manager
            .current_devices()
            .into_iter()
            .map(Connection::from)
    }
}
