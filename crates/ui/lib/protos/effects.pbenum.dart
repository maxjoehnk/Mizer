//
//  Generated code. Do not modify.
//  source: effects.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class EffectControl extends $pb.ProtobufEnum {
  static const EffectControl INTENSITY = EffectControl._(0, _omitEnumNames ? '' : 'INTENSITY');
  static const EffectControl SHUTTER = EffectControl._(1, _omitEnumNames ? '' : 'SHUTTER');
  static const EffectControl COLOR_MIXER_RED = EffectControl._(2, _omitEnumNames ? '' : 'COLOR_MIXER_RED');
  static const EffectControl COLOR_MIXER_GREEN = EffectControl._(3, _omitEnumNames ? '' : 'COLOR_MIXER_GREEN');
  static const EffectControl COLOR_MIXER_BLUE = EffectControl._(4, _omitEnumNames ? '' : 'COLOR_MIXER_BLUE');
  static const EffectControl COLOR_WHEEL = EffectControl._(5, _omitEnumNames ? '' : 'COLOR_WHEEL');
  static const EffectControl PAN = EffectControl._(6, _omitEnumNames ? '' : 'PAN');
  static const EffectControl TILT = EffectControl._(7, _omitEnumNames ? '' : 'TILT');
  static const EffectControl FOCUS = EffectControl._(8, _omitEnumNames ? '' : 'FOCUS');
  static const EffectControl ZOOM = EffectControl._(9, _omitEnumNames ? '' : 'ZOOM');
  static const EffectControl PRISM = EffectControl._(10, _omitEnumNames ? '' : 'PRISM');
  static const EffectControl IRIS = EffectControl._(11, _omitEnumNames ? '' : 'IRIS');
  static const EffectControl FROST = EffectControl._(12, _omitEnumNames ? '' : 'FROST');
  static const EffectControl GOBO = EffectControl._(13, _omitEnumNames ? '' : 'GOBO');
  static const EffectControl GENERIC = EffectControl._(14, _omitEnumNames ? '' : 'GENERIC');

  static const $core.List<EffectControl> values = <EffectControl> [
    INTENSITY,
    SHUTTER,
    COLOR_MIXER_RED,
    COLOR_MIXER_GREEN,
    COLOR_MIXER_BLUE,
    COLOR_WHEEL,
    PAN,
    TILT,
    FOCUS,
    ZOOM,
    PRISM,
    IRIS,
    FROST,
    GOBO,
    GENERIC,
  ];

  static final $core.Map<$core.int, EffectControl> _byValue = $pb.ProtobufEnum.initByValue(values);
  static EffectControl? valueOf($core.int value) => _byValue[value];

  const EffectControl._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
