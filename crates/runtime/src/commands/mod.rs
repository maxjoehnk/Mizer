use crate::pipeline::Pipeline;
use mizer_node::{
    NodeDesigner, NodeDetails, NodeMetadata, NodePath, NodeSetting, NodeType, PortMetadata,
};
use mizer_nodes::ContainerNode;
use mizer_ports::PortId;

pub use self::add_comment::*;
pub use self::add_link::*;
pub use self::add_node::*;
pub use self::delete_comment::*;
pub use self::delete_nodes::*;
pub use self::disconnect_port::*;
pub use self::disconnect_ports::*;
pub use self::duplicate_nodes::*;
pub use self::group_nodes::*;
pub use self::hide_node::*;
pub use self::move_node::*;
pub use self::remove_link::*;
pub use self::rename_node::*;
pub use self::show_node::*;
pub use self::update_comment::*;
pub use self::update_node_color::*;
pub use self::update_node_setting::*;

mod add_comment;
mod add_link;
mod add_node;
mod delete_comment;
mod delete_nodes;
mod disconnect_port;
mod disconnect_ports;
mod duplicate_nodes;
mod group_nodes;
mod hide_node;
mod move_node;
mod remove_link;
mod rename_node;
mod show_node;
mod update_comment;
mod update_node_color;
mod update_node_setting;

#[derive(Debug, Clone)]
pub struct StaticNodeDescriptor {
    pub node_type: NodeType,
    pub path: NodePath,
    pub designer: NodeDesigner,
    pub ports: Vec<(PortId, PortMetadata)>,
    pub details: NodeDetails,
    pub settings: Vec<NodeSetting>,
    pub metadata: NodeMetadata,
    pub children: Vec<NodePath>,
}

pub(crate) fn assert_valid_parent(
    pipeline: &Pipeline,
    parent: Option<&NodePath>,
) -> anyhow::Result<()> {
    if let Some(path) = parent {
        if !pipeline.contains_node(path) {
            return Err(anyhow::anyhow!("Unknown parent node {}", path));
        }
    };

    Ok(())
}

pub(crate) fn add_path_to_container(
    pipeline: &mut Pipeline,
    parent: Option<&NodePath>,
    path: &NodePath,
) -> anyhow::Result<()> {
    let Some(parent) = parent else {
        return Ok(());
    };
    let container = pipeline
        .get_node_mut::<ContainerNode>(parent)
        .ok_or_else(|| anyhow::anyhow!("Node {} is not a container", path))?;
    container.nodes.push(path.clone());

    Ok(())
}

pub(crate) fn remove_path_from_container(
    pipeline: &mut Pipeline,
    parent: Option<&NodePath>,
    path: &NodePath,
) -> anyhow::Result<()> {
    let Some(parent) = parent else {
        return Ok(());
    };
    let container = pipeline
        .get_node_mut::<ContainerNode>(parent)
        .ok_or_else(|| anyhow::anyhow!("Node {} is not a container", path))?;
    container.nodes.retain(|p| path != p);

    Ok(())
}
