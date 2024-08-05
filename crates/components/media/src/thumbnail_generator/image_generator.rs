use std::io::BufReader;
use std::path::Path;

use anyhow::Context;
use image::imageops::FilterType;

use super::{parse_image_content_type, IThumbnailGenerator, THUMBNAIL_SIZE};
use crate::documents::{MediaDocument, MediaType};

pub struct ImageGenerator;

impl IThumbnailGenerator for ImageGenerator {
    fn supported(&self, media: &MediaDocument) -> bool {
        media.media_type == MediaType::Image
    }

    fn generate_thumbnail(
        &self,
        media: &MediaDocument,
        target: &Path,
    ) -> anyhow::Result<Option<()>> {
        let source = std::fs::File::open(&media.file_path)?;
        let source = BufReader::new(source);

        let image = image::load(source, parse_image_content_type(&media.content_type)?)
            .context("thumbnail generation failed")?;
        let image = image.resize(THUMBNAIL_SIZE, THUMBNAIL_SIZE, FilterType::Nearest);
        image.save(target)?;

        Ok(Some(()))
    }
}
