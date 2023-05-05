use crate::{OscAddress, OscConnectionManager, OscProtocol};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct AddOscConnectionCommand {
    pub output_host: String,
    pub output_port: u16,
    pub input_port: u16,
}

impl<'a> Command<'a> for AddOscConnectionCommand {
    type Dependencies = RefMut<OscConnectionManager>;
    type State = String;
    type Result = String;

    fn label(&self) -> String {
        format!(
            "Add OSC Connection '{}:{}'",
            self.output_host, self.output_port
        )
    }

    fn apply(
        &self,
        osc_manager: &mut OscConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let id = osc_manager.list_connections().len();
        let id = format!("osc-{}", id);
        let address = OscAddress {
            protocol: OscProtocol::Udp,
            output_host: self.output_host.parse()?,
            output_port: self.output_port,
            input_port: self.input_port,
        };
        osc_manager.add_connection(id.clone(), address)?;

        Ok((id.clone(), id))
    }

    fn revert(
        &self,
        osc_manager: &mut OscConnectionManager,
        id: Self::State,
    ) -> anyhow::Result<()> {
        osc_manager.delete_connection(&id);

        Ok(())
    }
}
