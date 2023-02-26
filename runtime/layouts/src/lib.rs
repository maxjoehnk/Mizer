use base64::Engine;
use mizer_node::{Color, NodePath};
use pinboard::NonEmptyPinboard;
use serde::{Deserialize, Serialize};
use std::sync::Arc;

pub type LayoutStorage = Arc<NonEmptyPinboard<Vec<Layout>>>;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Layout {
    pub id: String,
    pub controls: Vec<ControlConfig>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct ControlConfig {
    #[serde(default)]
    pub label: Option<String>,
    pub node: NodePath,
    pub position: ControlPosition,
    pub size: ControlSize,
    #[serde(default)]
    pub decoration: ControlDecorations,
    #[serde(default)]
    pub behavior: ControlBehavior,
}

#[derive(Default, Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct ControlPosition {
    pub x: u64,
    pub y: u64,
}

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub struct ControlSize {
    pub width: u64,
    pub height: u64,
}

impl Default for ControlSize {
    fn default() -> Self {
        Self {
            width: 1,
            height: 1,
        }
    }
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq, Hash)]
pub struct ControlDecorations {
    pub color: Option<Color>,
    pub image: Option<Base64Image>,
}

#[derive(Debug, Default, Clone, Copy, Deserialize, Serialize, PartialEq, Hash)]
pub struct ControlBehavior {
    #[serde(default)]
    pub sequencer: SequencerControlBehavior,
}

#[derive(Debug, Default, Clone, Copy, Deserialize, Serialize, PartialEq, Hash)]
pub struct SequencerControlBehavior {
    #[serde(default)]
    pub click_behavior: SequencerControlClickBehavior,
}

#[derive(Debug, Default, Clone, Copy, Deserialize, Serialize, PartialEq, Hash)]
pub enum SequencerControlClickBehavior {
    #[default]
    GoForward,
    Toggle,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Hash)]
pub struct Base64Image(String);

impl Base64Image {
    pub fn from_buffer(buffer: Vec<u8>) -> Self {
        Self(base64::engine::general_purpose::STANDARD.encode(buffer))
    }

    pub fn try_to_buffer(&self) -> anyhow::Result<Vec<u8>> {
        let buffer = base64::engine::general_purpose::STANDARD.decode(&self.0)?;

        Ok(buffer)
    }
}
