use crate::{NodePort, NodePortState};
use mizer_commander::{Query, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListPortsQuery;

impl<'a> Query<'a> for ListPortsQuery {
    type Dependencies = Ref<NodePortState>;
    type Result = Vec<NodePort>;

    fn query(&self, ports_state: &NodePortState) -> anyhow::Result<Self::Result> {
        Ok(ports_state.list_ports())
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
