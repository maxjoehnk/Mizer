use mizer_node::{PortId, PortType};
use serde::{Deserialize, Serialize};

const NUMBER_PORT: &str = "Number";
const COLOR_PORT: &str = "Color";

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
            Self::Int | Self::Float | Self::Long | Self::Double | Self::Bool => NUMBER_PORT.into(),
            Self::Color => COLOR_PORT.into(),
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
