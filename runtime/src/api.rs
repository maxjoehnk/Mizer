use dashmap::mapref::one::Ref;
use dashmap::DashMap;
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodeType, PipelineNode};
use pinboard::{NonEmptyPinboard, Pinboard};
use std::collections::HashMap;
use std::ops::Deref;
use std::sync::Arc;

pub struct RuntimeApi {
    pub(crate) nodes: Arc<DashMap<NodePath, Box<dyn PipelineNode>>>,
    pub(crate) designer: Arc<NonEmptyPinboard<HashMap<NodePath, NodeDesigner>>>,
    pub(crate) links: Arc<NonEmptyPinboard<Vec<NodeLink>>>,
}

impl RuntimeApi {
    pub fn nodes(&self) -> Vec<NodeDescriptor> {
        let designer = self.designer.read();
        let paths = self
            .nodes
            .iter()
            .map(|entry| entry.key().clone())
            .collect::<Vec<_>>();

        paths
            .into_iter()
            .map(|path| {
                let node = self.nodes.get(&path).unwrap();
                let designer = designer[&path].clone();

                NodeDescriptor {
                    path,
                    node,
                    designer,
                }
            })
            .collect()
    }

    pub fn links(&self) -> Vec<NodeLink> {
        self.links.read()
    }
}

pub struct NodeDescriptor<'a> {
    pub path: NodePath,
    pub node: Ref<'a, NodePath, Box<dyn PipelineNode>>,
    pub designer: NodeDesigner,
}

impl<'a> NodeDescriptor<'a> {
    pub fn node_type(&self) -> NodeType {
        self.node.node_type()
    }
}
