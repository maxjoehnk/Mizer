use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};
use mizer_connection_contracts::{ConnectionStorage, DeletedConnectionHandle, StableConnectionId};

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteOscConnectionCommand {
    pub id: StableConnectionId,
}

impl<'a> Command<'a> for DeleteOscConnectionCommand {
    type Dependencies = RefMut<ConnectionStorage>;
    type State = DeletedConnectionHandle;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete OSC Connection '{}'", self.id)
    }

    fn apply(
        &self,
        osc_manager: &mut ConnectionStorage,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let handle = osc_manager
            .delete_connection_by_stable(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown osc connection"))?;

        Ok(((), handle))
    }

    fn revert(
        &self,
        osc_manager: &mut ConnectionStorage,
        state: Self::State,
    ) -> anyhow::Result<()> {
        osc_manager.restore_connection(state);

        Ok(())
    }
}
