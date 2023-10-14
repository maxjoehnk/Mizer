use std::fmt::{Display, Formatter};
use std::str::FromStr;

use serde::{Deserialize, Serialize};

#[derive(Default, Debug, Copy, Clone, Deserialize, Serialize, PartialEq, Eq, Hash)]
pub struct SurfaceId(uuid::Uuid);

impl SurfaceId {
    pub fn new() -> Self {
        Self(uuid::Uuid::new_v4())
    }
}

impl Display for SurfaceId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.0)
    }
}

impl FromStr for SurfaceId {
    type Err = uuid::Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        Ok(Self(uuid::Uuid::parse_str(s)?))
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Surface {
    pub id: SurfaceId,
    pub name: String,
    pub sections: Vec<SurfaceSection>,
}

impl Surface {
    pub fn new(id: SurfaceId) -> Self {
        Self {
            id,
            name: "Surface".into(),
            sections: vec![SurfaceSection {
                id: SurfaceSectionId {
                    surface_id: id,
                    index: 0,
                },
                name: "Section 1".into(),
                input: SurfaceTransform::default(),
                output: SurfaceTransform::default(),
            }],
        }
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct SurfaceSection {
    pub id: SurfaceSectionId,
    pub name: String,
    pub input: SurfaceTransform,
    pub output: SurfaceTransform,
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub struct SurfaceTransform {
    pub top_left: SurfaceTransformPoint,
    pub top_right: SurfaceTransformPoint,
    pub bottom_left: SurfaceTransformPoint,
    pub bottom_right: SurfaceTransformPoint,
}

impl Default for SurfaceTransform {
    fn default() -> Self {
        Self {
            top_left: SurfaceTransformPoint { x: 0.0, y: 0.0 },
            top_right: SurfaceTransformPoint { x: 1.0, y: 0.0 },
            bottom_left: SurfaceTransformPoint { x: 0.0, y: 1.0 },
            bottom_right: SurfaceTransformPoint { x: 1.0, y: 1.0 },
        }
    }
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub struct SurfaceTransformPoint {
    pub x: f64,
    pub y: f64,
}

#[derive(Debug, Copy, Clone, Deserialize, Serialize, PartialEq, Eq, Hash)]
pub struct SurfaceSectionId {
    pub surface_id: SurfaceId,
    pub index: usize,
}

impl Display for SurfaceSectionId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}:{}", self.surface_id, self.index)
    }
}
