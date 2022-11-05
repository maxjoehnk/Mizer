use mizer_node::{Color, NodePath};
use pinboard::NonEmptyPinboard;
use serde::{Deserialize, Serialize};
use std::sync::Arc;

pub type LayoutStorage = Arc<NonEmptyPinboard<Vec<Layout>>>;

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

#[derive(Default, Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct ControlPosition {
    pub x: u64,
    pub y: u64,
}

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct ControlSize {
    pub width: u64,
    pub height: u64,
}

impl Default for ControlSize {
    fn default() -> Self {
        Self {
            width: 1,
            height: 1,
        }
    }
}

#[derive(Default, Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Hash)]
pub struct ControlDecorations {
    pub color: Option<Color>,
}
