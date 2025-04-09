///
//  Generated code. Do not modify.
//  source: plans.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class AlignFixturesRequest_AlignDirection extends $pb.ProtobufEnum {
  static const AlignFixturesRequest_AlignDirection LEFT_TO_RIGHT = AlignFixturesRequest_AlignDirection._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEFT_TO_RIGHT');
  static const AlignFixturesRequest_AlignDirection TOP_TO_BOTTOM = AlignFixturesRequest_AlignDirection._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TOP_TO_BOTTOM');

  static const $core.List<AlignFixturesRequest_AlignDirection> values = <AlignFixturesRequest_AlignDirection> [
    LEFT_TO_RIGHT,
    TOP_TO_BOTTOM,
  ];

  static final $core.Map<$core.int, AlignFixturesRequest_AlignDirection> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AlignFixturesRequest_AlignDirection? valueOf($core.int value) => _byValue[value];

  const AlignFixturesRequest_AlignDirection._($core.int v, $core.String n) : super(v, n);
}

class SpreadFixturesRequest_SpreadGeometry extends $pb.ProtobufEnum {
  static const SpreadFixturesRequest_SpreadGeometry SQUARE = SpreadFixturesRequest_SpreadGeometry._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SQUARE');
  static const SpreadFixturesRequest_SpreadGeometry TRIANGLE = SpreadFixturesRequest_SpreadGeometry._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRIANGLE');
  static const SpreadFixturesRequest_SpreadGeometry CIRCLE = SpreadFixturesRequest_SpreadGeometry._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CIRCLE');

  static const $core.List<SpreadFixturesRequest_SpreadGeometry> values = <SpreadFixturesRequest_SpreadGeometry> [
    SQUARE,
    TRIANGLE,
    CIRCLE,
  ];

  static final $core.Map<$core.int, SpreadFixturesRequest_SpreadGeometry> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SpreadFixturesRequest_SpreadGeometry? valueOf($core.int value) => _byValue[value];

  const SpreadFixturesRequest_SpreadGeometry._($core.int v, $core.String n) : super(v, n);
}

