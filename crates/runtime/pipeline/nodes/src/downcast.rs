use crate::NodeDowncast;
use mizer_node::{NodePath, NodeType, PipelineNode};

impl<'a> NodeDowncast for dashmap::mapref::one::Ref<'a, NodePath, Box<dyn PipelineNode>> {
    fn node_type(&self) -> NodeType {
        self.value().node_type()
    }

    fn downcast_node<T: Clone + 'static>(&self, node_type: NodeType) -> Option<T> {
        match self.value().downcast_ref::<T>() {
            Ok(node) => Some(node.clone()),
            Err(err) => {
                tracing::error!("Could not downcast node type {:?}: {:?}", node_type, err);
                None
            }
        }
    }
}

impl<'a> NodeDowncast for dashmap::mapref::multiple::RefMulti<'a, NodePath, Box<dyn PipelineNode>> {
    fn node_type(&self) -> NodeType {
        self.value().node_type()
    }

    fn downcast_node<T: Clone + 'static>(&self, node_type: NodeType) -> Option<T> {
        match self.value().downcast_ref::<T>() {
            Ok(node) => Some(node.clone()),
            Err(err) => {
                tracing::error!("Could not downcast node type {:?}: {:?}", node_type, err);
                None
            }
        }
    }
}
