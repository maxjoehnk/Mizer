use std::borrow::Cow;

use anyhow::{anyhow, Context};
use ringbuffer::{AllocRingBuffer, RingBuffer};
use serde::{Deserialize, Serialize};

use mizer_devices::{DeviceManager, DeviceRef};
use mizer_node::*;
use mizer_video_nodes::background_thread_decoder::*;
use mizer_webcams::{Webcam, WebcamRef, WebcamSetting, WebcamSettingValue};
use mizer_wgpu::{
    TextureHandle, TextureProvider, TextureRegistry, TextureSourceStage, WgpuContext, WgpuPipeline,
};

const OUTPUT_PORT: &str = "Output";

// TODO: Add setting to select resolution and framerate
const DEVICE_SETTING: &str = "Webcam";
const BRIGHTNESS_SETTING: &str = "Brightness";
const CONTRAST_SETTING: &str = "Contrast";
const HUE_SETTING: &str = "Hue";
const SATURATION_SETTING: &str = "Saturation";
const SHARPNESS_SETTING: &str = "Sharpness";
const GAMMA_SETTING: &str = "Gamma";
const WHITE_BALANCE_SETTING: &str = "White Balance";
const BACKLIGHT_COMPENSATION_SETTING: &str = "Backlight Compensation";
const GAIN_SETTING: &str = "Gain";
const PAN_SETTING: &str = "Pan";
const TILT_SETTING: &str = "Tilt";
const ZOOM_SETTING: &str = "Zoom";
const EXPORURE_SETTING: &str = "Exposure";
const IRIS_SETTING: &str = "Iris";
const FOCUS_SETTING: &str = "Focus";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct WebcamNode {
    pub device_id: String,
}

