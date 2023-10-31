//
//  Generated code. Do not modify.
//  source: transport.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use transportStateDescriptor instead')
const TransportState$json = {
  '1': 'TransportState',
  '2': [
    {'1': 'STOPPED', '2': 0},
    {'1': 'PAUSED', '2': 1},
    {'1': 'PLAYING', '2': 2},
  ],
};

/// Descriptor for `TransportState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transportStateDescriptor = $convert.base64Decode(
    'Cg5UcmFuc3BvcnRTdGF0ZRILCgdTVE9QUEVEEAASCgoGUEFVU0VEEAESCwoHUExBWUlORxAC');

@$core.Deprecated('Use transportDescriptor instead')
const Transport$json = {
  '1': 'Transport',
  '2': [
    {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.mizer.transport.TransportState', '10': 'state'},
    {'1': 'speed', '3': 2, '4': 1, '5': 1, '10': 'speed'},
    {'1': 'timecode', '3': 3, '4': 1, '5': 11, '6': '.mizer.transport.Timecode', '10': 'timecode'},
    {'1': 'fps', '3': 4, '4': 1, '5': 1, '10': 'fps'},
  ],
};

/// Descriptor for `Transport`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transportDescriptor = $convert.base64Decode(
    'CglUcmFuc3BvcnQSNQoFc3RhdGUYASABKA4yHy5taXplci50cmFuc3BvcnQuVHJhbnNwb3J0U3'
    'RhdGVSBXN0YXRlEhQKBXNwZWVkGAIgASgBUgVzcGVlZBI1Cgh0aW1lY29kZRgDIAEoCzIZLm1p'
    'emVyLnRyYW5zcG9ydC5UaW1lY29kZVIIdGltZWNvZGUSEAoDZnBzGAQgASgBUgNmcHM=');

@$core.Deprecated('Use timecodeDescriptor instead')
const Timecode$json = {
  '1': 'Timecode',
  '2': [
    {'1': 'frames', '3': 1, '4': 1, '5': 4, '10': 'frames'},
    {'1': 'seconds', '3': 2, '4': 1, '5': 4, '10': 'seconds'},
    {'1': 'minutes', '3': 3, '4': 1, '5': 4, '10': 'minutes'},
    {'1': 'hours', '3': 4, '4': 1, '5': 4, '10': 'hours'},
  ],
};

/// Descriptor for `Timecode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timecodeDescriptor = $convert.base64Decode(
    'CghUaW1lY29kZRIWCgZmcmFtZXMYASABKARSBmZyYW1lcxIYCgdzZWNvbmRzGAIgASgEUgdzZW'
    'NvbmRzEhgKB21pbnV0ZXMYAyABKARSB21pbnV0ZXMSFAoFaG91cnMYBCABKARSBWhvdXJz');

@$core.Deprecated('Use setTransportRequestDescriptor instead')
const SetTransportRequest$json = {
  '1': 'SetTransportRequest',
  '2': [
    {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.mizer.transport.TransportState', '10': 'state'},
  ],
};

/// Descriptor for `SetTransportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setTransportRequestDescriptor = $convert.base64Decode(
    'ChNTZXRUcmFuc3BvcnRSZXF1ZXN0EjUKBXN0YXRlGAEgASgOMh8ubWl6ZXIudHJhbnNwb3J0Ll'
    'RyYW5zcG9ydFN0YXRlUgVzdGF0ZQ==');

@$core.Deprecated('Use setBpmRequestDescriptor instead')
const SetBpmRequest$json = {
  '1': 'SetBpmRequest',
  '2': [
    {'1': 'bpm', '3': 1, '4': 1, '5': 1, '10': 'bpm'},
  ],
};

/// Descriptor for `SetBpmRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setBpmRequestDescriptor = $convert.base64Decode(
    'Cg1TZXRCcG1SZXF1ZXN0EhAKA2JwbRgBIAEoAVIDYnBt');

