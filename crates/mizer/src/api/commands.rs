use mizer_clock::ClockState;
use mizer_message_bus::Subscriber;
use mizer_node::{NodePath, PortId};
use mizer_protocol_midi::MidiEvent;
use mizer_protocol_osc::OscMessage;
use mizer_runtime::{NodeMetadataRef, NodePreviewRef};
use mizer_session::SessionState;
use mizer_settings::FixtureLibraryPaths;

#[derive(Debug, Clone)]
pub enum ApiCommand {
    WritePort(NodePath, PortId, f64, flume::Sender<anyhow::Result<()>>),
    ReadFaderValue(NodePath, flume::Sender<anyhow::Result<f64>>),
    GetNodePreviewRef(NodePath, flume::Sender<Option<NodePreviewRef>>),
    GetNodeMetadataRef(flume::Sender<NodeMetadataRef>),
    SetClockState(ClockState),
    SetBpm(f64),
    SetFps(f64),
    GetMidiMonitor(String, flume::Sender<anyhow::Result<Subscriber<MidiEvent>>>),
    GetOscMonitor(
        String,
        flume::Sender<anyhow::Result<Subscriber<OscMessage>>>,
    ),
    SaveProject(flume::Sender<anyhow::Result<()>>),
    SaveProjectAs(String, flume::Sender<anyhow::Result<()>>),
    NewProject(flume::Sender<anyhow::Result<()>>),
    LoadProject(String, flume::Sender<anyhow::Result<()>>),
    ObserveSession(flume::Sender<Subscriber<SessionState>>),
    ReloadFixtureLibraries(FixtureLibraryPaths, flume::Sender<anyhow::Result<()>>),
}
