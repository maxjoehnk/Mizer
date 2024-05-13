pub use list_nodes::*;
pub use get_node::*;
pub use list_available_nodes::*;
pub use list_links::*;

use std::collections::HashMap;
use mizer_node::{NodeDesigner, NodeMetadata, NodePath, NodeSetting, NodeType};
use mizer_nodes::{ContainerNode, NodeDowncast};
use crate::{RuntimeAccess};
use crate::commands::StaticNodeDescriptor;

mod list_nodes;
mod get_node;
mod list_available_nodes;
mod list_links;

#[profiling::function]
fn get_descriptor(
    access: &RuntimeAccess,
    path: NodePath,
    metadata: &HashMap<NodePath, NodeMetadata>,
    designer: &HashMap<NodePath, NodeDesigner>,
    settings: &HashMap<NodePath, Vec<NodeSetting>>,
) -> StaticNodeDescriptor {
    let node = access.nodes.get(&path).unwrap();
    let metadata = metadata.get(&path).cloned().unwrap_or_default();
    let settings = settings.get(&path).cloned().unwrap_or_default();
    let designer = designer[&path].clone();
    let ports = access
        .ports
        .get(&path)
        .map(|ports| ports.clone())
        .unwrap_or_default();

    let children = if node.node_type() == NodeType::Container {
        if let Some(node) = node.downcast_node::<ContainerNode>(NodeType::Container) {
            node.nodes.clone()
        } else {
            Default::default()
        }
    } else {
        Default::default()
    };

    StaticNodeDescriptor {
        node_type: node.node_type(),
        path,
        designer,
        ports,
        details: node.details(),
        settings,
        metadata,
        children,
    }
}
