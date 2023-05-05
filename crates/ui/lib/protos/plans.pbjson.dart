///
//  Generated code. Do not modify.
//  source: plans.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use plansRequestDescriptor instead')
const PlansRequest$json = const {
  '1': 'PlansRequest',
};

/// Descriptor for `PlansRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List plansRequestDescriptor = $convert.base64Decode('CgxQbGFuc1JlcXVlc3Q=');
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
    const {'1': 'direction', '3': 2, '4': 1, '5': 14, '6': '.mizer.plan.AlignFixturesRequest.AlignDirection', '10': 'direction'},
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
final $typed_data.Uint8List alignFixturesRequestDescriptor = $convert.base64Decode('ChRBbGlnbkZpeHR1cmVzUmVxdWVzdBIXCgdwbGFuX2lkGAEgASgJUgZwbGFuSWQSTQoJZGlyZWN0aW9uGAIgASgOMi8ubWl6ZXIucGxhbi5BbGlnbkZpeHR1cmVzUmVxdWVzdC5BbGlnbkRpcmVjdGlvblIJZGlyZWN0aW9uEhYKBmdyb3VwcxgDIAEoDVIGZ3JvdXBzEhcKB3Jvd19nYXAYBCABKA1SBnJvd0dhcBIdCgpjb2x1bW5fZ2FwGAUgASgNUgljb2x1bW5HYXAiNgoOQWxpZ25EaXJlY3Rpb24SEQoNTEVGVF9UT19SSUdIVBAAEhEKDVRPUF9UT19CT1RUT00QAQ==');
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
@$core.Deprecated('Use plansDescriptor instead')
const Plans$json = const {
  '1': 'Plans',
  '2': const [
    const {'1': 'plans', '3': 1, '4': 3, '5': 11, '6': '.mizer.plan.Plan', '10': 'plans'},
  ],
};

/// Descriptor for `Plans`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List plansDescriptor = $convert.base64Decode('CgVQbGFucxImCgVwbGFucxgBIAMoCzIQLm1pemVyLnBsYW4uUGxhblIFcGxhbnM=');
@$core.Deprecated('Use planDescriptor instead')
const Plan$json = const {
  '1': 'Plan',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'positions', '3': 2, '4': 3, '5': 11, '6': '.mizer.plan.FixturePosition', '10': 'positions'},
    const {'1': 'screens', '3': 3, '4': 3, '5': 11, '6': '.mizer.plan.PlanScreen', '10': 'screens'},
  ],
};

/// Descriptor for `Plan`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planDescriptor = $convert.base64Decode('CgRQbGFuEhIKBG5hbWUYASABKAlSBG5hbWUSOQoJcG9zaXRpb25zGAIgAygLMhsubWl6ZXIucGxhbi5GaXh0dXJlUG9zaXRpb25SCXBvc2l0aW9ucxIwCgdzY3JlZW5zGAMgAygLMhYubWl6ZXIucGxhbi5QbGFuU2NyZWVuUgdzY3JlZW5z');
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
