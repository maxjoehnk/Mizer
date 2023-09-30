use std::path::PathBuf;

use anyhow::anyhow;
use ffmpeg_the_third as ffmpeg;
use flume::{bounded, unbounded};

#[derive(Debug, Clone, Copy)]
pub struct VideoMetadata {
    pub width: u32,
    pub height: u32,
    pub fps: f64,
    pub frames: usize,
}

pub struct VideoDecodeThreadHandle {
    sender: flume::Sender<VideoThreadMessage>,
    receiver: flume::Receiver<VideoThreadEvent>,
}

impl VideoDecodeThreadHandle {
    pub fn decode_file(&mut self, path: PathBuf) -> anyhow::Result<VideoMetadata> {
        let (message_tx, message_rx) = bounded(5);
        self.sender
            .send(VideoThreadMessage::DecodeFile(path, message_tx))
            .unwrap();
        self.receiver = message_rx;

        let metadata = self
            .receiver
            .iter()
            .find_map(|event| match event {
                VideoThreadEvent::Metadata(metadata) => Some(metadata),
                _ => None,
            })
            .ok_or_else(|| anyhow!("No metadata received"))?;

        Ok(metadata)
    }

    pub fn seek(&mut self, ts: usize) -> anyhow::Result<()> {
        let (message_tx, message_rx) = bounded(5);
        self.sender.send(VideoThreadMessage::Seek(ts, message_tx))?;
        self.receiver = message_rx;

        Ok(())
    }

    pub fn try_recv(&self) -> Option<VideoThreadEvent> {
        self.receiver.try_recv().ok()
    }
}

impl Drop for VideoDecodeThreadHandle {
    fn drop(&mut self) {
        self.sender.send(VideoThreadMessage::Exit).unwrap();
    }
}

enum VideoThreadMessage {
    DecodeFile(PathBuf, flume::Sender<VideoThreadEvent>),
    Seek(usize, flume::Sender<VideoThreadEvent>),
    Exit,
}

pub enum VideoThreadEvent {
    DecodedFrame(Vec<u8>),
    DecodeError(anyhow::Error),
    Metadata(VideoMetadata),
}

pub struct VideoDecodeThread {
    receiver: flume::Receiver<VideoThreadMessage>,
    sender: flume::Sender<VideoThreadEvent>,
    decoder: Option<VideoDecoder>,
}

impl VideoDecodeThread {
    pub fn spawn() -> anyhow::Result<VideoDecodeThreadHandle> {
        let (message_tx, message_rx) = bounded(20);
        let (event_tx, event_rx) = unbounded();

        std::thread::Builder::new()
            .name("VideoDecodeThread".to_string())
            .spawn(move || {
                let thread = Self {
                    receiver: message_rx,
                    sender: event_tx,
                    decoder: None,
                };
                thread.run();
            })?;

        Ok(VideoDecodeThreadHandle {
            receiver: event_rx,
            sender: message_tx,
        })
    }

    fn run(mut self) {
        loop {
            if let Ok(message) = self.receiver.try_recv() {
                match message {
                    VideoThreadMessage::DecodeFile(path, sender) => {
                        self.sender = sender;
                        match VideoDecoder::new(path) {
                            Ok(decoder) => {
                                if let Err(err) = self
                                    .sender
                                    .send(VideoThreadEvent::Metadata(decoder.metadata))
                                {
                                    log::error!("Error sending video metadata: {err:?}");
                                }
                                self.decoder = Some(decoder);
                            }
                            Err(err) => {
                                log::error!("Error creating video decoder: {err:?}");
                                if let Err(err) =
                                    self.sender.send(VideoThreadEvent::DecodeError(err))
                                {
                                    log::error!("Error sending video decode error: {err:?}");
                                }
                                continue;
                            }
                        }
                    }
                    VideoThreadMessage::Seek(ts, sender) => {
                        self.sender = sender;
                        if let Some(decoder) = self.decoder.as_mut() {
                            if let Err(err) = decoder.context.seek(ts as i64, i64::MIN..i64::MAX) {
                                log::error!("Error seeking video: {err:?}");
                            }
                        }
                    }
                    VideoThreadMessage::Exit => {
                        break;
                    }
                }
            }
            if self.sender.is_full() {
                std::thread::sleep(std::time::Duration::from_millis(10));
                continue;
            }
            if let Some(decoder) = self.decoder.as_mut() {
                match decoder.decode() {
                    Ok(Some(frame)) => {
                        if let Err(err) = self.sender.send(VideoThreadEvent::DecodedFrame(frame)) {
                            log::error!("Error sending decoded frame: {err:?}");
                        }
                    }
                    Ok(None) => {}
                    Err(err) => log::error!("Error decoding video: {err:?}"),
                }
            }
        }
    }
}

struct VideoDecoder {
    context: ffmpeg::format::context::Input,
    decoder: ffmpeg::decoder::Video,
    converter: ffmpeg::software::scaling::context::Context,
    stream_index: usize,
    metadata: VideoMetadata,
}

impl VideoDecoder {
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
            frames: stream.frames() as usize - 1,
        };

        Ok(Self {
            decoder,
            context,
            converter,
            stream_index: video_stream_index,
            metadata,
        })
    }

    fn decode(&mut self) -> anyhow::Result<Option<Vec<u8>>> {
        for (stream, packet) in self.context.packets() {
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
}
