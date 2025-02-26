use std::path::Path;

use ffmpeg_the_third as ffmpeg;
use image::DynamicImage;
use libc::EAGAIN;

use super::{IThumbnailGenerator, THUMBNAIL_SIZE};
use crate::documents::{MediaDocument, MediaType};

pub struct VideoGenerator;

impl IThumbnailGenerator for VideoGenerator {
    fn supported(&self, media: &MediaDocument) -> bool {
        media.media_type == MediaType::Video
    }

    fn generate_thumbnail(
        &self,
        media: &MediaDocument,
        target: &Path,
    ) -> anyhow::Result<Option<()>> {
        VideoGenerator::generate_thumbnail(&media.file_path, target)?;

        Ok(Some(()))
    }
}

impl VideoGenerator {
    fn generate_thumbnail<P: AsRef<Path>>(file: P, target: &Path) -> anyhow::Result<()> {
        let file = file.as_ref();
        let mut input_context = ffmpeg::format::input(&file)?;
        ffmpeg::format::context::input::dump(&input_context, 0, file.to_str());
        let stream = input_context
            .streams()
            .best(ffmpeg::media::Type::Video)
            .unwrap();
        let stream_index = stream.index();

        let decoder_context =
            ffmpeg::codec::context::Context::from_parameters(stream.parameters())?;
        let mut decoder = decoder_context.decoder().video()?;

        let mut converter = decoder.converter(ffmpeg::format::Pixel::RGBA)?;

        let mut converted_video = None;
        for packet in input_context.packets() {
            let (stream, packet) = packet?;
            if stream_index == stream.index() {
                decoder.send_packet(&packet)?;
                let mut decoded = ffmpeg::frame::Video::empty();
                let decode_result = decoder.receive_frame(&mut decoded);
                if let Err(ffmpeg::Error::Other { errno: EAGAIN }) = decode_result {
                    continue;
                }
                let mut frame = ffmpeg::frame::Video::empty();
                converter.run(&decoded, &mut frame)?;

                converted_video = Some(frame);
                break;
            }
        }

        if converted_video.is_none() {
            return Ok(());
        }

        let converted_video = converted_video.unwrap();

        let image = image::RgbaImage::from_raw(
            decoder.width(),
            decoder.height(),
            converted_video.data(0).into(),
        )
        .ok_or_else(|| anyhow::anyhow!("Unable to construct image buffer"))?;
        let image = DynamicImage::ImageRgba8(image);
        let image = image.resize(
            THUMBNAIL_SIZE,
            THUMBNAIL_SIZE,
            image::imageops::FilterType::Nearest,
        );

        image.save(&target)?;

        Ok(())
    }
}
