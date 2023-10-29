use serde::{Deserialize, Serialize};

use crate::documents::TagId;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct MediaTag {
    pub id: TagId,
    pub name: String,
}
