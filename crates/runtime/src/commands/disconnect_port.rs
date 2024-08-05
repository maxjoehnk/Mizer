use serde::{Deserialize, Serialize};

use crate::Pipeline;
use mizer_commander::{Command, RefMut};
use mizer_node::{NodeLink, NodePath};
use mizer_ports::PortId;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DisconnectPortCommand {
    pub path: NodePath,
    pub port: PortId,
}

impl<'a> Command<'a> for DisconnectPortCommand {
    type Dependencies = RefMut<Pipeline>;
    type State = Vec<NodeLink>;
    type Result = ();

    fn label(&self) -> String {
        format!("Disconnect Port {} of '{}'", self.port, self.path)
    }

    fn apply(&self, pipeline: &mut Pipeline) -> anyhow::Result<(Self::Result, Self::State)> {
        let old_links = pipeline.remove_links_from_port(&self.path, &self.port);

        Ok(((), old_links))
    }

    fn revert(&self, pipeline: &mut Pipeline, state: Self::State) -> anyhow::Result<()> {
        for link in state {
            pipeline.add_link(link)?;
        }

        Ok(())
    }
}
