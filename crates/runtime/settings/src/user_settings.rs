use std::collections::{HashMap, HashSet};
use serde::{Deserialize, Serialize};
use crate::UpdateSettingValue;

#[derive(Default, Debug, Clone, Deserialize, Serialize)]
#[serde(transparent)]
pub struct UserSettings(HashMap<String, UpdateSettingValue>);

impl UserSettings {
    pub fn reset_to_default(&mut self, path: &str) {
        self.0.remove(path);
    }

    pub fn set(&mut self, path: String, value: UpdateSettingValue) {
        self.0.insert(path, value);
    }

    pub fn get_settings(&self) -> Vec<(String, UpdateSettingValue)> {
        self.0.iter().map(|(k, v)| (k.clone(), v.clone())).collect()
    }
    
    pub fn get_changed_settings(&self) -> HashSet<String> {
        self.0.keys().cloned().collect()
    }
}
