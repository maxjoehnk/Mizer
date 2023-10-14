//
//  Generated code. Do not modify.
//  source: surfaces.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use surfaceDescriptor instead')
const Surface$json = {
  '1': 'Surface',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'sections', '3': 3, '4': 3, '5': 11, '6': '.mizer.surfaces.SurfaceSection', '10': 'sections'},
  ],
};

/// Descriptor for `Surface`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List surfaceDescriptor = $convert.base64Decode(
    'CgdTdXJmYWNlEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEjoKCHNlY3Rpb2'
    '5zGAMgAygLMh4ubWl6ZXIuc3VyZmFjZXMuU3VyZmFjZVNlY3Rpb25SCHNlY3Rpb25z');

@$core.Deprecated('Use surfacesDescriptor instead')
const Surfaces$json = {
  '1': 'Surfaces',
  '2': [
    {'1': 'surfaces', '3': 1, '4': 3, '5': 11, '6': '.mizer.surfaces.Surface', '10': 'surfaces'},
  ],
};

/// Descriptor for `Surfaces`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List surfacesDescriptor = $convert.base64Decode(
    'CghTdXJmYWNlcxIzCghzdXJmYWNlcxgBIAMoCzIXLm1pemVyLnN1cmZhY2VzLlN1cmZhY2VSCH'
    'N1cmZhY2Vz');

@$core.Deprecated('Use surfaceSectionDescriptor instead')
const SurfaceSection$json = {
  '1': 'SurfaceSection',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'input', '3': 3, '4': 1, '5': 11, '6': '.mizer.surfaces.SurfaceTransform', '10': 'input'},
    {'1': 'output', '3': 4, '4': 1, '5': 11, '6': '.mizer.surfaces.SurfaceTransform', '10': 'output'},
  ],
};

/// Descriptor for `SurfaceSection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List surfaceSectionDescriptor = $convert.base64Decode(
    'Cg5TdXJmYWNlU2VjdGlvbhIOCgJpZBgBIAEoDVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRI2Cg'
    'VpbnB1dBgDIAEoCzIgLm1pemVyLnN1cmZhY2VzLlN1cmZhY2VUcmFuc2Zvcm1SBWlucHV0EjgK'
    'Bm91dHB1dBgEIAEoCzIgLm1pemVyLnN1cmZhY2VzLlN1cmZhY2VUcmFuc2Zvcm1SBm91dHB1dA'
    '==');

@$core.Deprecated('Use surfaceTransformDescriptor instead')
const SurfaceTransform$json = {
  '1': 'SurfaceTransform',
  '2': [
    {'1': 'top_left', '3': 1, '4': 1, '5': 11, '6': '.mizer.surfaces.SurfaceTransformPoint', '10': 'topLeft'},
    {'1': 'top_right', '3': 2, '4': 1, '5': 11, '6': '.mizer.surfaces.SurfaceTransformPoint', '10': 'topRight'},
    {'1': 'bottom_left', '3': 3, '4': 1, '5': 11, '6': '.mizer.surfaces.SurfaceTransformPoint', '10': 'bottomLeft'},
    {'1': 'bottom_right', '3': 4, '4': 1, '5': 11, '6': '.mizer.surfaces.SurfaceTransformPoint', '10': 'bottomRight'},
  ],
};

/// Descriptor for `SurfaceTransform`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List surfaceTransformDescriptor = $convert.base64Decode(
    'ChBTdXJmYWNlVHJhbnNmb3JtEkAKCHRvcF9sZWZ0GAEgASgLMiUubWl6ZXIuc3VyZmFjZXMuU3'
    'VyZmFjZVRyYW5zZm9ybVBvaW50Ugd0b3BMZWZ0EkIKCXRvcF9yaWdodBgCIAEoCzIlLm1pemVy'
    'LnN1cmZhY2VzLlN1cmZhY2VUcmFuc2Zvcm1Qb2ludFIIdG9wUmlnaHQSRgoLYm90dG9tX2xlZn'
    'QYAyABKAsyJS5taXplci5zdXJmYWNlcy5TdXJmYWNlVHJhbnNmb3JtUG9pbnRSCmJvdHRvbUxl'
    'ZnQSSAoMYm90dG9tX3JpZ2h0GAQgASgLMiUubWl6ZXIuc3VyZmFjZXMuU3VyZmFjZVRyYW5zZm'
    '9ybVBvaW50Ugtib3R0b21SaWdodA==');

@$core.Deprecated('Use surfaceTransformPointDescriptor instead')
const SurfaceTransformPoint$json = {
  '1': 'SurfaceTransformPoint',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 1, '10': 'y'},
  ],
};

/// Descriptor for `SurfaceTransformPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List surfaceTransformPointDescriptor = $convert.base64Decode(
    'ChVTdXJmYWNlVHJhbnNmb3JtUG9pbnQSDAoBeBgBIAEoAVIBeBIMCgF5GAIgASgBUgF5');

@$core.Deprecated('Use updateSectionTransformDescriptor instead')
const UpdateSectionTransform$json = {
  '1': 'UpdateSectionTransform',
  '2': [
    {'1': 'surface_id', '3': 1, '4': 1, '5': 9, '10': 'surfaceId'},
    {'1': 'section_id', '3': 2, '4': 1, '5': 13, '10': 'sectionId'},
    {'1': 'transform', '3': 3, '4': 1, '5': 11, '6': '.mizer.surfaces.SurfaceTransform', '10': 'transform'},
  ],
};

/// Descriptor for `UpdateSectionTransform`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSectionTransformDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVTZWN0aW9uVHJhbnNmb3JtEh0KCnN1cmZhY2VfaWQYASABKAlSCXN1cmZhY2VJZB'
    'IdCgpzZWN0aW9uX2lkGAIgASgNUglzZWN0aW9uSWQSPgoJdHJhbnNmb3JtGAMgASgLMiAubWl6'
    'ZXIuc3VyZmFjZXMuU3VyZmFjZVRyYW5zZm9ybVIJdHJhbnNmb3Jt');

