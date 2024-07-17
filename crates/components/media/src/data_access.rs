use std::path::PathBuf;
use std::sync::Arc;

use dashmap::DashMap;

use mizer_message_bus::MessageBus;

use crate::documents::*;
use crate::TagCreateModel;

#[derive(Clone, Default)]
pub struct DataAccess {
    tags: Arc<DashMap<TagId, MediaTag>>,
    media: Arc<DashMap<MediaId, MediaDocument>>,
    pub(crate) bus: MessageBus<DataAccess>,
}

impl DataAccess {
    pub fn new() -> anyhow::Result<Self> {
        Ok(DataAccess::default())
    }

    pub fn list_media(&self) -> anyhow::Result<Vec<MediaDocument>> {
        let media = self
            .media
            .iter()
            .map(|entry| entry.value().clone())
            .collect();

        Ok(media)
    }

    pub fn get_media(&self, id: &MediaId) -> Option<MediaDocument> {
        self.media.get(id).map(|entry| entry.value().clone())
    }

    pub fn list_tags(&self) -> anyhow::Result<Vec<MediaTag>> {
        let tags = self
            .tags
            .iter()
            .map(|entry| entry.value().clone())
            .collect();

        Ok(tags)
    }

    pub fn add_tag<D: Into<TagCreateModel>>(&self, document: D) -> anyhow::Result<MediaTag> {
        let tag_document = document.into();
        let tag_document: MediaTag = tag_document.into();
        self.tags.insert(tag_document.id, tag_document.clone());
        self.bus.send(self.clone());

        Ok(tag_document)
    }

    pub fn remove_tag(&self, id: TagId) {
        self.tags.remove(&id);
        for mut media in self.media.iter_mut() {
            media.tags.retain(|tag| tag.id != id);
        }
        self.bus.send(self.clone());
    }

    pub fn add_media<D: Into<MediaDocument>>(&self, document: D) -> anyhow::Result<MediaDocument> {
        let media_document = document.into();
        self.insert_media(&media_document)?;
        self.bus.send(self.clone());

        Ok(media_document)
    }
    
    pub fn relink_media(&self, id: MediaId, path: PathBuf) -> anyhow::Result<()> {
        let mut media = self
            .media
            .get_mut(&id)
            .ok_or_else(|| anyhow::anyhow!("Media with id {id} does not exist"))?;
        media.file_path = path;
        self.bus.send(self.clone());

        Ok(())
    }

    pub fn import_tags(&self, tags: Vec<MediaTag>) -> anyhow::Result<()> {
        for tag in tags {
            self.tags.insert(tag.id, tag);
        }
        self.bus.send(self.clone());

        Ok(())
    }

    pub fn import_media(&self, medias: Vec<MediaDocument>) -> anyhow::Result<()> {
        for media in medias {
            self.media.insert(media.id, media);
        }
        self.bus.send(self.clone());

        Ok(())
    }

    pub fn clear(&self) -> anyhow::Result<()> {
        self.media.clear();
        self.tags.clear();
        self.bus.send(self.clone());

        Ok(())
    }

    pub(crate) fn contains_source(&self, path: &PathBuf) -> anyhow::Result<bool> {
        let existing_files = self.list_media()?;
        let exists = existing_files
            .into_iter()
            .any(|file| file.source_path.as_ref() == Some(path));

        Ok(exists)
    }

    fn insert_media(&self, document: &MediaDocument) -> anyhow::Result<()> {
        self.media.insert(document.id, document.clone());
        self.bus.send(self.clone());

        Ok(())
    }

    pub fn remove_media(&self, id: MediaId) {
        self.media.remove(&id);
        self.bus.send(self.clone());
    }

    pub fn add_tag_to_media(&self, media_id: MediaId, tag_id: TagId) -> anyhow::Result<()> {
        let mut media = self
            .media
            .get_mut(&media_id)
            .ok_or_else(|| anyhow::anyhow!("Media with id {media_id} does not exist"))?;
        let tag = self
            .tags
            .get(&tag_id)
            .ok_or_else(|| anyhow::anyhow!("Tag with id {tag_id} does not exist"))?;
        media.tags.push(tag.clone());
        self.bus.send(self.clone());

        Ok(())
    }

    pub fn remove_tag_from_media(&self, media_id: MediaId, tag_id: TagId) -> anyhow::Result<()> {
        let mut media = self
            .media
            .get_mut(&media_id)
            .ok_or_else(|| anyhow::anyhow!("Media with id {media_id} does not exist"))?;
        media.tags.retain(|tag| tag.id != tag_id);
        self.bus.send(self.clone());

        Ok(())
    }
}
