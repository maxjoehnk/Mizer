use std::path::Path;

use crate::file_storage::FileStorage;
use crate::media_handlers::{MediaHandler, THUMBNAIL_SIZE};
use anyhow::Context;
use image::imageops::FilterType;
use image::ImageFormat;
use std::io::BufReader;

pub struct ImageHandler;

impl MediaHandler for ImageHandler {
    fn supported(content_type: &str) -> bool {
        content_type.starts_with("image")
    }

    fn generate_thumbnail<P: AsRef<Path>>(
        &self,
        file: P,
        storage: &FileStorage,
        content_type: &str,
    ) -> anyhow::Result<()> {
        let target = storage.get_thumbnail_path(&file);
        let source = std::fs::File::open(file)?;
        let source = BufReader::new(source);

        let image = ::image::load(source, parse_content_type(content_type))
            .context("thumbnail generation failed")?;
        let image = image.resize(THUMBNAIL_SIZE, THUMBNAIL_SIZE, FilterType::Nearest);
        image.save(target)?;

        Ok(())
    }
}

fn parse_content_type(content_type: &str) -> ImageFormat {
    match content_type {
        "image/png" => ImageFormat::Png,
        "image/jpg" | "image/jpeg" => ImageFormat::Jpeg,
        "image/bmp" => ImageFormat::Bmp,
        "image/webp" => ImageFormat::WebP,
        "image/tiff" => ImageFormat::Tiff,
        _ => unimplemented!("{}", content_type),
    }
}
