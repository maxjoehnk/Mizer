use crate::models::nodes::*;
use protobuf::SingularPtrField;
use mizer_node::{NodeType, PortDirection, PortType, PortId, NodeLink, PortMetadata};
use mizer_runtime::NodeDescriptor;

impl From<mizer_nodes::Node> for Node_oneof_NodeConfig {
    fn from(node: mizer_nodes::Node) -> Self {
        use mizer_nodes::Node::*;
        match node {
            Clock(clock) => Node_oneof_NodeConfig::clockConfig(clock.into()),
            Oscillator(oscillator) => Node_oneof_NodeConfig::oscillatorConfig(oscillator.into()),
            DmxOutput(dmx_output) => Node_oneof_NodeConfig::dmxOutputConfig(dmx_output.into()),
            Scripting(scripting) => Node_oneof_NodeConfig::scriptingConfig(scripting.into()),
            Sequence(sequence) => Node_oneof_NodeConfig::sequenceConfig(sequence.into()),
            Fixture(fixture) => Node_oneof_NodeConfig::fixtureConfig(fixture.into()),
            IldaFile(ilda) => Node_oneof_NodeConfig::ildaFileConfig(ilda.into()),
            Laser(laser) => Node_oneof_NodeConfig::laserConfig(laser.into()),
            Fader(fader) => Node_oneof_NodeConfig::faderConfig(fader.into()),
            Button(button) => Node_oneof_NodeConfig::buttonConfig(button.into()),
            MidiInput(midi_input) => Node_oneof_NodeConfig::midiInputConfig(midi_input.into()),
            MidiOutput(midi_output) => Node_oneof_NodeConfig::midiOutputConfig(midi_output.into()),
            OpcOutput(opc) => Node_oneof_NodeConfig::opcOutputConfig(opc.into()),
            PixelPattern(pattern) => Node_oneof_NodeConfig::pixelPatternConfig(pattern.into()),
            PixelDmx(dmx) => Node_oneof_NodeConfig::pixelDmxConfig(dmx.into()),
            OscInput(osc) => Node_oneof_NodeConfig::oscInputConfig(osc.into()),
            OscOutput(osc) => Node_oneof_NodeConfig::oscOutputConfig(osc.into()),
            VideoFile(file) => Node_oneof_NodeConfig::videoFileConfig(file.into()),
            VideoColorBalance(color_balance) => Node_oneof_NodeConfig::videoColorBalanceConfig(color_balance.into()),
            VideoOutput(output) => Node_oneof_NodeConfig::videoOutputConfig(output.into()),
            VideoEffect(effect) => Node_oneof_NodeConfig::videoEffectConfig(effect.into()),
            VideoTransform(transform) => Node_oneof_NodeConfig::videoTransformConfig(transform.into()),
        }
    }
}

