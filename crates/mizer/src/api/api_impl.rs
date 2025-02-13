use std::sync::atomic::AtomicU8;
use std::sync::Arc;

use pinboard::NonEmptyPinboard;

use crate::{ApiCommand, ApiHandler};
use mizer_api::{GamepadRef, RuntimeApi};
use mizer_clock::{ClockSnapshot, ClockState};
use mizer_command_executor::{
    CommandExecutorApi, GetCommandHistoryQuery, ICommandExecutor, SendableCommand, SendableQuery,
};
use mizer_devices::DeviceManager;
use mizer_message_bus::{MessageBus, Subscriber};
use mizer_module::ApiInjector;
use mizer_node::{NodePath, PortId};
use mizer_protocol_dmx::DmxMonitorHandle;
use mizer_protocol_midi::{MidiDeviceProfileRegistry, MidiEvent};
use mizer_protocol_osc::OscMessage;
use mizer_runtime::{DefaultRuntime, LayoutsView, NodeMetadataRef, NodePreviewRef, RuntimeAccess};
use mizer_session::SessionState;
use mizer_settings::{Settings, SettingsManager};
use mizer_status_bus::StatusHandle;

#[derive(Clone)]
pub struct Api {
    access: RuntimeAccess,
    command_executor_api: CommandExecutorApi,
    sender: flume::Sender<ApiCommand>,
    settings: Arc<NonEmptyPinboard<SettingsManager>>,
    settings_bus: MessageBus<Settings>,
    history_bus: MessageBus<(Vec<(String, u128)>, usize)>,
    device_manager: DeviceManager,
    api_injector: ApiInjector,
    open_node_views: Arc<AtomicU8>,
}

impl ICommandExecutor for Api {
    #[profiling::function]
    fn run_command<'a, T: SendableCommand<'a> + 'static>(
        &self,
        command: T,
    ) -> anyhow::Result<T::Result> {
        let result = self.command_executor_api.run_command(command)?;
        self.emit_history()?;

        Ok(result)
    }

    #[profiling::function]
    fn execute_query<'a, T: SendableQuery<'a> + 'static>(
        &self,
        query: T,
    ) -> anyhow::Result<T::Result> {
        let result = self.command_executor_api.execute_query(query)?;

        Ok(result)
    }

    fn undo(&self) -> anyhow::Result<()> {
        self.command_executor_api.undo()?;
        self.emit_history()?;

        Ok(())
    }

    fn redo(&self) -> anyhow::Result<()> {
        self.command_executor_api.redo()?;
        self.emit_history()?;

        Ok(())
    }
}

impl RuntimeApi for Api {
    fn observe_history(&self) -> Subscriber<(Vec<(String, u128)>, usize)> {
        self.history_bus.subscribe()
    }

