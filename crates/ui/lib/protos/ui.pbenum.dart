//
//  Generated code. Do not modify.
//  source: ui.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class PanelGroup_Direction extends $pb.ProtobufEnum {
  static const PanelGroup_Direction DIRECTION_HORIZONTAL = PanelGroup_Direction._(0, _omitEnumNames ? '' : 'DIRECTION_HORIZONTAL');
  static const PanelGroup_Direction DIRECTION_VERTICAL = PanelGroup_Direction._(1, _omitEnumNames ? '' : 'DIRECTION_VERTICAL');

  static const $core.List<PanelGroup_Direction> values = <PanelGroup_Direction> [
    DIRECTION_HORIZONTAL,
    DIRECTION_VERTICAL,
  ];

  static final $core.Map<$core.int, PanelGroup_Direction> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PanelGroup_Direction? valueOf($core.int value) => _byValue[value];

  const PanelGroup_Direction._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
