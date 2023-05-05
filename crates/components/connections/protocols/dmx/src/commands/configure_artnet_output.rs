use crate::{ArtnetOutput, DmxConnection, DmxConnectionManager};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct ConfigureArtnetOutputCommand {
    pub id: String,
    pub name: String,
    pub host: String,
    pub port: Option<u16>,
}

impl<'a> Command<'a> for ConfigureArtnetOutputCommand {
    type Dependencies = RefMut<DmxConnectionManager>;
    type State = ArtnetOutput;
    type Result = ();

    fn label(&self) -> String {
        format!("Configure Artnet Connection '{}'", self.id)
    }

    fn apply(
        &self,
        dmx_manager: &mut DmxConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let output = dmx_manager
            .get_output(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown output {}", self.id))?;
        if let DmxConnection::Artnet(_) = output {
            let new_output = ArtnetOutput::new(self.host.clone(), self.port)?;
            let output = dmx_manager.delete_output(&self.id).unwrap();
            let output = if let DmxConnection::Artnet(output) = output {
                output
            } else {
                unreachable!()
            };
            dmx_manager.add_output(self.name.clone(), new_output);

            Ok(((), output))
        } else {
            anyhow::bail!("Invalid output type");
        }
    }

    fn revert(
        &self,
        dmx_manager: &mut DmxConnectionManager,
        output: Self::State,
    ) -> anyhow::Result<()> {
        dmx_manager
            .delete_output(&self.name)
            .ok_or_else(|| anyhow::anyhow!("Unknown output {}", self.id))?;
        dmx_manager.add_output(self.id.clone(), output);

        Ok(())
    }
}
