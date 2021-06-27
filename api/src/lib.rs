#[macro_use]
extern crate serde;

use mizer_runtime::NodeDescriptor;
use mizer_node::{NodeLink, NodeType, NodeDesigner, NodePath, PortId};
use mizer_layouts::Layout;
use mizer_nodes::Node;
use mizer_clock::{ClockState, ClockSnapshot};

pub mod handlers;
pub mod models;
mod mappings;

pub trait RuntimeApi : Clone + Send + Sync {
    fn nodes(&self) -> Vec<NodeDescriptor>;

    fn links(&self) -> Vec<NodeLink>;

    fn layouts(&self) -> Vec<Layout>;

    fn add_layout(&self, name: String);

    fn remove_layout(&self, id: String);

    fn rename_layout(&self, id: String, name: String);

    fn add_node(
        &self,
        node_type: NodeType,
        designer: NodeDesigner,
    ) -> anyhow::Result<NodeDescriptor<'_>>;

    fn add_node_for_fixture(&self, fixture_id: u32) -> anyhow::Result<NodeDescriptor<'_>>;

    fn write_node_port(
        &self,
        node_path: NodePath,
        port: PortId,
        value: f64,
    ) -> anyhow::Result<()>;

    fn link_nodes(&self, link: NodeLink) -> anyhow::Result<()>;

    fn get_node_history(&self, node: NodePath) -> anyhow::Result<Vec<f64>>;

    fn update_node(&self, path: NodePath, config: Node) -> anyhow::Result<()>;

    fn set_clock_state(&self, state: ClockState) -> anyhow::Result<()>;

    fn save_project(&self) -> anyhow::Result<()>;

    fn transport_recv(&self) -> flume::Receiver<ClockSnapshot>;
}
