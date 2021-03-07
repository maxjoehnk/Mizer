use crate::api::TagCreateModel;
use crate::documents::*;

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
