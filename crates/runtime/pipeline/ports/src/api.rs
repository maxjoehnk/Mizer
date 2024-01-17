use std::any::Any;
use std::fmt::{Debug, Display, Formatter, Result};
use std::hash::{Hash, Hasher};
use std::ops::{Deref, Mul};

use enum_iterator::Sequence;
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};

use mizer_util::hsv_to_rgb;

#[derive(Debug, Clone, Hash, PartialEq, Eq, PartialOrd, Ord, Serialize, Deserialize)]
#[repr(transparent)]
#[serde(transparent)]
pub struct PortId(pub String);

impl Display for PortId {
    fn fmt(&self, f: &mut Formatter) -> Result {
        std::fmt::Display::fmt(&self.0, f)
    }
}

impl From<String> for PortId {
    fn from(id: String) -> Self {
        PortId(id)
    }
}

impl From<&str> for PortId {
    fn from(id: &str) -> Self {
        Self(id.to_string())
    }
}

impl PartialEq<&str> for &PortId {
    fn eq(&self, other: &&str) -> bool {
        &self.0 == other
    }
}

impl PartialEq<String> for &PortId {
    fn eq(&self, other: &String) -> bool {
        &self.0 == other
    }
}

impl PortId {
    pub fn as_str(&self) -> &str {
        self.0.as_str()
    }
}

impl AsRef<str> for PortId {
    fn as_ref(&self) -> &str {
        self.0.as_str()
    }
}

#[derive(
    Debug,
    Default,
    Clone,
    Copy,
    Hash,
    PartialEq,
    Eq,
    Deserialize,
    Serialize,
    Sequence,
    IntoPrimitive,
    TryFromPrimitive,
)]
#[repr(u8)]
pub enum PortType {
    /// Single float value
    ///
    /// e.g. Control signals
    #[default]
    Single,
    /// Multiple float values
    ///
    /// e.g. Audio
    Multi,
    // TODO: should this actually be a texture?
    /// RGBA Colors
    Color,
    /// 2D Image and Video
    Texture,
    // TODO: maybe merge Vector and Poly?
    /// Vector Data
    ///
    /// e.g. SVG
    Vector,
    // TODO: maybe merge into vector?
    /// Laser Frames
    Laser,
    /// 3D Data
    ///
    /// e.g. 3D Objects
    Poly,
    /// Structured Data
    ///
    /// e.g. Text, Lists, Objects, Numbers
    Data,
    // TODO: figure out what kind's of data should be transmitted here
    /// Materials and Shaders for 3D Objects
    Material,
    /// Time signal measured in frames
    Clock,
}

pub mod port_types {
    use mizer_util::StructuredData;
    use mizer_vector::VectorData;

    pub type SINGLE = f64;
    pub type MULTI = Vec<f64>;
    pub type COLOR = super::Color;
    pub type DATA = StructuredData;
    pub type VECTOR = VectorData;
    pub type CLOCK = u64;
}

impl Display for PortType {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
        write!(f, "{:?}", self)
    }
}

pub trait NodePortReceiver<'a, Item>
where
    Item: PortValue,
{
    type Guard: ReceiverGuard<Item>;

    fn recv(&'a self) -> Option<Self::Guard>;
}

pub trait ReceiverGuard<Item>: Deref<Target = Option<Item>>
where
    Item: PortValue,
{
}

pub trait NodePortSender<Item>
where
    Item: PortValue,
{
    fn send(&self, value: Item) -> anyhow::Result<()>;

    fn clear(&self) -> anyhow::Result<()>;
}

pub trait PortValue: Debug + Clone + PartialEq + Send + Sync + Any {}

impl<T> PortValue for T where T: Debug + Clone + PartialEq + Send + Sync + Any {}

#[derive(Debug, Default, Clone, Copy, PartialEq, Serialize, Deserialize)]
pub struct Color {
    pub red: f64,
    pub green: f64,
    pub blue: f64,
    pub alpha: f64,
}

impl Color {
    pub const WHITE: Self = Self::rgb(1f64, 1f64, 1f64);
    pub const BLACK: Self = Self::rgb(0f64, 0f64, 0f64);

    pub const fn rgb(red: f64, green: f64, blue: f64) -> Self {
        Self {
            red,
            green,
            blue,
            alpha: 1f64,
        }
    }

    pub fn hsv(hue: f64, saturation: f64, value: f64) -> Self {
        let (red, green, blue) = hsv_to_rgb(hue, saturation, value);

        Self::rgb(red, green, blue)
    }
}

impl From<(f64, f64, f64)> for Color {
    fn from((r, g, b): (f64, f64, f64)) -> Self {
        Self::rgb(r, g, b)
    }
}

impl From<Color> for (f64, f64, f64) {
    fn from(color: Color) -> Self {
        (color.red, color.green, color.blue)
    }
}

impl From<Color> for [f32; 4] {
    fn from(color: Color) -> Self {
        [
            color.red as f32,
            color.green as f32,
            color.blue as f32,
            color.alpha as f32,
        ]
    }
}

impl Mul<f64> for Color {
    type Output = Self;

    fn mul(self, rhs: f64) -> Self::Output {
        Self {
            red: self.red * rhs,
            green: self.green * rhs,
            blue: self.blue * rhs,
            alpha: self.alpha,
        }
    }
}

#[allow(clippy::derived_hash_with_manual_eq)]
impl Hash for Color {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.red.to_bits().hash(state);
        self.green.to_bits().hash(state);
        self.blue.to_bits().hash(state);
        self.alpha.to_bits().hash(state);
    }
}
