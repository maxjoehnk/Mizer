use protobuf::SingularPtrField;

use mizer_node::{NodeLink, NodeType, PortDirection, PortId, PortMetadata, PortType, PreviewType};
use mizer_nodes::{MidiInputConfig, MidiOutputConfig, OscArgumentType};
use mizer_runtime::commands::StaticNodeDescriptor;
use mizer_runtime::{NodeDescriptor, NodeDowncast};

use crate::models::nodes::*;

impl From<mizer_nodes::Node> for NodeConfig_oneof_type {
    fn from(node: mizer_nodes::Node) -> Self {
        use mizer_nodes::Node::*;
        match node {
            Clock(clock) => Self::clockConfig(clock.into()),
            Oscillator(oscillator) => Self::oscillatorConfig(oscillator.into()),
            DmxOutput(dmx_output) => Self::dmxOutputConfig(dmx_output.into()),
            Scripting(scripting) => Self::scriptingConfig(scripting.into()),
            Sequence(sequence) => Self::sequenceConfig(sequence.into()),
            Envelope(envelope) => Self::envelopeConfig(envelope.into()),
            Select(select) => Self::selectConfig(select.into()),
            Merge(merge) => Self::mergeConfig(merge.into()),
            Threshold(threshold) => Self::thresholdConfig(threshold.into()),
            Fixture(fixture) => Self::fixtureConfig(fixture.into()),
            Programmer(programmer) => Self::programmerConfig(programmer.into()),
            Group(group) => Self::groupConfig(group.into()),
            Preset(preset) => Self::presetConfig(preset.into()),
            Sequencer(sequencer) => Self::sequencerConfig(sequencer.into()),
            IldaFile(ilda) => Self::ildaFileConfig(ilda.into()),
            Laser(laser) => Self::laserConfig(laser.into()),
            Fader(fader) => Self::faderConfig(fader.into()),
            Button(button) => Self::buttonConfig(button.into()),
            MidiInput(midi_input) => Self::midiInputConfig(midi_input.into()),
            MidiOutput(midi_output) => Self::midiOutputConfig(midi_output.into()),
            OpcOutput(opc) => Self::opcOutputConfig(opc.into()),
            PixelPattern(pattern) => Self::pixelPatternConfig(pattern.into()),
            PixelDmx(dmx) => Self::pixelDmxConfig(dmx.into()),
            OscInput(osc) => Self::oscInputConfig(osc.into()),
            OscOutput(osc) => Self::oscOutputConfig(osc.into()),
            VideoFile(file) => Self::videoFileConfig(file.into()),
            VideoColorBalance(color_balance) => Self::videoColorBalanceConfig(color_balance.into()),
            VideoOutput(output) => Self::videoOutputConfig(output.into()),
            VideoEffect(effect) => Self::videoEffectConfig(effect.into()),
            VideoTransform(transform) => Self::videoTransformConfig(transform.into()),
            ColorRgb(node) => Self::colorRgbConfig(node.into()),
            ColorHsv(node) => Self::colorHsvConfig(node.into()),
            Gamepad(node) => Self::gamepadNodeConfig(node.into()),
            TestSink(_) => unimplemented!("Only for test"),
        }
    }
}

