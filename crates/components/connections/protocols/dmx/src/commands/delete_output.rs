use crate::{DmxConnectionManager, DmxOutputConnection};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteOutputCommand {
    pub name: String,
}

impl<'a> Command<'a> for DeleteOutputCommand {
    type Dependencies = RefMut<DmxConnectionManager>;
    type State = DmxOutputConnection;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete DMX Connection '{}'", self.name)
    }

    fn apply(
        &self,
        dmx_manager: &mut DmxConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let output = dmx_manager
            .delete_output(&self.name)
            .ok_or_else(|| anyhow::anyhow!("Unknown output {}", self.name))?;

        Ok(((), output))
    }

    fn revert(
        &self,
        dmx_manager: &mut DmxConnectionManager,
        output: Self::State,
    ) -> anyhow::Result<()> {
        dmx_manager.add_output(self.name.clone(), output);

        Ok(())
    }
}
