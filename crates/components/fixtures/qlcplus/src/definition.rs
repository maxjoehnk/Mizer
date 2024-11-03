use std::fmt::{Display, Formatter};
use std::ops::Deref;
use std::str::FromStr;

use serde_derive::Deserialize;

#[derive(Debug, Clone, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct QlcPlusFixtureDefinition {
    pub manufacturer: String,
    pub model: String,
    #[serde(rename = "Type")]
    pub fixture_type: String,
    #[serde(default, rename = "Channel")]
    pub channels: Vec<ChannelType>,
    #[serde(default, rename = "Mode")]
    pub modes: Vec<ModeType>,
    #[serde(default)]
    pub physical: Option<PhysicalType>,
}

impl FromStr for QlcPlusFixtureDefinition {
    type Err = quick_xml::de::DeError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        quick_xml::de::from_str(s)
    }
}

#[derive(Debug, Clone, Deserialize)]
pub struct PhysicalType {}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct ChannelType {
    #[serde(rename = "@Name")]
    pub name: String,
    #[serde(default)]
    pub default: Option<DmxValueType>,
    #[serde(rename = "@Preset")]
    pub preset: Option<ChannelPresetType>,
    #[serde(rename = "Capability", default)]
    pub capabilities: Vec<CapabilityType>,
    #[serde(rename = "Group", default)]
    pub group: Option<GroupType>,
    #[serde(rename = "Colour", default)]
    pub color: Option<ColorType>,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
pub struct CapabilityType {
    #[serde(default, rename = "$value")]
    pub children: Vec<CapabilityChild>,
    #[serde(rename = "@Min")]
    pub min: DmxValueType,
    #[serde(rename = "@Max")]
    pub max: DmxValueType,
    #[serde(default, rename = "@Preset")]
    pub preset: Option<CapabilityPresetType>,
    #[serde(rename = "@Res1", default)]
    pub resource1: Option<String>,
    #[serde(rename = "@Res2", default)]
    pub resource2: Option<String>,
    #[serde(rename = "@Res", default)]
    pub resource: Option<String>,
    #[serde(default, rename = "@Color")]
    pub color: Option<String>,
    #[serde(default, rename = "@Color2")]
    pub color2: Option<String>,
}

impl CapabilityType {
    pub fn name(&self) -> String {
        self.children.iter()
            .find_map(|child| match child {
                CapabilityChild::Name(name) => Some(name.clone()),
                _ => None,
            })
            .expect("Capability has no name")
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
pub enum CapabilityChild {
    Alias(AliasType),
    #[serde(rename = "$text")]
    Name(String),
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
pub struct AliasType {
    #[serde(rename = "@Mode")]
    pub mode: String,
    #[serde(rename = "@Channel")]
    pub channel: String,
    #[serde(rename = "@With")]
    pub with: String,
}

#[derive(Debug, Clone, Deserialize)]
pub struct ModeType {
    #[serde(rename = "@Name")]
    pub name: String,
    #[serde(rename = "Channel", default)]
    pub channels: Vec<ModeChannelType>,
    #[serde(default)]
    pub physical: Vec<PhysicalType>,
    #[serde(rename = "Head", default)]
    pub heads: Vec<HeadType>,
}

#[derive(Debug, Clone, Deserialize)]
pub struct HeadType {
    #[serde(rename = "Channel")]
    pub channels: Vec<u16>,
}

#[derive(Debug, Clone, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct ModeChannelType {
    #[serde(rename = "@Number")]
    pub number: u16,
    #[serde(default)]
    pub acts_on: Option<u64>,
    #[serde(rename = "$value")]
    pub channel: String,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize)]
pub struct GroupType {
    #[serde(rename = "@Byte")]
    pub byte: u8,
    #[serde(rename = "$text")]
    pub group: GroupEnumType,
}

pub type DmxValueType = u64;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize)]
pub enum ChannelPresetType {
    IntensityMasterDimmer,
    IntensityMasterDimmerFine,
    IntensityDimmer,
    IntensityDimmerFine,
    IntensityRed,
    IntensityRedFine,
    IntensityGreen,
    IntensityGreenFine,
    IntensityBlue,
    IntensityBlueFine,
    IntensityCyan,
    IntensityCyanFine,
    IntensityMagenta,
    IntensityMagentaFine,
    IntensityYellow,
    IntensityYellowFine,
    IntensityAmber,
    IntensityAmberFine,
    IntensityWhite,
    IntensityWhiteFine,
    IntensityUV,
    IntensityUVFine,
    IntensityIndigo,
    IntensityIndigoFine,
    IntensityLime,
    IntensityLimeFine,
    IntensityHue,
    IntensityHueFine,
    IntensitySaturation,
    IntensitySaturationFine,
    IntensityLightness,
    IntensityLightnessFine,
    IntensityValue,
    IntensityValueFine,
    PositionPan,
    PositionPanFine,
    PositionTilt,
    PositionTiltFine,
    PositionXAxis,
    PositionYAxis,
    SpeedPanSlowFast,
    SpeedPanFastSlow,
    SpeedTiltSlowFast,
    SpeedTiltFastSlow,
    SpeedPanTiltSlowFast,
    SpeedPanTiltFastSlow,
    ColorMacro,
    ColorWheel,
    ColorWheelFine,
    ColorRGBMixer,
    ColorCTOMixer,
    ColorCTCMixer,
    ColorCTBMixer,
    GoboWheel,
    GoboWheelFine,
    GoboIndex,
    GoboIndexFine,
    ShutterStrobeSlowFast,
    ShutterStrobeFastSlow,
    ShutterIrisMinToMax,
    ShutterIrisMaxToMin,
    ShutterIrisFine,
    BeamFocusNearFar,
    BeamFocusFarNear,
    BeamFocusFine,
    BeamZoomSmallBig,
    BeamZoomBigSmall,
    BeamZoomFine,
    PrismRotationSlowFast,
    PrismRotationFastSlow,
    NoFunction,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize)]
