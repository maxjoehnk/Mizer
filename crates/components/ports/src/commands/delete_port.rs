use crate::{NodePort, NodePortId, NodePortState};
use mizer_commander::{Command, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct DeletePortCommand {
    pub port_id: NodePortId,
}

impl<'a> Command<'a> for DeletePortCommand {
    type Dependencies = Ref<NodePortState>;
    type State = NodePort;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete {}", self.port_id)
    }

    fn apply(&self, port_state: &NodePortState) -> anyhow::Result<(Self::Result, Self::State)> {
        let port = port_state.delete_port(self.port_id);
        let port = port.ok_or_else(|| anyhow::anyhow!("{} not found", self.port_id))?;

        Ok(((), port))
    }

    fn revert(&self, port_state: &NodePortState, port: Self::State) -> anyhow::Result<()> {
        port_state.insert_port(self.port_id, port);

        Ok(())
    }
}
