use std::fmt::{Display, Formatter};
use std::sync::Arc;

use pinboard::NonEmptyPinboard;
use serde::{Deserialize, Serialize};
use uuid::Uuid;

use mizer_fixtures::programmer::PresetId;
use mizer_fixtures::GroupId;
use mizer_node::{Color, NodePath};
use mizer_util::Base64Image;

pub mod views;

pub type LayoutStorage = Arc<NonEmptyPinboard<Vec<Layout>>>;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Layout {
    pub id: String,
    pub controls: Vec<ControlConfig>,
}

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct ControlId(Uuid);

impl TryFrom<String> for ControlId {
    type Error = uuid::Error;

    fn try_from(value: String) -> Result<Self, Self::Error> {
        Uuid::try_from(value.as_str()).map(Self)
    }
}

impl Display for ControlId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.0)
    }
}

impl Default for ControlId {
    fn default() -> Self {
        Self(Uuid::new_v4())
    }
}

impl ControlId {
    pub fn new() -> Self {
        Self::default()
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct ControlConfig {
    #[serde(default)]
    pub id: ControlId,
    #[serde(default)]
    pub label: Option<String>,
    #[serde(flatten)]
    pub control_type: ControlType,
    pub position: ControlPosition,
    pub size: ControlSize,
    #[serde(default)]
    pub decoration: ControlDecorations,
    #[serde(default)]
    pub behavior: ControlBehavior,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
#[serde(untagged)]
pub enum ControlType {
    Node {
        #[serde(alias = "node")]
        path: NodePath,
    },
    Sequencer {
        sequence_id: u32,
    },
    Group {
        group_id: GroupId,
    },
    Preset {
        preset_id: PresetId,
    },
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
