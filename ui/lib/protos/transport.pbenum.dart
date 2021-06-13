///
//  Generated code. Do not modify.
//  source: transport.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class TransportState extends $pb.ProtobufEnum {
  static const TransportState Stopped = TransportState._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Stopped');
  static const TransportState Paused = TransportState._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Paused');
  static const TransportState Playing = TransportState._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Playing');

  static const $core.List<TransportState> values = <TransportState> [
    Stopped,
    Paused,
    Playing,
  ];

  static final $core.Map<$core.int, TransportState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TransportState valueOf($core.int value) => _byValue[value];

  const TransportState._($core.int v, $core.String n) : super(v, n);
}

