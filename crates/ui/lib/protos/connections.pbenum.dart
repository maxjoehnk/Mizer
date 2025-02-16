///
//  Generated code. Do not modify.
//  source: connections.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CdjPlayback_State extends $pb.ProtobufEnum {
  static const CdjPlayback_State LOADING = CdjPlayback_State._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LOADING');
  static const CdjPlayback_State PLAYING = CdjPlayback_State._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PLAYING');
  static const CdjPlayback_State CUED = CdjPlayback_State._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUED');
  static const CdjPlayback_State CUEING = CdjPlayback_State._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUEING');

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
  static const CitpConnection_CitpKind CITP_KIND_LIGHTING_CONSOLE = CitpConnection_CitpKind._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CITP_KIND_LIGHTING_CONSOLE');
  static const CitpConnection_CitpKind CITP_KIND_MEDIA_SERVER = CitpConnection_CitpKind._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CITP_KIND_MEDIA_SERVER');
  static const CitpConnection_CitpKind CITP_KIND_VISUALIZER = CitpConnection_CitpKind._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CITP_KIND_VISUALIZER');
  static const CitpConnection_CitpKind CITP_KIND_UNKNOWN = CitpConnection_CitpKind._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CITP_KIND_UNKNOWN');

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

