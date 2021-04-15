use downcast::*;

pub use mizer_injector::Injector;
pub use mizer_ports::{PortId, PortType, Color};

pub use self::context::*;
pub use self::introspection::*;
pub use self::path::*;
pub use self::ports::*;

mod context;
mod path;
mod ports;
// TODO: pick better name
mod introspection;

pub trait PipelineNode: Send + Sync + Any {
    fn details(&self) -> NodeDetails;

    fn introspect_port(&self, port: &PortId) -> Option<PortMetadata> {
        log::trace!("Returning default port metadata for port {}", port);
        Default::default()
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        log::trace!("Returning default ports");
        Default::default()
    }

    // This can't be an associated function because it has to be object safe
    fn node_type(&self) -> NodeType;
}

downcast!(PipelineNode);

pub trait ProcessingNode: PipelineNode + Clone + Default + std::fmt::Debug {
    type State;

    fn details(&self) -> NodeDetails {
        PipelineNode::details(self)
    }

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()>;

    fn create_state(&self) -> Self::State;
}
