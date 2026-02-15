use crate::{OscAddress, OscConnection, OscProtocol};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};
use mizer_connection_contracts::{ConnectionStorage, Name, StableConnectionId};

#[derive(Debug, Deserialize, Serialize)]
pub struct ConfigureOscConnectionCommand {
    pub connection_id: StableConnectionId,
    pub name: String,
    pub output_host: String,
    pub output_port: u16,
    pub input_port: u16,
}

impl<'a> Command<'a> for ConfigureOscConnectionCommand {
    type Dependencies = RefMut<ConnectionStorage>;
    type State = (Option<Name>, OscAddress);
    type Result = ();

    fn label(&self) -> String {
        format!("Configure MQTT Connection '{}'", self.connection_id)
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
        let connection = storage.get_connection_by_stable_mut::<OscConnection>(&self.connection_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown osc connection"))?;
        let previous_address = connection.reconfigure(address)?;
        let previous_name = storage.rename_connection_by_stable(&self.connection_id, self.name.clone());

        Ok(((), (previous_name, previous_address)))
    }

    fn revert(
        &self,
        storage: &mut ConnectionStorage,
        (previous_name, previous_address): Self::State,
    ) -> anyhow::Result<()> {
        let connection = storage.get_connection_by_stable_mut::<OscConnection>(&self.connection_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown osc connection"))?;
        connection.reconfigure(previous_address)?;
        if let Some(name) = previous_name {
            storage.rename_connection_by_stable(&self.connection_id, name);
        }

        Ok(())
    }
}
