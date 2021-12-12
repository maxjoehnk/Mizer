use std::collections::HashMap;
use std::path::PathBuf;

use mizer_clock::Clock;
use mizer_connections::{Connection, DmxView, MidiView};
use mizer_module::Runtime;
use mizer_protocol_dmx::{ArtnetOutput, DmxConnectionManager, DmxOutput, SacnOutput};
use mizer_protocol_midi::MidiConnectionManager;

use crate::{ApiCommand, Mizer};

pub struct ApiHandler {
    pub(super) recv: flume::Receiver<ApiCommand>,
}

impl ApiHandler {
    #[profiling::function]
    pub fn handle(&self, mizer: &mut Mizer) {
        loop {
            match self.recv.try_recv() {
                Ok(cmd) => self.handle_command(cmd, mizer),
                Err(flume::TryRecvError::Empty) => break,
                Err(flume::TryRecvError::Disconnected) => {
                    panic!("api command receiver disconnected")
                }
            }
        }
    }

    fn handle_command(&self, command: ApiCommand, mizer: &mut Mizer) {
        match command {
            ApiCommand::AddNode(node_type, designer, node, sender) => {
                let result = mizer.runtime.handle_add_node(node_type, designer, node);

                sender
                    .send(result)
                    .expect("api command sender disconnected");
            }
            ApiCommand::WritePort(path, port, value, sender) => {
                mizer.runtime.pipeline.write_port(path, port, value);

                sender
                    .send(Ok(()))
                    .expect("api command sender disconnected");
            }
            ApiCommand::AddLink(link, sender) => {
                let result = mizer.runtime.add_link(link);

                sender
                    .send(result)
                    .expect("api command sender disconnected");
            }
            ApiCommand::GetNodePreviewRef(path, sender) => sender.send(mizer.runtime.get_history_ref(&path))
                .expect("api command sender disconnected"),
            ApiCommand::UpdateNode(path, config, sender) => {
                sender
                    .send(mizer.runtime.handle_update_node(path, config))
                    .expect("api command sender disconnected");
            }
            ApiCommand::DeleteNode(path, sender) => {
                sender
                    .send(mizer.runtime.delete_node(path))
                    .expect("api command sender disconnected");
            }
            ApiCommand::SetClockState(state) => {
                mizer.runtime.clock.set_state(state);
            }
            ApiCommand::SaveProject(sender) => {
                let result = mizer.save_project();
                sender
                    .send(result)
                    .expect("api command sender disconnected");
            }
            ApiCommand::SaveProjectAs(path, sender) => {
                let result = mizer.save_project_as(PathBuf::from(&path));
                sender
                    .send(result)
                    .expect("api command sender disconnected");
            }
            ApiCommand::NewProject(sender) => {
                mizer.new_project();
                sender
                    .send(Ok(()))
                    .expect("api command sender disconnected");
            }
            ApiCommand::LoadProject(path, sender) => {
                let result = mizer.load_project_from(PathBuf::from(&path));
                sender
                    .send(result)
                    .expect("api command sender disconnected");
            }
            ApiCommand::GetConnections(sender) => {
                let connections = self.get_connections(mizer);
                sender
                    .send(connections)
                    .expect("api command sender disconnected");
            }
            ApiCommand::AddArtnetConnection(name, (host, port), sender) => {
                let result = self.add_artnet_connection(mizer, name, host, port);
                sender
                    .send(result)
                    .expect("api command sender disconnected")
            }
            ApiCommand::AddSacnConnection(name, sender) => {
                let result = self.add_sacn_connection(mizer, name);
                sender
                    .send(result)
                    .expect("api command sender disconnected")
            }
            ApiCommand::GetDmxMonitor(output_id, sender) => {
                let result = self.monitor_dmx(mizer, output_id);
                sender
                    .send(result)
                    .expect("api command sender disconnected");
            }
        }
    }

    fn get_connections(&self, mizer: &mut Mizer) -> Vec<Connection> {
        let manager = mizer
            .runtime
            .injector()
            .get::<MidiConnectionManager>()
            .unwrap();
        let midi_connections = manager
            .list_available_devices()
            .into_iter()
            .map(|device| MidiView { name: device.name })
            .map(Connection::from);
        let dmx_manager = mizer
            .runtime
            .injector()
            .get::<DmxConnectionManager>()
            .unwrap();
        let dmx_connections = dmx_manager
            .list_outputs()
            .into_iter()
            .map(|(id, output)| DmxView {
                output_id: id.clone(),
                name: output.name(),
            })
            .map(Connection::from);

        let mut connections = Vec::new();
        connections.extend(midi_connections);
        connections.extend(dmx_connections);

        connections
    }

    fn add_artnet_connection(&self, mizer: &mut Mizer, name: String, host: String, port: Option<u16>) -> anyhow::Result<()> {
        let output = ArtnetOutput::new(host, port)?;
        let dmx_manager = mizer
            .runtime
            .injector_mut()
            .get_mut::<DmxConnectionManager>()
            .unwrap();
        dmx_manager.add_output(name, output);

        Ok(())
    }

    fn add_sacn_connection(&self, mizer: &mut Mizer, name: String) -> anyhow::Result<()> {
        let output = SacnOutput::new();
        let dmx_manager = mizer
            .runtime
            .injector_mut()
            .get_mut::<DmxConnectionManager>()
            .unwrap();
        dmx_manager.add_output(name, output);

        Ok(())
    }

    fn monitor_dmx(
        &self,
        mizer: &mut Mizer,
        output_id: String,
    ) -> anyhow::Result<HashMap<u16, [u8; 512]>> {
        let dmx_manager = mizer
            .runtime
            .injector()
            .get::<DmxConnectionManager>()
            .unwrap();
        let dmx_connection = dmx_manager.get_output(&output_id).unwrap();
        let buffer = dmx_connection.read_buffer();

        Ok(buffer)
    }
}
