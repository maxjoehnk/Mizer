use std::path::PathBuf;

use anyhow::{anyhow, Context};
use serde::{Deserialize, Serialize};

use mizer_media::documents::MediaId;
use mizer_media::MediaServer;
use mizer_node::*;
use mizer_wgpu::{
    TextureHandle, TextureProvider, TextureRegistry, TextureSourceStage, WgpuContext, WgpuPipeline,
};

use super::decoder::*;
use super::texture::*;

const PLAYBACK_INPUT: &str = "Playback";
const PLAYBACK_OUTPUT: &str = "Playback";
const OUTPUT_PORT: &str = "Output";
const PLAYBACK_SPEED_INPUT: &str = "Playback Speed";

const FILE_SETTING: &str = "File";
const PLAYBACK_SPEED_SETTING: &str = "Playback Speed";
const SYNC_TRANSPORT_STATE_SETTING: &str = "Sync to Transport State";
const RENDER_WHEN_STOPPED: &str = "Render when Stopped";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct VideoFileNode {
    pub file: String,
    #[serde(default = "default_playback_speed")]
    pub playback_speed: f64,
    #[serde(default)]
    pub sync_to_transport_state: bool,
    #[serde(default = "default_render_when_stopped")]
    pub render_when_stopped: bool,
}

impl Default for VideoFileNode {
    fn default() -> Self {
        Self {
            file: Default::default(),
            playback_speed: default_playback_speed(),
            sync_to_transport_state: Default::default(),
            render_when_stopped: default_render_when_stopped(),
        }
    }
}

fn default_render_when_stopped() -> bool {
    true
}

fn default_playback_speed() -> f64 {
    1.0
}

impl ConfigurableNode for VideoFileNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(media FILE_SETTING, &self.file, vec![MediaContentType::Video]),
            setting!(PLAYBACK_SPEED_SETTING, self.playback_speed),
            setting!(SYNC_TRANSPORT_STATE_SETTING, self.sync_to_transport_state),
            setting!(RENDER_WHEN_STOPPED, self.render_when_stopped),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(media setting, FILE_SETTING, self.file);
        update!(float setting, PLAYBACK_SPEED_SETTING, self.playback_speed);
        update!(bool setting, SYNC_TRANSPORT_STATE_SETTING, self.sync_to_transport_state);
        update!(bool setting, RENDER_WHEN_STOPPED, self.render_when_stopped);

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
            input_port!(PLAYBACK_SPEED_INPUT, PortType::Single),
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

        if !node_state.playing && !self.render_when_stopped {
            return Ok(());
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
        let clock_state = if self.sync_to_transport_state {
            context.clock_state()
        } else if node_state.playing {
            ClockState::Playing
        } else {
            ClockState::Stopped
        };
        if clock_state != state.texture.clock_state {
            state.set_clock_state(clock_state)?;
        }
        state.texture.playback_speed = context
            .read_port(PLAYBACK_SPEED_INPUT)
            .unwrap_or(self.playback_speed);
        state.receive_frames();
        state.texture.set_fps(context.fps());
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
            });

            if let Some(state) = state.as_ref() {
                state.texture.debug_ui(ui);
            }
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
        let mut decode_handle = VideoDecodeThread::spawn()?;
        let metadata = decode_handle.decode(path.clone())?;
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
        let metadata = self.decode_handle.decode(file_path.clone())?;
        self.texture = VideoTexture::new(file_path, metadata)
            .context("Creating new video texture provider")?;

        Ok(())
    }

    fn receive_frames(&mut self) {
        self.texture.receive_frames(&mut self.decode_handle);
    }

    fn set_clock_state(&mut self, clock_state: ClockState) -> anyhow::Result<()> {
        if clock_state != self.texture.clock_state {
            self.texture.set_clock_state(clock_state);
            if clock_state == ClockState::Stopped {
                self.decode_handle.seek(0)?;
            }
        }

        Ok(())
    }
}
