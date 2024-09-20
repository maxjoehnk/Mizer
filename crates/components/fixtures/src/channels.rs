use std::fmt;
use std::fmt::Formatter;
use std::ops::AddAssign;
use std::str::FromStr;
use std::sync::Arc;
use derive_more::{Display, From};
use derive_builder::Builder;
use indexmap::IndexMap;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum FixtureChannelCategory {
    Dimmer,
    Color,
    Position,
    Gobo,
    Beam,
    Shaper,
    Custom,
}

#[derive(Debug, Display, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash, Deserialize, Serialize)]
pub enum FixtureChannel {
    Intensity,
    #[display("Shutter{_0}")]
    Shutter(u8),
    #[display("ColorMixer{_0}")]
    ColorMixer(FixtureColorChannel),
    ColorWheel,
    #[display("GoboWheel{_0}")]
    GoboWheel(u8),
    #[display("GoboWheel{_0}Rotation")]
    GoboWheelRotation(u8),
    Pan,
    Tilt,
    PanEndless,
    TiltEndless,
    PanSpeed,
    TiltSpeed,
    PanTiltSpeed,
    #[display("Focus{_0}")]
    Focus(u8),
    #[display("Zoom{_0}")]
    Zoom(u8),
    #[display("Prism{_0}")]
    Prism(u8),
    #[display("Prism{_0}Rotation")]
    PrismRotation(u8),
    Iris,
    #[display("Frost{_0}")]
    Frost(u8),
    #[display("Shaper{_0}")]
    Shaper(FixtureShaperChannel),
    ShaperRotation,
    #[display("Custom{_0}")]
    Custom(u8)
}

impl FromStr for FixtureChannel {
    type Err = anyhow::Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        // TODO: auto parse numbers
        match s {
            "Intensity" => Ok(Self::Intensity),
            "Shutter1" => Ok(Self::Shutter(1)),
            "Shutter2" => Ok(Self::Shutter(2)),
            "ColorMixerRed" => Ok(Self::ColorMixer(FixtureColorChannel::Red)),
            "ColorMixerGreen" => Ok(Self::ColorMixer(FixtureColorChannel::Green)),
            "ColorMixerBlue" => Ok(Self::ColorMixer(FixtureColorChannel::Blue)),
            "ColorMixerWhite" => Ok(Self::ColorMixer(FixtureColorChannel::White)),
            "ColorMixerAmber" => Ok(Self::ColorMixer(FixtureColorChannel::Amber)),
            "ColorMixerLime" => Ok(Self::ColorMixer(FixtureColorChannel::Lime)),
            "ColorMixerCyan" => Ok(Self::ColorMixer(FixtureColorChannel::Cyan)),
            "ColorMixerMagenta" => Ok(Self::ColorMixer(FixtureColorChannel::Magenta)),
            "ColorMixerYellow" => Ok(Self::ColorMixer(FixtureColorChannel::Yellow)),
            "ColorWheel" => Ok(Self::ColorWheel),
            "GoboWheel1" => Ok(Self::GoboWheel(1)),
            "GoboWheel2" => Ok(Self::GoboWheel(2)),
            "GoboWheel1Rotation" => Ok(Self::GoboWheelRotation(1)),
            "GoboWheel2Rotation" => Ok(Self::GoboWheelRotation(2)),
            "Pan" => Ok(Self::Pan),
            "Tilt" => Ok(Self::Tilt),
            "PanEndless" => Ok(Self::PanEndless),
            "TiltEndless" => Ok(Self::TiltEndless),
            "PanSpeed" => Ok(Self::PanSpeed),
            "TiltSpeed" => Ok(Self::TiltSpeed),
            "PanTiltSpeed" => Ok(Self::PanTiltSpeed),
            "Focus1" => Ok(Self::Focus(1)),
            "Focus2" => Ok(Self::Focus(2)),
            "Zoom1" => Ok(Self::Zoom(1)),
            "Zoom2" => Ok(Self::Zoom(2)),
            "Prism1" => Ok(Self::Prism(1)),
            "Prism2" => Ok(Self::Prism(2)),
            "Prism1Rotation" => Ok(Self::PrismRotation(1)),
            "Prism2Rotation" => Ok(Self::PrismRotation(2)),
            "Iris" => Ok(Self::Iris),
            "Frost1" => Ok(Self::Frost(1)),
            "Frost2" => Ok(Self::Frost(2)),
            "ShaperBlade1" => Ok(Self::Shaper(FixtureShaperChannel::Blade1)),
            "ShaperBlade1a" => Ok(Self::Shaper(FixtureShaperChannel::Blade1a)),
            "ShaperBlade1b" => Ok(Self::Shaper(FixtureShaperChannel::Blade1b)),
            "ShaperBlade2" => Ok(Self::Shaper(FixtureShaperChannel::Blade2)),
            "ShaperBlade2a" => Ok(Self::Shaper(FixtureShaperChannel::Blade2a)),
            "ShaperBlade2b" => Ok(Self::Shaper(FixtureShaperChannel::Blade2b)),
            "ShaperBlade3" => Ok(Self::Shaper(FixtureShaperChannel::Blade3)),
            "ShaperBlade3a" => Ok(Self::Shaper(FixtureShaperChannel::Blade3a)),
            "ShaperBlade3b" => Ok(Self::Shaper(FixtureShaperChannel::Blade3b)),
            "ShaperBlade4" => Ok(Self::Shaper(FixtureShaperChannel::Blade4)),
            "ShaperBlade4a" => Ok(Self::Shaper(FixtureShaperChannel::Blade4a)),
            "ShaperBlade4b" => Ok(Self::Shaper(FixtureShaperChannel::Blade4b)),
            "ShaperRotation" => Ok(Self::ShaperRotation),
            name if name.starts_with("Custom") => {
                let number = name[6..].parse::<u8>()?;
                Ok(Self::Custom(number))
            }
            _ => Err(anyhow::anyhow!("Unknown fixture channel: {}", s)),
        }
    }
}

