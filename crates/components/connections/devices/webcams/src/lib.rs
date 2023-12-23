#[cfg(feature = "enable")]
pub use discovery::WebcamDiscovery;
#[cfg(feature = "enable")]
pub use nokhwa_impl::*;
#[cfg(not(feature = "enable"))]
pub use discovery_noop::WebcamDiscovery;
#[cfg(not(feature = "enable"))]
pub use noop_impl::*;

#[cfg(feature = "enable")]
mod discovery;

#[cfg(not(feature = "enable"))]
mod discovery_noop;

#[cfg(feature = "enable")]
mod nokhwa_impl;

#[cfg(not(feature = "enable"))]
mod noop_impl;

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
