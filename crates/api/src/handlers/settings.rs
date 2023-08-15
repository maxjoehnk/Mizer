use crate::proto::settings as models;
use crate::RuntimeApi;
use futures::{Stream, StreamExt};

#[derive(Clone)]
pub struct SettingsHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> SettingsHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
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
}
