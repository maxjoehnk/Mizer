///
//  Generated code. Do not modify.
//  source: session.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class LoadProjectResult_State extends $pb.ProtobufEnum {
  static const LoadProjectResult_State OK = LoadProjectResult_State._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OK');
  static const LoadProjectResult_State MISSING_FILE = LoadProjectResult_State._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MISSING_FILE');
  static const LoadProjectResult_State INVALID_FILE = LoadProjectResult_State._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INVALID_FILE');
  static const LoadProjectResult_State UNSUPPORTED_FILE_TYPE = LoadProjectResult_State._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNSUPPORTED_FILE_TYPE');
  static const LoadProjectResult_State MIGRATION_ISSUE = LoadProjectResult_State._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MIGRATION_ISSUE');
  static const LoadProjectResult_State UNKNOWN = LoadProjectResult_State._(255, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');

  static const $core.List<LoadProjectResult_State> values = <LoadProjectResult_State> [
    OK,
    MISSING_FILE,
    INVALID_FILE,
    UNSUPPORTED_FILE_TYPE,
    MIGRATION_ISSUE,
    UNKNOWN,
  ];

  static final $core.Map<$core.int, LoadProjectResult_State> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LoadProjectResult_State? valueOf($core.int value) => _byValue[value];

  const LoadProjectResult_State._($core.int v, $core.String n) : super(v, n);
}

