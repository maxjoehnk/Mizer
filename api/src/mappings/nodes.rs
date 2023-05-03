use mizer_node::{NodeLink, NodeType, PortDirection, PortId, PortMetadata, PortType, PreviewType};
use mizer_nodes::{MidiInputConfig, MidiOutputConfig, OscArgumentType};
use mizer_runtime::commands::StaticNodeDescriptor;
use mizer_runtime::{NodeDescriptor, NodeDowncast};
use protobuf::{EnumOrUnknown, MessageField};
use std::path::Path;

use crate::models::nodes::*;

impl From<mizer_nodes::Node> for node_config::Type {
    fn from(node: mizer_nodes::Node) -> Self {
        use mizer_nodes::Node::*;
        match node {
            Clock(clock) => Self::ClockConfig(clock.into()),
            Oscillator(oscillator) => Self::OscillatorConfig(oscillator.into()),
            DmxOutput(dmx_output) => Self::DmxOutputConfig(dmx_output.into()),
            Scripting(scripting) => Self::ScriptingConfig(scripting.into()),
            Sequence(sequence) => Self::SequenceConfig(sequence.into()),
            Envelope(envelope) => Self::EnvelopeConfig(envelope.into()),
            Select(select) => Self::SelectConfig(select.into()),
            Merge(merge) => Self::MergeConfig(merge.into()),
            Threshold(threshold) => Self::ThresholdConfig(threshold.into()),
            Encoder(node) => Self::EncoderConfig(node.into()),
            Fixture(fixture) => Self::FixtureConfig(fixture.into()),
            Programmer(programmer) => Self::ProgrammerConfig(programmer.into()),
            Group(group) => Self::GroupConfig(group.into()),
            Preset(preset) => Self::PresetConfig(preset.into()),
            Sequencer(sequencer) => Self::SequencerConfig(sequencer.into()),
            IldaFile(ilda) => Self::IldaFileConfig(ilda.into()),
            Laser(laser) => Self::LaserConfig(laser.into()),
            Fader(fader) => Self::FaderConfig(fader.into()),
            Button(button) => Self::ButtonConfig(button.into()),
            Label(label) => Self::LabelConfig(label.into()),
            MidiInput(midi_input) => Self::MidiInputConfig(midi_input.into()),
            MidiOutput(midi_output) => Self::MidiOutputConfig(midi_output.into()),
            OpcOutput(opc) => Self::OpcOutputConfig(opc.into()),
            PixelPattern(pattern) => Self::PixelPatternConfig(pattern.into()),
            PixelDmx(dmx) => Self::PixelDmxConfig(dmx.into()),
            OscInput(osc) => Self::OscInputConfig(osc.into()),
            OscOutput(osc) => Self::OscOutputConfig(osc.into()),
            VideoFile(file) => Self::VideoFileConfig(file.into()),
            VideoColorBalance(color_balance) => Self::VideoColorBalanceConfig(color_balance.into()),
            VideoOutput(output) => Self::VideoOutputConfig(output.into()),
            VideoEffect(effect) => Self::VideoEffectConfig(effect.into()),
            VideoTransform(transform) => Self::VideoTransformConfig(transform.into()),
            ColorRgb(node) => Self::ColorRgbConfig(node.into()),
            ColorHsv(node) => Self::ColorHsvConfig(node.into()),
            Gamepad(node) => Self::GamepadNodeConfig(node.into()),
            Container(node) => Self::ContainerConfig(node.into()),
            Math(node) => Self::MathConfig(node.into()),
            MqttInput(node) => Self::MqttInputConfig(node.into()),
            MqttOutput(node) => Self::MqttOutputConfig(node.into()),
            NumberToData(node) => Self::NumberToDataConfig(node.into()),
            DataToNumber(node) => Self::DataToNumberConfig(node.into()),
            Value(node) => Self::ValueConfig(node.into()),
            Extract(node) => Self::ExtractConfig(node.into()),
            PlanScreen(node) => Self::PlanScreenConfig(node.into()),
            Delay(node) => Self::DelayConfig(node.into()),
            Ramp(node) => Self::RampConfig(node.into()),
            Noise(node) => Self::NoiseConfig(node.into()),
            Transport(node) => Self::TransportConfig(node.into()),
            G13Input(node) => Self::G13InputConfig(node.into()),
            G13Output(node) => Self::G13OutputConfig(node.into()),
            ConstantNumber(node) => Self::ConstantNumberConfig(node.into()),
            Conditional(node) => Self::ConditionalConfig(node.into()),
            TimecodeControl(node) => Self::TimecodeControlConfig(node.into()),
            TimecodeOutput(node) => Self::TimecodeOutputConfig(node.into()),
            AudioFile(node) => Self::AudioFileConfig(node.into()),
            AudioOutput(node) => Self::AudioOutputConfig(node.into()),
            AudioVolume(node) => Self::AudioVolumeConfig(node.into()),
            AudioInput(node) => Self::AudioInputConfig(node.into()),
            AudioMix(node) => Self::AudioMixConfig(node.into()),
            AudioMeter(node) => Self::AudioMeterConfig(node.into()),
            Template(node) => Self::TemplateConfig(node.into()),
            TestSink(_) => unimplemented!("Only for test"),
        }
    }
}

