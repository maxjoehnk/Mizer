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

class Node_NodeType extends $pb.ProtobufEnum {
  static const Node_NodeType FADER = Node_NodeType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FADER');
  static const Node_NodeType BUTTON = Node_NodeType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUTTON');
  static const Node_NodeType OSCILLATOR = Node_NodeType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OSCILLATOR');
  static const Node_NodeType CLOCK = Node_NodeType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CLOCK');
  static const Node_NodeType SCRIPT = Node_NodeType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SCRIPT');
  static const Node_NodeType ENVELOPE = Node_NodeType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ENVELOPE');
  static const Node_NodeType SEQUENCE = Node_NodeType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SEQUENCE');
  static const Node_NodeType SELECT = Node_NodeType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SELECT');
  static const Node_NodeType MERGE = Node_NodeType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MERGE');
  static const Node_NodeType THRESHOLD = Node_NodeType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'THRESHOLD');
  static const Node_NodeType DMX_OUTPUT = Node_NodeType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DMX_OUTPUT');
  static const Node_NodeType OSC_INPUT = Node_NodeType._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OSC_INPUT');
  static const Node_NodeType OSC_OUTPUT = Node_NodeType._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OSC_OUTPUT');
  static const Node_NodeType MIDI_INPUT = Node_NodeType._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MIDI_INPUT');
  static const Node_NodeType MIDI_OUTPUT = Node_NodeType._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MIDI_OUTPUT');
  static const Node_NodeType SEQUENCER = Node_NodeType._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SEQUENCER');
  static const Node_NodeType FIXTURE = Node_NodeType._(16, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FIXTURE');
  static const Node_NodeType PROGRAMMER = Node_NodeType._(17, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PROGRAMMER');
  static const Node_NodeType GROUP = Node_NodeType._(18, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GROUP');
  static const Node_NodeType PRESET = Node_NodeType._(19, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PRESET');
  static const Node_NodeType VIDEO_FILE = Node_NodeType._(20, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VIDEO_FILE');
  static const Node_NodeType VIDEO_OUTPUT = Node_NodeType._(21, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VIDEO_OUTPUT');
  static const Node_NodeType VIDEO_HSV = Node_NodeType._(23, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VIDEO_HSV');
  static const Node_NodeType VIDEO_TRANSFORM = Node_NodeType._(24, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VIDEO_TRANSFORM');
  static const Node_NodeType VIDEO_MIXER = Node_NodeType._(25, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VIDEO_MIXER');
  static const Node_NodeType VIDEO_RGB = Node_NodeType._(26, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VIDEO_RGB');
  static const Node_NodeType VIDEO_RGB_SPLIT = Node_NodeType._(27, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VIDEO_RGB_SPLIT');
  static const Node_NodeType PIXEL_TO_DMX = Node_NodeType._(30, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PIXEL_TO_DMX');
  static const Node_NodeType PIXEL_PATTERN = Node_NodeType._(31, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PIXEL_PATTERN');
  static const Node_NodeType OPC_OUTPUT = Node_NodeType._(32, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OPC_OUTPUT');
  static const Node_NodeType LASER = Node_NodeType._(40, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LASER');
  static const Node_NodeType ILDA_FILE = Node_NodeType._(41, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ILDA_FILE');
  static const Node_NodeType GAMEPAD = Node_NodeType._(45, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GAMEPAD');
  static const Node_NodeType COLOR_RGB = Node_NodeType._(50, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_RGB');
  static const Node_NodeType COLOR_HSV = Node_NodeType._(51, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_HSV');
  static const Node_NodeType COLOR_CONSTANT = Node_NodeType._(52, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_CONSTANT');
  static const Node_NodeType COLOR_BRIGHTNESS = Node_NodeType._(53, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_BRIGHTNESS');
  static const Node_NodeType ENCODER = Node_NodeType._(55, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ENCODER');
  static const Node_NodeType MATH = Node_NodeType._(56, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MATH');
  static const Node_NodeType DATA_TO_NUMBER = Node_NodeType._(57, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DATA_TO_NUMBER');
  static const Node_NodeType NUMBER_TO_DATA = Node_NodeType._(58, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NUMBER_TO_DATA');
  static const Node_NodeType VALUE = Node_NodeType._(59, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VALUE');
  static const Node_NodeType EXTRACT = Node_NodeType._(60, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXTRACT');
  static const Node_NodeType MQTT_INPUT = Node_NodeType._(61, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MQTT_INPUT');
  static const Node_NodeType MQTT_OUTPUT = Node_NodeType._(62, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MQTT_OUTPUT');
  static const Node_NodeType PLAN_SCREEN = Node_NodeType._(63, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PLAN_SCREEN');
  static const Node_NodeType DELAY = Node_NodeType._(64, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DELAY');
  static const Node_NodeType RAMP = Node_NodeType._(65, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RAMP');
  static const Node_NodeType NOISE = Node_NodeType._(66, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NOISE');
  static const Node_NodeType LABEL = Node_NodeType._(67, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LABEL');
  static const Node_NodeType TRANSPORT = Node_NodeType._(68, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRANSPORT');
  static const Node_NodeType G13INPUT = Node_NodeType._(69, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G13INPUT');
  static const Node_NodeType G13OUTPUT = Node_NodeType._(70, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G13OUTPUT');
  static const Node_NodeType CONSTANT_NUMBER = Node_NodeType._(71, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CONSTANT_NUMBER');
  static const Node_NodeType CONDITIONAL = Node_NodeType._(72, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CONDITIONAL');
  static const Node_NodeType TIMECODE_CONTROL = Node_NodeType._(73, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIMECODE_CONTROL');
  static const Node_NodeType TIMECODE_OUTPUT = Node_NodeType._(74, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIMECODE_OUTPUT');
  static const Node_NodeType AUDIO_FILE = Node_NodeType._(75, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AUDIO_FILE');
  static const Node_NodeType AUDIO_OUTPUT = Node_NodeType._(76, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AUDIO_OUTPUT');
  static const Node_NodeType AUDIO_VOLUME = Node_NodeType._(77, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AUDIO_VOLUME');
  static const Node_NodeType AUDIO_INPUT = Node_NodeType._(78, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AUDIO_INPUT');
  static const Node_NodeType AUDIO_MIX = Node_NodeType._(79, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AUDIO_MIX');
  static const Node_NodeType AUDIO_METER = Node_NodeType._(80, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AUDIO_METER');
  static const Node_NodeType TEMPLATE = Node_NodeType._(81, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEMPLATE');
  static const Node_NodeType WEBCAM = Node_NodeType._(82, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WEBCAM');
  static const Node_NodeType TEXTURE_BORDER = Node_NodeType._(83, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEXTURE_BORDER');
  static const Node_NodeType VIDEO_TEXT = Node_NodeType._(84, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VIDEO_TEXT');
  static const Node_NodeType BEATS = Node_NodeType._(85, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BEATS');
  static const Node_NodeType CONTAINER = Node_NodeType._(100, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CONTAINER');

  static const $core.List<Node_NodeType> values = <Node_NodeType> [
    FADER,
    BUTTON,
    OSCILLATOR,
    CLOCK,
    SCRIPT,
    ENVELOPE,
    SEQUENCE,
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
    CONTAINER,
  ];

  static final $core.Map<$core.int, Node_NodeType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Node_NodeType? valueOf($core.int value) => _byValue[value];

  const Node_NodeType._($core.int v, $core.String n) : super(v, n);
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

