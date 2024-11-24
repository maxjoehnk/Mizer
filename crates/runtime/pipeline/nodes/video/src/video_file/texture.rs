use std::borrow::Cow;
use std::path::PathBuf;

use ringbuffer::{AllocRingBuffer, RingBuffer};

use mizer_node::*;
use mizer_wgpu::wgpu::TextureFormat;
use mizer_wgpu::TextureProvider;

use crate::background_thread_decoder::{VideoMetadata, VideoThreadEvent};

use super::decoder::*;

pub struct VideoTexture {
    pub clock_state: ClockState,
    pub file_path: PathBuf,
    pub playback_speed: f64,
    buffer: AllocRingBuffer<Vec<u8>>,
    buffer_frame: usize,
    frame: f64,
    metadata: Option<VideoMetadata>,
    playback_fps: f64,
}

impl VideoTexture {
    pub fn new(path: PathBuf, metadata: Option<VideoMetadata>) -> anyhow::Result<Self> {
        Ok(Self {
            clock_state: ClockState::Playing,
            file_path: path,
            playback_speed: 1.0,
            buffer: AllocRingBuffer::new(10),
            buffer_frame: 0,
            frame: 0f64,
            metadata,
            playback_fps: 60f64,
        })
    }

    pub fn receive_frames(&mut self, handle: &mut VideoDecodeThreadHandle) {
        profiling::scope!("VideoTexture::receive_frames");
        if self.buffer.is_full() {
            return;
        }
        while let Some(event) = handle.try_recv() {
            match event {
                VideoThreadEvent::Metadata(metadata) => {
                    self.metadata = Some(metadata);
                }
                VideoThreadEvent::DecodedFrame(frame) => {
                    self.buffer.push(frame);
                    if self.buffer.is_full() {
                        break;
                    }
                }
                VideoThreadEvent::DecodeError(error) => {
                    tracing::error!("Error decoding frame: {error}");
                }
            }
        }
    }

    pub fn debug_ui<'a>(&self, ui: &mut impl DebugUiDrawHandle<'a>) {
        ui.columns(2, |columns| {
            columns[0].label("Texture Size");
            if let Some(ref metadata) = self.metadata {
                columns[1].label(format!("{}x{}", metadata.width, metadata.height));
            }else {
                columns[1].label("N/A");
            }

            columns[0].label("Video FPS");
            if let Some(ref metadata) = self.metadata {
                columns[1].label(format!("{}", metadata.fps));
            }else {
                columns[1].label("N/A");
            }

            columns[0].label("Playback Speed");
            columns[1].label(format!("{}", self.playback_speed));

            columns[0].label("Buffered Frames");
            columns[1].label(format!(
                "{:02} / {:02} Frames ({} MB)",
                self.buffer.len(),
                self.buffer.capacity(),
                self.buffer.len() * self.width() as usize * self.height() as usize * 4
                    / 1024
                    / 1024
            ));

            columns[0].label("Frame in Buffer");
            columns[1].label(format!("{}", self.buffer_frame));

            columns[0].label("Frame");
            columns[1].label(format!("{}", self.frame));
        });
    }

    pub fn set_clock_state(&mut self, clock_state: ClockState) {
        self.clock_state = clock_state;
        if clock_state == ClockState::Stopped {
            self.buffer.clear();
            self.frame = 0f64;
            self.buffer_frame = 0;
        }
    }

    pub fn set_fps(&mut self, fps: f64) {
        self.playback_fps = fps;
    }
}

impl TextureProvider for VideoTexture {
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
        profiling::scope!("VideoTexture::data");
        if self.metadata.is_none() {
            return Ok(None);
        }
        if self.buffer.is_empty() {
            return Ok(None);
        }
        if let ClockState::Stopped = self.clock_state {
            self.frame = 0f64;
            self.buffer_frame = 0;

            return Ok(None);
        }
        let frame = self.frame;
        let frame = frame * (self.metadata.unwrap().fps / self.playback_fps);
        let frame = frame.floor() as usize;
        let mut frame_in_buffer = frame.saturating_sub(self.buffer_frame);
        while frame_in_buffer > 1 {
            self.buffer.skip();
            self.buffer_frame += 1;
            frame_in_buffer = frame.saturating_sub(self.buffer_frame);
        }
        if let Some(data) = self.buffer.get(frame_in_buffer) {
            let data: Cow<[u8]> = Cow::Borrowed(data);
            if self.clock_state == ClockState::Playing {
                self.frame += 1f64 * self.playback_speed;
            }
            Ok(Some(data))
        } else {
            Ok(None)
        }
    }
}
