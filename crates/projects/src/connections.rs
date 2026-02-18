use mizer_connections::ConnectionStorage;
use mizer_protocol_dmx::{ArtnetInput, ArtnetInputConfig, ArtnetOutput, SacnOutput};
use mizer_protocol_mqtt::MqttConnection;
use mizer_protocol_osc::OscConnection;
use crate::{ConnectionConfig, ConnectionTypes, Project, ProjectManagerMut};

impl ProjectManagerMut for ConnectionStorage {
    fn new_project(&mut self) {
        let _ =self.acquire_new_connection::<SacnOutput>(None, None);
    }

    fn load(&mut self, project: &Project) -> anyhow::Result<()> {
        profiling::scope!("ConnectionStorage::load");
        for connection in &project.connections {
            match &connection.config {
                ConnectionTypes::Sacn { priority } => {
                    self.add_connection::<SacnOutput>(connection.id.parse()?, *priority, connection.name.clone())?;
                }
                ConnectionTypes::ArtnetOutput { port, host } => {
                    self.add_connection::<ArtnetOutput>(connection.id.parse()?, (host.clone(), *port), connection.name.clone())?;
                },
                ConnectionTypes::ArtnetInput { port, host } => {
                    self.add_connection::<ArtnetInput>(connection.id.parse()?, ArtnetInputConfig::new(
                        *host, *port, connection.name.clone().unwrap_or_else(|| "Mizer".to_string()),
                    ), connection.name.clone())?;
                },
                ConnectionTypes::Osc(address) => {
                    self.add_connection::<OscConnection>(connection.id.parse()?, *address, connection.name.clone())?;
                }
                ConnectionTypes::Mqtt(address) => {
                    self.add_connection::<MqttConnection>(connection.id.parse()?, address.clone(), connection.name.clone())?;
                }
            }
        }

        Ok(())
    }

    fn save(&self, project: &mut Project) {
        for (id, name, output) in self.query::<ArtnetOutput>() {
            project.connections.push(ConnectionConfig {
                id: id.to_stable().to_string(),
                name: name.map(|n| n.to_string()),
                config: ConnectionTypes::ArtnetOutput { port: Some(output.port), host: output.host.clone() },
            });
        }
        for (id, name, output) in self.query::<SacnOutput>() {
            project.connections.push(ConnectionConfig {
                id: id.to_stable().to_string(),
                name: name.map(|n| n.to_string()),
                config: ConnectionTypes::Sacn { priority: Some(output.priority) },
            });
        }
        for (id, name, input) in self.query::<ArtnetInput>() {
            project.connections.push(ConnectionConfig {
                id: id.to_stable().to_string(),
                name: name.map(|n| n.to_string()),
                config: ConnectionTypes::ArtnetInput { port: Some(input.config.port), host: input.config.host },
            });
        }
        for (id, name, input) in self.query::<OscConnection>() {
            project.connections.push(ConnectionConfig {
                id: id.to_stable().to_string(),
                name: name.map(|n| n.to_string()),
                config: ConnectionTypes::Osc(input.address),
            });
        }
        for (id, name, connection) in self.query::<MqttConnection>() {
            project.connections.push(ConnectionConfig {
                id: id.to_stable().to_string(),
                name: name.map(|n| n.to_string()),
                config: ConnectionTypes::Mqtt(connection.address.clone()),
            });
        }
    }

    fn clear(&mut self) {
        self.delete_all_with::<ArtnetOutput>();
        self.delete_all_with::<ArtnetInput>();
        self.delete_all_with::<SacnOutput>();
        self.delete_all_with::<OscConnection>();
        self.delete_all_with::<MqttConnection>();
    }
}
