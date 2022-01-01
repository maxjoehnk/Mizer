use crate::models;
use mizer_settings::Settings;
use pinboard::NonEmptyPinboard;
use std::sync::Arc;

#[derive(Clone)]
pub struct SettingsHandler {
    settings: Arc<NonEmptyPinboard<Settings>>,
}

impl SettingsHandler {
    pub fn new(settings: Arc<NonEmptyPinboard<Settings>>) -> Self {
        Self { settings }
    }

    pub fn get_settings(&self) -> models::Settings {
        self.settings.read().into()
    }
}
