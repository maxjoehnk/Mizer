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

class Node_NodeType extends $pb.ProtobufEnum {
  static const Node_NodeType FADER = Node_NodeType._(0, _omitEnumNames ? '' : 'FADER');
  static const Node_NodeType BUTTON = Node_NodeType._(1, _omitEnumNames ? '' : 'BUTTON');
  static const Node_NodeType OSCILLATOR = Node_NodeType._(2, _omitEnumNames ? '' : 'OSCILLATOR');
  static const Node_NodeType CLOCK = Node_NodeType._(3, _omitEnumNames ? '' : 'CLOCK');
  static const Node_NodeType SCRIPT = Node_NodeType._(4, _omitEnumNames ? '' : 'SCRIPT');
  static const Node_NodeType ENVELOPE = Node_NodeType._(5, _omitEnumNames ? '' : 'ENVELOPE');
  static const Node_NodeType STEP_SEQUENCER = Node_NodeType._(6, _omitEnumNames ? '' : 'STEP_SEQUENCER');
  static const Node_NodeType SELECT = Node_NodeType._(7, _omitEnumNames ? '' : 'SELECT');
  static const Node_NodeType MERGE = Node_NodeType._(8, _omitEnumNames ? '' : 'MERGE');
  static const Node_NodeType THRESHOLD = Node_NodeType._(9, _omitEnumNames ? '' : 'THRESHOLD');
  static const Node_NodeType DMX_OUTPUT = Node_NodeType._(10, _omitEnumNames ? '' : 'DMX_OUTPUT');
  static const Node_NodeType OSC_INPUT = Node_NodeType._(11, _omitEnumNames ? '' : 'OSC_INPUT');
  static const Node_NodeType OSC_OUTPUT = Node_NodeType._(12, _omitEnumNames ? '' : 'OSC_OUTPUT');
  static const Node_NodeType MIDI_INPUT = Node_NodeType._(13, _omitEnumNames ? '' : 'MIDI_INPUT');
  static const Node_NodeType MIDI_OUTPUT = Node_NodeType._(14, _omitEnumNames ? '' : 'MIDI_OUTPUT');
  static const Node_NodeType SEQUENCER = Node_NodeType._(15, _omitEnumNames ? '' : 'SEQUENCER');
  static const Node_NodeType FIXTURE = Node_NodeType._(16, _omitEnumNames ? '' : 'FIXTURE');
  static const Node_NodeType PROGRAMMER = Node_NodeType._(17, _omitEnumNames ? '' : 'PROGRAMMER');
  static const Node_NodeType GROUP = Node_NodeType._(18, _omitEnumNames ? '' : 'GROUP');
  static const Node_NodeType PRESET = Node_NodeType._(19, _omitEnumNames ? '' : 'PRESET');
  static const Node_NodeType VIDEO_FILE = Node_NodeType._(20, _omitEnumNames ? '' : 'VIDEO_FILE');
  static const Node_NodeType VIDEO_OUTPUT = Node_NodeType._(21, _omitEnumNames ? '' : 'VIDEO_OUTPUT');
  static const Node_NodeType VIDEO_HSV = Node_NodeType._(23, _omitEnumNames ? '' : 'VIDEO_HSV');
  static const Node_NodeType VIDEO_TRANSFORM = Node_NodeType._(24, _omitEnumNames ? '' : 'VIDEO_TRANSFORM');
  static const Node_NodeType VIDEO_MIXER = Node_NodeType._(25, _omitEnumNames ? '' : 'VIDEO_MIXER');
  static const Node_NodeType VIDEO_RGB = Node_NodeType._(26, _omitEnumNames ? '' : 'VIDEO_RGB');
  static const Node_NodeType VIDEO_RGB_SPLIT = Node_NodeType._(27, _omitEnumNames ? '' : 'VIDEO_RGB_SPLIT');
  static const Node_NodeType PIXEL_TO_DMX = Node_NodeType._(30, _omitEnumNames ? '' : 'PIXEL_TO_DMX');
  static const Node_NodeType PIXEL_PATTERN = Node_NodeType._(31, _omitEnumNames ? '' : 'PIXEL_PATTERN');
  static const Node_NodeType OPC_OUTPUT = Node_NodeType._(32, _omitEnumNames ? '' : 'OPC_OUTPUT');
  static const Node_NodeType LASER = Node_NodeType._(40, _omitEnumNames ? '' : 'LASER');
  static const Node_NodeType ILDA_FILE = Node_NodeType._(41, _omitEnumNames ? '' : 'ILDA_FILE');
  static const Node_NodeType GAMEPAD = Node_NodeType._(45, _omitEnumNames ? '' : 'GAMEPAD');
  static const Node_NodeType COLOR_RGB = Node_NodeType._(50, _omitEnumNames ? '' : 'COLOR_RGB');
  static const Node_NodeType COLOR_HSV = Node_NodeType._(51, _omitEnumNames ? '' : 'COLOR_HSV');
  static const Node_NodeType COLOR_CONSTANT = Node_NodeType._(52, _omitEnumNames ? '' : 'COLOR_CONSTANT');
  static const Node_NodeType COLOR_BRIGHTNESS = Node_NodeType._(53, _omitEnumNames ? '' : 'COLOR_BRIGHTNESS');
  static const Node_NodeType ENCODER = Node_NodeType._(55, _omitEnumNames ? '' : 'ENCODER');
  static const Node_NodeType MATH = Node_NodeType._(56, _omitEnumNames ? '' : 'MATH');
  static const Node_NodeType DATA_TO_NUMBER = Node_NodeType._(57, _omitEnumNames ? '' : 'DATA_TO_NUMBER');
  static const Node_NodeType NUMBER_TO_DATA = Node_NodeType._(58, _omitEnumNames ? '' : 'NUMBER_TO_DATA');
  static const Node_NodeType VALUE = Node_NodeType._(59, _omitEnumNames ? '' : 'VALUE');
  static const Node_NodeType EXTRACT = Node_NodeType._(60, _omitEnumNames ? '' : 'EXTRACT');
  static const Node_NodeType MQTT_INPUT = Node_NodeType._(61, _omitEnumNames ? '' : 'MQTT_INPUT');
  static const Node_NodeType MQTT_OUTPUT = Node_NodeType._(62, _omitEnumNames ? '' : 'MQTT_OUTPUT');
  static const Node_NodeType PLAN_SCREEN = Node_NodeType._(63, _omitEnumNames ? '' : 'PLAN_SCREEN');
  static const Node_NodeType DELAY = Node_NodeType._(64, _omitEnumNames ? '' : 'DELAY');
  static const Node_NodeType RAMP = Node_NodeType._(65, _omitEnumNames ? '' : 'RAMP');
  static const Node_NodeType NOISE = Node_NodeType._(66, _omitEnumNames ? '' : 'NOISE');
  static const Node_NodeType LABEL = Node_NodeType._(67, _omitEnumNames ? '' : 'LABEL');
  static const Node_NodeType TRANSPORT = Node_NodeType._(68, _omitEnumNames ? '' : 'TRANSPORT');
  static const Node_NodeType G13INPUT = Node_NodeType._(69, _omitEnumNames ? '' : 'G13INPUT');
  static const Node_NodeType G13OUTPUT = Node_NodeType._(70, _omitEnumNames ? '' : 'G13OUTPUT');
  static const Node_NodeType CONSTANT_NUMBER = Node_NodeType._(71, _omitEnumNames ? '' : 'CONSTANT_NUMBER');
  static const Node_NodeType CONDITIONAL = Node_NodeType._(72, _omitEnumNames ? '' : 'CONDITIONAL');
  static const Node_NodeType TIMECODE_CONTROL = Node_NodeType._(73, _omitEnumNames ? '' : 'TIMECODE_CONTROL');
  static const Node_NodeType TIMECODE_OUTPUT = Node_NodeType._(74, _omitEnumNames ? '' : 'TIMECODE_OUTPUT');
  static const Node_NodeType AUDIO_FILE = Node_NodeType._(75, _omitEnumNames ? '' : 'AUDIO_FILE');
  static const Node_NodeType AUDIO_OUTPUT = Node_NodeType._(76, _omitEnumNames ? '' : 'AUDIO_OUTPUT');
  static const Node_NodeType AUDIO_VOLUME = Node_NodeType._(77, _omitEnumNames ? '' : 'AUDIO_VOLUME');
  static const Node_NodeType AUDIO_INPUT = Node_NodeType._(78, _omitEnumNames ? '' : 'AUDIO_INPUT');
  static const Node_NodeType AUDIO_MIX = Node_NodeType._(79, _omitEnumNames ? '' : 'AUDIO_MIX');
  static const Node_NodeType AUDIO_METER = Node_NodeType._(80, _omitEnumNames ? '' : 'AUDIO_METER');
  static const Node_NodeType TEMPLATE = Node_NodeType._(81, _omitEnumNames ? '' : 'TEMPLATE');
  static const Node_NodeType WEBCAM = Node_NodeType._(82, _omitEnumNames ? '' : 'WEBCAM');
  static const Node_NodeType TEXTURE_BORDER = Node_NodeType._(83, _omitEnumNames ? '' : 'TEXTURE_BORDER');
  static const Node_NodeType VIDEO_TEXT = Node_NodeType._(84, _omitEnumNames ? '' : 'VIDEO_TEXT');
  static const Node_NodeType BEATS = Node_NodeType._(85, _omitEnumNames ? '' : 'BEATS');
  static const Node_NodeType PRO_DJ_LINK_CLOCK = Node_NodeType._(86, _omitEnumNames ? '' : 'PRO_DJ_LINK_CLOCK');
  static const Node_NodeType PIONEER_CDJ = Node_NodeType._(87, _omitEnumNames ? '' : 'PIONEER_CDJ');
  static const Node_NodeType NDI_OUTPUT = Node_NodeType._(88, _omitEnumNames ? '' : 'NDI_OUTPUT');
  static const Node_NodeType SCREEN_CAPTURE = Node_NodeType._(89, _omitEnumNames ? '' : 'SCREEN_CAPTURE');
  static const Node_NodeType CONTAINER = Node_NodeType._(100, _omitEnumNames ? '' : 'CONTAINER');

