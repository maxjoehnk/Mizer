///
//  Generated code. Do not modify.
//  source: session.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use projectRequestDescriptor instead')
const ProjectRequest$json = const {
  '1': 'ProjectRequest',
};

/// Descriptor for `ProjectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List projectRequestDescriptor = $convert.base64Decode('Cg5Qcm9qZWN0UmVxdWVzdA==');
@$core.Deprecated('Use loadProjectRequestDescriptor instead')
const LoadProjectRequest$json = const {
  '1': 'LoadProjectRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `LoadProjectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loadProjectRequestDescriptor = $convert.base64Decode('ChJMb2FkUHJvamVjdFJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aA==');
@$core.Deprecated('Use saveProjectAsRequestDescriptor instead')
const SaveProjectAsRequest$json = const {
  '1': 'SaveProjectAsRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `SaveProjectAsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveProjectAsRequestDescriptor = $convert.base64Decode('ChRTYXZlUHJvamVjdEFzUmVxdWVzdBISCgRwYXRoGAEgASgJUgRwYXRo');
@$core.Deprecated('Use projectResponseDescriptor instead')
const ProjectResponse$json = const {
  '1': 'ProjectResponse',
};

/// Descriptor for `ProjectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List projectResponseDescriptor = $convert.base64Decode('Cg9Qcm9qZWN0UmVzcG9uc2U=');
@$core.Deprecated('Use clientAnnouncementDescriptor instead')
const ClientAnnouncement$json = const {
  '1': 'ClientAnnouncement',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `ClientAnnouncement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientAnnouncementDescriptor = $convert.base64Decode('ChJDbGllbnRBbm5vdW5jZW1lbnQSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use sessionRequestDescriptor instead')
const SessionRequest$json = const {
  '1': 'SessionRequest',
};

/// Descriptor for `SessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionRequestDescriptor = $convert.base64Decode('Cg5TZXNzaW9uUmVxdWVzdA==');
@$core.Deprecated('Use sessionDescriptor instead')
const Session$json = const {
  '1': 'Session',
  '2': const [
    const {'1': 'filePath', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'filePath', '17': true},
    const {'1': 'devices', '3': 2, '4': 3, '5': 11, '6': '.mizer.SessionDevice', '10': 'devices'},
    const {'1': 'projectHistory', '3': 3, '4': 3, '5': 9, '10': 'projectHistory'},
  ],
  '8': const [
    const {'1': '_filePath'},
  ],
};

/// Descriptor for `Session`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDescriptor = $convert.base64Decode('CgdTZXNzaW9uEh8KCGZpbGVQYXRoGAEgASgJSABSCGZpbGVQYXRoiAEBEi4KB2RldmljZXMYAiADKAsyFC5taXplci5TZXNzaW9uRGV2aWNlUgdkZXZpY2VzEiYKDnByb2plY3RIaXN0b3J5GAMgAygJUg5wcm9qZWN0SGlzdG9yeUILCglfZmlsZVBhdGg=');
@$core.Deprecated('Use sessionDeviceDescriptor instead')
const SessionDevice$json = const {
  '1': 'SessionDevice',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'ips', '3': 2, '4': 3, '5': 9, '10': 'ips'},
    const {'1': 'clock', '3': 3, '4': 1, '5': 11, '6': '.mizer.DeviceClock', '10': 'clock'},
    const {'1': 'ping', '3': 4, '4': 1, '5': 1, '10': 'ping'},
  ],
};

/// Descriptor for `SessionDevice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDeviceDescriptor = $convert.base64Decode('Cg1TZXNzaW9uRGV2aWNlEhIKBG5hbWUYASABKAlSBG5hbWUSEAoDaXBzGAIgAygJUgNpcHMSKAoFY2xvY2sYAyABKAsyEi5taXplci5EZXZpY2VDbG9ja1IFY2xvY2sSEgoEcGluZxgEIAEoAVIEcGluZw==');
@$core.Deprecated('Use deviceClockDescriptor instead')
const DeviceClock$json = const {
  '1': 'DeviceClock',
  '2': const [
    const {'1': 'master', '3': 1, '4': 1, '5': 8, '10': 'master'},
    const {'1': 'drift', '3': 2, '4': 1, '5': 1, '10': 'drift'},
  ],
};

/// Descriptor for `DeviceClock`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceClockDescriptor = $convert.base64Decode('CgtEZXZpY2VDbG9jaxIWCgZtYXN0ZXIYASABKAhSBm1hc3RlchIUCgVkcmlmdBgCIAEoAVIFZHJpZnQ=');
@$core.Deprecated('Use loadHistoryRequestDescriptor instead')
const LoadHistoryRequest$json = const {
  '1': 'LoadHistoryRequest',
};

/// Descriptor for `LoadHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loadHistoryRequestDescriptor = $convert.base64Decode('ChJMb2FkSGlzdG9yeVJlcXVlc3Q=');
@$core.Deprecated('Use historyDescriptor instead')
const History$json = const {
  '1': 'History',
  '2': const [
    const {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.mizer.HistoryItem', '10': 'items'},
    const {'1': 'pointer', '3': 2, '4': 1, '5': 4, '10': 'pointer'},
  ],
};

/// Descriptor for `History`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyDescriptor = $convert.base64Decode('CgdIaXN0b3J5EigKBWl0ZW1zGAEgAygLMhIubWl6ZXIuSGlzdG9yeUl0ZW1SBWl0ZW1zEhgKB3BvaW50ZXIYAiABKARSB3BvaW50ZXI=');
@$core.Deprecated('Use historyItemDescriptor instead')
const HistoryItem$json = const {
  '1': 'HistoryItem',
  '2': const [
    const {'1': 'label', '3': 1, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'timestamp', '3': 2, '4': 1, '5': 4, '10': 'timestamp'},
  ],
};

/// Descriptor for `HistoryItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyItemDescriptor = $convert.base64Decode('CgtIaXN0b3J5SXRlbRIUCgVsYWJlbBgBIAEoCVIFbGFiZWwSHAoJdGltZXN0YW1wGAIgASgEUgl0aW1lc3RhbXA=');
