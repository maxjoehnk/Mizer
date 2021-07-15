use mizer_clock::ClockState;
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodeType, PortId};
use mizer_nodes::Node;

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
    SaveProjectAs(String, flume::Sender<anyhow::Result<()>>),
    NewProject(flume::Sender<anyhow::Result<()>>),
    LoadProject(String, flume::Sender<anyhow::Result<()>>),
}
