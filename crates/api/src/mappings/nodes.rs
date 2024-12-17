use std::sync::Arc;

use mizer_node::{NodeLink, PortDirection, PortId, PortMetadata, PortType, PreviewType};
use mizer_nodes::MidiInputConfig;
use mizer_runtime::commands::StaticNodeDescriptor;

use crate::proto::nodes::node_setting::{spline_value, SplineValue};
use crate::proto::nodes::*;

impl From<MidiNodeConfig> for mizer_nodes::MidiInputNode {
    fn from(config: MidiNodeConfig) -> Self {
        Self {
            device: config.device,
            config: match config.binding {
                Some(midi_node_config::Binding::NoteBinding(binding)) => match binding.r#type() {
                    midi_node_config::note_binding::MidiType::Cc => MidiInputConfig::Note {
                        mode: mizer_nodes::NoteMode::CC,
                        channel: binding.channel as u8,
                        port: binding.port as u8,
                        range: (binding.range_from as u8, binding.range_to as u8),
                    },
                    midi_node_config::note_binding::MidiType::Note => MidiInputConfig::Note {
                        mode: mizer_nodes::NoteMode::Note,
                        channel: binding.channel as u8,
                        port: binding.port as u8,
                        range: (binding.range_from as u8, binding.range_to as u8),
                    },
                },
                Some(midi_node_config::Binding::ControlBinding(binding)) => {
                    MidiInputConfig::Control {
                        page: binding.page,
                        control: binding.control,
                    }
                }
                None => MidiInputConfig::default(),
            },
        }
    }
}

impl From<SplineValue> for mizer_util::Spline {
    fn from(config: SplineValue) -> Self {
        Self {
            steps: config
                .steps
                .into_iter()
                .map(mizer_util::SplineStep::from)
                .collect(),
        }
    }
}

impl From<spline_value::SplineStep> for mizer_util::SplineStep {
    fn from(step: spline_value::SplineStep) -> Self {
        Self {
            x: step.x,
            y: step.y,
            c0a: step.c0a,
            c0b: step.c0b,
            c1a: step.c1a,
            c1b: step.c1b,
        }
    }
}

impl From<mizer_util::Spline> for SplineValue {
    fn from(node: mizer_util::Spline) -> Self {
        Self {
            steps: node
                .steps
                .into_iter()
                .map(spline_value::SplineStep::from)
                .collect(),
        }
    }
}

impl From<mizer_util::SplineStep> for spline_value::SplineStep {
    fn from(step: mizer_util::SplineStep) -> Self {
        Self {
            x: step.x,
            y: step.y,
            c0a: step.c0a,
            c0b: step.c0b,
            c1a: step.c1a,
            c1b: step.c1b,
        }
    }
}

impl From<StaticNodeDescriptor> for Node {
    fn from(descriptor: StaticNodeDescriptor) -> Self {
        let mut node = Node {
            path: descriptor.path.to_string(),
            r#type: descriptor.node_type.get_name(),
            settings: descriptor
                .settings
                .into_iter()
                .map(NodeSetting::from)
                .collect(),
            children: vec![],
            designer: Some(descriptor.designer.into()),
            preview: node::NodePreviewType::from(descriptor.details.preview_type) as i32,
            details: Some(NodeDetails {
                node_type_name: descriptor.details.node_type_name,
                display_name: descriptor.metadata.display_name().to_string(),
                has_custom_name: descriptor.metadata.custom_name.is_some(),
                category: NodeCategory::from(descriptor.details.category) as i32,
            }),
            inputs: vec![],
            outputs: vec![],
        };
        let (inputs, outputs) = descriptor
            .ports
            .into_iter()
            .partition::<Vec<_>, _>(|(_, port)| matches!(port.direction, PortDirection::Input));

        for input in inputs {
            node.inputs.push(input.into());
        }
        for output in outputs {
            node.outputs.push(output.into());
        }

        tracing::debug!("{:?}", node);

        node
    }
}

impl From<mizer_node::NodeSetting> for NodeSetting {
    fn from(setting: mizer_node::NodeSetting) -> Self {
        Self {
            id: setting.id.into(),
            label: setting.label.map(|label| label.into()),
            category: setting.category.map(|category| category.into()),
            description: setting.description,
            disabled: setting.disabled,
            value: Some(setting.value.into()),
        }
    }
}