impl From<node_config::Type> for mizer_nodes::Node {
    fn from(node_config: node_config::Type) -> Self {
        match node_config {
            node_config::Type::ClockConfig(clock) => Self::Clock(clock.into()),
            node_config::Type::OscillatorConfig(oscillator) => Self::Oscillator(oscillator.into()),
            node_config::Type::DmxOutputConfig(dmx_output) => Self::DmxOutput(dmx_output.into()),
            node_config::Type::ScriptingConfig(scripting) => Self::Scripting(scripting.into()),
            node_config::Type::SequenceConfig(sequence) => Self::Sequence(sequence.into()),
            node_config::Type::EnvelopeConfig(envelope) => Self::Envelope(envelope.into()),
            node_config::Type::SelectConfig(select) => Self::Select(select.into()),
            node_config::Type::MergeConfig(merge) => Self::Merge(merge.into()),
            node_config::Type::ThresholdConfig(threshold) => Self::Threshold(threshold.into()),
            node_config::Type::EncoderConfig(config) => Self::Encoder(config.into()),
            node_config::Type::FixtureConfig(fixture) => Self::Fixture(fixture.into()),
            node_config::Type::ProgrammerConfig(programmer) => Self::Programmer(programmer.into()),
            node_config::Type::GroupConfig(group) => Self::Group(group.into()),
            node_config::Type::PresetConfig(preset) => Self::Preset(preset.into()),
            node_config::Type::SequencerConfig(sequencer) => Self::Sequencer(sequencer.into()),
            node_config::Type::IldaFileConfig(ilda) => Self::IldaFile(ilda.into()),
            node_config::Type::LaserConfig(laser) => Self::Laser(laser.into()),
            node_config::Type::FaderConfig(fader) => Self::Fader(fader.into()),
            node_config::Type::ButtonConfig(button) => Self::Button(button.into()),
            node_config::Type::LabelConfig(label) => Self::Label(label.into()),
            node_config::Type::MidiInputConfig(midi_input) => Self::MidiInput(midi_input.into()),
            node_config::Type::MidiOutputConfig(midi_output) => {
                Self::MidiOutput(midi_output.into())
            }
            node_config::Type::OpcOutputConfig(opc) => Self::OpcOutput(opc.into()),
            node_config::Type::PixelPatternConfig(pattern) => Self::PixelPattern(pattern.into()),
            node_config::Type::PixelDmxConfig(dmx) => Self::PixelDmx(dmx.into()),
            node_config::Type::OscInputConfig(osc) => Self::OscInput(osc.into()),
            node_config::Type::OscOutputConfig(osc) => Self::OscOutput(osc.into()),
            node_config::Type::VideoFileConfig(file) => Self::VideoFile(file.into()),
            node_config::Type::VideoColorBalanceConfig(color_balance) => {
                Self::VideoColorBalance(color_balance.into())
            }
            node_config::Type::VideoOutputConfig(output) => Self::VideoOutput(output.into()),
            node_config::Type::VideoEffectConfig(effect) => Self::VideoEffect(effect.into()),
            node_config::Type::VideoTransformConfig(transform) => {
                Self::VideoTransform(transform.into())
            }
            node_config::Type::ColorRgbConfig(node) => Self::ColorRgb(node.into()),
            node_config::Type::ColorHsvConfig(node) => Self::ColorHsv(node.into()),
            node_config::Type::GamepadNodeConfig(node) => Self::Gamepad(node.into()),
            node_config::Type::ContainerConfig(node) => Self::Container(node.into()),
            node_config::Type::MathConfig(node) => Self::Math(node.into()),
            node_config::Type::MqttInputConfig(node) => Self::MqttInput(node.into()),
            node_config::Type::MqttOutputConfig(node) => Self::MqttOutput(node.into()),
            node_config::Type::NumberToDataConfig(node) => Self::NumberToData(node.into()),
            node_config::Type::DataToNumberConfig(node) => Self::DataToNumber(node.into()),
            node_config::Type::ValueConfig(node) => Self::Value(node.into()),
            node_config::Type::ExtractConfig(node) => Self::Extract(node.into()),
            node_config::Type::DelayConfig(node) => Self::Delay(node.into()),
            node_config::Type::RampConfig(node) => Self::Ramp(node.into()),
            node_config::Type::NoiseConfig(node) => Self::Noise(node.into()),
            node_config::Type::TransportConfig(node) => Self::Transport(node.into()),
            node_config::Type::G13InputConfig(node) => Self::G13Input(node.into()),
            node_config::Type::G13OutputConfig(node) => Self::G13Output(node.into()),
            node_config::Type::PlanScreenConfig(node) => Self::PlanScreen(node.into()),
            node_config::Type::ConstantNumberConfig(node) => Self::ConstantNumber(node.into()),
            node_config::Type::ConditionalConfig(node) => Self::Conditional(node.into()),
            node_config::Type::TimecodeControlConfig(node) => Self::TimecodeControl(node.into()),
            node_config::Type::TimecodeOutputConfig(node) => Self::TimecodeOutput(node.into()),
            node_config::Type::AudioFileConfig(node) => Self::AudioFile(node.into()),
            node_config::Type::AudioOutputConfig(node) => Self::AudioOutput(node.into()),
            node_config::Type::AudioVolumeConfig(node) => Self::AudioVolume(node.into()),
            node_config::Type::AudioInputConfig(node) => Self::AudioInput(node.into()),
            node_config::Type::AudioMixConfig(node) => Self::AudioMix(node.into()),
            node_config::Type::AudioMeterConfig(node) => Self::AudioMeter(node.into()),
            node_config::Type::TemplateConfig(node) => Self::Template(node.into()),
        }
    }
}

