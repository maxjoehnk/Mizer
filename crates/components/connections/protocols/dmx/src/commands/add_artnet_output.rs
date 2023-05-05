use crate::{ArtnetOutput, DmxConnectionManager};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct AddArtnetOutputCommand {
    pub name: String,
    pub host: String,
    pub port: Option<u16>,
}

impl<'a> Command<'a> for AddArtnetOutputCommand {
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
        let output = ArtnetOutput::new(self.host.clone(), self.port)?;
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
