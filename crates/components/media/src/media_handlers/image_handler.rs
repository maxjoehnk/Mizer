use std::io::BufReader;
use std::path::Path;

use anyhow::Context;
use image::ImageFormat;

use crate::documents::{MediaMetadata, MediaType};
use crate::media_handlers::{MediaHandler};

#[derive(Clone)]
pub struct ImageHandler;

impl MediaHandler for ImageHandler {
    const MEDIA_TYPE: MediaType = MediaType::Image;

    fn supported(content_type: &str) -> bool {
        content_type.starts_with("image") && !content_type.starts_with("image/svg")
    }

    fn read_metadata<P: AsRef<Path>>(
        &self,
        file: P,
        content_type: &str,
    ) -> anyhow::Result<MediaMetadata> {
        let source = std::fs::File::open(file)?;
        let source = BufReader::new(source);
        let image = image::load(source, parse_image_content_type(content_type)?)
            .context("thumbnail generation failed")?;

        let width = image.width();
        let height = image.height();
        let dimensions = Some((width as u64, height as u64));

        Ok(MediaMetadata {
            dimensions,
            ..Default::default()
        })
    }
}

pub fn parse_image_content_type(content_type: &str) -> anyhow::Result<ImageFormat> {
    Ok(match content_type {
        "image/png" => ImageFormat::Png,
        "image/jpg" | "image/jpeg" => ImageFormat::Jpeg,
        "image/bmp" => ImageFormat::Bmp,
        "image/webp" => ImageFormat::WebP,
        "image/tiff" => ImageFormat::Tiff,
        "image/gif" => ImageFormat::Gif,
        _ => anyhow::bail!("Unsupported image type: {}", content_type),
    })
}
