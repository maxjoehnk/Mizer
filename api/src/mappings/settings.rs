use crate::models::settings as model;
use mizer_settings as settings;
use protobuf::SingularPtrField;

impl From<settings::Settings> for model::Settings {
    fn from(settings: settings::Settings) -> Self {
        Self {
            hotkeys: SingularPtrField::some(settings.hotkeys.into()),
            ..Default::default()
        }
    }
}

impl From<settings::Hotkeys> for model::Hotkeys {
    fn from(hotkeys: settings::Hotkeys) -> Self {
        Self {
            global: hotkeys.global,
            programmer: hotkeys.programmer,
            nodes: hotkeys.nodes,
            layouts: hotkeys.layouts,
            patch: hotkeys.patch,
            ..Default::default()
        }
    }
}
