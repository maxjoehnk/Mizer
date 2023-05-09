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
  static const Node_NodeType VIDEO_EFFECT = Node_NodeType._(22, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VIDEO_EFFECT');
  static const Node_NodeType VIDEO_COLOR_BALANCE = Node_NodeType._(23, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VIDEO_COLOR_BALANCE');
  static const Node_NodeType VIDEO_TRANSFORM = Node_NodeType._(24, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VIDEO_TRANSFORM');
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
    VIDEO_EFFECT,
    VIDEO_COLOR_BALANCE,
    VIDEO_TRANSFORM,
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

class OscillatorNodeConfig_OscillatorType extends $pb.ProtobufEnum {
  static const OscillatorNodeConfig_OscillatorType SQUARE = OscillatorNodeConfig_OscillatorType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SQUARE');
  static const OscillatorNodeConfig_OscillatorType SINE = OscillatorNodeConfig_OscillatorType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SINE');
  static const OscillatorNodeConfig_OscillatorType SAW = OscillatorNodeConfig_OscillatorType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SAW');
  static const OscillatorNodeConfig_OscillatorType TRIANGLE = OscillatorNodeConfig_OscillatorType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRIANGLE');

  static const $core.List<OscillatorNodeConfig_OscillatorType> values = <OscillatorNodeConfig_OscillatorType> [
    SQUARE,
    SINE,
    SAW,
    TRIANGLE,
  ];

  static final $core.Map<$core.int, OscillatorNodeConfig_OscillatorType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OscillatorNodeConfig_OscillatorType? valueOf($core.int value) => _byValue[value];

  const OscillatorNodeConfig_OscillatorType._($core.int v, $core.String n) : super(v, n);
}

class GamepadNodeConfig_Control extends $pb.ProtobufEnum {
  static const GamepadNodeConfig_Control LEFT_STICK_X = GamepadNodeConfig_Control._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEFT_STICK_X');
  static const GamepadNodeConfig_Control LEFT_STICK_Y = GamepadNodeConfig_Control._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEFT_STICK_Y');
  static const GamepadNodeConfig_Control RIGHT_STICK_X = GamepadNodeConfig_Control._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RIGHT_STICK_X');
  static const GamepadNodeConfig_Control RIGHT_STICK_Y = GamepadNodeConfig_Control._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RIGHT_STICK_Y');
  static const GamepadNodeConfig_Control LEFT_TRIGGER = GamepadNodeConfig_Control._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEFT_TRIGGER');
  static const GamepadNodeConfig_Control RIGHT_TRIGGER = GamepadNodeConfig_Control._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RIGHT_TRIGGER');
  static const GamepadNodeConfig_Control LEFT_SHOULDER = GamepadNodeConfig_Control._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEFT_SHOULDER');
  static const GamepadNodeConfig_Control RIGHT_SHOULDER = GamepadNodeConfig_Control._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RIGHT_SHOULDER');
  static const GamepadNodeConfig_Control SOUTH = GamepadNodeConfig_Control._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SOUTH');
  static const GamepadNodeConfig_Control EAST = GamepadNodeConfig_Control._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EAST');
  static const GamepadNodeConfig_Control NORTH = GamepadNodeConfig_Control._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NORTH');
  static const GamepadNodeConfig_Control WEST = GamepadNodeConfig_Control._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WEST');
  static const GamepadNodeConfig_Control SELECT = GamepadNodeConfig_Control._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SELECT');
  static const GamepadNodeConfig_Control START = GamepadNodeConfig_Control._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'START');
  static const GamepadNodeConfig_Control MODE = GamepadNodeConfig_Control._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MODE');
  static const GamepadNodeConfig_Control DPAD_UP = GamepadNodeConfig_Control._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DPAD_UP');
  static const GamepadNodeConfig_Control DPAD_DOWN = GamepadNodeConfig_Control._(16, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DPAD_DOWN');
  static const GamepadNodeConfig_Control DPAD_LEFT = GamepadNodeConfig_Control._(17, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DPAD_LEFT');
  static const GamepadNodeConfig_Control DPAD_RIGHT = GamepadNodeConfig_Control._(18, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DPAD_RIGHT');
  static const GamepadNodeConfig_Control LEFT_STICK = GamepadNodeConfig_Control._(19, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEFT_STICK');
  static const GamepadNodeConfig_Control RIGHT_STICK = GamepadNodeConfig_Control._(20, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RIGHT_STICK');

  static const $core.List<GamepadNodeConfig_Control> values = <GamepadNodeConfig_Control> [
    LEFT_STICK_X,
    LEFT_STICK_Y,
    RIGHT_STICK_X,
    RIGHT_STICK_Y,
    LEFT_TRIGGER,
    RIGHT_TRIGGER,
    LEFT_SHOULDER,
    RIGHT_SHOULDER,
    SOUTH,
    EAST,
    NORTH,
    WEST,
    SELECT,
    START,
    MODE,
    DPAD_UP,
    DPAD_DOWN,
    DPAD_LEFT,
    DPAD_RIGHT,
    LEFT_STICK,
    RIGHT_STICK,
  ];

  static final $core.Map<$core.int, GamepadNodeConfig_Control> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GamepadNodeConfig_Control? valueOf($core.int value) => _byValue[value];

  const GamepadNodeConfig_Control._($core.int v, $core.String n) : super(v, n);
}

class PixelPatternNodeConfig_Pattern extends $pb.ProtobufEnum {
  static const PixelPatternNodeConfig_Pattern RGB_ITERATE = PixelPatternNodeConfig_Pattern._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RGB_ITERATE');
  static const PixelPatternNodeConfig_Pattern SWIRL = PixelPatternNodeConfig_Pattern._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SWIRL');

  static const $core.List<PixelPatternNodeConfig_Pattern> values = <PixelPatternNodeConfig_Pattern> [
    RGB_ITERATE,
    SWIRL,
  ];

  static final $core.Map<$core.int, PixelPatternNodeConfig_Pattern> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PixelPatternNodeConfig_Pattern? valueOf($core.int value) => _byValue[value];

  const PixelPatternNodeConfig_Pattern._($core.int v, $core.String n) : super(v, n);
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

class OscNodeConfig_ArgumentType extends $pb.ProtobufEnum {
  static const OscNodeConfig_ArgumentType INT = OscNodeConfig_ArgumentType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INT');
  static const OscNodeConfig_ArgumentType FLOAT = OscNodeConfig_ArgumentType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FLOAT');
  static const OscNodeConfig_ArgumentType LONG = OscNodeConfig_ArgumentType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LONG');
  static const OscNodeConfig_ArgumentType DOUBLE = OscNodeConfig_ArgumentType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOUBLE');
  static const OscNodeConfig_ArgumentType BOOL = OscNodeConfig_ArgumentType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BOOL');
  static const OscNodeConfig_ArgumentType COLOR = OscNodeConfig_ArgumentType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR');

  static const $core.List<OscNodeConfig_ArgumentType> values = <OscNodeConfig_ArgumentType> [
    INT,
    FLOAT,
    LONG,
    DOUBLE,
    BOOL,
    COLOR,
  ];

  static final $core.Map<$core.int, OscNodeConfig_ArgumentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OscNodeConfig_ArgumentType? valueOf($core.int value) => _byValue[value];

  const OscNodeConfig_ArgumentType._($core.int v, $core.String n) : super(v, n);
}

class MergeNodeConfig_MergeMode extends $pb.ProtobufEnum {
  static const MergeNodeConfig_MergeMode LATEST = MergeNodeConfig_MergeMode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LATEST');
  static const MergeNodeConfig_MergeMode HIGHEST = MergeNodeConfig_MergeMode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'HIGHEST');
  static const MergeNodeConfig_MergeMode LOWEST = MergeNodeConfig_MergeMode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LOWEST');

  static const $core.List<MergeNodeConfig_MergeMode> values = <MergeNodeConfig_MergeMode> [
    LATEST,
    HIGHEST,
    LOWEST,
  ];

  static final $core.Map<$core.int, MergeNodeConfig_MergeMode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MergeNodeConfig_MergeMode? valueOf($core.int value) => _byValue[value];

  const MergeNodeConfig_MergeMode._($core.int v, $core.String n) : super(v, n);
}

class MathNodeConfig_Mode extends $pb.ProtobufEnum {
  static const MathNodeConfig_Mode ADDITION = MathNodeConfig_Mode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ADDITION');
  static const MathNodeConfig_Mode SUBTRACTION = MathNodeConfig_Mode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SUBTRACTION');
  static const MathNodeConfig_Mode MULTIPLICATION = MathNodeConfig_Mode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MULTIPLICATION');
  static const MathNodeConfig_Mode DIVISION = MathNodeConfig_Mode._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DIVISION');
  static const MathNodeConfig_Mode INVERT = MathNodeConfig_Mode._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INVERT');
  static const MathNodeConfig_Mode SINE = MathNodeConfig_Mode._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SINE');
  static const MathNodeConfig_Mode COSINE = MathNodeConfig_Mode._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COSINE');
  static const MathNodeConfig_Mode TANGENT = MathNodeConfig_Mode._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TANGENT');

  static const $core.List<MathNodeConfig_Mode> values = <MathNodeConfig_Mode> [
    ADDITION,
    SUBTRACTION,
    MULTIPLICATION,
    DIVISION,
    INVERT,
    SINE,
    COSINE,
    TANGENT,
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
  static const G13InputNodeConfig_Key JOYSTICK_X = G13InputNodeConfig_Key._(30, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'JOYSTICK_X');
  static const G13InputNodeConfig_Key JOYSTICK_Y = G13InputNodeConfig_Key._(31, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'JOYSTICK_Y');
  static const G13InputNodeConfig_Key JOYSTICK = G13InputNodeConfig_Key._(32, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'JOYSTICK');
  static const G13InputNodeConfig_Key LEFT = G13InputNodeConfig_Key._(33, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEFT');
  static const G13InputNodeConfig_Key DOWN = G13InputNodeConfig_Key._(34, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DOWN');
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
    JOYSTICK_X,
    JOYSTICK_Y,
    JOYSTICK,
    LEFT,
    DOWN,
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

