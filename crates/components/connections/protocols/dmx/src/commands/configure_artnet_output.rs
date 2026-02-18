use crate::ArtnetOutput;
use mizer_commander::{Command, RefMut};
use mizer_connection_contracts::{ConnectionStorage, StableConnectionId};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct ConfigureArtnetOutputCommand {
    pub id: StableConnectionId,
    pub name: String,
    pub host: String,
    pub port: Option<u16>,
}

impl<'a> Command<'a> for ConfigureArtnetOutputCommand {
    type Dependencies = RefMut<ConnectionStorage>;
    type State = (String, u16);
    type Result = ();

    fn label(&self) -> String {
        format!("Configure Artnet Connection '{}'", self.id)
    }

    fn apply(
        &self,
        storage: &mut ConnectionStorage,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let connection = storage
            .get_connection_by_stable_mut::<ArtnetOutput>(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown output {}", self.id))?;

        let state = connection.reconfigure(self.host.clone(), self.port);
        // TODO: revert new name
        storage.rename_connection_by_stable(&self.id, self.name.clone());

        Ok(((), state))
    }

    fn revert(&self, storage: &mut ConnectionStorage, output: Self::State) -> anyhow::Result<()> {
        let connection = storage
            .get_connection_by_stable_mut::<ArtnetOutput>(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown output {}", self.id))?;
        connection.reconfigure(output.0, Some(output.1));

        Ok(())
    }
}
