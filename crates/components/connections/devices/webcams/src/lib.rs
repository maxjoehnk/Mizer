pub use discovery::WebcamDiscovery;
use nokhwa::pixel_format::RgbAFormat;
use nokhwa::utils::{
    CameraControl, CameraInfo, ControlValueDescription, KnownCameraControl, RequestedFormat,
    RequestedFormatType, Resolution,
};
use nokhwa::Camera;

mod discovery;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct WebcamRef(CameraInfo);

impl WebcamRef {
    pub(crate) fn new(info: CameraInfo) -> Self {
        Self(info)
    }

    pub fn name(&self) -> String {
        format!("{} ({})", self.0.human_name(), self.0.description())
    }

    pub fn id(&self) -> String {
        self.0.index().as_string()
    }

    pub fn open(&self) -> anyhow::Result<Webcam> {
        let mut camera = Camera::new(
            self.0.index().clone(),
            RequestedFormat::new::<RgbAFormat>(RequestedFormatType::HighestResolution(
                Resolution::new(1920, 1080),
            )),
        )?;
        tracing::info!(
            "Opening camera {} with resolution {} and fps {}",
            self.name(),
            camera.resolution(),
            camera.frame_rate()
        );
        camera.open_stream()?;

        Ok(Webcam(camera))
    }
}

pub struct Webcam(Camera);

impl Webcam {
    pub fn width(&self) -> u32 {
        self.0.resolution().width_x
    }

    pub fn height(&self) -> u32 {
        self.0.resolution().height_y
    }

    pub fn frame_rate(&self) -> u32 {
        self.0.frame_rate()
    }

    pub fn settings(&self) -> anyhow::Result<Vec<WebcamSetting>> {
        let controls = self.0.camera_controls()?;

        let settings = controls
            .into_iter()
            .flat_map(|setting| WebcamSetting::try_from(setting).ok())
            .collect();

        Ok(settings)
    }

    pub fn frame(&mut self) -> anyhow::Result<WebcamFrame> {
        let buffer = self.0.frame()?;

        Ok(WebcamFrame(buffer))
    }
}

pub struct WebcamFrame(nokhwa::Buffer);

impl WebcamFrame {
    pub fn data(&self) -> anyhow::Result<Vec<u8>> {
        let image = self.0.decode_image::<RgbAFormat>()?;

        Ok(image.into_flat_samples().samples)
    }
}

#[derive(Debug, Clone)]
pub enum WebcamSetting {
    Brightness(WebcamSettingValue),
    Contrast(WebcamSettingValue),
    Hue(WebcamSettingValue),
    Saturation(WebcamSettingValue),
    Sharpness(WebcamSettingValue),
    Gamma(WebcamSettingValue),
    WhiteBalance(WebcamSettingValue),
    BacklightComp(WebcamSettingValue),
    Gain(WebcamSettingValue),
    Pan(WebcamSettingValue),
    Tilt(WebcamSettingValue),
    Zoom(WebcamSettingValue),
    Exposure(WebcamSettingValue),
    Iris(WebcamSettingValue),
    Focus(WebcamSettingValue),
}

impl TryFrom<CameraControl> for WebcamSetting {
    type Error = anyhow::Error;

    fn try_from(control: CameraControl) -> Result<Self, Self::Error> {
        let value = WebcamSettingValue::try_from(control.description())?;

        match control.control() {
            KnownCameraControl::Brightness => Ok(WebcamSetting::Brightness(value)),
            KnownCameraControl::Contrast => Ok(WebcamSetting::Contrast(value)),
            KnownCameraControl::Hue => Ok(WebcamSetting::Hue(value)),
            KnownCameraControl::Saturation => Ok(WebcamSetting::Saturation(value)),
            KnownCameraControl::Sharpness => Ok(WebcamSetting::Sharpness(value)),
            KnownCameraControl::Gamma => Ok(WebcamSetting::Gamma(value)),
            KnownCameraControl::WhiteBalance => Ok(WebcamSetting::WhiteBalance(value)),
            KnownCameraControl::BacklightComp => Ok(WebcamSetting::BacklightComp(value)),
            KnownCameraControl::Gain => Ok(WebcamSetting::Gain(value)),
            KnownCameraControl::Pan => Ok(WebcamSetting::Pan(value)),
            KnownCameraControl::Tilt => Ok(WebcamSetting::Tilt(value)),
            KnownCameraControl::Zoom => Ok(WebcamSetting::Zoom(value)),
            KnownCameraControl::Exposure => Ok(WebcamSetting::Exposure(value)),
            KnownCameraControl::Iris => Ok(WebcamSetting::Iris(value)),
            KnownCameraControl::Focus => Ok(WebcamSetting::Focus(value)),
            _ => Err(anyhow::anyhow!("Unsupported control")),
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum WebcamSettingValue {
    Float {
        value: f64,
        step: f64,
        min: Option<f64>,
        max: Option<f64>,
    },
    Int {
        value: i64,
        step: i64,
        min: Option<i64>,
        max: Option<i64>,
    },
    Bool {
        value: bool,
    },
    Text {
        value: String,
    },
}

impl TryFrom<&ControlValueDescription> for WebcamSettingValue {
    type Error = anyhow::Error;

    fn try_from(value: &ControlValueDescription) -> Result<Self, Self::Error> {
        match value {
            ControlValueDescription::Float { value, step, .. } => Ok(Self::Float {
                value: *value,
                step: *step,
                min: None,
                max: None,
            }),
            ControlValueDescription::FloatRange {
                value,
                step,
                min,
                max,
                ..
            } => Ok(Self::Float {
                value: *value,
                step: *step,
                min: Some(*min),
                max: Some(*max),
            }),
            ControlValueDescription::Integer { value, step, .. } => Ok(Self::Int {
                value: *value,
                step: *step,
                min: None,
                max: None,
            }),
            ControlValueDescription::IntegerRange {
                value,
                step,
                min,
                max,
                ..
            } => Ok(Self::Int {
                value: *value,
                step: *step,
                min: Some(*min),
                max: Some(*max),
            }),
            ControlValueDescription::Boolean { value, .. } => Ok(Self::Bool { value: *value }),
            ControlValueDescription::String { value, .. } => Ok(Self::Text {
                value: value.clone(),
            }),
            value => Err(anyhow::anyhow!("Unsupported control value: {value:?}")),
        }
    }
}