    #[profiling::function]
    fn write_node_port(&self, node_path: NodePath, port: PortId, value: f64) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::WritePort(node_path, port, value, tx))?;

        rx.recv()?
    }

    #[profiling::function]
    fn get_node_preview_ref(&self, node: NodePath) -> anyhow::Result<Option<NodePreviewRef>> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::GetNodePreviewRef(node, tx))?;

        let value = rx.recv()?;

        Ok(value)
    }

    #[profiling::function]
    fn get_node_metadata_ref(&self) -> anyhow::Result<NodeMetadataRef> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::GetNodeMetadataRef(tx))?;

        let value = rx.recv()?;

        Ok(value)
    }

    fn set_clock_state(&self, state: ClockState) -> anyhow::Result<()> {
        self.sender.send(ApiCommand::SetClockState(state))?;

        Ok(())
    }

    fn set_bpm(&self, bpm: f64) -> anyhow::Result<()> {
        self.sender.send(ApiCommand::SetBpm(bpm))?;

        Ok(())
    }

    fn tap(&self) -> anyhow::Result<()> {
        self.sender.send(ApiCommand::Tap)?;

        Ok(())
    }

    fn resync(&self) -> anyhow::Result<()> {
        self.sender.send(ApiCommand::Resync)?;

        Ok(())
    }

    fn observe_session(&self) -> anyhow::Result<Subscriber<SessionState>> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::ObserveSession(tx))?;

        Ok(rx.recv()?)
    }

    fn new_project(&self) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::NewProject(tx))?;
        rx.recv()??;

        self.emit_history()?;

        Ok(())
    }

    fn save_project(&self) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::SaveProject(tx))?;

        rx.recv()?
    }

    fn save_project_as(&self, path: String) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::SaveProjectAs(path, tx))?;

        rx.recv()?
    }

    fn load_project(&self, path: String) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::LoadProject(path, tx))?;
        rx.recv()??;

        self.emit_history()?;

        Ok(())
    }

    fn transport_recv(&self) -> flume::Receiver<ClockSnapshot> {
        self.access.clock_recv.clone()
    }

    fn get_clock_snapshot_ref(&self) -> Arc<NonEmptyPinboard<ClockSnapshot>> {
        self.access.clock_snapshot.clone()
    }

    #[profiling::function]
    fn set_fps(&self, fps: f64) -> anyhow::Result<()> {
        self.sender.send(ApiCommand::SetFps(fps))?;

        Ok(())
    }

    #[profiling::function]
    fn get_dmx_monitor(&self) -> anyhow::Result<Vec<(u16, Arc<[u8; 512]>)>> {
        let dmx_monitor = self.api_injector.get::<DmxMonitorHandle>();
        let dmx_monitor =
            dmx_monitor.ok_or_else(|| anyhow::anyhow!("DMX monitor not available"))?;

        Ok(dmx_monitor.read_all())
    }

    #[profiling::function]
    fn get_midi_monitor(&self, name: String) -> anyhow::Result<Subscriber<MidiEvent>> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::GetMidiMonitor(name, tx))
            .unwrap();

        rx.recv().map_err(anyhow::Error::from).and_then(|r| r)
    }

    #[profiling::function]
    fn get_osc_monitor(&self, connection_id: String) -> anyhow::Result<Subscriber<OscMessage>> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::GetOscMonitor(connection_id, tx))
            .unwrap();

        rx.recv().map_err(anyhow::Error::from).and_then(|r| r)
    }

    #[profiling::function]
    fn get_device_manager(&self) -> DeviceManager {
        self.device_manager.clone()
    }

    #[profiling::function]
    fn get_gamepad_ref(&self, id: String) -> anyhow::Result<Option<GamepadRef>> {
        let gamepad = self.get_gamepad(id);

        Ok(gamepad)
    }

    #[profiling::function]
    fn read_fader_value(&self, node_path: NodePath) -> anyhow::Result<f64> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::ReadFaderValue(node_path, tx))?;

        rx.recv()?
    }

    #[profiling::function]
    fn read_settings(&self) -> Settings {
        self.settings.read().settings
    }

    #[profiling::function]
    fn save_settings(&self, settings: Settings) -> anyhow::Result<()> {
        let mut settings_manager = self.settings.read();
        let refresh_fixture_libraries =
            settings_manager.settings.paths.fixture_libraries != settings.paths.fixture_libraries;
        settings_manager.settings = settings;
        self.settings_bus.send(settings_manager.settings.clone());
        settings_manager.save()?;
        if refresh_fixture_libraries {
            let (tx, rx) = flume::bounded(1);
            self.sender.send(ApiCommand::ReloadFixtureLibraries(
                settings_manager.settings.paths.fixture_libraries,
                tx,
            ))?;

            rx.recv()?
        } else {
            Ok(())
        }
    }

    fn observe_settings(&self) -> Subscriber<Settings> {
        self.settings_bus.subscribe()
    }

    #[profiling::function]
    fn layouts_view(&self) -> LayoutsView {
        self.access.layouts_view.clone()
    }

    fn reload_midi_device_profiles(&self) -> anyhow::Result<()> {
        let status_handle = self.api_injector.require_service::<StatusHandle>();
        let registry = self
            .api_injector
            .require_service::<MidiDeviceProfileRegistry>();
        let loaded_profiles = registry
            .load_device_profiles(&self.settings.read().settings.paths.midi_device_profiles)?;
        status_handle.add_message(
            format!("Loaded {loaded_profiles} MIDI Device Profiles"),
            None,
        );

        Ok(())
    }

    fn reload_fixture_definitions(&self) -> anyhow::Result<()> {
        let settings_manager = self.settings.read();
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::ReloadFixtureLibraries(
            settings_manager.settings.paths.fixture_libraries,
            tx,
        ))?;

        rx.recv()?
    }

    #[profiling::function]
    fn open_nodes_view(&self) {
        tracing::debug!("Opening nodes view");
        self.open_node_views
            .fetch_add(1, std::sync::atomic::Ordering::SeqCst);
        self.update_read_node_metadata();
    }

    #[profiling::function]
    fn close_nodes_view(&self) {
        tracing::debug!("Closing nodes view");
        self.open_node_views
            .fetch_sub(1, std::sync::atomic::Ordering::SeqCst);
        self.update_read_node_metadata();
    }

    #[profiling::function]
    fn open_node_settings(&self, paths: Vec<NodePath>) {
        tracing::debug!("Opening node settings {paths:?}");
        self.access.read_node_settings.set(paths);
    }
}

impl Api {
    pub fn setup(
        runtime: &DefaultRuntime,
        api_injector: ApiInjector,
        settings: Arc<NonEmptyPinboard<SettingsManager>>,
    ) -> (ApiHandler, Api) {
        let (tx, rx) = flume::unbounded();
        let access = runtime.access();
        let command_executor_api = api_injector.require_service();
        let device_manager = api_injector.require_service();

        (
            ApiHandler { recv: rx },
            Api {
                sender: tx,
                api_injector,
                command_executor_api,
                access,
                settings,
                settings_bus: MessageBus::new(),
                history_bus: MessageBus::new(),
                device_manager,
                open_node_views: Arc::new(AtomicU8::new(0)),
            },
        )
    }

    fn emit_history(&self) -> anyhow::Result<()> {
        let history = self.execute_query(GetCommandHistoryQuery)?;
        tracing::debug!("Emitting history {:?}", history);
        self.history_bus.send(history);

        Ok(())
    }

    fn get_gamepad(&self, id: String) -> Option<GamepadRef> {
        self.device_manager
            .get_gamepad(&id)
            .map(|gamepad| gamepad.value().clone())
    }

    fn update_read_node_metadata(&self) {
        let open_views = self
            .open_node_views
            .load(std::sync::atomic::Ordering::SeqCst);
        tracing::debug!("Open views: {open_views}");
        self.access
            .read_node_metadata
            .store(open_views > 0, std::sync::atomic::Ordering::SeqCst);
    }
}
