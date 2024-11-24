use std::borrow::Cow;

use anyhow::{anyhow, Context};
use ringbuffer::{AllocRingBuffer, RingBuffer};
use screenshots::Monitor;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_video_nodes::background_thread_decoder::*;
use mizer_wgpu::wgpu::TextureFormat;
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
        let primary_screen = Monitor::all()
            .unwrap_or_default()
            .into_iter()
            .find(|screen| screen.is_primary())
            .map(|screen| screen.id())
            .unwrap_or_default();

        Self {
            screen_id: primary_screen,
        }
    }
}

impl ConfigurableNode for ScreenCaptureNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        let screens = match Monitor::all() {
            Ok(screens) => screens,
            Err(err) => {
                tracing::error!(error = ?err, "Failed to list screens");
                vec![]
            }
        };

        let screens = screens
            .into_iter()
            .map(|screen| IdVariant {
                value: screen.id(),
                label: format!(
                    "Screen {} ({}x{})",
                    screen.name(),
                    screen.width(),
                    screen.height()
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
            node_type_name: "Screen Capture".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(OUTPUT_PORT, PortType::Texture)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ScreenCapture
    }
}

impl ProcessingNode for ScreenCaptureNode {
    type State = Option<ScreenCaptureState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let Some(wgpu_context) = context.try_inject::<WgpuContext>() else {
            return Ok(());
        };
        let Some(wgpu_pipeline) = context.try_inject::<WgpuPipeline>() else {
            return Ok(());
        };
        let Some(texture_registry) = context.try_inject::<TextureRegistry>() else {
            return Ok(());
        };

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
            if state.screen.id() != self.screen_id {
                if let Some(screen) = self.get_screen()? {
                    state.change_screen(screen)?;
                }
            }
            state.receive_frames();
            if !state.texture.is_ready() {
                return Ok(());
            }
            let texture = texture_registry
                .get(&state.transfer_texture)
                .ok_or_else(|| anyhow!("Texture not found in registry"))?;
            let stage = state
                .pipeline
                .render(wgpu_context, &texture, &mut state.texture)
                .context("Rendering texture source pipeline")?;
            wgpu_pipeline.add_stage(stage);
            context.write_port(OUTPUT_PORT, state.transfer_texture);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl ScreenCaptureNode {
    fn get_screen(&self) -> anyhow::Result<Option<Monitor>> {
        if let Some(screen) = Monitor::all()
            .context("Listing screens")?
            .into_iter()
            .find(|screen| screen.id() == self.screen_id)
        {
            Ok(Some(screen))
        } else {
            Ok(None)
        }
    }
}

pub struct ScreenCaptureState {
    screen: Monitor,
    texture: BackgroundDecoderTexture,
    pipeline: TextureSourceStage,
    transfer_texture: TextureHandle,
    decode_handle: BackgroundDecoderThreadHandle<ScreenCaptureDecoder>,
}

impl ScreenCaptureState {
    fn new(
        context: &WgpuContext,
        registry: &TextureRegistry,
        screen: Monitor,
    ) -> anyhow::Result<Self> {
        let mut decode_handle = BackgroundDecoderThread::spawn()?;
        let metadata = decode_handle.decode(screen.clone())?;
        let mut texture = BackgroundDecoderTexture::new(metadata);
        let pipeline = TextureSourceStage::new(context, &mut texture)
            .context("Creating texture source stage")?;
        let transfer_texture = registry.register(context, texture.width(), texture.height(), None);

        Ok(Self {
            screen,
            texture,
            pipeline,
            transfer_texture,
            decode_handle,
        })
    }

    fn receive_frames(&mut self) {
        self.texture.receive_frames(&mut self.decode_handle);
    }

    fn change_screen(&mut self, screen: Monitor) -> anyhow::Result<()> {
        self.screen = screen.clone();
        let metadata = self.decode_handle.decode(screen)?;
        self.texture = BackgroundDecoderTexture::new(metadata);

        Ok(())
    }
}

#[derive(Clone, Copy)]
struct CaptureArea {
    x: i32,
    y: i32,
    width: u32,
    height: u32,
}

struct ScreenCaptureDecoder {
    screen: Monitor,
    area: Option<CaptureArea>,
}

impl VideoDecoder for ScreenCaptureDecoder {
    type CreateDecoder = Monitor;
    type Commands = ();

    fn new(args: Self::CreateDecoder) -> anyhow::Result<Self>
    where
        Self: Sized,
    {
        Ok(Self {
            screen: args,
            area: None,
        })
    }

    fn handle(&mut self, _command: Self::Commands) -> anyhow::Result<()> {
        Ok(())
    }

    fn decode(&mut self) -> anyhow::Result<Option<Vec<u8>>> {
        let image = if let Some(area) = self.area {
            // TODO: calculate monitor area, take screenshots of all screens and combine into single picture
            // self.screen
            //     .capture_area(area.x, area.y, area.width, area.height)?
            anyhow::bail!("Capture area not implemented")
        } else {
            self.screen.capture_image()?
        };
        let data = image.into_flat_samples().samples;

        Ok(Some(data))
    }

    fn metadata(&self) -> anyhow::Result<VideoMetadata> {
        Ok(VideoMetadata {
            width: self.screen.width(),
            height: self.screen.height(),
            fps: 60.,
            frames: 0,
        })
    }
}
