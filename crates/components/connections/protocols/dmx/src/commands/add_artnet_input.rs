use std::net::Ipv4Addr;

use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};
use mizer_connection_contracts::{ConnectionId, ConnectionStorage};
use crate::{ArtnetInput, ArtnetInputConfig};

#[derive(Debug, Deserialize, Serialize)]
pub struct AddArtnetInputCommand {
    pub name: String,
    pub host: Ipv4Addr,
    pub port: Option<u16>,
}

impl<'a> Command<'a> for AddArtnetInputCommand {
    type Dependencies = RefMut<ConnectionStorage>;
    type State = ConnectionId;
    type Result = ();

    fn label(&self) -> String {
        format!("Add Artnet Connection '{}'", self.name)
    }

    fn apply(
        &self,
        connection_storage: &mut ConnectionStorage,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let id = connection_storage.acquire_new_connection::<ArtnetInput>(ArtnetInputConfig {
            name: self.name.clone(),
            host: self.host,
            port: self.port.unwrap_or(6454),
        }, Some(self.name.clone()))?;

        Ok(((), id))
    }

    fn revert(
        &self,
        connection_storage: &mut ConnectionStorage,
        id: Self::State,
    ) -> anyhow::Result<()> {
        connection_storage.delete_connection(&id).ok_or_else(|| anyhow::anyhow!("Unknown input {id}"))?;

        Ok(())
    }
}
