///
//  Generated code. Do not modify.
//  source: media.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'media.pbenum.dart';

export 'media.pbenum.dart';

class GetMediaTags extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMediaTags', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.media'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetMediaTags._() : super();
  factory GetMediaTags() => create();
  factory GetMediaTags.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMediaTags.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMediaTags clone() => GetMediaTags()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMediaTags copyWith(void Function(GetMediaTags) updates) => super.copyWith((message) => updates(message as GetMediaTags)) as GetMediaTags; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMediaTags create() => GetMediaTags._();
  GetMediaTags createEmptyInstance() => create();
  static $pb.PbList<GetMediaTags> createRepeated() => $pb.PbList<GetMediaTags>();
  @$core.pragma('dart2js:noInline')
  static GetMediaTags getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMediaTags>(create);
  static GetMediaTags? _defaultInstance;
}

class GetMediaRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMediaRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.media'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetMediaRequest._() : super();
  factory GetMediaRequest() => create();
  factory GetMediaRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMediaRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMediaRequest clone() => GetMediaRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMediaRequest copyWith(void Function(GetMediaRequest) updates) => super.copyWith((message) => updates(message as GetMediaRequest)) as GetMediaRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMediaRequest create() => GetMediaRequest._();
  GetMediaRequest createEmptyInstance() => create();
  static $pb.PbList<GetMediaRequest> createRepeated() => $pb.PbList<GetMediaRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMediaRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMediaRequest>(create);
  static GetMediaRequest? _defaultInstance;
}

class CreateMediaTag extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateMediaTag', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.media'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  CreateMediaTag._() : super();
  factory CreateMediaTag({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory CreateMediaTag.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateMediaTag.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateMediaTag clone() => CreateMediaTag()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateMediaTag copyWith(void Function(CreateMediaTag) updates) => super.copyWith((message) => updates(message as CreateMediaTag)) as CreateMediaTag; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateMediaTag create() => CreateMediaTag._();
  CreateMediaTag createEmptyInstance() => create();
  static $pb.PbList<CreateMediaTag> createRepeated() => $pb.PbList<CreateMediaTag>();
  @$core.pragma('dart2js:noInline')
  static CreateMediaTag getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateMediaTag>(create);
  static CreateMediaTag? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class MediaTags extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MediaTags', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.media'), createEmptyInstance: create)
    ..pc<MediaTag>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags', $pb.PbFieldType.PM, subBuilder: MediaTag.create)
    ..hasRequiredFields = false
  ;

  MediaTags._() : super();
  factory MediaTags({
    $core.Iterable<MediaTag>? tags,
  }) {
    final _result = create();
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    return _result;
  }
  factory MediaTags.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MediaTags.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MediaTags clone() => MediaTags()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MediaTags copyWith(void Function(MediaTags) updates) => super.copyWith((message) => updates(message as MediaTags)) as MediaTags; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MediaTags create() => MediaTags._();
  MediaTags createEmptyInstance() => create();
  static $pb.PbList<MediaTags> createRepeated() => $pb.PbList<MediaTags>();
  @$core.pragma('dart2js:noInline')
  static MediaTags getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaTags>(create);
  static MediaTags? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MediaTag> get tags => $_getList(0);
}

class MediaTag extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MediaTag', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.media'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  MediaTag._() : super();
  factory MediaTag({
    $core.String? id,
    $core.String? name,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory MediaTag.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MediaTag.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MediaTag clone() => MediaTag()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MediaTag copyWith(void Function(MediaTag) updates) => super.copyWith((message) => updates(message as MediaTag)) as MediaTag; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MediaFiles', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.media'), createEmptyInstance: create)
    ..pc<MediaFile>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'files', $pb.PbFieldType.PM, subBuilder: MediaFile.create)
    ..hasRequiredFields = false
  ;

  MediaFiles._() : super();
  factory MediaFiles({
    $core.Iterable<MediaFile>? files,
  }) {
    final _result = create();
    if (files != null) {
      _result.files.addAll(files);
    }
    return _result;
  }
  factory MediaFiles.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MediaFiles.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MediaFiles clone() => MediaFiles()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MediaFiles copyWith(void Function(MediaFiles) updates) => super.copyWith((message) => updates(message as MediaFiles)) as MediaFiles; // ignore: deprecated_member_use
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
}

