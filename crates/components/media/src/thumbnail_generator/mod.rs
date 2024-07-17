use std::path::{Path, PathBuf};
use image::ImageFormat;
use crate::documents::MediaDocument;
use crate::file_storage::FileStorage;

mod audio_generator;
mod image_generator;
mod svg_generator;
mod video_generator;

pub(crate) const THUMBNAIL_SIZE: u32 = 512;

pub struct ThumbnailGenerator {
    file_storage: FileStorage,
    generators: Vec<Box<dyn IThumbnailGenerator>>,
}

impl ThumbnailGenerator {
    pub fn new(storage: FileStorage) -> Self {
        let generators = vec![
            Box::new(image_generator::ImageGenerator) as Box<dyn IThumbnailGenerator>,
            Box::new(audio_generator::AudioGenerator) as Box<dyn IThumbnailGenerator>,
            Box::new(video_generator::VideoGenerator) as Box<dyn IThumbnailGenerator>,
            Box::new(svg_generator::SvgGenerator::new()) as Box<dyn IThumbnailGenerator>,
        ];

        ThumbnailGenerator {
            file_storage: storage,
            generators,
        }
    }
    
    pub fn generate(&self, media: &MediaDocument) -> anyhow::Result<Option<PathBuf>> {
        let thumbnail_path = self.file_storage.get_thumbnail_path(&media.file_path);

        for generator in self.generators.iter() {
            if generator.supported(media) {
                return generator.generate_thumbnail(media, &thumbnail_path)
                    .map(|result| result.map(|_| thumbnail_path));
            }
        }

        Ok(None)
    }
}

trait IThumbnailGenerator: Send + Sync {
    fn supported(&self, media: &MediaDocument) -> bool;

    fn generate_thumbnail(
        &self,
        media: &MediaDocument,
        target_path: &Path,
    ) -> anyhow::Result<Option<()>>;
}

pub(crate) fn parse_image_content_type(content_type: &str) -> anyhow::Result<ImageFormat> {
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
