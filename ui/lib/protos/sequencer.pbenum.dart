///
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.7
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
  static CueTrigger valueOf($core.int value) => _byValue[value];

  const CueTrigger._($core.int v, $core.String n) : super(v, n);
}

