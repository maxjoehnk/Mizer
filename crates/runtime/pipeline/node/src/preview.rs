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
    fn write_multi_preview(&self, data: &[f64]);
    fn write_data_preview(&self, data: StructuredData);
    fn write_color_preview(&self, data: Color);
    fn write_timecode_preview(&self, timecode: Timecode);
}
