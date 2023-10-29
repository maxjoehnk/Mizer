//
//  Generated code. Do not modify.
//  source: media.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use mediaTypeDescriptor instead')
const MediaType$json = {
  '1': 'MediaType',
  '2': [
    {'1': 'IMAGE', '2': 0},
    {'1': 'AUDIO', '2': 1},
    {'1': 'VIDEO', '2': 2},
    {'1': 'VECTOR', '2': 3},
  ],
};

/// Descriptor for `MediaType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List mediaTypeDescriptor = $convert.base64Decode(
    'CglNZWRpYVR5cGUSCQoFSU1BR0UQABIJCgVBVURJTxABEgkKBVZJREVPEAISCgoGVkVDVE9SEA'
    'M=');

@$core.Deprecated('Use addTagToMediaRequestDescriptor instead')
const AddTagToMediaRequest$json = {
  '1': 'AddTagToMediaRequest',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 9, '10': 'mediaId'},
    {'1': 'tag_id', '3': 2, '4': 1, '5': 9, '10': 'tagId'},
  ],
};

/// Descriptor for `AddTagToMediaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addTagToMediaRequestDescriptor = $convert.base64Decode(
    'ChRBZGRUYWdUb01lZGlhUmVxdWVzdBIZCghtZWRpYV9pZBgBIAEoCVIHbWVkaWFJZBIVCgZ0YW'
    'dfaWQYAiABKAlSBXRhZ0lk');

@$core.Deprecated('Use removeTagFromMediaRequestDescriptor instead')
const RemoveTagFromMediaRequest$json = {
  '1': 'RemoveTagFromMediaRequest',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 9, '10': 'mediaId'},
    {'1': 'tag_id', '3': 2, '4': 1, '5': 9, '10': 'tagId'},
  ],
};

/// Descriptor for `RemoveTagFromMediaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeTagFromMediaRequestDescriptor = $convert.base64Decode(
    'ChlSZW1vdmVUYWdGcm9tTWVkaWFSZXF1ZXN0EhkKCG1lZGlhX2lkGAEgASgJUgdtZWRpYUlkEh'
    'UKBnRhZ19pZBgCIAEoCVIFdGFnSWQ=');

@$core.Deprecated('Use mediaTagDescriptor instead')
const MediaTag$json = {
  '1': 'MediaTag',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `MediaTag`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaTagDescriptor = $convert.base64Decode(
    'CghNZWRpYVRhZxIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use mediaFilesDescriptor instead')
const MediaFiles$json = {
  '1': 'MediaFiles',
  '2': [
    {'1': 'files', '3': 1, '4': 3, '5': 11, '6': '.mizer.media.MediaFile', '10': 'files'},
    {'1': 'folders', '3': 2, '4': 1, '5': 11, '6': '.mizer.media.MediaFolders', '10': 'folders'},
    {'1': 'tags', '3': 3, '4': 3, '5': 11, '6': '.mizer.media.MediaTag', '10': 'tags'},
  ],
};

/// Descriptor for `MediaFiles`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaFilesDescriptor = $convert.base64Decode(
    'CgpNZWRpYUZpbGVzEiwKBWZpbGVzGAEgAygLMhYubWl6ZXIubWVkaWEuTWVkaWFGaWxlUgVmaW'
    'xlcxIzCgdmb2xkZXJzGAIgASgLMhkubWl6ZXIubWVkaWEuTWVkaWFGb2xkZXJzUgdmb2xkZXJz'
    'EikKBHRhZ3MYAyADKAsyFS5taXplci5tZWRpYS5NZWRpYVRhZ1IEdGFncw==');

@$core.Deprecated('Use mediaFileDescriptor instead')
const MediaFile$json = {
  '1': 'MediaFile',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.mizer.media.MediaType', '10': 'type'},
    {'1': 'metadata', '3': 4, '4': 1, '5': 11, '6': '.mizer.media.MediaMetadata', '10': 'metadata'},
    {'1': 'thumbnail_path', '3': 5, '4': 1, '5': 9, '9': 0, '10': 'thumbnailPath', '17': true},
  ],
  '8': [
    {'1': '_thumbnail_path'},
  ],
};

/// Descriptor for `MediaFile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaFileDescriptor = $convert.base64Decode(
    'CglNZWRpYUZpbGUSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSKgoEdHlwZR'
    'gDIAEoDjIWLm1pemVyLm1lZGlhLk1lZGlhVHlwZVIEdHlwZRI2CghtZXRhZGF0YRgEIAEoCzIa'
    'Lm1pemVyLm1lZGlhLk1lZGlhTWV0YWRhdGFSCG1ldGFkYXRhEioKDnRodW1ibmFpbF9wYXRoGA'
    'UgASgJSABSDXRodW1ibmFpbFBhdGiIAQFCEQoPX3RodW1ibmFpbF9wYXRo');

