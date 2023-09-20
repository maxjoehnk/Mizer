use std::borrow::Cow;

use anyhow::{anyhow, Context};
use screenshots::Screen;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{
    TextureHandle, TextureProvider, TextureRegistry, TextureSourceStage, WgpuContext, WgpuPipeline,
};

const OUTPUT_PORT: &str = "Output";

const SCREEN_SETTING: &str = "Screen";

// TODO: configure screen area
#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct ScreenCaptureNode {
    screen_id: u32,
}

impl Default for ScreenCaptureNode {
    fn default() -> Self {
        let primary_screen = Screen::all()
            .unwrap_or_default()
            .into_iter()
            .find(|screen| screen.display_info.is_primary)
            .map(|screen| screen.display_info.id)
            .unwrap_or_default();

        Self {
            screen_id: primary_screen,
        }
    }
}

impl ConfigurableNode for ScreenCaptureNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        let screens = match Screen::all() {
            Ok(screens) => screens,
            Err(err) => {
                tracing::error!(error = ?err, "Failed to list screens");
                vec![]
            }
        };

        let screens = screens
            .into_iter()
            .map(|screen| IdVariant {
                value: screen.display_info.id,
                label: format!(
                    "Screen {} ({}x{})",
                    screen.display_info.id, screen.display_info.width, screen.display_info.height
                ),
            })
            .collect();

        vec![setting!(id SCREEN_SETTING, self.screen_id, screens)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(id setting, SCREEN_SETTING, self.screen_id);

        update_fallback!(setting)
    }
}

impl PipelineNode for ScreenCaptureNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Screen Capture".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(OUTPUT_PORT, PortType::Texture)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ScreenCapture
    }
}

impl ProcessingNode for ScreenCaptureNode {
    type State = Option<ScreenCaptureState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let texture_registry = context.inject::<TextureRegistry>().unwrap();
        let video_pipeline = context.inject::<WgpuPipeline>().unwrap();

        if state.is_none() {
            let screen = self.get_screen()?;
            if let Some(screen) = screen {
                *state = Some(ScreenCaptureState::new(
                    wgpu_context,
                    texture_registry,
                    screen,
                )?);
            }
        }

        if let Some(state) = state.as_mut() {
            if state.texture.screen.display_info.id != self.screen_id {
                if let Some(screen) = self.get_screen()? {
                    state.texture.screen = screen;
                }
            }
            let texture = texture_registry
                .get(&state.transfer_texture)
                .ok_or_else(|| anyhow!("Texture not found in registry"))?;
            let stage = state
                .pipeline
                .render(wgpu_context, &texture, &mut state.texture)
                .context("Rendering texture source pipeline")?;
            video_pipeline.add_stage(stage);
            context.write_port(OUTPUT_PORT, state.transfer_texture);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl ScreenCaptureNode {
    fn get_screen(&self) -> anyhow::Result<Option<Screen>> {
        if let Some(screen) = Screen::all()
            .context("Listing screens")?
            .into_iter()
            .find(|screen| screen.display_info.id == self.screen_id)
        {
            Ok(Some(screen))
        } else {
            Ok(None)
        }
    }
}

pub struct ScreenCaptureState {
    texture: ScreenCaptureTexture,
    pipeline: TextureSourceStage,
    transfer_texture: TextureHandle,
}

impl ScreenCaptureState {
    fn new(
        context: &WgpuContext,
        registry: &TextureRegistry,
        screen: Screen,
    ) -> anyhow::Result<Self> {
        let mut texture = ScreenCaptureTexture::new(screen);
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

struct ScreenCaptureTexture {
    screen: Screen,
    area: Option<CaptureArea>,
}

#[derive(Clone, Copy)]
struct CaptureArea {
    x: i32,
    y: i32,
    width: u32,
    height: u32,
}

impl ScreenCaptureTexture {
    pub fn new(screen: Screen) -> Self {
        Self { screen, area: None }
    }
}

impl TextureProvider for ScreenCaptureTexture {
    fn width(&self) -> u32 {
        self.screen.display_info.width
    }

    fn height(&self) -> u32 {
        self.screen.display_info.height
    }

    fn data(&mut self) -> anyhow::Result<Option<Cow<[u8]>>> {
        profiling::scope!("ScreenCaptureTexture::data");
        let image = if let Some(area) = self.area {
            self.screen
                .capture_area(area.x, area.y, area.width, area.height)?
        } else {
            self.screen.capture()?
        };
        let data = image.into_flat_samples().samples;

        Ok(Some(Cow::Owned(data)))
    }
}
