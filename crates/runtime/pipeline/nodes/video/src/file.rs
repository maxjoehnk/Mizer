use std::borrow::Cow;
use std::path::PathBuf;

use anyhow::{anyhow, Context};
use ffmpeg_the_third as ffmpeg;
use flume::{bounded, unbounded};
use serde::{Deserialize, Serialize};

use mizer_media::documents::MediaId;
use mizer_media::MediaServer;
use mizer_node::*;
use mizer_wgpu::{
    TextureHandle, TextureProvider, TextureRegistry, TextureSourceStage, WgpuContext, WgpuPipeline,
};

const PLAYBACK_INPUT: &str = "Playback";
const PLAYBACK_OUTPUT: &str = "Playback";
const OUTPUT_PORT: &str = "Output";

const FILE_SETTING: &str = "File";
const SYNC_TRANSPORT_STATE_SETTING: &str = "Sync to Transport State";

// TODO: Use ringbuffer for video frames to keep memory usage in check

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct VideoFileNode {
    pub file: String,
    #[serde(default)]
    pub sync_to_transport_state: bool,
}

impl ConfigurableNode for VideoFileNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(media FILE_SETTING, &self.file, vec![MediaContentType::Video, MediaContentType::Image]),
            setting!(SYNC_TRANSPORT_STATE_SETTING, self.sync_to_transport_state),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(media setting, FILE_SETTING, self.file);
        update!(bool setting, SYNC_TRANSPORT_STATE_SETTING, self.sync_to_transport_state);

        update_fallback!(setting)
    }
}

impl PipelineNode for VideoFileNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Video File".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(PLAYBACK_INPUT, PortType::Single),
            output_port!(OUTPUT_PORT, PortType::Texture),
            output_port!(PLAYBACK_OUTPUT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoFile
    }
}

impl ProcessingNode for VideoFileNode {
    type State = (VideoFileNodeState, Option<VideoFileState>);

    fn process(
        &self,
        context: &impl NodeContext,
        (node_state, state): &mut Self::State,
    ) -> anyhow::Result<()> {
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let texture_registry = context.inject::<TextureRegistry>().unwrap();
        let video_pipeline = context.inject::<WgpuPipeline>().unwrap();
        let media_server = context.inject::<MediaServer>().unwrap();

        if let Some(value) = context.read_port::<_, f64>(PLAYBACK_INPUT) {
            let playback = value - f64::EPSILON > 0.0;
            node_state.playing = playback;
        }

        if self.file.is_empty() {
            return Ok(());
        }

        let media_id = MediaId::try_from(self.file.clone())?;
        let media_file = media_server.get_media_file(media_id);
        if media_file.is_none() {
            return Ok(());
        }

        let media_file = media_file.unwrap();

        if state.is_none() {
            *state = Some(
                VideoFileState::new(wgpu_context, texture_registry, media_file.file_path.clone())
                    .context("Creating video file state")?,
            );
        }

        let state = state.as_mut().unwrap();
        if state.texture.file_path != media_file.file_path {
            state
                .change_file(media_file.file_path)
                .context("Changing video file")?;
        }
        state.receive_frames();
        state.texture.clock_state = if self.sync_to_transport_state {
            context.clock_state()
        } else {
            if node_state.playing {
                ClockState::Playing
            } else {
                ClockState::Stopped
            }
        };
        context.write_port::<_, f64>(
            PLAYBACK_OUTPUT,
            match state.texture.clock_state {
                ClockState::Playing => 1.0,
                ClockState::Stopped => 0.0,
                ClockState::Paused => 0.5,
            },
        );
        context.write_port(OUTPUT_PORT, state.transfer_texture);
        let texture = texture_registry
            .get(&state.transfer_texture)
            .ok_or_else(|| anyhow!("Texture not found in registry"))?;
        let stage = state
            .pipeline
            .render(wgpu_context, &texture, &mut state.texture)
            .context("Rendering texture source pipeline")?;
        video_pipeline.add_stage(stage);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn debug_ui<'a>(&self, ui: &mut impl DebugUiDrawHandle<'a>, (node_state, state): &Self::State) {
        ui.collapsing_header("Settings", |ui| {
            ui.columns(2, |columns| {
                columns[0].label("File");
                columns[1].label(&self.file);
            });
        });

        ui.collapsing_header("State", |ui| {
            ui.columns(2, |columns| {
                columns[0].label("Playing");
                columns[1].label(format!("{}", node_state.playing));

                if let Some(state) = state.as_ref() {
                    columns[0].label("Texture Size");
                    columns[1].label(format!(
                        "{}x{}",
                        state.texture.width(),
                        state.texture.height()
                    ));

                    columns[0].label("FPS");
                    columns[1].label(format!("{}", state.texture.metadata.frames,));

                    columns[0].label("Buffered Frames");
                    columns[1].label(format!(
                        "{} / {} Frames ({} MB)",
                        state.texture.buffer.len(),
                        state.texture.metadata.frames,
                        state.texture.buffer.len()
                            * state.texture.width() as usize
                            * state.texture.height() as usize
                            * 4
                            / 1024
                            / 1024
                    ));

                    columns[0].label("Frame");
                    columns[1].label(format!("{}", state.texture.frame));
                }
            });
        });
    }
}