@$core.Deprecated('Use mediaMetadataDescriptor instead')
const MediaMetadata$json = {
  '1': 'MediaMetadata',
  '2': [
    {'1': 'source_path', '3': 1, '4': 1, '5': 9, '10': 'sourcePath'},
    {'1': 'file_size', '3': 2, '4': 1, '5': 4, '10': 'fileSize'},
    {'1': 'tags', '3': 3, '4': 3, '5': 11, '6': '.mizer.media.MediaTag', '10': 'tags'},
    {'1': 'dimensions', '3': 4, '4': 1, '5': 11, '6': '.mizer.media.MediaMetadata.Dimensions', '9': 0, '10': 'dimensions', '17': true},
    {'1': 'duration', '3': 5, '4': 1, '5': 4, '9': 1, '10': 'duration', '17': true},
    {'1': 'framerate', '3': 6, '4': 1, '5': 1, '9': 2, '10': 'framerate', '17': true},
    {'1': 'album', '3': 7, '4': 1, '5': 9, '9': 3, '10': 'album', '17': true},
    {'1': 'artist', '3': 8, '4': 1, '5': 9, '9': 4, '10': 'artist', '17': true},
  ],
  '3': [MediaMetadata_Dimensions$json],
  '8': [
    {'1': '_dimensions'},
    {'1': '_duration'},
    {'1': '_framerate'},
    {'1': '_album'},
    {'1': '_artist'},
  ],
};

@$core.Deprecated('Use mediaMetadataDescriptor instead')
const MediaMetadata_Dimensions$json = {
  '1': 'Dimensions',
  '2': [
    {'1': 'width', '3': 1, '4': 1, '5': 4, '10': 'width'},
    {'1': 'height', '3': 2, '4': 1, '5': 4, '10': 'height'},
  ],
};

/// Descriptor for `MediaMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaMetadataDescriptor = $convert.base64Decode(
    'Cg1NZWRpYU1ldGFkYXRhEh8KC3NvdXJjZV9wYXRoGAEgASgJUgpzb3VyY2VQYXRoEhsKCWZpbG'
    'Vfc2l6ZRgCIAEoBFIIZmlsZVNpemUSKQoEdGFncxgDIAMoCzIVLm1pemVyLm1lZGlhLk1lZGlh'
    'VGFnUgR0YWdzEkoKCmRpbWVuc2lvbnMYBCABKAsyJS5taXplci5tZWRpYS5NZWRpYU1ldGFkYX'
    'RhLkRpbWVuc2lvbnNIAFIKZGltZW5zaW9uc4gBARIfCghkdXJhdGlvbhgFIAEoBEgBUghkdXJh'
    'dGlvbogBARIhCglmcmFtZXJhdGUYBiABKAFIAlIJZnJhbWVyYXRliAEBEhkKBWFsYnVtGAcgAS'
    'gJSANSBWFsYnVtiAEBEhsKBmFydGlzdBgIIAEoCUgEUgZhcnRpc3SIAQEaOgoKRGltZW5zaW9u'
    'cxIUCgV3aWR0aBgBIAEoBFIFd2lkdGgSFgoGaGVpZ2h0GAIgASgEUgZoZWlnaHRCDQoLX2RpbW'
    'Vuc2lvbnNCCwoJX2R1cmF0aW9uQgwKCl9mcmFtZXJhdGVCCAoGX2FsYnVtQgkKB19hcnRpc3Q=');

@$core.Deprecated('Use mediaFoldersDescriptor instead')
const MediaFolders$json = {
  '1': 'MediaFolders',
  '2': [
    {'1': 'paths', '3': 1, '4': 3, '5': 9, '10': 'paths'},
  ],
};

/// Descriptor for `MediaFolders`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaFoldersDescriptor = $convert.base64Decode(
    'CgxNZWRpYUZvbGRlcnMSFAoFcGF0aHMYASADKAlSBXBhdGhz');

@$core.Deprecated('Use importMediaRequestDescriptor instead')
const ImportMediaRequest$json = {
  '1': 'ImportMediaRequest',
  '2': [
    {'1': 'files', '3': 1, '4': 3, '5': 9, '10': 'files'},
  ],
};

/// Descriptor for `ImportMediaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List importMediaRequestDescriptor = $convert.base64Decode(
    'ChJJbXBvcnRNZWRpYVJlcXVlc3QSFAoFZmlsZXMYASADKAlSBWZpbGVz');

