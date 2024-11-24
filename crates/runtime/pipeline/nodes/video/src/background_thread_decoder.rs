use std::borrow::Cow;
use flume::{bounded, unbounded};
use ringbuffer::{AllocRingBuffer, RingBuffer};
use mizer_wgpu::TextureProvider;
use mizer_wgpu::wgpu::TextureFormat;

#[derive(Debug, Clone, Copy)]
pub struct VideoMetadata {
    pub width: u32,
    pub height: u32,
    pub fps: f64,
    pub frames: usize,
}

impl Default for VideoMetadata {
    fn default() -> Self {
        Self {
            width: 1920,
            height: 1080,
            fps: 30.0,
            frames: 0,
        }
    }
}

pub struct BackgroundDecoderThreadHandle<TDecoder: VideoDecoder> {
    sender:
        flume::Sender<BackgroundDecoderThreadMessage<TDecoder::CreateDecoder, TDecoder::Commands>>,
    receiver: flume::Receiver<VideoThreadEvent>,
}

impl<TDecoder: VideoDecoder> BackgroundDecoderThreadHandle<TDecoder> {
    pub fn is_alive(&self) -> bool {
        !self.sender.is_disconnected()
    }
    
    pub fn decode(&mut self, args: TDecoder::CreateDecoder) -> anyhow::Result<Option<VideoMetadata>> {
        tracing::trace!("BackgroundDecoderThreadHandle::decode");
        let (message_tx, message_rx) = bounded(5);
        self.sender
            .send(BackgroundDecoderThreadMessage::DecodeFile(args, message_tx))?;
        self.receiver = message_rx;

        let metadata = self
            .receiver
            .recv_timeout(std::time::Duration::from_millis(5))
            .ok()
            .and_then(|event| match event {
                VideoThreadEvent::Metadata(metadata) => Some(metadata),
                _ => None,
            });

        Ok(metadata)
    }

    pub fn send(&mut self, command: TDecoder::Commands) -> anyhow::Result<()> {
        let (message_tx, message_rx) = bounded(5);
        self.sender
            .send(BackgroundDecoderThreadMessage::Command(
                command,
                Some(message_tx),
            ))?;
        self.receiver = message_rx;

        Ok(())
    }

    pub fn try_recv(&self) -> Option<VideoThreadEvent> {
        self.receiver.try_recv().ok()
    }
}

impl<TDecoder: VideoDecoder> Drop for BackgroundDecoderThreadHandle<TDecoder> {
    fn drop(&mut self) {
        if self.sender.send(BackgroundDecoderThreadMessage::Exit).is_err() {
            tracing::debug!("Error sending exit message, thread seems to be shut down already");
        }
    }
}

enum BackgroundDecoderThreadMessage<TCreateDecoder, TCommands> {
    DecodeFile(TCreateDecoder, flume::Sender<VideoThreadEvent>),
    Command(TCommands, Option<flume::Sender<VideoThreadEvent>>),
    Exit,
}

pub enum VideoThreadEvent {
    DecodedFrame(Vec<u8>),
    DecodeError(anyhow::Error),
    Metadata(VideoMetadata),
}

pub trait VideoDecoder {
    type CreateDecoder: Send + Sync + 'static;
    type Commands: Send + Sync + 'static;

    fn new(args: Self::CreateDecoder) -> anyhow::Result<Self>
    where
        Self: Sized;

    fn handle(&mut self, command: Self::Commands) -> anyhow::Result<()>;

    fn decode(&mut self) -> anyhow::Result<Option<Vec<u8>>>;

    fn metadata(&self) -> anyhow::Result<VideoMetadata>;
}

pub struct BackgroundDecoderThread<TDecoder: VideoDecoder> {
    receiver: flume::Receiver<
        BackgroundDecoderThreadMessage<TDecoder::CreateDecoder, TDecoder::Commands>,
    >,
    sender: flume::Sender<VideoThreadEvent>,
    decoder: Option<TDecoder>,
}

