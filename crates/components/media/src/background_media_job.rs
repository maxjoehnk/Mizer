use mizer_message_bus::Subscriber;
use mizer_status_bus::StatusHandle;
use crate::documents::{MediaDocument};
use crate::events::MediaEvent;
use crate::MediaServer;
use crate::thumbnail_generator::{ThumbnailGenerator};

pub struct BackgroundMediaJob {
    media_server: MediaServer,
    status_handle: StatusHandle,
    media_events: Subscriber<MediaEvent>,
    thumbnail_generator: ThumbnailGenerator,
}

impl BackgroundMediaJob {
    pub fn new(media_server: MediaServer, status_handle: StatusHandle, media_events: Subscriber<MediaEvent>) -> Self {
        let generator = ThumbnailGenerator::new(media_server.storage.clone());

        BackgroundMediaJob {
            media_server,
            status_handle,
            media_events,
            thumbnail_generator: generator,
        }
    }

    pub fn spawn(self) -> anyhow::Result<()> {
        std::thread::Builder::new()
            .name("Media Background Job".to_string())
            .spawn(move || self.start())?;

        Ok(())
    }

    pub fn start(&self) {
        loop {
            if let Some(event) = self.media_events.read_blocking() {
                if let Err(err) = self.handle_event(event) {
                    tracing::error!("Error handling media event: {:?}", err);
                }
            }
            std::thread::yield_now();
        }
    }

    fn handle_event(&self, event: MediaEvent) -> anyhow::Result<()> {
        match event {
            MediaEvent::FileAdded(media_id) | MediaEvent::FileUpdated(media_id) => {
                let media = self.media_server.get_media_file(media_id);
                if let Some(mut media) = media {
                    let exists = media.file_path.exists();
                    media.file_available = Some(exists);
                    if exists {
                        self.generate_thumbnail(&mut media);
                    }
                    self.media_server.db.add_media(media)?;
                }
            }
        }

        Ok(())
    }

    fn generate_thumbnail(&self, media: &mut MediaDocument) {
        match self.thumbnail_generator.generate(media) {
            Ok(thumbnail_path) => {
                media.metadata.thumbnail_path = thumbnail_path;
            }
            Err(err) => {
                let file_path = &media.file_path;
                tracing::warn!("Unable to generate thumbnail for {file_path:?}: {err:?}");
                mizer_console::warn!(mizer_console::ConsoleCategory::Media, "Unable to generate thumbnail for {file_path:?}");
            }
        }
    }
}
