///
//  Generated code. Do not modify.
//  source: plans.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'fixtures.pb.dart' as $0;

import 'plans.pbenum.dart';

export 'plans.pbenum.dart';

class AddPlanRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddPlanRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  AddPlanRequest._() : super();
  factory AddPlanRequest({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory AddPlanRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddPlanRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddPlanRequest clone() => AddPlanRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddPlanRequest copyWith(void Function(AddPlanRequest) updates) => super.copyWith((message) => updates(message as AddPlanRequest)) as AddPlanRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddPlanRequest create() => AddPlanRequest._();
  AddPlanRequest createEmptyInstance() => create();
  static $pb.PbList<AddPlanRequest> createRepeated() => $pb.PbList<AddPlanRequest>();
  @$core.pragma('dart2js:noInline')
  static AddPlanRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddPlanRequest>(create);
  static AddPlanRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class RemovePlanRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemovePlanRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  RemovePlanRequest._() : super();
  factory RemovePlanRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory RemovePlanRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemovePlanRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemovePlanRequest clone() => RemovePlanRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemovePlanRequest copyWith(void Function(RemovePlanRequest) updates) => super.copyWith((message) => updates(message as RemovePlanRequest)) as RemovePlanRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemovePlanRequest create() => RemovePlanRequest._();
  RemovePlanRequest createEmptyInstance() => create();
  static $pb.PbList<RemovePlanRequest> createRepeated() => $pb.PbList<RemovePlanRequest>();
  @$core.pragma('dart2js:noInline')
  static RemovePlanRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemovePlanRequest>(create);
  static RemovePlanRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class RenamePlanRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RenamePlanRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  RenamePlanRequest._() : super();
  factory RenamePlanRequest({
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
  factory RenamePlanRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenamePlanRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenamePlanRequest clone() => RenamePlanRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenamePlanRequest copyWith(void Function(RenamePlanRequest) updates) => super.copyWith((message) => updates(message as RenamePlanRequest)) as RenamePlanRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RenamePlanRequest create() => RenamePlanRequest._();
  RenamePlanRequest createEmptyInstance() => create();
  static $pb.PbList<RenamePlanRequest> createRepeated() => $pb.PbList<RenamePlanRequest>();
  @$core.pragma('dart2js:noInline')
  static RenamePlanRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RenamePlanRequest>(create);
  static RenamePlanRequest? _defaultInstance;

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

class MoveFixturesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MoveFixturesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'planId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  MoveFixturesRequest._() : super();
  factory MoveFixturesRequest({
    $core.String? planId,
    $core.int? x,
    $core.int? y,
  }) {
    final _result = create();
    if (planId != null) {
      _result.planId = planId;
    }
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    return _result;
  }
  factory MoveFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MoveFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MoveFixturesRequest clone() => MoveFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MoveFixturesRequest copyWith(void Function(MoveFixturesRequest) updates) => super.copyWith((message) => updates(message as MoveFixturesRequest)) as MoveFixturesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MoveFixturesRequest create() => MoveFixturesRequest._();
  MoveFixturesRequest createEmptyInstance() => create();
  static $pb.PbList<MoveFixturesRequest> createRepeated() => $pb.PbList<MoveFixturesRequest>();
  @$core.pragma('dart2js:noInline')
  static MoveFixturesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoveFixturesRequest>(create);
  static MoveFixturesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get planId => $_getSZ(0);
  @$pb.TagNumber(1)
  set planId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlanId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get x => $_getIZ(1);
  @$pb.TagNumber(2)
  set x($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasX() => $_has(1);
  @$pb.TagNumber(2)
  void clearX() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get y => $_getIZ(2);
  @$pb.TagNumber(3)
  set y($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasY() => $_has(2);
  @$pb.TagNumber(3)
  void clearY() => clearField(3);
}

class AlignFixturesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AlignFixturesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'planId')
    ..e<AlignFixturesRequest_AlignDirection>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: AlignFixturesRequest_AlignDirection.LEFT_TO_RIGHT, valueOf: AlignFixturesRequest_AlignDirection.valueOf, enumValues: AlignFixturesRequest_AlignDirection.values)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groups', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rowGap', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'columnGap', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  AlignFixturesRequest._() : super();
  factory AlignFixturesRequest({
    $core.String? planId,
    AlignFixturesRequest_AlignDirection? direction,
    $core.int? groups,
    $core.int? rowGap,
    $core.int? columnGap,
  }) {
    final _result = create();
    if (planId != null) {
      _result.planId = planId;
    }
    if (direction != null) {
      _result.direction = direction;
    }
    if (groups != null) {
      _result.groups = groups;
    }
    if (rowGap != null) {
      _result.rowGap = rowGap;
    }
    if (columnGap != null) {
      _result.columnGap = columnGap;
    }
    return _result;
  }
  factory AlignFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AlignFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AlignFixturesRequest clone() => AlignFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AlignFixturesRequest copyWith(void Function(AlignFixturesRequest) updates) => super.copyWith((message) => updates(message as AlignFixturesRequest)) as AlignFixturesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AlignFixturesRequest create() => AlignFixturesRequest._();
  AlignFixturesRequest createEmptyInstance() => create();
  static $pb.PbList<AlignFixturesRequest> createRepeated() => $pb.PbList<AlignFixturesRequest>();
  @$core.pragma('dart2js:noInline')
  static AlignFixturesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AlignFixturesRequest>(create);
  static AlignFixturesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get planId => $_getSZ(0);
  @$pb.TagNumber(1)
  set planId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlanId() => clearField(1);

  @$pb.TagNumber(2)
  AlignFixturesRequest_AlignDirection get direction => $_getN(1);
  @$pb.TagNumber(2)
  set direction(AlignFixturesRequest_AlignDirection v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDirection() => $_has(1);
  @$pb.TagNumber(2)
  void clearDirection() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get groups => $_getIZ(2);
  @$pb.TagNumber(3)
  set groups($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGroups() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroups() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get rowGap => $_getIZ(3);
  @$pb.TagNumber(4)
  set rowGap($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRowGap() => $_has(3);
  @$pb.TagNumber(4)
  void clearRowGap() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get columnGap => $_getIZ(4);
  @$pb.TagNumber(5)
  set columnGap($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasColumnGap() => $_has(4);
  @$pb.TagNumber(5)
  void clearColumnGap() => clearField(5);
}

class MoveFixtureRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MoveFixtureRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'planId')
    ..aOM<$0.FixtureId>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtureId', subBuilder: $0.FixtureId.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  MoveFixtureRequest._() : super();
  factory MoveFixtureRequest({
    $core.String? planId,
    $0.FixtureId? fixtureId,
    $core.int? x,
    $core.int? y,
  }) {
    final _result = create();
    if (planId != null) {
      _result.planId = planId;
    }
    if (fixtureId != null) {
      _result.fixtureId = fixtureId;
    }
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    return _result;
  }
  factory MoveFixtureRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MoveFixtureRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MoveFixtureRequest clone() => MoveFixtureRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MoveFixtureRequest copyWith(void Function(MoveFixtureRequest) updates) => super.copyWith((message) => updates(message as MoveFixtureRequest)) as MoveFixtureRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MoveFixtureRequest create() => MoveFixtureRequest._();
  MoveFixtureRequest createEmptyInstance() => create();
  static $pb.PbList<MoveFixtureRequest> createRepeated() => $pb.PbList<MoveFixtureRequest>();
  @$core.pragma('dart2js:noInline')
  static MoveFixtureRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoveFixtureRequest>(create);
  static MoveFixtureRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get planId => $_getSZ(0);
  @$pb.TagNumber(1)
  set planId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlanId() => clearField(1);

  @$pb.TagNumber(2)
  $0.FixtureId get fixtureId => $_getN(1);
  @$pb.TagNumber(2)
  set fixtureId($0.FixtureId v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasFixtureId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFixtureId() => clearField(2);
  @$pb.TagNumber(2)
  $0.FixtureId ensureFixtureId() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get x => $_getIZ(2);
  @$pb.TagNumber(3)
  set x($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasX() => $_has(2);
  @$pb.TagNumber(3)
  void clearX() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get y => $_getIZ(3);
  @$pb.TagNumber(4)
  set y($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasY() => $_has(3);
  @$pb.TagNumber(4)
  void clearY() => clearField(4);
}

class AddImageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddImageRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'planId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transparency', $pb.PbFieldType.OD)
    ..a<$core.List<$core.int>>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  AddImageRequest._() : super();
  factory AddImageRequest({
    $core.String? planId,
    $core.double? x,
    $core.double? y,
    $core.double? width,
    $core.double? height,
    $core.double? transparency,
    $core.List<$core.int>? data,
  }) {
    final _result = create();
    if (planId != null) {
      _result.planId = planId;
    }
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    if (transparency != null) {
      _result.transparency = transparency;
    }
    if (data != null) {
      _result.data = data;
    }
    return _result;
  }
  factory AddImageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddImageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddImageRequest clone() => AddImageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddImageRequest copyWith(void Function(AddImageRequest) updates) => super.copyWith((message) => updates(message as AddImageRequest)) as AddImageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddImageRequest create() => AddImageRequest._();
  AddImageRequest createEmptyInstance() => create();
  static $pb.PbList<AddImageRequest> createRepeated() => $pb.PbList<AddImageRequest>();
  @$core.pragma('dart2js:noInline')
  static AddImageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddImageRequest>(create);
  static AddImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get planId => $_getSZ(0);
  @$pb.TagNumber(1)
  set planId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlanId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get x => $_getN(1);
  @$pb.TagNumber(2)
  set x($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasX() => $_has(1);
  @$pb.TagNumber(2)
  void clearX() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get y => $_getN(2);
  @$pb.TagNumber(3)
  set y($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasY() => $_has(2);
  @$pb.TagNumber(3)
  void clearY() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get width => $_getN(3);
  @$pb.TagNumber(4)
  set width($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasWidth() => $_has(3);
  @$pb.TagNumber(4)
  void clearWidth() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get height => $_getN(4);
  @$pb.TagNumber(5)
  set height($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHeight() => $_has(4);
  @$pb.TagNumber(5)
  void clearHeight() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get transparency => $_getN(5);
  @$pb.TagNumber(6)
  set transparency($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransparency() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransparency() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.int> get data => $_getN(6);
  @$pb.TagNumber(7)
  set data($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasData() => $_has(6);
  @$pb.TagNumber(7)
  void clearData() => clearField(7);
}

class MoveImageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MoveImageRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'planId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  MoveImageRequest._() : super();
  factory MoveImageRequest({
    $core.String? planId,
    $core.String? imageId,
    $core.double? x,
    $core.double? y,
  }) {
    final _result = create();
    if (planId != null) {
      _result.planId = planId;
    }
    if (imageId != null) {
      _result.imageId = imageId;
    }
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    return _result;
  }
  factory MoveImageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MoveImageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MoveImageRequest clone() => MoveImageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MoveImageRequest copyWith(void Function(MoveImageRequest) updates) => super.copyWith((message) => updates(message as MoveImageRequest)) as MoveImageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MoveImageRequest create() => MoveImageRequest._();
  MoveImageRequest createEmptyInstance() => create();
  static $pb.PbList<MoveImageRequest> createRepeated() => $pb.PbList<MoveImageRequest>();
  @$core.pragma('dart2js:noInline')
  static MoveImageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoveImageRequest>(create);
  static MoveImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get planId => $_getSZ(0);
  @$pb.TagNumber(1)
  set planId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlanId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get imageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set imageId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasImageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get x => $_getN(2);
  @$pb.TagNumber(3)
  set x($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasX() => $_has(2);
  @$pb.TagNumber(3)
  void clearX() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get y => $_getN(3);
  @$pb.TagNumber(4)
  set y($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasY() => $_has(3);
  @$pb.TagNumber(4)
  void clearY() => clearField(4);
}

class ResizeImageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResizeImageRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'planId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ResizeImageRequest._() : super();
  factory ResizeImageRequest({
    $core.String? planId,
    $core.String? imageId,
    $core.double? width,
    $core.double? height,
  }) {
    final _result = create();
    if (planId != null) {
      _result.planId = planId;
    }
    if (imageId != null) {
      _result.imageId = imageId;
    }
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    return _result;
  }
  factory ResizeImageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResizeImageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResizeImageRequest clone() => ResizeImageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResizeImageRequest copyWith(void Function(ResizeImageRequest) updates) => super.copyWith((message) => updates(message as ResizeImageRequest)) as ResizeImageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResizeImageRequest create() => ResizeImageRequest._();
  ResizeImageRequest createEmptyInstance() => create();
  static $pb.PbList<ResizeImageRequest> createRepeated() => $pb.PbList<ResizeImageRequest>();
  @$core.pragma('dart2js:noInline')
  static ResizeImageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResizeImageRequest>(create);
  static ResizeImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get planId => $_getSZ(0);
  @$pb.TagNumber(1)
  set planId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlanId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get imageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set imageId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasImageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get width => $_getN(2);
  @$pb.TagNumber(3)
  set width($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWidth() => $_has(2);
  @$pb.TagNumber(3)
  void clearWidth() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get height => $_getN(3);
  @$pb.TagNumber(4)
  set height($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearHeight() => clearField(4);
}

class RemoveImageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveImageRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'planId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageId')
    ..hasRequiredFields = false
  ;

  RemoveImageRequest._() : super();
  factory RemoveImageRequest({
    $core.String? planId,
    $core.String? imageId,
  }) {
    final _result = create();
    if (planId != null) {
      _result.planId = planId;
    }
    if (imageId != null) {
      _result.imageId = imageId;
    }
    return _result;
  }
  factory RemoveImageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveImageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveImageRequest clone() => RemoveImageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveImageRequest copyWith(void Function(RemoveImageRequest) updates) => super.copyWith((message) => updates(message as RemoveImageRequest)) as RemoveImageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveImageRequest create() => RemoveImageRequest._();
  RemoveImageRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveImageRequest> createRepeated() => $pb.PbList<RemoveImageRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveImageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveImageRequest>(create);
  static RemoveImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get planId => $_getSZ(0);
  @$pb.TagNumber(1)
  set planId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlanId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get imageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set imageId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasImageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageId() => clearField(2);
}

class Plans extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Plans', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..pc<Plan>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'plans', $pb.PbFieldType.PM, subBuilder: Plan.create)
    ..hasRequiredFields = false
  ;

  Plans._() : super();
  factory Plans({
    $core.Iterable<Plan>? plans,
  }) {
    final _result = create();
    if (plans != null) {
      _result.plans.addAll(plans);
    }
    return _result;
  }
  factory Plans.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Plans.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Plans clone() => Plans()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Plans copyWith(void Function(Plans) updates) => super.copyWith((message) => updates(message as Plans)) as Plans; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Plans create() => Plans._();
  Plans createEmptyInstance() => create();
  static $pb.PbList<Plans> createRepeated() => $pb.PbList<Plans>();
  @$core.pragma('dart2js:noInline')
  static Plans getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Plans>(create);
  static Plans? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Plan> get plans => $_getList(0);
}

class Plan extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Plan', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<FixturePosition>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'positions', $pb.PbFieldType.PM, subBuilder: FixturePosition.create)
    ..pc<PlanScreen>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'screens', $pb.PbFieldType.PM, subBuilder: PlanScreen.create)
    ..pc<PlanImage>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'images', $pb.PbFieldType.PM, subBuilder: PlanImage.create)
    ..hasRequiredFields = false
  ;

  Plan._() : super();
  factory Plan({
    $core.String? name,
    $core.Iterable<FixturePosition>? positions,
    $core.Iterable<PlanScreen>? screens,
    $core.Iterable<PlanImage>? images,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (positions != null) {
      _result.positions.addAll(positions);
    }
    if (screens != null) {
      _result.screens.addAll(screens);
    }
    if (images != null) {
      _result.images.addAll(images);
    }
    return _result;
  }
  factory Plan.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Plan.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Plan clone() => Plan()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Plan copyWith(void Function(Plan) updates) => super.copyWith((message) => updates(message as Plan)) as Plan; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Plan create() => Plan._();
  Plan createEmptyInstance() => create();
  static $pb.PbList<Plan> createRepeated() => $pb.PbList<Plan>();
  @$core.pragma('dart2js:noInline')
  static Plan getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Plan>(create);
  static Plan? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<FixturePosition> get positions => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<PlanScreen> get screens => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<PlanImage> get images => $_getList(3);
}

class FixturePosition extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixturePosition', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOM<$0.FixtureId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', subBuilder: $0.FixtureId.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  FixturePosition._() : super();
  factory FixturePosition({
    $0.FixtureId? id,
    $core.int? x,
    $core.int? y,
    $core.int? width,
    $core.int? height,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    return _result;
  }
  factory FixturePosition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixturePosition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixturePosition clone() => FixturePosition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixturePosition copyWith(void Function(FixturePosition) updates) => super.copyWith((message) => updates(message as FixturePosition)) as FixturePosition; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixturePosition create() => FixturePosition._();
  FixturePosition createEmptyInstance() => create();
  static $pb.PbList<FixturePosition> createRepeated() => $pb.PbList<FixturePosition>();
  @$core.pragma('dart2js:noInline')
  static FixturePosition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixturePosition>(create);
  static FixturePosition? _defaultInstance;

  @$pb.TagNumber(1)
  $0.FixtureId get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($0.FixtureId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
  @$pb.TagNumber(1)
  $0.FixtureId ensureId() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get x => $_getIZ(1);
  @$pb.TagNumber(2)
  set x($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasX() => $_has(1);
  @$pb.TagNumber(2)
  void clearX() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get y => $_getIZ(2);
  @$pb.TagNumber(3)
  set y($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasY() => $_has(2);
  @$pb.TagNumber(3)
  void clearY() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get width => $_getIZ(3);
  @$pb.TagNumber(4)
  set width($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasWidth() => $_has(3);
  @$pb.TagNumber(4)
  void clearWidth() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get height => $_getIZ(4);
  @$pb.TagNumber(5)
  set height($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHeight() => $_has(4);
  @$pb.TagNumber(5)
  void clearHeight() => clearField(5);
}

class PlanScreen extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PlanScreen', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  PlanScreen._() : super();
  factory PlanScreen({
    $core.int? id,
    $core.int? x,
    $core.int? y,
    $core.int? width,
    $core.int? height,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    return _result;
  }
  factory PlanScreen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlanScreen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlanScreen clone() => PlanScreen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlanScreen copyWith(void Function(PlanScreen) updates) => super.copyWith((message) => updates(message as PlanScreen)) as PlanScreen; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlanScreen create() => PlanScreen._();
  PlanScreen createEmptyInstance() => create();
  static $pb.PbList<PlanScreen> createRepeated() => $pb.PbList<PlanScreen>();
  @$core.pragma('dart2js:noInline')
  static PlanScreen getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlanScreen>(create);
  static PlanScreen? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get x => $_getIZ(1);
  @$pb.TagNumber(2)
  set x($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasX() => $_has(1);
  @$pb.TagNumber(2)
  void clearX() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get y => $_getIZ(2);
  @$pb.TagNumber(3)
  set y($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasY() => $_has(2);
  @$pb.TagNumber(3)
  void clearY() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get width => $_getIZ(3);
  @$pb.TagNumber(4)
  set width($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasWidth() => $_has(3);
  @$pb.TagNumber(4)
  void clearWidth() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get height => $_getIZ(4);
  @$pb.TagNumber(5)
  set height($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHeight() => $_has(4);
  @$pb.TagNumber(5)
  void clearHeight() => clearField(5);
}

class PlanImage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PlanImage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transparency', $pb.PbFieldType.OD)
    ..a<$core.List<$core.int>>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  PlanImage._() : super();
  factory PlanImage({
    $core.String? id,
    $core.double? x,
    $core.double? y,
    $core.double? width,
    $core.double? height,
    $core.double? transparency,
    $core.List<$core.int>? data,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    if (transparency != null) {
      _result.transparency = transparency;
    }
    if (data != null) {
      _result.data = data;
    }
    return _result;
  }
  factory PlanImage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlanImage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlanImage clone() => PlanImage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlanImage copyWith(void Function(PlanImage) updates) => super.copyWith((message) => updates(message as PlanImage)) as PlanImage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlanImage create() => PlanImage._();
  PlanImage createEmptyInstance() => create();
  static $pb.PbList<PlanImage> createRepeated() => $pb.PbList<PlanImage>();
  @$core.pragma('dart2js:noInline')
  static PlanImage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlanImage>(create);
  static PlanImage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get x => $_getN(1);
  @$pb.TagNumber(2)
  set x($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasX() => $_has(1);
  @$pb.TagNumber(2)
  void clearX() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get y => $_getN(2);
  @$pb.TagNumber(3)
  set y($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasY() => $_has(2);
  @$pb.TagNumber(3)
  void clearY() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get width => $_getN(3);
  @$pb.TagNumber(4)
  set width($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasWidth() => $_has(3);
  @$pb.TagNumber(4)
  void clearWidth() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get height => $_getN(4);
  @$pb.TagNumber(5)
  set height($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHeight() => $_has(4);
  @$pb.TagNumber(5)
  void clearHeight() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get transparency => $_getN(5);
  @$pb.TagNumber(6)
  set transparency($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransparency() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransparency() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.int> get data => $_getN(6);
  @$pb.TagNumber(7)
  set data($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasData() => $_has(6);
  @$pb.TagNumber(7)
  void clearData() => clearField(7);
}