impl From<NodeSetting> for mizer_node::NodeSetting {
    fn from(setting: NodeSetting) -> Self {
        Self {
            id: setting.id.into(),
            label: setting.label.map(|label| label.into()),
            category: None,
            description: setting.description,
            disabled: setting.disabled,
            value: setting.value.unwrap().into(),
            optional: false,
        }
    }
}

impl From<mizer_node::NodeSettingValue> for node_setting::Value {
    fn from(value: mizer_node::NodeSettingValue) -> Self {
        use mizer_node::NodeSettingValue::*;

        match value {
            Text { value, multiline } => {
                Self::TextValue(node_setting::TextValue { value, multiline })
            }
            Float {
                value,
                min,
                min_hint,
                max,
                max_hint,
                step_size,
            } => Self::FloatValue(node_setting::FloatValue {
                value,
                min,
                min_hint,
                max,
                max_hint,
                step_size,
            }),
            Uint {
                value,
                min,
                min_hint,
                max,
                max_hint,
                step_size,
            } => Self::UintValue(node_setting::UintValue {
                value,
                min,
                min_hint,
                max,
                max_hint,
                step_size,
            }),
            Int {
                value,
                min,
                min_hint,
                max,
                max_hint,
                step_size,
            } => Self::IntValue(node_setting::IntValue {
                value: value as i32,
                min: min.map(|v| v as i32),
                min_hint: min_hint.map(|v| v as i32),
                max: max.map(|v| v as i32),
                max_hint: max_hint.map(|v| v as i32),
                step_size: step_size.map(|v| v as i32),
            }),
            Bool { value } => Self::BoolValue(node_setting::BoolValue { value }),
            Select { value, variants } => Self::SelectValue(node_setting::SelectValue {
                value,
                variants: variants
                    .into_iter()
                    .map(node_setting::SelectVariant::from)
                    .collect(),
            }),
            Enum { value, variants } => Self::EnumValue(node_setting::EnumValue {
                value: value as u32,
                variants: variants
                    .into_iter()
                    .map(node_setting::EnumVariant::from)
                    .collect(),
            }),
            Id { value, variants } => Self::IdValue(node_setting::IdValue {
                value,
                variants: variants
                    .into_iter()
                    .map(node_setting::IdVariant::from)
                    .collect(),
            }),
            Spline(spline) => Self::SplineValue(spline.into()),
            Steps(steps) => Self::StepSequencerValue(node_setting::StepSequencerValue { steps }),
            Media {
                value,
                content_types,
            } => Self::MediaValue(node_setting::MediaValue {
                value,
                allowed_types: content_types
                    .into_iter()
                    .map(crate::proto::media::MediaType::from)
                    .map(|variant| variant as i32)
                    .collect(),
            }),
        }
    }
}

impl From<node_setting::Value> for mizer_node::NodeSettingValue {
    fn from(value: node_setting::Value) -> Self {
        use node_setting::Value;

        match value {
            Value::TextValue(value) => Self::Text {
                value: value.value,
                multiline: value.multiline,
            },
            Value::FloatValue(value) => Self::Float {
                value: value.value,
                min: value.min,
                min_hint: value.min_hint,
                max: value.max,
                max_hint: value.max_hint,
                step_size: value.step_size,
            },
            Value::IntValue(value) => Self::Int {
                value: value.value as i64,
                min: value.min.map(|v| v as i64),
                min_hint: value.min_hint.map(|v| v as i64),
                max: value.max.map(|v| v as i64),
                max_hint: value.max_hint.map(|v| v as i64),
                step_size: value.step_size.map(|v| v as i64),
            },
            Value::UintValue(value) => Self::Uint {
                value: value.value,
                min: value.min,
                min_hint: value.min_hint,
                max: value.max,
                max_hint: value.max_hint,
                step_size: value.step_size,
            },
            Value::BoolValue(value) => Self::Bool { value: value.value },
            Value::SelectValue(value) => Self::Select {
                value: value.value,
                variants: value
                    .variants
                    .into_iter()
                    .map(mizer_node::SelectVariant::from)
                    .collect(),
            },
            Value::EnumValue(value) => Self::Enum {
                value: value.value as u8,
                variants: value
                    .variants
                    .into_iter()
                    .map(mizer_node::EnumVariant::from)
                    .collect(),
            },
            Value::IdValue(value) => Self::Id {
                value: value.value,
                variants: value
                    .variants
                    .into_iter()
                    .map(mizer_node::IdVariant::from)
                    .collect(),
            },
            Value::SplineValue(value) => Self::Spline(value.into()),
            Value::StepSequencerValue(value) => Self::Steps(value.steps),
            Value::MediaValue(value) => Self::Media {
                content_types: value
                    .allowed_types()
                    .into_iter()
                    .map(mizer_node::MediaContentType::from)
                    .collect(),
                value: value.value,
            },
        }
    }
}

