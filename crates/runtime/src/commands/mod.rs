use mizer_node::{NodeDesigner, NodeDetails, NodePath, NodeSetting, NodeType, PortMetadata};
use mizer_nodes::{ContainerNode, Node};
use mizer_ports::PortId;

use crate::pipeline_access::PipelineAccess;

pub use self::add_link::*;
pub use self::add_node::*;
pub use self::delete_node::*;
pub use self::disconnect_port::*;
pub use self::disconnect_ports::*;
pub use self::duplicate_node::*;
pub use self::group_nodes::*;
pub use self::hide_node::*;
pub use self::move_node::*;
pub use self::remove_link::*;
pub use self::rename_node::*;
pub use self::show_node::*;
pub use self::update_node_setting::*;

mod add_link;
mod add_node;
mod delete_node;
mod disconnect_port;
mod disconnect_ports;
mod duplicate_node;
mod group_nodes;
mod hide_node;
mod move_node;
mod remove_link;
mod rename_node;
mod show_node;
mod update_node_setting;

#[derive(Debug, Clone)]
pub struct StaticNodeDescriptor {
    pub node_type: NodeType,
    pub path: NodePath,
    pub designer: NodeDesigner,
    pub ports: Vec<(PortId, PortMetadata)>,
    pub details: NodeDetails,
    pub config: Node,
    pub settings: Vec<NodeSetting>,
}

pub(crate) fn assert_valid_parent(
    pipeline: &PipelineAccess,
    parent: Option<&NodePath>,
) -> anyhow::Result<()> {
    if let Some(path) = parent {
        if !pipeline.nodes.contains_key(path) {
            return Err(anyhow::anyhow!("Unknown parent node {}", path));
        }
    };

    Ok(())
}

pub(crate) fn add_path_to_container(
    pipeline: &mut PipelineAccess,
    parent: Option<&NodePath>,
    path: &NodePath,
) -> anyhow::Result<()> {
    if let Some(parent) = parent.and_then(|path| pipeline.nodes.get_mut(path)) {
        let parent = parent.downcast_mut::<ContainerNode>()?;
        parent.nodes.push(path.clone());
    }
    if let Some(mut parent) = parent.and_then(|path| pipeline.nodes_view.get_mut(path)) {
        let parent = parent.value_mut().downcast_mut::<ContainerNode>()?;
        parent.nodes.push(path.clone());
    }

    Ok(())
}

pub(crate) fn remove_path_from_container(
    pipeline: &mut PipelineAccess,
    parent: Option<&NodePath>,
    path: &NodePath,
) -> anyhow::Result<()> {
    if let Some(parent) = parent.and_then(|path| pipeline.nodes.get_mut(path)) {
        let parent = parent.downcast_mut::<ContainerNode>()?;
        parent.nodes.retain(|p| path != p);
    }
    if let Some(mut parent) = parent.and_then(|path| pipeline.nodes_view.get_mut(path)) {
        let parent = parent.value_mut().downcast_mut::<ContainerNode>()?;
        parent.nodes.retain(|p| path != p);
    }

    Ok(())
}
