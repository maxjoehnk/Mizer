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
  static const ChannelProtocol Dmx = ChannelProtocol._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Dmx');
  static const ChannelProtocol Numeric = ChannelProtocol._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Numeric');
  static const ChannelProtocol Trigger = ChannelProtocol._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Trigger');
  static const ChannelProtocol Clock = ChannelProtocol._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Clock');
  static const ChannelProtocol Video = ChannelProtocol._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Video');
  static const ChannelProtocol Color = ChannelProtocol._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Color');
  static const ChannelProtocol Vector = ChannelProtocol._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Vector');
  static const ChannelProtocol Text = ChannelProtocol._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Text');
  static const ChannelProtocol Midi = ChannelProtocol._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Midi');
  static const ChannelProtocol Timecode = ChannelProtocol._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Timecode');
  static const ChannelProtocol Boolean = ChannelProtocol._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Boolean');
  static const ChannelProtocol Select = ChannelProtocol._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Select');
  static const ChannelProtocol Pixels = ChannelProtocol._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Pixels');

  static const $core.List<ChannelProtocol> values = <ChannelProtocol> [
    Dmx,
    Numeric,
    Trigger,
    Clock,
    Video,
    Color,
    Vector,
    Text,
    Midi,
    Timecode,
    Boolean,
    Select,
    Pixels,
  ];

  static final $core.Map<$core.int, ChannelProtocol> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelProtocol valueOf($core.int value) => _byValue[value];

  const ChannelProtocol._($core.int v, $core.String n) : super(v, n);
}

class Node_NodeType extends $pb.ProtobufEnum {
  static const Node_NodeType Fader = Node_NodeType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Fader');
  static const Node_NodeType ConvertToDmx = Node_NodeType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ConvertToDmx');
  static const Node_NodeType ArtnetOutput = Node_NodeType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ArtnetOutput');
  static const Node_NodeType SacnOutput = Node_NodeType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SacnOutput');
  static const Node_NodeType Oscillator = Node_NodeType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Oscillator');
  static const Node_NodeType Clock = Node_NodeType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Clock');
  static const Node_NodeType OscInput = Node_NodeType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OscInput');
  static const Node_NodeType VideoFile = Node_NodeType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoFile');
  static const Node_NodeType VideoOutput = Node_NodeType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoOutput');
  static const Node_NodeType VideoEffect = Node_NodeType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoEffect');
  static const Node_NodeType VideoColorBalance = Node_NodeType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoColorBalance');
  static const Node_NodeType VideoTransform = Node_NodeType._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VideoTransform');
  static const Node_NodeType Script = Node_NodeType._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Script');
  static const Node_NodeType PixelToDmx = Node_NodeType._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PixelToDmx');
  static const Node_NodeType PixelPattern = Node_NodeType._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PixelPattern');
  static const Node_NodeType OpcOutput = Node_NodeType._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OpcOutput');
  static const Node_NodeType Fixture = Node_NodeType._(16, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Fixture');
  static const Node_NodeType Sequence = Node_NodeType._(17, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Sequence');

  static const $core.List<Node_NodeType> values = <Node_NodeType> [
    Fader,
    ConvertToDmx,
    ArtnetOutput,
    SacnOutput,
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
  ];

  static final $core.Map<$core.int, Node_NodeType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Node_NodeType valueOf($core.int value) => _byValue[value];

  const Node_NodeType._($core.int v, $core.String n) : super(v, n);
}

