use crate::{models, RuntimeApi};
use futures::{Stream, StreamExt};
use mizer_message_bus::Subscriber;

#[derive(Clone)]
pub struct SettingsHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> SettingsHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    pub fn get_settings(&self) -> models::Settings {
        self.runtime.read_settings().into()
    }

    pub fn save_settings(&self, settings: models::Settings) -> anyhow::Result<()> {
        self.runtime.save_settings(settings.into())
    }

    pub fn watch_settings(&self) -> impl Stream<Item = models::Settings> {
        self.runtime
            .observe_settings()
            .into_stream()
            .map(models::Settings::from)
    }
}
