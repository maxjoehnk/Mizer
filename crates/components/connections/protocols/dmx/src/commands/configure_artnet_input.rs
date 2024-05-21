use std::net::Ipv4Addr;

use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};

use crate::{ArtnetInputConfig, DmxConnectionManager, DmxInputConnection};

#[derive(Debug, Deserialize, Serialize)]
pub struct ConfigureArtnetInputCommand {
    pub id: String,
    pub name: String,
    pub host: Ipv4Addr,
    pub port: Option<u16>,
}

impl<'a> Command<'a> for ConfigureArtnetInputCommand {
    type Dependencies = RefMut<DmxConnectionManager>;
    type State = ArtnetInputConfig;
    type Result = ();

    fn label(&self) -> String {
        format!("Configure Artnet Connection '{}'", self.name)
    }

    fn apply(
        &self,
        dmx_manager: &mut DmxConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let input = dmx_manager
            .get_input_mut(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown input {}", self.id))?;
        let DmxInputConnection::Artnet(input) = input;
        let previous_config = input.reconfigure(ArtnetInputConfig::new(
            self.host,
            self.port,
            self.name.clone(),
        ))?;

        Ok(((), previous_config))
    }

    fn revert(
        &self,
        dmx_manager: &mut DmxConnectionManager,
        config: Self::State,
    ) -> anyhow::Result<()> {
        let input = dmx_manager
            .get_input_mut(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown input {}", self.id))?;
        let DmxInputConnection::Artnet(input) = input;
        input.reconfigure(config)?;

        Ok(())
    }
}
