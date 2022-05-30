use dashmap::mapref::one::Ref;

use crate::NodeDowncast;
use dashmap::DashMap;
use mizer_clock::ClockSnapshot;
use mizer_layouts::Layout;
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodeType, PipelineNode, PortId, PortMetadata};
use mizer_plan::Plan;
use pinboard::NonEmptyPinboard;
use std::collections::HashMap;
use std::sync::Arc;

#[derive(Clone)]
pub struct RuntimeAccess {
    pub nodes: Arc<DashMap<NodePath, Box<dyn PipelineNode>>>,
    pub designer: Arc<NonEmptyPinboard<HashMap<NodePath, NodeDesigner>>>,
    pub links: Arc<NonEmptyPinboard<Vec<NodeLink>>>,
    pub layouts: Arc<NonEmptyPinboard<Vec<Layout>>>,
    pub plans: Arc<NonEmptyPinboard<Vec<Plan>>>,
    // TODO: make broadcast
    pub clock_recv: flume::Receiver<ClockSnapshot>,
    pub clock_snapshot: Arc<NonEmptyPinboard<ClockSnapshot>>,
}

pub struct NodeDescriptor<'a> {
    pub path: NodePath,
    pub node: Ref<'a, NodePath, Box<dyn PipelineNode>>,
    pub designer: NodeDesigner,
    pub ports: Vec<(PortId, PortMetadata)>,
}

impl<'a> NodeDowncast for NodeDescriptor<'a> {
    fn node_type(&self) -> NodeType {
        self.node.node_type()
    }

    fn downcast_node<T: Clone + 'static>(&self, node_type: NodeType) -> Option<T> {
        match self.node.value().downcast_ref::<T>() {
            Ok(node) => Some(node.clone()),
            Err(err) => {
                log::error!(
                    "Could not downcast {} ({:?}): {:?}",
                    self.path,
                    node_type,
                    err
                );
                None
            }
        }
    }
}
