use std::borrow::Cow;

use anyhow::{anyhow, Context};
use serde::{Deserialize, Serialize};

use mizer_devices::{DeviceManager, DeviceRef};
use mizer_node::*;
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

fn webcam_to_node_setting(value: WebcamSettingValue, setting: &str) -> NodeSetting {
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
            name: "Webcam".into(),
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
            let webcam = webcam_ref.open().context("Opening webcam")?;
            state.texture = WebcamTexture::new(webcam);
            state.webcam_ref = webcam_ref.value().clone();
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
        None
    }
}

pub struct WebcamState {
    webcam_ref: WebcamRef,
    texture: WebcamTexture,
    pipeline: TextureSourceStage,
    transfer_texture: TextureHandle,
}

impl WebcamState {
    fn new(
        context: &WgpuContext,
        registry: &TextureRegistry,
        webcam_ref: WebcamRef,
    ) -> anyhow::Result<Self> {
        let webcam = webcam_ref.open().context("Opening webcam")?;
        let mut texture = WebcamTexture::new(webcam);
        let pipeline = TextureSourceStage::new(context, &mut texture)
            .context("Creating texture source stage")?;
        let transfer_texture = registry.register(context, texture.width(), texture.height(), None);

        Ok(Self {
            webcam_ref,
            texture,
            pipeline,
            transfer_texture,
        })
    }
}

struct WebcamTexture {
    webcam: Webcam,
}

impl WebcamTexture {
    pub fn new(webcam: Webcam) -> Self {
        Self { webcam }
    }
}

impl TextureProvider for WebcamTexture {
    fn width(&self) -> u32 {
        self.webcam.width()
    }

    fn height(&self) -> u32 {
        self.webcam.height()
    }

    fn data(&mut self) -> anyhow::Result<Option<Cow<[u8]>>> {
        profiling::scope!("WebcamTexture::data");
        let frame = self.webcam.frame()?;
        let data = frame.data()?;

        Ok(Some(Cow::Owned(data)))
    }
}
