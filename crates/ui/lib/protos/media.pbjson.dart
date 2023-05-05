///
//  Generated code. Do not modify.
//  source: media.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use mediaTypeDescriptor instead')
const MediaType$json = const {
  '1': 'MediaType',
  '2': const [
    const {'1': 'IMAGE', '2': 0},
    const {'1': 'AUDIO', '2': 1},
    const {'1': 'VIDEO', '2': 2},
    const {'1': 'VECTOR', '2': 3},
  ],
};

/// Descriptor for `MediaType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List mediaTypeDescriptor = $convert.base64Decode('CglNZWRpYVR5cGUSCQoFSU1BR0UQABIJCgVBVURJTxABEgkKBVZJREVPEAISCgoGVkVDVE9SEAM=');
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
    const {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.mizer.MediaType', '10': 'type'},
    const {'1': 'metadata', '3': 4, '4': 1, '5': 11, '6': '.mizer.MediaMetadata', '10': 'metadata'},
    const {'1': 'thumbnail_url', '3': 5, '4': 1, '5': 9, '10': 'thumbnailUrl'},
    const {'1': 'content_url', '3': 6, '4': 1, '5': 9, '10': 'contentUrl'},
  ],
};

/// Descriptor for `MediaFile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaFileDescriptor = $convert.base64Decode('CglNZWRpYUZpbGUSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSJAoEdHlwZRgDIAEoDjIQLm1pemVyLk1lZGlhVHlwZVIEdHlwZRIwCghtZXRhZGF0YRgEIAEoCzIULm1pemVyLk1lZGlhTWV0YWRhdGFSCG1ldGFkYXRhEiMKDXRodW1ibmFpbF91cmwYBSABKAlSDHRodW1ibmFpbFVybBIfCgtjb250ZW50X3VybBgGIAEoCVIKY29udGVudFVybA==');
@$core.Deprecated('Use mediaMetadataDescriptor instead')
const MediaMetadata$json = const {
  '1': 'MediaMetadata',
  '2': const [
    const {'1': 'source_path', '3': 1, '4': 1, '5': 9, '10': 'sourcePath'},
    const {'1': 'file_size', '3': 2, '4': 1, '5': 4, '10': 'fileSize'},
    const {'1': 'tags', '3': 3, '4': 3, '5': 11, '6': '.mizer.MediaTag', '10': 'tags'},
    const {'1': 'dimensions', '3': 4, '4': 1, '5': 11, '6': '.mizer.MediaMetadata.Dimensions', '9': 0, '10': 'dimensions', '17': true},
    const {'1': 'duration', '3': 5, '4': 1, '5': 4, '9': 1, '10': 'duration', '17': true},
    const {'1': 'framerate', '3': 6, '4': 1, '5': 1, '9': 2, '10': 'framerate', '17': true},
    const {'1': 'album', '3': 7, '4': 1, '5': 9, '9': 3, '10': 'album', '17': true},
    const {'1': 'artist', '3': 8, '4': 1, '5': 9, '9': 4, '10': 'artist', '17': true},
  ],
  '3': const [MediaMetadata_Dimensions$json],
  '8': const [
    const {'1': '_dimensions'},
    const {'1': '_duration'},
    const {'1': '_framerate'},
    const {'1': '_album'},
    const {'1': '_artist'},
  ],
};

@$core.Deprecated('Use mediaMetadataDescriptor instead')
const MediaMetadata_Dimensions$json = const {
  '1': 'Dimensions',
  '2': const [
    const {'1': 'width', '3': 1, '4': 1, '5': 4, '10': 'width'},
    const {'1': 'height', '3': 2, '4': 1, '5': 4, '10': 'height'},
  ],
};

/// Descriptor for `MediaMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaMetadataDescriptor = $convert.base64Decode('Cg1NZWRpYU1ldGFkYXRhEh8KC3NvdXJjZV9wYXRoGAEgASgJUgpzb3VyY2VQYXRoEhsKCWZpbGVfc2l6ZRgCIAEoBFIIZmlsZVNpemUSIwoEdGFncxgDIAMoCzIPLm1pemVyLk1lZGlhVGFnUgR0YWdzEkQKCmRpbWVuc2lvbnMYBCABKAsyHy5taXplci5NZWRpYU1ldGFkYXRhLkRpbWVuc2lvbnNIAFIKZGltZW5zaW9uc4gBARIfCghkdXJhdGlvbhgFIAEoBEgBUghkdXJhdGlvbogBARIhCglmcmFtZXJhdGUYBiABKAFIAlIJZnJhbWVyYXRliAEBEhkKBWFsYnVtGAcgASgJSANSBWFsYnVtiAEBEhsKBmFydGlzdBgIIAEoCUgEUgZhcnRpc3SIAQEaOgoKRGltZW5zaW9ucxIUCgV3aWR0aBgBIAEoBFIFd2lkdGgSFgoGaGVpZ2h0GAIgASgEUgZoZWlnaHRCDQoLX2RpbWVuc2lvbnNCCwoJX2R1cmF0aW9uQgwKCl9mcmFtZXJhdGVCCAoGX2FsYnVtQgkKB19hcnRpc3Q=');
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
