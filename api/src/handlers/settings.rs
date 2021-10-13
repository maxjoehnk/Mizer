use std::sync::Arc;
use pinboard::NonEmptyPinboard;
use mizer_settings::Settings;
use crate::models;

#[derive(Clone)]
pub struct SettingsHandler {
    settings: Arc<NonEmptyPinboard<Settings>>
}

impl SettingsHandler {
    pub fn new(settings: Arc<NonEmptyPinboard<Settings>>) -> Self {
        Self {
            settings
        }
    }

    pub fn get_settings(&self) -> models::Settings {
        self.settings.read().into()
    }
}
