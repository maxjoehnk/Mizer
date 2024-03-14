use ::image::ImageFormat;
pub use video::*;
pub use audio::*;
pub use image::*;

mod video;
mod audio;
mod image;

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
