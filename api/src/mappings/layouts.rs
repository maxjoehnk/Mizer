use crate::models::layouts::*;
use protobuf::SingularPtrField;

impl From<mizer_layouts::Layout> for Layout {
    fn from(layout: mizer_layouts::Layout) -> Self {
        Layout {
            id: layout.id,
            controls: layout
                .controls
                .into_iter()
                .map(LayoutControl::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_layouts::ControlConfig> for LayoutControl {
    fn from(config: mizer_layouts::ControlConfig) -> Self {
        LayoutControl {
            node: config.node.0,
            label: config.label.unwrap_or_default(),
            position: SingularPtrField::some(config.position.into()),
            size: SingularPtrField::some(config.size.into()),
            ..Default::default()
        }
    }
}

impl From<mizer_layouts::ControlPosition> for ControlPosition {
    fn from(position: mizer_layouts::ControlPosition) -> Self {
        Self {
            x: position.x,
            y: position.y,
            ..Default::default()
        }
    }
}

impl From<ControlPosition> for mizer_layouts::ControlPosition {
    fn from(position: ControlPosition) -> Self {
        Self {
            x: position.x,
            y: position.y,
        }
    }
}

impl From<mizer_layouts::ControlSize> for ControlSize {
    fn from(size: mizer_layouts::ControlSize) -> Self {
        ControlSize {
            width: size.width,
            height: size.height,
            ..Default::default()
        }
    }
}
