use crate::proto::settings as model;
use facet::{Facet, Peek};
use mizer_connections::midi_device_profile;
use mizer_settings as settings;
use mizer_settings::HotkeyGroup;
use std::collections::HashMap;
use std::hash::Hash;
use std::path::PathBuf;
use indexmap::IndexMap;

impl From<(settings::Settings, Vec<settings::Preference>)> for model::Settings {
    fn from((settings, preferences): (settings::Settings, Vec<settings::Preference>)) -> Self {
        let mut ui: model::UiSettings = settings.hotkeys.into();
        ui.language = settings.general.language.to_string();

        let mut settings = Self {
            ui: Some(ui),
            ..Default::default()
        };

        let mut categories = IndexMap::new();

        for preference in preferences {
            let category = categories
                .entry(preference.category.clone())
                .or_insert_with(IndexMap::new);
            let group = category
                .entry(preference.group.clone())
                .or_insert_with(Vec::new);
            group.push(preference.into());
        }

        for (category, groups) in categories {
            settings.categories.push(model::SettingsCategory {
                title: category,
                groups: groups
                    .into_iter()
                    .map(|(group, settings)| model::SettingsGroup {
                        title: group,
                        settings,
                    })
                    .collect(),
            })
        }

        settings
    }
}

impl From<settings::Preference> for model::Setting {
    fn from(preference: settings::Preference) -> Self {
        model::Setting {
            title: preference.title,
            key: preference.key,
            value: Some(preference.value.into()),
            default_value: preference.default_value,
        }
    }
}

impl From<settings::PreferenceValue> for model::setting::Value {
    fn from(value: settings::PreferenceValue) -> Self {
        match value {
            settings::PreferenceValue::Boolean(value) => {
                model::setting::Value::Boolean(model::BoolSetting { value })
            }
            settings::PreferenceValue::Select { selected, options } => model::setting::Value::Select(model::SelectSetting {
                selected,
                values: options.into_iter().map(|option| model::SelectOption { value: option.value, title: option.title }).collect()
            }),
            settings::PreferenceValue::Path(value) => model::setting::Value::Path(model::PathSetting { path: path_to_string(&value) }),
            settings::PreferenceValue::PathList(value) => model::setting::Value::PathList(model::PathListSetting {
                paths: value.iter().map(path_to_string).collect()
            }),
            settings::PreferenceValue::Hotkey(value) => model::setting::Value::Hotkey(model::HotkeySetting {
                combination: value,
            }),
        }
    }
}

fn path_to_string(path: &PathBuf) -> String {
    path.to_string_lossy().to_string()
}

impl From<model::update_setting::Value> for settings::UpdateSettingValue {
    fn from(value: model::update_setting::Value) -> Self {
        match value {
            model::update_setting::Value::Boolean(value) => Self::Bool(value),
            model::update_setting::Value::Select(value) => Self::Select(value),
            model::update_setting::Value::Path(value) => Self::Path(PathBuf::from(value)),
            model::update_setting::Value::PathList(value) => {
                Self::PathList(value.paths.into_iter().map(PathBuf::from).collect())
            }
            model::update_setting::Value::Hotkey(value) => Self::Hotkey(value),
        }
    }
}

impl From<settings::Hotkeys> for model::UiSettings {
    fn from(hotkeys: settings::Hotkeys) -> Self {
        let mut map = HashMap::new();
        map.insert("global".into(), map_hotkey_map(hotkeys.global));
        map.insert("programmer".into(), map_hotkey_map(hotkeys.programmer));
        map.insert("nodes".into(), map_hotkey_map(hotkeys.nodes));
        map.insert("layouts".into(), map_hotkey_map(hotkeys.layouts));
        map.insert("patch".into(), map_hotkey_map(hotkeys.patch));
        map.insert("sequencer".into(), map_hotkey_map(hotkeys.sequencer));
        map.insert("plan".into(), map_hotkey_map(hotkeys.plan));
        map.insert("effects".into(), map_hotkey_map(hotkeys.effects));
        map.insert("media".into(), map_hotkey_map(hotkeys.media));

        Self {
            language: Default::default(),
            hotkeys: map,
        }
    }
}

fn map_hotkey_map<'facet, T: Facet<'facet>>(group: HotkeyGroup<T>) -> model::Hotkeys
where
    T: PartialEq + Eq + Hash,
{
    let hotkeys = group
        .into_iter()
        .map(|(key, value)| {
            let active_variant = Peek::new(&key)
                .into_enum()
                .expect("Hotkey key must be an enum")
                .active_variant()
                .expect("Hotkey key must be a variant");
            let name = active_variant
                .rename
                .unwrap_or(active_variant.name)
                .to_string();

            (name, value)
        })
        .collect();

    model::Hotkeys { keys: hotkeys }
}

impl From<Vec<midi_device_profile::DeviceProfile>> for model::MidiDeviceProfiles {
    fn from(profiles: Vec<midi_device_profile::DeviceProfile>) -> Self {
        Self {
            profiles: profiles.into_iter().map(|p| p.into()).collect(),
        }
    }
}

impl From<midi_device_profile::DeviceProfile> for model::MidiDeviceProfile {
    fn from(profile: midi_device_profile::DeviceProfile) -> Self {
        Self {
            id: profile.id,
            manufacturer: profile.manufacturer,
            name: profile.name,
            file_path: profile.file_path.to_string_lossy().to_string(),
            errors: profile
                .errors
                .errors()
                .into_iter()
                .map(|err| model::Error {
                    timestamp: err.timestamp.to_string(),
                    message: err.error.to_string(),
                })
                .collect(),
        }
    }
}
