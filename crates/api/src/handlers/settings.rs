use crate::proto::settings as models;
use crate::RuntimeApi;
use futures::{Stream, StreamExt};
use mizer_connections::midi_device_profile::MidiDeviceProfileRegistry;

#[derive(Clone)]
pub struct SettingsHandler<R: RuntimeApi> {
    runtime: R,
    profile_registry: MidiDeviceProfileRegistry,
}

impl<R: RuntimeApi> SettingsHandler<R> {
    pub fn new(runtime: R, profile_registry: MidiDeviceProfileRegistry) -> Self {
        Self {
            runtime,
            profile_registry,
        }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_settings(&self) -> models::Settings {
        self.runtime.read_settings().into()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn save_settings(&self, settings: models::Settings) -> anyhow::Result<()> {
        self.runtime.save_settings(settings.into())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn watch_settings(&self) -> impl Stream<Item = models::Settings> {
        self.runtime
            .observe_settings()
            .into_stream()
            .map(models::Settings::from)
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn load_midi_device_profiles(&self) -> models::MidiDeviceProfiles {
        self.profile_registry.list_device_profiles().into()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn reload_midi_device_profiles(&self) -> anyhow::Result<()> {
        self.runtime.reload_midi_device_profiles()
    }
}
