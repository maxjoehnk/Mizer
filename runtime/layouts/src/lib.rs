use mizer_node::{Color, NodePath};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Layout {
    pub id: String,
    pub controls: Vec<ControlConfig>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct ControlConfig {
    #[serde(default)]
    pub label: Option<String>,
    pub node: NodePath,
    pub position: ControlPosition,
    pub size: ControlSize,
    #[serde(default)]
    pub decoration: ControlDecorations,
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct ControlPosition {
    pub x: u64,
    pub y: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct ControlSize {
    pub width: u64,
    pub height: u64,
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct ControlDecorations {
    pub color: Option<Color>,
}
