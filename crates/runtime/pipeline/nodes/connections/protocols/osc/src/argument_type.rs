use std::fmt::{Display, Formatter};

use enum_iterator::Sequence;
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};

use mizer_node::{PortId, PortType};

const NUMBER_PORT: &str = "Number";
const COLOR_PORT: &str = "Color";
const DATA_PORT: &str = "Data";

#[derive(
    Debug,
    Clone,
    Copy,
    Deserialize,
    Serialize,
    PartialEq,
    Eq,
    Sequence,
    TryFromPrimitive,
    IntoPrimitive,
)]
#[repr(u8)]
#[serde(rename_all = "camelCase")]
pub enum OscArgumentType {
    Int,
    Float,
    Long,
    Double,
    Bool,
    Color,
    String,
}

impl OscArgumentType {
    pub(crate) fn get_port_id(&self) -> PortId {
        match self {
            Self::Int | Self::Float | Self::Long | Self::Double | Self::Bool => NUMBER_PORT.into(),
            Self::Color => COLOR_PORT.into(),
            Self::String => DATA_PORT.into(),
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
            Self::String => PortType::Data,
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

    pub(crate) fn is_data(&self) -> bool {
        matches!(self, Self::String)
    }
}

impl Display for OscArgumentType {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}
