use std::path::PathBuf;

use ffmpeg_the_third as ffmpeg;

use crate::background_thread_decoder::*;

pub type VideoDecodeThread = BackgroundDecoderThread<VideoFileDecoder>;
pub type VideoDecodeThreadHandle = BackgroundDecoderThreadHandle<VideoFileDecoder>;

pub trait VideoDecodeThreadHandleExt {
    fn seek(&mut self, ts: usize) -> anyhow::Result<()>;
}

impl VideoDecodeThreadHandleExt for VideoDecodeThreadHandle {
    fn seek(&mut self, ts: usize) -> anyhow::Result<()> {
        self.send(VideoDecodeMessage::Seek(ts))?;

        Ok(())
    }
}

pub enum VideoDecodeMessage {
    Seek(usize),
}

pub struct VideoFileDecoder {
    context: ffmpeg::format::context::Input,
    decoder: ffmpeg::decoder::Video,
    converter: ffmpeg::software::scaling::context::Context,
    stream_index: usize,
    metadata: VideoMetadata,
}

impl VideoDecoder for VideoFileDecoder {
    type CreateDecoder = PathBuf;
    type Commands = VideoDecodeMessage;

    fn new(path: PathBuf) -> anyhow::Result<Self> {
        let context = ffmpeg::format::input(&path)?;
        ffmpeg::format::context::input::dump(&context, 0, path.to_str());
        let stream = context.streams().best(ffmpeg::media::Type::Video).unwrap();
        let video_stream_index = stream.index();

        let context_decoder =
            ffmpeg::codec::context::Context::from_parameters(stream.parameters())?;
        let decoder = context_decoder.decoder().video()?;

        let converter = decoder.converter(ffmpeg::format::Pixel::RGBA)?;

        let metadata = VideoMetadata {
            width: decoder.width(),
            height: decoder.height(),
            fps: stream.rate().into(),
            frames: (stream.frames() as usize).saturating_sub(1),
        };

        Ok(Self {
            decoder,
            context,
            converter,
            stream_index: video_stream_index,
            metadata,
        })
    }

    fn handle(&mut self, command: Self::Commands) -> anyhow::Result<()> {
        match command {
            Self::Commands::Seek(ts) => {
                if let Err(err) = self.context.seek(ts as i64, i64::MIN..i64::MAX) {
                    tracing::error!("Error seeking video: {err:?}");
                }
            }
        }
        Ok(())
    }

    fn decode(&mut self) -> anyhow::Result<Option<Vec<u8>>> {
        for packet in self.context.packets() {
            let (stream, packet) = packet?;
            if self.stream_index == stream.index() {
                self.decoder.send_packet(&packet)?;
                let mut decoded = ffmpeg::frame::Video::empty();
                self.decoder.receive_frame(&mut decoded)?;
                let mut frame = ffmpeg::frame::Video::empty();
                self.converter.run(&decoded, &mut frame)?;

                return Ok(Some(frame.data(0).to_vec()));
            }
        }

        self.context.seek(0, 0..0)?;

        Ok(None)
    }

    fn metadata(&self) -> anyhow::Result<VideoMetadata> {
        Ok(self.metadata)
    }
}
