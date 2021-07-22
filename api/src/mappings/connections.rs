use crate::models::connections::DmxConnection;
use crate::models::{Connection, Connection_oneof_connection, MidiConnection};

impl From<mizer_connections::Connection> for Connection {
    fn from(connection: mizer_connections::Connection) -> Self {
        Self {
            name: connection.name(),
            connection: Some(connection.into()),
            ..Default::default()
        }
    }
}

impl From<mizer_connections::Connection> for Connection_oneof_connection {
    fn from(connection: mizer_connections::Connection) -> Self {
        use mizer_connections::Connection::*;
        match connection {
            Midi(_) => Self::midi(MidiConnection::default()),
            Dmx(view) => Self::dmx(DmxConnection {
                outputId: view.output_id,
                ..Default::default()
            }),
        }
    }
}
