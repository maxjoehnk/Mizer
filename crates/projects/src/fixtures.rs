use mizer_fixtures::programmer::{Color, Position, Preset};
use serde::{Deserialize, Serialize};

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct PresetsStore {
    #[serde(default)]
    pub intensity: Vec<Preset<f64>>,
    #[serde(default)]
    pub shutter: Vec<Preset<f64>>,
    #[serde(default)]
    pub color: Vec<Preset<Color>>,
    #[serde(default)]
    pub position: Vec<Preset<Position>>,
}
