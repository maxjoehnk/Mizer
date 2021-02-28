pub use mizer_ports::{PortId, PortType};

pub use self::ports::*;
pub use self::context::*;
pub use self::path::*;
pub use self::introspection::*;

mod ports;
mod context;
mod path;
// TODO: pick better name
mod introspection;

pub trait PipelineNode : Send + Sync {
    fn details(&self) -> NodeDetails;

    fn introspect_port(&self, port: &PortId) -> PortMetadata {
        log::trace!("Returning default port metadata for port {}", port);
        Default::default()
    }

    // This can't be an associated function because it has to be object safe
    fn node_type(&self) -> NodeType;
}

pub trait ProcessingNode: PipelineNode + Clone {
    type State;

    fn details(&self) -> NodeDetails {
        PipelineNode::details(self)
    }

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()>;

    fn create_state(&self) -> Self::State;

    fn introspect_port(&self, port: &PortId) -> PortMetadata {
        PipelineNode::introspect_port(self, port)
    }
}