#[derive(Debug)]
pub struct VideoFileNodeState {
    playing: bool,
}

impl Default for VideoFileNodeState {
    fn default() -> Self {
        Self { playing: true }
    }
}

pub struct VideoFileState {
    texture: VideoTexture,
    pipeline: TextureSourceStage,
    transfer_texture: TextureHandle,
    decode_handle: VideoDecodeThreadHandle,
}

impl VideoFileState {
    fn new(
        context: &WgpuContext,
        registry: &TextureRegistry,
        path: PathBuf,
    ) -> anyhow::Result<Self> {
        log::debug!("Loading video file: {path:?}");
        let decode_handle = VideoDecodeThread::spawn()?;
        let metadata = decode_handle.decode_file(path.clone())?;
        let mut texture =
            VideoTexture::new(path, metadata).context("Creating new video texture provider")?;
        let pipeline = TextureSourceStage::new(context, &mut texture)
            .context("Creating texture source stage")?;
        let transfer_texture = registry.register(context, texture.width(), texture.height(), None);

        Ok(Self {
            texture,
            pipeline,
            transfer_texture,
            decode_handle,
        })
    }

    fn change_file(&mut self, file_path: PathBuf) -> anyhow::Result<()> {
        let metadata = self.decode_handle.decode_file(file_path.clone())?;
        self.texture = VideoTexture::new(file_path, metadata)
            .context("Creating new video texture provider")?;

        Ok(())
    }

    fn receive_frames(&mut self) {
        for _ in 0..60 {
            if let Some(VideoThreadEvent::DecodedFrame(frame)) = self.decode_handle.try_recv() {
                self.texture.buffer.push(frame);
            } else {
                break;
            }
        }
    }
}

struct VideoTexture {
    clock_state: ClockState,
    file_path: PathBuf,
    buffer: Vec<Vec<u8>>,
    frame: usize,
    metadata: VideoMetadata,
}

impl VideoTexture {
    fn new(path: PathBuf, metadata: VideoMetadata) -> anyhow::Result<Self> {
        Ok(Self {
            clock_state: ClockState::Playing,
            file_path: path,
            buffer: Vec::new(),
            frame: 0,
            metadata,
        })
    }
}

#[derive(Debug, Clone, Copy)]
struct VideoMetadata {
    width: u32,
    height: u32,
    fps: f64,
    frames: usize,
}

struct VideoDecodeThreadHandle {
    sender: flume::Sender<VideoThreadMessage>,
    receiver: flume::Receiver<VideoThreadEvent>,
}

impl VideoDecodeThreadHandle {
    fn decode_file(&self, path: PathBuf) -> anyhow::Result<VideoMetadata> {
        self.sender
            .send(VideoThreadMessage::DecodeFile(path))
            .unwrap();

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

    fn try_recv(&self) -> Option<VideoThreadEvent> {
        self.receiver.try_recv().ok()
    }
}

impl Drop for VideoDecodeThreadHandle {
    fn drop(&mut self) {
        self.sender.send(VideoThreadMessage::Exit).unwrap();
    }
}

enum VideoThreadMessage {
    DecodeFile(PathBuf),
    Exit,
}

enum VideoThreadEvent {
    DecodedFrame(Vec<u8>),
    Metadata(VideoMetadata),
}

struct VideoDecodeThread {
    receiver: flume::Receiver<VideoThreadMessage>,
    sender: flume::Sender<VideoThreadEvent>,
    decoder: Option<VideoDecoder>,
}

impl VideoDecodeThread {
    fn spawn() -> anyhow::Result<VideoDecodeThreadHandle> {
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
                    VideoThreadMessage::DecodeFile(path) => match VideoDecoder::new(path) {
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
                            continue;
                        }
                    },
                    VideoThreadMessage::Exit => {
                        break;
                    }
                }
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
    pub fn new(path: PathBuf) -> anyhow::Result<Self> {
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

        Ok(None)
    }
}

impl TextureProvider for VideoTexture {
    fn width(&self) -> u32 {
        self.metadata.width
    }

    fn height(&self) -> u32 {
        self.metadata.height
    }

    fn data(&mut self) -> anyhow::Result<Option<Cow<[u8]>>> {
        profiling::scope!("VideoTexture::data");
        if self.buffer.is_empty() {
            return Ok(None);
        }
        if let ClockState::Stopped = self.clock_state {
            self.frame = 0;
        }
        let frame = self.frame as f64;
        let frame = frame * (self.metadata.fps / 60.0);
        let frame = frame.floor() as usize;
        if let Some(data) = self.buffer.get(frame) {
            let data: Cow<[u8]> = Cow::Borrowed(data);
            if self.clock_state == ClockState::Playing {
                self.frame += 1;
                if frame >= self.metadata.frames {
                    self.frame = 0;
                }
            }
            Ok(Some(data))
        } else {
            Ok(None)
        }
    }
}