impl From<mizer_node::EnumVariant> for node_setting::EnumVariant {
    fn from(variant: mizer_node::EnumVariant) -> Self {
        Self {
            value: variant.value as u32,
            label: variant.label,
        }
    }
}

impl From<node_setting::EnumVariant> for mizer_node::EnumVariant {
    fn from(variant: node_setting::EnumVariant) -> Self {
        Self {
            value: variant.value as u8,
            label: variant.label,
        }
    }
}

impl From<mizer_node::IdVariant> for node_setting::IdVariant {
    fn from(variant: mizer_node::IdVariant) -> Self {
        Self {
            value: variant.value,
            label: variant.label,
        }
    }
}

impl From<node_setting::IdVariant> for mizer_node::IdVariant {
    fn from(variant: node_setting::IdVariant) -> Self {
        Self {
            value: variant.value,
            label: variant.label,
        }
    }
}

impl From<mizer_node::SelectVariant> for node_setting::SelectVariant {
    fn from(variant: mizer_node::SelectVariant) -> Self {
        match variant {
            mizer_node::SelectVariant::Item { value, label } => Self {
                variant: Some(node_setting::select_variant::Variant::Item(
                    node_setting::select_variant::SelectItem {
                        label: label.to_string(),
                        value: value.to_string(),
                    },
                )),
            },
            mizer_node::SelectVariant::Group { children, label } => Self {
                variant: Some(node_setting::select_variant::Variant::Group(
                    node_setting::select_variant::SelectGroup {
                        label: label.to_string(),
                        items: children
                            .into_iter()
                            .map(node_setting::SelectVariant::from)
                            .collect(),
                    },
                )),
            },
        }
    }
}

impl From<node_setting::SelectVariant> for mizer_node::SelectVariant {
    fn from(variant: node_setting::SelectVariant) -> Self {
        match variant.variant.unwrap() {
            node_setting::select_variant::Variant::Item(
                node_setting::select_variant::SelectItem { value, label, .. },
            ) => Self::Item {
                label: Arc::new(label),
                value: Arc::new(value),
            },
            node_setting::select_variant::Variant::Group(
                node_setting::select_variant::SelectGroup { items, label, .. },
            ) => Self::Group {
                label: Arc::new(label),
                children: items.into_iter().map(Self::from).collect(),
            },
        }
    }
}

impl From<mizer_node::MediaContentType> for crate::proto::media::MediaType {
    fn from(value: mizer_node::MediaContentType) -> Self {
        match value {
            mizer_node::MediaContentType::Audio => Self::Audio,
            mizer_node::MediaContentType::Image => Self::Image,
            mizer_node::MediaContentType::Video => Self::Video,
            mizer_node::MediaContentType::Vector => Self::Vector,
            mizer_node::MediaContentType::Data => Self::Data,
        }
    }
}

impl From<crate::proto::media::MediaType> for mizer_node::MediaContentType {
    fn from(value: crate::proto::media::MediaType) -> Self {
        match value {
            crate::proto::media::MediaType::Audio => Self::Audio,
            crate::proto::media::MediaType::Image => Self::Image,
            crate::proto::media::MediaType::Video => Self::Video,
            crate::proto::media::MediaType::Vector => Self::Vector,
            crate::proto::media::MediaType::Data => Self::Data,
        }
    }
}

impl From<mizer_node::NodeDesigner> for NodeDesigner {
    fn from(designer: mizer_node::NodeDesigner) -> Self {
        Self {
            scale: designer.scale,
            position: Some(NodePosition {
                x: designer.position.x,
                y: designer.position.y,
            }),
            hidden: designer.hidden,
            color: designer.color.map(|c| c as u8).map(|c| c as i32),
        }
    }
}

