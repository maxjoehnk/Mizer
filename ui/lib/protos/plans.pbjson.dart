///
//  Generated code. Do not modify.
//  source: plans.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

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
  ],
};

/// Descriptor for `Plan`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planDescriptor = $convert.base64Decode('CgRQbGFuEhIKBG5hbWUYASABKAlSBG5hbWUSOQoJcG9zaXRpb25zGAIgAygLMhsubWl6ZXIucGxhbi5GaXh0dXJlUG9zaXRpb25SCXBvc2l0aW9ucw==');
@$core.Deprecated('Use fixturePositionDescriptor instead')
const FixturePosition$json = const {
  '1': 'FixturePosition',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'id'},
    const {'1': 'x', '3': 2, '4': 1, '5': 5, '10': 'x'},
    const {'1': 'y', '3': 3, '4': 1, '5': 5, '10': 'y'},
  ],
};

/// Descriptor for `FixturePosition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixturePositionDescriptor = $convert.base64Decode('Cg9GaXh0dXJlUG9zaXRpb24SKQoCaWQYASABKAsyGS5taXplci5maXh0dXJlcy5GaXh0dXJlSWRSAmlkEgwKAXgYAiABKAVSAXgSDAoBeRgDIAEoBVIBeQ==');
