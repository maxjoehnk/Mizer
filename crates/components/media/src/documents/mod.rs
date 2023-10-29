use std::fmt::{Display, Formatter};

use serde::{Deserialize, Serialize};

pub use self::media::*;
pub use self::tag::*;

mod media;
mod tag;

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash)]
#[repr(transparent)]
#[serde(transparent)]
pub struct MediaId(pub(crate) uuid::Uuid);

impl Display for MediaId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.0.hyphenated())
    }
}

impl MediaId {
    pub fn new() -> Self {
        MediaId(uuid::Uuid::new_v4())
    }
}

impl TryFrom<String> for MediaId {
    type Error = uuid::Error;

    fn try_from(value: String) -> Result<Self, Self::Error> {
        uuid::Uuid::parse_str(&value).map(MediaId)
    }
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash)]
#[repr(transparent)]
#[serde(transparent)]
pub struct TagId(pub(crate) uuid::Uuid);

impl Display for TagId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.0.hyphenated())
    }
}

impl TagId {
    pub fn new() -> Self {
        TagId(uuid::Uuid::new_v4())
    }
}

impl TryFrom<String> for TagId {
    type Error = uuid::Error;

    fn try_from(value: String) -> Result<Self, Self::Error> {
        uuid::Uuid::parse_str(&value).map(TagId)
    }
}
