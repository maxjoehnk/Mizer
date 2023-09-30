use std::borrow::Cow;
use std::path::PathBuf;

use ringbuffer::{AllocRingBuffer, RingBuffer};

use mizer_node::*;
use mizer_wgpu::TextureProvider;

use super::decoder::*;

pub struct VideoTexture {
    pub clock_state: ClockState,
    pub file_path: PathBuf,
    buffer: AllocRingBuffer<Vec<u8>>,
    buffer_frame: usize,
    frame: usize,
    metadata: VideoMetadata,
}

impl VideoTexture {
    pub fn new(path: PathBuf, metadata: VideoMetadata) -> anyhow::Result<Self> {
        Ok(Self {
            clock_state: ClockState::Playing,
            file_path: path,
            buffer: AllocRingBuffer::new(10),
            buffer_frame: 0,
            frame: 0,
            metadata,
        })
    }

    pub fn receive_frames(&mut self, handle: &mut VideoDecodeThreadHandle) {
        profiling::scope!("VideoTexture::receive_frames");
        while !self.buffer.is_full() {
            if let Some(VideoThreadEvent::DecodedFrame(frame)) = handle.try_recv() {
                self.buffer.push(frame);
            } else {
                break;
            }
        }
    }

    pub fn debug_ui<'a>(&self, ui: &mut impl DebugUiDrawHandle<'a>) {
        ui.columns(2, |columns| {
            columns[0].label("Texture Size");
            columns[1].label(format!("{}x{}", self.width(), self.height()));

            columns[0].label("FPS");
            columns[1].label(format!("{}", self.metadata.fps));

            columns[0].label("Buffered Frames");
            columns[1].label(format!(
                "{:02} Frames ({} MB)",
                self.buffer.len(),
                self.buffer.len() * self.width() as usize * self.height() as usize * 4
                    / 1024
                    / 1024
            ));

            columns[0].label("Frame");
            columns[1].label(format!("{}", self.frame));
        });
    }

    pub fn set_clock_state(&mut self, clock_state: ClockState) {
        self.clock_state = clock_state;
        if clock_state == ClockState::Stopped {
            self.buffer.clear();
            self.frame = 0;
            self.buffer_frame = 0;
        }
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
            self.buffer_frame = 0;
        }
        let frame = self.frame as f64;
        let frame = frame * (self.metadata.fps / 60.0);
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
                self.frame += 1;
            }
            Ok(Some(data))
        } else {
            Ok(None)
        }
    }
}
