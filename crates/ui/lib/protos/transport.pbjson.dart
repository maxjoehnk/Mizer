///
//  Generated code. Do not modify.
//  source: transport.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use transportStateDescriptor instead')
const TransportState$json = const {
  '1': 'TransportState',
  '2': const [
    const {'1': 'STOPPED', '2': 0},
    const {'1': 'PAUSED', '2': 1},
    const {'1': 'PLAYING', '2': 2},
  ],
};

/// Descriptor for `TransportState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transportStateDescriptor = $convert.base64Decode('Cg5UcmFuc3BvcnRTdGF0ZRILCgdTVE9QUEVEEAASCgoGUEFVU0VEEAESCwoHUExBWUlORxAC');
@$core.Deprecated('Use transportDescriptor instead')
const Transport$json = const {
  '1': 'Transport',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.mizer.transport.TransportState', '10': 'state'},
    const {'1': 'speed', '3': 2, '4': 1, '5': 1, '10': 'speed'},
    const {'1': 'timecode', '3': 3, '4': 1, '5': 11, '6': '.mizer.transport.Timecode', '10': 'timecode'},
  ],
};

/// Descriptor for `Transport`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transportDescriptor = $convert.base64Decode('CglUcmFuc3BvcnQSNQoFc3RhdGUYASABKA4yHy5taXplci50cmFuc3BvcnQuVHJhbnNwb3J0U3RhdGVSBXN0YXRlEhQKBXNwZWVkGAIgASgBUgVzcGVlZBI1Cgh0aW1lY29kZRgDIAEoCzIZLm1pemVyLnRyYW5zcG9ydC5UaW1lY29kZVIIdGltZWNvZGU=');
@$core.Deprecated('Use timecodeDescriptor instead')
const Timecode$json = const {
  '1': 'Timecode',
  '2': const [
    const {'1': 'frames', '3': 1, '4': 1, '5': 4, '10': 'frames'},
    const {'1': 'seconds', '3': 2, '4': 1, '5': 4, '10': 'seconds'},
    const {'1': 'minutes', '3': 3, '4': 1, '5': 4, '10': 'minutes'},
    const {'1': 'hours', '3': 4, '4': 1, '5': 4, '10': 'hours'},
  ],
};

/// Descriptor for `Timecode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timecodeDescriptor = $convert.base64Decode('CghUaW1lY29kZRIWCgZmcmFtZXMYASABKARSBmZyYW1lcxIYCgdzZWNvbmRzGAIgASgEUgdzZWNvbmRzEhgKB21pbnV0ZXMYAyABKARSB21pbnV0ZXMSFAoFaG91cnMYBCABKARSBWhvdXJz');
@$core.Deprecated('Use setTransportRequestDescriptor instead')
const SetTransportRequest$json = const {
  '1': 'SetTransportRequest',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.mizer.transport.TransportState', '10': 'state'},
  ],
};

/// Descriptor for `SetTransportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setTransportRequestDescriptor = $convert.base64Decode('ChNTZXRUcmFuc3BvcnRSZXF1ZXN0EjUKBXN0YXRlGAEgASgOMh8ubWl6ZXIudHJhbnNwb3J0LlRyYW5zcG9ydFN0YXRlUgVzdGF0ZQ==');
@$core.Deprecated('Use setBpmRequestDescriptor instead')
const SetBpmRequest$json = const {
  '1': 'SetBpmRequest',
  '2': const [
    const {'1': 'bpm', '3': 1, '4': 1, '5': 1, '10': 'bpm'},
  ],
};

/// Descriptor for `SetBpmRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setBpmRequestDescriptor = $convert.base64Decode('Cg1TZXRCcG1SZXF1ZXN0EhAKA2JwbRgBIAEoAVIDYnBt');
