///
//  Generated code. Do not modify.
//  source: connections.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CdjPlayback_State extends $pb.ProtobufEnum {
  static const CdjPlayback_State Loading = CdjPlayback_State._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Loading');
  static const CdjPlayback_State Playing = CdjPlayback_State._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Playing');
  static const CdjPlayback_State Cued = CdjPlayback_State._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Cued');
  static const CdjPlayback_State Cueing = CdjPlayback_State._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Cueing');

  static const $core.List<CdjPlayback_State> values = <CdjPlayback_State> [
    Loading,
    Playing,
    Cued,
    Cueing,
  ];

  static final $core.Map<$core.int, CdjPlayback_State> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CdjPlayback_State? valueOf($core.int value) => _byValue[value];

  const CdjPlayback_State._($core.int v, $core.String n) : super(v, n);
}

