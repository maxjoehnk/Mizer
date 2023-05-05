use crate::{MediaCreateModel, MediaServer};
use async_std::{fs, io};
use futures::{StreamExt, TryStreamExt};
use multer::Multipart;
use tide::{Body, StatusCode};

pub async fn handle(api: &MediaServer, mut payload: Multipart<'_>) -> tide::Result {
    let mut media_request = MediaCreateModel {
        name: String::new(),
        tags: Vec::new(),
    };
    let file_path = api.get_temp_path();
    while let Some(field) = payload.next_field().await? {
        match field.name() {
            Some("name") => {
                media_request.name = field.text().await?;
            }
            Some("file") => {
                let filename = field.file_name().ok_or_else(|| {
                    tide::Error::new(StatusCode::BadRequest, anyhow::anyhow!("Missing file name"))
                })?;
                if media_request.name.is_empty() {
                    media_request.name = filename.into();
                }
                let file = fs::File::create(&file_path).await?;
                let field = field
                    .map(|chunk| {
                        chunk
                            .map(|bytes| bytes.to_vec())
                            .map_err(|err| std::io::Error::new(std::io::ErrorKind::Other, err))
                    })
                    .into_async_read();
                io::copy(field, file).await?;
            }
            Some("tags") => {
                let tags = field.text().await?;
                media_request.tags = serde_json::from_str(&tags)?;
            }
            _ => {}
        }
    }

    if media_request.tags.is_empty() {
        return Err(tide::Error::new(
            StatusCode::BadRequest,
            anyhow::anyhow!("At least one tag must be defined"),
        ));
    }

    let document = api.import_file(media_request, file_path, None).await?;

    Ok(Body::from_json(&document)?.into())
}
