use mizer_node::{NodeType, NodeDesigner, NodePath, NodeLink, PortId};
use mizer_nodes::Node;
use mizer_clock::ClockState;

#[derive(Debug, Clone)]
pub enum ApiCommand {
    AddNode(
        NodeType,
        NodeDesigner,
        Option<Node>,
        flume::Sender<anyhow::Result<NodePath>>,
    ),
    AddLink(NodeLink, flume::Sender<anyhow::Result<()>>),
    WritePort(NodePath, PortId, f64, flume::Sender<anyhow::Result<()>>),
    GetNodePreview(NodePath, flume::Sender<anyhow::Result<Vec<f64>>>),
    UpdateNode(NodePath, Node, flume::Sender<anyhow::Result<()>>),
    SetClockState(ClockState),
    SaveProject(flume::Sender<anyhow::Result<()>>),
}

