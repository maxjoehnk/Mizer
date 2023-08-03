///
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CueTrigger_Type extends $pb.ProtobufEnum {
  static const CueTrigger_Type GO = CueTrigger_Type._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GO');
  static const CueTrigger_Type FOLLOW = CueTrigger_Type._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FOLLOW');
  static const CueTrigger_Type TIME = CueTrigger_Type._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIME');
  static const CueTrigger_Type BEATS = CueTrigger_Type._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BEATS');
  static const CueTrigger_Type TIMECODE = CueTrigger_Type._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIMECODE');

  static const $core.List<CueTrigger_Type> values = <CueTrigger_Type> [
    GO,
    FOLLOW,
    TIME,
    BEATS,
    TIMECODE,
  ];

  static final $core.Map<$core.int, CueTrigger_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CueTrigger_Type? valueOf($core.int value) => _byValue[value];

  const CueTrigger_Type._($core.int v, $core.String n) : super(v, n);
}

class CueControl_Type extends $pb.ProtobufEnum {
  static const CueControl_Type INTENSITY = CueControl_Type._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INTENSITY');
  static const CueControl_Type SHUTTER = CueControl_Type._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SHUTTER');
  static const CueControl_Type COLOR_RED = CueControl_Type._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_RED');
  static const CueControl_Type COLOR_GREEN = CueControl_Type._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_GREEN');
  static const CueControl_Type COLOR_BLUE = CueControl_Type._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_BLUE');
  static const CueControl_Type COLOR_WHEEL = CueControl_Type._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_WHEEL');
  static const CueControl_Type PAN = CueControl_Type._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAN');
  static const CueControl_Type TILT = CueControl_Type._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TILT');
  static const CueControl_Type WORLD_X = CueControl_Type._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WORLD_X');
  static const CueControl_Type WORLD_Y = CueControl_Type._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WORLD_Y');
  static const CueControl_Type WORLD_Z = CueControl_Type._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WORLD_Z');
  static const CueControl_Type FOCUS = CueControl_Type._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FOCUS');
  static const CueControl_Type ZOOM = CueControl_Type._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ZOOM');
  static const CueControl_Type PRISM = CueControl_Type._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PRISM');
  static const CueControl_Type IRIS = CueControl_Type._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IRIS');
  static const CueControl_Type FROST = CueControl_Type._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FROST');
  static const CueControl_Type GOBO = CueControl_Type._(16, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GOBO');
  static const CueControl_Type GENERIC = CueControl_Type._(17, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GENERIC');

  static const $core.List<CueControl_Type> values = <CueControl_Type> [
    INTENSITY,
    SHUTTER,
    COLOR_RED,
    COLOR_GREEN,
    COLOR_BLUE,
    COLOR_WHEEL,
    PAN,
    TILT,
    WORLD_X,
    WORLD_Y,
    WORLD_Z,
    FOCUS,
    ZOOM,
    PRISM,
    IRIS,
    FROST,
    GOBO,
    GENERIC,
  ];

  static final $core.Map<$core.int, CueControl_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CueControl_Type? valueOf($core.int value) => _byValue[value];

  const CueControl_Type._($core.int v, $core.String n) : super(v, n);
}

