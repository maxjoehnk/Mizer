use mizer_commander::{Command, RefMut};
use mizer_node::{NodeLink, NodePath};
use serde::{Deserialize, Serialize};
use crate::Pipeline;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DisconnectPortsCommand {
    pub path: NodePath,
}

impl<'a> Command<'a> for DisconnectPortsCommand {
    type Dependencies = RefMut<Pipeline>;
    type State = Vec<NodeLink>;
    type Result = ();

    fn label(&self) -> String {
        format!("Disconnect Ports of '{}'", self.path)
    }

    fn apply(
        &self,
        pipeline: &mut Pipeline,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let old_links = pipeline.remove_links_from_node(&self.path);

        Ok(((), old_links))
    }

    fn revert(
        &self,
        pipeline: &mut Pipeline,
        state: Self::State,
    ) -> anyhow::Result<()> {
        for link in state {
            pipeline.add_link(link)?;
        }

        Ok(())
    }
}
