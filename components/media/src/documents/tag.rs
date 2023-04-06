use crate::documents::MediaDocument;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct TagDocument {
    pub id: uuid::Uuid,
    pub name: String,
    pub media: Vec<AttachedMediaDocument>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
#[serde(tag = "type", rename_all = "lowercase")]
pub enum AttachedMediaDocument {
    Video(AttachedDocument),
    Image(AttachedDocument),
    Audio(AttachedDocument),
    Vector(AttachedDocument),
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct AttachedDocument {
    pub id: uuid::Uuid,
    pub name: String,
}

impl From<&MediaDocument> for AttachedMediaDocument {
    fn from(doc: &MediaDocument) -> Self {
        let document = AttachedDocument {
            id: doc.id,
            name: doc.name.clone(),
        };
        match doc.content_type.as_str() {
            content_type if content_type.starts_with("image") => {
                AttachedMediaDocument::Image(document)
            }
            content_type if content_type.starts_with("video") => {
                AttachedMediaDocument::Video(document)
            }
            content_type if content_type.starts_with("audio") => {
                AttachedMediaDocument::Audio(document)
            }
            "text/xml" => AttachedMediaDocument::Vector(document),
            _ => unimplemented!(),
        }
    }
}
