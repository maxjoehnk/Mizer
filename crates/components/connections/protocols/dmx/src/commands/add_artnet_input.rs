use std::net::Ipv4Addr;

use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};

use crate::{ArtnetInput, DmxConnectionManager};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct AddArtnetInputCommand {
    pub name: String,
    pub host: Ipv4Addr,
    pub port: Option<u16>,
}

impl<'a> Command<'a> for AddArtnetInputCommand {
    type Dependencies = RefMut<DmxConnectionManager>;
    type State = String;
    type Result = ();

    fn label(&self) -> String {
        format!("Add Artnet Connection '{}'", self.name)
    }

    fn apply(
        &self,
        dmx_manager: &mut DmxConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let input = ArtnetInput::new(self.host.clone(), self.port, self.name.clone())?;
        let id = format!("dmx-input-{}", dmx_manager.list_inputs().len());
        dmx_manager.add_input(id.clone(), input);

        Ok(((), id))
    }

    fn revert(
        &self,
        dmx_manager: &mut DmxConnectionManager,
        id: Self::State,
    ) -> anyhow::Result<()> {
        dmx_manager
            .delete_input(&id)
            .ok_or_else(|| anyhow::anyhow!("Unknown input {id}"))?;

        Ok(())
    }
}
