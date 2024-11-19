use crate::{NodeDesigner, NodePath};

pub struct NodeCommentArea {
    pub parent: Option<NodePath>,
    pub designer: NodeDesigner,
    pub width: f64,
    pub height: f64,
    pub label: Option<String>,
    pub show_background: bool,
    pub show_border: bool,
}
