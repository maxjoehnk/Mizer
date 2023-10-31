use std::sync::Arc;

use ndi::{FourCCVideoType, VideoData};
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{BufferHandle, TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

const INPUT_PORT: &str = "Input";

const NAME_SETTING: &str = "Name";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct NdiOutputNode {
    pub name: String,
}

impl Default for NdiOutputNode {
    fn default() -> Self {
        Self {
            name: "Mizer".to_string(),
        }
    }
}

pub struct NdiOutputState {
    buffer_handle: Arc<BufferHandle>,
    send: ndi::Send,
    name: String,
    frame: Option<VideoData>,
}

impl NdiOutputState {
    fn new(name: String, context: &WgpuContext, pipeline: &WgpuPipeline) -> anyhow::Result<Self> {
        let buffer_handle = pipeline.create_export_buffer(context, 1920, 1080);

        let send = ndi::SendBuilder::new().ndi_name(name.clone()).build()?;

        Ok(Self {
            buffer_handle,
            send,
            name,
            frame: None,
        })
    }

    fn change_name(&mut self, name: String) -> anyhow::Result<()> {
        if self.name == name {
            return Ok(());
        }
        tracing::debug!("Changing name to {name}");
        self.send = ndi::SendBuilder::new().ndi_name(name.clone()).build()?;
        self.name = name;

        Ok(())
    }

    fn queue_frame(&mut self, fps: f64, buffer: &mut [u8]) {
        profiling::scope!("NdiOutputState::queue_frame");
        tracing::trace!("sending frame via ndi");
        let video_data = {
            profiling::scope!("ndi::VideoData::from_buffer");
            VideoData::from_buffer(
                1920,
                1080,
                FourCCVideoType::BGRA,
                fps.floor() as i32,
                1,
                ndi::FrameFormatType::Progressive,
                0,
                0,
                None,
                buffer,
            )
        };
        {
            profiling::scope!("ndi::Send::send_video");
            self.send.send_video_async(&video_data);
        }
        // Keep frame in memory until next frame is sent as they will be processed in the background
        self.frame = Some(video_data);
    }
}

impl ConfigurableNode for NdiOutputNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(NAME_SETTING, &self.name)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(text setting, NAME_SETTING, self.name);

        update_fallback!(setting)
    }
}

impl PipelineNode for NdiOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "NDI Output".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(INPUT_PORT, PortType::Texture)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::NdiOutput
    }
}

impl ProcessingNode for NdiOutputNode {
    type State = Option<NdiOutputState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let wgpu_pipeline = context.inject::<WgpuPipeline>().unwrap();
        let texture_registry = context.inject::<TextureRegistry>().unwrap();
        if state.is_none() {
            *state = Some(NdiOutputState::new(
                self.name.clone(),
                wgpu_context,
                wgpu_pipeline,
            )?);
        }

        let state = state.as_mut().unwrap();
        state.change_name(self.name.clone())?;

        if let Some(texture_handle) = context.read_port::<_, TextureHandle>(INPUT_PORT) {
            tracing::trace!("got texture handle");
            if let Some(texture) = texture_registry.get_texture_ref(&texture_handle) {
                tracing::trace!("got texture");
                wgpu_pipeline.export_to_buffer(
                    wgpu_context,
                    &texture,
                    Arc::clone(&state.buffer_handle),
                );
            }
        }

        Ok(())
    }

    fn post_process(
        &self,
        context: &impl NodeContext,
        state: &mut Self::State,
    ) -> anyhow::Result<()> {
        let wgpu_pipeline = context.inject::<WgpuPipeline>().unwrap();
        let texture_registry = context.inject::<TextureRegistry>().unwrap();
        if let Some(state) = state.as_mut() {
            if let Some(texture_handle) = context.read_port::<_, TextureHandle>(INPUT_PORT) {
                if texture_registry.get_texture_ref(&texture_handle).is_some() {
                    let buffer_access = wgpu_pipeline.get_buffer(&state.buffer_handle);
                    if let Some(mut buffer_slice) = buffer_access.read_mut() {
                        state.queue_frame(context.fps(), &mut buffer_slice);
                    };
                }
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
