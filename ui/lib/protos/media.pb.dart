///
//  Generated code. Do not modify.
//  source: media.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GetMediaTags extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMediaTags', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMediaRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateMediaTag', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MediaTags', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MediaTag', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MediaFiles', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MediaFile', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<MediaTag>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags', $pb.PbFieldType.PM, subBuilder: MediaTag.create)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'thumbnailUrl', protoName: 'thumbnailUrl')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contentUrl', protoName: 'contentUrl')
    ..hasRequiredFields = false
  ;

  MediaFile._() : super();
  factory MediaFile({
    $core.String? id,
    $core.String? name,
    $core.Iterable<MediaTag>? tags,
    $core.String? thumbnailUrl,
    $core.String? contentUrl,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (thumbnailUrl != null) {
      _result.thumbnailUrl = thumbnailUrl;
    }
    if (contentUrl != null) {
      _result.contentUrl = contentUrl;
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
  $core.List<MediaTag> get tags => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get thumbnailUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set thumbnailUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasThumbnailUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearThumbnailUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get contentUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set contentUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasContentUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearContentUrl() => clearField(5);
}

class GroupedMediaFiles extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupedMediaFiles', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MediaTagWithFiles', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
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

