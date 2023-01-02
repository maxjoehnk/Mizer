use crate::{OscAddress, OscConnectionManager, OscProtocol};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct ConfigureOscConnectionCommand {
    pub connection_id: String,
    pub output_host: String,
    pub output_port: u16,
    pub input_port: u16,
}

impl<'a> Command<'a> for ConfigureOscConnectionCommand {
    type Dependencies = RefMut<OscConnectionManager>;
    type State = OscAddress;
    type Result = ();

    fn label(&self) -> String {
        format!("Configure MQTT Connection '{}'", self.connection_id)
    }

    fn apply(
        &self,
        osc_manager: &mut OscConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let address = OscAddress {
            protocol: OscProtocol::Udp,
            output_host: self.output_host.parse()?,
            output_port: self.output_port,
            input_port: self.input_port,
        };
        let previous_address = osc_manager.reconfigure_connection(&self.connection_id, address)?;

        Ok(((), previous_address))
    }

    fn revert(
        &self,
        osc_manager: &mut OscConnectionManager,
        previous_address: Self::State,
    ) -> anyhow::Result<()> {
        osc_manager.reconfigure_connection(&self.connection_id, previous_address)?;

        Ok(())
    }
}
