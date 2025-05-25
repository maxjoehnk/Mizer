use bon::__::IsUnset;
use self::worker_node_definition_builder::SetWorkerType;
pub use self::audio::*;

mod audio;

pub enum WorkerNode {
    Audio(Box<dyn AudioWorkerNode>),
}

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
pub enum WorkerNodeType {
    Audio,
}

#[derive(bon::Builder, PartialEq, Eq, Hash)]
#[builder(const)]
pub struct WorkerNodeDefinition {
    // #[builder(field)]
    // pub graph_ports: Vec<WorkerGraphPort>,
    // #[builder(field)]
    // pub transfer_ports: Vec<WorkerNodePort>,
    worker_type: WorkerNodeType,
}

impl<S: worker_node_definition_builder::State> WorkerNodeDefinitionBuilder<S> {
    pub const fn audio(self) -> WorkerNodeDefinitionBuilder<SetWorkerType<S>>
    where
        S::WorkerType: IsUnset
    {
        self.worker_type(WorkerNodeType::Audio)
    }
}

// impl WorkerNodeDefinitionBuilder {
//     pub const fn graph_port(mut self, port: WorkerGraphPort) -> Self {
//         self.graph_ports.push(port);
//         self
//     }
//
//     pub const fn transfer_port(mut self, port: WorkerNodePort) -> Self {
//         self.transfer_ports.push(port);
//         self
//     }
// }

#[derive(Debug, Copy, Clone, PartialEq, Eq, Hash)]
pub struct WorkerPortId(pub &'static str);

// Define a port between multiple nodes in the given graph
pub struct WorkerGraphPort {}

// Define a buffered port between the owning node and the worker
pub struct WorkerNodePort {}
