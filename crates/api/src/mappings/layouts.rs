use mizer_util::Base64Image;

use crate::proto::layouts::*;

impl From<mizer_layouts::Layout> for Layout {
    fn from(layout: mizer_layouts::Layout) -> Self {
        Self {
            id: layout.id,
            controls: layout
                .controls
                .into_iter()
                .map(LayoutControl::from)
                .collect(),
        }
    }
}

impl From<mizer_layouts::ControlConfig> for LayoutControl {
    fn from(config: mizer_layouts::ControlConfig) -> Self {
        Self {
            id: config.id.to_string(),
            control_type: Some(config.control_type.into()),
            label: config.label.unwrap_or_default(),
            position: Some(config.position.into()),
            size: Some(config.size.into()),
            decoration: Some(config.decoration.into()),
            behavior: Some(config.behavior.into()),
        }
    }
}

impl From<mizer_layouts::ControlType> for layout_control::ControlType {
    fn from(value: mizer_layouts::ControlType) -> Self {
        use mizer_layouts::ControlType::*;

        match value {
            Group { group_id } => Self::Group(layout_control::GroupControlType {
                group_id: group_id.into(),
            }),
            Node { path: node } => {
                Self::Node(layout_control::NodeControlType { path: node.into() })
            }
            Preset { preset_id } => Self::Preset(layout_control::PresetControlType {
                preset_id: Some(preset_id.into()),
            }),
            Sequencer { sequence_id } => {
                Self::Sequencer(layout_control::SequencerControlType { sequence_id })
            }
        }
    }
}

impl From<mizer_layouts::ControlPosition> for ControlPosition {
    fn from(position: mizer_layouts::ControlPosition) -> Self {
        Self {
            x: position.x,
            y: position.y,
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
            sequencer: Some(value.sequencer.into()),
        }
    }
}

impl From<ControlBehavior> for mizer_layouts::ControlBehavior {
    fn from(value: ControlBehavior) -> Self {
        Self {
            sequencer: value.sequencer.unwrap().into(),
        }
    }
}

impl From<mizer_layouts::SequencerControlBehavior> for SequencerControlBehavior {
    fn from(value: mizer_layouts::SequencerControlBehavior) -> Self {
        Self {
            click_behavior: sequencer_control_behavior::ClickBehavior::from(value.click_behavior)
                as i32,
        }
    }
}

impl From<SequencerControlBehavior> for mizer_layouts::SequencerControlBehavior {
    fn from(value: SequencerControlBehavior) -> Self {
        Self {
            click_behavior: value.click_behavior().into(),
        }
    }
}

impl From<mizer_layouts::SequencerControlClickBehavior>
    for sequencer_control_behavior::ClickBehavior
{
    fn from(value: mizer_layouts::SequencerControlClickBehavior) -> Self {
        use mizer_layouts::SequencerControlClickBehavior::*;

        match value {
            GoForward => Self::GoForward,
            Toggle => Self::Toggle,
        }
    }
}

impl From<sequencer_control_behavior::ClickBehavior>
    for mizer_layouts::SequencerControlClickBehavior
{
    fn from(value: sequencer_control_behavior::ClickBehavior) -> Self {
        use sequencer_control_behavior::ClickBehavior::*;

        match value {
            GoForward => Self::GoForward,
            Toggle => Self::Toggle,
        }
    }
}

impl From<ControlType> for mizer_node::NodeType {
    fn from(value: ControlType) -> Self {
        match value {
            ControlType::Button => Self::Button,
            ControlType::Fader => Self::Fader,
            ControlType::Label => Self::Label,
        }
    }
}
