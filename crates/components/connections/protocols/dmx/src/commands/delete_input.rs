use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};

use crate::{DmxConnectionManager, DmxInputConnection};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct DeleteInputCommand {
    pub id: String,
}

impl<'a> Command<'a> for DeleteInputCommand {
    type Dependencies = RefMut<DmxConnectionManager>;
    type State = DmxInputConnection;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete DMX Connection '{}'", self.id)
    }

    fn apply(
        &self,
        dmx_manager: &mut DmxConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let input = dmx_manager
            .delete_input(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown input {}", self.id))?;

        Ok(((), input))
    }

    fn revert(
        &self,
        dmx_manager: &mut DmxConnectionManager,
        input: Self::State,
    ) -> anyhow::Result<()> {
        dmx_manager.add_input(self.id.clone(), input);

        Ok(())
    }
}
