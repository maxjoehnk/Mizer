use crate::{OscAddress, OscConnectionManager};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteOscConnectionCommand {
    pub id: String,
}

impl<'a> Command<'a> for DeleteOscConnectionCommand {
    type Dependencies = RefMut<OscConnectionManager>;
    type State = (String, OscAddress);
    type Result = ();

    fn label(&self) -> String {
        format!("Delete OSC Connection '{}'", self.id)
    }

    fn apply(
        &self,
        osc_manager: &mut OscConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let config = osc_manager
            .delete_connection(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown osc connection"))?;

        Ok(((), config))
    }

    fn revert(
        &self,
        osc_manager: &mut OscConnectionManager,
        (name, address): Self::State,
    ) -> anyhow::Result<()> {
        osc_manager.add_connection(self.id.clone(), name, address)?;

        Ok(())
    }
}
