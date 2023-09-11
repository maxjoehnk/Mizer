use std::fmt::{Display, Formatter};
use std::fs::File;
use std::path::{Path, PathBuf};
use std::thread;
use std::thread::JoinHandle;

use anyhow::Context;
use dasp::frame::Stereo;
use dasp::interpolate::sinc::Sinc;
use dasp::ring_buffer::Fixed;
use dasp::signal::equilibrium;
use dasp::{Frame, Signal};
use enum_iterator::Sequence;
use flume::{bounded, Receiver, Sender};
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};
use symphonia::core::audio::SampleBuffer;
use symphonia::core::codecs::{Decoder, CODEC_TYPE_NULL};
use symphonia::core::errors::Error;
use symphonia::core::formats::FormatReader;
use symphonia::core::io::MediaSourceStream;
use symphonia::core::probe::Hint;
use symphonia::default;

use mizer_media::documents::MediaId;
use mizer_media::MediaServer;
use mizer_node::edge::Edge;
use mizer_node::*;

use crate::{AudioContextExt, SAMPLE_RATE};

const PLAYBACK_INPUT: &str = "Playback";
const PAUSE_INPUT: &str = "Pause";
const PLAYBACK_OUTPUT: &str = "Playback";
const TIMECODE_INPUT: &str = "Timecode";
const TIMECODE_OUTPUT: &str = "Timecode";
const AUDIO_OUTPUT: &str = "Stereo";

const PLAYBACK_MODE_SETTING: &str = "Playback Mode";
const FILE_SETTING: &str = "File";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct AudioFileNode {
    #[serde(alias = "path")]
    pub file: String,
    pub playback_mode: PlaybackMode,
}

#[derive(
    Debug,
    Default,
    Clone,
    Copy,
    Deserialize,
    Serialize,
    PartialEq,
    Sequence,
    TryFromPrimitive,
    IntoPrimitive,
)]
#[repr(u8)]
pub enum PlaybackMode {
    #[default]
    OneShot,
    Loop,
}

impl Display for PlaybackMode {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::OneShot => write!(f, "One Shot"),
            Self::Loop => write!(f, "Loop"),
        }
    }
}

impl ConfigurableNode for AudioFileNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(enum PLAYBACK_MODE_SETTING, self.playback_mode),
            setting!(media FILE_SETTING, &self.file, vec![MediaContentType::Audio]),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(enum setting, PLAYBACK_MODE_SETTING, self.playback_mode);
        update!(media setting, FILE_SETTING, self.file);

        update_fallback!(setting)
    }
}

impl PipelineNode for AudioFileNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Audio File".to_string(),
            preview_type: PreviewType::Waveform,
            category: NodeCategory::Audio,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(PLAYBACK_INPUT, PortType::Single),
            input_port!(PAUSE_INPUT, PortType::Single),
            input_port!(TIMECODE_INPUT, PortType::Clock),
            output_port!(PLAYBACK_OUTPUT, PortType::Single),
            output_port!(TIMECODE_OUTPUT, PortType::Clock),
            output_port!(AUDIO_OUTPUT, PortType::Multi),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::AudioFile
    }
}

impl ProcessingNode for AudioFileNode {
    type State = (AudioFileNodeState, Option<AudioFileDecodeState>);

