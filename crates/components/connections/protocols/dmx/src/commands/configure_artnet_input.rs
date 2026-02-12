use std::net::Ipv4Addr;

use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};
use mizer_connection_contracts::{ConnectionStorage, StableConnectionId};
use crate::{ArtnetInput, ArtnetInputConfig};

#[derive(Debug, Deserialize, Serialize)]
pub struct ConfigureArtnetInputCommand {
    pub id: StableConnectionId,
    pub name: String,
    pub host: Ipv4Addr,
    pub port: Option<u16>,
}

impl<'a> Command<'a> for ConfigureArtnetInputCommand {
    type Dependencies = RefMut<ConnectionStorage>;
    type State = ArtnetInputConfig;
    type Result = ();

    fn label(&self) -> String {
        format!("Configure Artnet Connection '{}'", self.name)
    }

    fn apply(
        &self,
        storage: &mut ConnectionStorage,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let input = storage.get_connection_by_stable_mut::<ArtnetInput>(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown input {}", self.id))?;
        let previous_config = input.reconfigure(ArtnetInputConfig::new(
            self.host,
            self.port,
            self.name.clone(),
        ))?;
        // TODO: revert new name
        storage.rename_connection_by_stable(&self.id, self.name.clone());

        Ok(((), previous_config))
    }

    fn revert(
        &self,
        storage: &mut ConnectionStorage,
        config: Self::State,
    ) -> anyhow::Result<()> {
        let input = storage.get_connection_by_stable_mut::<ArtnetInput>(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown input {}", self.id))?;
        input.reconfigure(config)?;

        Ok(())
    }
}
