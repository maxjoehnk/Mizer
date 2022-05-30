use std::collections::HashMap;

use mizer_api::RuntimeApi;
use mizer_clock::{ClockSnapshot, ClockState};
use mizer_connections::{midi_device_profile::DeviceProfile, Connection};
use mizer_layouts::Layout;
use mizer_node::{NodeDesigner, NodeLink, NodePath, PortId};
use mizer_runtime::{DefaultRuntime, NodeDescriptor, RuntimeAccess};
use mizer_session::SessionState;

use crate::{ApiCommand, ApiHandler};
use mizer_command_executor::{CommandExecutorApi, SendableCommand};
use mizer_message_bus::{MessageBus, Subscriber};
use mizer_protocol_midi::MidiEvent;
use mizer_settings::{Settings, SettingsManager};
use pinboard::NonEmptyPinboard;
use std::sync::Arc;

#[derive(Clone)]
pub struct Api {
    access: RuntimeAccess,
    command_executor_api: CommandExecutorApi,
    sender: flume::Sender<ApiCommand>,
    settings: Arc<NonEmptyPinboard<SettingsManager>>,
    settings_bus: MessageBus<Settings>,
    history_bus: MessageBus<(Vec<(String, u128)>, usize)>,
}

impl RuntimeApi for Api {
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

    fn nodes(&self) -> Vec<NodeDescriptor> {
        let designer = self.access.designer.read();
        self.access
            .nodes
            .iter()
            .map(|entry| entry.key().clone())
            .map(|path| self.get_descriptor(path, &designer))
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

    fn write_node_port(&self, node_path: NodePath, port: PortId, value: f64) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::WritePort(node_path, port, value, tx))?;

        rx.recv()?
    }

    fn get_node_history_ref(
        &self,
        node: NodePath,
    ) -> anyhow::Result<Option<Arc<NonEmptyPinboard<Vec<f64>>>>> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::GetNodePreviewRef(node, tx))?;

        let value = rx.recv()?;

        Ok(value)
    }

    fn get_node(&self, path: &NodePath) -> Option<NodeDescriptor> {
        let designer = self.access.designer.read();
        self.access
            .nodes
            .iter()
            .map(|entry| entry.key().clone())
            .find(|node_path| node_path == path)
            .map(|path| self.get_descriptor(path, &designer))
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

    fn get_connections(&self) -> Vec<Connection> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::GetConnections(tx)).unwrap();

        rx.recv().unwrap()
    }

    fn add_sacn_connection(&self, name: String) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::AddSacnConnection(name, tx))?;

        rx.recv()?
    }

    fn add_artnet_connection(
        &self,
        name: String,
        host: String,
        port: Option<u16>,
    ) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::AddArtnetConnection(name, (host, port), tx))?;

        rx.recv()?
    }

    fn get_midi_device_profiles(&self) -> Vec<DeviceProfile> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::GetMidiDeviceProfiles(tx))
            .unwrap();

        rx.recv().unwrap()
    }

    fn get_dmx_monitor(&self, output_id: String) -> anyhow::Result<HashMap<u16, [u8; 512]>> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::GetDmxMonitor(output_id, tx))
            .unwrap();

        rx.recv().unwrap()
    }

    fn get_midi_monitor(&self, name: String) -> anyhow::Result<Subscriber<MidiEvent>> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::GetMidiMonitor(name, tx))
            .unwrap();

        rx.recv().map_err(anyhow::Error::from).and_then(|r| r)
    }

    fn read_fader_value(&self, node_path: NodePath) -> anyhow::Result<f64> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::ReadFaderValue(node_path, tx))?;

        rx.recv()?
    }

    fn read_settings(&self) -> Settings {
        self.settings.read().settings
    }

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
                settings_manager.settings.paths.fixture_libraries.clone(),
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
}

impl Api {
    pub fn setup(
        runtime: &DefaultRuntime,
        command_executor_api: CommandExecutorApi,
        settings: Arc<NonEmptyPinboard<SettingsManager>>,
    ) -> (ApiHandler, Api) {
        let (tx, rx) = flume::unbounded();
        let access = runtime.access();

        (
            ApiHandler { recv: rx },
            Api {
                sender: tx,
                command_executor_api,
                access,
                settings,
                settings_bus: MessageBus::new(),
                history_bus: MessageBus::new(),
            },
        )
    }

    fn get_descriptor(
        &self,
        path: NodePath,
        designer: &HashMap<NodePath, NodeDesigner>,
    ) -> NodeDescriptor {
        let node = self.access.nodes.get(&path).unwrap();
        let ports = node.list_ports();
        let designer = designer[&path].clone();

        NodeDescriptor {
            path,
            node,
            designer,
            ports,
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
}
