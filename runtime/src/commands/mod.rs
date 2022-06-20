pub use self::add_link::*;
pub use self::add_node::*;
pub use self::delete_node::*;
pub use self::disconnect_ports::*;
pub use self::duplicate_node::*;
pub use self::hide_node::*;
pub use self::move_node::*;
pub use self::show_node::*;
pub use self::update_node::*;
use mizer_node::{NodeDesigner, NodeDetails, NodePath, NodeType, PortMetadata};
use mizer_nodes::Node;
use mizer_ports::PortId;

mod add_link;
mod add_node;
mod delete_node;
mod disconnect_ports;
mod duplicate_node;
mod hide_node;
mod move_node;
mod show_node;
mod update_node;

#[derive(Debug, Clone)]
pub struct StaticNodeDescriptor {
    pub node_type: NodeType,
    pub path: NodePath,
    pub designer: NodeDesigner,
    pub ports: Vec<(PortId, PortMetadata)>,
    pub details: NodeDetails,
    pub config: Node,
}
