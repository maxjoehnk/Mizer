use std::io::Cursor;
use std::path::Path;

use anyhow::Context;
use id3::frame::PictureType;
use id3::{Tag};
use image::imageops::FilterType;

use crate::documents::{MediaDocument, MediaType};
use super::{THUMBNAIL_SIZE, IThumbnailGenerator, parse_image_content_type};

pub struct AudioGenerator;

impl IThumbnailGenerator for AudioGenerator {
    fn supported(&self, media: &MediaDocument) -> bool {
        media.media_type == MediaType::Audio
    }

    fn generate_thumbnail(
        &self,
        media: &MediaDocument,
        target: &Path,
    ) -> anyhow::Result<Option<()>> {
        let tag = Tag::read_from_path(&media.file_path).context("Unable to read id3 tag")?;
        let Some(cover) = tag
            .pictures()
            .find(|p| p.picture_type == PictureType::CoverFront) else {
            return Ok(None);
        };
        let cursor = Cursor::new(&cover.data);
        let image = image::load(cursor, parse_image_content_type(&cover.mime_type)?)
            .context("Unable to read cover image")?;
        let image = image.resize(THUMBNAIL_SIZE, THUMBNAIL_SIZE, FilterType::Nearest);
        image.save(target).context("Unable to save thumbnail")?;
        
        Ok(Some(()))
    }
}
