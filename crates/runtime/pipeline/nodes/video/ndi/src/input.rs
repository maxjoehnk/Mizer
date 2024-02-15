use std::borrow::Cow;

use anyhow::{anyhow, Context};
use ringbuffer::{AllocRingBuffer, RingBuffer};
use serde::{Deserialize, Serialize};

use mizer_devices::{DeviceManager, DeviceRef};
use mizer_ndi::{NdiSource, NdiSourceRef};
use mizer_node::*;
use mizer_video_nodes::background_thread_decoder::*;
use mizer_wgpu::wgpu::TextureFormat;
use mizer_wgpu::{
    TextureHandle, TextureProvider, TextureRegistry, TextureSourceStage, WgpuContext, WgpuPipeline,
};

const OUTPUT_PORT: &str = "Output";

const DEVICE_SETTING: &str = "Source";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct NdiInputNode {
    pub device_id: String,
}

impl ConfigurableNode for NdiInputNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let device_manager = injector.get::<DeviceManager>().unwrap();
        let devices = device_manager
            .current_devices()
            .into_iter()
            .flat_map(|device| {
                if let DeviceRef::NdiSource(source) = device {
                    Some(SelectVariant::Item {
                        value: source.id.into(),
                        label: source.name.into(),
                    })
                } else {
                    None
                }
            })
            .collect();

        vec![setting!(
            select DEVICE_SETTING,
            &self.device_id,
            devices
        )]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, DEVICE_SETTING, self.device_id);

        update_fallback!(setting)
    }
}

impl PipelineNode for NdiInputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "NDI Input".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(OUTPUT_PORT, PortType::Texture)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::NdiInput
    }
}

impl ProcessingNode for NdiInputNode {
    type State = Option<NdiInputState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let texture_registry = context.inject::<TextureRegistry>().unwrap();
        let video_pipeline = context.inject::<WgpuPipeline>().unwrap();
        let device_manager = context.inject::<DeviceManager>().unwrap();

        if self.device_id.is_empty() {
            return Ok(());
        }

        let ndi_source_ref = device_manager.get_ndi_source(&self.device_id);
        if ndi_source_ref.is_none() {
            return Ok(());
        }

        let ndi_source_ref = ndi_source_ref.unwrap();

        if state.is_none() {
            *state = Some(
                NdiInputState::new(
                    wgpu_context,
                    texture_registry,
                    ndi_source_ref.value().clone(),
                )
                .context("Creating ndi input state")?,
            );
        }

        let state = state.as_mut().unwrap();
        if &state.ndi_source_ref != ndi_source_ref.value() {
            state
                .change_source(ndi_source_ref.clone())
                .context("Changing webcam")?;
        }
        state.receive_frames();
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

pub struct NdiInputState {
    ndi_source_ref: NdiSourceRef,
    texture: NdiSourceTexture,
    pipeline: TextureSourceStage,
    transfer_texture: TextureHandle,
    decode_handle: BackgroundDecoderThreadHandle<NdiSourceDecoder>,
}

impl NdiInputState {
    fn new(
        context: &WgpuContext,
        registry: &TextureRegistry,
        ndi_source_ref: NdiSourceRef,
    ) -> anyhow::Result<Self> {
        let mut decode_handle = BackgroundDecoderThread::spawn()?;
        let metadata = decode_handle.decode(ndi_source_ref.clone())?;
        let mut texture = NdiSourceTexture::new(metadata);
        let pipeline = TextureSourceStage::new(context, &mut texture)
            .context("Creating texture source stage")?;
        let transfer_texture = registry.register(context, texture.width(), texture.height(), None);

        Ok(Self {
            ndi_source_ref,
            texture,
            pipeline,
            transfer_texture,
            decode_handle,
        })
    }

    fn receive_frames(&mut self) {
        self.texture.receive_frames(&mut self.decode_handle);
    }

    fn change_source(&mut self, ndi_source_ref: NdiSourceRef) -> anyhow::Result<()> {
        let metadata = self.decode_handle.decode(ndi_source_ref)?;
        self.texture = NdiSourceTexture::new(metadata);

        Ok(())
    }
}

struct NdiSourceTexture {
    buffer: AllocRingBuffer<Vec<u8>>,
    metadata: VideoMetadata,
}

impl NdiSourceTexture {
    pub fn new(metadata: VideoMetadata) -> Self {
        Self {
            buffer: AllocRingBuffer::new(10),
            metadata,
        }
    }

    pub fn receive_frames(&mut self, handle: &mut BackgroundDecoderThreadHandle<NdiSourceDecoder>) {
        profiling::scope!("NdiSourceTexture::receive_frames");
        while let Some(VideoThreadEvent::DecodedFrame(frame)) = handle.try_recv() {
            self.buffer.push(frame);
        }
    }
}

impl TextureProvider for NdiSourceTexture {
    fn texture_format(&self) -> TextureFormat {
        TextureFormat::Rgba8UnormSrgb
    }

    fn width(&self) -> u32 {
        self.metadata.width
    }

    fn height(&self) -> u32 {
        self.metadata.height
    }

    fn data(&mut self) -> anyhow::Result<Option<Cow<[u8]>>> {
        profiling::scope!("NdiSourceTexture::data");
        if self.buffer.is_empty() {
            return Ok(None);
        }

        Ok(self
            .buffer
            .back()
            .map(|data| Cow::Borrowed(data.as_slice())))
    }
}

struct NdiSourceDecoder {
    source: NdiSource,
}

impl VideoDecoder for NdiSourceDecoder {
    type CreateDecoder = NdiSourceRef;
    type Commands = ();

    fn new(ndi_source_ref: Self::CreateDecoder) -> anyhow::Result<Self>
    where
        Self: Sized,
    {
        let source = ndi_source_ref.open().context("Opening ndi source")?;

        Ok(Self { source })
    }

    fn handle(&mut self, _command: Self::Commands) -> anyhow::Result<()> {
        Ok(())
    }

    fn decode(&mut self) -> anyhow::Result<Option<Vec<u8>>> {
        let frame = self.source.frame()?;
        let data = frame.data()?;

        Ok(Some(data))
    }

    fn metadata(&self) -> anyhow::Result<VideoMetadata> {
        Ok(VideoMetadata {
            width: self.source.width(),
            height: self.source.height(),
            fps: self.source.frame_rate() as f64,
            frames: 0,
        })
    }
}
