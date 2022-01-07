use std::collections::HashMap;

use mizer_clock::ClockState;
use mizer_connections::{midi_device_profile::DeviceProfile, Connection};
use mizer_message_bus::Subscriber;
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodeType, PortId};
use mizer_nodes::Node;
use mizer_protocol_midi::MidiEvent;
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
    ReadFaderValue(NodePath, flume::Sender<anyhow::Result<f64>>),
    GetNodePreviewRef(
        NodePath,
        flume::Sender<Option<Arc<NonEmptyPinboard<Vec<f64>>>>>,
    ),
    UpdateNode(NodePath, Node, flume::Sender<anyhow::Result<()>>),
    DeleteNode(NodePath, flume::Sender<()>),
    SetClockState(ClockState),
    GetConnections(flume::Sender<Vec<Connection>>),
    GetMidiDeviceProfiles(flume::Sender<Vec<DeviceProfile>>),
    AddSacnConnection(String, flume::Sender<anyhow::Result<()>>),
    AddArtnetConnection(
        String,
        (String, Option<u16>),
        flume::Sender<anyhow::Result<()>>,
    ),
    GetDmxMonitor(
        String,
        flume::Sender<anyhow::Result<HashMap<u16, [u8; 512]>>>,
    ),
    GetMidiMonitor(String, flume::Sender<anyhow::Result<Subscriber<MidiEvent>>>),
    SaveProject(flume::Sender<anyhow::Result<()>>),
    SaveProjectAs(String, flume::Sender<anyhow::Result<()>>),
    NewProject(flume::Sender<anyhow::Result<()>>),
    LoadProject(String, flume::Sender<anyhow::Result<()>>),
}
