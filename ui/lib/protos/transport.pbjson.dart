///
//  Generated code. Do not modify.
//  source: transport.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use transportStateDescriptor instead')
const TransportState$json = const {
  '1': 'TransportState',
  '2': const [
    const {'1': 'Stopped', '2': 0},
    const {'1': 'Paused', '2': 1},
    const {'1': 'Playing', '2': 2},
  ],
};

/// Descriptor for `TransportState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transportStateDescriptor = $convert.base64Decode('Cg5UcmFuc3BvcnRTdGF0ZRILCgdTdG9wcGVkEAASCgoGUGF1c2VkEAESCwoHUGxheWluZxAC');
@$core.Deprecated('Use subscribeTransportRequestDescriptor instead')
const SubscribeTransportRequest$json = const {
  '1': 'SubscribeTransportRequest',
};

/// Descriptor for `SubscribeTransportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeTransportRequestDescriptor = $convert.base64Decode('ChlTdWJzY3JpYmVUcmFuc3BvcnRSZXF1ZXN0');
@$core.Deprecated('Use transportDescriptor instead')
const Transport$json = const {
  '1': 'Transport',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.mizer.TransportState', '10': 'state'},
    const {'1': 'speed', '3': 2, '4': 1, '5': 1, '10': 'speed'},
    const {'1': 'timecode', '3': 3, '4': 1, '5': 11, '6': '.mizer.Timecode', '10': 'timecode'},
  ],
};

/// Descriptor for `Transport`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transportDescriptor = $convert.base64Decode('CglUcmFuc3BvcnQSKwoFc3RhdGUYASABKA4yFS5taXplci5UcmFuc3BvcnRTdGF0ZVIFc3RhdGUSFAoFc3BlZWQYAiABKAFSBXNwZWVkEisKCHRpbWVjb2RlGAMgASgLMg8ubWl6ZXIuVGltZWNvZGVSCHRpbWVjb2Rl');
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
    const {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.mizer.TransportState', '10': 'state'},
  ],
};

/// Descriptor for `SetTransportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setTransportRequestDescriptor = $convert.base64Decode('ChNTZXRUcmFuc3BvcnRSZXF1ZXN0EisKBXN0YXRlGAEgASgOMhUubWl6ZXIuVHJhbnNwb3J0U3RhdGVSBXN0YXRl');
@$core.Deprecated('Use setBpmRequestDescriptor instead')
const SetBpmRequest$json = const {
  '1': 'SetBpmRequest',
  '2': const [
    const {'1': 'bpm', '3': 1, '4': 1, '5': 1, '10': 'bpm'},
  ],
};

/// Descriptor for `SetBpmRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setBpmRequestDescriptor = $convert.base64Decode('Cg1TZXRCcG1SZXF1ZXN0EhAKA2JwbRgBIAEoAVIDYnBt');
