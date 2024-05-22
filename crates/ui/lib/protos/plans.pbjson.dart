//
//  Generated code. Do not modify.
//  source: plans.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use addPlanRequestDescriptor instead')
const AddPlanRequest$json = {
  '1': 'AddPlanRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AddPlanRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addPlanRequestDescriptor = $convert.base64Decode(
    'Cg5BZGRQbGFuUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');

@$core.Deprecated('Use removePlanRequestDescriptor instead')
const RemovePlanRequest$json = {
  '1': 'RemovePlanRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `RemovePlanRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removePlanRequestDescriptor = $convert.base64Decode(
    'ChFSZW1vdmVQbGFuUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use renamePlanRequestDescriptor instead')
const RenamePlanRequest$json = {
  '1': 'RenamePlanRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `RenamePlanRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renamePlanRequestDescriptor = $convert.base64Decode(
    'ChFSZW5hbWVQbGFuUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ'
    '==');

@$core.Deprecated('Use moveFixturesRequestDescriptor instead')
const MoveFixturesRequest$json = {
  '1': 'MoveFixturesRequest',
  '2': [
    {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'x', '3': 2, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 3, '4': 1, '5': 1, '10': 'y'},
  ],
};

/// Descriptor for `MoveFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveFixturesRequestDescriptor = $convert.base64Decode(
    'ChNNb3ZlRml4dHVyZXNSZXF1ZXN0EhcKB3BsYW5faWQYASABKAlSBnBsYW5JZBIMCgF4GAIgAS'
    'gBUgF4EgwKAXkYAyABKAFSAXk=');

@$core.Deprecated('Use alignFixturesRequestDescriptor instead')
const AlignFixturesRequest$json = {
  '1': 'AlignFixturesRequest',
  '2': [
    {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'direction', '3': 2, '4': 1, '5': 14, '6': '.mizer.plans.AlignFixturesRequest.AlignDirection', '10': 'direction'},
    {'1': 'groups', '3': 3, '4': 1, '5': 13, '10': 'groups'},
    {'1': 'row_gap', '3': 4, '4': 1, '5': 13, '10': 'rowGap'},
    {'1': 'column_gap', '3': 5, '4': 1, '5': 13, '10': 'columnGap'},
  ],
  '4': [AlignFixturesRequest_AlignDirection$json],
};

@$core.Deprecated('Use alignFixturesRequestDescriptor instead')
const AlignFixturesRequest_AlignDirection$json = {
  '1': 'AlignDirection',
  '2': [
    {'1': 'LEFT_TO_RIGHT', '2': 0},
    {'1': 'TOP_TO_BOTTOM', '2': 1},
  ],
};

/// Descriptor for `AlignFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List alignFixturesRequestDescriptor = $convert.base64Decode(
    'ChRBbGlnbkZpeHR1cmVzUmVxdWVzdBIXCgdwbGFuX2lkGAEgASgJUgZwbGFuSWQSTgoJZGlyZW'
    'N0aW9uGAIgASgOMjAubWl6ZXIucGxhbnMuQWxpZ25GaXh0dXJlc1JlcXVlc3QuQWxpZ25EaXJl'
    'Y3Rpb25SCWRpcmVjdGlvbhIWCgZncm91cHMYAyABKA1SBmdyb3VwcxIXCgdyb3dfZ2FwGAQgAS'
    'gNUgZyb3dHYXASHQoKY29sdW1uX2dhcBgFIAEoDVIJY29sdW1uR2FwIjYKDkFsaWduRGlyZWN0'
    'aW9uEhEKDUxFRlRfVE9fUklHSFQQABIRCg1UT1BfVE9fQk9UVE9NEAE=');

@$core.Deprecated('Use spreadFixturesRequestDescriptor instead')
const SpreadFixturesRequest$json = {
  '1': 'SpreadFixturesRequest',
  '2': [
    {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'geometry', '3': 2, '4': 1, '5': 14, '6': '.mizer.plans.SpreadFixturesRequest.SpreadGeometry', '10': 'geometry'},
  ],
  '4': [SpreadFixturesRequest_SpreadGeometry$json],
};

@$core.Deprecated('Use spreadFixturesRequestDescriptor instead')
const SpreadFixturesRequest_SpreadGeometry$json = {
  '1': 'SpreadGeometry',
  '2': [
    {'1': 'SQUARE', '2': 0},
    {'1': 'TRIANGLE', '2': 1},
  ],
};

/// Descriptor for `SpreadFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spreadFixturesRequestDescriptor = $convert.base64Decode(
    'ChVTcHJlYWRGaXh0dXJlc1JlcXVlc3QSFwoHcGxhbl9pZBgBIAEoCVIGcGxhbklkEk0KCGdlb2'
    '1ldHJ5GAIgASgOMjEubWl6ZXIucGxhbnMuU3ByZWFkRml4dHVyZXNSZXF1ZXN0LlNwcmVhZEdl'
    'b21ldHJ5UghnZW9tZXRyeSIqCg5TcHJlYWRHZW9tZXRyeRIKCgZTUVVBUkUQABIMCghUUklBTk'
    'dMRRAB');

