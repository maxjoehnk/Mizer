///
//  Generated code. Do not modify.
//  source: media.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use getMediaTagsDescriptor instead')
const GetMediaTags$json = const {
  '1': 'GetMediaTags',
};

/// Descriptor for `GetMediaTags`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMediaTagsDescriptor = $convert.base64Decode('CgxHZXRNZWRpYVRhZ3M=');
@$core.Deprecated('Use getMediaRequestDescriptor instead')
const GetMediaRequest$json = const {
  '1': 'GetMediaRequest',
};

/// Descriptor for `GetMediaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMediaRequestDescriptor = $convert.base64Decode('Cg9HZXRNZWRpYVJlcXVlc3Q=');
@$core.Deprecated('Use createMediaTagDescriptor instead')
const CreateMediaTag$json = const {
  '1': 'CreateMediaTag',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `CreateMediaTag`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createMediaTagDescriptor = $convert.base64Decode('Cg5DcmVhdGVNZWRpYVRhZxISCgRuYW1lGAEgASgJUgRuYW1l');
@$core.Deprecated('Use mediaTagsDescriptor instead')
const MediaTags$json = const {
  '1': 'MediaTags',
  '2': const [
    const {'1': 'tags', '3': 1, '4': 3, '5': 11, '6': '.mizer.MediaTag', '10': 'tags'},
  ],
};

/// Descriptor for `MediaTags`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaTagsDescriptor = $convert.base64Decode('CglNZWRpYVRhZ3MSIwoEdGFncxgBIAMoCzIPLm1pemVyLk1lZGlhVGFnUgR0YWdz');
@$core.Deprecated('Use mediaTagDescriptor instead')
const MediaTag$json = const {
  '1': 'MediaTag',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `MediaTag`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaTagDescriptor = $convert.base64Decode('CghNZWRpYVRhZxIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use mediaFilesDescriptor instead')
const MediaFiles$json = const {
  '1': 'MediaFiles',
  '2': const [
    const {'1': 'files', '3': 1, '4': 3, '5': 11, '6': '.mizer.MediaFile', '10': 'files'},
  ],
};

/// Descriptor for `MediaFiles`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaFilesDescriptor = $convert.base64Decode('CgpNZWRpYUZpbGVzEiYKBWZpbGVzGAEgAygLMhAubWl6ZXIuTWVkaWFGaWxlUgVmaWxlcw==');
@$core.Deprecated('Use mediaFileDescriptor instead')
const MediaFile$json = const {
  '1': 'MediaFile',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'tags', '3': 3, '4': 3, '5': 11, '6': '.mizer.MediaTag', '10': 'tags'},
    const {'1': 'thumbnailUrl', '3': 4, '4': 1, '5': 9, '10': 'thumbnailUrl'},
    const {'1': 'contentUrl', '3': 5, '4': 1, '5': 9, '10': 'contentUrl'},
  ],
};

/// Descriptor for `MediaFile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaFileDescriptor = $convert.base64Decode('CglNZWRpYUZpbGUSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSIwoEdGFncxgDIAMoCzIPLm1pemVyLk1lZGlhVGFnUgR0YWdzEiIKDHRodW1ibmFpbFVybBgEIAEoCVIMdGh1bWJuYWlsVXJsEh4KCmNvbnRlbnRVcmwYBSABKAlSCmNvbnRlbnRVcmw=');
@$core.Deprecated('Use groupedMediaFilesDescriptor instead')
const GroupedMediaFiles$json = const {
  '1': 'GroupedMediaFiles',
  '2': const [
    const {'1': 'tags', '3': 1, '4': 3, '5': 11, '6': '.mizer.MediaTagWithFiles', '10': 'tags'},
  ],
};

/// Descriptor for `GroupedMediaFiles`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupedMediaFilesDescriptor = $convert.base64Decode('ChFHcm91cGVkTWVkaWFGaWxlcxIsCgR0YWdzGAEgAygLMhgubWl6ZXIuTWVkaWFUYWdXaXRoRmlsZXNSBHRhZ3M=');
@$core.Deprecated('Use mediaTagWithFilesDescriptor instead')
const MediaTagWithFiles$json = const {
  '1': 'MediaTagWithFiles',
  '2': const [
    const {'1': 'tag', '3': 1, '4': 1, '5': 11, '6': '.mizer.MediaTag', '10': 'tag'},
    const {'1': 'files', '3': 2, '4': 3, '5': 11, '6': '.mizer.MediaFile', '10': 'files'},
  ],
};

/// Descriptor for `MediaTagWithFiles`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaTagWithFilesDescriptor = $convert.base64Decode('ChFNZWRpYVRhZ1dpdGhGaWxlcxIhCgN0YWcYASABKAsyDy5taXplci5NZWRpYVRhZ1IDdGFnEiYKBWZpbGVzGAIgAygLMhAubWl6ZXIuTWVkaWFGaWxlUgVmaWxlcw==');
