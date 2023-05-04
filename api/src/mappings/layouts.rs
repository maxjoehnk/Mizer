use crate::models::layouts::*;
use mizer_layouts::Base64Image;
use protobuf::{EnumOrUnknown, MessageField};

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
            position: MessageField::some(config.position.into()),
            size: MessageField::some(config.size.into()),
            decoration: MessageField::some(config.decoration.into()),
            behavior: MessageField::some(config.behavior.into()),
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
            has_color: decorations.color.is_some(),
            color: decorations.color.map(Color::from).into(),
            has_image: decorations.image.is_some(),
            image: decorations
                .image
                .and_then(|img| img.try_to_buffer().ok())
                .unwrap_or_default(),
            ..Default::default()
        }
    }
}

impl From<ControlDecorations> for mizer_layouts::ControlDecorations {
    fn from(decorations: ControlDecorations) -> Self {
        Self {
            color: decorations
                .has_color
                .then(|| decorations.color.unwrap().into()),
            image: decorations
                .has_image
                .then(|| Base64Image::from_buffer(decorations.image)),
        }
    }
}

impl From<mizer_node::Color> for Color {
    fn from(color: mizer_node::Color) -> Self {
        Self {
            red: color.red,
            green: color.green,
            blue: color.blue,
            ..Default::default()
        }
    }
}

impl From<Color> for mizer_node::Color {
    fn from(color: Color) -> Self {
        Self::rgb(color.red, color.green, color.blue)
    }
}

impl From<mizer_layouts::ControlBehavior> for ControlBehavior {
    fn from(value: mizer_layouts::ControlBehavior) -> Self {
        Self {
            sequencer: MessageField::some(value.sequencer.into()),
            ..Default::default()
        }
    }
}

impl From<ControlBehavior> for mizer_layouts::ControlBehavior {
    fn from(value: ControlBehavior) -> Self {
        Self {
            sequencer: value.sequencer.into_option().unwrap().into(),
        }
    }
}

impl From<mizer_layouts::SequencerControlBehavior> for SequencerControlBehavior {
    fn from(value: mizer_layouts::SequencerControlBehavior) -> Self {
        Self {
            click_behavior: EnumOrUnknown::new(value.click_behavior.into()),
            ..Default::default()
        }
    }
}

impl From<SequencerControlBehavior> for mizer_layouts::SequencerControlBehavior {
    fn from(value: SequencerControlBehavior) -> Self {
        Self {
            click_behavior: value.click_behavior.unwrap().into(),
        }
    }
}

impl From<mizer_layouts::SequencerControlClickBehavior>
    for sequencer_control_behavior::ClickBehavior
{
    fn from(value: mizer_layouts::SequencerControlClickBehavior) -> Self {
        use mizer_layouts::SequencerControlClickBehavior::*;

        match value {
            GoForward => Self::GO_FORWARD,
            Toggle => Self::TOGGLE,
        }
    }
}

impl From<sequencer_control_behavior::ClickBehavior>
    for mizer_layouts::SequencerControlClickBehavior
{
    fn from(value: sequencer_control_behavior::ClickBehavior) -> Self {
        use sequencer_control_behavior::ClickBehavior::*;

        match value {
            GO_FORWARD => Self::GoForward,
            TOGGLE => Self::Toggle,
        }
    }
}