impl From<NodeDesigner> for mizer_node::NodeDesigner {
    fn from(designer: NodeDesigner) -> Self {
        Self {
            scale: designer.scale,
            position: designer.position.unwrap().into(),
            hidden: designer.hidden,
            color: designer
                .color
                .and_then(|color| (color as u8).try_into().ok()),
        }
    }
}

impl From<NodePosition> for mizer_node::NodePosition {
    fn from(position: NodePosition) -> Self {
        Self {
            x: position.x,
            y: position.y,
        }
    }
}
impl From<PortType> for ChannelProtocol {
    fn from(port: PortType) -> Self {
        match port {
            PortType::Single => ChannelProtocol::Single,
            PortType::Multi => ChannelProtocol::Multi,
            PortType::Color => ChannelProtocol::Color,
            PortType::Texture => ChannelProtocol::Texture,
            PortType::Vector => ChannelProtocol::Vector,
            PortType::Laser => ChannelProtocol::Laser,
            PortType::Poly => ChannelProtocol::Poly,
            PortType::Data => ChannelProtocol::Data,
            PortType::Text => ChannelProtocol::Text,
            PortType::Material => ChannelProtocol::Material,
            PortType::Clock => ChannelProtocol::Clock,
        }
    }
}

impl From<ChannelProtocol> for PortType {
    fn from(port: ChannelProtocol) -> Self {
        match port {
            ChannelProtocol::Single => PortType::Single,
            ChannelProtocol::Multi => PortType::Multi,
            ChannelProtocol::Color => PortType::Color,
            ChannelProtocol::Texture => PortType::Texture,
            ChannelProtocol::Vector => PortType::Vector,
            ChannelProtocol::Laser => PortType::Laser,
            ChannelProtocol::Poly => PortType::Poly,
            ChannelProtocol::Data => PortType::Data,
            ChannelProtocol::Text => PortType::Text,
            ChannelProtocol::Material => PortType::Material,
            ChannelProtocol::Clock => PortType::Clock,
        }
    }
}

impl From<(PortId, PortMetadata)> for Port {
    fn from((id, metadata): (PortId, PortMetadata)) -> Self {
        Port {
            name: id.to_string(),
            protocol: ChannelProtocol::from(metadata.port_type) as i32,
            multiple: metadata.multiple.unwrap_or_default(),
        }
    }
}

impl From<NodeConnection> for NodeLink {
    fn from(connection: NodeConnection) -> Self {
        NodeLink {
            port_type: connection.protocol().into(),
            source: connection.source_node.into(),
            source_port: connection.source_port.unwrap().name.into(),
            target: connection.target_node.into(),
            target_port: connection.target_port.unwrap().name.into(),
            local: true,
        }
    }
}

impl From<PreviewType> for node::NodePreviewType {
    fn from(preview: PreviewType) -> Self {
        match preview {
            PreviewType::History => node::NodePreviewType::History,
            PreviewType::Waveform => node::NodePreviewType::Waveform,
            PreviewType::Multiple => node::NodePreviewType::Multiple,
            PreviewType::Texture => node::NodePreviewType::Texture,
            PreviewType::Timecode => node::NodePreviewType::Timecode,
            PreviewType::Data => node::NodePreviewType::Data,
            PreviewType::Color => node::NodePreviewType::Color,
            PreviewType::None => node::NodePreviewType::None,
        }
    }
}

impl From<mizer_node::NodeCategory> for NodeCategory {
    fn from(category: mizer_node::NodeCategory) -> Self {
        use mizer_node::NodeCategory::*;

        match category {
            None => Self::None,
            Standard => Self::Standard,
            Connections => Self::Connections,
            Conversions => Self::Conversions,
            Controls => Self::Controls,
            Data => Self::Data,
            Color => Self::Color,
            Audio => Self::Audio,
            Video => Self::Video,
            Laser => Self::Laser,
            Pixel => Self::Pixel,
            Vector => Self::Vector,
            Fixtures => Self::Fixtures,
            Ui => Self::Ui,
        }
    }
}

impl From<mizer_node::NodeCommentArea> for NodeCommentArea {
    fn from(comment_area: mizer_node::NodeCommentArea) -> Self {
        Self {
            id: comment_area.id.to_string(),
            parent: comment_area.parent.map(|path| path.to_string()),
            designer: Some(comment_area.designer.into()),
            width: comment_area.width,
            height: comment_area.height,
            label: comment_area.label,
            show_background: comment_area.show_background,
            show_border: comment_area.show_border,
        }
    }
}