impl From<mizer_nodes::ClockNode> for ClockNodeConfig {
    fn from(clock: mizer_nodes::ClockNode) -> Self {
        ClockNodeConfig {
            speed: clock.speed,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::OscillatorNode> for OscillatorNodeConfig {
    fn from(oscillator: mizer_nodes::OscillatorNode) -> Self {
        OscillatorNodeConfig {
            field_type: oscillator.oscillator_type.into(),
            offset: oscillator.offset,
            min: oscillator.min,
            max: oscillator.max,
            ratio: oscillator.ratio,
            reverse: oscillator.reverse,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::OscillatorType> for OscillatorNodeConfig_OscillatorType {
    fn from(oscillator_type: mizer_nodes::OscillatorType) -> Self {
        use mizer_nodes::OscillatorType::*;

        match oscillator_type {
            Sine => OscillatorNodeConfig_OscillatorType::Sine,
            Saw => OscillatorNodeConfig_OscillatorType::Saw,
            Square => OscillatorNodeConfig_OscillatorType::Square,
            Triangle => OscillatorNodeConfig_OscillatorType::Triangle,
        }
    }
}

impl From<mizer_nodes::DmxOutputNode> for DmxOutputNodeConfig {
    fn from(output: mizer_nodes::DmxOutputNode) -> Self {
        DmxOutputNodeConfig {
            channel: output.channel as u32,
            universe: output.universe as u32,
            output: "output".into(), // TODO: use output property
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::ScriptingNode> for ScriptingNodeConfig {
    fn from(scripting: mizer_nodes::ScriptingNode) -> Self {
        ScriptingNodeConfig {
            script: scripting.script,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::SequenceNode> for SequenceNodeConfig {
    fn from(sequence: mizer_nodes::SequenceNode) -> Self {
        SequenceNodeConfig {
            steps: sequence.steps.into_iter().map(SequenceNodeConfig_SequenceStep::from).collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::SequenceStep> for SequenceNodeConfig_SequenceStep {
    fn from(step: mizer_nodes::SequenceStep) -> Self {
        SequenceNodeConfig_SequenceStep {
            value: step.value,
            hold: step.hold,
            tick: step.tick,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::FixtureNode> for FixtureNodeConfig {
    fn from(fixture: mizer_nodes::FixtureNode) -> Self {
        FixtureNodeConfig {
            fixture_id: fixture.fixture_id,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::IldaFileNode> for IldaFileNodeConfig {
    fn from(ilda_file: mizer_nodes::IldaFileNode) -> Self {
        IldaFileNodeConfig {
            file: ilda_file.file,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::LaserNode> for LaserNodeConfig {
    fn from(laser: mizer_nodes::LaserNode) -> Self {
        LaserNodeConfig {
            device_id: laser.device_id,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::FaderNode> for InputNodeConfig {
    fn from(_: mizer_nodes::FaderNode) -> Self {
        InputNodeConfig::default()
    }
}

impl From<mizer_nodes::ButtonNode> for InputNodeConfig {
    fn from(_: mizer_nodes::ButtonNode) -> Self {
        InputNodeConfig::default()
    }
}

impl From<mizer_nodes::MidiInputNode> for MidiInputNodeConfig {
    fn from(_: mizer_nodes::MidiInputNode) -> Self {
        MidiInputNodeConfig::default()
    }
}

impl From<mizer_nodes::MidiOutputNode> for MidiOutputNodeConfig {
    fn from(_: mizer_nodes::MidiOutputNode) -> Self {
        MidiOutputNodeConfig::default()
    }
}

impl From<mizer_nodes::OpcOutputNode> for OpcOutputNodeConfig {
    fn from(opc: mizer_nodes::OpcOutputNode) -> Self {
        OpcOutputNodeConfig {
            width: opc.width,
            height: opc.height,
            host: opc.host,
            port: opc.port as u32,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::PixelPatternGeneratorNode> for PixelPatternNodeConfig {
    fn from(node: mizer_nodes::PixelPatternGeneratorNode) -> Self {
        PixelPatternNodeConfig {
            pattern: node.pattern.into(),
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::Pattern> for PixelPatternNodeConfig_Pattern {
    fn from(pattern: mizer_nodes::Pattern) -> Self {
        use mizer_nodes::Pattern::*;

        match pattern {
            RgbIterate => PixelPatternNodeConfig_Pattern::RgbIterate,
            RgbSnake => PixelPatternNodeConfig_Pattern::RgbSnake,
        }
    }
}

impl From<mizer_nodes::PixelDmxNode> for PixelDmxNodeConfig {
    fn from(node: mizer_nodes::PixelDmxNode) -> Self {
        PixelDmxNodeConfig {
            height: node.height,
            width: node.width,
            output: node.output,
            start_universe: node.start_universe as u32,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::OscInputNode> for OscNodeConfig {
    fn from(node: mizer_nodes::OscInputNode) -> Self {
        Self {
            host: node.host,
            port: node.port as u32,
            path: node.path,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::OscOutputNode> for OscNodeConfig {
    fn from(node: mizer_nodes::OscOutputNode) -> Self {
        Self {
            host: node.host,
            port: node.port as u32,
            path: node.path,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::VideoFileNode> for VideoFileNodeConfig {
    fn from(node: mizer_nodes::VideoFileNode) -> Self {
        VideoFileNodeConfig {
            file: node.file,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::VideoColorBalanceNode> for VideoColorBalanceNodeConfig {
    fn from(node: mizer_nodes::VideoColorBalanceNode) -> Self {
        Default::default()
    }
}

impl From<mizer_nodes::VideoOutputNode> for VideoOutputNodeConfig {
    fn from(node: mizer_nodes::VideoOutputNode) -> Self {
        Default::default()
    }
}

impl From<mizer_nodes::VideoEffectNode> for VideoEffectNodeConfig {
    fn from(node: mizer_nodes::VideoEffectNode) -> Self {
        Default::default()
    }
}

impl From<mizer_nodes::VideoTransformNode> for VideoTransformNodeConfig {
    fn from(node: mizer_nodes::VideoTransformNode) -> Self {
        Default::default()
    }
}

impl From<NodeType> for Node_NodeType {
    fn from(node: NodeType) -> Self {
        match node {
            NodeType::Fader => Node_NodeType::Fader,
            NodeType::Button => Node_NodeType::Button,
            NodeType::DmxOutput => Node_NodeType::DmxOutput,
            NodeType::Oscillator => Node_NodeType::Oscillator,
            NodeType::Clock => Node_NodeType::Clock,
            NodeType::OscInput => Node_NodeType::OscInput,
            NodeType::OscOutput => Node_NodeType::OscOutput,
            NodeType::VideoFile => Node_NodeType::VideoFile,
            NodeType::VideoOutput => Node_NodeType::VideoOutput,
            NodeType::VideoEffect => Node_NodeType::VideoEffect,
            NodeType::VideoColorBalance => Node_NodeType::VideoColorBalance,
            NodeType::VideoTransform => Node_NodeType::VideoTransform,
            NodeType::Scripting => Node_NodeType::Script,
            NodeType::PixelDmx => Node_NodeType::PixelToDmx,
            NodeType::PixelPattern => Node_NodeType::PixelPattern,
            NodeType::OpcOutput => Node_NodeType::OpcOutput,
            NodeType::Fixture => Node_NodeType::Fixture,
            NodeType::Sequence => Node_NodeType::Sequence,
            NodeType::MidiInput => Node_NodeType::MidiInput,
            NodeType::MidiOutput => Node_NodeType::MidiOutput,
            NodeType::Laser => Node_NodeType::Laser,
            NodeType::IldaFile => Node_NodeType::IldaFile,
        }
    }
}

impl From<Node_NodeType> for NodeType {
    fn from(node: Node_NodeType) -> Self {
        match node {
            Node_NodeType::Fader => NodeType::Fader,
            Node_NodeType::Button => NodeType::Button,
            Node_NodeType::DmxOutput => NodeType::DmxOutput,
            Node_NodeType::Oscillator => NodeType::Oscillator,
            Node_NodeType::Clock => NodeType::Clock,
            Node_NodeType::OscInput => NodeType::OscInput,
            Node_NodeType::OscOutput => NodeType::OscOutput,
            Node_NodeType::VideoFile => NodeType::VideoFile,
            Node_NodeType::VideoOutput => NodeType::VideoOutput,
            Node_NodeType::VideoEffect => NodeType::VideoEffect,
            Node_NodeType::VideoColorBalance => NodeType::VideoColorBalance,
            Node_NodeType::VideoTransform => NodeType::VideoTransform,
            Node_NodeType::Script => NodeType::Scripting,
            Node_NodeType::PixelToDmx => NodeType::PixelDmx,
            Node_NodeType::PixelPattern => NodeType::PixelPattern,
            Node_NodeType::OpcOutput => NodeType::OpcOutput,
            Node_NodeType::Fixture => NodeType::Fixture,
            Node_NodeType::Sequence => NodeType::Sequence,
            Node_NodeType::MidiInput => NodeType::MidiInput,
            Node_NodeType::MidiOutput => NodeType::MidiOutput,
            Node_NodeType::Laser => NodeType::Laser,
            Node_NodeType::IldaFile => NodeType::IldaFile,
        }
    }
}

impl From<NodeDescriptor<'_>> for Node {
    fn from(descriptor: NodeDescriptor<'_>) -> Self {
        let node_type = descriptor.node_type();
        let mut node = Node {
            path: descriptor.path.to_string(),
            field_type: node_type.into(),
            NodeConfig: Some(descriptor.downcast().into()),
            designer: SingularPtrField::some(descriptor.designer.into()),
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
impl From<mizer_node::NodeDesigner> for NodeDesigner {
    fn from(designer: mizer_node::NodeDesigner) -> Self {
        Self {
            scale: designer.scale,
            position: SingularPtrField::some(NodePosition {
                x: designer.position.x,
                y: designer.position.y,
                ..Default::default()
            }),
            ..Default::default()
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
            PortType::Gstreamer => ChannelProtocol::Gst,
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
            ChannelProtocol::Gst => PortType::Gstreamer,
        }
    }
}

impl From<(PortId, PortMetadata)> for Port {
    fn from((id, metadata): (PortId, PortMetadata)) -> Self {
        Port {
            name: id.to_string(),
            protocol: metadata.port_type.into(),
            ..Default::default()
        }
    }
}

impl From<NodeConnection> for NodeLink {
    fn from(connection: NodeConnection) -> Self {
        NodeLink {
            port_type: connection.protocol.into(),
            source: connection.sourceNode.into(),
            source_port: connection.sourcePort.unwrap().name.into(),
            target: connection.targetNode.into(),
            target_port: connection.targetPort.unwrap().name.into(),
            local: true,
        }
    }
}
