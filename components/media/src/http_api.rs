use crate::api::{MediaCreateModel, MediaServerApi, MediaServerCommand};
use async_std::{fs, io};
use futures::{StreamExt, TryStreamExt};
use multer::Multipart;
use tide::{Body, Request, StatusCode};

pub async fn start(media_server_api: MediaServerApi) -> anyhow::Result<()> {
    let mut app = tide::with_state(media_server_api);
    app.at("/thumbnails/").serve_dir(".storage/thumbnails")?;
    app.at("/media/").serve_dir(".storage/media/")?;
    app.at("/api/media")
        .post(|mut req: Request<MediaServerApi>| async move {
            let body = req.body_bytes().await;
            // TODO: actually stream file instead copying whole file into memory
            let body = async_std::stream::once(body);
            // TODO: read boundary from request
            let multipart = Multipart::new(body, "boundary");
            add_media(req.state(), multipart).await
        });

    app.listen("0.0.0.0:50050").await?;

    Ok(())
}

async fn add_media(api: &MediaServerApi, mut payload: Multipart) -> tide::Result {
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

    let (sender, receiver) = MediaServerApi::open_channel();
    api.send_command(MediaServerCommand::ImportFile(
        media_request,
        file_path,
        sender,
    ));

    let document = receiver.recv_async().await?;

    Ok(Body::from_json(&document)?.into())
}
