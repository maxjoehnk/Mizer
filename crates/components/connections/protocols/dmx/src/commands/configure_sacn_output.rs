use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};
use mizer_connection_contracts::{ConnectionStorage, StableConnectionId};
use crate::{SacnOutput};

#[derive(Debug, Deserialize, Serialize)]
pub struct ConfigureSacnOutputCommand {
    pub id: StableConnectionId,
    pub name: String,
    pub priority: u8,
}

impl<'a> Command<'a> for ConfigureSacnOutputCommand {
    type Dependencies = RefMut<ConnectionStorage>;
    type State = u8;
    type Result = ();

    fn label(&self) -> String {
        format!("Configure Sacn Connection '{}'", self.id)
    }

    fn apply(
        &self,
        storage: &mut ConnectionStorage,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let connection = storage
            .get_connection_by_stable_mut::<SacnOutput>(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown output {}", self.id))?;

        let state = connection.reconfigure(self.priority);
        // TODO: revert new name
        storage.rename_connection_by_stable(&self.id, self.name.clone());

        Ok(((), state))
    }

    fn revert(
        &self,
        storage: &mut ConnectionStorage,
        state: Self::State,
    ) -> anyhow::Result<()> {
        let connection = storage
            .get_connection_by_stable_mut::<SacnOutput>(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown output {}", self.id))?;
        connection.reconfigure(state);

        Ok(())
    }
}
