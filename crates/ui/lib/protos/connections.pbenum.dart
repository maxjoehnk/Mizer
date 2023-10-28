//
//  Generated code. Do not modify.
//  source: connections.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CdjPlayback_State extends $pb.ProtobufEnum {
  static const CdjPlayback_State LOADING = CdjPlayback_State._(0, _omitEnumNames ? '' : 'LOADING');
  static const CdjPlayback_State PLAYING = CdjPlayback_State._(1, _omitEnumNames ? '' : 'PLAYING');
  static const CdjPlayback_State CUED = CdjPlayback_State._(2, _omitEnumNames ? '' : 'CUED');
  static const CdjPlayback_State CUEING = CdjPlayback_State._(3, _omitEnumNames ? '' : 'CUEING');

  static const $core.List<CdjPlayback_State> values = <CdjPlayback_State> [
    LOADING,
    PLAYING,
    CUED,
    CUEING,
  ];

  static final $core.Map<$core.int, CdjPlayback_State> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CdjPlayback_State? valueOf($core.int value) => _byValue[value];

  const CdjPlayback_State._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
