use anyhow::{anyhow, Context};
use serde::{Deserialize, Serialize};
use mizer_connections::ConnectionStorage;
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
const EXPOSURE_SETTING: &str = "Exposure";
const IRIS_SETTING: &str = "Iris";
const FOCUS_SETTING: &str = "Focus";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct WebcamNode {
    pub device_id: String,
}

impl ConfigurableNode for WebcamNode {
    fn settings(&self, injector: &ReadOnlyInjectionScope) -> Vec<NodeSetting> {
        let device_manager = injector.inject::<ConnectionStorage>();
        let devices = device_manager
            .query::<WebcamRef>()
            .into_iter()
            .map(|(id, name, webcam)| {
                SelectVariant::Item {
                    value: id.to_stable().to_string().into(),
                    label: name.cloned().unwrap_or_else(|| webcam.name().into()),
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
                            settings.push(webcam_to_node_setting(value, EXPOSURE_SETTING))
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
            Err(err) => tracing::error!("Failed to open webcam to read settings: {err:?}"),
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

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(OUTPUT_PORT, PortType::Texture)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Webcam
    }
}

impl ProcessingNode for WebcamNode {
    type State = Option<WebcamState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let Some(wgpu_context) = context.try_inject::<WgpuContext>() else {
            return Ok(());
        };
        let Some(texture_registry) = context.try_inject::<TextureRegistry>() else {
            return Ok(());
        };
        let Some(wgpu_pipeline) = context.try_inject::<WgpuPipeline>() else {
            return Ok(());
        };
        let connection_storage = context.inject::<ConnectionStorage>();

        if self.device_id.is_empty() {
            return Ok(());
        }

        let id = self.device_id.parse()?;
        let webcam_ref = connection_storage.get_connection_by_stable::<WebcamRef>(&id);
        if webcam_ref.is_none() {
            return Ok(());
        }

        let webcam_ref = webcam_ref.unwrap();

        if state.is_none() {
            *state = Some(
                WebcamState::new(wgpu_context, texture_registry, webcam_ref.clone())
                    .context("Creating video file state")?,
            );
        }

        let state = state.as_mut().unwrap();
        if &state.webcam_ref != webcam_ref {
            state
                .change_webcam(webcam_ref.clone())
                .context("Changing webcam")?;
        }
        state.receive_frames();
        if !state.texture.is_ready() {
            return Ok(());
        }
        context.write_port(OUTPUT_PORT, state.transfer_texture);
        let texture = texture_registry
            .get(&state.transfer_texture)
            .ok_or_else(|| anyhow!("Texture not found in registry"))?;
        let stage = state
            .pipeline
            .render(wgpu_context, &texture, &mut state.texture)
            .context("Rendering texture source pipeline")?;
        wgpu_pipeline.add_stage(stage);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        None
    }
}

pub struct WebcamState {
    webcam_ref: WebcamRef,
    texture: BackgroundDecoderTexture,
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
        let mut texture = BackgroundDecoderTexture::new(metadata);
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
        self.texture = BackgroundDecoderTexture::new(metadata);

        Ok(())
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

    fn handle(&mut self, _command: Self::Commands) -> anyhow::Result<()> {
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
