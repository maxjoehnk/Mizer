use std::collections::HashMap;

use mizer_clock::{ClockSnapshot, ClockState};
use mizer_command_executor::SendableCommand;
use mizer_connections::{midi_device_profile::DeviceProfile, Connection, MidiEvent, OscMessage};
pub use mizer_gamepads::GamepadRef;
use mizer_layouts::Layout;
use mizer_message_bus::Subscriber;
use mizer_node::{NodeLink, NodePath, NodePreviewRef, PortId};
use mizer_plan::Plan;
use mizer_runtime::{LayoutsView, NodeDescriptor, NodeMetadataRef};
use mizer_session::SessionState;
use mizer_settings::Settings;
use pinboard::NonEmptyPinboard;
use std::sync::Arc;

pub mod handlers;
mod mappings;
pub mod models;

pub trait RuntimeApi: Clone + Send + Sync {
    fn run_command<'a, T: SendableCommand<'a> + 'static>(
        &self,
        command: T,
    ) -> anyhow::Result<T::Result>;

    fn undo(&self) -> anyhow::Result<()>;
    fn redo(&self) -> anyhow::Result<()>;

    fn observe_history(&self) -> Subscriber<(Vec<(String, u128)>, usize)>;

    fn nodes(&self) -> Vec<NodeDescriptor>;

    fn links(&self) -> Vec<NodeLink>;

    fn layouts(&self) -> Vec<Layout>;

    fn plans(&self) -> Vec<Plan>;

    fn write_node_port(&self, node_path: NodePath, port: PortId, value: f64) -> anyhow::Result<()>;

    fn get_node_preview_ref(&self, node: NodePath) -> anyhow::Result<Option<NodePreviewRef>>;
    fn get_node_metadata_ref(&self) -> anyhow::Result<NodeMetadataRef>;

    fn get_node(&self, path: &NodePath) -> Option<NodeDescriptor>;

    fn set_clock_state(&self, state: ClockState) -> anyhow::Result<()>;
    fn set_bpm(&self, bpm: f64) -> anyhow::Result<()>;

    fn observe_session(&self) -> anyhow::Result<Subscriber<SessionState>>;
    fn new_project(&self) -> anyhow::Result<()>;
    fn save_project(&self) -> anyhow::Result<()>;
    fn save_project_as(&self, path: String) -> anyhow::Result<()>;
    fn load_project(&self, path: String) -> anyhow::Result<()>;

    fn transport_recv(&self) -> flume::Receiver<ClockSnapshot>;
    fn get_clock_snapshot_ref(&self) -> Arc<NonEmptyPinboard<ClockSnapshot>>;

    fn get_connections(&self) -> Vec<Connection>;

    fn get_midi_device_profiles(&self) -> Vec<DeviceProfile>;

    fn get_dmx_monitor(&self, output_id: String) -> anyhow::Result<HashMap<u16, [u8; 512]>>;

    fn get_midi_monitor(&self, name: String) -> anyhow::Result<Subscriber<MidiEvent>>;

    fn get_osc_monitor(&self, name: String) -> anyhow::Result<Subscriber<OscMessage>>;

    fn get_gamepad_ref(&self, id: String) -> anyhow::Result<Option<GamepadRef>>;

    fn read_fader_value(&self, path: NodePath) -> anyhow::Result<f64>;

    fn read_settings(&self) -> Settings;
    fn save_settings(&self, settings: Settings) -> anyhow::Result<()>;
    fn observe_settings(&self) -> Subscriber<Settings>;
    fn layouts_view(&self) -> LayoutsView;
}
