use crate::documents::*;
use crate::TagCreateModel;
use sled::Mode;
use std::path::{Path, PathBuf};

#[derive(Clone)]
pub struct DataAccess {
    db: sled::Db,
    tags: sled::Tree,
    media: sled::Tree,
}

impl DataAccess {
    pub fn new() -> anyhow::Result<Self> {
        let db = sled::Config::new()
            .create_new(true)
            .temporary(true)
            .mode(Mode::HighThroughput)
            .open()?;
        let tags = db.open_tree("tags")?;
        let media = db.open_tree("media")?;

        Ok(DataAccess { db, tags, media })
    }

    pub fn list_media(&self) -> anyhow::Result<Vec<MediaDocument>> {
        let media = self
            .media
            .iter()
            .values()
            .map(|value| {
                let value = value?;
                let doc = serde_json::from_slice(&value)?;

                Ok(doc)
            })
            .collect::<anyhow::Result<Vec<_>>>()?;

        Ok(media)
    }

    pub fn list_tags(&self) -> anyhow::Result<Vec<TagDocument>> {
        let tags = self
            .tags
            .iter()
            .values()
            .map(|value| {
                let value = value?;
                let doc = serde_json::from_slice(&value)?;

                Ok(doc)
            })
            .collect::<anyhow::Result<Vec<_>>>()?;

        Ok(tags)
    }

    pub fn add_tag<D: Into<TagCreateModel>>(&self, document: D) -> anyhow::Result<TagDocument> {
        let tag_document = document.into();
        let tag_document: TagDocument = tag_document.into();
        let id = tag_document.id.as_bytes();
        let value = serde_json::to_vec(&tag_document)?;
        self.tags.insert(id, value)?;

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
            let id = tag.id.as_bytes();
            let value = serde_json::to_vec(&tag)?;
            self.tags.insert(id, value)?;
        }

        Ok(())
    }

    pub fn import_media(&self, medias: Vec<MediaDocument>) -> anyhow::Result<()> {
        for media in medias {
            let id = media.id.as_bytes();
            let value = serde_json::to_vec(&media)?;
            self.media.insert(id, value)?;
        }

        Ok(())
    }

    pub fn clear(&self) -> anyhow::Result<()> {
        self.media.clear()?;
        self.tags.clear()?;

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
        let id = document.id.as_bytes();
        let value = serde_json::to_vec(&document)?;
        self.media.insert(id, value)?;

        Ok(())
    }

    fn update_tags(&self, document: &MediaDocument) -> anyhow::Result<()> {
        let attached_media: AttachedMediaDocument = document.into();
        let ids = document.tags.iter().map(|t| t.id);

        for id in ids {
            let id = id.as_bytes();
            self.update_tag_document(id, attached_media.clone())?;
        }

        Ok(())
    }

    fn update_tag_document(
        &self,
        id: &[u8],
        document: AttachedMediaDocument,
    ) -> anyhow::Result<()> {
        self.tags.update_and_fetch(id, move |tags| {
            let document = document.clone();
            if let Some(tags) = tags {
                let tags = serde_json::from_slice::<TagDocument>(tags);
                if let Ok(mut tags) = tags {
                    tags.media.push(document);

                    serde_json::to_vec(&tags).ok()
                } else {
                    None
                }
            } else {
                None
            }
        })?;
        Ok(())
    }
}
