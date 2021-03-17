use serde::{Deserialize, Serialize};
use mizer_node::NodePath;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Layout {
    pub id: String,
    pub controls: Vec<ControlConfig>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct ControlConfig {
    pub node: NodePath,
    pub position: ControlPosition,
    pub size: ControlSize,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct ControlPosition {
    pub x: u64,
    pub y: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct ControlSize {
    pub width: u64,
    pub height: u64,
}
