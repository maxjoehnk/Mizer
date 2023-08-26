//
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class NodeCategory extends $pb.ProtobufEnum {
  static const NodeCategory NODE_CATEGORY_NONE = NodeCategory._(0, _omitEnumNames ? '' : 'NODE_CATEGORY_NONE');
  static const NodeCategory NODE_CATEGORY_STANDARD = NodeCategory._(1, _omitEnumNames ? '' : 'NODE_CATEGORY_STANDARD');
  static const NodeCategory NODE_CATEGORY_CONNECTIONS = NodeCategory._(2, _omitEnumNames ? '' : 'NODE_CATEGORY_CONNECTIONS');
  static const NodeCategory NODE_CATEGORY_CONVERSIONS = NodeCategory._(3, _omitEnumNames ? '' : 'NODE_CATEGORY_CONVERSIONS');
  static const NodeCategory NODE_CATEGORY_CONTROLS = NodeCategory._(4, _omitEnumNames ? '' : 'NODE_CATEGORY_CONTROLS');
  static const NodeCategory NODE_CATEGORY_DATA = NodeCategory._(5, _omitEnumNames ? '' : 'NODE_CATEGORY_DATA');
  static const NodeCategory NODE_CATEGORY_COLOR = NodeCategory._(6, _omitEnumNames ? '' : 'NODE_CATEGORY_COLOR');
  static const NodeCategory NODE_CATEGORY_AUDIO = NodeCategory._(7, _omitEnumNames ? '' : 'NODE_CATEGORY_AUDIO');
  static const NodeCategory NODE_CATEGORY_VIDEO = NodeCategory._(8, _omitEnumNames ? '' : 'NODE_CATEGORY_VIDEO');
  static const NodeCategory NODE_CATEGORY_LASER = NodeCategory._(9, _omitEnumNames ? '' : 'NODE_CATEGORY_LASER');
  static const NodeCategory NODE_CATEGORY_PIXEL = NodeCategory._(10, _omitEnumNames ? '' : 'NODE_CATEGORY_PIXEL');

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
  static const ChannelProtocol SINGLE = ChannelProtocol._(0, _omitEnumNames ? '' : 'SINGLE');
  static const ChannelProtocol MULTI = ChannelProtocol._(1, _omitEnumNames ? '' : 'MULTI');
  static const ChannelProtocol TEXTURE = ChannelProtocol._(2, _omitEnumNames ? '' : 'TEXTURE');
  static const ChannelProtocol VECTOR = ChannelProtocol._(3, _omitEnumNames ? '' : 'VECTOR');
  static const ChannelProtocol LASER = ChannelProtocol._(4, _omitEnumNames ? '' : 'LASER');
  static const ChannelProtocol POLY = ChannelProtocol._(5, _omitEnumNames ? '' : 'POLY');
  static const ChannelProtocol DATA = ChannelProtocol._(6, _omitEnumNames ? '' : 'DATA');
  static const ChannelProtocol MATERIAL = ChannelProtocol._(7, _omitEnumNames ? '' : 'MATERIAL');
  static const ChannelProtocol COLOR = ChannelProtocol._(9, _omitEnumNames ? '' : 'COLOR');
  static const ChannelProtocol CLOCK = ChannelProtocol._(10, _omitEnumNames ? '' : 'CLOCK');

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
  static const Node_NodePreviewType NONE = Node_NodePreviewType._(0, _omitEnumNames ? '' : 'NONE');
  static const Node_NodePreviewType HISTORY = Node_NodePreviewType._(1, _omitEnumNames ? '' : 'HISTORY');
  static const Node_NodePreviewType WAVEFORM = Node_NodePreviewType._(2, _omitEnumNames ? '' : 'WAVEFORM');
  static const Node_NodePreviewType MULTIPLE = Node_NodePreviewType._(3, _omitEnumNames ? '' : 'MULTIPLE');
  static const Node_NodePreviewType TEXTURE = Node_NodePreviewType._(4, _omitEnumNames ? '' : 'TEXTURE');
  static const Node_NodePreviewType TIMECODE = Node_NodePreviewType._(5, _omitEnumNames ? '' : 'TIMECODE');
  static const Node_NodePreviewType DATA = Node_NodePreviewType._(6, _omitEnumNames ? '' : 'DATA');
  static const Node_NodePreviewType COLOR = Node_NodePreviewType._(7, _omitEnumNames ? '' : 'COLOR');

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
  static const MidiNodeConfig_NoteBinding_MidiType CC = MidiNodeConfig_NoteBinding_MidiType._(0, _omitEnumNames ? '' : 'CC');
  static const MidiNodeConfig_NoteBinding_MidiType NOTE = MidiNodeConfig_NoteBinding_MidiType._(1, _omitEnumNames ? '' : 'NOTE');

  static const $core.List<MidiNodeConfig_NoteBinding_MidiType> values = <MidiNodeConfig_NoteBinding_MidiType> [
    CC,
    NOTE,
  ];

  static final $core.Map<$core.int, MidiNodeConfig_NoteBinding_MidiType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MidiNodeConfig_NoteBinding_MidiType? valueOf($core.int value) => _byValue[value];

  const MidiNodeConfig_NoteBinding_MidiType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