impl From<mizer_nodes::Node> for NodeConfig {
    fn from(node: mizer_nodes::Node) -> Self {
        let config: node_config::Type = node.into();
        NodeConfig {
            type_: Some(config),
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
            type_: EnumOrUnknown::new(oscillator.oscillator_type.into()),
            offset: oscillator.offset,
            min: oscillator.min,
            max: oscillator.max,
            ratio: oscillator.interval,
            reverse: oscillator.reverse,
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::OscillatorType> for oscillator_node_config::OscillatorType {
    fn from(oscillator_type: mizer_nodes::OscillatorType) -> Self {
        use mizer_nodes::OscillatorType::*;

        match oscillator_type {
            Sine => Self::SINE,
            Saw => Self::SAW,
            Square => Self::SQUARE,
            Triangle => Self::TRIANGLE,
        }
    }
}

impl From<OscillatorNodeConfig> for mizer_nodes::OscillatorNode {
    fn from(oscillator: OscillatorNodeConfig) -> Self {
        Self {
            oscillator_type: oscillator.type_.unwrap().into(),
            offset: oscillator.offset,
            min: oscillator.min,
            max: oscillator.max,
            interval: oscillator.ratio,
            reverse: oscillator.reverse,
        }
    }
}

impl From<oscillator_node_config::OscillatorType> for mizer_nodes::OscillatorType {
    fn from(oscillator_type: oscillator_node_config::OscillatorType) -> Self {
        use oscillator_node_config::OscillatorType::*;

        match oscillator_type {
            SINE => Self::Sine,
            SAW => Self::Saw,
            SQUARE => Self::Square,
            TRIANGLE => Self::Triangle,
        }
    }
}

impl From<mizer_nodes::DmxOutputNode> for DmxOutputNodeConfig {
    fn from(output: mizer_nodes::DmxOutputNode) -> Self {
        Self {
            channel: output.channel as u32,
            universe: output.universe as u32,
            output: output.output,
            ..Default::default()
        }
    }
}

impl From<DmxOutputNodeConfig> for mizer_nodes::DmxOutputNode {
    fn from(output: DmxOutputNodeConfig) -> Self {
        Self {
            channel: output.channel as u16,
            universe: output.universe as u16,
            output: output.output,
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
                .map(sequence_node_config::SequenceStep::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::SequenceStep> for sequence_node_config::SequenceStep {
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

impl From<sequence_node_config::SequenceStep> for mizer_nodes::SequenceStep {
    fn from(step: sequence_node_config::SequenceStep) -> Self {
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
    fn from(node: mizer_nodes::GroupNode) -> Self {
        Self {
            group_id: node.id.into(),
            ..Default::default()
        }
    }
}

impl From<GroupNodeConfig> for mizer_nodes::GroupNode {
    fn from(node: GroupNodeConfig) -> Self {
        Self {
            id: node.group_id.into(),
            ..Default::default()
        }
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
            control: EnumOrUnknown::new(gamepad.control.into()),
            ..Default::default()
        }
    }
}

impl From<GamepadNodeConfig> for mizer_nodes::GamepadNode {
    fn from(gamepad: GamepadNodeConfig) -> Self {
        Self {
            device_id: gamepad.device_id,
            control: gamepad.control.unwrap().into(),
        }
    }
}

impl From<mizer_nodes::GamepadControl> for gamepad_node_config::Control {
    fn from(control: mizer_nodes::GamepadControl) -> Self {
        use mizer_nodes::GamepadControl::*;

        match control {
            LeftStickX => Self::LEFT_STICK_X,
            LeftStickY => Self::LEFT_STICK_Y,
            RightStickX => Self::RIGHT_STICK_X,
            RightStickY => Self::RIGHT_STICK_Y,
            LeftTrigger => Self::LEFT_TRIGGER,
            RightTrigger => Self::RIGHT_TRIGGER,
            LeftShoulder => Self::LEFT_SHOULDER,
            RightShoulder => Self::RIGHT_SHOULDER,
            South => Self::SOUTH,
            East => Self::EAST,
            North => Self::NORTH,
            West => Self::WEST,
            Select => Self::SELECT,
            Start => Self::START,
            Mode => Self::MODE,
            DpadUp => Self::DPAD_UP,
            DpadDown => Self::DPAD_DOWN,
            DpadLeft => Self::DPAD_LEFT,
            DpadRight => Self::DPAD_RIGHT,
            LeftStick => Self::LEFT_STICK,
            RightStick => Self::RIGHT_STICK,
        }
    }
}

impl From<gamepad_node_config::Control> for mizer_nodes::GamepadControl {
    fn from(control: gamepad_node_config::Control) -> Self {
        use gamepad_node_config::Control::*;

        match control {
            LEFT_STICK_X => Self::LeftStickX,
            LEFT_STICK_Y => Self::LeftStickY,
            RIGHT_STICK_X => Self::RightStickX,
            RIGHT_STICK_Y => Self::RightStickY,
            LEFT_TRIGGER => Self::LeftTrigger,
            RIGHT_TRIGGER => Self::RightTrigger,
            LEFT_SHOULDER => Self::LeftShoulder,
            RIGHT_SHOULDER => Self::RightShoulder,
            SOUTH => Self::South,
            EAST => Self::East,
            NORTH => Self::North,
            WEST => Self::West,
            SELECT => Self::Select,
            START => Self::Start,
            MODE => Self::Mode,
            DPAD_UP => Self::DpadUp,
            DPAD_DOWN => Self::DpadDown,
            DPAD_LEFT => Self::DpadLeft,
            DPAD_RIGHT => Self::DpadRight,
            LEFT_STICK => Self::LeftStick,
            RIGHT_STICK => Self::RightStick,
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
            } => midi_node_config::Binding::NoteBinding(midi_node_config::NoteBinding {
                channel: channel as u32,
                type_: midi_node_config::note_binding::MidiType::CC.into(),
                port: port as u32,
                range_from: range.0 as u32,
                range_to: range.1 as u32,
                ..Default::default()
            }),
            mizer_nodes::MidiInputConfig::Note {
                channel,
                port,
                range,
            } => midi_node_config::Binding::NoteBinding(midi_node_config::NoteBinding {
                channel: channel as u32,
                type_: midi_node_config::note_binding::MidiType::NOTE.into(),
                port: port as u32,
                range_from: range.0 as u32,
                range_to: range.1 as u32,
                ..Default::default()
            }),
            mizer_nodes::MidiInputConfig::Control { page, control } => {
                midi_node_config::Binding::ControlBinding(midi_node_config::ControlBinding {
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
                Some(midi_node_config::Binding::NoteBinding(binding)) => {
                    match binding.type_.unwrap() {
                        midi_node_config::note_binding::MidiType::CC => MidiInputConfig::CC {
                            channel: binding.channel as u8,
                            port: binding.port as u8,
                            range: (binding.range_from as u8, binding.range_to as u8),
                        },
                        midi_node_config::note_binding::MidiType::NOTE => MidiInputConfig::Note {
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

impl From<mizer_nodes::MidiOutputNode> for MidiNodeConfig {
    fn from(node: mizer_nodes::MidiOutputNode) -> Self {
        let binding = match node.config {
            mizer_nodes::MidiOutputConfig::CC {
                channel,
                port,
                range,
            } => midi_node_config::Binding::NoteBinding(midi_node_config::NoteBinding {
                channel: channel as u32,
                type_: midi_node_config::note_binding::MidiType::CC.into(),
                port: port as u32,
                range_from: range.0 as u32,
                range_to: range.1 as u32,
                ..Default::default()
            }),
            mizer_nodes::MidiOutputConfig::Note {
                channel,
                port,
                range,
            } => midi_node_config::Binding::NoteBinding(midi_node_config::NoteBinding {
                channel: channel as u32,
                type_: midi_node_config::note_binding::MidiType::NOTE.into(),
                port: port as u32,
                range_from: range.0 as u32,
                range_to: range.1 as u32,
                ..Default::default()
            }),
            mizer_nodes::MidiOutputConfig::Control { page, control } => {
                midi_node_config::Binding::ControlBinding(midi_node_config::ControlBinding {
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
                Some(midi_node_config::Binding::NoteBinding(binding)) => {
                    match binding.type_.unwrap() {
                        midi_node_config::note_binding::MidiType::CC => MidiOutputConfig::CC {
                            channel: binding.channel as u8,
                            port: binding.port as u8,
                            range: (binding.range_from as u8, binding.range_to as u8),
                        },
                        midi_node_config::note_binding::MidiType::NOTE => MidiOutputConfig::Note {
                            channel: binding.channel as u8,
                            port: binding.port as u8,
                            range: (binding.range_from as u8, binding.range_to as u8),
                        },
                    }
                }
                Some(midi_node_config::Binding::ControlBinding(binding)) => {
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
            pattern: EnumOrUnknown::new(node.pattern.into()),
            ..Default::default()
        }
    }
}

impl From<PixelPatternNodeConfig> for mizer_nodes::PixelPatternGeneratorNode {
    fn from(node: PixelPatternNodeConfig) -> Self {
        Self {
            pattern: node.pattern.unwrap().into(),
        }
    }
}

impl From<mizer_nodes::Pattern> for pixel_pattern_node_config::Pattern {
    fn from(pattern: mizer_nodes::Pattern) -> Self {
        use mizer_nodes::Pattern::*;

        match pattern {
            RgbIterate => Self::RGB_ITERATE,
            RgbSnake => Self::RGB_SNAKE,
        }
    }
}

impl From<pixel_pattern_node_config::Pattern> for mizer_nodes::Pattern {
    fn from(pattern: pixel_pattern_node_config::Pattern) -> Self {
        use pixel_pattern_node_config::Pattern::*;

        match pattern {
            RGB_ITERATE => Self::RgbIterate,
            RGB_SNAKE => Self::RgbSnake,
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
            connection: node.connection,
            path: node.path,
            argument_type: EnumOrUnknown::new(node.argument_type.into()),
            ..Default::default()
        }
    }
}

impl From<OscNodeConfig> for mizer_nodes::OscInputNode {
    fn from(node: OscNodeConfig) -> Self {
        Self {
            connection: node.connection,
            path: node.path,
            argument_type: node.argument_type.unwrap().into(),
        }
    }
}

impl From<mizer_nodes::OscOutputNode> for OscNodeConfig {
    fn from(node: mizer_nodes::OscOutputNode) -> Self {
        Self {
            connection: node.connection,
            path: node.path,
            argument_type: EnumOrUnknown::new(node.argument_type.into()),
            only_emit_changes: node.only_emit_changes,
            ..Default::default()
        }
    }
}

impl From<OscNodeConfig> for mizer_nodes::OscOutputNode {
    fn from(node: OscNodeConfig) -> Self {
        Self {
            connection: node.connection,
            path: node.path,
            argument_type: node.argument_type.unwrap().into(),
            only_emit_changes: node.only_emit_changes,
        }
    }
}

impl From<osc_node_config::ArgumentType> for mizer_nodes::OscArgumentType {
    fn from(argument_type: osc_node_config::ArgumentType) -> Self {
        use osc_node_config::ArgumentType::*;

        match argument_type {
            BOOL => Self::Bool,
            INT => Self::Int,
            DOUBLE => Self::Double,
            FLOAT => Self::Float,
            LONG => Self::Long,
            COLOR => Self::Color,
        }
    }
}

impl From<mizer_nodes::OscArgumentType> for osc_node_config::ArgumentType {
    fn from(argument_type: OscArgumentType) -> Self {
        use OscArgumentType::*;

        match argument_type {
            Bool => Self::BOOL,
            Int => Self::INT,
            Double => Self::DOUBLE,
            Float => Self::FLOAT,
            Long => Self::LONG,
            Color => Self::COLOR,
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
            mode: EnumOrUnknown::new(node.mode.into()),
            ..Default::default()
        }
    }
}

impl From<MergeNodeConfig> for mizer_nodes::MergeNode {
    fn from(config: MergeNodeConfig) -> Self {
        Self {
            mode: config.mode.unwrap().into(),
        }
    }
}

impl From<mizer_nodes::MergeMode> for merge_node_config::MergeMode {
    fn from(mode: mizer_nodes::MergeMode) -> Self {
        use mizer_nodes::MergeMode::*;

        match mode {
            Latest => Self::LATEST,
            Highest => Self::HIGHEST,
            Lowest => Self::LOWEST,
        }
    }
}

impl From<merge_node_config::MergeMode> for mizer_nodes::MergeMode {
    fn from(mode: merge_node_config::MergeMode) -> Self {
        use merge_node_config::MergeMode::*;

        match mode {
            LATEST => Self::Latest,
            HIGHEST => Self::Highest,
            LOWEST => Self::Lowest,
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

impl From<mizer_nodes::EncoderNode> for EncoderNodeConfig {
    fn from(node: mizer_nodes::EncoderNode) -> Self {
        Self {
            hold_rate: node.hold_rate,
            ..Default::default()
        }
    }
}

impl From<EncoderNodeConfig> for mizer_nodes::EncoderNode {
    fn from(config: EncoderNodeConfig) -> Self {
        Self {
            hold_rate: config.hold_rate,
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

impl From<mizer_nodes::MathNode> for MathNodeConfig {
    fn from(node: mizer_nodes::MathNode) -> Self {
        Self {
            mode: EnumOrUnknown::new(node.mode.into()),
            ..Default::default()
        }
    }
}

impl From<MathNodeConfig> for mizer_nodes::MathNode {
    fn from(config: MathNodeConfig) -> Self {
        Self {
            mode: config.mode.unwrap().into(),
        }
    }
}

impl From<mizer_nodes::MathMode> for math_node_config::Mode {
    fn from(mode: mizer_nodes::MathMode) -> Self {
        use mizer_nodes::MathMode::*;

        match mode {
            Addition => Self::ADDITION,
            Subtraction => Self::SUBTRACTION,
            Division => Self::DIVISION,
            Multiplication => Self::MULTIPLICATION,
            Invert => Self::INVERT,
            Sine => Self::SINE,
            Cosine => Self::COSINE,
            Tangent => Self::TANGENT,
        }
    }
}

impl From<math_node_config::Mode> for mizer_nodes::MathMode {
    fn from(mode: math_node_config::Mode) -> Self {
        use math_node_config::Mode::*;

        match mode {
            ADDITION => Self::Addition,
            SUBTRACTION => Self::Subtraction,
            DIVISION => Self::Division,
            MULTIPLICATION => Self::Multiplication,
            INVERT => Self::Invert,
            SINE => Self::Sine,
            COSINE => Self::Cosine,
            TANGENT => Self::Tangent,
        }
    }
}

impl From<mizer_nodes::MqttInputNode> for MqttInputNodeConfig {
    fn from(node: mizer_nodes::MqttInputNode) -> Self {
        Self {
            connection: node.connection,
            path: node.path,
            ..Default::default()
        }
    }
}

impl From<MqttInputNodeConfig> for mizer_nodes::MqttInputNode {
    fn from(config: MqttInputNodeConfig) -> Self {
        Self {
            connection: config.connection,
            path: config.path,
        }
    }
}

impl From<mizer_nodes::MqttOutputNode> for MqttOutputNodeConfig {
    fn from(node: mizer_nodes::MqttOutputNode) -> Self {
        Self {
            connection: node.connection,
            path: node.path,
            retain: node.retain,
            ..Default::default()
        }
    }
}

impl From<MqttOutputNodeConfig> for mizer_nodes::MqttOutputNode {
    fn from(config: MqttOutputNodeConfig) -> Self {
        Self {
            connection: config.connection,
            path: config.path,
            retain: config.retain,
        }
    }
}

impl From<mizer_nodes::NumberToDataNode> for NumberToDataNodeConfig {
    fn from(_node: mizer_nodes::NumberToDataNode) -> Self {
        Self {
            ..Default::default()
        }
    }
}

impl From<NumberToDataNodeConfig> for mizer_nodes::NumberToDataNode {
    fn from(_config: NumberToDataNodeConfig) -> Self {
        Self::default()
    }
}

impl From<mizer_nodes::DataToNumberNode> for DataToNumberNodeConfig {
    fn from(_node: mizer_nodes::DataToNumberNode) -> Self {
        Self {
            ..Default::default()
        }
    }
}

impl From<DataToNumberNodeConfig> for mizer_nodes::DataToNumberNode {
    fn from(_config: DataToNumberNodeConfig) -> Self {
        Self::default()
    }
}

impl From<PlanScreenNodeConfig> for mizer_nodes::PlanScreenNode {
    fn from(config: PlanScreenNodeConfig) -> Self {
        Self {
            plan: config.plan_id,
            screen_id: config.screen_id.into(),
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::PlanScreenNode> for PlanScreenNodeConfig {
    fn from(node: mizer_nodes::PlanScreenNode) -> Self {
        Self {
            plan_id: node.plan,
            screen_id: node.screen_id.into(),
            ..Default::default()
        }
    }
}

impl From<ValueNodeConfig> for mizer_nodes::ValueNode {
    fn from(config: ValueNodeConfig) -> Self {
        Self {
            value: config.value,
        }
    }
}

impl From<mizer_nodes::ValueNode> for ValueNodeConfig {
    fn from(node: mizer_nodes::ValueNode) -> Self {
        Self {
            value: node.value,
            ..Default::default()
        }
    }
}

impl From<ExtractNodeConfig> for mizer_nodes::ExtractNode {
    fn from(config: ExtractNodeConfig) -> Self {
        Self { path: config.path }
    }
}

impl From<mizer_nodes::ExtractNode> for ExtractNodeConfig {
    fn from(node: mizer_nodes::ExtractNode) -> Self {
        Self {
            path: node.path,
            ..Default::default()
        }
    }
}

impl From<TemplateNodeConfig> for mizer_nodes::TemplateNode {
    fn from(config: TemplateNodeConfig) -> Self {
        Self {
            template: config.template,
        }
    }
}

impl From<mizer_nodes::TemplateNode> for TemplateNodeConfig {
    fn from(node: mizer_nodes::TemplateNode) -> Self {
        Self {
            template: node.template,
            ..Default::default()
        }
    }
}

impl From<DelayNodeConfig> for mizer_nodes::DelayNode {
    fn from(config: DelayNodeConfig) -> Self {
        Self {
            buffer_size: config.buffer_size as usize,
        }
    }
}

impl From<mizer_nodes::DelayNode> for DelayNodeConfig {
    fn from(node: mizer_nodes::DelayNode) -> Self {
        Self {
            buffer_size: node.buffer_size as u32,
            ..Default::default()
        }
    }
}

impl From<RampNodeConfig> for mizer_nodes::RampNode {
    fn from(config: RampNodeConfig) -> Self {
        Self {
            spline: mizer_util::Spline {
                steps: config
                    .steps
                    .into_iter()
                    .map(mizer_util::SplineStep::from)
                    .collect(),
            },
        }
    }
}

impl From<ramp_node_config::RampStep> for mizer_util::SplineStep {
    fn from(step: ramp_node_config::RampStep) -> Self {
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

impl From<mizer_nodes::RampNode> for RampNodeConfig {
    fn from(node: mizer_nodes::RampNode) -> Self {
        Self {
            steps: node
                .spline
                .steps
                .into_iter()
                .map(ramp_node_config::RampStep::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_util::SplineStep> for ramp_node_config::RampStep {
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

impl From<NoiseNodeConfig> for mizer_nodes::NoiseNode {
    fn from(config: NoiseNodeConfig) -> Self {
        Self {
            tick_rate: config.tick_rate,
            fade: config.fade,
        }
    }
}

impl From<mizer_nodes::NoiseNode> for NoiseNodeConfig {
    fn from(node: mizer_nodes::NoiseNode) -> Self {
        Self {
            tick_rate: node.tick_rate,
            fade: node.fade,
            ..Default::default()
        }
    }
}

impl From<LabelNodeConfig> for mizer_nodes::LabelNode {
    fn from(config: LabelNodeConfig) -> Self {
        Self { text: config.text }
    }
}

impl From<mizer_nodes::LabelNode> for LabelNodeConfig {
    fn from(node: mizer_nodes::LabelNode) -> Self {
        Self {
            text: node.text,
            ..Default::default()
        }
    }
}

impl From<TransportNodeConfig> for mizer_nodes::TransportNode {
    fn from(_: TransportNodeConfig) -> Self {
        Self
    }
}

impl From<mizer_nodes::TransportNode> for TransportNodeConfig {
    fn from(_: mizer_nodes::TransportNode) -> Self {
        Self {
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::G13InputNode> for G13InputNodeConfig {
    fn from(g13: mizer_nodes::G13InputNode) -> Self {
        Self {
            device_id: g13.device_id,
            key: EnumOrUnknown::new(g13.key.into()),
            ..Default::default()
        }
    }
}

impl From<G13InputNodeConfig> for mizer_nodes::G13InputNode {
    fn from(g13: G13InputNodeConfig) -> Self {
        Self {
            device_id: g13.device_id,
            key: g13.key.unwrap().into(),
        }
    }
}

impl From<mizer_nodes::G13Key> for g13input_node_config::Key {
    fn from(key: mizer_nodes::G13Key) -> Self {
        use mizer_nodes::G13Key::*;

        match key {
            G1 => Self::G1,
            G2 => Self::G2,
            G3 => Self::G3,
            G4 => Self::G4,
            G5 => Self::G5,
            G6 => Self::G6,
            G7 => Self::G7,
            G8 => Self::G8,
            G9 => Self::G9,
            G10 => Self::G10,
            G11 => Self::G11,
            G12 => Self::G12,
            G13 => Self::G13,
            G14 => Self::G14,
            G15 => Self::G15,
            G16 => Self::G16,
            G17 => Self::G17,
            G18 => Self::G18,
            G19 => Self::G19,
            G20 => Self::G20,
            G21 => Self::G21,
            G22 => Self::G22,
            M1 => Self::M1,
            M2 => Self::M2,
            M3 => Self::M3,
            MR => Self::MR,
            L1 => Self::L1,
            L2 => Self::L2,
            L3 => Self::L3,
            L4 => Self::L4,
            Joystick => Self::JOYSTICK,
            JoystickX => Self::JOYSTICK_X,
            JoystickY => Self::JOYSTICK_Y,
            Down => Self::DOWN,
            Left => Self::LEFT,
            BD => Self::BD,
        }
    }
}

impl From<g13input_node_config::Key> for mizer_nodes::G13Key {
    fn from(key: g13input_node_config::Key) -> Self {
        use g13input_node_config::Key::*;

        match key {
            G1 => Self::G1,
            G2 => Self::G2,
            G3 => Self::G3,
            G4 => Self::G4,
            G5 => Self::G5,
            G6 => Self::G6,
            G7 => Self::G7,
            G8 => Self::G8,
            G9 => Self::G9,
            G10 => Self::G10,
            G11 => Self::G11,
            G12 => Self::G12,
            G13 => Self::G13,
            G14 => Self::G14,
            G15 => Self::G15,
            G16 => Self::G16,
            G17 => Self::G17,
            G18 => Self::G18,
            G19 => Self::G19,
            G20 => Self::G20,
            G21 => Self::G21,
            G22 => Self::G22,
            M1 => Self::M1,
            M2 => Self::M2,
            M3 => Self::M3,
            MR => Self::MR,
            L1 => Self::L1,
            L2 => Self::L2,
            L3 => Self::L3,
            L4 => Self::L4,
            JOYSTICK => Self::Joystick,
            JOYSTICK_X => Self::JoystickX,
            JOYSTICK_Y => Self::JoystickY,
            DOWN => Self::Down,
            LEFT => Self::Left,
            BD => Self::BD,
        }
    }
}

impl From<mizer_nodes::G13OutputNode> for G13OutputNodeConfig {
    fn from(g13: mizer_nodes::G13OutputNode) -> Self {
        Self {
            device_id: g13.device_id,
            ..Default::default()
        }
    }
}

impl From<G13OutputNodeConfig> for mizer_nodes::G13OutputNode {
    fn from(g13: G13OutputNodeConfig) -> Self {
        Self {
            device_id: g13.device_id,
        }
    }
}

impl From<mizer_nodes::ConstantNumberNode> for ConstantNumberNodeConfig {
    fn from(node: mizer_nodes::ConstantNumberNode) -> Self {
        Self {
            value: node.value,
            ..Default::default()
        }
    }
}

impl From<ConstantNumberNodeConfig> for mizer_nodes::ConstantNumberNode {
    fn from(node: ConstantNumberNodeConfig) -> Self {
        Self { value: node.value }
    }
}

impl From<mizer_nodes::ConditionalNode> for ConditionalNodeConfig {
    fn from(node: mizer_nodes::ConditionalNode) -> Self {
        Self {
            threshold: node.threshold,
            ..Default::default()
        }
    }
}

impl From<ConditionalNodeConfig> for mizer_nodes::ConditionalNode {
    fn from(node: ConditionalNodeConfig) -> Self {
        Self {
            threshold: node.threshold,
        }
    }
}

impl From<mizer_nodes::TimecodeControlNode> for TimecodeControlNodeConfig {
    fn from(node: mizer_nodes::TimecodeControlNode) -> Self {
        Self {
            timecode_id: node.timecode_id.into(),
            ..Default::default()
        }
    }
}

impl From<TimecodeControlNodeConfig> for mizer_nodes::TimecodeControlNode {
    fn from(node: TimecodeControlNodeConfig) -> Self {
        Self {
            timecode_id: node.timecode_id.into(),
        }
    }
}

impl From<mizer_nodes::TimecodeOutputNode> for TimecodeOutputNodeConfig {
    fn from(node: mizer_nodes::TimecodeOutputNode) -> Self {
        Self {
            control_id: node.control_id.into(),
            ..Default::default()
        }
    }
}

impl From<TimecodeOutputNodeConfig> for mizer_nodes::TimecodeOutputNode {
    fn from(node: TimecodeOutputNodeConfig) -> Self {
        Self {
            control_id: node.control_id.into(),
        }
    }
}

impl From<mizer_nodes::AudioFileNode> for AudioFileNodeConfig {
    fn from(node: mizer_nodes::AudioFileNode) -> Self {
        Self {
            file: node
                .path
                .to_str()
                .map(|path| path.to_string())
                .unwrap_or_default(),
            playback_mode: EnumOrUnknown::new(node.playback_mode.into()),
            ..Default::default()
        }
    }
}

impl From<mizer_nodes::PlaybackMode> for audio_file_node_config::PlaybackMode {
    fn from(mode: mizer_nodes::PlaybackMode) -> Self {
        use mizer_nodes::PlaybackMode::*;

        match mode {
            OneShot => Self::ONE_SHOT,
            Loop => Self::LOOP,
            PingPong => Self::PING_PONG,
        }
    }
}

impl From<AudioFileNodeConfig> for mizer_nodes::AudioFileNode {
    fn from(node: AudioFileNodeConfig) -> Self {
        Self {
            path: Path::new(&node.file).to_path_buf(),
            playback_mode: node.playback_mode.unwrap().into(),
        }
    }
}

impl From<audio_file_node_config::PlaybackMode> for mizer_nodes::PlaybackMode {
    fn from(mode: audio_file_node_config::PlaybackMode) -> Self {
        use audio_file_node_config::PlaybackMode::*;

        match mode {
            ONE_SHOT => Self::OneShot,
            LOOP => Self::Loop,
            PING_PONG => Self::PingPong,
        }
    }
}

impl From<mizer_nodes::AudioOutputNode> for AudioOutputNodeConfig {
    fn from(_node: mizer_nodes::AudioOutputNode) -> Self {
        Self {
            ..Default::default()
        }
    }
}

impl From<AudioOutputNodeConfig> for mizer_nodes::AudioOutputNode {
    fn from(_node: AudioOutputNodeConfig) -> Self {
        Self {}
    }
}

impl From<mizer_nodes::AudioVolumeNode> for AudioVolumeNodeConfig {
    fn from(_node: mizer_nodes::AudioVolumeNode) -> Self {
        Self {
            ..Default::default()
        }
    }
}

impl From<AudioVolumeNodeConfig> for mizer_nodes::AudioVolumeNode {
    fn from(_node: AudioVolumeNodeConfig) -> Self {
        Self {}
    }
}

impl From<mizer_nodes::AudioInputNode> for AudioInputNodeConfig {
    fn from(_node: mizer_nodes::AudioInputNode) -> Self {
        Self {
            ..Default::default()
        }
    }
}

impl From<AudioInputNodeConfig> for mizer_nodes::AudioInputNode {
    fn from(_node: AudioInputNodeConfig) -> Self {
        Self {}
    }
}

impl From<mizer_nodes::AudioMixNode> for AudioMixNodeConfig {
    fn from(_node: mizer_nodes::AudioMixNode) -> Self {
        Self {
            ..Default::default()
        }
    }
}

impl From<AudioMixNodeConfig> for mizer_nodes::AudioMixNode {
    fn from(_node: AudioMixNodeConfig) -> Self {
        Self {}
    }
}

impl From<mizer_nodes::AudioMeterNode> for AudioMeterNodeConfig {
    fn from(_node: mizer_nodes::AudioMeterNode) -> Self {
        Self {
            ..Default::default()
        }
    }
}

impl From<AudioMeterNodeConfig> for mizer_nodes::AudioMeterNode {
    fn from(_node: AudioMeterNodeConfig) -> Self {
        Self {}
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
            NodeType::VideoEffect => node::NodeType::VIDEO_EFFECT,
            NodeType::VideoColorBalance => node::NodeType::VIDEO_COLOR_BALANCE,
            NodeType::VideoTransform => node::NodeType::VIDEO_TRANSFORM,
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
            node::NodeType::VIDEO_EFFECT => NodeType::VideoEffect,
            node::NodeType::VIDEO_COLOR_BALANCE => NodeType::VideoColorBalance,
            node::NodeType::VIDEO_TRANSFORM => NodeType::VideoTransform,
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
        config: MessageField::some(config),
        designer: MessageField::some(descriptor.designer.into()),
        preview: EnumOrUnknown::new(details.preview_type.into()),
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
            config: MessageField::some(descriptor.config.into()),
            designer: MessageField::some(descriptor.designer.into()),
            preview: EnumOrUnknown::new(descriptor.details.preview_type.into()),
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
            PortType::Gstreamer => ChannelProtocol::GST,
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
            ChannelProtocol::GST => PortType::Gstreamer,
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
            PreviewType::None => node::NodePreviewType::NONE,
        }
    }
}
