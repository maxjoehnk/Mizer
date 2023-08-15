use mizer_protocol_dmx::{
    ArtnetOutput, DmxConnection, DmxConnectionManager, DmxOutput, SacnOutput,
};
use mizer_protocol_mqtt::MqttConnectionManager;
use mizer_protocol_osc::OscConnectionManager;

use crate::{ConnectionConfig, ConnectionTypes, Project, ProjectManagerMut};

impl ProjectManagerMut for DmxConnectionManager {
    fn new_project(&mut self) {
        self.add_output("dmx-0".into(), SacnOutput::new(None));
    }

    fn load(&mut self, project: &Project) -> anyhow::Result<()> {
        profiling::scope!("DmxConnectionManager::load");
        for connection in &project.connections {
            match &connection.config {
                ConnectionTypes::Sacn { priority } => {
                    self.add_output(connection.id.clone(), SacnOutput::new(*priority))
                }
                ConnectionTypes::Artnet { port, host } => self.add_output(
                    connection.id.clone(),
                    ArtnetOutput::new(host.clone(), *port)?,
                ),
                _ => {}
            }
        }

        Ok(())
    }

    fn save(&self, project: &mut Project) {
        profiling::scope!("DmxConnectionManager::save");
        for (id, output) in self.list_outputs() {
            project.connections.push(ConnectionConfig {
                id: id.clone(),
                name: output.name(),
                config: get_config(output),
            });
        }
    }

    fn clear(&mut self) {
        self.clear();
    }
}

fn get_config(connection: &DmxConnection) -> ConnectionTypes {
    match connection {
        DmxConnection::Artnet(artnet) => ConnectionTypes::Artnet {
            host: artnet.host.clone(),
            port: artnet.port.into(),
        },
        DmxConnection::Sacn(sacn) => ConnectionTypes::Sacn {
            priority: Some(sacn.priority),
        },
    }
}

impl ProjectManagerMut for MqttConnectionManager {
    fn load(&mut self, project: &Project) -> anyhow::Result<()> {
        profiling::scope!("MqttConnectionManager::load");
        for connection in &project.connections {
            if let ConnectionTypes::Mqtt(ref address) = connection.config {
                self.add_connection(connection.id.clone(), address.clone())?;
            }
        }

        Ok(())
    }

    fn save(&self, project: &mut Project) {
        profiling::scope!("MqttConnectionManager::save");
        for (id, connection) in self.list_connections() {
            project.connections.push(ConnectionConfig {
                id: id.clone(),
                name: Default::default(),
                config: ConnectionTypes::Mqtt(connection.address.clone()),
            });
        }
    }

    fn clear(&mut self) {
        self.clear();
    }
}

impl ProjectManagerMut for OscConnectionManager {
    fn load(&mut self, project: &Project) -> anyhow::Result<()> {
        profiling::scope!("OscConnectionManager::load");
        for connection in &project.connections {
            if let ConnectionTypes::Osc(ref address) = connection.config {
                self.add_connection(connection.id.clone(), *address)?;
            }
        }

        Ok(())
    }

    fn save(&self, project: &mut Project) {
        profiling::scope!("OscConnectionManager::save");
        for (id, connection) in self.list_connections() {
            project.connections.push(ConnectionConfig {
                id: id.clone(),
                name: Default::default(),
                config: ConnectionTypes::Osc(connection.address),
            });
        }
    }

    fn clear(&mut self) {
        self.clear();
    }
}