impl From<NodeConfig_oneof_type> for mizer_nodes::Node {
    fn from(node_config: NodeConfig_oneof_type) -> Self {
        match node_config {
            NodeConfig_oneof_type::clockConfig(clock) => Self::Clock(clock.into()),
            NodeConfig_oneof_type::oscillatorConfig(oscillator) => {
                Self::Oscillator(oscillator.into())
            }
            NodeConfig_oneof_type::dmxOutputConfig(dmx_output) => {
                Self::DmxOutput(dmx_output.into())
            }
            NodeConfig_oneof_type::scriptingConfig(scripting) => Self::Scripting(scripting.into()),
            NodeConfig_oneof_type::sequenceConfig(sequence) => Self::Sequence(sequence.into()),
            NodeConfig_oneof_type::envelopeConfig(envelope) => Self::Envelope(envelope.into()),
            NodeConfig_oneof_type::selectConfig(select) => Self::Select(select.into()),
            NodeConfig_oneof_type::mergeConfig(merge) => Self::Merge(merge.into()),
            NodeConfig_oneof_type::thresholdConfig(threshold) => Self::Threshold(threshold.into()),
            NodeConfig_oneof_type::fixtureConfig(fixture) => Self::Fixture(fixture.into()),
            NodeConfig_oneof_type::programmerConfig(programmer) => {
                Self::Programmer(programmer.into())
            }
            NodeConfig_oneof_type::groupConfig(group) => Self::Group(group.into()),
            NodeConfig_oneof_type::presetConfig(preset) => Self::Preset(preset.into()),
            NodeConfig_oneof_type::sequencerConfig(sequencer) => Self::Sequencer(sequencer.into()),
            NodeConfig_oneof_type::ildaFileConfig(ilda) => Self::IldaFile(ilda.into()),
            NodeConfig_oneof_type::laserConfig(laser) => Self::Laser(laser.into()),
            NodeConfig_oneof_type::faderConfig(fader) => Self::Fader(fader.into()),
            NodeConfig_oneof_type::buttonConfig(button) => Self::Button(button.into()),
            NodeConfig_oneof_type::midiInputConfig(midi_input) => {
                Self::MidiInput(midi_input.into())
            }
            NodeConfig_oneof_type::midiOutputConfig(midi_output) => {
                Self::MidiOutput(midi_output.into())
            }
            NodeConfig_oneof_type::opcOutputConfig(opc) => Self::OpcOutput(opc.into()),
            NodeConfig_oneof_type::pixelPatternConfig(pattern) => {
                Self::PixelPattern(pattern.into())
            }
            NodeConfig_oneof_type::pixelDmxConfig(dmx) => Self::PixelDmx(dmx.into()),
            NodeConfig_oneof_type::oscInputConfig(osc) => Self::OscInput(osc.into()),
            NodeConfig_oneof_type::oscOutputConfig(osc) => Self::OscOutput(osc.into()),
            NodeConfig_oneof_type::videoFileConfig(file) => Self::VideoFile(file.into()),
            NodeConfig_oneof_type::videoColorBalanceConfig(color_balance) => {
                Self::VideoColorBalance(color_balance.into())
            }
            NodeConfig_oneof_type::videoOutputConfig(output) => Self::VideoOutput(output.into()),
            NodeConfig_oneof_type::videoEffectConfig(effect) => Self::VideoEffect(effect.into()),
            NodeConfig_oneof_type::videoTransformConfig(transform) => {
                Self::VideoTransform(transform.into())
            }
            NodeConfig_oneof_type::colorRgbConfig(node) => Self::ColorRgb(node.into()),
            NodeConfig_oneof_type::colorHsvConfig(node) => Self::ColorHsv(node.into()),
            NodeConfig_oneof_type::gamepadNodeConfig(node) => Self::Gamepad(node.into()),
        }
    }
}

