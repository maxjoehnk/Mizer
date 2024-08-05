use std::future::Future;
use std::sync::Arc;
use futures::FutureExt;
use mizer_message_bus::Subscriber;
use mizer_scheduler::{BackgroundTask, EventJobSchedule, TaskContext};
use crate::documents::{MediaDocument, MediaId};
use crate::events::MediaEvent;
use crate::MediaServer;
use crate::thumbnail_generator::{ThumbnailGenerator};

pub struct BackgroundMediaJob {
    media_events: Subscriber<MediaEvent>,
    media_server: MediaServer,
    thumbnail_generator: Arc<ThumbnailGenerator>,
}

impl EventJobSchedule for BackgroundMediaJob {
    type Event = MediaEvent;

    fn next_event(&self) -> impl Future<Output=Option<Self::Event>> + Send {
        self.media_events.read_async().map(|result| result.ok())
    }

    fn create_task(&self, event: Self::Event) -> Box<dyn BackgroundTask> {
        match event {
            MediaEvent::FileAdded(media_id) | MediaEvent::FileUpdated(media_id) => {
                Box::new(BackgroundMediaTask {
                    media_id,
                    media_server: self.media_server.clone(),
                    thumbnail_generator: Arc::clone(&self.thumbnail_generator),
                })
            }}
    }
}

impl BackgroundMediaJob {
    pub fn new(media_server: MediaServer, media_events: Subscriber<MediaEvent>) -> Self {
        let generator = ThumbnailGenerator::new(media_server.storage.clone());

        BackgroundMediaJob {
            media_server,
            media_events,
            thumbnail_generator: Arc::new(generator),
        }
    }
}

struct BackgroundMediaTask {
    media_id: MediaId,
    media_server: MediaServer,
    thumbnail_generator: Arc<ThumbnailGenerator>,
}

impl BackgroundTask for BackgroundMediaTask {
    fn run(&self, _context: &dyn TaskContext) -> anyhow::Result<()> {
        let media = self.media_server.get_media_file(self.media_id);
        if let Some(mut media) = media {
            let exists = media.file_path.exists();
            media.file_available = Some(exists);
            if exists {
                self.generate_thumbnail(&mut media);
            }
            self.media_server.db.add_media(media)?;
        }

        Ok(())
    }
}
    
impl BackgroundMediaTask {
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
