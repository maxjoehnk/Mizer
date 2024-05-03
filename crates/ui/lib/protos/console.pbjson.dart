//
//  Generated code. Do not modify.
//  source: console.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use consoleLevelDescriptor instead')
const ConsoleLevel$json = {
  '1': 'ConsoleLevel',
  '2': [
    {'1': 'ERROR', '2': 0},
    {'1': 'WARNING', '2': 1},
    {'1': 'INFO', '2': 2},
    {'1': 'DEBUG', '2': 3},
  ],
};

/// Descriptor for `ConsoleLevel`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List consoleLevelDescriptor = $convert.base64Decode(
    'CgxDb25zb2xlTGV2ZWwSCQoFRVJST1IQABILCgdXQVJOSU5HEAESCAoESU5GTxACEgkKBURFQl'
    'VHEAM=');

@$core.Deprecated('Use consoleCategoryDescriptor instead')
const ConsoleCategory$json = {
  '1': 'ConsoleCategory',
  '2': [
    {'1': 'CONNECTIONS', '2': 0},
    {'1': 'MEDIA', '2': 1},
    {'1': 'PROJECTS', '2': 2},
    {'1': 'COMMANDS', '2': 3},
    {'1': 'NODES', '2': 4},
    {'1': 'SCRIPTS', '2': 5},
  ],
};

/// Descriptor for `ConsoleCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List consoleCategoryDescriptor = $convert.base64Decode(
    'Cg9Db25zb2xlQ2F0ZWdvcnkSDwoLQ09OTkVDVElPTlMQABIJCgVNRURJQRABEgwKCFBST0pFQ1'
    'RTEAISDAoIQ09NTUFORFMQAxIJCgVOT0RFUxAEEgsKB1NDUklQVFMQBQ==');

@$core.Deprecated('Use consoleHistoryDescriptor instead')
const ConsoleHistory$json = {
  '1': 'ConsoleHistory',
  '2': [
    {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.mizer.console.ConsoleMessage', '10': 'messages'},
  ],
};

/// Descriptor for `ConsoleHistory`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List consoleHistoryDescriptor = $convert.base64Decode(
    'Cg5Db25zb2xlSGlzdG9yeRI5CghtZXNzYWdlcxgBIAMoCzIdLm1pemVyLmNvbnNvbGUuQ29uc2'
    '9sZU1lc3NhZ2VSCG1lc3NhZ2Vz');

@$core.Deprecated('Use consoleMessageDescriptor instead')
const ConsoleMessage$json = {
  '1': 'ConsoleMessage',
  '2': [
    {'1': 'level', '3': 1, '4': 1, '5': 14, '6': '.mizer.console.ConsoleLevel', '10': 'level'},
    {'1': 'category', '3': 2, '4': 1, '5': 14, '6': '.mizer.console.ConsoleCategory', '10': 'category'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 4, '10': 'timestamp'},
  ],
};

/// Descriptor for `ConsoleMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List consoleMessageDescriptor = $convert.base64Decode(
    'Cg5Db25zb2xlTWVzc2FnZRIxCgVsZXZlbBgBIAEoDjIbLm1pemVyLmNvbnNvbGUuQ29uc29sZU'
    'xldmVsUgVsZXZlbBI6CghjYXRlZ29yeRgCIAEoDjIeLm1pemVyLmNvbnNvbGUuQ29uc29sZUNh'
    'dGVnb3J5UghjYXRlZ29yeRIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlEhwKCXRpbWVzdGFtcB'
    'gEIAEoBFIJdGltZXN0YW1w');

