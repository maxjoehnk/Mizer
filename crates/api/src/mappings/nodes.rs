use std::sync::Arc;

use mizer_node::{NodeLink, NodeType, PortDirection, PortId, PortMetadata, PortType, PreviewType};
use mizer_nodes::{MidiInputConfig, NodeDowncast};
use mizer_runtime::commands::StaticNodeDescriptor;
use mizer_runtime::NodeDescriptor;

use crate::proto::nodes::node_setting::{spline_value, SplineValue};
use crate::proto::nodes::*;

impl TryFrom<mizer_nodes::Node> for node_config::Type {
    type Error = ();

    fn try_from(node: mizer_nodes::Node) -> Result<Self, Self::Error> {
        use mizer_nodes::Node::*;
        match node {
            Container(node) => Ok(Self::ContainerConfig(node.into())),
            _ => Err(()),
        }
    }
}

impl From<node_config::Type> for mizer_nodes::Node {
    fn from(node_config: node_config::Type) -> Self {
        match node_config {
            node_config::Type::ContainerConfig(node) => Self::Container(node.into()),
        }
    }
}

impl From<mizer_nodes::Node> for NodeConfig {
    fn from(node: mizer_nodes::Node) -> Self {
        let config: Option<node_config::Type> = node.try_into().ok();
        NodeConfig {
            r#type: config,
            ..Default::default()
        }
    }
}

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

impl From<mizer_nodes::ContainerNode> for ContainerNodeConfig {
    fn from(_: mizer_nodes::ContainerNode) -> Self {
        // This is just a fallback to avoid crashing when
        Default::default()
    }
}

impl From<ContainerNodeConfig> for mizer_nodes::ContainerNode {
    fn from(config: ContainerNodeConfig) -> Self {
        Self {
            nodes: config
                .nodes
                .into_iter()
                .map(|node| node.path.into())
                .collect(),
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
            ..Default::default()
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
            ..Default::default()
        }
    }
}

impl From<NodeType> for node::NodeType {
    fn from(node: NodeType) -> Self {
        match node {
            NodeType::Fader => node::NodeType::Fader,
            NodeType::Button => node::NodeType::Button,
            NodeType::Label => node::NodeType::Label,
            NodeType::DmxOutput => node::NodeType::DmxOutput,
            NodeType::DmxInput => node::NodeType::DmxInput,
            NodeType::Oscillator => node::NodeType::Oscillator,
            NodeType::Clock => node::NodeType::Clock,
            NodeType::OscInput => node::NodeType::OscInput,
            NodeType::OscOutput => node::NodeType::OscOutput,
            NodeType::VideoFile => node::NodeType::VideoFile,
            NodeType::VideoOutput => node::NodeType::VideoOutput,
            NodeType::VideoHsv => node::NodeType::VideoHsv,
            NodeType::VideoTransform => node::NodeType::VideoTransform,
            NodeType::VideoMixer => node::NodeType::VideoMixer,
            NodeType::VideoRgb => node::NodeType::VideoRgb,
            NodeType::VideoRgbSplit => node::NodeType::VideoRgbSplit,
            NodeType::Scripting => node::NodeType::Script,
            NodeType::PixelDmx => node::NodeType::PixelToDmx,
            NodeType::PixelPattern => node::NodeType::PixelPattern,
            NodeType::OpcOutput => node::NodeType::OpcOutput,
            NodeType::Fixture => node::NodeType::Fixture,
            NodeType::Programmer => node::NodeType::Programmer,
            NodeType::Group => node::NodeType::Group,
            NodeType::Preset => node::NodeType::Preset,
            NodeType::Sequencer => node::NodeType::Sequencer,
            NodeType::StepSequencer => node::NodeType::StepSequencer,
            NodeType::Envelope => node::NodeType::Envelope,
            NodeType::Select => node::NodeType::Select,
            NodeType::Merge => node::NodeType::Merge,
            NodeType::Threshold => node::NodeType::Threshold,
            NodeType::Encoder => node::NodeType::Encoder,
            NodeType::MidiInput => node::NodeType::MidiInput,
            NodeType::MidiOutput => node::NodeType::MidiOutput,
            NodeType::Laser => node::NodeType::Laser,
            NodeType::IldaFile => node::NodeType::IldaFile,
            NodeType::ColorConstant => node::NodeType::ColorConstant,
            NodeType::ColorBrightness => node::NodeType::ColorBrightness,
            NodeType::ColorHsv => node::NodeType::ColorHsv,
            NodeType::ColorRgb => node::NodeType::ColorRgb,
            NodeType::Gamepad => node::NodeType::Gamepad,
            NodeType::Container => node::NodeType::Container,
            NodeType::Math => node::NodeType::Math,
            NodeType::MqttInput => node::NodeType::MqttInput,
            NodeType::MqttOutput => node::NodeType::MqttOutput,
            NodeType::NumberToData => node::NodeType::NumberToData,
            NodeType::DataToNumber => node::NodeType::DataToNumber,
            NodeType::Value => node::NodeType::Value,
            NodeType::Extract => node::NodeType::Extract,
            NodeType::PlanScreen => node::NodeType::PlanScreen,
            NodeType::Delay => node::NodeType::Delay,
            NodeType::Ramp => node::NodeType::Ramp,
            NodeType::Noise => node::NodeType::Noise,
            NodeType::Transport => node::NodeType::Transport,
            NodeType::G13Input => node::NodeType::G13input,
            NodeType::G13Output => node::NodeType::G13output,
            NodeType::ConstantNumber => node::NodeType::ConstantNumber,
            NodeType::Conditional => node::NodeType::Conditional,
            NodeType::TimecodeControl => node::NodeType::TimecodeControl,
            NodeType::TimecodeOutput => node::NodeType::TimecodeOutput,
            NodeType::AudioFile => node::NodeType::AudioFile,
            NodeType::AudioOutput => node::NodeType::AudioOutput,
            NodeType::AudioVolume => node::NodeType::AudioVolume,
            NodeType::AudioInput => node::NodeType::AudioInput,
            NodeType::AudioMix => node::NodeType::AudioMix,
            NodeType::AudioMeter => node::NodeType::AudioMeter,
            NodeType::Template => node::NodeType::Template,
            NodeType::Webcam => node::NodeType::Webcam,
            NodeType::ScreenCapture => node::NodeType::ScreenCapture,
            NodeType::TextureBorder => node::NodeType::TextureBorder,
            NodeType::VideoText => node::NodeType::VideoText,
            NodeType::Beats => node::NodeType::Beats,
            NodeType::ProDjLinkClock => node::NodeType::ProDjLinkClock,
            NodeType::PioneerCdj => node::NodeType::PioneerCdj,
            NodeType::NdiOutput => node::NodeType::NdiOutput,
            NodeType::TestSink => unimplemented!("only for test"),
        }
    }
}

