use crate::{NodePort, NodePortId, NodePortState};
use mizer_commander::{Command, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct AddPortCommand {
    pub name: Option<String>,
}

impl<'a> Command<'a> for AddPortCommand {
    type Dependencies = Ref<NodePortState>;
    type State = NodePortId;
    type Result = NodePort;

    fn label(&self) -> String {
        "Add Port".to_string()
    }

    fn apply(&self, port_state: &NodePortState) -> anyhow::Result<(Self::Result, Self::State)> {
        let port_id = port_state.add_port(self.name.clone());
        let port = port_state
            .get_port(&port_id)
            .ok_or_else(|| anyhow::anyhow!("Failed to retrieve port after adding it"))?;

        Ok((port, port_id))
    }

    fn revert(&self, port_state: &NodePortState, port_id: Self::State) -> anyhow::Result<()> {
        port_state.delete_port(port_id);

        Ok(())
    }
}
