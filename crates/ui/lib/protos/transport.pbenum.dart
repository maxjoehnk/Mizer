//
//  Generated code. Do not modify.
//  source: transport.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class TransportState extends $pb.ProtobufEnum {
  static const TransportState STOPPED = TransportState._(0, _omitEnumNames ? '' : 'STOPPED');
  static const TransportState PAUSED = TransportState._(1, _omitEnumNames ? '' : 'PAUSED');
  static const TransportState PLAYING = TransportState._(2, _omitEnumNames ? '' : 'PLAYING');

  static const $core.List<TransportState> values = <TransportState> [
    STOPPED,
    PAUSED,
    PLAYING,
  ];

  static final $core.Map<$core.int, TransportState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TransportState? valueOf($core.int value) => _byValue[value];

  const TransportState._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