impl From<node::NodeType> for NodeType {
    fn from(node: node::NodeType) -> Self {
        match node {
            node::NodeType::Fader => NodeType::Fader,
            node::NodeType::Button => NodeType::Button,
            node::NodeType::Label => NodeType::Label,
            node::NodeType::DmxOutput => NodeType::DmxOutput,
            node::NodeType::DmxInput => NodeType::DmxInput,
            node::NodeType::Oscillator => NodeType::Oscillator,
            node::NodeType::Clock => NodeType::Clock,
            node::NodeType::OscInput => NodeType::OscInput,
            node::NodeType::OscOutput => NodeType::OscOutput,
            node::NodeType::VideoFile => NodeType::VideoFile,
            node::NodeType::VideoOutput => NodeType::VideoOutput,
            node::NodeType::VideoHsv => NodeType::VideoHsv,
            node::NodeType::VideoTransform => NodeType::VideoTransform,
            node::NodeType::VideoMixer => NodeType::VideoMixer,
            node::NodeType::VideoRgb => NodeType::VideoRgb,
            node::NodeType::VideoRgbSplit => NodeType::VideoRgbSplit,
            node::NodeType::Script => NodeType::Scripting,
            node::NodeType::PixelToDmx => NodeType::PixelDmx,
            node::NodeType::PixelPattern => NodeType::PixelPattern,
            node::NodeType::OpcOutput => NodeType::OpcOutput,
            node::NodeType::Fixture => NodeType::Fixture,
            node::NodeType::Programmer => NodeType::Programmer,
            node::NodeType::Group => NodeType::Group,
            node::NodeType::Preset => NodeType::Preset,
            node::NodeType::Sequencer => NodeType::Sequencer,
            node::NodeType::StepSequencer => NodeType::StepSequencer,
            node::NodeType::Envelope => NodeType::Envelope,
            node::NodeType::Select => NodeType::Select,
            node::NodeType::Merge => NodeType::Merge,
            node::NodeType::Threshold => NodeType::Threshold,
            node::NodeType::Encoder => NodeType::Encoder,
            node::NodeType::MidiInput => NodeType::MidiInput,
            node::NodeType::MidiOutput => NodeType::MidiOutput,
            node::NodeType::Laser => NodeType::Laser,
            node::NodeType::IldaFile => NodeType::IldaFile,
            node::NodeType::ColorConstant => NodeType::ColorConstant,
            node::NodeType::ColorBrightness => NodeType::ColorBrightness,
            node::NodeType::ColorHsv => NodeType::ColorHsv,
            node::NodeType::ColorRgb => NodeType::ColorRgb,
            node::NodeType::Gamepad => NodeType::Gamepad,
            node::NodeType::Container => NodeType::Container,
            node::NodeType::Math => NodeType::Math,
            node::NodeType::MqttInput => NodeType::MqttInput,
            node::NodeType::MqttOutput => NodeType::MqttOutput,
            node::NodeType::NumberToData => NodeType::NumberToData,
            node::NodeType::DataToNumber => NodeType::DataToNumber,
            node::NodeType::Value => NodeType::Value,
            node::NodeType::Extract => NodeType::Extract,
            node::NodeType::PlanScreen => NodeType::PlanScreen,
            node::NodeType::Delay => NodeType::Delay,
            node::NodeType::Ramp => NodeType::Ramp,
            node::NodeType::Noise => NodeType::Noise,
            node::NodeType::Transport => NodeType::Transport,
            node::NodeType::G13input => NodeType::G13Input,
            node::NodeType::G13output => NodeType::G13Output,
            node::NodeType::ConstantNumber => NodeType::ConstantNumber,
            node::NodeType::Conditional => NodeType::Conditional,
            node::NodeType::TimecodeControl => NodeType::TimecodeControl,
            node::NodeType::TimecodeOutput => NodeType::TimecodeOutput,
            node::NodeType::AudioFile => NodeType::AudioFile,
            node::NodeType::AudioOutput => NodeType::AudioOutput,
            node::NodeType::AudioVolume => NodeType::AudioVolume,
            node::NodeType::AudioInput => NodeType::AudioInput,
            node::NodeType::AudioMix => NodeType::AudioMix,
            node::NodeType::AudioMeter => NodeType::AudioMeter,
            node::NodeType::Template => NodeType::Template,
            node::NodeType::Webcam => NodeType::Webcam,
            node::NodeType::ScreenCapture => NodeType::ScreenCapture,
            node::NodeType::TextureBorder => NodeType::TextureBorder,
            node::NodeType::VideoText => NodeType::VideoText,
            node::NodeType::Beats => NodeType::Beats,
            node::NodeType::ProDjLinkClock => NodeType::ProDjLinkClock,
            node::NodeType::PioneerCdj => NodeType::PioneerCdj,
            node::NodeType::NdiOutput => NodeType::NdiOutput,
        }
    }
}

