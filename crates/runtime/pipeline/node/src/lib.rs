use std::fmt::Debug;

use downcast::*;

pub use mizer_debug_ui::DebugUiDrawHandle;
pub use mizer_injector::Injector;
pub use mizer_ports::{port_types, Color, PortId, PortType};

pub use self::context::*;
pub use self::introspection::*;
pub use self::path::*;
pub use self::ports::*;
pub use self::preview::*;
pub use self::settings::*;

mod context;
mod path;
mod ports;
// TODO: pick better name
mod introspection;
mod preview;
mod settings;

pub mod edge;
mod macros;
#[cfg(feature = "test")]
pub mod mocks;

pub trait PipelineNode: ConfigurableNode + Debug + Send + Sync + Any {
    fn details(&self) -> NodeDetails;

    #[allow(unused_variables)]
    fn display_name(&self, injector: &Injector) -> String {
        self.details().node_type_name
    }

    #[allow(unused_variables)]
    fn list_ports(&self, injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        tracing::trace!("Returning default ports");
        Default::default()
    }

    // This can't be an associated function because it has to be object safe
    fn node_type(&self) -> NodeType;
}

pub trait ConfigurableNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update_fallback!(setting)
    }
}

downcast!(dyn PipelineNode);

pub trait ProcessingNode: PipelineNode + Clone + Default + Debug {
    type State;

    fn details(&self) -> NodeDetails {
        PipelineNode::details(self)
    }

    #[allow(unused_variables)]
    fn pre_process(
        &self,
        context: &impl NodeContext,
        state: &mut Self::State,
    ) -> anyhow::Result<()> {
        Ok(())
    }

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()>;

    #[allow(unused_variables)]
    fn post_process(
        &self,
        context: &impl NodeContext,
        state: &mut Self::State,
    ) -> anyhow::Result<()> {
        Ok(())
    }

    fn create_state(&self) -> Self::State;

    fn debug_ui<'a>(&self, _ui: &mut impl DebugUiDrawHandle<'a>, _state: &Self::State) {}
}
