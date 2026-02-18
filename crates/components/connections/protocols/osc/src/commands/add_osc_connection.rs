use crate::{OscAddress, OscConnection, OscProtocol};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};
use mizer_connection_contracts::{ConnectionId, ConnectionStorage};

#[derive(Debug, Deserialize, Serialize)]
pub struct AddOscConnectionCommand {
    pub name: String,
    pub output_host: String,
    pub output_port: u16,
    pub input_port: u16,
}

impl<'a> Command<'a> for AddOscConnectionCommand {
    type Dependencies = RefMut<ConnectionStorage>;
    type State = ConnectionId;
    type Result = ConnectionId;

    fn label(&self) -> String {
        format!(
            "Add OSC Connection {} ({}:{})",
            self.name, self.output_host, self.output_port
        )
    }

    fn apply(
        &self,
        storage: &mut ConnectionStorage,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let address = OscAddress {
            protocol: OscProtocol::Udp,
            output_host: self.output_host.parse()?,
            output_port: self.output_port,
            input_port: self.input_port,
        };
        let connection_id = storage.acquire_new_connection::<OscConnection>(address, Some(self.name.clone()))?;

        Ok((connection_id, connection_id))
    }

    fn revert(
        &self,
        storage: &mut ConnectionStorage,
        id: Self::State,
    ) -> anyhow::Result<()> {
        storage.delete_connection(&id);

        Ok(())
    }
}
