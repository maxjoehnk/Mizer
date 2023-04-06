use std::path::{Path, PathBuf};
use std::process::{Child, Command};

use crate::documents::{MediaMetadata, MediaType};
use crate::file_storage::FileStorage;
use crate::media_handlers::{MediaHandler, THUMBNAIL_SIZE};
use anyhow::Context;
use rsmpeg::avcodec::{AVCodec, AVCodecContext, AVPacket};
use rsmpeg::avformat::AVFormatContextInput;
use rsmpeg::avutil::{av_inv_q, av_q2d, AVFrame, AVFrameWithImage, AVImage};
use rsmpeg::error::RsmpegError;
use rsmpeg::ffi::{
    AVCodecID_AV_CODEC_ID_PNG, AVMediaType_AVMEDIA_TYPE_VIDEO, SWS_FAST_BILINEAR, SWS_PRINT_INFO,
};
use rsmpeg::swscale::SwsContext;
use std::ffi::{CString, OsStr};
use std::fs::File;
use std::io::Write;
use std::slice;

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
        VideoHandler::generate_thumbnail_child_process(file, target)?;

        Ok(())
    }

    fn read_metadata<P: AsRef<Path>>(
        &self,
        file: P,
        _content_type: &str,
    ) -> anyhow::Result<MediaMetadata> {
        let mut metadata = MediaMetadata::default();
        let context = VideoHandler::open_context(file)?;
        metadata.duration = if context.duration < 0 {
            None
        } else {
            Some(context.duration as u64 / 1_000_000)
        };

        let (stream_index, decoder) = VideoHandler::open_decoder(&context)?;
        metadata.dimensions = Some((decoder.width as u64, decoder.height as u64));
        let stream = context.streams().get(stream_index).unwrap();
        metadata.framerate = Some(av_q2d(stream.r_frame_rate));

        Ok(metadata)
    }
}

impl VideoHandler {
    #[deprecated(note = "swap to generate_thumbnail_ffi once it's stable")]
    fn generate_thumbnail_child_process<P: AsRef<Path>>(
        file: P,
        target: PathBuf,
    ) -> anyhow::Result<()> {
        let mut child = Command::new("ffmpeg")
            .arg("-i")
            .arg(file.as_ref().as_os_str())
            .arg("-vframes")
            .arg("1")
            .arg("-filter:v")
            .arg(format!("scale={}:-1", THUMBNAIL_SIZE))
            .arg(&target)
            .spawn()?;

        let status = child.wait()?;

        if status.success() {
            Ok(())
        } else {
            anyhow::bail!("Something went wrong")
        }
    }

    // This method doesn't produce proper thumbnails for all input files yet
    // Also the aspect ratio is always forced to 1:1 which should be changed
    #[allow(unused)]
    fn generate_thumbnail_ffi<P: AsRef<Path>>(file: P, target: PathBuf) -> anyhow::Result<()> {
        let mut context = VideoHandler::open_context(file)?;
        let (stream_index, mut decoder) = VideoHandler::open_decoder(&context)?;
        let cover_frame = VideoHandler::get_cover_frame(&mut context, &mut decoder, stream_index)?;
        let thumbnail = VideoHandler::scale_thumbnail(&cover_frame, &decoder)?;
        let mut file = File::create(target)?;
        VideoHandler::write_thumbnail(thumbnail, &mut file)?;

        Ok(())
    }

    fn open_context<P: AsRef<Path>>(path: P) -> anyhow::Result<AVFormatContextInput> {
        let filename = path.as_ref().to_str().unwrap();
        let file_cstr = CString::new(filename)?;
        let context = AVFormatContextInput::open(&file_cstr)?;

        Ok(context)
    }

    fn open_decoder(context: &AVFormatContextInput) -> anyhow::Result<(usize, AVCodecContext)> {
        let (stream_index, decoder) = context
            .find_best_stream(AVMediaType_AVMEDIA_TYPE_VIDEO)?
            .context("Failed to find the best stream")?;

        let stream = context.streams().get(stream_index).unwrap();

        let mut decode_context = AVCodecContext::new(&decoder);
        decode_context.apply_codecpar(&stream.codecpar())?;
        decode_context.open(None)?;

        Ok((stream_index, decode_context))
    }

    fn get_cover_frame(
        context: &mut AVFormatContextInput,
        decoder: &mut AVCodecContext,
        stream_index: usize,
    ) -> anyhow::Result<AVFrame> {
        loop {
            let cover_packet = loop {
                match context.read_packet()? {
                    Some(x) if x.stream_index != stream_index as i32 => {}
                    x => break x,
                }
            };

            decoder.send_packet(cover_packet.as_ref())?;
            // repeatedly send packet until a frame can be extracted
            match decoder.receive_frame() {
                Ok(x) => break Ok(x),
                Err(RsmpegError::DecoderDrainError) => {}
                Err(e) => anyhow::bail!(e),
            }

            if cover_packet.is_none() {
                anyhow::bail!("Can't find video cover frame");
            }
        }
    }

    fn scale_thumbnail(
        frame: &AVFrame,
        decode_context: &AVCodecContext,
    ) -> anyhow::Result<AVPacket> {
        let mut encode_context = {
            let encoder =
                AVCodec::find_encoder(AVCodecID_AV_CODEC_ID_PNG).context("Encoder not found")?;
            let mut encode_context = AVCodecContext::new(&encoder);

            encode_context.set_bit_rate(decode_context.bit_rate);
            encode_context.set_width(THUMBNAIL_SIZE as i32);
            encode_context.set_height(THUMBNAIL_SIZE as i32);
            encode_context.set_time_base(av_inv_q(decode_context.framerate));
            encode_context.set_pix_fmt(if let Some(pix_fmts) = encoder.pix_fmts() {
                pix_fmts[0]
            } else {
                decode_context.pix_fmt
            });
            encode_context.open(None)?;

            encode_context
        };

        let scaled_cover_packet = {
            let mut sws_context = SwsContext::get_context(
                decode_context.width,
                decode_context.height,
                decode_context.pix_fmt,
                encode_context.width,
                encode_context.height,
                encode_context.pix_fmt,
                SWS_FAST_BILINEAR | SWS_PRINT_INFO,
            )
            .context("Invalid swscontext parameter.")?;

            let image_buffer = AVImage::new(
                encode_context.pix_fmt,
                encode_context.width,
                encode_context.height,
                1,
            )
            .context("Image buffer parameter invalid.")?;

            let mut scaled_cover_frame = AVFrameWithImage::new(image_buffer);

            sws_context
                .scale_frame(frame, 0, decode_context.height, &mut scaled_cover_frame)
                .context("Scaling frame")?;

            encode_context.send_frame(Some(&scaled_cover_frame))?;
            encode_context.receive_packet()?
        };

        Ok(scaled_cover_packet)
    }

    fn write_thumbnail(packet: AVPacket, file: &mut File) -> anyhow::Result<()> {
        let data = unsafe { slice::from_raw_parts(packet.data, packet.size as usize) };
        file.write_all(data)?;

        Ok(())
    }
}
