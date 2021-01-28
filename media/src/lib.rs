use crate::data_access::DataAccess;
use crate::file_storage::FileStorage;
use crate::documents::MediaDocument;
use uuid::Uuid;
use crate::media_handlers::{VideoHandler, MediaHandler, ImageHandler};
use crate::api::{MediaServerApi, MediaServerCommand, MediaCreateModel};
use tokio::stream::StreamExt;
use std::path::Path;
use tokio::io::AsyncReadExt;

mod data_access;
mod file_storage;
pub mod documents;
mod media_handlers;

pub struct MediaServer {
    pub db: DataAccess,
    pub file_storage: FileStorage,
    video_handler: VideoHandler,
    image_handler: ImageHandler,
}

impl MediaServer {
    pub async fn new() -> anyhow::Result<Self> {
        let context = DataAccess::new("mongodb://localhost:27017").await?;
        let file_storage = FileStorage::new()?;
        let video_handler = VideoHandler;
        let image_handler = ImageHandler;

        Ok(MediaServer {
            db: context,
            file_storage,
            video_handler,
            image_handler,
        })
    }

    pub fn open_api(self, handle: &tokio::runtime::Handle) -> anyhow::Result<MediaServerApi> {
        let (tx, rx) = flume::unbounded();
        let file_storage = self.file_storage.clone();

        handle.spawn(async move {
            let mut stream = rx.into_stream();
            while let Some(command) = stream.next().await {
                match command {
                    MediaServerCommand::UploadFile(model, file_path, resp) => {
                        let document = self.upload_file(model, &file_path).await.unwrap();
                        resp.send(document).unwrap();
                    }
                    MediaServerCommand::CreateTag(model, resp) => {
                        let document = self.db.add_tag(model).await.unwrap();
                        resp.send(document).unwrap();
                    }
                    MediaServerCommand::GetTags(resp) => {
                        let documents = self.db.list_tags().await.unwrap();
                        resp.send(documents).unwrap();
                    }
                }
            }
        });

        Ok(MediaServerApi(tx, file_storage))
    }

    async fn upload_file(&self, model: MediaCreateModel, file_path: &Path) -> anyhow::Result<MediaDocument> {
        let id = Uuid::new_v4();
        let mut temp_file = tokio::fs::File::open(file_path).await?;
        let mut buffer = [0u8; 256];
        temp_file.read(&mut buffer).await?;
        let content_type = mimesniff::detect_content_type(&buffer).to_string();
        log::debug!("got {} content type for {:?}", &content_type, model);

        if content_type.starts_with("video") {
            self.video_handler.handle_file(file_path, &self.file_storage, &content_type)?;
        }else if content_type.starts_with("image") {
            self.image_handler.handle_file(file_path, &self.file_storage, &content_type)?;
        }else {
            anyhow::bail!("unsupported file")
        };

        let media = self.db.add_media(MediaDocument {
            id,
            content_type,
            name: model.name,
            tags: model.tags,
        }).await?;

        Ok(media)
    }

}

pub mod api;

pub mod http_api {
    use crate::api::{MediaServerApi, MediaCreateModel, MediaServerCommand};
    use actix_multipart::{Multipart, Field};
    use actix_web::{post, Responder, Scope, web, HttpServer, App, Result};
    use actix_files::Files;
    use futures::{TryStreamExt, StreamExt};
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
        web::scope("/api/media")
            .service(add_media)
    }

    #[post("")]
    async fn add_media(api: web::Data<MediaServerApi>, mut payload: Multipart) -> Result<impl Responder> {
        let mut media_request = MediaCreateModel {
            name: String::new(),
            tags: Vec::new(),
        };
        let file_path = api.get_temp_path();
        while let Ok(Some(mut field)) = payload.try_next().await {
            if let Some(content_disposition) = field.content_disposition() {
                match content_disposition.get_name() {
                    Some("name") => {
                        media_request.name = field_to_string(&mut field).await.map_err(|err| actix_web::error::ErrorInternalServerError(err))?;
                    },
                    Some("file") => {
                        let filename = content_disposition.get_filename().ok_or_else(|| actix_web::error::ParseError::Incomplete)?;
                        if media_request.name.is_empty() {
                            media_request.name = filename.into();
                        }
                        let mut file = tokio::fs::File::create(&file_path).await?;
                        let mut stream = field.into_stream();
                        while let Some(data) = stream.next().await {
                            let data = data.map_err(|err| actix_web::error::ErrorInternalServerError(err))?;
                            file.write(&data).await?;
                        }
                    },
                    Some("tags") => {
                        let tags = field_to_string(&mut field).await.map_err(|err| actix_web::error::ErrorInternalServerError(err))?;
                        media_request.tags = serde_json::from_str(&tags)?;
                    },
                    _ => {}
                }
            }
        }

        if media_request.tags.len() == 0 {
            return Err(actix_web::error::ErrorBadRequest("At least one tag must be defined"));
        }

        let (sender, receiver) = MediaServerApi::open_channel();
        api.send_command(MediaServerCommand::UploadFile(media_request, file_path, sender));

        let document = receiver.recv_async().await.map_err(|err| actix_web::error::ErrorInternalServerError(err))?;

        Ok(web::Json(document))
    }

    async fn field_to_string(field: &mut Field) -> anyhow::Result<String> {
        let bytes = field.try_collect::<Vec<_>>().await.map_err(|err| anyhow::anyhow!("multipart error: {:?}", err))?;
        let name = bytes.first().ok_or_else(|| anyhow::anyhow!("No name"))?;

        Ok(String::from_utf8_lossy(&name).into())
    }
}