impl From<mizer_nodes::Node> for NodeConfig {
    fn from(node: mizer_nodes::Node) -> Self {
        let config: NodeConfig_oneof_type = node.into();
        NodeConfig {
            field_type: Some(config),
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::ClockNode> for ClockNodeConfig {
    fn from(clock: mizer_nodes::ClockNode) -> Self {
        Self {
            speed: clock.speed,
            ..Default::default()
        }
    }
}

impl From<ClockNodeConfig> for mizer_nodes::ClockNode {
    fn from(clock: ClockNodeConfig) -> Self {
        Self { speed: clock.speed }
    }
}

impl From<mizer_nodes::OscillatorNode> for OscillatorNodeConfig {
    fn from(oscillator: mizer_nodes::OscillatorNode) -> Self {
        Self {
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
            Sine => Self::Sine,
            Saw => Self::Saw,
            Square => Self::Square,
            Triangle => Self::Triangle,
        }
    }
}

impl From<OscillatorNodeConfig> for mizer_nodes::OscillatorNode {
    fn from(oscillator: OscillatorNodeConfig) -> Self {
        Self {
            oscillator_type: oscillator.field_type.into(),
            offset: oscillator.offset,
            min: oscillator.min,
            max: oscillator.max,
            ratio: oscillator.ratio,
            reverse: oscillator.reverse,
        }
    }
}

impl From<OscillatorNodeConfig_OscillatorType> for mizer_nodes::OscillatorType {
    fn from(oscillator_type: OscillatorNodeConfig_OscillatorType) -> Self {
        use OscillatorNodeConfig_OscillatorType::*;

        match oscillator_type {
            Sine => Self::Sine,
            Saw => Self::Saw,
            Square => Self::Square,
            Triangle => Self::Triangle,
        }
    }
}

impl From<mizer_nodes::DmxOutputNode> for DmxOutputNodeConfig {
    fn from(output: mizer_nodes::DmxOutputNode) -> Self {
        let mut result = Self {
            channel: output.channel as u32,
            universe: output.universe as u32,
            ..Default::default()
        };
        if let Some(output) = output.output {
            result.set_output(output);
        }

        result
    }
}

impl From<DmxOutputNodeConfig> for mizer_nodes::DmxOutputNode {
    fn from(output: DmxOutputNodeConfig) -> Self {
        Self {
            channel: output.channel as u16,
            universe: output.universe as u16,
            output: output._output.map(|o| match o {
                DmxOutputNodeConfig_oneof__output::output(output) => output,
            }),
        }
    }
}

impl From<mizer_nodes::ScriptingNode> for ScriptingNodeConfig {
    fn from(scripting: mizer_nodes::ScriptingNode) -> Self {
        Self {
            script: scripting.script,
            ..Default::default()
        }
    }
}

impl From<ScriptingNodeConfig> for mizer_nodes::ScriptingNode {
    fn from(scripting: ScriptingNodeConfig) -> Self {
        Self {
            script: scripting.script,
        }
    }
}

impl From<mizer_nodes::SequenceNode> for SequenceNodeConfig {
    fn from(sequence: mizer_nodes::SequenceNode) -> Self {
        Self {
            steps: sequence
                .steps
                .into_iter()
                .map(SequenceNodeConfig_SequenceStep::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::SequenceStep> for SequenceNodeConfig_SequenceStep {
    fn from(step: mizer_nodes::SequenceStep) -> Self {
        Self {
            value: step.value,
            hold: step.hold,
            tick: step.tick,
            ..Default::default()
        }
    }
}

impl From<SequenceNodeConfig> for mizer_nodes::SequenceNode {
    fn from(sequence: SequenceNodeConfig) -> Self {
        Self {
            steps: sequence
                .steps
                .into_iter()
                .map(mizer_nodes::SequenceStep::from)
                .collect(),
        }
    }
}

impl From<SequenceNodeConfig_SequenceStep> for mizer_nodes::SequenceStep {
    fn from(step: SequenceNodeConfig_SequenceStep) -> Self {
        Self {
            value: step.value,
            hold: step.hold,
            tick: step.tick,
        }
    }
}

impl From<mizer_nodes::EnvelopeNode> for EnvelopeNodeConfig {
    fn from(envelope: mizer_nodes::EnvelopeNode) -> Self {
        Self {
            attack: envelope.attack,
            decay: envelope.decay,
            sustain: envelope.sustain,
            release: envelope.release,
            ..Default::default()
        }
    }
}

impl From<EnvelopeNodeConfig> for mizer_nodes::EnvelopeNode {
    fn from(envelope: EnvelopeNodeConfig) -> Self {
        Self {
            attack: envelope.attack,
            decay: envelope.decay,
            sustain: envelope.sustain,
            release: envelope.release,
        }
    }
}

impl From<mizer_nodes::FixtureNode> for FixtureNodeConfig {
    fn from(fixture: mizer_nodes::FixtureNode) -> Self {
        Self {
            fixture_id: fixture.fixture_id,
            ..Default::default()
        }
    }
}

impl From<FixtureNodeConfig> for mizer_nodes::FixtureNode {
    fn from(fixture: FixtureNodeConfig) -> Self {
        Self {
            fixture_id: fixture.fixture_id,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::ProgrammerNode> for ProgrammerNodeConfig {
    fn from(_: mizer_nodes::ProgrammerNode) -> Self {
        Default::default()
    }
}

impl From<ProgrammerNodeConfig> for mizer_nodes::ProgrammerNode {
    fn from(_: ProgrammerNodeConfig) -> Self {
        Default::default()
    }
}

impl From<mizer_nodes::GroupNode> for GroupNodeConfig {
    fn from(_: mizer_nodes::GroupNode) -> Self {
        Default::default()
    }
}

impl From<GroupNodeConfig> for mizer_nodes::GroupNode {
    fn from(_: GroupNodeConfig) -> Self {
        Default::default()
    }
}

impl From<mizer_nodes::PresetNode> for PresetNodeConfig {
    fn from(_: mizer_nodes::PresetNode) -> Self {
        Default::default()
    }
}

impl From<PresetNodeConfig> for mizer_nodes::PresetNode {
    fn from(_: PresetNodeConfig) -> Self {
        Default::default()
    }
}

impl From<mizer_nodes::SequencerNode> for SequencerNodeConfig {
    fn from(node: mizer_nodes::SequencerNode) -> Self {
        Self {
            sequence_id: node.sequence_id,
            ..Default::default()
        }
    }
}

impl From<SequencerNodeConfig> for mizer_nodes::SequencerNode {
    fn from(node: SequencerNodeConfig) -> Self {
        Self {
            sequence_id: node.sequence_id,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::IldaFileNode> for IldaFileNodeConfig {
    fn from(ilda_file: mizer_nodes::IldaFileNode) -> Self {
        Self {
            file: ilda_file.file,
            ..Default::default()
        }
    }
}

impl From<IldaFileNodeConfig> for mizer_nodes::IldaFileNode {
    fn from(ilda_file: IldaFileNodeConfig) -> Self {
        Self {
            file: ilda_file.file,
        }
    }
}

impl From<mizer_nodes::LaserNode> for LaserNodeConfig {
    fn from(laser: mizer_nodes::LaserNode) -> Self {
        Self {
            device_id: laser.device_id,
            ..Default::default()
        }
    }
}

impl From<LaserNodeConfig> for mizer_nodes::LaserNode {
    fn from(laser: LaserNodeConfig) -> Self {
        Self {
            device_id: laser.device_id,
        }
    }
}

impl From<mizer_nodes::GamepadNode> for GamepadNodeConfig {
    fn from(gamepad: mizer_nodes::GamepadNode) -> Self {
        Self {
            device_id: gamepad.device_id,
            ..Default::default()
        }
    }
}

impl From<GamepadNodeConfig> for mizer_nodes::GamepadNode {
    fn from(gamepad: GamepadNodeConfig) -> Self {
        Self {
            device_id: gamepad.device_id,
        }
    }
}

impl From<mizer_nodes::FaderNode> for FaderNodeConfig {
    fn from(_: mizer_nodes::FaderNode) -> Self {
        Default::default()
    }
}

impl From<FaderNodeConfig> for mizer_nodes::FaderNode {
    fn from(_: FaderNodeConfig) -> Self {
        Default::default()
    }
}

impl From<mizer_nodes::ButtonNode> for ButtonNodeConfig {
    fn from(node: mizer_nodes::ButtonNode) -> Self {
        Self {
            toggle: node.toggle,
            ..Default::default()
        }
    }
}

impl From<ButtonNodeConfig> for mizer_nodes::ButtonNode {
    fn from(node: ButtonNodeConfig) -> Self {
        Self {
            toggle: node.toggle,
        }
    }
}

impl From<mizer_nodes::MidiInputNode> for MidiNodeConfig {
    fn from(node: mizer_nodes::MidiInputNode) -> Self {
        let binding = match node.config {
            mizer_nodes::MidiInputConfig::CC {
                channel,
                port,
                range,
            } => MidiNodeConfig_oneof_binding::noteBinding(MidiNodeConfig_NoteBinding {
                channel: channel as u32,
                field_type: MidiNodeConfig_NoteBinding_MidiType::CC,
                port: port as u32,
                rangeFrom: range.0 as u32,
                rangeTo: range.1 as u32,
                ..Default::default()
            }),
            mizer_nodes::MidiInputConfig::Note {
                channel,
                port,
                range,
            } => MidiNodeConfig_oneof_binding::noteBinding(MidiNodeConfig_NoteBinding {
                channel: channel as u32,
                field_type: MidiNodeConfig_NoteBinding_MidiType::Note,
                port: port as u32,
                rangeFrom: range.0 as u32,
                rangeTo: range.1 as u32,
                ..Default::default()
            }),
            mizer_nodes::MidiInputConfig::Control { page, control } => {
                MidiNodeConfig_oneof_binding::controlBinding(MidiNodeConfig_ControlBinding {
                    page,
                    control,
                    ..Default::default()
                })
            }
        };

        Self {
            device: node.device,
            binding: Some(binding),
            ..Default::default()
        }
    }
}

impl From<MidiNodeConfig> for mizer_nodes::MidiInputNode {
    fn from(config: MidiNodeConfig) -> Self {
        Self {
            device: config.device,
            config: match config.binding {
                Some(MidiNodeConfig_oneof_binding::noteBinding(binding)) => {
                    match binding.field_type {
                        MidiNodeConfig_NoteBinding_MidiType::CC => MidiInputConfig::CC {
                            channel: binding.channel as u8,
                            port: binding.port as u8,
                            range: (binding.rangeFrom as u8, binding.rangeTo as u8),
                        },
                        MidiNodeConfig_NoteBinding_MidiType::Note => MidiInputConfig::Note {
                            channel: binding.channel as u8,
                            port: binding.port as u8,
                            range: (binding.rangeFrom as u8, binding.rangeTo as u8),
                        },
                    }
                }
                Some(MidiNodeConfig_oneof_binding::controlBinding(binding)) => {
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

impl From<mizer_nodes::MidiOutputNode> for MidiNodeConfig {
    fn from(node: mizer_nodes::MidiOutputNode) -> Self {
        let binding = match node.config {
            mizer_nodes::MidiOutputConfig::CC {
                channel,
                port,
                range,
            } => MidiNodeConfig_oneof_binding::noteBinding(MidiNodeConfig_NoteBinding {
                channel: channel as u32,
                field_type: MidiNodeConfig_NoteBinding_MidiType::CC,
                port: port as u32,
                rangeFrom: range.0 as u32,
                rangeTo: range.1 as u32,
                ..Default::default()
            }),
            mizer_nodes::MidiOutputConfig::Note {
                channel,
                port,
                range,
            } => MidiNodeConfig_oneof_binding::noteBinding(MidiNodeConfig_NoteBinding {
                channel: channel as u32,
                field_type: MidiNodeConfig_NoteBinding_MidiType::Note,
                port: port as u32,
                rangeFrom: range.0 as u32,
                rangeTo: range.1 as u32,
                ..Default::default()
            }),
            mizer_nodes::MidiOutputConfig::Control { page, control } => {
                MidiNodeConfig_oneof_binding::controlBinding(MidiNodeConfig_ControlBinding {
                    page,
                    control,
                    ..Default::default()
                })
            }
        };

        Self {
            device: node.device,
            binding: Some(binding),
            ..Default::default()
        }
    }
}

impl From<MidiNodeConfig> for mizer_nodes::MidiOutputNode {
    fn from(config: MidiNodeConfig) -> Self {
        Self {
            device: config.device,
            config: match config.binding {
                Some(MidiNodeConfig_oneof_binding::noteBinding(binding)) => {
                    match binding.field_type {
                        MidiNodeConfig_NoteBinding_MidiType::CC => MidiOutputConfig::CC {
                            channel: binding.channel as u8,
                            port: binding.port as u8,
                            range: (binding.rangeFrom as u8, binding.rangeTo as u8),
                        },
                        MidiNodeConfig_NoteBinding_MidiType::Note => MidiOutputConfig::Note {
                            channel: binding.channel as u8,
                            port: binding.port as u8,
                            range: (binding.rangeFrom as u8, binding.rangeTo as u8),
                        },
                    }
                }
                Some(MidiNodeConfig_oneof_binding::controlBinding(binding)) => {
                    MidiOutputConfig::Control {
                        page: binding.page,
                        control: binding.control,
                    }
                }
                None => MidiOutputConfig::default(),
            },
        }
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

impl From<OpcOutputNodeConfig> for mizer_nodes::OpcOutputNode {
    fn from(opc: OpcOutputNodeConfig) -> Self {
        Self {
            width: opc.width,
            height: opc.height,
            host: opc.host,
            port: opc.port as u16,
        }
    }
}

impl From<mizer_nodes::PixelPatternGeneratorNode> for PixelPatternNodeConfig {
    fn from(node: mizer_nodes::PixelPatternGeneratorNode) -> Self {
        Self {
            pattern: node.pattern.into(),
            ..Default::default()
        }
    }
}

impl From<PixelPatternNodeConfig> for mizer_nodes::PixelPatternGeneratorNode {
    fn from(node: PixelPatternNodeConfig) -> Self {
        Self {
            pattern: node.pattern.into(),
        }
    }
}

impl From<mizer_nodes::Pattern> for PixelPatternNodeConfig_Pattern {
    fn from(pattern: mizer_nodes::Pattern) -> Self {
        use mizer_nodes::Pattern::*;

        match pattern {
            RgbIterate => Self::RgbIterate,
            RgbSnake => Self::RgbSnake,
        }
    }
}

impl From<PixelPatternNodeConfig_Pattern> for mizer_nodes::Pattern {
    fn from(pattern: PixelPatternNodeConfig_Pattern) -> Self {
        use PixelPatternNodeConfig_Pattern::*;

        match pattern {
            RgbIterate => Self::RgbIterate,
            RgbSnake => Self::RgbSnake,
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

impl From<PixelDmxNodeConfig> for mizer_nodes::PixelDmxNode {
    fn from(node: PixelDmxNodeConfig) -> Self {
        Self {
            height: node.height,
            width: node.width,
            output: node.output,
            start_universe: node.start_universe as u16,
        }
    }
}

impl From<mizer_nodes::OscInputNode> for OscNodeConfig {
    fn from(node: mizer_nodes::OscInputNode) -> Self {
        Self {
            host: node.host,
            port: node.port as u32,
            path: node.path,
            argumentType: node.argument_type.into(),
            ..Default::default()
        }
    }
}

impl From<OscNodeConfig> for mizer_nodes::OscInputNode {
    fn from(node: OscNodeConfig) -> Self {
        Self {
            host: node.host,
            port: node.port as u16,
            path: node.path,
            argument_type: node.argumentType.into(),
        }
    }
}

impl From<mizer_nodes::OscOutputNode> for OscNodeConfig {
    fn from(node: mizer_nodes::OscOutputNode) -> Self {
        Self {
            host: node.host,
            port: node.port as u32,
            path: node.path,
            argumentType: node.argument_type.into(),
            ..Default::default()
        }
    }
}

impl From<OscNodeConfig> for mizer_nodes::OscOutputNode {
    fn from(node: OscNodeConfig) -> Self {
        Self {
            host: node.host,
            port: node.port as u16,
            path: node.path,
            argument_type: node.argumentType.into(),
        }
    }
}

impl From<OscNodeConfig_ArgumentType> for mizer_nodes::OscArgumentType {
    fn from(argument_type: OscNodeConfig_ArgumentType) -> Self {
        use OscNodeConfig_ArgumentType::*;

        match argument_type {
            Bool => Self::Bool,
            Int => Self::Int,
            Double => Self::Double,
            Float => Self::Float,
            Long => Self::Long,
            Color => Self::Color,
        }
    }
}

impl From<mizer_nodes::OscArgumentType> for OscNodeConfig_ArgumentType {
    fn from(argument_type: OscArgumentType) -> Self {
        use OscArgumentType::*;

        match argument_type {
            Bool => Self::Bool,
            Int => Self::Int,
            Double => Self::Double,
            Float => Self::Float,
            Long => Self::Long,
            Color => Self::Color,
        }
    }
}

impl From<mizer_nodes::VideoFileNode> for VideoFileNodeConfig {
    fn from(node: mizer_nodes::VideoFileNode) -> Self {
        Self {
            file: node.file,
            ..Default::default()
        }
    }
}

impl From<VideoFileNodeConfig> for mizer_nodes::VideoFileNode {
    fn from(node: VideoFileNodeConfig) -> Self {
        Self { file: node.file }
    }
}

impl From<mizer_nodes::VideoColorBalanceNode> for VideoColorBalanceNodeConfig {
    fn from(_: mizer_nodes::VideoColorBalanceNode) -> Self {
        Default::default()
    }
}

impl From<VideoColorBalanceNodeConfig> for mizer_nodes::VideoColorBalanceNode {
    fn from(_: VideoColorBalanceNodeConfig) -> Self {
        Default::default()
    }
}

impl From<mizer_nodes::VideoOutputNode> for VideoOutputNodeConfig {
    fn from(_: mizer_nodes::VideoOutputNode) -> Self {
        Default::default()
    }
}

impl From<VideoOutputNodeConfig> for mizer_nodes::VideoOutputNode {
    fn from(_: VideoOutputNodeConfig) -> Self {
        Default::default()
    }
}

impl From<mizer_nodes::VideoEffectNode> for VideoEffectNodeConfig {
    fn from(_: mizer_nodes::VideoEffectNode) -> Self {
        Default::default()
    }
}

impl From<VideoEffectNodeConfig> for mizer_nodes::VideoEffectNode {
    fn from(_: VideoEffectNodeConfig) -> Self {
        Default::default()
    }
}

impl From<mizer_nodes::VideoTransformNode> for VideoTransformNodeConfig {
    fn from(_: mizer_nodes::VideoTransformNode) -> Self {
        Default::default()
    }
}

impl From<VideoTransformNodeConfig> for mizer_nodes::VideoTransformNode {
    fn from(_: VideoTransformNodeConfig) -> Self {
        Default::default()
    }
}

impl From<mizer_nodes::SelectNode> for SelectNodeConfig {
    fn from(_: mizer_nodes::SelectNode) -> Self {
        Default::default()
    }
}

impl From<SelectNodeConfig> for mizer_nodes::SelectNode {
    fn from(_: SelectNodeConfig) -> Self {
        Default::default()
    }
}

impl From<mizer_nodes::MergeNode> for MergeNodeConfig {
    fn from(node: mizer_nodes::MergeNode) -> Self {
        Self {
            mode: node.mode.into(),
            ..Default::default()
        }
    }
}

impl From<MergeNodeConfig> for mizer_nodes::MergeNode {
    fn from(config: MergeNodeConfig) -> Self {
        Self {
            mode: config.mode.into(),
        }
    }
}

impl From<mizer_nodes::MergeMode> for MergeNodeConfig_MergeMode {
    fn from(mode: mizer_nodes::MergeMode) -> Self {
        use mizer_nodes::MergeMode::*;

        match mode {
            Latest => Self::Latest,
            Highest => Self::Highest,
            Lowest => Self::Lowest,
        }
    }
}

impl From<MergeNodeConfig_MergeMode> for mizer_nodes::MergeMode {
    fn from(mode: MergeNodeConfig_MergeMode) -> Self {
        use MergeNodeConfig_MergeMode::*;

        match mode {
            Latest => Self::Latest,
            Highest => Self::Highest,
            Lowest => Self::Lowest,
        }
    }
}

impl From<mizer_nodes::ThresholdNode> for ThresholdNodeConfig {
    fn from(node: mizer_nodes::ThresholdNode) -> Self {
        Self {
            lower_threshold: node.lower_threshold,
            upper_threshold: node.upper_threshold,
            active_value: node.active_value,
            inactive_value: node.inactive_value,
            ..Default::default()
        }
    }
}

impl From<ThresholdNodeConfig> for mizer_nodes::ThresholdNode {
    fn from(config: ThresholdNodeConfig) -> Self {
        Self {
            lower_threshold: config.lower_threshold,
            upper_threshold: config.upper_threshold,
            active_value: config.active_value,
            inactive_value: config.inactive_value,
        }
    }
}

impl From<mizer_nodes::HsvColorNode> for ColorHsvNodeConfig {
    fn from(_: mizer_nodes::HsvColorNode) -> Self {
        Default::default()
    }
}

impl From<ColorHsvNodeConfig> for mizer_nodes::HsvColorNode {
    fn from(_: ColorHsvNodeConfig) -> Self {
        Default::default()
    }
}

impl From<mizer_nodes::RgbColorNode> for ColorRgbNodeConfig {
    fn from(_: mizer_nodes::RgbColorNode) -> Self {
        Default::default()
    }
}

impl From<ColorRgbNodeConfig> for mizer_nodes::RgbColorNode {
    fn from(_: ColorRgbNodeConfig) -> Self {
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
            NodeType::Programmer => Node_NodeType::Programmer,
            NodeType::Group => Node_NodeType::Group,
            NodeType::Preset => Node_NodeType::Preset,
            NodeType::Sequencer => Node_NodeType::Sequencer,
            NodeType::Sequence => Node_NodeType::Sequence,
            NodeType::Envelope => Node_NodeType::Envelope,
            NodeType::Select => Node_NodeType::Select,
            NodeType::Merge => Node_NodeType::Merge,
            NodeType::Threshold => Node_NodeType::Threshold,
            NodeType::MidiInput => Node_NodeType::MidiInput,
            NodeType::MidiOutput => Node_NodeType::MidiOutput,
            NodeType::Laser => Node_NodeType::Laser,
            NodeType::IldaFile => Node_NodeType::IldaFile,
            NodeType::ColorHsv => Node_NodeType::ColorHsv,
            NodeType::ColorRgb => Node_NodeType::ColorRgb,
            NodeType::Gamepad => Node_NodeType::Gamepad,
            NodeType::TestSink => unimplemented!("only for test"),
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
            Node_NodeType::Programmer => NodeType::Programmer,
            Node_NodeType::Group => NodeType::Group,
            Node_NodeType::Preset => NodeType::Preset,
            Node_NodeType::Sequencer => NodeType::Sequencer,
            Node_NodeType::Sequence => NodeType::Sequence,
            Node_NodeType::Envelope => NodeType::Envelope,
            Node_NodeType::Select => NodeType::Select,
            Node_NodeType::Merge => NodeType::Merge,
            Node_NodeType::Threshold => NodeType::Threshold,
            Node_NodeType::MidiInput => NodeType::MidiInput,
            Node_NodeType::MidiOutput => NodeType::MidiOutput,
            Node_NodeType::Laser => NodeType::Laser,
            Node_NodeType::IldaFile => NodeType::IldaFile,
            Node_NodeType::ColorHsv => NodeType::ColorHsv,
            Node_NodeType::ColorRgb => NodeType::ColorRgb,
            Node_NodeType::Gamepad => NodeType::Gamepad,
        }
    }
}

impl From<NodeDescriptor<'_>> for Node {
    fn from(descriptor: NodeDescriptor<'_>) -> Self {
        let details = descriptor.node.value().details();
        let node_type = descriptor.node_type();
        let mut node = Node {
            path: descriptor.path.to_string(),
            field_type: node_type.into(),
            config: SingularPtrField::some(descriptor.downcast().into()),
            designer: SingularPtrField::some(descriptor.designer.into()),
            preview: details.preview_type.into(),
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

impl From<StaticNodeDescriptor> for Node {
    fn from(descriptor: StaticNodeDescriptor) -> Self {
        let mut node = Node {
            path: descriptor.path.to_string(),
            field_type: descriptor.node_type.into(),
            config: SingularPtrField::some(descriptor.config.into()),
            designer: SingularPtrField::some(descriptor.designer.into()),
            preview: descriptor.details.preview_type.into(),
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
            PortType::Gstreamer => ChannelProtocol::GST,
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
            ChannelProtocol::GST => PortType::Gstreamer,
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

impl From<PreviewType> for Node_NodePreviewType {
    fn from(preview: PreviewType) -> Self {
        match preview {
            PreviewType::History => Node_NodePreviewType::History,
            PreviewType::Waveform => Node_NodePreviewType::Waveform,
            PreviewType::Multiple => Node_NodePreviewType::Multiple,
            PreviewType::Texture => Node_NodePreviewType::Texture,
            PreviewType::None => Node_NodePreviewType::None,
        }
    }
}
