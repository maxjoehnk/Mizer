use serde::{Deserialize, Serialize};
use mizer_node::{NodeDesigner, NodePath};

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct NodeConfig {
    pub path: NodePath,
    #[serde(flatten)]
    pub config: crate::Node,
    #[serde(default)]
    pub designer: NodeDesigner,
}
