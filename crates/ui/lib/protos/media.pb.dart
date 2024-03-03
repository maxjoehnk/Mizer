//
//  Generated code. Do not modify.
//  source: media.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'media.pbenum.dart';

export 'media.pbenum.dart';

class AddTagToMediaRequest extends $pb.GeneratedMessage {
  factory AddTagToMediaRequest({
    $core.String? mediaId,
    $core.String? tagId,
  }) {
    final $result = create();
    if (mediaId != null) {
      $result.mediaId = mediaId;
    }
    if (tagId != null) {
      $result.tagId = tagId;
    }
    return $result;
  }
  AddTagToMediaRequest._() : super();
  factory AddTagToMediaRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddTagToMediaRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddTagToMediaRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.media'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'mediaId')
    ..aOS(2, _omitFieldNames ? '' : 'tagId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddTagToMediaRequest clone() => AddTagToMediaRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddTagToMediaRequest copyWith(void Function(AddTagToMediaRequest) updates) => super.copyWith((message) => updates(message as AddTagToMediaRequest)) as AddTagToMediaRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddTagToMediaRequest create() => AddTagToMediaRequest._();
  AddTagToMediaRequest createEmptyInstance() => create();
  static $pb.PbList<AddTagToMediaRequest> createRepeated() => $pb.PbList<AddTagToMediaRequest>();
  @$core.pragma('dart2js:noInline')
  static AddTagToMediaRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddTagToMediaRequest>(create);
  static AddTagToMediaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mediaId => $_getSZ(0);
  @$pb.TagNumber(1)
  set mediaId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMediaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get tagId => $_getSZ(1);
  @$pb.TagNumber(2)
  set tagId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTagId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTagId() => clearField(2);
}

class RemoveTagFromMediaRequest extends $pb.GeneratedMessage {
  factory RemoveTagFromMediaRequest({
    $core.String? mediaId,
    $core.String? tagId,
  }) {
    final $result = create();
    if (mediaId != null) {
      $result.mediaId = mediaId;
    }
    if (tagId != null) {
      $result.tagId = tagId;
    }
    return $result;
  }
  RemoveTagFromMediaRequest._() : super();
  factory RemoveTagFromMediaRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveTagFromMediaRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveTagFromMediaRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.media'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'mediaId')
    ..aOS(2, _omitFieldNames ? '' : 'tagId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveTagFromMediaRequest clone() => RemoveTagFromMediaRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveTagFromMediaRequest copyWith(void Function(RemoveTagFromMediaRequest) updates) => super.copyWith((message) => updates(message as RemoveTagFromMediaRequest)) as RemoveTagFromMediaRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveTagFromMediaRequest create() => RemoveTagFromMediaRequest._();
  RemoveTagFromMediaRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveTagFromMediaRequest> createRepeated() => $pb.PbList<RemoveTagFromMediaRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveTagFromMediaRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveTagFromMediaRequest>(create);
  static RemoveTagFromMediaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mediaId => $_getSZ(0);
  @$pb.TagNumber(1)
  set mediaId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMediaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get tagId => $_getSZ(1);
  @$pb.TagNumber(2)
  set tagId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTagId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTagId() => clearField(2);
}

class MediaTag extends $pb.GeneratedMessage {
  factory MediaTag({
    $core.String? id,
    $core.String? name,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  MediaTag._() : super();
  factory MediaTag.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MediaTag.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MediaTag', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.media'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MediaTag clone() => MediaTag()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MediaTag copyWith(void Function(MediaTag) updates) => super.copyWith((message) => updates(message as MediaTag)) as MediaTag;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaTag create() => MediaTag._();
  MediaTag createEmptyInstance() => create();
  static $pb.PbList<MediaTag> createRepeated() => $pb.PbList<MediaTag>();
  @$core.pragma('dart2js:noInline')
  static MediaTag getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaTag>(create);
  static MediaTag? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class MediaFiles extends $pb.GeneratedMessage {
  factory MediaFiles({
    $core.Iterable<MediaFile>? files,
    MediaFolders? folders,
    $core.Iterable<MediaTag>? tags,
  }) {
    final $result = create();
    if (files != null) {
      $result.files.addAll(files);
    }
    if (folders != null) {
      $result.folders = folders;
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    return $result;
  }
  MediaFiles._() : super();
  factory MediaFiles.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MediaFiles.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MediaFiles', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.media'), createEmptyInstance: create)
    ..pc<MediaFile>(1, _omitFieldNames ? '' : 'files', $pb.PbFieldType.PM, subBuilder: MediaFile.create)
    ..aOM<MediaFolders>(2, _omitFieldNames ? '' : 'folders', subBuilder: MediaFolders.create)
    ..pc<MediaTag>(3, _omitFieldNames ? '' : 'tags', $pb.PbFieldType.PM, subBuilder: MediaTag.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MediaFiles clone() => MediaFiles()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MediaFiles copyWith(void Function(MediaFiles) updates) => super.copyWith((message) => updates(message as MediaFiles)) as MediaFiles;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaFiles create() => MediaFiles._();
  MediaFiles createEmptyInstance() => create();
  static $pb.PbList<MediaFiles> createRepeated() => $pb.PbList<MediaFiles>();
  @$core.pragma('dart2js:noInline')
  static MediaFiles getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaFiles>(create);
  static MediaFiles? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MediaFile> get files => $_getList(0);

  @$pb.TagNumber(2)
  MediaFolders get folders => $_getN(1);
  @$pb.TagNumber(2)
  set folders(MediaFolders v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasFolders() => $_has(1);
  @$pb.TagNumber(2)
  void clearFolders() => clearField(2);
  @$pb.TagNumber(2)
  MediaFolders ensureFolders() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<MediaTag> get tags => $_getList(2);
}

class MediaFile extends $pb.GeneratedMessage {
  factory MediaFile({
    $core.String? id,
    $core.String? name,
    MediaType? type,
    MediaMetadata? metadata,
    $core.String? thumbnailPath,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (type != null) {
      $result.type = type;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (thumbnailPath != null) {
      $result.thumbnailPath = thumbnailPath;
    }
    return $result;
  }
  MediaFile._() : super();
  factory MediaFile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MediaFile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MediaFile', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.media'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..e<MediaType>(3, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: MediaType.IMAGE, valueOf: MediaType.valueOf, enumValues: MediaType.values)
    ..aOM<MediaMetadata>(4, _omitFieldNames ? '' : 'metadata', subBuilder: MediaMetadata.create)
    ..aOS(5, _omitFieldNames ? '' : 'thumbnailPath')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MediaFile clone() => MediaFile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MediaFile copyWith(void Function(MediaFile) updates) => super.copyWith((message) => updates(message as MediaFile)) as MediaFile;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaFile create() => MediaFile._();
  MediaFile createEmptyInstance() => create();
  static $pb.PbList<MediaFile> createRepeated() => $pb.PbList<MediaFile>();
  @$core.pragma('dart2js:noInline')
  static MediaFile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaFile>(create);
  static MediaFile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  MediaType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(MediaType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  MediaMetadata get metadata => $_getN(3);
  @$pb.TagNumber(4)
  set metadata(MediaMetadata v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => clearField(4);
  @$pb.TagNumber(4)
  MediaMetadata ensureMetadata() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get thumbnailPath => $_getSZ(4);
  @$pb.TagNumber(5)
  set thumbnailPath($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasThumbnailPath() => $_has(4);
  @$pb.TagNumber(5)
  void clearThumbnailPath() => clearField(5);
}

class MediaMetadata_Dimensions extends $pb.GeneratedMessage {
  factory MediaMetadata_Dimensions({
    $fixnum.Int64? width,
    $fixnum.Int64? height,
  }) {
    final $result = create();
    if (width != null) {
      $result.width = width;
    }
    if (height != null) {
      $result.height = height;
    }
    return $result;
  }
  MediaMetadata_Dimensions._() : super();
  factory MediaMetadata_Dimensions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MediaMetadata_Dimensions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MediaMetadata.Dimensions', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.media'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'width', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MediaMetadata_Dimensions clone() => MediaMetadata_Dimensions()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MediaMetadata_Dimensions copyWith(void Function(MediaMetadata_Dimensions) updates) => super.copyWith((message) => updates(message as MediaMetadata_Dimensions)) as MediaMetadata_Dimensions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaMetadata_Dimensions create() => MediaMetadata_Dimensions._();
  MediaMetadata_Dimensions createEmptyInstance() => create();
  static $pb.PbList<MediaMetadata_Dimensions> createRepeated() => $pb.PbList<MediaMetadata_Dimensions>();
  @$core.pragma('dart2js:noInline')
  static MediaMetadata_Dimensions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaMetadata_Dimensions>(create);
  static MediaMetadata_Dimensions? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get width => $_getI64(0);
  @$pb.TagNumber(1)
  set width($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWidth() => $_has(0);
  @$pb.TagNumber(1)
  void clearWidth() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get height => $_getI64(1);
  @$pb.TagNumber(2)
  set height($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => clearField(2);
}

class MediaMetadata extends $pb.GeneratedMessage {
  factory MediaMetadata({
    $core.String? sourcePath,
    $fixnum.Int64? fileSize,
    $core.Iterable<MediaTag>? tags,
    MediaMetadata_Dimensions? dimensions,
    $fixnum.Int64? duration,
    $core.double? framerate,
    $core.String? album,
    $core.String? artist,
    $core.int? sampleRate,
    $core.int? audioChannelCount,
  }) {
    final $result = create();
    if (sourcePath != null) {
      $result.sourcePath = sourcePath;
    }
    if (fileSize != null) {
      $result.fileSize = fileSize;
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (dimensions != null) {
      $result.dimensions = dimensions;
    }
    if (duration != null) {
      $result.duration = duration;
    }
    if (framerate != null) {
      $result.framerate = framerate;
    }
    if (album != null) {
      $result.album = album;
    }
    if (artist != null) {
      $result.artist = artist;
    }
    if (sampleRate != null) {
      $result.sampleRate = sampleRate;
    }
    if (audioChannelCount != null) {
      $result.audioChannelCount = audioChannelCount;
    }
    return $result;
  }
  MediaMetadata._() : super();
  factory MediaMetadata.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MediaMetadata.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MediaMetadata', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.media'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sourcePath')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'fileSize', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<MediaTag>(3, _omitFieldNames ? '' : 'tags', $pb.PbFieldType.PM, subBuilder: MediaTag.create)
    ..aOM<MediaMetadata_Dimensions>(4, _omitFieldNames ? '' : 'dimensions', subBuilder: MediaMetadata_Dimensions.create)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'duration', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'framerate', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'album')
    ..aOS(8, _omitFieldNames ? '' : 'artist')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'sampleRate', $pb.PbFieldType.OU3)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'audioChannelCount', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MediaMetadata clone() => MediaMetadata()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MediaMetadata copyWith(void Function(MediaMetadata) updates) => super.copyWith((message) => updates(message as MediaMetadata)) as MediaMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaMetadata create() => MediaMetadata._();
  MediaMetadata createEmptyInstance() => create();
  static $pb.PbList<MediaMetadata> createRepeated() => $pb.PbList<MediaMetadata>();
  @$core.pragma('dart2js:noInline')
  static MediaMetadata getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaMetadata>(create);
  static MediaMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sourcePath => $_getSZ(0);
  @$pb.TagNumber(1)
  set sourcePath($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSourcePath() => $_has(0);
  @$pb.TagNumber(1)
  void clearSourcePath() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get fileSize => $_getI64(1);
  @$pb.TagNumber(2)
  set fileSize($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFileSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<MediaTag> get tags => $_getList(2);

  @$pb.TagNumber(4)
  MediaMetadata_Dimensions get dimensions => $_getN(3);
  @$pb.TagNumber(4)
  set dimensions(MediaMetadata_Dimensions v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDimensions() => $_has(3);
  @$pb.TagNumber(4)
  void clearDimensions() => clearField(4);
  @$pb.TagNumber(4)
  MediaMetadata_Dimensions ensureDimensions() => $_ensure(3);

  @$pb.TagNumber(5)
  $fixnum.Int64 get duration => $_getI64(4);
  @$pb.TagNumber(5)
  set duration($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDuration() => $_has(4);
  @$pb.TagNumber(5)
  void clearDuration() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get framerate => $_getN(5);
  @$pb.TagNumber(6)
  set framerate($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFramerate() => $_has(5);
  @$pb.TagNumber(6)
  void clearFramerate() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get album => $_getSZ(6);
  @$pb.TagNumber(7)
  set album($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAlbum() => $_has(6);
  @$pb.TagNumber(7)
  void clearAlbum() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get artist => $_getSZ(7);
  @$pb.TagNumber(8)
  set artist($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasArtist() => $_has(7);
  @$pb.TagNumber(8)
  void clearArtist() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get sampleRate => $_getIZ(8);
  @$pb.TagNumber(9)
  set sampleRate($core.int v) { $_setUnsignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSampleRate() => $_has(8);
  @$pb.TagNumber(9)
  void clearSampleRate() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get audioChannelCount => $_getIZ(9);
  @$pb.TagNumber(10)
  set audioChannelCount($core.int v) { $_setUnsignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasAudioChannelCount() => $_has(9);
  @$pb.TagNumber(10)
  void clearAudioChannelCount() => clearField(10);
}

class MediaFolders extends $pb.GeneratedMessage {
  factory MediaFolders({
    $core.Iterable<$core.String>? paths,
  }) {
    final $result = create();
    if (paths != null) {
      $result.paths.addAll(paths);
    }
    return $result;
  }
  MediaFolders._() : super();
  factory MediaFolders.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MediaFolders.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MediaFolders', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.media'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'paths')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MediaFolders clone() => MediaFolders()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MediaFolders copyWith(void Function(MediaFolders) updates) => super.copyWith((message) => updates(message as MediaFolders)) as MediaFolders;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MediaFolders create() => MediaFolders._();
  MediaFolders createEmptyInstance() => create();
  static $pb.PbList<MediaFolders> createRepeated() => $pb.PbList<MediaFolders>();
  @$core.pragma('dart2js:noInline')
  static MediaFolders getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaFolders>(create);
  static MediaFolders? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get paths => $_getList(0);
}

class ImportMediaRequest extends $pb.GeneratedMessage {
  factory ImportMediaRequest({
    $core.Iterable<$core.String>? files,
  }) {
    final $result = create();
    if (files != null) {
      $result.files.addAll(files);
    }
    return $result;
  }
  ImportMediaRequest._() : super();
  factory ImportMediaRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImportMediaRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ImportMediaRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.media'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'files')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImportMediaRequest clone() => ImportMediaRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImportMediaRequest copyWith(void Function(ImportMediaRequest) updates) => super.copyWith((message) => updates(message as ImportMediaRequest)) as ImportMediaRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImportMediaRequest create() => ImportMediaRequest._();
  ImportMediaRequest createEmptyInstance() => create();
  static $pb.PbList<ImportMediaRequest> createRepeated() => $pb.PbList<ImportMediaRequest>();
  @$core.pragma('dart2js:noInline')
  static ImportMediaRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImportMediaRequest>(create);
  static ImportMediaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get files => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
