use crate::{PreferenceValue, Settings};
use facet::{Partial, Shape, Type, UserType};
use std::path::PathBuf;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub enum UpdateSettingValue {
    Bool(bool),
    Select(String),
    Path(PathBuf),
    PathList(Vec<PathBuf>),
    Hotkey(String),
}

impl From<PreferenceValue> for UpdateSettingValue {
    fn from(value: PreferenceValue) -> Self {
        match value {
            PreferenceValue::Boolean(value) => Self::Bool(value),
            PreferenceValue::Select { selected, .. } => Self::Select(selected),
            PreferenceValue::Path(value) => Self::Path(value),
            PreferenceValue::PathList(value) => Self::PathList(value),
            PreferenceValue::Hotkey(value) => Self::Hotkey(value),
        }
    }
}

impl Settings {
    pub(crate) fn update_setting(&mut self, path: String, value: UpdateSettingValue) -> anyhow::Result<()> {
        let path = path.split('.').collect::<Vec<_>>();

        let mut partial = Partial::alloc::<Settings>()?;
        partial = partial.set(self.clone())?;

        let mut is_hotkey = false;
        for field in &path {
            if is_hotkey_group(partial.shape()) {
                is_hotkey = true;
                break;
            }
            partial = partial.begin_field(field)?;
        }

        match value {
            UpdateSettingValue::Bool(value) => partial = partial.set(value)?,
            UpdateSettingValue::Select(value) => partial = partial.select_variant_named(&value)?,
            UpdateSettingValue::Path(value) => partial = partial.set(value)?,
            UpdateSettingValue::PathList(value) => partial = partial.set(value)?,
            UpdateSettingValue::Hotkey(value) => {
                if !is_hotkey {
                    anyhow::bail!("Cannot set hotkey on non-hotkey setting");
                }

                let hotkey_action = path.iter().last().unwrap();

                partial = partial.init_map()?;
                partial = partial.begin_key()?;
                partial = partial.select_variant_named(hotkey_action)?;
                partial = partial.end()?;
                partial = partial.begin_value()?;
                partial = partial.set(value)?;
                // skipped last end call because the loop will pop the value frame
            },
        }

        for _ in &path {
            partial = partial.end()?;
        }

        let updated = partial.build()?;
        let updated = updated.materialize::<Settings>()?;
        *self = updated;

        Ok(())
    }

    pub(crate) fn reset_setting(&mut self, path: &str, defaults: &Settings) -> anyhow::Result<()> {
        let preferences = defaults.as_preferences(Default::default());
        let preference = preferences.into_iter().find(|p| p.key == path).ok_or_else(|| anyhow::anyhow!("Preference not found: {}", path))?;

        self.update_setting(preference.key, preference.value.into())?;

        Ok(())
    }
}

fn is_hotkey_group(shape: &Shape) -> bool {
    matches!(shape.ty, Type::User(UserType::Opaque) if shape.type_identifier == "HashMap")
}
