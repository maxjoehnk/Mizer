use custom_derive::custom_derive;
use enum_derive::*;
use std::fmt::{Display, Formatter};
use std::ops::Deref;
use std::str::FromStr;
use strong_xml::XmlRead;

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "FixtureDefinition")]
pub struct QlcPlusFixtureDefinition {
    #[xml(flatten_text = "Manufacturer")]
    pub manufacturer: String,
    #[xml(flatten_text = "Model")]
    pub model: String,
    #[xml(flatten_text = "Type")]
    pub fixture_type: String,
    #[xml(child = "Channel")]
    pub channels: Vec<ChannelType>,
    #[xml(child = "Mode")]
    pub modes: Vec<ModeType>,
    #[xml(default, child = "Physical")]
    pub physical: Option<PhysicalType>,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "Physical")]
pub struct PhysicalType {}

#[derive(Debug, Clone, PartialEq, XmlRead)]
#[xml(tag = "Channel")]
pub struct ChannelType {
    #[xml(attr = "Name")]
    pub name: HtmlEntityString,
    #[xml(default, attr = "Default")]
    pub default: Option<DmxValueType>,
    #[xml(attr = "Preset")]
    pub preset: Option<ChannelPresetType>,
    #[xml(default, child = "Capability")]
    pub capabilities: Vec<CapabilityType>,
    #[xml(default, child = "Group")]
    pub group: Option<GroupType>,
    #[xml(default, flatten_text = "Colour")]
    pub color: Option<ColorType>,
}

#[derive(Debug, Clone, PartialEq, XmlRead)]
#[xml(tag = "Capability")]
pub struct CapabilityType {
    #[xml(text)]
    pub name: HtmlEntityString,
    #[xml(attr = "Min")]
    pub min: DmxValueType,
    #[xml(attr = "Max")]
    pub max: DmxValueType,
    #[xml(default, attr = "Preset")]
    pub preset: Option<CapabilityPresetType>,
    #[xml(default, child = "Alias")]
    pub alias: Vec<AliasType>,
    #[xml(attr = "Res1")]
    pub resource1: Option<String>,
    #[xml(attr = "Res2")]
    pub resource2: Option<String>,
    #[xml(attr = "Res")]
    pub resource: Option<String>,
    #[xml(attr = "Color")]
    pub color: Option<String>,
    #[xml(attr = "Color2")]
    pub color2: Option<String>,
}

#[derive(Debug, Clone, PartialEq, XmlRead)]
#[xml(tag = "Alias")]
pub struct AliasType {
    #[xml(attr = "Mode")]
    pub mode: String,
    #[xml(attr = "Channel")]
    pub channel: HtmlEntityString,
    #[xml(attr = "With")]
    pub with: String,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "Mode")]
pub struct ModeType {
    #[xml(attr = "Name")]
    pub name: String,
    #[xml(child = "Channel")]
    pub channels: Vec<ModeChannelType>,
    #[xml(child = "Physical")]
    pub physical: Vec<PhysicalType>,
    #[xml(child = "Head")]
    pub heads: Vec<HeadType>,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "Head")]
pub struct HeadType {
    #[xml(flatten_text = "Channel")]
    pub channels: Vec<u64>,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "Channel")]
pub struct ModeChannelType {
    #[xml(attr = "Number")]
    pub number: u64,
    #[xml(default, attr = "ActsOn")]
    pub acts_on: Option<u64>,
    #[xml(text)]
    pub channel: HtmlEntityString,
}

#[derive(Debug, Clone, Copy, PartialEq, XmlRead)]
#[xml(tag = "Group")]
pub struct GroupType {
    #[xml(attr = "Byte")]
    pub byte: u8,
    #[xml(text)]
    pub group: GroupEnumType,
}

pub type DmxValueType = u64;

custom_derive! {
    #[derive(Debug, Clone, Copy, PartialEq, Eq, EnumFromStr)]
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
}

custom_derive! {
    #[derive(Debug, Clone, Copy, PartialEq, Eq, EnumFromStr)]
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
}

custom_derive! {
    #[derive(Debug, Clone, Copy, PartialEq, Eq, EnumFromStr)]
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
}

custom_derive! {
    #[derive(Debug, Clone, Copy, PartialEq, Eq, EnumFromStr)]
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
}

#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
#[repr(transparent)]
pub struct HtmlEntityString(String);

impl FromStr for HtmlEntityString {
    type Err = anyhow::Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let string = htmlentity::entity::decode(s).into_iter().collect();

        Ok(Self(string))
    }
}

impl Deref for HtmlEntityString {
    type Target = String;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl Display for HtmlEntityString {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        f.write_str(&self.0)
    }
}
