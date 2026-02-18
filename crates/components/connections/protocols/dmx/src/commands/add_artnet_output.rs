use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};
use mizer_connection_contracts::{ConnectionId, ConnectionStorage};
use crate::ArtnetOutput;

#[derive(Debug, Deserialize, Serialize)]
pub struct AddArtnetOutputCommand {
    pub name: String,
    pub host: String,
    pub port: Option<u16>,
}

impl<'a> Command<'a> for AddArtnetOutputCommand {
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
        let connection_id = connection_storage.acquire_new_connection::<ArtnetOutput>((self.host.clone(), self.port), Some(self.name.clone()))?;

        Ok(((), connection_id))
    }

    fn revert(&self, storage: &mut ConnectionStorage, id: Self::State) -> anyhow::Result<()> {
        storage
            .delete_connection(&id)
            .ok_or_else(|| anyhow::anyhow!("Unknown output {id}"))?;

        Ok(())
    }
}
