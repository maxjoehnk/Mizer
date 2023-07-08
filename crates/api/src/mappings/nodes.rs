use mizer_node::{NodeLink, NodeType, PortDirection, PortId, PortMetadata, PortType, PreviewType};
use mizer_nodes::{MidiInputConfig, NodeDowncast};
use mizer_runtime::commands::StaticNodeDescriptor;
use mizer_runtime::NodeDescriptor;
use protobuf::{EnumOrUnknown, MessageField};

use crate::models::nodes::node_setting::{spline_value, SplineValue};
use crate::models::nodes::*;

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
            type_: config,
            ..Default::default()
        }
    }
}

impl From<MidiNodeConfig> for mizer_nodes::MidiInputNode {
    fn from(config: MidiNodeConfig) -> Self {
        Self {
            device: config.device,
            config: match config.binding {
                Some(midi_node_config::Binding::NoteBinding(binding)) => {
                    match binding.type_.unwrap() {
                        midi_node_config::note_binding::MidiType::CC => MidiInputConfig::Note {
                            mode: mizer_nodes::NoteMode::CC,
                            channel: binding.channel as u8,
                            port: binding.port as u8,
                            range: (binding.range_from as u8, binding.range_to as u8),
                        },
                        midi_node_config::note_binding::MidiType::NOTE => MidiInputConfig::Note {
                            mode: mizer_nodes::NoteMode::Note,
                            channel: binding.channel as u8,
                            port: binding.port as u8,
                            range: (binding.range_from as u8, binding.range_to as u8),
                        },
                    }
                }
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
            NodeType::Fader => node::NodeType::FADER,
            NodeType::Button => node::NodeType::BUTTON,
            NodeType::Label => node::NodeType::LABEL,
            NodeType::DmxOutput => node::NodeType::DMX_OUTPUT,
            NodeType::Oscillator => node::NodeType::OSCILLATOR,
            NodeType::Clock => node::NodeType::CLOCK,
            NodeType::OscInput => node::NodeType::OSC_INPUT,
            NodeType::OscOutput => node::NodeType::OSC_OUTPUT,
            NodeType::VideoFile => node::NodeType::VIDEO_FILE,
            NodeType::VideoOutput => node::NodeType::VIDEO_OUTPUT,
            NodeType::VideoHsv => node::NodeType::VIDEO_HSV,
            NodeType::VideoTransform => node::NodeType::VIDEO_TRANSFORM,
            NodeType::VideoMixer => node::NodeType::VIDEO_MIXER,
            NodeType::VideoRgb => node::NodeType::VIDEO_RGB,
            NodeType::VideoRgbSplit => node::NodeType::VIDEO_RGB_SPLIT,
            NodeType::Scripting => node::NodeType::SCRIPT,
            NodeType::PixelDmx => node::NodeType::PIXEL_TO_DMX,
            NodeType::PixelPattern => node::NodeType::PIXEL_PATTERN,
            NodeType::OpcOutput => node::NodeType::OPC_OUTPUT,
            NodeType::Fixture => node::NodeType::FIXTURE,
            NodeType::Programmer => node::NodeType::PROGRAMMER,
            NodeType::Group => node::NodeType::GROUP,
            NodeType::Preset => node::NodeType::PRESET,
            NodeType::Sequencer => node::NodeType::SEQUENCER,
            NodeType::Sequence => node::NodeType::SEQUENCE,
            NodeType::Envelope => node::NodeType::ENVELOPE,
            NodeType::Select => node::NodeType::SELECT,
            NodeType::Merge => node::NodeType::MERGE,
            NodeType::Threshold => node::NodeType::THRESHOLD,
            NodeType::Encoder => node::NodeType::ENCODER,
            NodeType::MidiInput => node::NodeType::MIDI_INPUT,
            NodeType::MidiOutput => node::NodeType::MIDI_OUTPUT,
            NodeType::Laser => node::NodeType::LASER,
            NodeType::IldaFile => node::NodeType::ILDA_FILE,
            NodeType::ColorConstant => node::NodeType::COLOR_CONSTANT,
            NodeType::ColorBrightness => node::NodeType::COLOR_BRIGHTNESS,
            NodeType::ColorHsv => node::NodeType::COLOR_HSV,
            NodeType::ColorRgb => node::NodeType::COLOR_RGB,
            NodeType::Gamepad => node::NodeType::GAMEPAD,
            NodeType::Container => node::NodeType::CONTAINER,
            NodeType::Math => node::NodeType::MATH,
            NodeType::MqttInput => node::NodeType::MQTT_INPUT,
            NodeType::MqttOutput => node::NodeType::MQTT_OUTPUT,
            NodeType::NumberToData => node::NodeType::NUMBER_TO_DATA,
            NodeType::DataToNumber => node::NodeType::DATA_TO_NUMBER,
            NodeType::Value => node::NodeType::VALUE,
            NodeType::Extract => node::NodeType::EXTRACT,
            NodeType::PlanScreen => node::NodeType::PLAN_SCREEN,
            NodeType::Delay => node::NodeType::DELAY,
            NodeType::Ramp => node::NodeType::RAMP,
            NodeType::Noise => node::NodeType::NOISE,
            NodeType::Transport => node::NodeType::TRANSPORT,
            NodeType::G13Input => node::NodeType::G13INPUT,
            NodeType::G13Output => node::NodeType::G13OUTPUT,
            NodeType::ConstantNumber => node::NodeType::CONSTANT_NUMBER,
            NodeType::Conditional => node::NodeType::CONDITIONAL,
            NodeType::TimecodeControl => node::NodeType::TIMECODE_CONTROL,
            NodeType::TimecodeOutput => node::NodeType::TIMECODE_OUTPUT,
            NodeType::AudioFile => node::NodeType::AUDIO_FILE,
            NodeType::AudioOutput => node::NodeType::AUDIO_OUTPUT,
            NodeType::AudioVolume => node::NodeType::AUDIO_VOLUME,
            NodeType::AudioInput => node::NodeType::AUDIO_INPUT,
            NodeType::AudioMix => node::NodeType::AUDIO_MIX,
            NodeType::AudioMeter => node::NodeType::AUDIO_METER,
            NodeType::Template => node::NodeType::TEMPLATE,
            NodeType::TestSink => unimplemented!("only for test"),
        }
    }
}

impl From<node::NodeType> for NodeType {
    fn from(node: node::NodeType) -> Self {
        match node {
            node::NodeType::FADER => NodeType::Fader,
            node::NodeType::BUTTON => NodeType::Button,
            node::NodeType::LABEL => NodeType::Label,
            node::NodeType::DMX_OUTPUT => NodeType::DmxOutput,
            node::NodeType::OSCILLATOR => NodeType::Oscillator,
            node::NodeType::CLOCK => NodeType::Clock,
            node::NodeType::OSC_INPUT => NodeType::OscInput,
            node::NodeType::OSC_OUTPUT => NodeType::OscOutput,
            node::NodeType::VIDEO_FILE => NodeType::VideoFile,
            node::NodeType::VIDEO_OUTPUT => NodeType::VideoOutput,
            node::NodeType::VIDEO_HSV => NodeType::VideoHsv,
            node::NodeType::VIDEO_TRANSFORM => NodeType::VideoTransform,
            node::NodeType::VIDEO_MIXER => NodeType::VideoMixer,
            node::NodeType::VIDEO_RGB => NodeType::VideoRgb,
            node::NodeType::VIDEO_RGB_SPLIT => NodeType::VideoRgbSplit,
            node::NodeType::SCRIPT => NodeType::Scripting,
            node::NodeType::PIXEL_TO_DMX => NodeType::PixelDmx,
            node::NodeType::PIXEL_PATTERN => NodeType::PixelPattern,
            node::NodeType::OPC_OUTPUT => NodeType::OpcOutput,
            node::NodeType::FIXTURE => NodeType::Fixture,
            node::NodeType::PROGRAMMER => NodeType::Programmer,
            node::NodeType::GROUP => NodeType::Group,
            node::NodeType::PRESET => NodeType::Preset,
            node::NodeType::SEQUENCER => NodeType::Sequencer,
            node::NodeType::SEQUENCE => NodeType::Sequence,
            node::NodeType::ENVELOPE => NodeType::Envelope,
            node::NodeType::SELECT => NodeType::Select,
            node::NodeType::MERGE => NodeType::Merge,
            node::NodeType::THRESHOLD => NodeType::Threshold,
            node::NodeType::ENCODER => NodeType::Encoder,
            node::NodeType::MIDI_INPUT => NodeType::MidiInput,
            node::NodeType::MIDI_OUTPUT => NodeType::MidiOutput,
            node::NodeType::LASER => NodeType::Laser,
            node::NodeType::ILDA_FILE => NodeType::IldaFile,
            node::NodeType::COLOR_CONSTANT => NodeType::ColorConstant,
            node::NodeType::COLOR_BRIGHTNESS => NodeType::ColorBrightness,
            node::NodeType::COLOR_HSV => NodeType::ColorHsv,
            node::NodeType::COLOR_RGB => NodeType::ColorRgb,
            node::NodeType::GAMEPAD => NodeType::Gamepad,
            node::NodeType::CONTAINER => NodeType::Container,
            node::NodeType::MATH => NodeType::Math,
            node::NodeType::MQTT_INPUT => NodeType::MqttInput,
            node::NodeType::MQTT_OUTPUT => NodeType::MqttOutput,
            node::NodeType::NUMBER_TO_DATA => NodeType::NumberToData,
            node::NodeType::DATA_TO_NUMBER => NodeType::DataToNumber,
            node::NodeType::VALUE => NodeType::Value,
            node::NodeType::EXTRACT => NodeType::Extract,
            node::NodeType::PLAN_SCREEN => NodeType::PlanScreen,
            node::NodeType::DELAY => NodeType::Delay,
            node::NodeType::RAMP => NodeType::Ramp,
            node::NodeType::NOISE => NodeType::Noise,
            node::NodeType::TRANSPORT => NodeType::Transport,
            node::NodeType::G13INPUT => NodeType::G13Input,
            node::NodeType::G13OUTPUT => NodeType::G13Output,
            node::NodeType::CONSTANT_NUMBER => NodeType::ConstantNumber,
            node::NodeType::CONDITIONAL => NodeType::Conditional,
            node::NodeType::TIMECODE_CONTROL => NodeType::TimecodeControl,
            node::NodeType::TIMECODE_OUTPUT => NodeType::TimecodeOutput,
            node::NodeType::AUDIO_FILE => NodeType::AudioFile,
            node::NodeType::AUDIO_OUTPUT => NodeType::AudioOutput,
            node::NodeType::AUDIO_VOLUME => NodeType::AudioVolume,
            node::NodeType::AUDIO_INPUT => NodeType::AudioInput,
            node::NodeType::AUDIO_MIX => NodeType::AudioMix,
            node::NodeType::AUDIO_METER => NodeType::AudioMeter,
            node::NodeType::TEMPLATE => NodeType::Template,
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
        type_: EnumOrUnknown::new(node_type.into()),
        settings: descriptor
            .settings
            .into_iter()
            .map(NodeSetting::from)
            .collect(),
        config: MessageField::some(config),
        designer: MessageField::some(descriptor.designer.into()),
        preview: EnumOrUnknown::new(details.preview_type.into()),
        details: MessageField::some(NodeDetails {
            name: details.name,
            category: EnumOrUnknown::new(details.category.into()),
            ..Default::default()
        }),
        ..Default::default()
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
            type_: EnumOrUnknown::new(descriptor.node_type.into()),
            settings: descriptor
                .settings
                .into_iter()
                .map(NodeSetting::from)
                .collect(),
            config: descriptor.config.try_into().ok().into(),
            designer: MessageField::some(descriptor.designer.into()),
            preview: EnumOrUnknown::new(descriptor.details.preview_type.into()),
            details: MessageField::some(NodeDetails {
                name: descriptor.details.name,
                category: EnumOrUnknown::new(descriptor.details.category.into()),
                ..Default::default()
            }),
            ..Default::default()
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
            label: setting.label,
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
            label: setting.label,
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
            Int {
                value,
                min,
                min_hint,
                max,
                max_hint,
            } => Self::Int(node_setting::IntValue {
                value,
                min,
                min_hint,
                max,
                max_hint,
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
            Media {
                value,
                content_types,
            } => Self::Media(node_setting::MediaValue {
                value,
                allowed_types: content_types
                    .into_iter()
                    .map(crate::models::media::MediaType::from)
                    .map(EnumOrUnknown::new)
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
            Media(value) => Self::Media {
                value: value.value,
                content_types: value
                    .allowed_types
                    .into_iter()
                    .map(|t| t.unwrap())
                    .map(mizer_node::MediaContentType::from)
                    .collect(),
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
                        label,
                        value,
                        ..Default::default()
                    },
                )),
                ..Default::default()
            },
            mizer_node::SelectVariant::Group { children, label } => Self {
                variant: Some(node_setting::select_variant::Variant::Group(
                    node_setting::select_variant::SelectGroup {
                        label,
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
            ) => Self::Item { label, value },
            node_setting::select_variant::Variant::Group(
                node_setting::select_variant::SelectGroup { items, label, .. },
            ) => Self::Group {
                label,
                children: items.into_iter().map(Self::from).collect(),
            },
        }
    }
}

impl From<mizer_node::MediaContentType> for crate::models::media::MediaType {
    fn from(value: mizer_node::MediaContentType) -> Self {
        match value {
            mizer_node::MediaContentType::Audio => Self::AUDIO,
            mizer_node::MediaContentType::Image => Self::IMAGE,
            mizer_node::MediaContentType::Video => Self::VIDEO,
            mizer_node::MediaContentType::Vector => Self::VECTOR,
        }
    }
}

impl From<crate::models::media::MediaType> for mizer_node::MediaContentType {
    fn from(value: crate::models::media::MediaType) -> Self {
        match value {
            crate::models::media::MediaType::AUDIO => Self::Audio,
            crate::models::media::MediaType::IMAGE => Self::Image,
            crate::models::media::MediaType::VIDEO => Self::Video,
            crate::models::media::MediaType::VECTOR => Self::Vector,
        }
    }
}

impl From<mizer_node::NodeDesigner> for NodeDesigner {
    fn from(designer: mizer_node::NodeDesigner) -> Self {
        Self {
            scale: designer.scale,
            position: MessageField::some(NodePosition {
                x: designer.position.x,
                y: designer.position.y,
                ..Default::default()
            }),
            hidden: designer.hidden,
            ..Default::default()
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
            PortType::Single => ChannelProtocol::SINGLE,
            PortType::Multi => ChannelProtocol::MULTI,
            PortType::Color => ChannelProtocol::COLOR,
            PortType::Texture => ChannelProtocol::TEXTURE,
            PortType::Vector => ChannelProtocol::VECTOR,
            PortType::Laser => ChannelProtocol::LASER,
            PortType::Poly => ChannelProtocol::POLY,
            PortType::Data => ChannelProtocol::DATA,
            PortType::Material => ChannelProtocol::MATERIAL,
            PortType::Clock => ChannelProtocol::CLOCK,
        }
    }
}

impl From<ChannelProtocol> for PortType {
    fn from(port: ChannelProtocol) -> Self {
        match port {
            ChannelProtocol::SINGLE => PortType::Single,
            ChannelProtocol::MULTI => PortType::Multi,
            ChannelProtocol::COLOR => PortType::Color,
            ChannelProtocol::TEXTURE => PortType::Texture,
            ChannelProtocol::VECTOR => PortType::Vector,
            ChannelProtocol::LASER => PortType::Laser,
            ChannelProtocol::POLY => PortType::Poly,
            ChannelProtocol::DATA => PortType::Data,
            ChannelProtocol::MATERIAL => PortType::Material,
            ChannelProtocol::CLOCK => PortType::Clock,
        }
    }
}

impl From<(PortId, PortMetadata)> for Port {
    fn from((id, metadata): (PortId, PortMetadata)) -> Self {
        Port {
            name: id.to_string(),
            protocol: EnumOrUnknown::new(metadata.port_type.into()),
            multiple: metadata.multiple.unwrap_or_default(),
            ..Default::default()
        }
    }
}

impl From<NodeConnection> for NodeLink {
    fn from(connection: NodeConnection) -> Self {
        NodeLink {
            port_type: connection.protocol.unwrap().into(),
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
            PreviewType::History => node::NodePreviewType::HISTORY,
            PreviewType::Waveform => node::NodePreviewType::WAVEFORM,
            PreviewType::Multiple => node::NodePreviewType::MULTIPLE,
            PreviewType::Texture => node::NodePreviewType::TEXTURE,
            PreviewType::Timecode => node::NodePreviewType::TIMECODE,
            PreviewType::Data => node::NodePreviewType::DATA,
            PreviewType::Color => node::NodePreviewType::COLOR,
            PreviewType::None => node::NodePreviewType::NONE,
        }
    }
}

impl From<mizer_node::NodeCategory> for NodeCategory {
    fn from(category: mizer_node::NodeCategory) -> Self {
        use mizer_node::NodeCategory::*;

        match category {
            None => Self::NODE_CATEGORY_NONE,
            Standard => Self::NODE_CATEGORY_STANDARD,
            Connections => Self::NODE_CATEGORY_CONNECTIONS,
            Conversions => Self::NODE_CATEGORY_CONVERSIONS,
            Controls => Self::NODE_CATEGORY_CONTROLS,
            Data => Self::NODE_CATEGORY_DATA,
            Color => Self::NODE_CATEGORY_COLOR,
            Audio => Self::NODE_CATEGORY_AUDIO,
            Video => Self::NODE_CATEGORY_VIDEO,
            Laser => Self::NODE_CATEGORY_LASER,
            Pixel => Self::NODE_CATEGORY_PIXEL,
        }
    }
}
