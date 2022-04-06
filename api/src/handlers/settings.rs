use crate::{models, RuntimeApi};

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
}
