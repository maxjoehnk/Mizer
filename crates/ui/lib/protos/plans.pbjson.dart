///
//  Generated code. Do not modify.
//  source: plans.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use addPlanRequestDescriptor instead')
const AddPlanRequest$json = const {
  '1': 'AddPlanRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AddPlanRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addPlanRequestDescriptor = $convert.base64Decode('Cg5BZGRQbGFuUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');
@$core.Deprecated('Use removePlanRequestDescriptor instead')
const RemovePlanRequest$json = const {
  '1': 'RemovePlanRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `RemovePlanRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removePlanRequestDescriptor = $convert.base64Decode('ChFSZW1vdmVQbGFuUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use renamePlanRequestDescriptor instead')
const RenamePlanRequest$json = const {
  '1': 'RenamePlanRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `RenamePlanRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renamePlanRequestDescriptor = $convert.base64Decode('ChFSZW5hbWVQbGFuUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use moveFixturesRequestDescriptor instead')
const MoveFixturesRequest$json = const {
  '1': 'MoveFixturesRequest',
  '2': const [
    const {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    const {'1': 'x', '3': 2, '4': 1, '5': 5, '10': 'x'},
    const {'1': 'y', '3': 3, '4': 1, '5': 5, '10': 'y'},
  ],
};

/// Descriptor for `MoveFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveFixturesRequestDescriptor = $convert.base64Decode('ChNNb3ZlRml4dHVyZXNSZXF1ZXN0EhcKB3BsYW5faWQYASABKAlSBnBsYW5JZBIMCgF4GAIgASgFUgF4EgwKAXkYAyABKAVSAXk=');
@$core.Deprecated('Use alignFixturesRequestDescriptor instead')
const AlignFixturesRequest$json = const {
  '1': 'AlignFixturesRequest',
  '2': const [
    const {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    const {'1': 'direction', '3': 2, '4': 1, '5': 14, '6': '.mizer.plans.AlignFixturesRequest.AlignDirection', '10': 'direction'},
    const {'1': 'groups', '3': 3, '4': 1, '5': 13, '10': 'groups'},
    const {'1': 'row_gap', '3': 4, '4': 1, '5': 13, '10': 'rowGap'},
    const {'1': 'column_gap', '3': 5, '4': 1, '5': 13, '10': 'columnGap'},
  ],
  '4': const [AlignFixturesRequest_AlignDirection$json],
};

@$core.Deprecated('Use alignFixturesRequestDescriptor instead')
const AlignFixturesRequest_AlignDirection$json = const {
  '1': 'AlignDirection',
  '2': const [
    const {'1': 'LEFT_TO_RIGHT', '2': 0},
    const {'1': 'TOP_TO_BOTTOM', '2': 1},
  ],
};

/// Descriptor for `AlignFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List alignFixturesRequestDescriptor = $convert.base64Decode('ChRBbGlnbkZpeHR1cmVzUmVxdWVzdBIXCgdwbGFuX2lkGAEgASgJUgZwbGFuSWQSTgoJZGlyZWN0aW9uGAIgASgOMjAubWl6ZXIucGxhbnMuQWxpZ25GaXh0dXJlc1JlcXVlc3QuQWxpZ25EaXJlY3Rpb25SCWRpcmVjdGlvbhIWCgZncm91cHMYAyABKA1SBmdyb3VwcxIXCgdyb3dfZ2FwGAQgASgNUgZyb3dHYXASHQoKY29sdW1uX2dhcBgFIAEoDVIJY29sdW1uR2FwIjYKDkFsaWduRGlyZWN0aW9uEhEKDUxFRlRfVE9fUklHSFQQABIRCg1UT1BfVE9fQk9UVE9NEAE=');
@$core.Deprecated('Use moveFixtureRequestDescriptor instead')
const MoveFixtureRequest$json = const {
  '1': 'MoveFixtureRequest',
  '2': const [
    const {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    const {'1': 'fixture_id', '3': 2, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtureId'},
    const {'1': 'x', '3': 3, '4': 1, '5': 5, '10': 'x'},
    const {'1': 'y', '3': 4, '4': 1, '5': 5, '10': 'y'},
  ],
};

/// Descriptor for `MoveFixtureRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveFixtureRequestDescriptor = $convert.base64Decode('ChJNb3ZlRml4dHVyZVJlcXVlc3QSFwoHcGxhbl9pZBgBIAEoCVIGcGxhbklkEjgKCmZpeHR1cmVfaWQYAiABKAsyGS5taXplci5maXh0dXJlcy5GaXh0dXJlSWRSCWZpeHR1cmVJZBIMCgF4GAMgASgFUgF4EgwKAXkYBCABKAVSAXk=');
@$core.Deprecated('Use addImageRequestDescriptor instead')
const AddImageRequest$json = const {
  '1': 'AddImageRequest',
  '2': const [
    const {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    const {'1': 'x', '3': 2, '4': 1, '5': 1, '10': 'x'},
    const {'1': 'y', '3': 3, '4': 1, '5': 1, '10': 'y'},
    const {'1': 'width', '3': 4, '4': 1, '5': 1, '10': 'width'},
    const {'1': 'height', '3': 5, '4': 1, '5': 1, '10': 'height'},
    const {'1': 'transparency', '3': 6, '4': 1, '5': 1, '10': 'transparency'},
    const {'1': 'data', '3': 7, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `AddImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addImageRequestDescriptor = $convert.base64Decode('Cg9BZGRJbWFnZVJlcXVlc3QSFwoHcGxhbl9pZBgBIAEoCVIGcGxhbklkEgwKAXgYAiABKAFSAXgSDAoBeRgDIAEoAVIBeRIUCgV3aWR0aBgEIAEoAVIFd2lkdGgSFgoGaGVpZ2h0GAUgASgBUgZoZWlnaHQSIgoMdHJhbnNwYXJlbmN5GAYgASgBUgx0cmFuc3BhcmVuY3kSEgoEZGF0YRgHIAEoDFIEZGF0YQ==');
@$core.Deprecated('Use moveImageRequestDescriptor instead')
const MoveImageRequest$json = const {
  '1': 'MoveImageRequest',
  '2': const [
    const {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    const {'1': 'image_id', '3': 2, '4': 1, '5': 9, '10': 'imageId'},
    const {'1': 'x', '3': 3, '4': 1, '5': 1, '10': 'x'},
    const {'1': 'y', '3': 4, '4': 1, '5': 1, '10': 'y'},
  ],
};

/// Descriptor for `MoveImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveImageRequestDescriptor = $convert.base64Decode('ChBNb3ZlSW1hZ2VSZXF1ZXN0EhcKB3BsYW5faWQYASABKAlSBnBsYW5JZBIZCghpbWFnZV9pZBgCIAEoCVIHaW1hZ2VJZBIMCgF4GAMgASgBUgF4EgwKAXkYBCABKAFSAXk=');
@$core.Deprecated('Use resizeImageRequestDescriptor instead')
const ResizeImageRequest$json = const {
  '1': 'ResizeImageRequest',
  '2': const [
    const {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    const {'1': 'image_id', '3': 2, '4': 1, '5': 9, '10': 'imageId'},
    const {'1': 'width', '3': 3, '4': 1, '5': 1, '10': 'width'},
    const {'1': 'height', '3': 4, '4': 1, '5': 1, '10': 'height'},
  ],
};

/// Descriptor for `ResizeImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resizeImageRequestDescriptor = $convert.base64Decode('ChJSZXNpemVJbWFnZVJlcXVlc3QSFwoHcGxhbl9pZBgBIAEoCVIGcGxhbklkEhkKCGltYWdlX2lkGAIgASgJUgdpbWFnZUlkEhQKBXdpZHRoGAMgASgBUgV3aWR0aBIWCgZoZWlnaHQYBCABKAFSBmhlaWdodA==');
@$core.Deprecated('Use removeImageRequestDescriptor instead')
const RemoveImageRequest$json = const {
  '1': 'RemoveImageRequest',
  '2': const [
    const {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    const {'1': 'image_id', '3': 2, '4': 1, '5': 9, '10': 'imageId'},
  ],
};

/// Descriptor for `RemoveImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeImageRequestDescriptor = $convert.base64Decode('ChJSZW1vdmVJbWFnZVJlcXVlc3QSFwoHcGxhbl9pZBgBIAEoCVIGcGxhbklkEhkKCGltYWdlX2lkGAIgASgJUgdpbWFnZUlk');
@$core.Deprecated('Use plansDescriptor instead')
const Plans$json = const {
  '1': 'Plans',
  '2': const [
    const {'1': 'plans', '3': 1, '4': 3, '5': 11, '6': '.mizer.plans.Plan', '10': 'plans'},
  ],
};

/// Descriptor for `Plans`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List plansDescriptor = $convert.base64Decode('CgVQbGFucxInCgVwbGFucxgBIAMoCzIRLm1pemVyLnBsYW5zLlBsYW5SBXBsYW5z');
@$core.Deprecated('Use planDescriptor instead')
const Plan$json = const {
  '1': 'Plan',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'positions', '3': 2, '4': 3, '5': 11, '6': '.mizer.plans.FixturePosition', '10': 'positions'},
    const {'1': 'screens', '3': 3, '4': 3, '5': 11, '6': '.mizer.plans.PlanScreen', '10': 'screens'},
    const {'1': 'images', '3': 4, '4': 3, '5': 11, '6': '.mizer.plans.PlanImage', '10': 'images'},
  ],
};

/// Descriptor for `Plan`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planDescriptor = $convert.base64Decode('CgRQbGFuEhIKBG5hbWUYASABKAlSBG5hbWUSOgoJcG9zaXRpb25zGAIgAygLMhwubWl6ZXIucGxhbnMuRml4dHVyZVBvc2l0aW9uUglwb3NpdGlvbnMSMQoHc2NyZWVucxgDIAMoCzIXLm1pemVyLnBsYW5zLlBsYW5TY3JlZW5SB3NjcmVlbnMSLgoGaW1hZ2VzGAQgAygLMhYubWl6ZXIucGxhbnMuUGxhbkltYWdlUgZpbWFnZXM=');
@$core.Deprecated('Use fixturePositionDescriptor instead')
const FixturePosition$json = const {
  '1': 'FixturePosition',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'id'},
    const {'1': 'x', '3': 2, '4': 1, '5': 5, '10': 'x'},
    const {'1': 'y', '3': 3, '4': 1, '5': 5, '10': 'y'},
    const {'1': 'width', '3': 4, '4': 1, '5': 13, '10': 'width'},
    const {'1': 'height', '3': 5, '4': 1, '5': 13, '10': 'height'},
  ],
};

/// Descriptor for `FixturePosition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixturePositionDescriptor = $convert.base64Decode('Cg9GaXh0dXJlUG9zaXRpb24SKQoCaWQYASABKAsyGS5taXplci5maXh0dXJlcy5GaXh0dXJlSWRSAmlkEgwKAXgYAiABKAVSAXgSDAoBeRgDIAEoBVIBeRIUCgV3aWR0aBgEIAEoDVIFd2lkdGgSFgoGaGVpZ2h0GAUgASgNUgZoZWlnaHQ=');
@$core.Deprecated('Use planScreenDescriptor instead')
const PlanScreen$json = const {
  '1': 'PlanScreen',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'x', '3': 2, '4': 1, '5': 5, '10': 'x'},
    const {'1': 'y', '3': 3, '4': 1, '5': 5, '10': 'y'},
    const {'1': 'width', '3': 4, '4': 1, '5': 13, '10': 'width'},
    const {'1': 'height', '3': 5, '4': 1, '5': 13, '10': 'height'},
  ],
};

/// Descriptor for `PlanScreen`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planScreenDescriptor = $convert.base64Decode('CgpQbGFuU2NyZWVuEg4KAmlkGAEgASgNUgJpZBIMCgF4GAIgASgFUgF4EgwKAXkYAyABKAVSAXkSFAoFd2lkdGgYBCABKA1SBXdpZHRoEhYKBmhlaWdodBgFIAEoDVIGaGVpZ2h0');
@$core.Deprecated('Use planImageDescriptor instead')
const PlanImage$json = const {
  '1': 'PlanImage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'x', '3': 2, '4': 1, '5': 1, '10': 'x'},
    const {'1': 'y', '3': 3, '4': 1, '5': 1, '10': 'y'},
    const {'1': 'width', '3': 4, '4': 1, '5': 1, '10': 'width'},
    const {'1': 'height', '3': 5, '4': 1, '5': 1, '10': 'height'},
    const {'1': 'transparency', '3': 6, '4': 1, '5': 1, '10': 'transparency'},
    const {'1': 'data', '3': 7, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `PlanImage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planImageDescriptor = $convert.base64Decode('CglQbGFuSW1hZ2USDgoCaWQYASABKAlSAmlkEgwKAXgYAiABKAFSAXgSDAoBeRgDIAEoAVIBeRIUCgV3aWR0aBgEIAEoAVIFd2lkdGgSFgoGaGVpZ2h0GAUgASgBUgZoZWlnaHQSIgoMdHJhbnNwYXJlbmN5GAYgASgBUgx0cmFuc3BhcmVuY3kSEgoEZGF0YRgHIAEoDFIEZGF0YQ==');
