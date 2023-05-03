///
//  Generated code. Do not modify.
//  source: fixtures.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class FixtureControl extends $pb.ProtobufEnum {
  static const FixtureControl INTENSITY = FixtureControl._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INTENSITY');
  static const FixtureControl SHUTTER = FixtureControl._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SHUTTER');
  static const FixtureControl COLOR_MIXER = FixtureControl._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_MIXER');
  static const FixtureControl COLOR_WHEEL = FixtureControl._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR_WHEEL');
  static const FixtureControl PAN = FixtureControl._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAN');
  static const FixtureControl TILT = FixtureControl._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TILT');
  static const FixtureControl FOCUS = FixtureControl._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FOCUS');
  static const FixtureControl ZOOM = FixtureControl._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ZOOM');
  static const FixtureControl PRISM = FixtureControl._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PRISM');
  static const FixtureControl IRIS = FixtureControl._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IRIS');
  static const FixtureControl FROST = FixtureControl._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FROST');
  static const FixtureControl GOBO = FixtureControl._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GOBO');
  static const FixtureControl GENERIC = FixtureControl._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GENERIC');

  static const $core.List<FixtureControl> values = <FixtureControl> [
    INTENSITY,
    SHUTTER,
    COLOR_MIXER,
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

  static final $core.Map<$core.int, FixtureControl> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FixtureControl? valueOf($core.int value) => _byValue[value];

  const FixtureControl._($core.int v, $core.String n) : super(v, n);
}

class FixtureFaderControl_ColorMixerControlChannel extends $pb.ProtobufEnum {
  static const FixtureFaderControl_ColorMixerControlChannel RED = FixtureFaderControl_ColorMixerControlChannel._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RED');
  static const FixtureFaderControl_ColorMixerControlChannel GREEN = FixtureFaderControl_ColorMixerControlChannel._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GREEN');
  static const FixtureFaderControl_ColorMixerControlChannel BLUE = FixtureFaderControl_ColorMixerControlChannel._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BLUE');

  static const $core.List<FixtureFaderControl_ColorMixerControlChannel> values = <FixtureFaderControl_ColorMixerControlChannel> [
    RED,
    GREEN,
    BLUE,
  ];

  static final $core.Map<$core.int, FixtureFaderControl_ColorMixerControlChannel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FixtureFaderControl_ColorMixerControlChannel? valueOf($core.int value) => _byValue[value];

  const FixtureFaderControl_ColorMixerControlChannel._($core.int v, $core.String n) : super(v, n);
}

