use serde::{Deserialize, Serialize};

use crate::path::NodePath;
use mizer_ports::{PortId, PortType};

#[derive(Hash, Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct NodeLink {
    pub source: NodePath,
    pub source_port: PortId,
    pub target: NodePath,
    pub target_port: PortId,
    pub port_type: PortType,
    pub local: bool,
}

#[derive(Default, Debug, Clone, Copy, PartialEq, Eq, Deserialize, Serialize)]
pub struct PortMetadata {
    pub port_type: PortType,
    pub direction: PortDirection,
    pub multiple: Option<bool>,
    pub dimensions: Option<(u64, u64)>,
    pub count: Option<u64>,
}

impl PortMetadata {
    pub fn is_input(&self) -> bool {
        matches!(self.direction, PortDirection::Input)
    }

    pub fn is_output(&self) -> bool {
        matches!(self.direction, PortDirection::Output)
    }
}

// TODO: add passthrough/bidirectional support
#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize, Serialize)]
pub enum PortDirection {
    Input,
    Output,
}

impl Default for PortDirection {
    fn default() -> Self {
        Self::Input
    }
}

pub trait TogglePort {
    fn to_value(self) -> f64;
    fn from_value(value: f64) -> Self;
}

impl TogglePort for bool {
    fn to_value(self) -> f64 {
        if self {
            1.0
        } else {
            0.0
        }
    }

    fn from_value(value: f64) -> Self {
        value > 0f64
    }
}
