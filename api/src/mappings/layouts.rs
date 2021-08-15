use crate::models::layouts::*;
use protobuf::SingularPtrField;

impl From<mizer_layouts::Layout> for Layout {
    fn from(layout: mizer_layouts::Layout) -> Self {
        Self {
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
        Self {
            node: config.node.0,
            label: config.label.unwrap_or_default(),
            position: SingularPtrField::some(config.position.into()),
            size: SingularPtrField::some(config.size.into()),
            decoration: SingularPtrField::some(config.decoration.into()),
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
        Self {
            width: size.width,
            height: size.height,
            ..Default::default()
        }
    }
}

impl From<ControlSize> for mizer_layouts::ControlSize {
    fn from(size: ControlSize) -> Self {
        Self {
            width: size.width,
            height: size.height,
        }
    }
}

impl From<mizer_layouts::ControlDecorations> for ControlDecorations {
    fn from(decorations: mizer_layouts::ControlDecorations) -> Self {
        Self {
            hasColor: decorations.color.is_some(),
            color: decorations.color.map(Color::from).into(),
            ..Default::default()
        }
    }
}

impl From<ControlDecorations> for mizer_layouts::ControlDecorations {
    fn from(decorations: ControlDecorations) -> Self {
        Self {
            color: decorations.hasColor.then(|| decorations.color.unwrap().into()),
        }
    }
}

impl From<mizer_node::Color> for Color {
    fn from(color: mizer_node::Color) -> Self {
        Self {
            red: to_float(color.red),
            green: to_float(color.green),
            blue: to_float(color.blue),
            ..Default::default()
        }
    }
}

impl From<Color> for mizer_node::Color {
    fn from(color: Color) -> Self {
        Self {
            red: from_float(color.red),
            green: from_float(color.green),
            blue: from_float(color.blue),
            alpha: u8::MAX,
        }
    }
}

fn to_float(color: u8) -> f64 {
    let color = color as f64;
    let max = u8::MAX as f64;

    color / max
}

fn from_float(color: f64) -> u8 {
    (color * u8::MAX as f64).min(255.).max(0.).floor() as u8
}
