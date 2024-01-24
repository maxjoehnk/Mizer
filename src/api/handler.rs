use std::collections::HashMap;
use std::path::PathBuf;

use mizer_clock::Clock;
use mizer_command_executor::CommandHistory;
use mizer_connections::{midi_device_profile::DeviceProfile, *};
use mizer_devices::DeviceManager;
use mizer_fixtures::library::FixtureLibrary;
use mizer_message_bus::Subscriber;
use mizer_module::Runtime;
use mizer_protocol_dmx::{DmxConnectionManager, DmxInput, DmxOutput};
use mizer_protocol_midi::{MidiConnectionManager, MidiEvent};
use mizer_protocol_mqtt::MqttConnectionManager;
use mizer_protocol_osc::{OscConnectionManager, OscMessage};

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

    #[profiling::function]
    fn handle_command(&self, command: ApiCommand, mizer: &mut Mizer) {
        match command {
            ApiCommand::WritePort(path, port, value, sender) => {
                profiling::scope!("ApiCommand::WritePort");
                mizer.runtime.pipeline.write_port(path, port, value);

                sender
                    .send(Ok(()))
                    .expect("api command sender disconnected");
            }
            ApiCommand::ReadFaderValue(path, sender) => {
                profiling::scope!("ApiCommand::ReadFaderValue");
                let value = mizer
                    .runtime
                    .pipeline
                    .get_state::<f64>(&path)
                    .copied()
                    .ok_or_else(|| anyhow::anyhow!("No fader node with given path found"));

                sender.send(value).expect("api command sender disconnected");
            }
            ApiCommand::GetNodePreviewRef(path, sender) => {
                profiling::scope!("ApiCommand::GetNodePreviewRef");
                sender
                    .send(mizer.runtime.get_preview_ref(&path))
                    .expect("api command sender disconnected")
            }
            ApiCommand::GetNodeMetadataRef(sender) => {
                profiling::scope!("ApiCommand::GetNodeMetadataRef");
                if let Err(err) = sender.send(mizer.runtime.get_node_metadata_ref()) {
                    log::error!("Unable to respond to ApiCommand::GetNodeMetadataRef: {err:?}");
                }
            }
            ApiCommand::SetClockState(state) => {
                profiling::scope!("ApiCommand::SetClockState");
                mizer.runtime.clock.set_state(state);
            }
            ApiCommand::SetBpm(bpm) => {
                profiling::scope!("ApiCommand::SetBpm");
                let speed = mizer.runtime.clock.speed_mut();
                *speed = bpm;
            }
            ApiCommand::SetFps(fps) => {
                profiling::scope!("ApiCommand::SetFps");
                mizer.runtime.set_fps(fps);
            }
            ApiCommand::SaveProject(sender) => {
                profiling::scope!("ApiCommand::SaveProject");
                let result = mizer.save_project();
                sender
                    .send(result)
                    .expect("api command sender disconnected");
            }
            ApiCommand::SaveProjectAs(path, sender) => {
                profiling::scope!("ApiCommand::SaveProjectAs");
                let result = mizer.save_project_as(PathBuf::from(&path));
                sender
                    .send(result)
                    .expect("api command sender disconnected");
            }
            ApiCommand::NewProject(sender) => {
                profiling::scope!("ApiCommand::NewProject");
                mizer.new_project();
                sender
                    .send(Ok(()))
                    .expect("api command sender disconnected");
            }
            ApiCommand::LoadProject(path, sender) => {
                profiling::scope!("ApiCommand::LoadProject");
                let result = mizer.load_project_from(PathBuf::from(&path));
                sender
                    .send(result)
                    .expect("api command sender disconnected");
            }
            ApiCommand::GetConnections(sender) => {
                profiling::scope!("ApiCommand::GetConnections");
                let connections = self.get_connections(mizer);
                sender
                    .send(connections)
                    .expect("api command sender disconnected");
            }
            ApiCommand::GetMidiDeviceProfiles(sender) => {
                profiling::scope!("ApiCommand::GetMidiDeviceProfiles");
                let device_profiles = self.get_midi_device_profiles(mizer);
                sender
                    .send(device_profiles)
                    .expect("api command sender disconnected");
            }
            ApiCommand::GetDmxMonitor(output_id, sender) => {
                profiling::scope!("ApiCommand::GetDmxMonitor");
                let result = self.monitor_dmx(mizer, output_id);
                sender
                    .send(result)
                    .expect("api command sender disconnected");
            }
            ApiCommand::GetMidiMonitor(name, sender) => {
                profiling::scope!("ApiCommand::GetMidiMonitor");
                let result = self.monitor_midi(mizer, name);
                sender
                    .send(result)
                    .expect("api command sender disconnected");
            }
            ApiCommand::GetOscMonitor(id, sender) => {
                profiling::scope!("ApiCommand::GetOscMonitor");
                let result = self.monitor_osc(mizer, id);
                sender
                    .send(result)
                    .expect("api command sender disconnected");
            }
            ApiCommand::ObserveSession(sender) => {
                profiling::scope!("ApiCommand::ObserveSession");
                sender
                    .send(mizer.session_events.subscribe())
                    .expect("api command sender disconnected");
            }
            ApiCommand::ReloadFixtureLibraries(paths, sender) => {
                profiling::scope!("ApiCommand::ReloadFixtureLibraries");
                let injector = mizer.runtime.injector();
                let library = injector.get::<FixtureLibrary>().unwrap();
                let result = library.reload(paths);

                sender
                    .send(result)
                    .expect("api command sender disconnected");
            }
            ApiCommand::GetHistory(sender) => {
                profiling::scope!("ApiCommand::GetHistory");
                let injector = mizer.runtime.injector();
                let history = injector.get::<CommandHistory>().unwrap();
                let result = history.items();
                let cursor = history.index();

                sender
                    .send((result, cursor))
                    .expect("api command sender disconnected");
            }
        }
    }

    #[profiling::function]
    fn get_connections(&self, mizer: &mut Mizer) -> Vec<Connection> {
        let manager = mizer
            .runtime
            .injector()
            .get::<MidiConnectionManager>()
            .unwrap();
        let midi_connections = manager
            .list_available_devices()
            .into_iter()
            .map(|device| MidiView {
                name: device.name,
                device_profile: device.profile.as_ref().map(|profile| profile.id.clone()),
            })
            .map(Connection::from);
        let dmx_manager = mizer
            .runtime
            .injector()
            .get::<DmxConnectionManager>()
            .unwrap();
        let dmx_outputs = dmx_manager
            .list_outputs()
            .into_iter()
            .map(|(id, output)| DmxOutputView {
                output_id: id.clone(),
                name: output.name(),
                config: match output {
                    mizer_protocol_dmx::DmxOutputConnection::Artnet(config) => {
                        DmxOutputConfig::Artnet {
                            host: config.host.clone(),
                            port: config.port,
                        }
                    }
                    mizer_protocol_dmx::DmxOutputConnection::Sacn(config) => {
                        DmxOutputConfig::Sacn {
                            priority: config.priority,
                        }
                    }
                },
            })
            .map(Connection::from);
        let dmx_inputs = dmx_manager
            .list_inputs()
            .into_iter()
            .map(|(id, input)| DmxInputView {
                input_id: id.clone(),
                name: input.name(),
                config: match input {
                    mizer_protocol_dmx::DmxInputConnection::Artnet(config) => {
                        DmxInputConfig::Artnet {
                            host: config.config.host.clone(),
                            port: config.config.port,
                        }
                    }
                },
            })
            .map(Connection::from);
        let mqtt_manager = mizer
            .runtime
            .injector()
            .get::<MqttConnectionManager>()
            .unwrap();
        let mqtt_connections = mqtt_manager
            .list_connections()
            .into_iter()
            .map(|(id, connection)| MqttView {
                connection_id: id.clone(),
                name: connection.address.url.to_string(),
                url: connection.address.url.to_string(),
                username: connection.address.username.clone(),
                password: connection.address.password.clone(),
            })
            .map(Connection::from);
        let osc_manager = mizer
            .runtime
            .injector()
            .get::<OscConnectionManager>()
            .unwrap();
        let osc_connections = osc_manager
            .list_connections()
            .into_iter()
            .map(|(id, connection)| OscView {
                connection_id: id.clone(),
                name: format!(
                    "{}://{}:{}",
                    connection.address.protocol,
                    connection.address.output_host,
                    connection.address.output_port
                ),
                output_host: connection.address.output_host.to_string(),
                output_port: connection.address.output_port,
                input_port: connection.address.input_port,
            })
            .map(Connection::from);
        let device_manager = mizer.runtime.injector().get::<DeviceManager>().unwrap();
        let devices = device_manager
            .current_devices()
            .into_iter()
            .map(Connection::from);

        let mut connections = Vec::new();
        connections.extend(midi_connections);
        connections.extend(dmx_outputs);
        connections.extend(dmx_inputs);
        connections.extend(mqtt_connections);
        connections.extend(osc_connections);
        connections.extend(devices);

        connections
    }

    fn get_midi_device_profiles(&self, mizer: &mut Mizer) -> Vec<DeviceProfile> {
        let manager = mizer
            .runtime
            .injector()
            .get::<MidiConnectionManager>()
            .unwrap();

        manager.list_available_device_profiles()
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

    fn monitor_midi(
        &self,
        mizer: &mut Mizer,
        name: String,
    ) -> anyhow::Result<Subscriber<MidiEvent>> {
        let midi_manager = mizer
            .runtime
            .injector()
            .get::<MidiConnectionManager>()
            .unwrap();
        let device = midi_manager
            .request_device(&name)?
            .ok_or_else(|| anyhow::anyhow!("Unknown Midi Device"))?;
        let subscriber = device.events();

        Ok(subscriber)
    }

    fn monitor_osc(&self, mizer: &mut Mizer, id: String) -> anyhow::Result<Subscriber<OscMessage>> {
        let osc_manager = mizer
            .runtime
            .injector()
            .get::<OscConnectionManager>()
            .unwrap();
        let subscription = osc_manager
            .subscribe(&id)?
            .ok_or_else(|| anyhow::anyhow!("Unknown Osc Connection"))?;
        let subscriber = subscription.events();

        Ok(subscriber)
    }
}
