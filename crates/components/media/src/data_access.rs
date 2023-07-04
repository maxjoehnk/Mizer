use dashmap::DashMap;
use std::path::PathBuf;
use std::sync::Arc;
use uuid::Uuid;

use crate::documents::*;
use crate::TagCreateModel;

#[derive(Clone, Default)]
pub struct DataAccess {
    tags: Arc<DashMap<Uuid, TagDocument>>,
    media: Arc<DashMap<MediaId, MediaDocument>>,
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

    pub fn get_media(&self, id: MediaId) -> Option<MediaDocument> {
        self.media.get(&id).map(|entry| entry.value().clone())
    }

    pub fn list_tags(&self) -> anyhow::Result<Vec<TagDocument>> {
        let tags = self
            .tags
            .iter()
            .map(|entry| entry.value().clone())
            .collect();

        Ok(tags)
    }

    pub fn add_tag<D: Into<TagCreateModel>>(&self, document: D) -> anyhow::Result<TagDocument> {
        let tag_document = document.into();
        let tag_document: TagDocument = tag_document.into();
        self.tags.insert(tag_document.id, tag_document.clone());

        Ok(tag_document)
    }

    pub fn add_media<D: Into<MediaDocument>>(&self, document: D) -> anyhow::Result<MediaDocument> {
        let media_document = document.into();
        self.insert_media(&media_document)?;
        self.update_tags(&media_document)?;

        Ok(media_document)
    }

    pub fn import_tags(&self, tags: Vec<TagDocument>) -> anyhow::Result<()> {
        for tag in tags {
            self.tags.insert(tag.id, tag);
        }

        Ok(())
    }

    pub fn import_media(&self, medias: Vec<MediaDocument>) -> anyhow::Result<()> {
        for media in medias {
            self.media.insert(media.id, media);
        }

        Ok(())
    }

    pub fn clear(&self) -> anyhow::Result<()> {
        self.media.clear();
        self.tags.clear();

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

        Ok(())
    }

    fn update_tags(&self, document: &MediaDocument) -> anyhow::Result<()> {
        let attached_media: AttachedMediaDocument = document.into();
        let ids = document.tags.iter().map(|t| t.id);

        for id in ids {
            self.update_tag_document(id, attached_media.clone())?;
        }

        Ok(())
    }

    fn update_tag_document(&self, id: Uuid, document: AttachedMediaDocument) -> anyhow::Result<()> {
        if let Some(mut tag) = self.tags.get_mut(&id) {
            tag.media.push(document);
        }

        Ok(())
    }
}
