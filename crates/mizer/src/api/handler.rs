use std::path::PathBuf;

use mizer_clock::Clock;
use mizer_fixtures::library::FixtureLibrary;
use mizer_message_bus::Subscriber;
use mizer_module::Runtime;
use mizer_protocol_midi::{MidiConnectionManager, MidiEvent};
use mizer_protocol_osc::{OscConnectionManager, OscMessage};
use mizer_runtime::Pipeline;
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
                let pipeline = mizer.runtime.injector_mut().get_mut::<Pipeline>().unwrap();
                pipeline.write_port(path, port, value);

                sender
                    .send(Ok(()))
                    .expect("api command sender disconnected");
            }
            ApiCommand::ReadFaderValue(path, sender) => {
                profiling::scope!("ApiCommand::ReadFaderValue");
                let pipeline = mizer.runtime.injector().get::<Pipeline>().unwrap();
                let value = pipeline
                    .read_state::<f64>(&path)
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
                    tracing::error!("Unable to respond to ApiCommand::GetNodeMetadataRef: {err:?}");
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
        }
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