impl From<NodeDescriptor<'_>> for Node {
    fn from(descriptor: NodeDescriptor<'_>) -> Self {
        let config = descriptor.downcast().into();
        map_node_descriptor_with_config(descriptor, config)
    }
}

pub fn map_node_descriptor_with_config(descriptor: NodeDescriptor<'_>, config: NodeConfig) -> Node {
    let details = descriptor.node.value().details();
    let node_type = descriptor.node_type();
    let mut node = Node {
        path: descriptor.path.to_string(),
        r#type: node::NodeType::from(node_type) as i32,
        settings: descriptor
            .settings
            .into_iter()
            .map(NodeSetting::from)
            .collect(),
        config: Some(config),
        designer: Some(descriptor.designer.into()),
        preview: node::NodePreviewType::from(details.preview_type) as i32,
        details: Some(NodeDetails {
            name: details.name,
            category: NodeCategory::from(details.category) as i32,
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

    log::debug!("{:?}", node);

    node
}

impl From<StaticNodeDescriptor> for Node {
    fn from(descriptor: StaticNodeDescriptor) -> Self {
        let mut node = Node {
            path: descriptor.path.to_string(),
            r#type: node::NodeType::from(descriptor.node_type) as i32,
            settings: descriptor
                .settings
                .into_iter()
                .map(NodeSetting::from)
                .collect(),
            config: descriptor.config.try_into().ok().into(),
            designer: Some(descriptor.designer.into()),
            preview: node::NodePreviewType::from(descriptor.details.preview_type) as i32,
            details: Some(NodeDetails {
                name: descriptor.details.name,
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

        log::debug!("{:?}", node);

        node
    }
}

impl From<mizer_node::NodeSetting> for NodeSetting {
    fn from(setting: mizer_node::NodeSetting) -> Self {
        Self {
            label: setting.label.into(),
            description: setting.description,
            disabled: setting.disabled,
            value: Some(setting.value.into()),
            ..Default::default()
        }
    }
}

impl From<NodeSetting> for mizer_node::NodeSetting {
    fn from(setting: NodeSetting) -> Self {
        Self {
            label: setting.label.into(),
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
            Text { value, multiline } => Self::Text(node_setting::TextValue {
                value,
                multiline,
                ..Default::default()
            }),
            Float {
                value,
                min,
                min_hint,
                max,
                max_hint,
            } => Self::Float(node_setting::FloatValue {
                value,
                min,
                min_hint,
                max,
                max_hint,
                ..Default::default()
            }),
            Uint {
                value,
                min,
                min_hint,
                max,
                max_hint,
            } => Self::Uint(node_setting::UintValue {
                value,
                min,
                min_hint,
                max,
                max_hint,
                ..Default::default()
            }),
            Int {
                value,
                min,
                min_hint,
                max,
                max_hint,
            } => Self::Int(node_setting::IntValue {
                value: value as i32,
                min: min.map(|v| v as i32),
                min_hint: min_hint.map(|v| v as i32),
                max: max.map(|v| v as i32),
                max_hint: max_hint.map(|v| v as i32),
                ..Default::default()
            }),
            Bool { value } => Self::Bool(node_setting::BoolValue {
                value,
                ..Default::default()
            }),
            Select { value, variants } => Self::Select(node_setting::SelectValue {
                value,
                variants: variants
                    .into_iter()
                    .map(node_setting::SelectVariant::from)
                    .collect(),
                ..Default::default()
            }),
            Enum { value, variants } => Self::Enum(node_setting::EnumValue {
                value: value as u32,
                variants: variants
                    .into_iter()
                    .map(node_setting::EnumVariant::from)
                    .collect(),
                ..Default::default()
            }),
            Id { value, variants } => Self::Id(node_setting::IdValue {
                value,
                variants: variants
                    .into_iter()
                    .map(node_setting::IdVariant::from)
                    .collect(),
                ..Default::default()
            }),
            Spline(spline) => Self::Spline(spline.into()),
            Steps(steps) => Self::StepSequencer(node_setting::StepSequencerValue {
                steps,
                ..Default::default()
            }),
            Media {
                value,
                content_types,
            } => Self::Media(node_setting::MediaValue {
                value,
                allowed_types: content_types
                    .into_iter()
                    .map(crate::proto::media::MediaType::from)
                    .map(|variant| variant as i32)
                    .collect(),
                ..Default::default()
            }),
        }
    }
}

impl From<node_setting::Value> for mizer_node::NodeSettingValue {
    fn from(value: node_setting::Value) -> Self {
        use node_setting::Value::*;

        match value {
            Text(value) => Self::Text {
                value: value.value,
                multiline: value.multiline,
            },
            Float(value) => Self::Float {
                value: value.value,
                min: value.min,
                min_hint: value.min_hint,
                max: value.max,
                max_hint: value.max_hint,
            },
            Int(value) => Self::Int {
                value: value.value as i64,
                min: value.min.map(|v| v as i64),
                min_hint: value.min_hint.map(|v| v as i64),
                max: value.max.map(|v| v as i64),
                max_hint: value.max_hint.map(|v| v as i64),
            },
            Uint(value) => Self::Uint {
                value: value.value,
                min: value.min,
                min_hint: value.min_hint,
                max: value.max,
                max_hint: value.max_hint,
            },
            Bool(value) => Self::Bool { value: value.value },
            Select(value) => Self::Select {
                value: value.value,
                variants: value
                    .variants
                    .into_iter()
                    .map(mizer_node::SelectVariant::from)
                    .collect(),
            },
            Enum(value) => Self::Enum {
                value: value.value as u8,
                variants: value
                    .variants
                    .into_iter()
                    .map(mizer_node::EnumVariant::from)
                    .collect(),
            },
            Id(value) => Self::Id {
                value: value.value,
                variants: value
                    .variants
                    .into_iter()
                    .map(mizer_node::IdVariant::from)
                    .collect(),
            },
            Spline(value) => Self::Spline(value.into()),
            StepSequencer(value) => Self::Steps(value.steps),
            Media(value) => Self::Media {
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
            ..Default::default()
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
            ..Default::default()
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
                        ..Default::default()
                    },
                )),
                ..Default::default()
            },
            mizer_node::SelectVariant::Group { children, label } => Self {
                variant: Some(node_setting::select_variant::Variant::Group(
                    node_setting::select_variant::SelectGroup {
                        label: label.to_string(),
                        items: children
                            .into_iter()
                            .map(node_setting::SelectVariant::from)
                            .collect(),
                        ..Default::default()
                    },
                )),
                ..Default::default()
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
        }
    }
}

impl From<NodeDesigner> for mizer_node::NodeDesigner {
    fn from(designer: NodeDesigner) -> Self {
        Self {
            scale: designer.scale,
            position: designer.position.unwrap().into(),
            hidden: designer.hidden,
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
        }
    }
}
