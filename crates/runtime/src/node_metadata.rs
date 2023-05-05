use mizer_node::NodePath;
use mizer_pipeline::{NodeMetadata, RuntimePortMetadata};
use mizer_ports::PortId;
use pinboard::NonEmptyPinboard;
use std::collections::HashMap;
use std::sync::Arc;

pub struct NodeMetadataRef {
    metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeMetadata>>>,
}

impl NodeMetadataRef {
    pub(crate) fn new(metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeMetadata>>>) -> Self {
        Self { metadata }
    }

    pub fn get_all_port_metadata(&self) -> Vec<(NodePath, PortId, RuntimePortMetadata)> {
        let metadata = self.metadata.read();
        metadata
            .into_iter()
            .flat_map(|(path, metadata)| {
                metadata
                    .ports
                    .into_iter()
                    .map(move |(port, port_metadata)| (path.clone(), port, port_metadata))
            })
            .collect()
    }
}
