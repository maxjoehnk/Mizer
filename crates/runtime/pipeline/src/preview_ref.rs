use std::sync::Arc;

use ringbuffer::{ConstGenericRingBuffer, RingBuffer};

use mizer_clock::Timecode;
use mizer_node::HISTORY_PREVIEW_SIZE;
use mizer_ports::Color;
use mizer_util::StructuredData;
use parking_lot::RwLock;

pub enum NodePreviewRef {
    History(Arc<RwLock<ConstGenericRingBuffer<f64, HISTORY_PREVIEW_SIZE>>>),
    Data(Arc<RwLock<Option<StructuredData>>>),
    Color(Arc<RwLock<Option<Color>>>),
    Timecode(Arc<RwLock<Option<Timecode>>>),
}

impl NodePreviewRef {
    pub fn read_history(&self) -> Option<Vec<f64>> {
        if let Self::History(pinboard) = self {
            let guard = pinboard.read();

            Some(guard.to_vec())
        } else {
            None
        }
    }

    pub fn read_data(&self) -> Option<StructuredData> {
        if let Self::Data(pinboard) = self {
            let guard = pinboard.read();

            guard.clone()
        } else {
            None
        }
    }

    pub fn read_color(&self) -> Option<Color> {
        if let Self::Color(pinboard) = self {
            let guard = pinboard.read();

            *guard
        } else {
            None
        }
    }

    pub fn read_timecode(&self) -> Option<Timecode> {
        if let Self::Timecode(pinboard) = self {
            let guard = pinboard.read();

            *guard
        } else {
            None
        }
    }
}
