use crate::documents::{AttachedTag, MediaDocument};
use crate::file_storage::FileStorage;
use flume::{Receiver, Sender};
use std::path::PathBuf;

#[derive(Clone)]
pub struct MediaServerApi(
    pub(crate) Sender<MediaServerCommand>,
    pub(crate) FileStorage,
);

impl MediaServerApi {
    pub fn send_command(&self, command: MediaServerCommand) {
        self.0.send(command);
    }

    pub fn get_temp_path(&self) -> PathBuf {
        self.1.create_temp_file()
    }

    pub fn open_channel<T>() -> (Sender<T>, Receiver<T>) {
        flume::bounded(1)
    }
}

pub enum MediaServerCommand {
    ImportFile(MediaCreateModel, PathBuf, Sender<MediaDocument>),
    CreateTag(TagCreateModel, Sender<TagDocument>),
    GetTags(Sender<Vec<TagDocument>>),
}

#[derive(Debug, Clone)]
pub struct MediaCreateModel {
    pub name: String,
    pub tags: Vec<AttachedTag>,
}

use crate::documents::TagDocument;
use uuid::Uuid;

#[derive(Debug, Clone)]
pub struct TagCreateModel {
    pub name: String,
}

impl From<TagCreateModel> for TagDocument {
    fn from(model: TagCreateModel) -> Self {
        TagDocument {
            id: Uuid::new_v4(),
            name: model.name,
            media: Vec::new(),
        }
    }
}
