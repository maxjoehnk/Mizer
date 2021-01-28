use mongodb::{options::ClientOptions, Client, Collection};
use crate::documents::*;
use bson::{from_bson, Bson, to_bson, doc};
use serde::Serialize;
use crate::api::TagCreateModel;
use futures::prelude::*;

#[derive(Clone)]
pub struct DataAccess {
    client: Client
}

impl DataAccess {
    pub async fn new(url: &str) -> anyhow::Result<Self> {
        let mut client_options = ClientOptions::parse(url).await?;
        client_options.app_name = Some("Mizer Media Server".into());

        let client = Client::with_options(client_options)?;

        Ok(DataAccess { client })
    }

    pub async fn list_tags(&self) -> anyhow::Result<Vec<TagDocument>> {
        let cursor = self.tags_collection().find(None, None).await?;
        let tags = cursor.try_collect::<Vec<_>>().await?;
        let tags = tags.into_iter().map(|document| from_bson(Bson::Document(document))).collect::<Result<_, _>>()?;

        Ok(tags)
    }

    pub async fn add_tag<D: Into<TagCreateModel>>(&self, document: D) -> anyhow::Result<TagDocument> {
        let tag_document = document.into();
        let tag_document = tag_document.into();
        let document = to_document(&tag_document)?;
        self.tags_collection().insert_one(document, None).await?;

        Ok(tag_document)
    }

    pub async fn add_media<D: Into<MediaDocument>>(&self, document: D) -> anyhow::Result<MediaDocument> {
        let media_document = document.into();
        self.insert_media(&media_document).await?;
        self.update_tags(&media_document).await?;

        Ok(media_document)
    }

    async fn insert_media(&self, document: &MediaDocument) -> anyhow::Result<()> {
        let document = to_document(document)?;
        self.media_collection().insert_one(document, None).await?;

        Ok(())
    }

    async fn update_tags(&self, document: &MediaDocument) -> anyhow::Result<()> {
        let ids = document.tags.iter().map(|t| t.id).map(|id| Ok(to_bson(&id)?)).collect::<anyhow::Result<Vec<_>>>()?;
        let document: AttachedMediaDocument = document.into();
        let document = to_document(&document)?;
        self.tags_collection()
            .update_many(doc!{
                "id": {
                    "$in": ids
                }
            }, doc!{
                "$push": {
                    "media": document
                }
            }, None).await?;

        Ok(())
    }

    fn tags_collection(&self) -> Collection {
        let db = self.client.database("media-server");
        db.collection("tags")
    }

    fn media_collection(&self) -> Collection {
        let db = self.client.database("media-server");
        db.collection("media")
    }
}

fn to_document<T: Serialize>(document: &T) -> anyhow::Result<bson::Document> {
    if let Bson::Document(document) = to_bson(document)? {
        Ok(document)
    }else {
        anyhow::bail!("not an document")
    }
}