impl TryFrom<String> for FixtureChannel {
    type Error = anyhow::Error;

    fn try_from(value: String) -> Result<Self, Self::Error> {
        Self::from_str(&value)
    }
}

impl FixtureChannel {
    pub const fn category(&self) -> FixtureChannelCategory {
        match self {
            Self::Intensity | Self::Shutter(_) => FixtureChannelCategory::Dimmer,
            Self::ColorMixer(_) | Self::ColorWheel => FixtureChannelCategory::Color,
            Self::Pan | Self::Tilt | Self::PanEndless | Self::TiltEndless | Self::PanSpeed | Self::TiltSpeed | Self::PanTiltSpeed => FixtureChannelCategory::Position,
            Self::GoboWheel(_) | Self::GoboWheelRotation(_) => FixtureChannelCategory::Gobo,
            Self::Focus(_) | Self::Zoom(_) | Self::Prism(_) | Self::PrismRotation(_) | Self::Iris | Self::Frost(_) => FixtureChannelCategory::Beam,
            Self::Shaper(_) | Self::ShaperRotation => FixtureChannelCategory::Shaper,
            Self::Custom(_) => FixtureChannelCategory::Custom,
        }
    }
}

#[derive(Debug, Display, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash, Deserialize, Serialize)]
pub enum FixtureColorChannel {
    Red,
    Green,
    Blue,
    White,
    Amber,
    Lime,
    Cyan,
    Magenta,
    Yellow,
}

#[derive(Debug, Display, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash, Deserialize, Serialize)]
pub enum FixtureShaperChannel {
    Blade1,
    Blade1a,
    Blade1b,
    Blade2,
    Blade2a,
    Blade2b,
    Blade3,
    Blade3a,
    Blade3b,
    Blade4,
    Blade4a,
    Blade4b,
}

#[derive(Debug, Clone, PartialEq, Builder)]
#[builder(pattern = "owned")]
pub struct FixtureChannelDefinition {
    pub channel: FixtureChannel,
    #[builder(setter(strip_option, into), default)]
    pub label: Option<Arc<String>>,
    #[builder(default)]
    pub presets: Vec<FixtureChannelPreset>,
    pub channels: DmxChannels,
    #[builder(default)]
    pub default: Option<FixtureValue>,
    #[builder(default)]
    pub highlight: Option<FixtureValue>,
}

impl FixtureChannelDefinition {
    pub fn builder() -> FixtureChannelDefinitionBuilder {
        Default::default()
    }

    pub fn name(&self) -> String {
        self.label.clone().map(|label| label.to_string()).unwrap_or_else(|| self.channel.to_string())
    }
    
    pub fn channel_category(&self) -> FixtureChannelCategory {
        self.channel.category()
    }

