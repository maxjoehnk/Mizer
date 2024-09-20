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

class FixtureChannelCategory extends $pb.ProtobufEnum {
  static const FixtureChannelCategory NONE = FixtureChannelCategory._(0, _omitEnumNames ? '' : 'NONE');
  static const FixtureChannelCategory DIMMER = FixtureChannelCategory._(1, _omitEnumNames ? '' : 'DIMMER');
  static const FixtureChannelCategory COLOR = FixtureChannelCategory._(2, _omitEnumNames ? '' : 'COLOR');
  static const FixtureChannelCategory POSITION = FixtureChannelCategory._(3, _omitEnumNames ? '' : 'POSITION');
  static const FixtureChannelCategory GOBO = FixtureChannelCategory._(4, _omitEnumNames ? '' : 'GOBO');
  static const FixtureChannelCategory BEAM = FixtureChannelCategory._(5, _omitEnumNames ? '' : 'BEAM');
  static const FixtureChannelCategory SHAPER = FixtureChannelCategory._(6, _omitEnumNames ? '' : 'SHAPER');
  static const FixtureChannelCategory CUSTOM = FixtureChannelCategory._(7, _omitEnumNames ? '' : 'CUSTOM');

  static const $core.List<FixtureChannelCategory> values = <FixtureChannelCategory> [
    NONE,
    DIMMER,
    COLOR,
    POSITION,
    GOBO,
    BEAM,
    SHAPER,
    CUSTOM,
  ];

  static final $core.Map<$core.int, FixtureChannelCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FixtureChannelCategory? valueOf($core.int value) => _byValue[value];

  const FixtureChannelCategory._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
