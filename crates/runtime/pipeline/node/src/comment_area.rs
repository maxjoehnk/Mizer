use crate::{NodeColor, NodeDesigner, NodePath, NodePosition};
use serde::{Deserialize, Serialize};
use std::fmt::Display;
use std::str::FromStr;
use uuid::Uuid;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize, Serialize, Hash)]
pub struct NodeCommentId(Uuid);

impl NodeCommentId {
    pub fn new() -> Self {
        Self(Uuid::new_v4())
    }
}

impl Display for NodeCommentId {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.0)
    }
}

impl FromStr for NodeCommentId {
    type Err = uuid::Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        Ok(Self(Uuid::parse_str(s)?))
    }
}

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
pub struct NodeCommentArea {
    pub id: NodeCommentId,
    pub parent: Option<NodePath>,
    pub designer: NodeDesigner,
    pub width: f64,
    pub height: f64,
    pub label: Option<String>,
    pub show_background: bool,
    pub show_border: bool,
}

impl NodeCommentArea {
    pub fn new(position: NodePosition, width: f64, height: f64) -> Self {
        Self {
            id: NodeCommentId::new(),
            parent: None,
            designer: NodeDesigner {
                position,
                color: Some(NodeColor::LightGreen),
                ..Default::default()
            },
            width,
            height,
            label: None,
            show_background: true,
            show_border: true,
        }
    }
}
