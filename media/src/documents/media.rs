use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MediaDocument {
    pub id: Uuid,
    pub name: String,
    pub tags: Vec<AttachedTag>,
    pub content_type: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AttachedTag {
    pub id: Uuid,
    pub name: String,
}