impl<TDecoder: VideoDecoder> BackgroundDecoderThread<TDecoder> {
    pub fn spawn() -> anyhow::Result<BackgroundDecoderThreadHandle<TDecoder>> {
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

        Ok(BackgroundDecoderThreadHandle {
            receiver: event_rx,
            sender: message_tx,
        })
    }

    fn run(mut self) {
        loop {
            if let Ok(message) = self.receiver.try_recv() {
                match message {
                    BackgroundDecoderThreadMessage::DecodeFile(args, sender) => {
                        self.sender = sender;
                        match TDecoder::new(args) {
                            Ok(decoder) => {
                                match decoder.metadata() {
                                    Ok(metadata) => {
                                        if let Err(err) =
                                            self.sender.send(VideoThreadEvent::Metadata(metadata))
                                        {
                                            tracing::error!(
                                                "Closing decoder thread. Error sending video metadata: {err:?}"
                                            );
                                            return;
                                        }
                                    }
                                    Err(err) => {
                                        tracing::error!("Error getting video metadata: {err:?}");
                                    }
                                }
                                self.decoder = Some(decoder);
                            }
                            Err(err) => {
                                tracing::error!("Error creating video decoder: {err:?}");
                                if let Err(err) =
                                    self.sender.send(VideoThreadEvent::DecodeError(err))
                                {
                                    tracing::error!("Closing decoder thread. Error sending video decode error: {err:?}");
                                    return;
                                }
                                continue;
                            }
                        }
                    }
                    BackgroundDecoderThreadMessage::Command(command, sender) => {
                        if let Some(sender) = sender {
                            self.sender = sender;
                        }
                        if let Some(decoder) = self.decoder.as_mut() {
                            if let Err(err) = decoder.handle(command) {
                                tracing::error!("Error seeking video: {err:?}");
                            }
                        }
                    }
                    BackgroundDecoderThreadMessage::Exit => {
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
                            tracing::error!("Closing decoder thread. Error sending decoded frame: {err:?}");
                            return;
                        }
                    }
                    Ok(None) => {}
                    Err(err) => tracing::error!("Error decoding video: {err:?}"),
                }
            }
        }
    }
}

pub struct BackgroundDecoderTexture {
    buffer: AllocRingBuffer<Vec<u8>>,
    metadata: Option<VideoMetadata>,
}

impl BackgroundDecoderTexture {
    pub fn new(metadata: Option<VideoMetadata>) -> Self {
        tracing::trace!("BackgroundThreadTexture::new");
        Self {
            buffer: AllocRingBuffer::new(10),
            metadata,
        }
    }

    pub fn is_ready(&self) -> bool {
        self.metadata.is_some()
    }

    pub fn receive_frames<TDecoder: VideoDecoder>(&mut self, handle: &mut BackgroundDecoderThreadHandle<TDecoder>) {
        profiling::scope!("BackgroundThreadTexture::receive_frames");
        for event in handle.receiver.drain() {
            match event {
                VideoThreadEvent::Metadata(metadata) => {
                    tracing::debug!("Received video metadata: {metadata:?}");
                    self.metadata = Some(metadata);
                }
                VideoThreadEvent::DecodedFrame(frame) => {
                    self.buffer.push(frame);
                }
                VideoThreadEvent::DecodeError(error) => {
                    tracing::error!("Error decoding frame: {error}");
                }
            }
        }
    }
}

impl TextureProvider for BackgroundDecoderTexture {
    fn texture_format(&self) -> TextureFormat {
        TextureFormat::Rgba8UnormSrgb
    }

    fn width(&self) -> u32 {
        self.metadata.unwrap_or_default().width
    }

    fn height(&self) -> u32 {
        self.metadata.unwrap_or_default().height
    }

    fn data(&mut self) -> anyhow::Result<Option<Cow<[u8]>>> {
        profiling::scope!("BackgroundThreadTexture::data");
        if self.buffer.is_empty() {
            return Ok(None);
        }

        Ok(self
            .buffer
            .back()
            .map(|data| Cow::Borrowed(data.as_slice())))
    }
}
