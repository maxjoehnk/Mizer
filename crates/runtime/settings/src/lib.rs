use std::io::{Read, Write};
use std::path::PathBuf;

use directories_next::ProjectDirs;
use crate::defaults::get_default_settings;
pub use crate::settings::*;
pub use crate::hotkeys::*;
pub use crate::update::*;
use crate::user_settings::UserSettings;
pub use crate::preferences::*;

mod defaults;
mod settings;
mod hotkeys;
mod update;
mod user_settings;
mod preferences;
mod migrate;

#[derive(Debug, Clone)]
pub struct SettingsManager {
    defaults: Settings,
    pub settings: Settings,
    pub user_settings: UserSettings,
}

impl SettingsManager {
    pub fn new() -> anyhow::Result<Self> {
        tracing::trace!("Loading default settings");
        let settings = get_default_settings();

        Ok(Self { defaults: settings.clone(), settings, user_settings: Default::default() })
    }

    pub fn read(&self) -> Vec<Preference> {
        let changed = self.user_settings.get_changed_settings();
        let preferences = self.settings.as_preferences(changed);

        preferences
    }

    pub fn update(&mut self, path: String, value: UpdateSettingValue) -> anyhow::Result<()> {
        self.user_settings.set(path.clone(), value.clone());
        self.settings.update_setting(path, value)?;

        Ok(())
    }

    pub fn reset(&mut self, path: String) -> anyhow::Result<()> {
        self.settings.reset_setting(&path, &self.defaults)?;
        self.user_settings.reset_to_default(&path);

        Ok(())
    }

    pub fn load(&mut self) -> anyhow::Result<()> {
        let Some(path) = Self::get_config_path() else {
            return Ok(());
        };
        tracing::trace!("Settings path: {path:?}");
        if path.exists() {
            tracing::debug!("Loading settings from {path:?}");
            let mut file = std::fs::File::open(&path)?;
            let mut buffer = String::new();
            file.read_to_string(&mut buffer)?;
            let mut migrated = false;

            match toml::from_str(&buffer) {
                Ok(user_settings) => self.user_settings = user_settings,
                Err(err) => {
                    tracing::warn!(?err, "Failed to parse settings file. This might be because of an old format, trying to migrate...");

                    migrate::migrate_settings(&path, &mut self.user_settings)?;
                    migrated = true;
                }
            }
            for (path, value) in self.user_settings.get_settings() {
                if let Err(err) = self.settings.update_setting(path.clone(), value.clone()) {
                    tracing::error!("Failed to update setting {path}: {err}");
                    self.user_settings.reset_to_default(&path);
                }
            }
            if migrated {
                self.save()?;
            }
        }

        Ok(())
    }

    pub fn save(&self) -> anyhow::Result<()> {
        let path =
            Self::get_config_path().ok_or_else(|| anyhow::anyhow!("No config path found"))?;

        std::fs::create_dir_all(
            path.parent()
                .ok_or_else(|| anyhow::anyhow!("Invalid config path"))?,
        )?;
        let mut file = std::fs::File::create(path)?;
        let file_contents = toml::to_string(&self.user_settings)?;
        file.write_all(file_contents.as_bytes())?;

        Ok(())
    }

    fn get_config_path() -> Option<PathBuf> {
        ProjectDirs::from("live", "mizer", "Mizer")
            .map(|dirs| dirs.config_dir().join("settings.toml"))
    }
}