  static const $core.List<Node_NodeType> values = <Node_NodeType> [
    FADER,
    BUTTON,
    OSCILLATOR,
    CLOCK,
    SCRIPT,
    ENVELOPE,
    STEP_SEQUENCER,
    SELECT,
    MERGE,
    THRESHOLD,
    DMX_OUTPUT,
    OSC_INPUT,
    OSC_OUTPUT,
    MIDI_INPUT,
    MIDI_OUTPUT,
    SEQUENCER,
    FIXTURE,
    PROGRAMMER,
    GROUP,
    PRESET,
    VIDEO_FILE,
    VIDEO_OUTPUT,
    VIDEO_HSV,
    VIDEO_TRANSFORM,
    VIDEO_MIXER,
    VIDEO_RGB,
    VIDEO_RGB_SPLIT,
    PIXEL_TO_DMX,
    PIXEL_PATTERN,
    OPC_OUTPUT,
    LASER,
    ILDA_FILE,
    GAMEPAD,
    COLOR_RGB,
    COLOR_HSV,
    COLOR_CONSTANT,
    COLOR_BRIGHTNESS,
    ENCODER,
    MATH,
    DATA_TO_NUMBER,
    NUMBER_TO_DATA,
    VALUE,
    EXTRACT,
    MQTT_INPUT,
    MQTT_OUTPUT,
    PLAN_SCREEN,
    DELAY,
    RAMP,
    NOISE,
    LABEL,
    TRANSPORT,
    G13INPUT,
    G13OUTPUT,
    CONSTANT_NUMBER,
    CONDITIONAL,
    TIMECODE_CONTROL,
    TIMECODE_OUTPUT,
    AUDIO_FILE,
    AUDIO_OUTPUT,
    AUDIO_VOLUME,
    AUDIO_INPUT,
    AUDIO_MIX,
    AUDIO_METER,
    TEMPLATE,
    WEBCAM,
    TEXTURE_BORDER,
    VIDEO_TEXT,
    BEATS,
    PRO_DJ_LINK_CLOCK,
    PIONEER_CDJ,
    NDI_OUTPUT,
    SCREEN_CAPTURE,
    CONTAINER,
  ];

  static final $core.Map<$core.int, Node_NodeType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Node_NodeType? valueOf($core.int value) => _byValue[value];

  const Node_NodeType._($core.int v, $core.String n) : super(v, n);
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
