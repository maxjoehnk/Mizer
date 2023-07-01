use anyhow::Context;
use ffmpeg_the_third as ffmpeg;
use serde::{Deserialize, Serialize};
use std::borrow::Cow;

use mizer_node::*;
use mizer_wgpu::{TextureProvider, TextureSourceStage, WgpuContext, WgpuPipeline};

const OUTPUT_PORT: &str = "Output";

const FILE_SETTING: &str = "File";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct VideoFileNode {
    pub file: String,
}

impl ConfigurableNode for VideoFileNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(FILE_SETTING, &self.file)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(text setting, FILE_SETTING, self.file);

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
        vec![output_port!(OUTPUT_PORT, PortType::Texture)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoFile
    }
}

impl ProcessingNode for VideoFileNode {
    type State = Option<VideoFileState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let video_pipeline = context.inject::<WgpuPipeline>().unwrap();

        if self.file.is_empty() {
            return Ok(());
        }

        if state.is_none() {
            *state = Some(
                VideoFileState::new(wgpu_context, &self.file)
                    .context("Creating video file state")?,
            );
        }

        let state = state.as_mut().unwrap();
        if let Some(texture) = context.write_texture(OUTPUT_PORT) {
            let stage = state
                .pipeline
                .render(wgpu_context, &texture, &mut state.texture)
                .context("Rendering texture source pipeline")?;
            video_pipeline.add_stage(stage);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        None
    }
}

pub struct VideoFileState {
    texture: VideoTexture,
    pipeline: TextureSourceStage,
}

impl VideoFileState {
    fn new(context: &WgpuContext, path: &str) -> anyhow::Result<Self> {
        log::debug!("Loading video file: {}", path);
        let mut texture = VideoTexture::new(path).context("Creating new video texture provider")?;
        let pipeline = TextureSourceStage::new(context, &mut texture)
            .context("Creating texture source stage")?;

        Ok(Self { texture, pipeline })
    }
}

struct VideoTexture {
    context: ffmpeg::format::context::Input,
    decoder: ffmpeg::decoder::Video,
    converter: ffmpeg::software::scaling::context::Context,
    stream_index: usize,
}

impl VideoTexture {
    pub fn new(path: &str) -> anyhow::Result<Self> {
        let context = ffmpeg::format::input(&path)?;
        ffmpeg::format::context::input::dump(&context, 0, Some(path));
        let stream = context.streams().best(ffmpeg::media::Type::Video).unwrap();
        let video_stream_index = stream.index();

        let context_decoder =
            ffmpeg::codec::context::Context::from_parameters(stream.parameters())?;
        let decoder = context_decoder.decoder().video()?;

        let converter = decoder.converter(ffmpeg::format::Pixel::RGBA)?;

        Ok(Self {
            decoder,
            context,
            converter,
            stream_index: video_stream_index,
        })
    }
}

impl TextureProvider for VideoTexture {
    fn width(&self) -> u32 {
        self.decoder.width()
    }

    fn height(&self) -> u32 {
        self.decoder.height()
    }

    fn data(&mut self) -> anyhow::Result<Option<Cow<[u8]>>> {
        profiling::scope!("VideoTexture::data");
        for (stream, packet) in self.context.packets() {
            if self.stream_index == stream.index() {
                self.decoder.send_packet(&packet)?;
                let mut decoded = ffmpeg::frame::Video::empty();
                self.decoder.receive_frame(&mut decoded)?;
                let mut frame = ffmpeg::frame::Video::empty();
                self.converter.run(&decoded, &mut frame)?;

                return Ok(Some(Cow::Owned(frame.data(0).to_vec())));
            }
        }
        self.context.seek(0, 0..0)?;
        Ok(None)
    }
}
