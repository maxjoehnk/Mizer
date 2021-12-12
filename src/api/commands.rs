use std::collections::HashMap;

use mizer_clock::ClockState;
use mizer_connections::Connection;
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodeType, PortId};
use mizer_nodes::Node;
use pinboard::NonEmptyPinboard;
use std::sync::Arc;

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
    GetNodePreviewRef(NodePath, flume::Sender<Option<Arc<NonEmptyPinboard<Vec<f64>>>>>),
    UpdateNode(NodePath, Node, flume::Sender<anyhow::Result<()>>),
    DeleteNode(NodePath, flume::Sender<()>),
    SetClockState(ClockState),
    GetConnections(flume::Sender<Vec<Connection>>),
    AddSacnConnection(String, flume::Sender<anyhow::Result<()>>),
    AddArtnetConnection(String, (String, Option<u16>), flume::Sender<anyhow::Result<()>>),
    GetDmxMonitor(
        String,
        flume::Sender<anyhow::Result<HashMap<u16, [u8; 512]>>>,
    ),
    SaveProject(flume::Sender<anyhow::Result<()>>),
    SaveProjectAs(String, flume::Sender<anyhow::Result<()>>),
    NewProject(flume::Sender<anyhow::Result<()>>),
    LoadProject(String, flume::Sender<anyhow::Result<()>>),
}
