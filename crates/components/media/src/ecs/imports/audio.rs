use std::io::Cursor;
use std::path::{Path, PathBuf};
use anyhow::Context;
use id3::frame::PictureType;
use id3::Tag;
use image::imageops::FilterType;
use mizer_ecs::*;
use crate::ecs::imports::parse_image_content_type;
use crate::ecs::models::*;
use crate::file_storage::FileStorage;
use crate::media_handlers::THUMBNAIL_SIZE;

pub fn audio_added(query: Query<(Entity, Ref<MediaId>, &MediaPath, &MediaContentType)>, mut commands: Commands, file_storage: Res<FileStorage>) {
    for (entity, id, path, _content_type) in query.iter()
        .filter(|(_, id, _, _)| id.is_added())
        .filter(|(_, _, _, content_type)| content_type.0.starts_with("audio")) {
        let mut entity_commands = commands.entity(entity);
        entity_commands.insert(MediaType::Audio);
        match generate_thumbnail(path, file_storage.as_ref()) {
            Ok(Some(thumbnail)) => {
                entity_commands.insert(ThumbnailPath(thumbnail));
            }
            Ok(None) => {}
            Err(err) => {
                tracing::error!("Unable to generate thumbnail: {err}");
                entity_commands.insert(MediaImportStatus::UnknownError);
            }
        }
        match parse_metadata(path) {
            Ok(metadata) => {
                if let Some(duration) = metadata.duration {
                    entity_commands.insert(duration);
                }
                if let Some(sample_rate) = metadata.sample_rate {
                    entity_commands.insert(sample_rate);
                }
                if let Some(audio_channels) = metadata.audio_channels {
                    entity_commands.insert(audio_channels);
                }
            }
            Err(err) => {
                tracing::error!("Unable to parse metadata: {err}");
                entity_commands.insert(MediaImportStatus::UnknownError);
            }
        }
        tracing::debug!("Audio added: {:?}", id);
        entity_commands.insert(MediaImportStatus::Success);
    }
}


fn generate_thumbnail(file: &impl AsRef<Path>, storage: &FileStorage) -> anyhow::Result<Option<PathBuf>> {
    let mut target = None;
    let tag = Tag::read_from_path(file).context("Unable to read id3 tag")?;
    if let Some(cover) = tag
        .pictures()
        .find(|p| p.picture_type == PictureType::CoverFront)
    {
        let path = storage.get_thumbnail_path(&file);
        let cursor = Cursor::new(&cover.data);
        let image = image::load(cursor, parse_image_content_type(&cover.mime_type)?)
            .context("Unable to read cover image")?;
        let image = image.resize(THUMBNAIL_SIZE, THUMBNAIL_SIZE, FilterType::Nearest);
        image.save(&path).context("Unable to save thumbnail")?;

        target = Some(path);
    }

    Ok(target)
}

fn parse_metadata(file: &impl AsRef<Path>) -> anyhow::Result<metadata::AudioMetadata> {
    metadata::read_metadata(file)
}

mod metadata {
    use std::fs::File;
    use std::path::Path;
    use anyhow::Context;
    use id3::{Tag, TagLike};
    use symphonia::core::formats::{FormatOptions, FormatReader};
    use symphonia::core::io::{MediaSourceStream, ReadOnlySource};
    use symphonia::core::meta::MetadataOptions;
    use symphonia::core::probe::Hint;
    use crate::ecs::models::*;

    #[derive(Default)]
    pub struct AudioMetadata {
        pub duration: Option<MediaDuration>,
        pub sample_rate: Option<SampleRate>,
        pub audio_channels: Option<AudioChannels>,
        pub title: Option<Title>,
        pub album: Option<Album>,
        pub interpret: Option<Interpret>,
    }

    pub fn read_metadata<P: AsRef<Path>>(
        file: P,
    ) -> anyhow::Result<AudioMetadata> {
        let mut metadata = read_tag_metadata(&file).unwrap_or_default();
        let probe_result = probe_file(&file)?;
        metadata.duration = get_duration(&probe_result.format).or(metadata.duration);
        metadata.sample_rate = get_sample_rate(&probe_result.format);
        metadata.audio_channels = get_channel_count(&probe_result.format);

        Ok(metadata)
    }

    fn probe_file<P: AsRef<Path>>(file: P) -> anyhow::Result<symphonia::core::probe::ProbeResult> {
        let mut hint = Hint::new();
        if let Some(extension) = file.as_ref().extension().and_then(|e| e.to_str()) {
            hint.with_extension(extension);
        }
        let file = File::open(file)?;
        let source = Box::new(ReadOnlySource::new(file));
        let mss = MediaSourceStream::new(source, Default::default());

        let format_opts = FormatOptions::default();
        let metadata_opts = MetadataOptions::default();
        let probed =
            symphonia::default::get_probe().format(&hint, mss, &format_opts, &metadata_opts)?;

        Ok(probed)
    }

    fn get_duration(format: &Box<dyn FormatReader>) -> Option<MediaDuration> {
        let track = format.default_track()?;
        let timebase = track.codec_params.time_base?;
        let n_frames = track.codec_params.n_frames?;
        let time = timebase.calc_time(n_frames);

        Some(MediaDuration(time.seconds))
    }

    fn get_sample_rate(format: &Box<dyn FormatReader>) -> Option<SampleRate> {
        let track = format.default_track()?;

        track.codec_params.sample_rate.map(SampleRate)
    }

    fn get_channel_count(format: &Box<dyn FormatReader>) -> Option<AudioChannels> {
        let track = format.default_track()?;

        Some(AudioChannels(track.codec_params.channels?.count() as u32))
    }

    fn read_tag_metadata<P: AsRef<Path>>(file: P) -> anyhow::Result<AudioMetadata> {
        let tag = Tag::read_from_path(file).context("Unable to read id3 tag")?;
        let title = tag.title().map(|a| a.to_string()).map(Title);
        let album = tag.album().map(|a| a.to_string()).map(Album);
        let interpret = tag.artist().map(|a| a.to_string()).map(Interpret);
        let duration = tag.duration().map(|d| d as u64).map(MediaDuration);

        Ok(AudioMetadata {
            title,
            album,
            interpret,
            duration,
            ..Default::default()
        })
    }
}
