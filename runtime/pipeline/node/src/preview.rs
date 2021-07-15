use serde::{Deserialize, Serialize};

pub const HISTORY_PREVIEW_SIZE: usize = 128;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize, Serialize)]
pub enum PreviewType {
    Texture,
    Waveform,
    History,
    Multiple,
    None,
}

impl Default for PreviewType {
    fn default() -> Self {
        PreviewType::None
    }
}

pub trait PreviewContext {
    fn push_history_value(&self, value: f64);
}
