///
//  Generated code. Do not modify.
//  source: media.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const GetMediaTags$json = const {
  '1': 'GetMediaTags',
};

const GetMediaRequest$json = const {
  '1': 'GetMediaRequest',
};

const CreateMediaTag$json = const {
  '1': 'CreateMediaTag',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

const MediaTags$json = const {
  '1': 'MediaTags',
  '2': const [
    const {'1': 'tags', '3': 1, '4': 3, '5': 11, '6': '.mizer.MediaTag', '10': 'tags'},
  ],
};

const MediaTag$json = const {
  '1': 'MediaTag',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

const MediaFiles$json = const {
  '1': 'MediaFiles',
  '2': const [
    const {'1': 'files', '3': 1, '4': 3, '5': 11, '6': '.mizer.MediaFile', '10': 'files'},
  ],
};

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

const GroupedMediaFiles$json = const {
  '1': 'GroupedMediaFiles',
  '2': const [
    const {'1': 'tags', '3': 1, '4': 3, '5': 11, '6': '.mizer.MediaTagWithFiles', '10': 'tags'},
  ],
};

const MediaTagWithFiles$json = const {
  '1': 'MediaTagWithFiles',
  '2': const [
    const {'1': 'tag', '3': 1, '4': 1, '5': 11, '6': '.mizer.MediaTag', '10': 'tag'},
    const {'1': 'files', '3': 2, '4': 3, '5': 11, '6': '.mizer.MediaFile', '10': 'files'},
  ],
};

