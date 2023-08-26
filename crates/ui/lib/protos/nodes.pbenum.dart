///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class NodeCategory extends $pb.ProtobufEnum {
  static const NodeCategory NODE_CATEGORY_NONE = NodeCategory._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NODE_CATEGORY_NONE');
  static const NodeCategory NODE_CATEGORY_STANDARD = NodeCategory._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NODE_CATEGORY_STANDARD');
  static const NodeCategory NODE_CATEGORY_CONNECTIONS = NodeCategory._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NODE_CATEGORY_CONNECTIONS');
  static const NodeCategory NODE_CATEGORY_CONVERSIONS = NodeCategory._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NODE_CATEGORY_CONVERSIONS');
  static const NodeCategory NODE_CATEGORY_CONTROLS = NodeCategory._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NODE_CATEGORY_CONTROLS');
  static const NodeCategory NODE_CATEGORY_DATA = NodeCategory._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NODE_CATEGORY_DATA');
  static const NodeCategory NODE_CATEGORY_COLOR = NodeCategory._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NODE_CATEGORY_COLOR');
  static const NodeCategory NODE_CATEGORY_AUDIO = NodeCategory._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NODE_CATEGORY_AUDIO');
  static const NodeCategory NODE_CATEGORY_VIDEO = NodeCategory._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NODE_CATEGORY_VIDEO');
  static const NodeCategory NODE_CATEGORY_LASER = NodeCategory._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NODE_CATEGORY_LASER');
  static const NodeCategory NODE_CATEGORY_PIXEL = NodeCategory._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NODE_CATEGORY_PIXEL');

  static const $core.List<NodeCategory> values = <NodeCategory> [
    NODE_CATEGORY_NONE,
    NODE_CATEGORY_STANDARD,
    NODE_CATEGORY_CONNECTIONS,
    NODE_CATEGORY_CONVERSIONS,
    NODE_CATEGORY_CONTROLS,
    NODE_CATEGORY_DATA,
    NODE_CATEGORY_COLOR,
    NODE_CATEGORY_AUDIO,
    NODE_CATEGORY_VIDEO,
    NODE_CATEGORY_LASER,
    NODE_CATEGORY_PIXEL,
  ];

  static final $core.Map<$core.int, NodeCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NodeCategory? valueOf($core.int value) => _byValue[value];

  const NodeCategory._($core.int v, $core.String n) : super(v, n);
}

class ChannelProtocol extends $pb.ProtobufEnum {
  static const ChannelProtocol SINGLE = ChannelProtocol._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SINGLE');
  static const ChannelProtocol MULTI = ChannelProtocol._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MULTI');
  static const ChannelProtocol TEXTURE = ChannelProtocol._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEXTURE');
  static const ChannelProtocol VECTOR = ChannelProtocol._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VECTOR');
  static const ChannelProtocol LASER = ChannelProtocol._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LASER');
  static const ChannelProtocol POLY = ChannelProtocol._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'POLY');
  static const ChannelProtocol DATA = ChannelProtocol._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DATA');
  static const ChannelProtocol MATERIAL = ChannelProtocol._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MATERIAL');
  static const ChannelProtocol COLOR = ChannelProtocol._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR');
  static const ChannelProtocol CLOCK = ChannelProtocol._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CLOCK');

  static const $core.List<ChannelProtocol> values = <ChannelProtocol> [
    SINGLE,
    MULTI,
    TEXTURE,
    VECTOR,
    LASER,
    POLY,
    DATA,
    MATERIAL,
    COLOR,
    CLOCK,
  ];

  static final $core.Map<$core.int, ChannelProtocol> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelProtocol? valueOf($core.int value) => _byValue[value];

  const ChannelProtocol._($core.int v, $core.String n) : super(v, n);
}

class Node_NodePreviewType extends $pb.ProtobufEnum {
  static const Node_NodePreviewType NONE = Node_NodePreviewType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NONE');
  static const Node_NodePreviewType HISTORY = Node_NodePreviewType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'HISTORY');
  static const Node_NodePreviewType WAVEFORM = Node_NodePreviewType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WAVEFORM');
  static const Node_NodePreviewType MULTIPLE = Node_NodePreviewType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MULTIPLE');
  static const Node_NodePreviewType TEXTURE = Node_NodePreviewType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEXTURE');
  static const Node_NodePreviewType TIMECODE = Node_NodePreviewType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIMECODE');
  static const Node_NodePreviewType DATA = Node_NodePreviewType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DATA');
  static const Node_NodePreviewType COLOR = Node_NodePreviewType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR');

  static const $core.List<Node_NodePreviewType> values = <Node_NodePreviewType> [
    NONE,
    HISTORY,
    WAVEFORM,
    MULTIPLE,
    TEXTURE,
    TIMECODE,
    DATA,
    COLOR,
  ];

  static final $core.Map<$core.int, Node_NodePreviewType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Node_NodePreviewType? valueOf($core.int value) => _byValue[value];

  const Node_NodePreviewType._($core.int v, $core.String n) : super(v, n);
}

class MidiNodeConfig_NoteBinding_MidiType extends $pb.ProtobufEnum {
  static const MidiNodeConfig_NoteBinding_MidiType CC = MidiNodeConfig_NoteBinding_MidiType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CC');
  static const MidiNodeConfig_NoteBinding_MidiType NOTE = MidiNodeConfig_NoteBinding_MidiType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NOTE');

  static const $core.List<MidiNodeConfig_NoteBinding_MidiType> values = <MidiNodeConfig_NoteBinding_MidiType> [
    CC,
    NOTE,
  ];

  static final $core.Map<$core.int, MidiNodeConfig_NoteBinding_MidiType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MidiNodeConfig_NoteBinding_MidiType? valueOf($core.int value) => _byValue[value];

  const MidiNodeConfig_NoteBinding_MidiType._($core.int v, $core.String n) : super(v, n);
}

