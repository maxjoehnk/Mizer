use crate::{DmxConnectionManager, DmxInputConnection};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct DeleteInputCommand {
    pub name: String,
}

impl<'a> Command<'a> for DeleteInputCommand {
    type Dependencies = RefMut<DmxConnectionManager>;
    type State = DmxInputConnection;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete DMX Connection '{}'", self.name)
    }

    fn apply(
        &self,
        dmx_manager: &mut DmxConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let input = dmx_manager
            .delete_input(&self.name)
            .ok_or_else(|| anyhow::anyhow!("Unknown input {}", self.name))?;

        Ok(((), input))
    }

    fn revert(
        &self,
        dmx_manager: &mut DmxConnectionManager,
        input: Self::State,
    ) -> anyhow::Result<()> {
        dmx_manager.add_input(self.name.clone(), input);

        Ok(())
    }
}
