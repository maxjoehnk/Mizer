use mizer_node::{PortId, PortType};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub enum OscArgumentType {
    Int,
    Float,
    Long,
    Double,
    Bool,
    Color,
}

impl OscArgumentType {
    pub(crate) fn get_port_id(&self) -> PortId {
        match self {
            Self::Int => "number".into(),
            Self::Float => "number".into(),
            Self::Long => "number".into(),
            Self::Double => "number".into(),
            Self::Bool => "number".into(),
            Self::Color => "color".into(),
        }
    }

    pub(crate) fn get_port_type(&self) -> PortType {
        match self {
            Self::Int => PortType::Single,
            Self::Float => PortType::Single,
            Self::Long => PortType::Single,
            Self::Double => PortType::Single,
            Self::Bool => PortType::Single,
            Self::Color => PortType::Color,
        }
    }

    pub(crate) fn is_numeric(&self) -> bool {
        matches!(
            self,
            Self::Int | Self::Float | Self::Long | Self::Double | Self::Bool
        )
    }

    pub(crate) fn is_color(&self) -> bool {
        matches!(self, Self::Color)
    }
}
