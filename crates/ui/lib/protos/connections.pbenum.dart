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

class CitpConnection_CitpKind extends $pb.ProtobufEnum {
  static const CitpConnection_CitpKind CITP_KIND_LIGHTING_CONSOLE = CitpConnection_CitpKind._(0, _omitEnumNames ? '' : 'CITP_KIND_LIGHTING_CONSOLE');
  static const CitpConnection_CitpKind CITP_KIND_MEDIA_SERVER = CitpConnection_CitpKind._(1, _omitEnumNames ? '' : 'CITP_KIND_MEDIA_SERVER');
  static const CitpConnection_CitpKind CITP_KIND_VISUALIZER = CitpConnection_CitpKind._(2, _omitEnumNames ? '' : 'CITP_KIND_VISUALIZER');
  static const CitpConnection_CitpKind CITP_KIND_UNKNOWN = CitpConnection_CitpKind._(3, _omitEnumNames ? '' : 'CITP_KIND_UNKNOWN');

  static const $core.List<CitpConnection_CitpKind> values = <CitpConnection_CitpKind> [
    CITP_KIND_LIGHTING_CONSOLE,
    CITP_KIND_MEDIA_SERVER,
    CITP_KIND_VISUALIZER,
    CITP_KIND_UNKNOWN,
  ];

  static final $core.Map<$core.int, CitpConnection_CitpKind> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CitpConnection_CitpKind? valueOf($core.int value) => _byValue[value];

  const CitpConnection_CitpKind._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
