//
//  Generated code. Do not modify.
//  source: fixtures.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class FixtureControl extends $pb.ProtobufEnum {
  static const FixtureControl NONE = FixtureControl._(0, _omitEnumNames ? '' : 'NONE');
  static const FixtureControl INTENSITY = FixtureControl._(1, _omitEnumNames ? '' : 'INTENSITY');
  static const FixtureControl SHUTTER = FixtureControl._(2, _omitEnumNames ? '' : 'SHUTTER');
  static const FixtureControl COLOR_MIXER = FixtureControl._(3, _omitEnumNames ? '' : 'COLOR_MIXER');
  static const FixtureControl COLOR_WHEEL = FixtureControl._(4, _omitEnumNames ? '' : 'COLOR_WHEEL');
  static const FixtureControl PAN = FixtureControl._(5, _omitEnumNames ? '' : 'PAN');
  static const FixtureControl TILT = FixtureControl._(6, _omitEnumNames ? '' : 'TILT');
  static const FixtureControl FOCUS = FixtureControl._(7, _omitEnumNames ? '' : 'FOCUS');
  static const FixtureControl ZOOM = FixtureControl._(8, _omitEnumNames ? '' : 'ZOOM');
  static const FixtureControl PRISM = FixtureControl._(9, _omitEnumNames ? '' : 'PRISM');
  static const FixtureControl IRIS = FixtureControl._(10, _omitEnumNames ? '' : 'IRIS');
  static const FixtureControl FROST = FixtureControl._(11, _omitEnumNames ? '' : 'FROST');
  static const FixtureControl GOBO = FixtureControl._(12, _omitEnumNames ? '' : 'GOBO');
  static const FixtureControl GENERIC = FixtureControl._(13, _omitEnumNames ? '' : 'GENERIC');

  static const $core.List<FixtureControl> values = <FixtureControl> [
    NONE,
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
  static const FixtureFaderControl_ColorMixerControlChannel RED = FixtureFaderControl_ColorMixerControlChannel._(0, _omitEnumNames ? '' : 'RED');
  static const FixtureFaderControl_ColorMixerControlChannel GREEN = FixtureFaderControl_ColorMixerControlChannel._(1, _omitEnumNames ? '' : 'GREEN');
  static const FixtureFaderControl_ColorMixerControlChannel BLUE = FixtureFaderControl_ColorMixerControlChannel._(2, _omitEnumNames ? '' : 'BLUE');

  static const $core.List<FixtureFaderControl_ColorMixerControlChannel> values = <FixtureFaderControl_ColorMixerControlChannel> [
    RED,
    GREEN,
    BLUE,
  ];

  static final $core.Map<$core.int, FixtureFaderControl_ColorMixerControlChannel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FixtureFaderControl_ColorMixerControlChannel? valueOf($core.int value) => _byValue[value];

  const FixtureFaderControl_ColorMixerControlChannel._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
