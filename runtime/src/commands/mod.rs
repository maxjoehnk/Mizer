pub use self::add_link::*;
pub use self::add_node::*;
pub use self::delete_node::*;
pub use self::disconnect_ports::*;
pub use self::duplicate_node::*;
pub use self::hide_node::*;
pub use self::move_node::*;
pub use self::show_node::*;
pub use self::update_node::*;
use crate::pipeline_access::PipelineAccess;
use mizer_node::{NodeDesigner, NodeDetails, NodePath, NodeType, PortMetadata};
use mizer_nodes::{ContainerNode, Node};
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
