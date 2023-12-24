use std::collections::HashMap;
use std::sync::Arc;

use pinboard::NonEmptyPinboard;

use mizer_node::NodePath;
use mizer_pipeline::{NodeRuntimeMetadata, RuntimePortMetadata};
use mizer_ports::PortId;

pub struct NodeMetadataRef {
    metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeRuntimeMetadata>>>,
}

impl NodeMetadataRef {
    pub(crate) fn new(
        metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeRuntimeMetadata>>>,
    ) -> Self {
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
