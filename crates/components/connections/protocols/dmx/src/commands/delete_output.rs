use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};
use mizer_connection_contracts::{ConnectionStorage, DeletedConnectionHandle, StableConnectionId};

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteOutputCommand {
    pub id: StableConnectionId,
}

impl<'a> Command<'a> for DeleteOutputCommand {
    type Dependencies = RefMut<ConnectionStorage>;
    type State = DeletedConnectionHandle;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete DMX Connection '{}'", self.id)
    }

    fn apply(
        &self,
        storage: &mut ConnectionStorage,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let output = storage.delete_connection_by_stable(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown output {}", self.id))?;

        Ok(((), output))
    }

    fn revert(
        &self,
        storage: &mut ConnectionStorage,
        state: Self::State,
    ) -> anyhow::Result<()> {
        storage.restore_connection(state);

        Ok(())
    }
}
