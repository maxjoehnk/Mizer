///
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CueTrigger extends $pb.ProtobufEnum {
  static const CueTrigger GO = CueTrigger._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GO');
  static const CueTrigger FOLLOW = CueTrigger._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FOLLOW');
  static const CueTrigger BEATS = CueTrigger._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BEATS');
  static const CueTrigger TIMECODE = CueTrigger._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIMECODE');

  static const $core.List<CueTrigger> values = <CueTrigger> [
    GO,
    FOLLOW,
    BEATS,
    TIMECODE,
  ];

  static final $core.Map<$core.int, CueTrigger> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CueTrigger? valueOf($core.int value) => _byValue[value];

  const CueTrigger._($core.int v, $core.String n) : super(v, n);
}

class CueControl extends $pb.ProtobufEnum {
  static const CueControl INTENSITY = CueControl._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INTENSITY');
  static const CueControl SHUTTER = CueControl._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SHUTTER');
  static const CueControl COLOR_RED = CueControl._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_RED');
  static const CueControl COLOR_GREEN = CueControl._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_GREEN');
  static const CueControl COLOR_BLUE = CueControl._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_BLUE');
  static const CueControl PAN = CueControl._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAN');
  static const CueControl TILT = CueControl._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TILT');
  static const CueControl FOCUS = CueControl._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FOCUS');
  static const CueControl ZOOM = CueControl._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ZOOM');
  static const CueControl PRISM = CueControl._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PRISM');
  static const CueControl IRIS = CueControl._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IRIS');
  static const CueControl FROST = CueControl._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FROST');
  static const CueControl GENERIC = CueControl._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GENERIC');

  static const $core.List<CueControl> values = <CueControl> [
    INTENSITY,
    SHUTTER,
    COLOR_RED,
    COLOR_GREEN,
    COLOR_BLUE,
    PAN,
    TILT,
    FOCUS,
    ZOOM,
    PRISM,
    IRIS,
    FROST,
    GENERIC,
  ];

  static final $core.Map<$core.int, CueControl> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CueControl? valueOf($core.int value) => _byValue[value];

  const CueControl._($core.int v, $core.String n) : super(v, n);
}

