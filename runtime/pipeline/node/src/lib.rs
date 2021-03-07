pub use mizer_ports::{PortId, PortType};
pub use mizer_injector::Injector;

pub use self::context::*;
pub use self::introspection::*;
pub use self::path::*;
pub use self::ports::*;

mod context;
mod path;
mod ports;
// TODO: pick better name
mod introspection;

pub trait PipelineNode: Send + Sync {
    fn details(&self) -> NodeDetails;

    fn introspect_port(&self, port: &PortId, injector: &Injector) -> Option<PortMetadata> {
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

    fn introspect_port(&self, port: &PortId, injector: &Injector) -> Option<PortMetadata> {
        PipelineNode::introspect_port(self, port, injector)
    }
}
