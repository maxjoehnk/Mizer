use anyhow::{anyhow, Context};
use ffmpeg_the_third as ffmpeg;
use mizer_media::documents::MediaId;
use mizer_media::MediaServer;
use serde::{Deserialize, Serialize};
use std::borrow::Cow;
use std::path::PathBuf;

use mizer_node::*;
use mizer_wgpu::{
    TextureHandle, TextureProvider, TextureRegistry, TextureSourceStage, WgpuContext, WgpuPipeline,
};

const OUTPUT_PORT: &str = "Output";

const FILE_SETTING: &str = "File";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct VideoFileNode {
    pub file: String,
}

impl ConfigurableNode for VideoFileNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(media FILE_SETTING, &self.file, vec![MediaContentType::Video, MediaContentType::Image]),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(media setting, FILE_SETTING, self.file);

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
        let texture_registry = context.inject::<TextureRegistry>().unwrap();
        let video_pipeline = context.inject::<WgpuPipeline>().unwrap();
        let media_server = context.inject::<MediaServer>().unwrap();

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
            state.texture = VideoTexture::new(media_file.file_path)
                .context("Creating new video texture provider")?;
        }
        state.texture.clock_state = context.clock_state();
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
        None
    }
}

pub struct VideoFileState {
    texture: VideoTexture,
    pipeline: TextureSourceStage,
    transfer_texture: TextureHandle,
}

impl VideoFileState {
    fn new(
        context: &WgpuContext,
        registry: &TextureRegistry,
        path: PathBuf,
    ) -> anyhow::Result<Self> {
        log::debug!("Loading video file: {path:?}");
        let mut texture = VideoTexture::new(path).context("Creating new video texture provider")?;
        let pipeline = TextureSourceStage::new(context, &mut texture)
            .context("Creating texture source stage")?;
        let transfer_texture = registry.register(context, texture.width(), texture.height(), None);

        Ok(Self {
            texture,
            pipeline,
            transfer_texture,
        })
    }
}

struct VideoTexture {
    context: ffmpeg::format::context::Input,
    decoder: ffmpeg::decoder::Video,
    converter: ffmpeg::software::scaling::context::Context,
    stream_index: usize,
    clock_state: ClockState,
    file_path: PathBuf,
}

impl VideoTexture {
    pub fn new(path: PathBuf) -> anyhow::Result<Self> {
        let context = ffmpeg::format::input(&path)?;
        ffmpeg::format::context::input::dump(&context, 0, path.to_str());
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
            clock_state: ClockState::Playing,
            file_path: path,
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
        match self.clock_state {
            ClockState::Stopped => {
                self.context.seek(0, 0..0)?;
            }
            ClockState::Paused => {
                return Ok(None);
            }
            _ => {}
        }
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
