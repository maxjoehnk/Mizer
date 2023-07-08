use std::path::{Path, PathBuf};
use std::process::{Child, Command};

use crate::documents::{MediaMetadata, MediaType};
use crate::file_storage::FileStorage;
use crate::media_handlers::{MediaHandler, THUMBNAIL_SIZE};
use ffmpeg_the_third as ffmpeg;
use std::ffi::OsStr;

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
        for (stream, packet) in input_context.packets() {
            if stream_index == stream.index() {
                decoder.send_packet(&packet)?;
                let mut decoded = ffmpeg::frame::Video::empty();
                decoder.receive_frame(&mut decoded)?;
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
        let mut scaler = converted_video.scaler(
            THUMBNAIL_SIZE,
            THUMBNAIL_SIZE,
            ffmpeg::software::scaling::Flags::empty(),
        )?;
        let mut thumbnail_frame = ffmpeg::frame::Video::empty();
        scaler.run(&converted_video, &mut thumbnail_frame)?;
        let mut output_context = ffmpeg::format::output(&target)?;
        ffmpeg::format::context::output::dump(&output_context, 0, target.to_str());
        output_context.write_header()?;

        let context = ffmpeg::encoder::find(ffmpeg::codec::Id::PNG).unwrap();
        let thumbnail_stream = output_context.add_stream(context)?;
        let mut encoder = ffmpeg::codec::Context::from_parameters(thumbnail_stream.parameters())?
            .encoder()
            .video()?;
        encoder.set_width(THUMBNAIL_SIZE);
        encoder.set_height(THUMBNAIL_SIZE);
        encoder.set_aspect_ratio(decoder.aspect_ratio());
        encoder.set_format(ffmpeg::format::Pixel::RGBA);
        encoder.set_frame_rate(decoder.frame_rate());
        encoder.set_time_base(decoder.time_base());

        encoder.send_frame(&thumbnail_frame)?;
        let mut packet = ffmpeg::packet::Packet::empty();
        encoder.receive_packet(&mut packet)?;
        packet.write_interleaved(&mut output_context)?;

        Ok(())
    }
}
