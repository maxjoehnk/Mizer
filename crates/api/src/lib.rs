use std::net::{IpAddr, Ipv4Addr, SocketAddr, TcpListener};
use std::sync::Arc;

use pinboard::NonEmptyPinboard;
pub use prost::Message;
use tonic::transport::Server;

use mizer_clock::{ClockSnapshot, ClockState};
use mizer_command_executor::ICommandExecutor;
use mizer_connections::{MidiEvent, OscMessage};
pub use mizer_devices::DeviceManager;
pub use mizer_gamepads::GamepadRef;
use mizer_message_bus::Subscriber;
use mizer_node::{NodePath, PortId};
use mizer_runtime::{LayoutsView, NodeMetadataRef, NodePreviewRef};
use mizer_session::SessionState;
use mizer_settings::Settings;

use crate::handlers::Handlers;
use crate::proto::fixtures::fixtures_api_server::FixturesApiServer;
use crate::proto::programmer::programmer_api_server::ProgrammerApiServer;
use crate::proto::sequencer::sequencer_remote_api_server::SequencerRemoteApiServer;

pub mod handlers;
mod mappings;
pub mod proto;
pub mod remote;

pub trait RuntimeApi: Clone + Send + Sync + ICommandExecutor {
    #[deprecated(note = "this should be replaced with a subscribe query in the future")]
    fn observe_history(&self) -> Subscriber<(Vec<(String, u128)>, usize)>;

    fn write_node_port(&self, node_path: NodePath, port: PortId, value: f64) -> anyhow::Result<()>;

    #[deprecated(
        note = "this is only used for ffi access but imposes the risk of bypassing the query layer"
    )]
    fn get_node_preview_ref(&self, node: NodePath) -> anyhow::Result<Option<NodePreviewRef>>;
    #[deprecated(
        note = "this is only used for ffi access but imposes the risk of bypassing the query layer"
    )]
    fn get_node_metadata_ref(&self) -> anyhow::Result<NodeMetadataRef>;

    fn set_clock_state(&self, state: ClockState) -> anyhow::Result<()>;
    fn set_bpm(&self, bpm: f64) -> anyhow::Result<()>;
    fn tap(&self) -> anyhow::Result<()>;
    fn resync(&self) -> anyhow::Result<()>;

    #[deprecated(note = "this should be replaced with a subscribe query in the future")]
    fn observe_session(&self) -> anyhow::Result<Subscriber<SessionState>>;
    fn new_project(&self) -> anyhow::Result<()>;
    fn save_project(&self) -> anyhow::Result<()>;
    fn save_project_as(&self, path: String) -> anyhow::Result<()>;
    fn load_project(&self, path: String) -> anyhow::Result<()>;

    fn transport_recv(&self) -> flume::Receiver<ClockSnapshot>;
    fn get_clock_snapshot_ref(&self) -> Arc<NonEmptyPinboard<ClockSnapshot>>;
    fn set_fps(&self, fps: f64) -> anyhow::Result<()>;

    fn get_dmx_monitor(&self) -> anyhow::Result<Vec<(u16, Arc<[u8; 512]>)>>;

    #[deprecated(note = "this should be replaced with a subscribe query in the future")]
    fn get_midi_monitor(&self, name: String) -> anyhow::Result<Subscriber<MidiEvent>>;

    #[deprecated(note = "this should be replaced with a subscribe query in the future")]
    fn get_osc_monitor(&self, name: String) -> anyhow::Result<Subscriber<OscMessage>>;

    #[deprecated(
        note = "this is only used for ffi access but imposes the risk of bypassing the query layer"
    )]
    fn get_gamepad_ref(&self, id: String) -> anyhow::Result<Option<GamepadRef>>;

    #[deprecated(
        note = "this is only used for ffi access but imposes the risk of bypassing the query layer"
    )]
    fn get_device_manager(&self) -> DeviceManager;

    fn reload_midi_device_profiles(&self) -> anyhow::Result<()>;
    fn reload_fixture_definitions(&self) -> anyhow::Result<()>;

    fn read_fader_value(&self, path: NodePath) -> anyhow::Result<f64>;

    fn read_settings(&self) -> Settings;
    fn save_settings(&self, settings: Settings) -> anyhow::Result<()>;
    fn observe_settings(&self) -> Subscriber<Settings>;
    #[deprecated(
        note = "this is only used for ffi access but imposes the risk of bypassing the query layer"
    )]
    fn layouts_view(&self) -> LayoutsView;

    fn open_nodes_view(&self);
    fn close_nodes_view(&self);
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
            .add_service(SequencerRemoteApiServer::new(handlers.sequencer))
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
