use std::ffi::OsStr;
use std::path::{Path, PathBuf};
use std::process::{Child, Command};

use ffmpeg::error::EAGAIN;
use ffmpeg_the_third as ffmpeg;
use image::DynamicImage;

use crate::documents::{MediaMetadata, MediaType};
use crate::file_storage::FileStorage;
use crate::media_handlers::{MediaHandler, THUMBNAIL_SIZE};

#[derive(Clone)]
pub struct VideoHandler;

impl VideoHandler {
    #[cfg(all(feature = "omx", not(feature = "nvenc")))]
    fn transcode_command<I: AsRef<OsStr>, O: AsRef<OsStr>>(
        input: I,
        output: O,
    ) -> anyhow::Result<Child> {
        let child = Command::new("ffmpeg")
            .arg("-i")
            .arg(input)
            .arg("-c:v")
            .arg("h264_omx")
            .arg("-preset")
            .arg("slow")
            .arg("-crf")
            .arg("17")
            .arg(output)
            .spawn()?;

        Ok(child)
    }

    #[cfg(feature = "nvenc")]
    fn transcode_command<I: AsRef<OsStr>, O: AsRef<OsStr>>(
        input: I,
        output: O,
    ) -> anyhow::Result<Child> {
        unimplemented!()
    }

    #[cfg(not(any(feature = "nvenc", feature = "omx")))]
    fn transcode_command<I: AsRef<OsStr>, O: AsRef<OsStr>>(
        input: I,
        output: O,
    ) -> anyhow::Result<Child> {
        let child = Command::new("ffmpeg")
            .arg("-i")
            .arg(input)
            .arg("-c:v")
            .arg("libx264")
            .arg("-preset")
            .arg("slow")
            .arg("-crf")
            .arg("17")
            .arg(output)
            .spawn()?;

        Ok(child)
    }
}

impl MediaHandler for VideoHandler {
    const MEDIA_TYPE: MediaType = MediaType::Video;

    fn supported(content_type: &str) -> bool {
        content_type.starts_with("video")
    }

    fn generate_thumbnail<P: AsRef<Path>>(
        &self,
        file: P,
        storage: &FileStorage,
        _content_type: &str,
    ) -> anyhow::Result<()> {
        let target = storage.get_thumbnail_path(&file);
        VideoHandler::generate_thumbnail(file, target)?;

        Ok(())
    }

    fn read_metadata<P: AsRef<Path>>(
        &self,
        file: P,
        _content_type: &str,
    ) -> anyhow::Result<MediaMetadata> {
        let file = file.as_ref();
        let mut metadata = MediaMetadata::default();
        let input_context = ffmpeg::format::input(&file)?;
        ffmpeg::format::context::input::dump(&input_context, 0, file.to_str());
        let stream = input_context
            .streams()
            .best(ffmpeg::media::Type::Video)
            .unwrap();

        let decoder_context =
            ffmpeg::codec::context::Context::from_parameters(stream.parameters())?;
        let decoder = decoder_context.decoder().video()?;
        metadata.duration = if stream.duration() < 0 {
            None
        } else {
            let time_base: f64 = stream.time_base().into();
            let duration = stream.duration() as f64 * time_base;
            Some(duration.round() as u64)
        };

        metadata.dimensions = Some((decoder.width() as u64, decoder.height() as u64));
        metadata.framerate = Some(stream.rate().into());

        Ok(metadata)
    }
}

impl VideoHandler {
    fn generate_thumbnail<P: AsRef<Path>>(file: P, target: PathBuf) -> anyhow::Result<()> {
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
