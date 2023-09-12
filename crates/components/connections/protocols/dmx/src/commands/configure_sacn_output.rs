use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};

use crate::{DmxConnectionManager, DmxOutputConnection, SacnOutput};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct ConfigureSacnOutputCommand {
    pub id: String,
    pub name: String,
    pub priority: u8,
}

impl<'a> Command<'a> for ConfigureSacnOutputCommand {
    type Dependencies = RefMut<DmxConnectionManager>;
    type State = SacnOutput;
    type Result = ();

    fn label(&self) -> String {
        format!("Configure Sacn Connection '{}'", self.id)
    }

    fn apply(
        &self,
        dmx_manager: &mut DmxConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let output = dmx_manager
            .get_output(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown output {}", self.id))?;
        if let DmxOutputConnection::Sacn(_) = output {
            let new_output = SacnOutput::new(Some(self.priority));
            let output = dmx_manager.delete_output(&self.id).unwrap();
            let output = if let DmxOutputConnection::Sacn(output) = output {
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
