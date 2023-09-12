use crate::{ArtnetInput, DmxConnectionManager};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};
use std::net::Ipv4Addr;

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct AddArtnetInputCommand {
    pub name: String,
    pub host: Ipv4Addr,
    pub port: Option<u16>,
}

impl<'a> Command<'a> for AddArtnetInputCommand {
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
        let input = ArtnetInput::new(self.host.clone(), self.port)?;
        dmx_manager.add_input(self.name.clone(), input);

        Ok(((), ()))
    }

    fn revert(&self, dmx_manager: &mut DmxConnectionManager, _: Self::State) -> anyhow::Result<()> {
        dmx_manager
            .delete_input(&self.name)
            .ok_or_else(|| anyhow::anyhow!("Unknown input {}", self.name))?;

        Ok(())
    }
}