    pub fn first_address(&self) -> DmxChannel {
        match self.channels {
            DmxChannels::Resolution8Bit { coarse } => coarse,
            DmxChannels::Resolution16Bit { coarse, .. } => coarse,
            DmxChannels::Resolution24Bit { coarse, .. } => coarse,
            DmxChannels::Resolution32Bit { coarse, .. } => coarse,
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureChannelPreset {
    pub value: FixtureValue,
    pub name: String,
    pub image: Option<FixtureImage>,
    pub color: Vec<String>,
}

#[derive(Debug, Clone, Copy, PartialEq, From, Deserialize, Serialize)]
pub enum FixtureValue {
    // Dmx8Bit(u8),
    // Dmx16Bit(u16),
    // Dmx24Bit(u32),
    Percent(f64),
}

impl Display for FixtureValue {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Percent(value) => write!(f, "{:.2}%", value * 100f64),
        }
    }
}

impl FixtureValue {
    pub fn get_percent(&self) -> f64 {
        match self {
            Self::Percent(value) => *value,
        }
    }
}

impl Default for FixtureValue {
    fn default() -> Self {
        Self::Percent(0.)
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Deserialize, Serialize)]
pub struct FixtureChannelValue {
    pub channel: FixtureChannel,
    pub value: FixtureValue,
}

impl FixtureChannelValue {
    pub fn new(channel: FixtureChannel, value: FixtureValue) -> Self {
        Self { channel, value }
    }
}

impl From<(FixtureChannel, FixtureValue)> for FixtureChannelValue {
    fn from((channel, value): (FixtureChannel, FixtureValue)) -> Self {
        Self { channel, value }
    }
}

#[derive(Clone, PartialEq, Eq)]
pub enum FixtureImage {
    Svg(Arc<String>),
    Raster(Arc<Vec<u8>>),
}

impl fmt::Debug for FixtureImage {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Svg(_) => write!(f, "Svg"),
            Self::Raster(_) => write!(f, "Raster"),
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum DmxChannels {
    Resolution8Bit { coarse: DmxChannel },
    Resolution16Bit { coarse: DmxChannel, fine: DmxChannel },
    Resolution24Bit { coarse: DmxChannel, fine: DmxChannel, finest: DmxChannel },
    Resolution32Bit { coarse: DmxChannel, fine: DmxChannel, finest: DmxChannel, ultra: DmxChannel },
}

impl DmxChannels {
    pub fn dmx_width(&self) -> u16 {
        match self {
            Self::Resolution8Bit { .. } => 1,
            Self::Resolution16Bit { .. } => 2,
            Self::Resolution24Bit { .. } => 3,
            Self::Resolution32Bit { .. } => 4,
        }
    }
}

/// Represents a DMX channel address.
///
/// Valid values are in the range 0..512.
/// When displayed we will show the channel number as 1..513 to make it easier for the user to compare to a channel sheet.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, PartialOrd, Ord, Deserialize, Serialize)]
#[serde(transparent)]
pub struct DmxChannel(u16);

impl DmxChannel {
    pub fn new(channel: u16) -> Self {
        debug_assert!(channel < 512, "Channel out of range");

        Self(channel)
    }

    pub fn channel(&self) -> u16 {
        self.0
    }

    pub fn as_usize(&self) -> usize {
        self.0 as usize
    }
}

impl AddAssign<u16> for DmxChannel {
    fn add_assign(&mut self, rhs: u16) {
        self.0 = self.0.saturating_add(rhs);
    }
}

impl Display for DmxChannel {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.0 + 1)
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureChannelMode {
    pub name: Arc<String>,
    pub channels: IndexMap<FixtureChannel, FixtureChannelDefinition>,
    pub children: Vec<SubFixtureChannelMode>,
    pub dmx_channel_count: u16,
}

impl FixtureChannelMode {
    pub fn new(name: String, channels: Vec<FixtureChannelDefinition>, children: Vec<SubFixtureChannelMode>, dmx_channel_count: u16) -> Self {
        Self {
            name: Arc::new(name),
            channels: channels.into_iter().map(|c| (c.channel, c)).collect(),
            children,
            dmx_channel_count,
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct SubFixtureChannelMode {
    pub id: u32,
    pub name: Arc<String>,
    pub channels: IndexMap<FixtureChannel, FixtureChannelDefinition>,
}

impl SubFixtureChannelMode {
    pub fn new(id: u32, name: String, channels: Vec<FixtureChannelDefinition>) -> Self {
        Self {
            id,
            name: Arc::new(name),
            channels: channels.into_iter().map(|c| (c.channel, c)).collect(),
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum DmxChannelResolution {
    /// 8 Bit
    Coarse,
    /// 16 Bit
    Fine,
    /// 24 Bit
    Finest,
    /// 32 Bit
    Ultra,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum FixtureCapability {
    Channel(FixtureChannel, FixtureValue),
    // FixtureValues as well?
    ColorRgb(f64, f64, f64),
    ColorHsl(f64, f64, f64),
    PanTilt(FixtureValue, FixtureValue),
}
