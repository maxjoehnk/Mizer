use anyhow::anyhow;
use flume::{bounded, unbounded};

#[derive(Debug, Clone, Copy)]
pub struct VideoMetadata {
    pub width: u32,
    pub height: u32,
    pub fps: f64,
    pub frames: usize,
}

pub struct BackgroundDecoderThreadHandle<TDecoder: VideoDecoder> {
    sender:
        flume::Sender<BackgroundDecoderThreadMessage<TDecoder::CreateDecoder, TDecoder::Commands>>,
    receiver: flume::Receiver<VideoThreadEvent>,
}

impl<TDecoder: VideoDecoder> BackgroundDecoderThreadHandle<TDecoder> {
    pub fn decode(&mut self, args: TDecoder::CreateDecoder) -> anyhow::Result<VideoMetadata> {
        let (message_tx, message_rx) = bounded(5);
        self.sender
            .send(BackgroundDecoderThreadMessage::DecodeFile(args, message_tx))
            .unwrap();
        self.receiver = message_rx;

        let metadata = self
            .receiver
            .iter()
            .find_map(|event| match event {
                VideoThreadEvent::Metadata(metadata) => Some(Ok(metadata)),
                VideoThreadEvent::DecodeError(err) => Some(Err(err)),
                _ => None,
            })
            .ok_or_else(|| anyhow!("No metadata received"))??;

        Ok(metadata)
    }

    pub fn send(&mut self, command: TDecoder::Commands) -> anyhow::Result<()> {
        let (message_tx, message_rx) = bounded(5);
        self.sender
            .send(BackgroundDecoderThreadMessage::Command(
                command,
                Some(message_tx),
            ))
            .unwrap();
        self.receiver = message_rx;

        Ok(())
    }

    pub fn try_recv(&self) -> Option<VideoThreadEvent> {
        self.receiver.try_recv().ok()
    }
}

impl<TDecoder: VideoDecoder> Drop for BackgroundDecoderThreadHandle<TDecoder> {
    fn drop(&mut self) {
        self.sender
            .send(BackgroundDecoderThreadMessage::Exit)
            .unwrap();
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
                                                "Error sending video metadata: {err:?}"
                                            );
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
                                    tracing::error!("Error sending video decode error: {err:?}");
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
                            tracing::error!("Error sending decoded frame: {err:?}");
                        }
                    }
                    Ok(None) => {}
                    Err(err) => tracing::error!("Error decoding video: {err:?}"),
                }
            }
        }
    }
}
