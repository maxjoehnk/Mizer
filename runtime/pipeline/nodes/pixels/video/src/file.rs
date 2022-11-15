use anyhow::Context as _;
use std::fs::File;
use std::io::Write;
use std::path::PathBuf;

use ffmpeg_next as ffmpeg;
use ffmpeg_next::format::Pixel;
use ffmpeg_next::frame::Video;
use ffmpeg_next::media::Type;
use ffmpeg_next::software::scaling::{Context, Flags};
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::ConvertBytes;

const OUTPUT_PORT: &str = "output";

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct VideoPixelFileNode {
    pub file_path: String,
}

impl PipelineNode for VideoPixelFileNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(PipelineNode).into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            OUTPUT_PORT.into(),
            PortMetadata {
                port_type: PortType::Multi,
                direction: PortDirection::Output,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoPixelFile
    }
}

impl ProcessingNode for VideoPixelFileNode {
    type State = Option<VideoPixelFileState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let file_path = PathBuf::from(&self.file_path);
        if !file_path.exists() {
            return Ok(());
        }
        let Some(dimensions) = context.output_port(OUTPUT_PORT).and_then(|port| port.dimensions) else {
            return Ok(());
        };
        if state
            .as_ref()
            .map(|s| s.file_path != file_path)
            .unwrap_or_default()
        {
            *state = None;
        }
        if state.is_none() {
            *state = Some(VideoPixelFileState::new(file_path, dimensions)?);
        }
        let Some(state) = state.as_mut() else { return Ok(()) };
        let mut frame = state.next_frame()?;
        if frame.is_none() {
            state.reset()?;
            frame = state.next_frame()?;
        }
        if let Some(frame) = frame {
            context.write_port(OUTPUT_PORT, frame);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.file_path = config.file_path.clone();
    }
}

pub struct VideoPixelFileState {
    file_path: PathBuf,
    width: u32,
    height: u32,
    input: ffmpeg::format::context::Input,
    stream_index: usize,
    decoder: ffmpeg::decoder::Video,
    scaler: Context,
    frame_index: usize,
}

impl VideoPixelFileState {
    fn new(file_path: PathBuf, (width, height): (u64, u64)) -> anyhow::Result<Self> {
        let width = width as u32;
        let height = height as u32;

        let ictx = ffmpeg::format::input(&file_path)?;
        let input = ictx
            .streams()
            .best(Type::Video)
            .ok_or(ffmpeg::Error::StreamNotFound)?;
        let stream_index = input.index();
        let context_decoder = ffmpeg::codec::context::Context::from_parameters(input.parameters())?;
        let decoder = context_decoder.decoder().video()?;

        let scaler = Context::get(
            decoder.format(),
            decoder.width(),
            decoder.height(),
            Pixel::RGB24,
            width,
            height,
            Flags::BILINEAR,
        )?;

        Ok(Self {
            file_path,
            width,
            height,
            input: ictx,
            stream_index,
            decoder,
            scaler,
            frame_index: 0,
        })
    }

    fn next_frame(&mut self) -> anyhow::Result<Option<Vec<f64>>> {
        for (stream, packet) in self.input.packets() {
            if stream.index() == self.stream_index {
                log::trace!("Next packet {stream:?}");
                self.decoder
                    .send_packet(&packet)
                    .context("Send packet to decoder")?;
                log::trace!("Decoding frame");
                let mut decoded = Video::empty();
                self.decoder.receive_frame(&mut decoded)?;
                let mut rgb_frame = Video::empty();
                self.scaler
                    .run(&decoded, &mut rgb_frame)
                    .context("Scale frame")?;

                if self.frame_index <= 20 {
                    self.frame_index += 1;
                    let mut file = File::create(format!("frame{}.ppm", self.frame_index))?;
                    file.write_all(
                        format!("P6\n{} {}\n255\n", rgb_frame.width(), rgb_frame.height())
                            .as_bytes(),
                    )?;
                    file.write_all(rgb_frame.data(0))?;
                }

                let data = rgb_frame
                    .data(0)
                    .iter()
                    .map(|byte| f64::from_8bit(*byte))
                    .collect();

                return Ok(Some(data));
            }
        }

        Ok(None)
    }

    fn reset(&mut self) -> anyhow::Result<()> {
        self.input.seek(0, (0..0))?;

        Ok(())
    }
}