pub enum CapabilityPresetType {
    SlowToFast,
    FastToSlow,
    NearToFar,
    FarToNear,
    BigToSmall,
    SmallToBig,
    ShutterOpen,
    ShutterClose,
    StrobeSlowToFast,
    StrobeFastToSlow,
    StrobeRandom,
    StrobeRandomSlowToFast,
    StrobeRandomFastToSlow,
    PulseSlowToFast,
    PulseFastToSlow,
    RampUpSlowToFast,
    RampUpFastToSlow,
    RampDownSlowToFast,
    RampDownFastToSlow,
    StrobeFrequency,
    StrobeFreqRange,
    PulseFrequency,
    PulseFreqRange,
    RampUpFrequency,
    RampUpFreqRange,
    RampDownFrequency,
    RampDownFreqRange,
    RotationStop,
    RotationIndexed,
    RotationClockwise,
    RotationClockwiseSlowToFast,
    RotationClockwiseFastToSlow,
    RotationCounterClockwise,
    RotationCounterClockwiseSlowToFast,
    RotationCounterClockwiseFastToSlow,
    ColorMacro,
    ColorDoubleMacro,
    ColorWheelIndex,
    GoboMacro,
    GoboShakeMacro,
    GenericPicture,
    PrismEffectOn,
    PrismEffectOff,
    LampOn,
    LampOff,
    ResetAll,
    ResetPanTilt,
    ResetPan,
    ResetTilt,
    ResetMotors,
    ResetGobo,
    ResetColor,
    ResetCMY,
    ResetCTO,
    ResetEffects,
    ResetPrism,
    ResetBlades,
    ResetIris,
    ResetFrost,
    ResetZoom,
    SilentModeOn,
    SilentModeOff,
    SilentModeAutomatic,
    Alias,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize)]
pub enum GroupEnumType {
    Intensity,
    Colour,
    Gobo,
    Prism,
    Shutter,
    Beam,
    Speed,
    Effect,
    Pan,
    Tilt,
    Maintenance,
    Nothing,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize)]
pub enum ColorType {
    Generic,
    Red,
    Green,
    Blue,
    Cyan,
    Magenta,
    Yellow,
    Amber,
    White,
    UV,
    Lime,
    Indigo,
}
