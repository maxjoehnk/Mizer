use std::collections::HashMap;
use std::sync::Arc;

use pinboard::NonEmptyPinboard;

use mizer_api::{GamepadRef, RuntimeApi};
use mizer_clock::{ClockSnapshot, ClockState};
use mizer_command_executor::{CommandExecutorApi, SendableCommand};
use mizer_connections::{midi_device_profile::DeviceProfile, Connection};
use mizer_devices::DeviceManager;
use mizer_layouts::Layout;
use mizer_message_bus::{MessageBus, Subscriber};
use mizer_module::ApiInjector;
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodePreviewRef, NodeSetting, PortId};
use mizer_protocol_midi::MidiEvent;
use mizer_protocol_osc::OscMessage;
use mizer_runtime::{DefaultRuntime, LayoutsView, NodeDescriptor, NodeMetadataRef, RuntimeAccess};
use mizer_session::SessionState;
use mizer_settings::{Settings, SettingsManager};

use crate::{ApiCommand, ApiHandler};

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
}

impl RuntimeApi for Api {
    #[profiling::function]
    fn run_command<'a, T: SendableCommand<'a> + 'static>(
        &self,
        command: T,
    ) -> anyhow::Result<T::Result> {
        let result = self.command_executor_api.run_command(command)?;
        self.emit_history()?;

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

    fn observe_history(&self) -> Subscriber<(Vec<(String, u128)>, usize)> {
        self.history_bus.subscribe()
    }

    #[profiling::function]
    fn nodes(&self) -> Vec<NodeDescriptor> {
        let designer = self.access.designer.read();
        let settings = self.access.settings.read();
        self.access
            .nodes
            .iter()
            .map(|entry| entry.key().clone())
            .map(|path| self.get_descriptor(path, &designer, &settings))
            .collect()
    }

    fn links(&self) -> Vec<NodeLink> {
        self.access.links.read()
    }

    fn layouts(&self) -> Vec<Layout> {
        self.access.layouts.read()
    }

    fn plans(&self) -> Vec<mizer_plan::Plan> {
        self.access.plans.read()
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

    #[profiling::function]
    fn get_node(&self, path: &NodePath) -> Option<NodeDescriptor> {
        let designer = self.access.designer.read();
        let settings = self.access.settings.read();
        self.access
            .nodes
            .iter()
            .map(|entry| entry.key().clone())
            .find(|node_path| node_path == path)
            .map(|path| self.get_descriptor(path, &designer, &settings))
    }

    fn set_clock_state(&self, state: ClockState) -> anyhow::Result<()> {
        self.sender.send(ApiCommand::SetClockState(state))?;

        Ok(())
    }

    fn set_bpm(&self, bpm: f64) -> anyhow::Result<()> {
        self.sender.send(ApiCommand::SetBpm(bpm))?;

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
    fn get_connections(&self) -> Vec<Connection> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::GetConnections(tx)).unwrap();

        rx.recv().unwrap()
    }

    #[profiling::function]
    fn get_midi_device_profiles(&self) -> Vec<DeviceProfile> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::GetMidiDeviceProfiles(tx))
            .unwrap();

        rx.recv().unwrap()
    }

    #[profiling::function]
    fn get_dmx_monitor(&self, output_id: String) -> anyhow::Result<HashMap<u16, [u8; 512]>> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::GetDmxMonitor(output_id, tx))
            .unwrap();

        rx.recv().unwrap()
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

    #[profiling::function]
    fn get_service<T: 'static + Send + Sync + Clone>(&self) -> Option<&T> {
        self.api_injector.get()
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
            },
        )
    }

    #[profiling::function]
    fn get_descriptor(
        &self,
        path: NodePath,
        designer: &HashMap<NodePath, NodeDesigner>,
        settings: &HashMap<NodePath, Vec<NodeSetting>>,
    ) -> NodeDescriptor {
        let node = self.access.nodes.get(&path).unwrap();
        let ports = node.list_ports();
        let settings = settings.get(&path).cloned().unwrap_or_default();
        let designer = designer[&path].clone();

        NodeDescriptor {
            path,
            node,
            designer,
            ports,
            settings,
        }
    }

    fn emit_history(&self) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::GetHistory(tx))?;

        let history = rx.recv()?;
        log::debug!("Emitting history {:?}", history);
        self.history_bus.send(history);

        Ok(())
    }

    fn get_gamepad(&self, id: String) -> Option<GamepadRef> {
        self.device_manager
            .get_gamepad(&id)
            .map(|gamepad| gamepad.value().clone())
    }
}