    fn process(
        &self,
        context: &impl NodeContext,
        (node_state, decode_state): &mut Self::State,
    ) -> anyhow::Result<()> {
        let media_server = context.inject::<MediaServer>().unwrap();
        if let Some(value) = context.read_port(PAUSE_INPUT) {
            if let Some(paused) = node_state.paused_edge.update(value) {
                node_state.paused = paused;
            }
        }
        let mut playback_changed = false;
        if let Some(value) = context.read_port::<_, f64>(PLAYBACK_INPUT) {
            let playback = value - f64::EPSILON > 0.0;
            if playback != node_state.playing {
                playback_changed = true;
            }
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
        let path = media_file.file_path;

        if !path.exists() {
            tracing::debug!(
                "Skipping processing of AudioFileNode. Path {:?} does not exist",
                path
            );

            return Ok(());
        }
        if decode_state
            .as_ref()
            .and_then(|s| s.is_file(&path).then_some(()))
            .is_none()
        {
            tracing::debug!("Opening new decoder for {path:?}");
            let audio_state = AudioFileDecodeState::new(path.clone())
                .context(format!("Opening AudioFileDecodeState for {:?}", &path))?;
            *decode_state = Some(audio_state);
        }

        let playback_value = if node_state.paused {
            context.output_signal(AUDIO_OUTPUT, equilibrium());
            0.5
        } else if let Some(state) = decode_state.as_mut() {
            match state.recv.try_recv() {
                Ok(mut player) => {
                    tracing::debug!("Received decoded file {path:?} from decoding thread");
                    if node_state.playing {
                        player.play();
                    }
                    state.player = Some(player)
                }
                Err(_) => {}
            }
            if let Some(player) = state.player.as_mut() {
                player.playback_mode = self.playback_mode;
                let sample_rate = player.sample_rate;
                if playback_changed {
                    if node_state.playing {
                        player.play();
                    } else {
                        player.stop();
                    }
                }
                let signal = player.by_ref();
                let ring_buffer = Fixed::from([[0.0; 2]; 100]);
                let sinc = Sinc::new(ring_buffer);
                let signal = signal.from_hz_to_hz(sinc, sample_rate as f64, SAMPLE_RATE as f64);

                context.output_signal(AUDIO_OUTPUT, signal);
                if player.next.is_some() {
                    1.0
                } else {
                    0.0
                }
            } else {
                0.0
            }
        } else {
            0.0
        };

        context.write_port::<_, f64>(PLAYBACK_OUTPUT, playback_value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

pub struct AudioFileNodeState {
    paused: bool,
    paused_edge: Edge,
    playing: bool,
}

impl Default for AudioFileNodeState {
    fn default() -> Self {
        Self {
            paused: false,
            paused_edge: Default::default(),
            playing: false,
        }
    }
}

pub struct AudioFileDecodeState {
    path: PathBuf,
    player: Option<DecodedFile>,
    recv: Receiver<DecodedFile>,
    thread_handle: JoinHandle<anyhow::Result<()>>,
}

struct DecodedFile {
    samples: Vec<f64>,
    offset: usize,
    sample_rate: u32,
    next: Option<Stereo<f64>>,
    playback_mode: PlaybackMode,
}

impl Signal for DecodedFile {
    type Frame = Stereo<f64>;

    fn next(&mut self) -> Self::Frame {
        match self.next {
            Some(frame) => {
                self.get_next_frame();
                frame
            }
            None => Stereo::<f64>::EQUILIBRIUM,
        }
    }
}

impl DecodedFile {
    fn new(samples: Vec<f64>, sample_rate: u32) -> Self {
        Self {
            sample_rate,
            samples,
            offset: 0,
            next: None,
            playback_mode: PlaybackMode::OneShot,
        }
    }

    fn seek_to(&mut self, offset: usize) {
        self.offset = offset;
        self.get_next_frame();
    }

    fn get_next_frame(&mut self) {
        tracing::trace!("get_next_frame");
        if self.offset + 2 > self.samples.len() {
            match self.playback_mode {
                PlaybackMode::Loop => self.seek_to(0),
                PlaybackMode::OneShot => {
                    self.next = None;
                }
            }
        } else {
            let frame = [self.samples[self.offset], self.samples[self.offset + 1]];
            self.next = Some(frame);
            self.offset += 2;
        }
    }

    fn stop(&mut self) {
        tracing::debug!("Stopping playback");
        self.offset = 0;
        self.next = None;
    }

    fn play(&mut self) {
        tracing::debug!("Starting playback");
        self.get_next_frame();
    }
}

impl AudioFileDecodeState {
    #[tracing::instrument]
    fn new(path: PathBuf) -> anyhow::Result<Self> {
        let (recv, thread_handle) = AudioDecodeThread::spawn(path.clone())?;

        Ok(Self {
            path,
            recv,
            player: None,
            thread_handle,
        })
    }

    pub(crate) fn is_file(&self, path: &Path) -> bool {
        self.path == path
    }
}

struct AudioDecodeThread {
    path: PathBuf,
    format: Box<dyn FormatReader>,
    decoder: Box<dyn Decoder>,
    track_id: u32,
    send: Sender<DecodedFile>,
}

impl AudioDecodeThread {
    fn spawn(
        path: PathBuf,
    ) -> anyhow::Result<(Receiver<DecodedFile>, JoinHandle<anyhow::Result<()>>)> {
        let codecs = default::get_codecs();
        let probe = default::get_probe();
        let file = File::open(&path)?;
        let stream = MediaSourceStream::new(Box::new(file), Default::default());
        let mut hint = Hint::new();
        if let Some(ext) = path.extension().and_then(|p| p.to_str()) {
            hint.with_extension(ext);
        }

        let meta = Default::default();
        let fmt = Default::default();

        let probe_result = probe.format(&hint, stream, &fmt, &meta)?;

        let format = probe_result.format;
        let track = format
            .tracks()
            .iter()
            .find(|t| t.codec_params.codec != CODEC_TYPE_NULL)
            .ok_or_else(|| anyhow::anyhow!("Unknown codec"))?;

        let track_id = track.id;

        let decoder_options = Default::default();

        let decoder = codecs.make(&track.codec_params, &decoder_options)?;

        tracing::debug!(
            "Got metadata for audio file sample_rate = {:?}",
            track.codec_params.sample_rate
        );

        let (send, recv) = bounded(1);

        let decoder_thread = Self {
            send,
            track_id,
            format,
            decoder,
            path,
        };

        let thread_handle = thread::spawn(move || decoder_thread.decode());

        Ok((recv, thread_handle))
    }

    #[tracing::instrument(skip(self))]
    fn decode(mut self) -> anyhow::Result<()> {
        tracing::debug!("Decoding file {:?}", self.path);
        let sample_rate = self.decoder.codec_params().sample_rate.unwrap_or(44_100);
        let mut buffer = Vec::new();
        loop {
            let packet = match self.format.next_packet() {
                Ok(packet) => packet,
                Err(Error::IoError(err))
                    if err.kind() == std::io::ErrorKind::UnexpectedEof
                        && err.to_string() == "end of stream" =>
                {
                    tracing::debug!("Successfully decoded file");
                    self.send.send(DecodedFile::new(buffer, sample_rate))?;
                    return Ok(());
                }
                Err(Error::ResetRequired) => todo!(),
                Err(err) => {
                    tracing::error!("Error acquiring next packet: {err:?}");
                    return Err(err.into());
                }
            };

            while !self.format.metadata().is_latest() {
                self.format.metadata().pop();
            }

            if packet.track_id() != self.track_id {
                continue;
            }

            match self.decoder.decode(&packet) {
                Ok(decoded) => {
                    if decoded.frames() == 0 {
                        tracing::debug!("No frames left");
                    }
                    let mut target_buffer =
                        SampleBuffer::new(decoded.frames() as u64, *decoded.spec());
                    target_buffer.copy_interleaved_ref(decoded);

                    buffer.extend_from_slice(target_buffer.samples());
                }
                Err(Error::IoError(err))
                    if err.kind() == std::io::ErrorKind::UnexpectedEof
                        && err.to_string() == "end of stream" =>
                {
                    tracing::debug!("Successfully decoded file");
                    self.send.send(DecodedFile::new(buffer, sample_rate))?;
                    return Ok(());
                }
                Err(Error::IoError(err)) => {
                    tracing::error!(error = %err, "IO Error while decoding next packet for {:?}", &self.path);
                }
                Err(Error::DecodeError(err)) => {
                    tracing::error!(error = %err, "Decode Error while decoding next packet for {:?}", &self.path);
                }
                Err(err) => {
                    tracing::error!(error = %err, "Error while decoding next packet for {:?}", &self.path);
                    return Err(err.into());
                }
            }
        }
    }
}
