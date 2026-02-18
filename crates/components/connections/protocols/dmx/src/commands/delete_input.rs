use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};
use mizer_connection_contracts::{ConnectionStorage, DeletedConnectionHandle, StableConnectionId};

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteInputCommand {
    pub id: StableConnectionId,
}

impl<'a> Command<'a> for DeleteInputCommand {
    type Dependencies = RefMut<ConnectionStorage>;
    type State = DeletedConnectionHandle;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete DMX Connection '{}'", self.id)
    }

    fn apply(
        &self,
        dmx_manager: &mut ConnectionStorage,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let input = dmx_manager
            .delete_connection_by_stable(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown input {}", self.id))?;

        Ok(((), input))
    }

    fn revert(
        &self,
        storage: &mut ConnectionStorage,
        connection: Self::State,
    ) -> anyhow::Result<()> {
        storage.restore_connection(connection);

        Ok(())
    }
}
