use crate::proto::ports::*;
use crate::RuntimeApi;
use mizer_node_ports::{commands::*, queries::*, NodePortId};

#[derive(Clone)]
pub struct PortsHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> PortsHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_ports(&self) -> anyhow::Result<NodePorts> {
        let ports = self.runtime.execute_query(ListPortsQuery)?;
        let ports = ports.into_iter().map(NodePort::from).collect();

        Ok(NodePorts { ports })
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_port(&self, name: Option<String>) -> anyhow::Result<NodePort> {
        self.runtime
            .run_command(AddPortCommand { name })
            .map_err(|e| anyhow::anyhow!("Failed to add port: {}", e))
            .map(NodePort::from)
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn delete_port(&self, port_id: NodePortId) -> anyhow::Result<()> {
        self.runtime
            .run_command(DeletePortCommand { port_id })
            .map_err(|e| anyhow::anyhow!("Failed to delete port: {}", e))
    }
}
