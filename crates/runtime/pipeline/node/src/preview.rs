use std::sync::Arc;

use pinboard::NonEmptyPinboard;
use serde::{Deserialize, Serialize};

use mizer_clock::Timecode;
use mizer_ports::Color;
use mizer_util::StructuredData;

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
    fn write_timecode_preview(&self, timecode: Timecode);
}

pub enum NodePreviewRef {
    History(Arc<NonEmptyPinboard<Vec<f64>>>),
    Data(Arc<NonEmptyPinboard<Option<StructuredData>>>),
    Color(Arc<NonEmptyPinboard<Option<Color>>>),
    Timecode(Arc<NonEmptyPinboard<Option<Timecode>>>),
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

    pub fn read_timecode(&self) -> Option<Timecode> {
        if let Self::Timecode(pinboard) = self {
            pinboard.read()
        } else {
            None
        }
    }
}
