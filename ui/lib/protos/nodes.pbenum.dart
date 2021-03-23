///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ChannelProtocol extends $pb.ProtobufEnum {
  static const ChannelProtocol Single = ChannelProtocol._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Single');
  static const ChannelProtocol Multi = ChannelProtocol._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Multi');
  static const ChannelProtocol Texture = ChannelProtocol._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Texture');
  static const ChannelProtocol Vector = ChannelProtocol._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Vector');
  static const ChannelProtocol Laser = ChannelProtocol._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Laser');
  static const ChannelProtocol Poly = ChannelProtocol._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Poly');
  static const ChannelProtocol Data = ChannelProtocol._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Data');
  static const ChannelProtocol Material = ChannelProtocol._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Material');
  static const ChannelProtocol Gst = ChannelProtocol._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Gst');

  static const $core.List<ChannelProtocol> values = <ChannelProtocol> [
    Single,
    Multi,
    Texture,
    Vector,
    Laser,
    Poly,
    Data,
    Material,
    Gst,
  ];

  static final $core.Map<$core.int, ChannelProtocol> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelProtocol valueOf($core.int value) => _byValue[value];

  const ChannelProtocol._($core.int v, $core.String n) : super(v, n);
}

class Node_NodeType extends $pb.ProtobufEnum {
  static const Node_NodeType Fader = Node_NodeType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Fader');
  static const Node_NodeType Button = Node_NodeType._(20, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Button');
  static const Node_NodeType DmxOutput = Node_NodeType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DmxOutput');
  static const Node_NodeType Oscillator = Node_NodeType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Oscillator');
  static const Node_NodeType Clock = Node_NodeType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Clock');
  static const Node_NodeType OscInput = Node_NodeType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OscInput');
  static const Node_NodeType VideoFile = Node_NodeType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoFile');
  static const Node_NodeType VideoOutput = Node_NodeType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoOutput');
  static const Node_NodeType VideoEffect = Node_NodeType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoEffect');
  static const Node_NodeType VideoColorBalance = Node_NodeType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoColorBalance');
  static const Node_NodeType VideoTransform = Node_NodeType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoTransform');
  static const Node_NodeType Script = Node_NodeType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Script');
  static const Node_NodeType PixelToDmx = Node_NodeType._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PixelToDmx');
  static const Node_NodeType PixelPattern = Node_NodeType._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PixelPattern');
  static const Node_NodeType OpcOutput = Node_NodeType._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OpcOutput');
  static const Node_NodeType Fixture = Node_NodeType._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Fixture');
  static const Node_NodeType Sequence = Node_NodeType._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Sequence');
  static const Node_NodeType MidiInput = Node_NodeType._(16, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MidiInput');
  static const Node_NodeType MidiOutput = Node_NodeType._(17, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MidiOutput');
  static const Node_NodeType Laser = Node_NodeType._(18, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Laser');
  static const Node_NodeType IldaFile = Node_NodeType._(19, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IldaFile');

  static const $core.List<Node_NodeType> values = <Node_NodeType> [
    Fader,
    Button,
    DmxOutput,
    Oscillator,
    Clock,
    OscInput,
    VideoFile,
    VideoOutput,
    VideoEffect,
    VideoColorBalance,
    VideoTransform,
    Script,
    PixelToDmx,
    PixelPattern,
    OpcOutput,
    Fixture,
    Sequence,
    MidiInput,
    MidiOutput,
    Laser,
    IldaFile,
  ];

  static final $core.Map<$core.int, Node_NodeType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Node_NodeType valueOf($core.int value) => _byValue[value];

  const Node_NodeType._($core.int v, $core.String n) : super(v, n);
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
  static OscillatorNodeConfig_OscillatorType valueOf($core.int value) => _byValue[value];

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
  static PixelPatternNodeConfig_Pattern valueOf($core.int value) => _byValue[value];

  const PixelPatternNodeConfig_Pattern._($core.int v, $core.String n) : super(v, n);
}

