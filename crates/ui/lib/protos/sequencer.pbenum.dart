//
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class FixturePriority extends $pb.ProtobufEnum {
  static const FixturePriority PRIORITY_HTP = FixturePriority._(0, _omitEnumNames ? '' : 'PRIORITY_HTP');
  static const FixturePriority PRIORITY_LTP_HIGHEST = FixturePriority._(1, _omitEnumNames ? '' : 'PRIORITY_LTP_HIGHEST');
  static const FixturePriority PRIORITY_LTP_HIGH = FixturePriority._(2, _omitEnumNames ? '' : 'PRIORITY_LTP_HIGH');
  static const FixturePriority PRIORITY_LTP_NORMAL = FixturePriority._(3, _omitEnumNames ? '' : 'PRIORITY_LTP_NORMAL');
  static const FixturePriority PRIORITY_LTP_LOW = FixturePriority._(4, _omitEnumNames ? '' : 'PRIORITY_LTP_LOW');
  static const FixturePriority PRIORITY_LTP_LOWEST = FixturePriority._(5, _omitEnumNames ? '' : 'PRIORITY_LTP_LOWEST');

  static const $core.List<FixturePriority> values = <FixturePriority> [
    PRIORITY_HTP,
    PRIORITY_LTP_HIGHEST,
    PRIORITY_LTP_HIGH,
    PRIORITY_LTP_NORMAL,
    PRIORITY_LTP_LOW,
    PRIORITY_LTP_LOWEST,
  ];

  static final $core.Map<$core.int, FixturePriority> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FixturePriority? valueOf($core.int value) => _byValue[value];

  const FixturePriority._($core.int v, $core.String n) : super(v, n);
}

class CueTrigger_Type extends $pb.ProtobufEnum {
  static const CueTrigger_Type GO = CueTrigger_Type._(0, _omitEnumNames ? '' : 'GO');
  static const CueTrigger_Type FOLLOW = CueTrigger_Type._(1, _omitEnumNames ? '' : 'FOLLOW');
  static const CueTrigger_Type TIME = CueTrigger_Type._(2, _omitEnumNames ? '' : 'TIME');
  static const CueTrigger_Type BEATS = CueTrigger_Type._(3, _omitEnumNames ? '' : 'BEATS');
  static const CueTrigger_Type TIMECODE = CueTrigger_Type._(4, _omitEnumNames ? '' : 'TIMECODE');

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


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