class MediaFile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MediaFile', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.media'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<MediaType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: MediaType.IMAGE, valueOf: MediaType.valueOf, enumValues: MediaType.values)
    ..aOM<MediaMetadata>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', subBuilder: MediaMetadata.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'thumbnailPath')
    ..hasRequiredFields = false
  ;

  MediaFile._() : super();
  factory MediaFile({
    $core.String? id,
    $core.String? name,
    MediaType? type,
    MediaMetadata? metadata,
    $core.String? thumbnailPath,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (type != null) {
      _result.type = type;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    if (thumbnailPath != null) {
      _result.thumbnailPath = thumbnailPath;
    }
    return _result;
  }
  factory MediaFile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MediaFile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MediaFile clone() => MediaFile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MediaFile copyWith(void Function(MediaFile) updates) => super.copyWith((message) => updates(message as MediaFile)) as MediaFile; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MediaMetadata.Dimensions', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.media'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  MediaMetadata_Dimensions._() : super();
  factory MediaMetadata_Dimensions({
    $fixnum.Int64? width,
    $fixnum.Int64? height,
  }) {
    final _result = create();
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    return _result;
  }
  factory MediaMetadata_Dimensions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MediaMetadata_Dimensions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MediaMetadata_Dimensions clone() => MediaMetadata_Dimensions()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MediaMetadata_Dimensions copyWith(void Function(MediaMetadata_Dimensions) updates) => super.copyWith((message) => updates(message as MediaMetadata_Dimensions)) as MediaMetadata_Dimensions; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MediaMetadata', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.media'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourcePath')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileSize', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<MediaTag>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags', $pb.PbFieldType.PM, subBuilder: MediaTag.create)
    ..aOM<MediaMetadata_Dimensions>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dimensions', subBuilder: MediaMetadata_Dimensions.create)
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'duration', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'framerate', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'album')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'artist')
    ..hasRequiredFields = false
  ;

  MediaMetadata._() : super();
  factory MediaMetadata({
    $core.String? sourcePath,
    $fixnum.Int64? fileSize,
    $core.Iterable<MediaTag>? tags,
    MediaMetadata_Dimensions? dimensions,
    $fixnum.Int64? duration,
    $core.double? framerate,
    $core.String? album,
    $core.String? artist,
  }) {
    final _result = create();
    if (sourcePath != null) {
      _result.sourcePath = sourcePath;
    }
    if (fileSize != null) {
      _result.fileSize = fileSize;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (dimensions != null) {
      _result.dimensions = dimensions;
    }
    if (duration != null) {
      _result.duration = duration;
    }
    if (framerate != null) {
      _result.framerate = framerate;
    }
    if (album != null) {
      _result.album = album;
    }
    if (artist != null) {
      _result.artist = artist;
    }
    return _result;
  }
  factory MediaMetadata.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MediaMetadata.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MediaMetadata clone() => MediaMetadata()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MediaMetadata copyWith(void Function(MediaMetadata) updates) => super.copyWith((message) => updates(message as MediaMetadata)) as MediaMetadata; // ignore: deprecated_member_use
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
}

class GroupedMediaFiles extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupedMediaFiles', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.media'), createEmptyInstance: create)
    ..pc<MediaTagWithFiles>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags', $pb.PbFieldType.PM, subBuilder: MediaTagWithFiles.create)
    ..hasRequiredFields = false
  ;

  GroupedMediaFiles._() : super();
  factory GroupedMediaFiles({
    $core.Iterable<MediaTagWithFiles>? tags,
  }) {
    final _result = create();
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    return _result;
  }
  factory GroupedMediaFiles.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupedMediaFiles.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupedMediaFiles clone() => GroupedMediaFiles()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupedMediaFiles copyWith(void Function(GroupedMediaFiles) updates) => super.copyWith((message) => updates(message as GroupedMediaFiles)) as GroupedMediaFiles; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupedMediaFiles create() => GroupedMediaFiles._();
  GroupedMediaFiles createEmptyInstance() => create();
  static $pb.PbList<GroupedMediaFiles> createRepeated() => $pb.PbList<GroupedMediaFiles>();
  @$core.pragma('dart2js:noInline')
  static GroupedMediaFiles getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupedMediaFiles>(create);
  static GroupedMediaFiles? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MediaTagWithFiles> get tags => $_getList(0);
}

class MediaTagWithFiles extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MediaTagWithFiles', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.media'), createEmptyInstance: create)
    ..aOM<MediaTag>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tag', subBuilder: MediaTag.create)
    ..pc<MediaFile>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'files', $pb.PbFieldType.PM, subBuilder: MediaFile.create)
    ..hasRequiredFields = false
  ;

  MediaTagWithFiles._() : super();
  factory MediaTagWithFiles({
    MediaTag? tag,
    $core.Iterable<MediaFile>? files,
  }) {
    final _result = create();
    if (tag != null) {
      _result.tag = tag;
    }
    if (files != null) {
      _result.files.addAll(files);
    }
    return _result;
  }
  factory MediaTagWithFiles.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MediaTagWithFiles.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MediaTagWithFiles clone() => MediaTagWithFiles()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MediaTagWithFiles copyWith(void Function(MediaTagWithFiles) updates) => super.copyWith((message) => updates(message as MediaTagWithFiles)) as MediaTagWithFiles; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MediaTagWithFiles create() => MediaTagWithFiles._();
  MediaTagWithFiles createEmptyInstance() => create();
  static $pb.PbList<MediaTagWithFiles> createRepeated() => $pb.PbList<MediaTagWithFiles>();
  @$core.pragma('dart2js:noInline')
  static MediaTagWithFiles getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaTagWithFiles>(create);
  static MediaTagWithFiles? _defaultInstance;

  @$pb.TagNumber(1)
  MediaTag get tag => $_getN(0);
  @$pb.TagNumber(1)
  set tag(MediaTag v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTag() => $_has(0);
  @$pb.TagNumber(1)
  void clearTag() => clearField(1);
  @$pb.TagNumber(1)
  MediaTag ensureTag() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<MediaFile> get files => $_getList(1);
}

