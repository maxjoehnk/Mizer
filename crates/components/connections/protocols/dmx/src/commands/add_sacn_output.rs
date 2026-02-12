use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};
use mizer_connection_contracts::{ConnectionId, ConnectionStorage};
use crate::SacnOutput;

#[derive(Debug, Deserialize, Serialize)]
pub struct AddSacnOutputCommand {
    pub name: String,
    pub priority: u8,
}

impl<'a> Command<'a> for AddSacnOutputCommand {
    type Dependencies = RefMut<ConnectionStorage>;
    type State = ConnectionId;
    type Result = ();

    fn label(&self) -> String {
        format!("Add Sacn Connection '{}'", self.name)
    }

    fn apply(
        &self,
        dmx_manager: &mut ConnectionStorage,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let connection_id = dmx_manager.acquire_new_connection::<SacnOutput>(Some(self.priority), Some(self.name.clone()))?;

        Ok(((), connection_id))
    }

    fn revert(&self, dmx_manager: &mut ConnectionStorage, connection_id: Self::State) -> anyhow::Result<()> {
        dmx_manager
            .delete_connection(&connection_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown output {connection_id}"))?;

        Ok(())
    }
}
