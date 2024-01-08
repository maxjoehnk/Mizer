use std::fs::File;
use std::io::Cursor;
use std::path::Path;

use anyhow::Context;
use id3::frame::PictureType;
use id3::{Tag, TagLike};
use image::imageops::FilterType;
use symphonia::core::formats::{FormatOptions, FormatReader};
use symphonia::core::io::{MediaSourceStream, ReadOnlySource};
use symphonia::core::meta::MetadataOptions;
use symphonia::core::probe::Hint;

use crate::documents::{MediaMetadata, MediaType};
use crate::file_storage::FileStorage;
use crate::media_handlers::image_handler::parse_image_content_type;
use crate::media_handlers::{MediaHandler, THUMBNAIL_SIZE};

#[derive(Clone)]
pub struct AudioHandler;

impl MediaHandler for AudioHandler {
    const MEDIA_TYPE: MediaType = MediaType::Audio;

    fn supported(content_type: &str) -> bool {
        content_type.starts_with("audio")
    }

    fn generate_thumbnail<P: AsRef<Path>>(
        &self,
        file: P,
        storage: &FileStorage,
        _content_type: &str,
    ) -> anyhow::Result<()> {
        let target = storage.get_thumbnail_path(&file);
        let tag = Tag::read_from_path(file).context("Unable to read id3 tag")?;
        if let Some(cover) = tag
            .pictures()
            .find(|p| p.picture_type == PictureType::CoverFront)
        {
            let cursor = Cursor::new(&cover.data);
            let image = image::load(cursor, parse_image_content_type(&cover.mime_type)?)
                .context("Unable to read cover image")?;
            let image = image.resize(THUMBNAIL_SIZE, THUMBNAIL_SIZE, FilterType::Nearest);
            image.save(target).context("Unable to save thumbnail")?;
        }

        Ok(())
    }

    fn read_metadata<P: AsRef<Path>>(
        &self,
        file: P,
        _content_type: &str,
    ) -> anyhow::Result<MediaMetadata> {
        let mut metadata = self.read_tag_metadata(&file).unwrap_or_default();
        metadata.duration = self.read_duration(&file)?.or(metadata.duration);

        Ok(metadata)
    }
}

impl AudioHandler {
    fn read_duration<P: AsRef<Path>>(&self, file: P) -> anyhow::Result<Option<u64>> {
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
        let duration = AudioHandler::get_duration(probed.format);

        Ok(duration)
    }

    fn get_duration(format: Box<dyn FormatReader>) -> Option<u64> {
        let track = format.default_track()?;
        let timebase = track.codec_params.time_base?;
        let n_frames = track.codec_params.n_frames?;
        let time = timebase.calc_time(n_frames);

        Some(time.seconds)
    }

    fn read_tag_metadata<P: AsRef<Path>>(&self, file: P) -> anyhow::Result<MediaMetadata> {
        let tag = Tag::read_from_path(file).context("Unable to read id3 tag")?;
        let name = tag.title().map(|a| a.to_string());
        let album = tag.album().map(|a| a.to_string());
        let artist = tag.artist().map(|a| a.to_string());
        let duration = tag.duration().map(|d| d as u64);

        Ok(MediaMetadata {
            name,
            album,
            artist,
            duration,
            ..Default::default()
        })
    }
}
