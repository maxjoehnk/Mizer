use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};
use mizer_connection_contracts::{ConnectionStorage, DeletedConnectionHandle, StableConnectionId};

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteMqttConnectionCommand {
    pub id: StableConnectionId,
}

impl<'a> Command<'a> for DeleteMqttConnectionCommand {
    type Dependencies = RefMut<ConnectionStorage>;
    type State = DeletedConnectionHandle;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete MQTT Connection '{}'", self.id)
    }

    fn apply(
        &self,
        connection_storage: &mut ConnectionStorage,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let handle = connection_storage.delete_connection_by_stable(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Connection not found"))?;

        Ok(((), handle))
    }

    fn revert(
        &self,
        connection_storage: &mut ConnectionStorage,
        handle: Self::State,
    ) -> anyhow::Result<()> {
        connection_storage.restore_connection(handle);

        Ok(())
    }
}
