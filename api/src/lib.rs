use std::collections::HashMap;

use mizer_clock::{ClockSnapshot, ClockState};
use mizer_connections::Connection;
use mizer_layouts::{ControlConfig, Layout};
use mizer_layouts::{ControlPosition, ControlSize};
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodePosition, NodeType, PortId};
use mizer_nodes::Node;
use mizer_runtime::NodeDescriptor;
use pinboard::NonEmptyPinboard;
use std::sync::Arc;

pub mod handlers;
mod mappings;
pub mod models;

pub trait RuntimeApi: Clone + Send + Sync {
    fn nodes(&self) -> Vec<NodeDescriptor>;

    fn links(&self) -> Vec<NodeLink>;

    fn layouts(&self) -> Vec<Layout>;

    fn add_layout(&self, name: String);

    fn remove_layout(&self, id: String);

    fn rename_layout(&self, id: String, name: String);

    fn add_layout_control(
        &self,
        layout_id: String,
        path: NodePath,
        position: ControlPosition,
        size: ControlSize,
    );
    fn delete_layout_control(&self, layout_id: String, control_id: String);
    fn update_layout_control<F: FnOnce(&mut ControlConfig)>(
        &self,
        layout_id: String,
        control_id: String,
        update: F,
    );

    fn add_node(
        &self,
        node_type: NodeType,
        designer: NodeDesigner,
    ) -> anyhow::Result<NodeDescriptor<'_>>;

    fn add_node_for_fixture(&self, fixture_id: u32) -> anyhow::Result<NodeDescriptor<'_>>;
    fn add_node_for_sequence(&self, sequence_id: u32) -> anyhow::Result<NodeDescriptor<'_>>;

    fn write_node_port(&self, node_path: NodePath, port: PortId, value: f64) -> anyhow::Result<()>;

    fn link_nodes(&self, link: NodeLink) -> anyhow::Result<()>;

    fn get_node_history_ref(
        &self,
        node: NodePath,
    ) -> anyhow::Result<Option<Arc<NonEmptyPinboard<Vec<f64>>>>>;

    fn get_node(&self, path: &NodePath) -> Option<NodeDescriptor>;
    fn update_node(&self, path: NodePath, config: Node) -> anyhow::Result<()>;
    fn update_node_position(&self, path: NodePath, position: NodePosition) -> anyhow::Result<()>;
    fn delete_node(&self, path: NodePath) -> anyhow::Result<()>;

    fn set_clock_state(&self, state: ClockState) -> anyhow::Result<()>;

    fn new_project(&self) -> anyhow::Result<()>;
    fn save_project(&self) -> anyhow::Result<()>;
    fn load_project(&self, path: String) -> anyhow::Result<()>;

    fn transport_recv(&self) -> flume::Receiver<ClockSnapshot>;

    fn get_connections(&self) -> Vec<Connection>;
    fn add_sacn_connection(&self, name: String) -> anyhow::Result<()>;
    fn add_artnet_connection(
        &self,
        name: String,
        host: String,
        port: Option<u16>,
    ) -> anyhow::Result<()>;

    fn get_dmx_monitor(&self, output_id: String) -> anyhow::Result<HashMap<u16, [u8; 512]>>;
}
