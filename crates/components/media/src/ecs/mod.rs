use std::path::{Path, PathBuf};
use std::fs;
use std::io::Read;
use std::ops::Deref;
use mizer_ecs::*;
use crate::discovery::MediaImporter;
use crate::documents::MediaDocument;
use crate::file_storage::FileStorage;
use crate::MediaCreateModel;
use self::models::*;

mod models;
mod imports;

pub type MediaBackgroundJobHandle = BackgroundJobHandle<MediaImportCommand, MediaImportEvent>;

pub fn setup(context: &mut EcsContext) -> MediaBackgroundJobHandle {
    context.world.insert_resource(FileStorage::new(PathBuf::from("/tmp/media")).unwrap());
    context.add_system(PreProcess, file_discovered);
    context.add_system(PreProcess, file_added.after(file_discovered));
    context.add_system(PreProcess, (
        imports::image_added,
        imports::audio_added,
        imports::video_added,
    ).after(file_added));

    context.add_background_job()
}

fn file_discovered(mut import_events: EventReader<MediaImportEvent>, mut commands: Commands) {
    for event in import_events.read() {
        let MediaImportEvent::MediaAdded(path) = event;
        tracing::debug!("Discovered media file: {path:?}");
        commands.spawn(MediaPath(path.clone()));
    }
}

fn file_added(query: Query<(Entity, Ref<MediaPath>)>, mut commands: Commands) {
    for (entity, path) in query.iter().filter(|(_, path)| path.is_added()) {
        let mut entity_commands = commands.entity(entity);
        entity_commands.insert((MediaId::new(), MediaImportStatus::default(), EntityErrors::default()));

        match get_content_type(path.deref()) {
            Ok((content_type, file_size)) => {
                tracing::debug!("Detected content type: {content_type:?} for {path:?}");
                entity_commands.insert((content_type, file_size));
            }
            Err(err) => {
                tracing::error!("Unable to import file: {err}");
                entity_commands.insert(MediaImportStatus::UnknownError);
            }
        }
    }
}

fn get_content_type(file_path: &impl AsRef<Path>) -> anyhow::Result<(MediaContentType, FileSize)> {
    let mut file = fs::File::open(file_path)?;
    let file_size = file.metadata()?.len();
    let content_type = if file_size < 256 {
        let mut buffer = vec![0u8; file_size as usize];
        file.read_to_end(&mut buffer)?;

        infer::get(&buffer)
    } else {
        let mut buffer = [0u8; 256];
        file.read_exact(&mut buffer)?;

        infer::get(&buffer)
    };
    let mime = mime_guess::from_path(file_path).first();
    let content_type = content_type
        .map(|content_type| content_type.mime_type())
        .or_else(|| mime.as_ref().map(|mime| mime.essence_str()))
        .ok_or_else(|| anyhow::anyhow!("Unknown file type"))?;

    Ok((MediaContentType(content_type.to_string()), FileSize(file_size)))
}

#[derive(Event)]
pub enum MediaImportEvent {
    MediaAdded(PathBuf),
}

#[derive(Event, Clone)]
pub enum MediaImportCommand {
}

impl MediaImporter for MediaBackgroundJobHandle {
    async fn import_file(&self, _model: MediaCreateModel, path: PathBuf, _source_path: Option<&Path>) -> anyhow::Result<Option<MediaDocument>> {
        tracing::debug!("importing file {:?}", path);
        self.send_event(MediaImportEvent::MediaAdded(path));

        Ok(None)
    }
}

pub trait MediaContextExt {
    fn get_media_views(&mut self) -> Vec<MediaFileView>;
}

impl MediaContextExt for EcsContext {
    fn get_media_views(&mut self) -> Vec<MediaFileView> {
        self.world.query::<(&MediaId, &MediaPath, &MediaImportStatus, Option<&FileSize>, Option<&MediaType>, Option<&MediaDuration>, Option<&AudioChannels>, Option<&SampleRate>)>()
            .iter(&self.world)
            .map(|(id, path, status, file_size, media_type, duration, audio_channels, sample_rate)| MediaFileView {
                id: *id,
                path: path.clone(),
                status: *status,
                file_size: file_size.copied(),
                media_type: media_type.copied(),
                duration: duration.copied(),
                audio_channels: audio_channels.copied(),
                sample_rate: sample_rate.copied(),
            }).collect()
    }
}
