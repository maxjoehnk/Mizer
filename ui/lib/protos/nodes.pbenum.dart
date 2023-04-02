///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ChannelProtocol extends $pb.ProtobufEnum {
  static const ChannelProtocol SINGLE = ChannelProtocol._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SINGLE');
  static const ChannelProtocol MULTI = ChannelProtocol._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MULTI');
  static const ChannelProtocol COLOR = ChannelProtocol._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR');
  static const ChannelProtocol TEXTURE = ChannelProtocol._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEXTURE');
  static const ChannelProtocol VECTOR = ChannelProtocol._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VECTOR');
  static const ChannelProtocol LASER = ChannelProtocol._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LASER');
  static const ChannelProtocol POLY = ChannelProtocol._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'POLY');
  static const ChannelProtocol DATA = ChannelProtocol._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DATA');
  static const ChannelProtocol MATERIAL = ChannelProtocol._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MATERIAL');
  static const ChannelProtocol GST = ChannelProtocol._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GST');
  static const ChannelProtocol CLOCK = ChannelProtocol._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CLOCK');

  static const $core.List<ChannelProtocol> values = <ChannelProtocol> [
    SINGLE,
    MULTI,
    COLOR,
    TEXTURE,
    VECTOR,
    LASER,
    POLY,
    DATA,
    MATERIAL,
    GST,
    CLOCK,
  ];

  static final $core.Map<$core.int, ChannelProtocol> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelProtocol? valueOf($core.int value) => _byValue[value];

  const ChannelProtocol._($core.int v, $core.String n) : super(v, n);
}

