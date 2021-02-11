use crate::api::{MediaCreateModel, MediaServerApi, MediaServerCommand};
use actix_files::Files;
use actix_multipart::{Field, Multipart};
use actix_web::{post, web, App, HttpServer, Responder, Result, Scope};
use futures::{StreamExt, TryStreamExt};
use tokio::io::AsyncWriteExt;

pub fn start(media_server_api: MediaServerApi) -> anyhow::Result<()> {
    let local_set = tokio::task::LocalSet::new();
    let system = actix_rt::System::run_in_tokio("mizer-media-api", &local_set);
    let _server = HttpServer::new(move || {
        App::new()
            .data(media_server_api.clone())
            .service(Files::new("/thumbnails", ".storage/thumbnails"))
            .service(Files::new("/media", ".storage/media"))
            .service(api())
    })
    .bind("0.0.0.0:50050")
    .unwrap()
    .run();
    local_set.spawn_local(system);

    Ok(())
}

pub fn api() -> Scope {
    web::scope("/api/media").service(add_media)
}

#[post("")]
async fn add_media(
    api: web::Data<MediaServerApi>,
    mut payload: Multipart,
) -> Result<impl Responder> {
    let mut media_request = MediaCreateModel {
        name: String::new(),
        tags: Vec::new(),
    };
    let file_path = api.get_temp_path();
    while let Ok(Some(mut field)) = payload.try_next().await {
        if let Some(content_disposition) = field.content_disposition() {
            match content_disposition.get_name() {
                Some("name") => {
                    media_request.name = field_to_string(&mut field)
                        .await
                        .map_err(|err| actix_web::error::ErrorInternalServerError(err))?;
                }
                Some("file") => {
                    let filename = content_disposition
                        .get_filename()
                        .ok_or_else(|| actix_web::error::ParseError::Incomplete)?;
                    if media_request.name.is_empty() {
                        media_request.name = filename.into();
                    }
                    let mut file = tokio::fs::File::create(&file_path).await?;
                    let mut stream = field.into_stream();
                    while let Some(data) = stream.next().await {
                        let data = data
                            .map_err(|err| actix_web::error::ErrorInternalServerError(err))?;
                        file.write(&data).await?;
                    }
                }
                Some("tags") => {
                    let tags = field_to_string(&mut field)
                        .await
                        .map_err(|err| actix_web::error::ErrorInternalServerError(err))?;
                    media_request.tags = serde_json::from_str(&tags)?;
                }
                _ => {}
            }
        }
    }

    if media_request.tags.len() == 0 {
        return Err(actix_web::error::ErrorBadRequest(
            "At least one tag must be defined",
        ));
    }

    let (sender, receiver) = MediaServerApi::open_channel();
    api.send_command(MediaServerCommand::ImportFile(
        media_request,
        file_path,
        sender,
    ));

    let document = receiver
        .recv_async()
        .await
        .map_err(|err| actix_web::error::ErrorInternalServerError(err))?;

    Ok(web::Json(document))
}

async fn field_to_string(field: &mut Field) -> anyhow::Result<String> {
    let bytes = field
        .try_collect::<Vec<_>>()
        .await
        .map_err(|err| anyhow::anyhow!("multipart error: {:?}", err))?;
    let name = bytes.first().ok_or_else(|| anyhow::anyhow!("No name"))?;

    Ok(String::from_utf8_lossy(&name).into())
}
