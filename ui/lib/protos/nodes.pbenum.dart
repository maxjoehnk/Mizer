///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

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
  static const Node_NodeType ColorRgb = Node_NodeType._(50, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ColorRgb');
  static const Node_NodeType ColorHsv = Node_NodeType._(51, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ColorHsv');

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
    ColorRgb,
    ColorHsv,
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
  static const Node_NodePreviewType None = Node_NodePreviewType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'None');

  static const $core.List<Node_NodePreviewType> values = <Node_NodePreviewType> [
    History,
    Waveform,
    Multiple,
    Texture,
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

