use std::collections::HashMap;
use std::fmt;
use std::sync::Arc;
use derive_more::{Display, From, FromStr};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum FixtureChannelCategory {
    Dimmer,
    Color,
    Position,
    Gobo,
    Beam,
    Shaper,
}

#[derive(Debug, Display, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash, Deserialize, Serialize)]
pub enum FixtureChannel {
    Intensity,
    Shutter,
    ColorMixer(FixtureColorChannel),
    ColorWheel,
    GoboWheel,
    GoboWheelRotation,
    Pan,
    Tilt,
    PanEndless,
    TiltEndless,
    Focus,
    Zoom,
    Prism,
    PrismRotation,
    Iris,
    Frost,
    Shaper(FixtureShaperChannel),
    ShaperRotation,
}

impl TryFrom<String> for FixtureChannel {
    type Error = anyhow::Error;

    fn try_from(value: String) -> Result<Self, Self::Error> {
        todo!()
    }
}

impl TryFrom<&str> for FixtureChannel {
    type Error = anyhow::Error;

    fn try_from(value: &str) -> Result<Self, Self::Error> {
        todo!()
    }
}

impl FixtureChannel {
    pub const fn category(&self) -> FixtureChannelCategory {
        match self {
            Self::Intensity | Self::Shutter => FixtureChannelCategory::Dimmer,
            Self::ColorMixer(_) | Self::ColorWheel => FixtureChannelCategory::Color,
            Self::Pan | Self::Tilt | Self::PanEndless | Self::TiltEndless => FixtureChannelCategory::Position,
            Self::GoboWheel | Self::GoboWheelRotation => FixtureChannelCategory::Gobo,
            Self::Focus | Self::Zoom | Self::Prism | Self::PrismRotation | Self::Iris | Self::Frost => FixtureChannelCategory::Beam,
            Self::Shaper(_) | Self::ShaperRotation => FixtureChannelCategory::Shaper,
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

#[derive(Debug, Clone, PartialEq, bon::Builder)]
pub struct FixtureChannelDefinition {
    pub channel: FixtureChannel,
    pub label: Option<Arc<String>>,
    #[builder(default)]
    pub presets: Vec<FixtureChannelPreset>,
    pub channels: DmxChannels,
    pub default: Option<FixtureValue>,
    pub highlight: Option<FixtureValue>,
}

impl FixtureChannelDefinition {
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

#[derive(Debug, Clone, Copy, PartialEq)]
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

#[derive(Debug, Display, Clone, Copy, PartialEq, Eq, Hash, PartialOrd, Ord, Deserialize, Serialize)]
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

#[derive(Debug, Clone, PartialEq)]
pub struct FixtureChannelMode {
    pub name: Arc<String>,
    pub channels: HashMap<FixtureChannel, FixtureChannelDefinition>,
    pub children: Vec<SubFixtureChannelMode>,
}

impl FixtureChannelMode {
    pub fn new(name: String, channels: Vec<FixtureChannelDefinition>, children: Vec<SubFixtureChannelMode>) -> Self {
        Self {
            name: Arc::new(name),
            channels: channels.into_iter().map(|c| (c.channel, c)).collect(),
            children,
        }
    }

    pub fn channel_count(&self) -> u16 {
        let child_channels = self.children.iter()
            .flat_map(|c| c.channels.iter().map(|(_, c)| c.channels.dmx_width()))
            .sum::<u16>();
        let channels = self.channels.iter().map(|(_, c)| c.channels.dmx_width()).sum::<u16>();

        channels + child_channels
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct SubFixtureChannelMode {
    pub id: u32,
    pub name: Arc<String>,
    pub channels: HashMap<FixtureChannel, FixtureChannelDefinition>,
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
