use std::path::PathBuf;
use std::ops::Deref;

use crate::{ApiCommand, Mizer};
use mizer_clock::Clock;
use mizer_connections::{Connection, MidiView};
use mizer_module::Runtime;
use mizer_protocol_midi::{MidiDeviceProvider, MidiConnectionManager, MidiDevice};

pub struct ApiHandler {
    pub(super) recv: flume::Receiver<ApiCommand>,
}

impl ApiHandler {
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
            ApiCommand::GetNodePreview(path, sender) => {
                if let Some(history) = mizer.runtime.pipeline.get_history(&path) {
                    sender
                        .send(Ok(history))
                        .expect("api command sender disconnected");
                } else {
                    sender
                        .send(Err(anyhow::anyhow!("No Preview for given node")))
                        .expect("api command sender disconnected");
                }
            }
            ApiCommand::UpdateNode(path, config, sender) => {
                sender
                    .send(mizer.runtime.handle_update_node(path, config))
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
                mizer.close_project();
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
                sender.send(connections).expect("api command sender disconnected");
            }
        }
    }

    fn get_connections(&self, mizer: &mut Mizer) -> Vec<Connection> {
        let manager = mizer.runtime.injector().get::<MidiConnectionManager>().unwrap();
        manager.list_available_devices()
            .into_iter()
            .map(|device| MidiView {
                name: device.name
            })
            .map(Connection::from)
            .collect()
    }
}
