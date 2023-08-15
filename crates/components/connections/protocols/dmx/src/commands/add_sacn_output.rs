use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};

use crate::{DmxConnectionManager, SacnOutput};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct AddSacnOutputCommand {
    pub name: String,
    pub priority: u8,
}

impl<'a> Command<'a> for AddSacnOutputCommand {
    type Dependencies = RefMut<DmxConnectionManager>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!("Add Artnet Connection '{}'", self.name)
    }

    fn apply(
        &self,
        dmx_manager: &mut DmxConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let output = SacnOutput::new(Some(self.priority));
        dmx_manager.add_output(self.name.clone(), output);

        Ok(((), ()))
    }

    fn revert(&self, dmx_manager: &mut DmxConnectionManager, _: Self::State) -> anyhow::Result<()> {
        dmx_manager
            .delete_output(&self.name)
            .ok_or_else(|| anyhow::anyhow!("Unknown output {}", self.name))?;

        Ok(())
    }
}
