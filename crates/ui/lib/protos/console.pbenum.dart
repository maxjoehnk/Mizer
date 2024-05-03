//
//  Generated code. Do not modify.
//  source: console.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ConsoleLevel extends $pb.ProtobufEnum {
  static const ConsoleLevel ERROR = ConsoleLevel._(0, _omitEnumNames ? '' : 'ERROR');
  static const ConsoleLevel WARNING = ConsoleLevel._(1, _omitEnumNames ? '' : 'WARNING');
  static const ConsoleLevel INFO = ConsoleLevel._(2, _omitEnumNames ? '' : 'INFO');
  static const ConsoleLevel DEBUG = ConsoleLevel._(3, _omitEnumNames ? '' : 'DEBUG');

  static const $core.List<ConsoleLevel> values = <ConsoleLevel> [
    ERROR,
    WARNING,
    INFO,
    DEBUG,
  ];

  static final $core.Map<$core.int, ConsoleLevel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ConsoleLevel? valueOf($core.int value) => _byValue[value];

  const ConsoleLevel._($core.int v, $core.String n) : super(v, n);
}

class ConsoleCategory extends $pb.ProtobufEnum {
  static const ConsoleCategory CONNECTIONS = ConsoleCategory._(0, _omitEnumNames ? '' : 'CONNECTIONS');
  static const ConsoleCategory MEDIA = ConsoleCategory._(1, _omitEnumNames ? '' : 'MEDIA');
  static const ConsoleCategory PROJECTS = ConsoleCategory._(2, _omitEnumNames ? '' : 'PROJECTS');
  static const ConsoleCategory COMMANDS = ConsoleCategory._(3, _omitEnumNames ? '' : 'COMMANDS');
  static const ConsoleCategory NODES = ConsoleCategory._(4, _omitEnumNames ? '' : 'NODES');
  static const ConsoleCategory SCRIPTS = ConsoleCategory._(5, _omitEnumNames ? '' : 'SCRIPTS');

  static const $core.List<ConsoleCategory> values = <ConsoleCategory> [
    CONNECTIONS,
    MEDIA,
    PROJECTS,
    COMMANDS,
    NODES,
    SCRIPTS,
  ];

  static final $core.Map<$core.int, ConsoleCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ConsoleCategory? valueOf($core.int value) => _byValue[value];

  const ConsoleCategory._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
