use chrono::{DateTime, Utc};
use ringbuffer::{ConstGenericRingBuffer, RingBuffer};
use serde::{Deserialize, Serialize};
use std::sync::Arc;

const MAX_ERROR_COUNT: usize = 32;

#[derive(Debug, Clone)]
pub struct ErrorCollector<TErr> {
    buffer: ConstGenericRingBuffer<Error<TErr>, MAX_ERROR_COUNT>,
}

impl<TErr> Default for ErrorCollector<TErr> {
    fn default() -> Self {
        Self {
            buffer: ConstGenericRingBuffer::default(),
        }
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Error<TErr> {
    pub timestamp: DateTime<Utc>,
    pub error: Arc<TErr>,
}

impl<TErr> Error<TErr> {
    pub fn new(error: TErr) -> Self {
        Self {
            timestamp: Utc::now(),
            error: Arc::new(error),
        }
    }
}

impl<TErr: Clone> ErrorCollector<TErr> {
    pub fn push(&mut self, error: TErr) {
        self.buffer.push(Error::new(error));
    }

    pub fn errors(&self) -> Vec<Error<TErr>> {
        self.buffer.to_vec()
    }
}
