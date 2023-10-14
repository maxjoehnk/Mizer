use crate::proto::surfaces::*;

impl From<mizer_surfaces::Surface> for Surface {
    fn from(surface: mizer_surfaces::Surface) -> Self {
        Self {
            id: surface.id.to_string(),
            name: surface.name,
            sections: surface.sections.into_iter().map(Into::into).collect(),
        }
    }
}

impl From<mizer_surfaces::SurfaceSection> for SurfaceSection {
    fn from(value: mizer_surfaces::SurfaceSection) -> Self {
        Self {
            id: value.id.index as u32,
            name: value.name,
            input: Some(value.input.into()),
            output: Some(value.output.into()),
        }
    }
}

impl From<mizer_surfaces::SurfaceTransform> for SurfaceTransform {
    fn from(value: mizer_surfaces::SurfaceTransform) -> Self {
        Self {
            top_left: Some(value.top_left.into()),
            top_right: Some(value.top_right.into()),
            bottom_left: Some(value.bottom_left.into()),
            bottom_right: Some(value.bottom_right.into()),
        }
    }
}

impl From<mizer_surfaces::SurfaceTransformPoint> for SurfaceTransformPoint {
    fn from(value: mizer_surfaces::SurfaceTransformPoint) -> Self {
        Self {
            x: value.x,
            y: value.y,
        }
    }
}

impl From<SurfaceTransform> for mizer_surfaces::SurfaceTransform {
    fn from(value: SurfaceTransform) -> Self {
        Self {
            top_left: value.top_left.unwrap().into(),
            top_right: value.top_right.unwrap().into(),
            bottom_left: value.bottom_left.unwrap().into(),
            bottom_right: value.bottom_right.unwrap().into(),
        }
    }
}

impl From<SurfaceTransformPoint> for mizer_surfaces::SurfaceTransformPoint {
    fn from(value: SurfaceTransformPoint) -> Self {
        Self {
            x: value.x,
            y: value.y,
        }
    }
}
