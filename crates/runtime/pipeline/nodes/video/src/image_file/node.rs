use std::path::PathBuf;

use anyhow::{anyhow, Context};
use serde::{Deserialize, Serialize};

use mizer_media::documents::MediaId;
use mizer_media::MediaServer;
use mizer_node::*;
use mizer_wgpu::{
    TextureHandle, TextureProvider, TextureRegistry, TextureSourceStage, WgpuContext, WgpuPipeline,
};

use super::texture::*;

const OUTPUT_PORT: &str = "Output";

const FILE_SETTING: &str = "File";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct ImageFileNode {
    pub file: String,
}

impl ConfigurableNode for ImageFileNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(media FILE_SETTING, &self.file, vec![MediaContentType::Image])]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(media setting, FILE_SETTING, self.file);

        update_fallback!(setting)
    }
}

impl PipelineNode for ImageFileNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Image File".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(OUTPUT_PORT, PortType::Texture)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ImageFile
    }
}

impl ProcessingNode for ImageFileNode {
    type State = Option<ImageFileState>;

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
                ImageFileState::new(wgpu_context, texture_registry, media_file.file_path.clone())
                    .context("Creating image file state")?,
            );
        }

        let state = state.as_mut().unwrap();
        if state.texture.file_path != media_file.file_path {
            state
                .change_file(media_file.file_path)
                .context("Changing image file")?;
        }
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

    fn debug_ui<'a>(&self, ui: &mut impl DebugUiDrawHandle<'a>, state: &Self::State) {
        ui.collapsing_header("Settings", |ui| {
            ui.columns(2, |columns| {
                columns[0].label("File");
                columns[1].label(&self.file);
            });
        });

        ui.collapsing_header("State", |ui| {
            if let Some(state) = state.as_ref() {
                state.texture.debug_ui(ui);
            }
        });
    }
}

pub struct ImageFileState {
    texture: ImageTexture,
    pipeline: TextureSourceStage,
    transfer_texture: TextureHandle,
}

impl ImageFileState {
    fn new(
        context: &WgpuContext,
        registry: &TextureRegistry,
        path: PathBuf,
    ) -> anyhow::Result<Self> {
        log::debug!("Loading video file: {path:?}");
        let mut texture = ImageTexture::new(path).context("Creating new image texture provider")?;
        let pipeline = TextureSourceStage::new(context, &mut texture)
            .context("Creating texture source stage")?;
        let transfer_texture = registry.register(context, texture.width(), texture.height(), None);

        Ok(Self {
            texture,
            pipeline,
            transfer_texture,
        })
    }

    fn change_file(&mut self, file_path: PathBuf) -> anyhow::Result<()> {
        self.texture =
            ImageTexture::new(file_path).context("Creating new image texture provider")?;

        Ok(())
    }
}
