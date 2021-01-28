use std::path::Path;

use crate::file_storage::FileStorage;
use crate::media_handlers::MediaHandler;
use anyhow::Context;
use image::ImageFormat;
use image::imageops::FilterType;
use std::io::BufReader;

pub struct ImageHandler;

impl MediaHandler for ImageHandler {
    fn generate_thumbnail<P: AsRef<Path>>(&self, file: P, storage: &FileStorage, content_type: &str) -> anyhow::Result<()> {
        let target = storage.get_thumbnail_path(&file);
        let source = std::fs::File::open(file)?;
        let source = BufReader::new(source);

        let image = ::image::load(source, parse_content_type(content_type)).context("thumbnail generation failed")?;
        let image = image.resize(200, 200, FilterType::Nearest);
        image.save(target)?;

        Ok(())
    }
}

fn parse_content_type(content_type: &str) -> ImageFormat {
    match content_type {
        "image/png" => ImageFormat::Png,
        "image/jpg" | "image/jpeg" => ImageFormat::Jpeg,
        "image/bmp" => ImageFormat::Bmp,
        _ => unimplemented!("{}", content_type)
    }
}