@$core.Deprecated('Use moveFixtureRequestDescriptor instead')
const MoveFixtureRequest$json = {
  '1': 'MoveFixtureRequest',
  '2': [
    {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'fixture_id', '3': 2, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtureId'},
    {'1': 'x', '3': 3, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 4, '4': 1, '5': 1, '10': 'y'},
  ],
};

/// Descriptor for `MoveFixtureRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveFixtureRequestDescriptor = $convert.base64Decode(
    'ChJNb3ZlRml4dHVyZVJlcXVlc3QSFwoHcGxhbl9pZBgBIAEoCVIGcGxhbklkEjgKCmZpeHR1cm'
    'VfaWQYAiABKAsyGS5taXplci5maXh0dXJlcy5GaXh0dXJlSWRSCWZpeHR1cmVJZBIMCgF4GAMg'
    'ASgBUgF4EgwKAXkYBCABKAFSAXk=');

@$core.Deprecated('Use addImageRequestDescriptor instead')
const AddImageRequest$json = {
  '1': 'AddImageRequest',
  '2': [
    {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'x', '3': 2, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 3, '4': 1, '5': 1, '10': 'y'},
    {'1': 'width', '3': 4, '4': 1, '5': 1, '10': 'width'},
    {'1': 'height', '3': 5, '4': 1, '5': 1, '10': 'height'},
    {'1': 'transparency', '3': 6, '4': 1, '5': 1, '10': 'transparency'},
    {'1': 'data', '3': 7, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `AddImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addImageRequestDescriptor = $convert.base64Decode(
    'Cg9BZGRJbWFnZVJlcXVlc3QSFwoHcGxhbl9pZBgBIAEoCVIGcGxhbklkEgwKAXgYAiABKAFSAX'
    'gSDAoBeRgDIAEoAVIBeRIUCgV3aWR0aBgEIAEoAVIFd2lkdGgSFgoGaGVpZ2h0GAUgASgBUgZo'
    'ZWlnaHQSIgoMdHJhbnNwYXJlbmN5GAYgASgBUgx0cmFuc3BhcmVuY3kSEgoEZGF0YRgHIAEoDF'
    'IEZGF0YQ==');

@$core.Deprecated('Use moveImageRequestDescriptor instead')
const MoveImageRequest$json = {
  '1': 'MoveImageRequest',
  '2': [
    {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'image_id', '3': 2, '4': 1, '5': 9, '10': 'imageId'},
    {'1': 'x', '3': 3, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 4, '4': 1, '5': 1, '10': 'y'},
  ],
};

/// Descriptor for `MoveImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveImageRequestDescriptor = $convert.base64Decode(
    'ChBNb3ZlSW1hZ2VSZXF1ZXN0EhcKB3BsYW5faWQYASABKAlSBnBsYW5JZBIZCghpbWFnZV9pZB'
    'gCIAEoCVIHaW1hZ2VJZBIMCgF4GAMgASgBUgF4EgwKAXkYBCABKAFSAXk=');

@$core.Deprecated('Use resizeImageRequestDescriptor instead')
const ResizeImageRequest$json = {
  '1': 'ResizeImageRequest',
  '2': [
    {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'image_id', '3': 2, '4': 1, '5': 9, '10': 'imageId'},
    {'1': 'width', '3': 3, '4': 1, '5': 1, '10': 'width'},
    {'1': 'height', '3': 4, '4': 1, '5': 1, '10': 'height'},
  ],
};

/// Descriptor for `ResizeImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resizeImageRequestDescriptor = $convert.base64Decode(
    'ChJSZXNpemVJbWFnZVJlcXVlc3QSFwoHcGxhbl9pZBgBIAEoCVIGcGxhbklkEhkKCGltYWdlX2'
    'lkGAIgASgJUgdpbWFnZUlkEhQKBXdpZHRoGAMgASgBUgV3aWR0aBIWCgZoZWlnaHQYBCABKAFS'
    'BmhlaWdodA==');

@$core.Deprecated('Use removeImageRequestDescriptor instead')
const RemoveImageRequest$json = {
  '1': 'RemoveImageRequest',
  '2': [
    {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'image_id', '3': 2, '4': 1, '5': 9, '10': 'imageId'},
  ],
};

/// Descriptor for `RemoveImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeImageRequestDescriptor = $convert.base64Decode(
    'ChJSZW1vdmVJbWFnZVJlcXVlc3QSFwoHcGxhbl9pZBgBIAEoCVIGcGxhbklkEhkKCGltYWdlX2'
    'lkGAIgASgJUgdpbWFnZUlk');

@$core.Deprecated('Use addScreenRequestDescriptor instead')
const AddScreenRequest$json = {
  '1': 'AddScreenRequest',
  '2': [
    {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'x', '3': 2, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 3, '4': 1, '5': 1, '10': 'y'},
    {'1': 'width', '3': 4, '4': 1, '5': 1, '10': 'width'},
    {'1': 'height', '3': 5, '4': 1, '5': 1, '10': 'height'},
  ],
};

/// Descriptor for `AddScreenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addScreenRequestDescriptor = $convert.base64Decode(
    'ChBBZGRTY3JlZW5SZXF1ZXN0EhcKB3BsYW5faWQYASABKAlSBnBsYW5JZBIMCgF4GAIgASgBUg'
    'F4EgwKAXkYAyABKAFSAXkSFAoFd2lkdGgYBCABKAFSBXdpZHRoEhYKBmhlaWdodBgFIAEoAVIG'
    'aGVpZ2h0');

