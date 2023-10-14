use std::collections::HashMap;
use std::net::{IpAddr, Ipv4Addr, SocketAddr, TcpListener};
use std::sync::Arc;

use pinboard::NonEmptyPinboard;
pub use prost::Message;
use tonic::transport::Server;

use mizer_clock::{ClockSnapshot, ClockState};
use mizer_command_executor::SendableCommand;
use mizer_connections::{midi_device_profile::DeviceProfile, Connection, MidiEvent, OscMessage};
pub use mizer_devices::DeviceManager;
pub use mizer_gamepads::GamepadRef;
use mizer_layouts::Layout;
use mizer_message_bus::Subscriber;
use mizer_node::{NodeLink, NodeMetadataRef, NodePath, NodePreviewRef, PortId};
use mizer_plan::Plan;
use mizer_runtime::{LayoutsView, NodeDescriptor};
use mizer_session::SessionState;
use mizer_settings::Settings;

use crate::handlers::Handlers;
use crate::proto::fixtures::fixtures_api_server::FixturesApiServer;
use crate::proto::programmer::programmer_api_server::ProgrammerApiServer;

pub mod handlers;
mod mappings;
pub mod proto;
pub mod remote;

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
    fn get_device_manager(&self) -> DeviceManager;

    fn read_fader_value(&self, path: NodePath) -> anyhow::Result<f64>;

    fn read_settings(&self) -> Settings;
    fn save_settings(&self, settings: Settings) -> anyhow::Result<()>;
    fn observe_settings(&self) -> Subscriber<Settings>;
    fn layouts_view(&self) -> LayoutsView;
}

pub fn start_remote_api<R: RuntimeApi + 'static>(handlers: Handlers<R>) -> anyhow::Result<u16> {
    let port = get_available_port().ok_or_else(|| anyhow::anyhow!("no available port"))?;
    let addr = SocketAddr::new(IpAddr::V4(Ipv4Addr::UNSPECIFIED), port);

    tokio::spawn(async move {
        tracing::info!("Starting remote API on {addr}");
        let result = Server::builder()
            .trace_fn(|_| tracing::info_span!("remote_api"))
            .add_service(FixturesApiServer::new(handlers.fixtures))
            .add_service(ProgrammerApiServer::new(handlers.programmer))
            .serve(addr)
            .await;

        if let Err(err) = result {
            tracing::error!("failed to start remote API: {err}");
        }
    });

    Ok(port)
}

fn get_available_port() -> Option<u16> {
    (50000..60000).find(|port| port_is_available(*port))
}

fn port_is_available(port: u16) -> bool {
    TcpListener::bind(("0.0.0.0", port)).is_ok()
}
