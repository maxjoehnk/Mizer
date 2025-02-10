use mizer_node::{NodeDesigner, NodePath};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct NodeConfig {
    pub path: NodePath,
    #[serde(flatten)]
    pub config: crate::Node,
    #[serde(default)]
    pub designer: NodeDesigner,
}
