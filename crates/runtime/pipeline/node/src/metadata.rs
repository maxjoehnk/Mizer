use std::collections::HashMap;
use std::sync::Arc;

use pinboard::NonEmptyPinboard;

use mizer_ports::PortId;

use crate::NodePath;

#[derive(Debug, Clone, Default)]
pub struct NodeMetadata {
    pub ports: HashMap<PortId, RuntimePortMetadata>,
}

#[derive(Debug, Clone, Default)]
pub struct RuntimePortMetadata {
    pub pushed_value: bool,
}

pub struct NodeMetadataRef {
    metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeMetadata>>>,
}

impl NodeMetadataRef {
    pub fn new(metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeMetadata>>>) -> Self {
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
