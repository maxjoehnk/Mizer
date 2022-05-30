use serde::{Deserialize, Serialize};
use std::any::Any;
use std::fmt::{Debug, Display, Formatter, Result};
use std::hash::{Hash, Hasher};
use std::ops::Deref;

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

#[derive(Debug, Clone, Copy, Hash, PartialEq, Eq, Deserialize, Serialize)]
pub enum PortType {
    /// Single float value
    ///
    /// e.g. Control signals
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
    /// Text Data
    ///
    /// e.g. Scripts
    Data,
    // TODO: figure out what kind's of data should be transmitted here
    /// Materials and Shaders for 3D Objects
    Material,
    /// Legacy, should be converted to texture
    Gstreamer,
}

impl Default for PortType {
    fn default() -> Self {
        PortType::Single
    }
}

pub trait NodePortReceiver<'a, Item>
where
    Item: PortValue,
{
    type Guard: ReceiverGuard<Item>;

    fn recv(&'a self) -> Option<Self::Guard>;
}

pub trait ReceiverGuard<Item>: Deref<Target = Item>
where
    Item: PortValue,
{
}

pub trait NodePortSender<Item>
where
    Item: PortValue,
{
    fn send(&self, value: Item) -> anyhow::Result<()>;
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
    pub fn rgb(red: f64, green: f64, blue: f64) -> Self {
        Self {
            red,
            green,
            blue,
            alpha: 1f64,
        }
    }
}

impl From<(f64, f64, f64)> for Color {
    fn from((r, g, b): (f64, f64, f64)) -> Self {
        Self::rgb(r, g, b)
    }
}

#[allow(clippy::derive_hash_xor_eq)]
impl Hash for Color {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.red.to_bits().hash(state);
        self.green.to_bits().hash(state);
        self.blue.to_bits().hash(state);
        self.alpha.to_bits().hash(state);
    }
}