class Node_NodeType extends $pb.ProtobufEnum {
  static const Node_NodeType Fader = Node_NodeType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Fader');
  static const Node_NodeType Button = Node_NodeType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Button');
  static const Node_NodeType Oscillator = Node_NodeType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Oscillator');
  static const Node_NodeType Clock = Node_NodeType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Clock');
  static const Node_NodeType Script = Node_NodeType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Script');
  static const Node_NodeType Envelope = Node_NodeType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Envelope');
  static const Node_NodeType Sequence = Node_NodeType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Sequence');
  static const Node_NodeType Select = Node_NodeType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Select');
  static const Node_NodeType Merge = Node_NodeType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Merge');
  static const Node_NodeType Threshold = Node_NodeType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Threshold');
  static const Node_NodeType DmxOutput = Node_NodeType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DmxOutput');
  static const Node_NodeType OscInput = Node_NodeType._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OscInput');
  static const Node_NodeType OscOutput = Node_NodeType._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OscOutput');
  static const Node_NodeType MidiInput = Node_NodeType._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MidiInput');
  static const Node_NodeType MidiOutput = Node_NodeType._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MidiOutput');
  static const Node_NodeType Sequencer = Node_NodeType._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Sequencer');
  static const Node_NodeType Fixture = Node_NodeType._(16, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Fixture');
  static const Node_NodeType Programmer = Node_NodeType._(17, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Programmer');
  static const Node_NodeType Group = Node_NodeType._(18, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Group');
  static const Node_NodeType Preset = Node_NodeType._(19, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Preset');
  static const Node_NodeType VideoFile = Node_NodeType._(20, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoFile');
  static const Node_NodeType VideoOutput = Node_NodeType._(21, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoOutput');
  static const Node_NodeType VideoEffect = Node_NodeType._(22, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoEffect');
  static const Node_NodeType VideoColorBalance = Node_NodeType._(23, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoColorBalance');
  static const Node_NodeType VideoTransform = Node_NodeType._(24, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoTransform');
  static const Node_NodeType PixelToDmx = Node_NodeType._(30, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PixelToDmx');
  static const Node_NodeType PixelPattern = Node_NodeType._(31, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PixelPattern');
  static const Node_NodeType OpcOutput = Node_NodeType._(32, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OpcOutput');
  static const Node_NodeType Laser = Node_NodeType._(40, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Laser');
  static const Node_NodeType IldaFile = Node_NodeType._(41, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IldaFile');
  static const Node_NodeType Gamepad = Node_NodeType._(45, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Gamepad');
  static const Node_NodeType ColorRgb = Node_NodeType._(50, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ColorRgb');
  static const Node_NodeType ColorHsv = Node_NodeType._(51, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ColorHsv');
  static const Node_NodeType Container = Node_NodeType._(100, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Container');
  static const Node_NodeType Encoder = Node_NodeType._(55, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Encoder');
  static const Node_NodeType Math = Node_NodeType._(56, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Math');
  static const Node_NodeType DataToNumber = Node_NodeType._(57, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DataToNumber');
  static const Node_NodeType NumberToData = Node_NodeType._(58, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NumberToData');
  static const Node_NodeType Value = Node_NodeType._(59, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Value');
  static const Node_NodeType MqttInput = Node_NodeType._(60, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MqttInput');
  static const Node_NodeType MqttOutput = Node_NodeType._(61, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MqttOutput');
  static const Node_NodeType PlanScreen = Node_NodeType._(62, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PlanScreen');
  static const Node_NodeType Delay = Node_NodeType._(63, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Delay');
  static const Node_NodeType Ramp = Node_NodeType._(64, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ramp');
  static const Node_NodeType Noise = Node_NodeType._(65, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Noise');
  static const Node_NodeType Label = Node_NodeType._(66, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Label');
  static const Node_NodeType Transport = Node_NodeType._(67, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Transport');
  static const Node_NodeType G13Input = Node_NodeType._(68, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G13Input');
  static const Node_NodeType G13Output = Node_NodeType._(69, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G13Output');
  static const Node_NodeType ConstantNumber = Node_NodeType._(70, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ConstantNumber');
  static const Node_NodeType Conditional = Node_NodeType._(71, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Conditional');
  static const Node_NodeType TimecodeControl = Node_NodeType._(72, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TimecodeControl');
  static const Node_NodeType TimecodeOutput = Node_NodeType._(73, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TimecodeOutput');
  static const Node_NodeType AudioFile = Node_NodeType._(74, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AudioFile');
  static const Node_NodeType AudioOutput = Node_NodeType._(75, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AudioOutput');
  static const Node_NodeType AudioVolume = Node_NodeType._(76, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AudioVolume');
  static const Node_NodeType AudioInput = Node_NodeType._(77, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AudioInput');
  static const Node_NodeType AudioMix = Node_NodeType._(78, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AudioMix');
  static const Node_NodeType AudioMeter = Node_NodeType._(79, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AudioMeter');

  static const $core.List<Node_NodeType> values = <Node_NodeType> [
    Fader,
    Button,
    Oscillator,
    Clock,
    Script,
    Envelope,
    Sequence,
    Select,
    Merge,
    Threshold,
    DmxOutput,
    OscInput,
    OscOutput,
    MidiInput,
    MidiOutput,
    Sequencer,
    Fixture,
    Programmer,
    Group,
    Preset,
    VideoFile,
    VideoOutput,
    VideoEffect,
    VideoColorBalance,
    VideoTransform,
    PixelToDmx,
    PixelPattern,
    OpcOutput,
    Laser,
    IldaFile,
    Gamepad,
    ColorRgb,
    ColorHsv,
    Container,
    Encoder,
    Math,
    DataToNumber,
    NumberToData,
    Value,
    MqttInput,
    MqttOutput,
    PlanScreen,
    Delay,
    Ramp,
    Noise,
    Label,
    Transport,
    G13Input,
    G13Output,
    ConstantNumber,
    Conditional,
    TimecodeControl,
    TimecodeOutput,
    AudioFile,
    AudioOutput,
    AudioVolume,
    AudioInput,
    AudioMix,
    AudioMeter,
  ];

  static final $core.Map<$core.int, Node_NodeType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Node_NodeType? valueOf($core.int value) => _byValue[value];

  const Node_NodeType._($core.int v, $core.String n) : super(v, n);
}

class Node_NodePreviewType extends $pb.ProtobufEnum {
  static const Node_NodePreviewType History = Node_NodePreviewType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'History');
  static const Node_NodePreviewType Waveform = Node_NodePreviewType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Waveform');
  static const Node_NodePreviewType Multiple = Node_NodePreviewType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Multiple');
  static const Node_NodePreviewType Texture = Node_NodePreviewType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Texture');
  static const Node_NodePreviewType Timecode = Node_NodePreviewType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Timecode');
  static const Node_NodePreviewType None = Node_NodePreviewType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'None');

  static const $core.List<Node_NodePreviewType> values = <Node_NodePreviewType> [
    History,
    Waveform,
    Multiple,
    Texture,
    Timecode,
    None,
  ];

  static final $core.Map<$core.int, Node_NodePreviewType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Node_NodePreviewType? valueOf($core.int value) => _byValue[value];

  const Node_NodePreviewType._($core.int v, $core.String n) : super(v, n);
}

class OscillatorNodeConfig_OscillatorType extends $pb.ProtobufEnum {
  static const OscillatorNodeConfig_OscillatorType Square = OscillatorNodeConfig_OscillatorType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Square');
  static const OscillatorNodeConfig_OscillatorType Sine = OscillatorNodeConfig_OscillatorType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Sine');
  static const OscillatorNodeConfig_OscillatorType Saw = OscillatorNodeConfig_OscillatorType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Saw');
  static const OscillatorNodeConfig_OscillatorType Triangle = OscillatorNodeConfig_OscillatorType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Triangle');

  static const $core.List<OscillatorNodeConfig_OscillatorType> values = <OscillatorNodeConfig_OscillatorType> [
    Square,
    Sine,
    Saw,
    Triangle,
  ];

  static final $core.Map<$core.int, OscillatorNodeConfig_OscillatorType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OscillatorNodeConfig_OscillatorType? valueOf($core.int value) => _byValue[value];

  const OscillatorNodeConfig_OscillatorType._($core.int v, $core.String n) : super(v, n);
}

class GamepadNodeConfig_Control extends $pb.ProtobufEnum {
  static const GamepadNodeConfig_Control LeftStickX = GamepadNodeConfig_Control._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LeftStickX');
  static const GamepadNodeConfig_Control LeftStickY = GamepadNodeConfig_Control._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LeftStickY');
  static const GamepadNodeConfig_Control RightStickX = GamepadNodeConfig_Control._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RightStickX');
  static const GamepadNodeConfig_Control RightStickY = GamepadNodeConfig_Control._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RightStickY');
  static const GamepadNodeConfig_Control LeftTrigger = GamepadNodeConfig_Control._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LeftTrigger');
  static const GamepadNodeConfig_Control RightTrigger = GamepadNodeConfig_Control._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RightTrigger');
  static const GamepadNodeConfig_Control LeftShoulder = GamepadNodeConfig_Control._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LeftShoulder');
  static const GamepadNodeConfig_Control RightShoulder = GamepadNodeConfig_Control._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RightShoulder');
  static const GamepadNodeConfig_Control South = GamepadNodeConfig_Control._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'South');
  static const GamepadNodeConfig_Control East = GamepadNodeConfig_Control._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'East');
  static const GamepadNodeConfig_Control North = GamepadNodeConfig_Control._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'North');
  static const GamepadNodeConfig_Control West = GamepadNodeConfig_Control._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'West');
  static const GamepadNodeConfig_Control Select = GamepadNodeConfig_Control._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Select');
  static const GamepadNodeConfig_Control Start = GamepadNodeConfig_Control._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Start');
  static const GamepadNodeConfig_Control DpadUp = GamepadNodeConfig_Control._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DpadUp');
  static const GamepadNodeConfig_Control DpadDown = GamepadNodeConfig_Control._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DpadDown');
  static const GamepadNodeConfig_Control DpadLeft = GamepadNodeConfig_Control._(16, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DpadLeft');
  static const GamepadNodeConfig_Control DpadRight = GamepadNodeConfig_Control._(17, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DpadRight');
  static const GamepadNodeConfig_Control LeftStick = GamepadNodeConfig_Control._(18, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LeftStick');
  static const GamepadNodeConfig_Control RightStick = GamepadNodeConfig_Control._(19, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RightStick');

  static const $core.List<GamepadNodeConfig_Control> values = <GamepadNodeConfig_Control> [
    LeftStickX,
    LeftStickY,
    RightStickX,
    RightStickY,
    LeftTrigger,
    RightTrigger,
    LeftShoulder,
    RightShoulder,
    South,
    East,
    North,
    West,
    Select,
    Start,
    DpadUp,
    DpadDown,
    DpadLeft,
    DpadRight,
    LeftStick,
    RightStick,
  ];

  static final $core.Map<$core.int, GamepadNodeConfig_Control> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GamepadNodeConfig_Control? valueOf($core.int value) => _byValue[value];

  const GamepadNodeConfig_Control._($core.int v, $core.String n) : super(v, n);
}

class PixelPatternNodeConfig_Pattern extends $pb.ProtobufEnum {
  static const PixelPatternNodeConfig_Pattern RgbIterate = PixelPatternNodeConfig_Pattern._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RgbIterate');
  static const PixelPatternNodeConfig_Pattern RgbSnake = PixelPatternNodeConfig_Pattern._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RgbSnake');

  static const $core.List<PixelPatternNodeConfig_Pattern> values = <PixelPatternNodeConfig_Pattern> [
    RgbIterate,
    RgbSnake,
  ];

  static final $core.Map<$core.int, PixelPatternNodeConfig_Pattern> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PixelPatternNodeConfig_Pattern? valueOf($core.int value) => _byValue[value];

  const PixelPatternNodeConfig_Pattern._($core.int v, $core.String n) : super(v, n);
}

class MidiNodeConfig_NoteBinding_MidiType extends $pb.ProtobufEnum {
  static const MidiNodeConfig_NoteBinding_MidiType CC = MidiNodeConfig_NoteBinding_MidiType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CC');
  static const MidiNodeConfig_NoteBinding_MidiType Note = MidiNodeConfig_NoteBinding_MidiType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Note');

  static const $core.List<MidiNodeConfig_NoteBinding_MidiType> values = <MidiNodeConfig_NoteBinding_MidiType> [
    CC,
    Note,
  ];

  static final $core.Map<$core.int, MidiNodeConfig_NoteBinding_MidiType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MidiNodeConfig_NoteBinding_MidiType? valueOf($core.int value) => _byValue[value];

  const MidiNodeConfig_NoteBinding_MidiType._($core.int v, $core.String n) : super(v, n);
}

class OscNodeConfig_ArgumentType extends $pb.ProtobufEnum {
  static const OscNodeConfig_ArgumentType Int = OscNodeConfig_ArgumentType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Int');
  static const OscNodeConfig_ArgumentType Float = OscNodeConfig_ArgumentType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Float');
  static const OscNodeConfig_ArgumentType Long = OscNodeConfig_ArgumentType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Long');
  static const OscNodeConfig_ArgumentType Double = OscNodeConfig_ArgumentType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Double');
  static const OscNodeConfig_ArgumentType Bool = OscNodeConfig_ArgumentType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Bool');
  static const OscNodeConfig_ArgumentType Color = OscNodeConfig_ArgumentType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Color');

  static const $core.List<OscNodeConfig_ArgumentType> values = <OscNodeConfig_ArgumentType> [
    Int,
    Float,
    Long,
    Double,
    Bool,
    Color,
  ];

  static final $core.Map<$core.int, OscNodeConfig_ArgumentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OscNodeConfig_ArgumentType? valueOf($core.int value) => _byValue[value];

  const OscNodeConfig_ArgumentType._($core.int v, $core.String n) : super(v, n);
}

class MergeNodeConfig_MergeMode extends $pb.ProtobufEnum {
  static const MergeNodeConfig_MergeMode Latest = MergeNodeConfig_MergeMode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Latest');
  static const MergeNodeConfig_MergeMode Highest = MergeNodeConfig_MergeMode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Highest');
  static const MergeNodeConfig_MergeMode Lowest = MergeNodeConfig_MergeMode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Lowest');

  static const $core.List<MergeNodeConfig_MergeMode> values = <MergeNodeConfig_MergeMode> [
    Latest,
    Highest,
    Lowest,
  ];

  static final $core.Map<$core.int, MergeNodeConfig_MergeMode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MergeNodeConfig_MergeMode? valueOf($core.int value) => _byValue[value];

  const MergeNodeConfig_MergeMode._($core.int v, $core.String n) : super(v, n);
}

class MathNodeConfig_Mode extends $pb.ProtobufEnum {
  static const MathNodeConfig_Mode Addition = MathNodeConfig_Mode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Addition');
  static const MathNodeConfig_Mode Subtraction = MathNodeConfig_Mode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Subtraction');
  static const MathNodeConfig_Mode Multiplication = MathNodeConfig_Mode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Multiplication');
  static const MathNodeConfig_Mode Division = MathNodeConfig_Mode._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Division');
  static const MathNodeConfig_Mode Invert = MathNodeConfig_Mode._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Invert');
  static const MathNodeConfig_Mode Sine = MathNodeConfig_Mode._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Sine');
  static const MathNodeConfig_Mode Cosine = MathNodeConfig_Mode._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Cosine');
  static const MathNodeConfig_Mode Tangent = MathNodeConfig_Mode._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Tangent');

  static const $core.List<MathNodeConfig_Mode> values = <MathNodeConfig_Mode> [
    Addition,
    Subtraction,
    Multiplication,
    Division,
    Invert,
    Sine,
    Cosine,
    Tangent,
  ];

  static final $core.Map<$core.int, MathNodeConfig_Mode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MathNodeConfig_Mode? valueOf($core.int value) => _byValue[value];

  const MathNodeConfig_Mode._($core.int v, $core.String n) : super(v, n);
}

class G13InputNodeConfig_Key extends $pb.ProtobufEnum {
  static const G13InputNodeConfig_Key G1 = G13InputNodeConfig_Key._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G1');
  static const G13InputNodeConfig_Key G2 = G13InputNodeConfig_Key._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G2');
  static const G13InputNodeConfig_Key G3 = G13InputNodeConfig_Key._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G3');
  static const G13InputNodeConfig_Key G4 = G13InputNodeConfig_Key._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G4');
  static const G13InputNodeConfig_Key G5 = G13InputNodeConfig_Key._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G5');
  static const G13InputNodeConfig_Key G6 = G13InputNodeConfig_Key._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G6');
  static const G13InputNodeConfig_Key G7 = G13InputNodeConfig_Key._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G7');
  static const G13InputNodeConfig_Key G8 = G13InputNodeConfig_Key._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G8');
  static const G13InputNodeConfig_Key G9 = G13InputNodeConfig_Key._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G9');
  static const G13InputNodeConfig_Key G10 = G13InputNodeConfig_Key._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G10');
  static const G13InputNodeConfig_Key G11 = G13InputNodeConfig_Key._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G11');
  static const G13InputNodeConfig_Key G12 = G13InputNodeConfig_Key._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G12');
  static const G13InputNodeConfig_Key G13 = G13InputNodeConfig_Key._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G13');
  static const G13InputNodeConfig_Key G14 = G13InputNodeConfig_Key._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G14');
  static const G13InputNodeConfig_Key G15 = G13InputNodeConfig_Key._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G15');
  static const G13InputNodeConfig_Key G16 = G13InputNodeConfig_Key._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G16');
  static const G13InputNodeConfig_Key G17 = G13InputNodeConfig_Key._(16, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G17');
  static const G13InputNodeConfig_Key G18 = G13InputNodeConfig_Key._(17, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G18');
  static const G13InputNodeConfig_Key G19 = G13InputNodeConfig_Key._(18, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G19');
  static const G13InputNodeConfig_Key G20 = G13InputNodeConfig_Key._(19, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G20');
  static const G13InputNodeConfig_Key G21 = G13InputNodeConfig_Key._(20, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G21');
  static const G13InputNodeConfig_Key G22 = G13InputNodeConfig_Key._(21, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G22');
  static const G13InputNodeConfig_Key M1 = G13InputNodeConfig_Key._(22, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'M1');
  static const G13InputNodeConfig_Key M2 = G13InputNodeConfig_Key._(23, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'M2');
  static const G13InputNodeConfig_Key M3 = G13InputNodeConfig_Key._(24, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'M3');
  static const G13InputNodeConfig_Key MR = G13InputNodeConfig_Key._(25, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MR');
  static const G13InputNodeConfig_Key L1 = G13InputNodeConfig_Key._(26, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'L1');
  static const G13InputNodeConfig_Key L2 = G13InputNodeConfig_Key._(27, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'L2');
  static const G13InputNodeConfig_Key L3 = G13InputNodeConfig_Key._(28, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'L3');
  static const G13InputNodeConfig_Key L4 = G13InputNodeConfig_Key._(29, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'L4');
  static const G13InputNodeConfig_Key JoystickX = G13InputNodeConfig_Key._(30, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'JoystickX');
  static const G13InputNodeConfig_Key JoystickY = G13InputNodeConfig_Key._(31, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'JoystickY');
  static const G13InputNodeConfig_Key Joystick = G13InputNodeConfig_Key._(32, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Joystick');
  static const G13InputNodeConfig_Key Left = G13InputNodeConfig_Key._(33, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Left');
  static const G13InputNodeConfig_Key Down = G13InputNodeConfig_Key._(34, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Down');
  static const G13InputNodeConfig_Key BD = G13InputNodeConfig_Key._(35, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BD');

  static const $core.List<G13InputNodeConfig_Key> values = <G13InputNodeConfig_Key> [
    G1,
    G2,
    G3,
    G4,
    G5,
    G6,
    G7,
    G8,
    G9,
    G10,
    G11,
    G12,
    G13,
    G14,
    G15,
    G16,
    G17,
    G18,
    G19,
    G20,
    G21,
    G22,
    M1,
    M2,
    M3,
    MR,
    L1,
    L2,
    L3,
    L4,
    JoystickX,
    JoystickY,
    Joystick,
    Left,
    Down,
    BD,
  ];

  static final $core.Map<$core.int, G13InputNodeConfig_Key> _byValue = $pb.ProtobufEnum.initByValue(values);
  static G13InputNodeConfig_Key? valueOf($core.int value) => _byValue[value];

  const G13InputNodeConfig_Key._($core.int v, $core.String n) : super(v, n);
}

class AudioFileNodeConfig_PlaybackMode extends $pb.ProtobufEnum {
  static const AudioFileNodeConfig_PlaybackMode ONE_SHOT = AudioFileNodeConfig_PlaybackMode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ONE_SHOT');
  static const AudioFileNodeConfig_PlaybackMode LOOP = AudioFileNodeConfig_PlaybackMode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LOOP');
  static const AudioFileNodeConfig_PlaybackMode PING_PONG = AudioFileNodeConfig_PlaybackMode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PING_PONG');

  static const $core.List<AudioFileNodeConfig_PlaybackMode> values = <AudioFileNodeConfig_PlaybackMode> [
    ONE_SHOT,
    LOOP,
    PING_PONG,
  ];

  static final $core.Map<$core.int, AudioFileNodeConfig_PlaybackMode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AudioFileNodeConfig_PlaybackMode? valueOf($core.int value) => _byValue[value];

  const AudioFileNodeConfig_PlaybackMode._($core.int v, $core.String n) : super(v, n);
}

