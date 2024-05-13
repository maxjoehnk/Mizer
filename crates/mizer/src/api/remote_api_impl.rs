use std::rc::Rc;
use std::sync::Arc;
use flume::Receiver;
use pinboard::NonEmptyPinboard;
use mizer_api::{GamepadRef, RuntimeApi};
use mizer_clock::{ClockSnapshot, ClockState};
use mizer_command_executor::{SendableCommand, SendableQuery};
use mizer_connections::{Connection, MidiEvent, OscMessage};
use mizer_connections::midi_device_profile::DeviceProfile;
use mizer_devices::DeviceManager;
use mizer_layouts::Layout;
use mizer_message_bus::Subscriber;
use mizer_node::{NodeLink, NodePath, PortId};
use mizer_pipeline::NodePreviewRef;
use mizer_plan::Plan;
use mizer_runtime::{LayoutsView, NodeDescriptor, NodeMetadataRef};
use mizer_session::SessionState;
use mizer_settings::Settings;

#[derive(Clone)]
pub struct RemoteApi {}

impl RuntimeApi for RemoteApi {
    fn run_command<'a, T: SendableCommand<'a> + 'static>(&self, command: T) -> anyhow::Result<T::Result> {
        todo!()
    }

    fn query<'a, T: SendableQuery<'a> + 'static>(&self, query: T) -> anyhow::Result<T::Result> {
        todo!()
    }

    fn undo(&self) -> anyhow::Result<()> {
        todo!()
    }

    fn redo(&self) -> anyhow::Result<()> {
        todo!()
    }

    fn observe_history(&self) -> Subscriber<(Vec<(String, u128)>, usize)> {
        todo!()
    }

    fn nodes(&self) -> Vec<NodeDescriptor> {
        // todo!()
        Default::default()
    }

    fn links(&self) -> Vec<NodeLink> {
        // todo!()
        Default::default()
    }

    fn layouts(&self) -> Vec<Layout> {
        // todo!()
        Default::default()
    }

    fn plans(&self) -> Vec<Plan> {
        // todo!()
        Default::default()
    }

    fn write_node_port(&self, node_path: NodePath, port: PortId, value: f64) -> anyhow::Result<()> {
        todo!()
    }

    fn get_node_preview_ref(&self, node: NodePath) -> anyhow::Result<Option<NodePreviewRef>> {
        // todo!()
        Default::default()
    }

    fn get_node_metadata_ref(&self) -> anyhow::Result<NodeMetadataRef> {
        todo!()
    }

    fn get_node(&self, path: &NodePath) -> Option<NodeDescriptor> {
        // todo!()
        Default::default()
    }

    fn set_clock_state(&self, state: ClockState) -> anyhow::Result<()> {
        // todo!()
        Default::default()
    }

    fn set_bpm(&self, bpm: f64) -> anyhow::Result<()> {
        // todo!()
        Default::default()
    }

    fn observe_session(&self) -> anyhow::Result<Subscriber<SessionState>> {
        todo!()
    }

    fn new_project(&self) -> anyhow::Result<()> {
        // todo!()
        Default::default()
    }

    fn save_project(&self) -> anyhow::Result<()> {
        // todo!()
        Default::default()
    }

    fn save_project_as(&self, path: String) -> anyhow::Result<()> {
        // todo!()
        Default::default()
    }

    fn load_project(&self, path: String) -> anyhow::Result<()> {
        // todo!()
        Default::default()
    }

    fn transport_recv(&self) -> Receiver<ClockSnapshot> {
        todo!()
    }

    fn get_clock_snapshot_ref(&self) -> Arc<NonEmptyPinboard<ClockSnapshot>> {
        todo!()
    }

    fn set_fps(&self, fps: f64) -> anyhow::Result<()> {
        // todo!()
        Default::default()
    }

    fn get_connections(&self) -> Vec<Connection> {
        // todo!()
        Default::default()
    }

    fn get_midi_device_profiles(&self) -> Vec<DeviceProfile> {
        // todo!()
        Default::default()
    }

    fn get_dmx_monitor(&self) -> anyhow::Result<Vec<(u16, Rc<[u8; 512]>)>> {
        // todo!()
        Default::default()
    }

    fn get_midi_monitor(&self, name: String) -> anyhow::Result<Subscriber<MidiEvent>> {
        todo!()
    }

    fn get_osc_monitor(&self, name: String) -> anyhow::Result<Subscriber<OscMessage>> {
        todo!()
    }

    fn get_gamepad_ref(&self, id: String) -> anyhow::Result<Option<GamepadRef>> {
        // todo!()
        Default::default()
    }

    fn get_device_manager(&self) -> DeviceManager {
        todo!()
    }

    fn reload_midi_device_profiles(&self) -> anyhow::Result<()> {
        // todo!()
        Default::default()
    }

    fn read_fader_value(&self, path: NodePath) -> anyhow::Result<f64> {
        // todo!()
        Default::default()
    }

    fn read_settings(&self) -> Settings {
        todo!()
    }

    fn save_settings(&self, settings: Settings) -> anyhow::Result<()> {
        // todo!()
        Default::default()
    }

    fn observe_settings(&self) -> Subscriber<Settings> {
        todo!()
    }

    fn layouts_view(&self) -> LayoutsView {
        // todo!()
        Default::default()
    }

    fn get_service<T: 'static + Send + Sync + Clone>(&self) -> Option<&T> {
        // todo!()
        Default::default()
    }

    fn open_nodes_view(&self) {
        // todo!()
        Default::default()
    }

    fn close_nodes_view(&self) {
        // todo!()
        Default::default()
    }
}
