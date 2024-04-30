use crate::proto::console::*;

impl From<mizer_console::ConsoleMessage> for ConsoleMessage {
    fn from(value: mizer_console::ConsoleMessage) -> Self {
        Self {
            level: ConsoleLevel::from(value.level) as i32,
            category: ConsoleCategory::from(value.category) as i32,
            message: value.message,
            timestamp: value.timestamp,
        }
    }
}

impl From<mizer_console::ConsoleLevel> for ConsoleLevel {
    fn from(value: mizer_console::ConsoleLevel) -> Self {
        match value {
            mizer_console::ConsoleLevel::Debug => Self::Debug,
            mizer_console::ConsoleLevel::Info => Self::Info,
            mizer_console::ConsoleLevel::Warning => Self::Warning,
            mizer_console::ConsoleLevel::Error => Self::Error,
        }
    }
}

impl From<mizer_console::ConsoleCategory> for ConsoleCategory {
    fn from(value: mizer_console::ConsoleCategory) -> Self {
        use mizer_console::ConsoleCategory as C;

        match value {
            C::Connections => Self::Connections,
            C::Media => Self::Media,
            C::Projects => Self::Projects,
            C::Commands => Self::Commands,
            C::Nodes => Self::Nodes,
        }
    }
}
