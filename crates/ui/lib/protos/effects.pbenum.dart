///
//  Generated code. Do not modify.
//  source: effects.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class EffectControl extends $pb.ProtobufEnum {
  static const EffectControl INTENSITY = EffectControl._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INTENSITY');
  static const EffectControl SHUTTER = EffectControl._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SHUTTER');
  static const EffectControl COLOR_MIXER_RED = EffectControl._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_MIXER_RED');
  static const EffectControl COLOR_MIXER_GREEN = EffectControl._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_MIXER_GREEN');
  static const EffectControl COLOR_MIXER_BLUE = EffectControl._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_MIXER_BLUE');
  static const EffectControl COLOR_MIXER_AMBER = EffectControl._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_MIXER_AMBER');
  static const EffectControl COLOR_WHEEL = EffectControl._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_WHEEL');
  static const EffectControl PAN = EffectControl._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAN');
  static const EffectControl TILT = EffectControl._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TILT');
  static const EffectControl FOCUS = EffectControl._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FOCUS');
  static const EffectControl ZOOM = EffectControl._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ZOOM');
  static const EffectControl PRISM = EffectControl._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PRISM');
  static const EffectControl IRIS = EffectControl._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IRIS');
  static const EffectControl FROST = EffectControl._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FROST');
  static const EffectControl GOBO = EffectControl._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GOBO');
  static const EffectControl GENERIC = EffectControl._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GENERIC');

  static const $core.List<EffectControl> values = <EffectControl> [
    INTENSITY,
    SHUTTER,
    COLOR_MIXER_RED,
    COLOR_MIXER_GREEN,
    COLOR_MIXER_BLUE,
    COLOR_MIXER_AMBER,
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

