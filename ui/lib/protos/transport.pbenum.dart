///
//  Generated code. Do not modify.
//  source: transport.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class TransportState extends $pb.ProtobufEnum {
  static const TransportState STOPPED = TransportState._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STOPPED');
  static const TransportState PAUSED = TransportState._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAUSED');
  static const TransportState PLAYING = TransportState._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PLAYING');

  static const $core.List<TransportState> values = <TransportState> [
    STOPPED,
    PAUSED,
    PLAYING,
  ];

  static final $core.Map<$core.int, TransportState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TransportState? valueOf($core.int value) => _byValue[value];

  const TransportState._($core.int v, $core.String n) : super(v, n);
}

