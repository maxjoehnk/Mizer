use std::fmt::{Debug, Display, Formatter, Result};
use serde::{Serialize, Deserialize};
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
    Gstreamer
}

impl Default for PortType {
    fn default() -> Self {
        PortType::Single
    }
}

pub trait NodePortReceiver<'a, Item> where Item: PortValue {
    type Guard : ReceiverGuard<Item>;

    fn recv(&'a self) -> Option<Self::Guard>;
}

pub trait ReceiverGuard<Item> : Deref<Target = Item> where Item: PortValue {
}

pub trait NodePortSender<Item> where Item: PortValue {
    fn send(&self, value: Item) -> anyhow::Result<()>;
}

pub trait PortValue : Debug + Clone + PartialEq + Send + Sync {}

impl<T> PortValue for T
    where T: Debug + Clone + PartialEq + Send + Sync
{}