impl ConfigurableNode for WebcamNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let device_manager = injector.get::<DeviceManager>().unwrap();
        let devices = device_manager
            .current_devices()
            .into_iter()
            .flat_map(|device| {
                if let DeviceRef::Webcam(webcam) = device {
                    Some(SelectVariant::Item {
                        value: webcam.id.into(),
                        label: webcam.name.into(),
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

// TODO: Implement webcam controls
fn collect_webcam_settings(webcam_ref: Option<&WebcamRef>) -> Vec<NodeSetting> {
    let mut settings = Vec::new();

    if let Some(webcam_ref) = webcam_ref {
        match webcam_ref.open() {
            Ok(webcam) => {
                for setting in webcam.settings().unwrap_or_default() {
                    match setting {
                        WebcamSetting::Brightness(value) => {
                            settings.push(webcam_to_node_setting(value, BRIGHTNESS_SETTING))
                        }
                        WebcamSetting::Contrast(value) => {
                            settings.push(webcam_to_node_setting(value, CONTRAST_SETTING))
                        }
                        WebcamSetting::Hue(value) => {
                            settings.push(webcam_to_node_setting(value, HUE_SETTING))
                        }
                        WebcamSetting::Saturation(value) => {
                            settings.push(webcam_to_node_setting(value, SATURATION_SETTING))
                        }
                        WebcamSetting::Sharpness(value) => {
                            settings.push(webcam_to_node_setting(value, SHARPNESS_SETTING))
                        }
                        WebcamSetting::Gamma(value) => {
                            settings.push(webcam_to_node_setting(value, GAMMA_SETTING))
                        }
                        WebcamSetting::WhiteBalance(value) => {
                            settings.push(webcam_to_node_setting(value, WHITE_BALANCE_SETTING))
                        }
                        WebcamSetting::BacklightComp(value) => settings.push(
                            webcam_to_node_setting(value, BACKLIGHT_COMPENSATION_SETTING),
                        ),
                        WebcamSetting::Gain(value) => {
                            settings.push(webcam_to_node_setting(value, GAIN_SETTING))
                        }
                        WebcamSetting::Pan(value) => {
                            settings.push(webcam_to_node_setting(value, PAN_SETTING))
                        }
                        WebcamSetting::Tilt(value) => {
                            settings.push(webcam_to_node_setting(value, TILT_SETTING))
                        }
                        WebcamSetting::Zoom(value) => {
                            settings.push(webcam_to_node_setting(value, ZOOM_SETTING))
                        }
                        WebcamSetting::Exposure(value) => {
                            settings.push(webcam_to_node_setting(value, EXPORURE_SETTING))
                        }
                        WebcamSetting::Iris(value) => {
                            settings.push(webcam_to_node_setting(value, IRIS_SETTING))
                        }
                        WebcamSetting::Focus(value) => {
                            settings.push(webcam_to_node_setting(value, FOCUS_SETTING))
                        }
                    }
                }
            }
            Err(err) => log::error!("Failed to open webcam to read settings: {err:?}"),
        }
    }

    settings
}

fn webcam_to_node_setting(value: WebcamSettingValue, setting: &'static str) -> NodeSetting {
    match value {
        WebcamSettingValue::Float {
            value, min, max, ..
        } => {
            let mut setting = setting!(setting, value);
            if let Some(min) = min {
                setting = setting.min(min);
            }
            if let Some(max) = max {
                setting = setting.max(max);
            }

            setting
        }
        WebcamSettingValue::Int {
            value, min, max, ..
        } => {
            let mut setting = setting!(setting, value);
            if let Some(min) = min {
                setting = setting.min(min);
            }
            if let Some(max) = max {
                setting = setting.max(max);
            }

            setting
        }
        WebcamSettingValue::Bool { value } => setting!(setting, value),
        WebcamSettingValue::Text { value } => setting!(setting, value),
    }
}

impl PipelineNode for WebcamNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Webcam".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(OUTPUT_PORT, PortType::Texture)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Webcam
    }
}

impl ProcessingNode for WebcamNode {
    type State = Option<WebcamState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let texture_registry = context.inject::<TextureRegistry>().unwrap();
        let video_pipeline = context.inject::<WgpuPipeline>().unwrap();
        let device_manager = context.inject::<DeviceManager>().unwrap();

        if self.device_id.is_empty() {
            return Ok(());
        }

        let webcam_ref = device_manager.get_webcam(&self.device_id);
        if webcam_ref.is_none() {
            return Ok(());
        }

        let webcam_ref = webcam_ref.unwrap();

        if state.is_none() {
            *state = Some(
                WebcamState::new(wgpu_context, texture_registry, webcam_ref.value().clone())
                    .context("Creating video file state")?,
            );
        }

        let state = state.as_mut().unwrap();
        if &state.webcam_ref != webcam_ref.value() {
            state
                .change_webcam(webcam_ref.clone())
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

pub struct WebcamState {
    webcam_ref: WebcamRef,
    texture: WebcamTexture,
    pipeline: TextureSourceStage,
    transfer_texture: TextureHandle,
    decode_handle: BackgroundDecoderThreadHandle<WebcamDecoder>,
}

impl WebcamState {
    fn new(
        context: &WgpuContext,
        registry: &TextureRegistry,
        webcam_ref: WebcamRef,
    ) -> anyhow::Result<Self> {
        let mut decode_handle = BackgroundDecoderThread::spawn()?;
        let metadata = decode_handle.decode(webcam_ref.clone())?;
        let mut texture = WebcamTexture::new(metadata);
        let pipeline = TextureSourceStage::new(context, &mut texture)
            .context("Creating texture source stage")?;
        let transfer_texture = registry.register(context, texture.width(), texture.height(), None);

        Ok(Self {
            webcam_ref,
            texture,
            pipeline,
            transfer_texture,
            decode_handle,
        })
    }

    fn receive_frames(&mut self) {
        self.texture.receive_frames(&mut self.decode_handle);
    }

    fn change_webcam(&mut self, webcam_ref: WebcamRef) -> anyhow::Result<()> {
        let metadata = self.decode_handle.decode(webcam_ref)?;
        self.texture = WebcamTexture::new(metadata);

        Ok(())
    }
}

struct WebcamTexture {
    buffer: AllocRingBuffer<Vec<u8>>,
    metadata: VideoMetadata,
}

impl WebcamTexture {
    pub fn new(metadata: VideoMetadata) -> Self {
        Self {
            buffer: AllocRingBuffer::new(10),
            metadata,
        }
    }

    pub fn receive_frames(&mut self, handle: &mut BackgroundDecoderThreadHandle<WebcamDecoder>) {
        profiling::scope!("WebcamTexture::receive_frames");
        while let Some(VideoThreadEvent::DecodedFrame(frame)) = handle.try_recv() {
            self.buffer.push(frame);
        }
    }
}

impl TextureProvider for WebcamTexture {
    fn width(&self) -> u32 {
        self.metadata.width
    }

    fn height(&self) -> u32 {
        self.metadata.height
    }

    fn data(&mut self) -> anyhow::Result<Option<Cow<[u8]>>> {
        profiling::scope!("WebcamTexture::data");
        if self.buffer.is_empty() {
            return Ok(None);
        }

        Ok(self
            .buffer
            .back()
            .map(|data| Cow::Borrowed(data.as_slice())))
    }
}

struct WebcamDecoder {
    webcam: Webcam,
}

impl VideoDecoder for WebcamDecoder {
    type CreateDecoder = WebcamRef;
    type Commands = ();

    fn new(webcam_ref: Self::CreateDecoder) -> anyhow::Result<Self>
    where
        Self: Sized,
    {
        let webcam = webcam_ref.open().context("Opening webcam")?;

        Ok(Self { webcam })
    }

    fn handle(&mut self, command: Self::Commands) -> anyhow::Result<()> {
        Ok(())
    }

    fn decode(&mut self) -> anyhow::Result<Option<Vec<u8>>> {
        let frame = self.webcam.frame()?;
        let data = frame.data()?;

        Ok(Some(data.to_vec()))
    }

    fn metadata(&self) -> anyhow::Result<VideoMetadata> {
        Ok(VideoMetadata {
            width: self.webcam.width(),
            height: self.webcam.height(),
            fps: self.webcam.frame_rate() as f64,
            frames: 0,
        })
    }
}
