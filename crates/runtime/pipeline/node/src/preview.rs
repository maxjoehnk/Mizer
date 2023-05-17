use std::sync::Arc;

use serde::{Deserialize, Serialize};

use mizer_ports::Color;
use mizer_util::StructuredData;
use pinboard::NonEmptyPinboard;

pub const HISTORY_PREVIEW_SIZE: usize = 128;

#[derive(Default, Debug, Clone, Copy, PartialEq, Eq, Deserialize, Serialize)]
pub enum PreviewType {
    Texture,
    Waveform,
    History,
    Multiple,
    Timecode,
    Data,
    Color,
    #[default]
    None,
}

pub trait PreviewContext {
    fn push_history_value(&self, value: f64);
    fn write_data_preview(&self, data: StructuredData);
    fn write_color_preview(&self, data: Color);
}

pub enum NodePreviewRef {
    History(Arc<NonEmptyPinboard<Vec<f64>>>),
    Data(Arc<NonEmptyPinboard<Option<StructuredData>>>),
    Color(Arc<NonEmptyPinboard<Option<Color>>>),
}

impl NodePreviewRef {
    pub fn read_history(&self) -> Option<Vec<f64>> {
        if let Self::History(pinboard) = self {
            pinboard.read().into()
        } else {
            None
        }
    }

    pub fn read_data(&self) -> Option<StructuredData> {
        if let Self::Data(pinboard) = self {
            pinboard.read()
        } else {
            None
        }
    }

    pub fn read_color(&self) -> Option<Color> {
        if let Self::Color(pinboard) = self {
            pinboard.read()
        } else {
            None
        }
    }
}