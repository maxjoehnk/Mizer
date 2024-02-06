//
//  Generated code. Do not modify.
//  source: plans.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class AlignFixturesRequest_AlignDirection extends $pb.ProtobufEnum {
  static const AlignFixturesRequest_AlignDirection LEFT_TO_RIGHT = AlignFixturesRequest_AlignDirection._(0, _omitEnumNames ? '' : 'LEFT_TO_RIGHT');
  static const AlignFixturesRequest_AlignDirection TOP_TO_BOTTOM = AlignFixturesRequest_AlignDirection._(1, _omitEnumNames ? '' : 'TOP_TO_BOTTOM');

  static const $core.List<AlignFixturesRequest_AlignDirection> values = <AlignFixturesRequest_AlignDirection> [
    LEFT_TO_RIGHT,
    TOP_TO_BOTTOM,
  ];

  static final $core.Map<$core.int, AlignFixturesRequest_AlignDirection> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AlignFixturesRequest_AlignDirection? valueOf($core.int value) => _byValue[value];

  const AlignFixturesRequest_AlignDirection._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
