use std::fmt::{Display, Formatter};
use std::fs::File;
use std::path::{Path, PathBuf};
use std::sync::{Arc, Mutex};
use std::thread;
use std::thread::JoinHandle;

use anyhow::Context;
use enum_iterator::Sequence;
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};
use symphonia::core::audio::SampleBuffer;
use symphonia::core::codecs::{Decoder, CODEC_TYPE_NULL};
use symphonia::core::errors::Error;
use symphonia::core::formats::FormatReader;
use symphonia::core::io::MediaSourceStream;
use symphonia::core::probe::Hint;
use symphonia::default;

use mizer_node::edge::Edge;
use mizer_node::*;

use crate::BUFFER_SIZE;

const PLAYBACK_INPUT: &str = "Playback";
const PLAYBACK_OUTPUT: &str = "Playback";
const TIMECODE_INPUT: &str = "Timecode";
const TIMECODE_OUTPUT: &str = "Timecode";
const AUDIO_OUTPUT: &str = "Stereo";

const PLAYBACK_MODE_SETTING: &str = "Playback Mode";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct AudioFileNode {
    pub path: PathBuf,
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
    PingPong,
}

impl Display for PlaybackMode {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::OneShot => write!(f, "One Shot"),
            Self::Loop => write!(f, "Loop"),
            Self::PingPong => write!(f, "Ping Pong"),
        }
    }
}

impl ConfigurableNode for AudioFileNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(enum PLAYBACK_MODE_SETTING, self.playback_mode)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(enum setting, PLAYBACK_MODE_SETTING, self.playback_mode);

        update_fallback!(setting)
    }
}

impl PipelineNode for AudioFileNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(AudioFileNode).to_string(),
            preview_type: PreviewType::Waveform,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(PLAYBACK_INPUT, PortType::Single),
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
        if let Some(value) = context.read_port(PLAYBACK_INPUT) {
            if let Some(paused) = node_state.paused_edge.update(value) {
                node_state.paused = paused;
            }
        }
        if !self.path.exists() {
            tracing::debug!(
                "Skipping processing of AudioFileNode. Path {:?} does not exist",
                self.path
            );

            return Ok(());
        }
        if decode_state
            .as_ref()
            .and_then(|s| s.is_file(&self.path).then_some(()))
            .is_none()
        {
            let audio_state = AudioFileDecodeState::new(self.path.clone())
                .context(format!("Opening AudioFileNodeState for {:?}", &self.path))?;
            *decode_state = Some(audio_state);
        }

        if node_state.paused {
            context.write_port::<_, Vec<f64>>(AUDIO_OUTPUT, vec![0.; BUFFER_SIZE]);
        } else if let Some(state) = decode_state.as_mut() {
            let frames = state.read();

            context.write_port::<_, Vec<f64>>(AUDIO_OUTPUT, frames);
        }

        context.write_port::<_, f64>(PLAYBACK_OUTPUT, if node_state.paused { 0f64 } else { 1f64 });

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

pub struct AudioFileNodeState {
    paused: bool,
    paused_edge: Edge,
}

impl Default for AudioFileNodeState {
    fn default() -> Self {
        Self {
            paused: true,
            paused_edge: Default::default(),
        }
    }
}

pub struct AudioFileDecodeState {
    path: PathBuf,
    thread_handle: JoinHandle<anyhow::Result<()>>,
    buffer: Arc<Mutex<Vec<f64>>>,
    offset: usize,
}

impl AudioFileDecodeState {
    #[tracing::instrument]
    fn new(path: PathBuf) -> anyhow::Result<Self> {
        let (buffer, thread_handle) = AudioDecodeThread::spawn(path.clone())?;

        Ok(Self {
            path,
            thread_handle,
            buffer,
            offset: 0,
        })
    }

    pub(crate) fn is_file(&self, path: &Path) -> bool {
        self.path == path
    }

    fn read(&mut self) -> Vec<f64> {
        let min = self.offset;
        let max = self.offset + BUFFER_SIZE;

        let buffer = self.buffer.lock().unwrap();
        if max > buffer.len() {
            return vec![0.; BUFFER_SIZE];
        }
        let buffer = buffer[min..max].to_vec();
        self.offset += BUFFER_SIZE;

        buffer
    }
}

struct AudioDecodeThread {
    path: PathBuf,
    format: Box<dyn FormatReader>,
    decoder: Box<dyn Decoder>,
    track_id: u32,
    buffer: Arc<Mutex<Vec<f64>>>,
}

impl AudioDecodeThread {
    fn spawn(
        path: PathBuf,
    ) -> anyhow::Result<(Arc<Mutex<Vec<f64>>>, JoinHandle<anyhow::Result<()>>)> {
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

        let buffer = Arc::new(Mutex::new(Default::default()));

        let decoder_thread = Self {
            buffer: Arc::clone(&buffer),
            track_id,
            format,
            decoder,
            path,
        };

        let thread_handle = thread::spawn(move || decoder_thread.decode());

        Ok((buffer, thread_handle))
    }

    fn decode(mut self) -> anyhow::Result<()> {
        loop {
            let packet = match self.format.next_packet() {
                Ok(packet) => packet,
                Err(Error::ResetRequired) => todo!(),
                Err(err) => return Err(err.into()),
            };

            while !self.format.metadata().is_latest() {
                self.format.metadata().pop();
            }

            if packet.track_id() != self.track_id {
                continue;
            }

            match self.decoder.decode(&packet) {
                Ok(decoded) => {
                    let mut target_buffer =
                        SampleBuffer::new(decoded.frames() as u64, *decoded.spec());
                    target_buffer.copy_interleaved_ref(decoded);

                    let mut buffer = self.buffer.lock().unwrap();
                    buffer.extend_from_slice(target_buffer.samples());
                }
                Err(Error::IoError(err))
                    if err.kind() == std::io::ErrorKind::UnexpectedEof
                        && err.to_string() == "end of stream" =>
                {
                    return Ok(());
                }
                Err(Error::IoError(err)) => {
                    tracing::error!(error = %err, "IO Error while decoding next packet for {:?}", &self.path);
                }
                Err(Error::DecodeError(err)) => {
                    tracing::error!(error = %err, "Decode Error while decoding next packet for {:?}", &self.path);
                }
                Err(err) => return Err(err.into()),
            }
        }
    }
}