@$core.Deprecated('Use plansDescriptor instead')
const Plans$json = {
  '1': 'Plans',
  '2': [
    {'1': 'plans', '3': 1, '4': 3, '5': 11, '6': '.mizer.plans.Plan', '10': 'plans'},
  ],
};

/// Descriptor for `Plans`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List plansDescriptor = $convert.base64Decode(
    'CgVQbGFucxInCgVwbGFucxgBIAMoCzIRLm1pemVyLnBsYW5zLlBsYW5SBXBsYW5z');

@$core.Deprecated('Use planDescriptor instead')
const Plan$json = {
  '1': 'Plan',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'positions', '3': 2, '4': 3, '5': 11, '6': '.mizer.plans.FixturePosition', '10': 'positions'},
    {'1': 'screens', '3': 3, '4': 3, '5': 11, '6': '.mizer.plans.PlanScreen', '10': 'screens'},
    {'1': 'images', '3': 4, '4': 3, '5': 11, '6': '.mizer.plans.PlanImage', '10': 'images'},
  ],
};

/// Descriptor for `Plan`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planDescriptor = $convert.base64Decode(
    'CgRQbGFuEhIKBG5hbWUYASABKAlSBG5hbWUSOgoJcG9zaXRpb25zGAIgAygLMhwubWl6ZXIucG'
    'xhbnMuRml4dHVyZVBvc2l0aW9uUglwb3NpdGlvbnMSMQoHc2NyZWVucxgDIAMoCzIXLm1pemVy'
    'LnBsYW5zLlBsYW5TY3JlZW5SB3NjcmVlbnMSLgoGaW1hZ2VzGAQgAygLMhYubWl6ZXIucGxhbn'
    'MuUGxhbkltYWdlUgZpbWFnZXM=');

@$core.Deprecated('Use fixturePositionDescriptor instead')
const FixturePosition$json = {
  '1': 'FixturePosition',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'id'},
    {'1': 'x', '3': 2, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 3, '4': 1, '5': 1, '10': 'y'},
    {'1': 'width', '3': 4, '4': 1, '5': 1, '10': 'width'},
    {'1': 'height', '3': 5, '4': 1, '5': 1, '10': 'height'},
  ],
};

/// Descriptor for `FixturePosition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixturePositionDescriptor = $convert.base64Decode(
    'Cg9GaXh0dXJlUG9zaXRpb24SKQoCaWQYASABKAsyGS5taXplci5maXh0dXJlcy5GaXh0dXJlSW'
    'RSAmlkEgwKAXgYAiABKAFSAXgSDAoBeRgDIAEoAVIBeRIUCgV3aWR0aBgEIAEoAVIFd2lkdGgS'
    'FgoGaGVpZ2h0GAUgASgBUgZoZWlnaHQ=');

@$core.Deprecated('Use planScreenDescriptor instead')
const PlanScreen$json = {
  '1': 'PlanScreen',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'x', '3': 2, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 3, '4': 1, '5': 1, '10': 'y'},
    {'1': 'width', '3': 4, '4': 1, '5': 1, '10': 'width'},
    {'1': 'height', '3': 5, '4': 1, '5': 1, '10': 'height'},
  ],
};

/// Descriptor for `PlanScreen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planScreenDescriptor = $convert.base64Decode(
    'CgpQbGFuU2NyZWVuEg4KAmlkGAEgASgNUgJpZBIMCgF4GAIgASgBUgF4EgwKAXkYAyABKAFSAX'
    'kSFAoFd2lkdGgYBCABKAFSBXdpZHRoEhYKBmhlaWdodBgFIAEoAVIGaGVpZ2h0');

@$core.Deprecated('Use planImageDescriptor instead')
const PlanImage$json = {
  '1': 'PlanImage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'x', '3': 2, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 3, '4': 1, '5': 1, '10': 'y'},
    {'1': 'width', '3': 4, '4': 1, '5': 1, '10': 'width'},
    {'1': 'height', '3': 5, '4': 1, '5': 1, '10': 'height'},
    {'1': 'transparency', '3': 6, '4': 1, '5': 1, '10': 'transparency'},
    {'1': 'data', '3': 7, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `PlanImage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planImageDescriptor = $convert.base64Decode(
    'CglQbGFuSW1hZ2USDgoCaWQYASABKAlSAmlkEgwKAXgYAiABKAFSAXgSDAoBeRgDIAEoAVIBeR'
    'IUCgV3aWR0aBgEIAEoAVIFd2lkdGgSFgoGaGVpZ2h0GAUgASgBUgZoZWlnaHQSIgoMdHJhbnNw'
    'YXJlbmN5GAYgASgBUgx0cmFuc3BhcmVuY3kSEgoEZGF0YRgHIAEoDFIEZGF0YQ==');

