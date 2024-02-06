//
//  Generated code. Do not modify.
//  source: plans.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'fixtures.pb.dart' as $0;
import 'plans.pbenum.dart';

export 'plans.pbenum.dart';

class AddPlanRequest extends $pb.GeneratedMessage {
  factory AddPlanRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  AddPlanRequest._() : super();
  factory AddPlanRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddPlanRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddPlanRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddPlanRequest clone() => AddPlanRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddPlanRequest copyWith(void Function(AddPlanRequest) updates) => super.copyWith((message) => updates(message as AddPlanRequest)) as AddPlanRequest;

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
  factory RemovePlanRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  RemovePlanRequest._() : super();
  factory RemovePlanRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemovePlanRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemovePlanRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemovePlanRequest clone() => RemovePlanRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemovePlanRequest copyWith(void Function(RemovePlanRequest) updates) => super.copyWith((message) => updates(message as RemovePlanRequest)) as RemovePlanRequest;

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
  factory RenamePlanRequest({
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
  RenamePlanRequest._() : super();
  factory RenamePlanRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenamePlanRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RenamePlanRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenamePlanRequest clone() => RenamePlanRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenamePlanRequest copyWith(void Function(RenamePlanRequest) updates) => super.copyWith((message) => updates(message as RenamePlanRequest)) as RenamePlanRequest;

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
  factory MoveFixturesRequest({
    $core.String? planId,
    $core.double? x,
    $core.double? y,
  }) {
    final $result = create();
    if (planId != null) {
      $result.planId = planId;
    }
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    return $result;
  }
  MoveFixturesRequest._() : super();
  factory MoveFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MoveFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MoveFixturesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'planId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MoveFixturesRequest clone() => MoveFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MoveFixturesRequest copyWith(void Function(MoveFixturesRequest) updates) => super.copyWith((message) => updates(message as MoveFixturesRequest)) as MoveFixturesRequest;

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
}

class AlignFixturesRequest extends $pb.GeneratedMessage {
  factory AlignFixturesRequest({
    $core.String? planId,
    AlignFixturesRequest_AlignDirection? direction,
    $core.int? groups,
    $core.int? rowGap,
    $core.int? columnGap,
  }) {
    final $result = create();
    if (planId != null) {
      $result.planId = planId;
    }
    if (direction != null) {
      $result.direction = direction;
    }
    if (groups != null) {
      $result.groups = groups;
    }
    if (rowGap != null) {
      $result.rowGap = rowGap;
    }
    if (columnGap != null) {
      $result.columnGap = columnGap;
    }
    return $result;
  }
  AlignFixturesRequest._() : super();
  factory AlignFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AlignFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AlignFixturesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'planId')
    ..e<AlignFixturesRequest_AlignDirection>(2, _omitFieldNames ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: AlignFixturesRequest_AlignDirection.LEFT_TO_RIGHT, valueOf: AlignFixturesRequest_AlignDirection.valueOf, enumValues: AlignFixturesRequest_AlignDirection.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'groups', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'rowGap', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'columnGap', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AlignFixturesRequest clone() => AlignFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AlignFixturesRequest copyWith(void Function(AlignFixturesRequest) updates) => super.copyWith((message) => updates(message as AlignFixturesRequest)) as AlignFixturesRequest;

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
  factory MoveFixtureRequest({
    $core.String? planId,
    $0.FixtureId? fixtureId,
    $core.double? x,
    $core.double? y,
  }) {
    final $result = create();
    if (planId != null) {
      $result.planId = planId;
    }
    if (fixtureId != null) {
      $result.fixtureId = fixtureId;
    }
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    return $result;
  }
  MoveFixtureRequest._() : super();
  factory MoveFixtureRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MoveFixtureRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MoveFixtureRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'planId')
    ..aOM<$0.FixtureId>(2, _omitFieldNames ? '' : 'fixtureId', subBuilder: $0.FixtureId.create)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MoveFixtureRequest clone() => MoveFixtureRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MoveFixtureRequest copyWith(void Function(MoveFixtureRequest) updates) => super.copyWith((message) => updates(message as MoveFixtureRequest)) as MoveFixtureRequest;

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

class AddImageRequest extends $pb.GeneratedMessage {
  factory AddImageRequest({
    $core.String? planId,
    $core.double? x,
    $core.double? y,
    $core.double? width,
    $core.double? height,
    $core.double? transparency,
    $core.List<$core.int>? data,
  }) {
    final $result = create();
    if (planId != null) {
      $result.planId = planId;
    }
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (width != null) {
      $result.width = width;
    }
    if (height != null) {
      $result.height = height;
    }
    if (transparency != null) {
      $result.transparency = transparency;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  AddImageRequest._() : super();
  factory AddImageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddImageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddImageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'planId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'width', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'transparency', $pb.PbFieldType.OD)
    ..a<$core.List<$core.int>>(7, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddImageRequest clone() => AddImageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddImageRequest copyWith(void Function(AddImageRequest) updates) => super.copyWith((message) => updates(message as AddImageRequest)) as AddImageRequest;

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
  factory MoveImageRequest({
    $core.String? planId,
    $core.String? imageId,
    $core.double? x,
    $core.double? y,
  }) {
    final $result = create();
    if (planId != null) {
      $result.planId = planId;
    }
    if (imageId != null) {
      $result.imageId = imageId;
    }
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    return $result;
  }
  MoveImageRequest._() : super();
  factory MoveImageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MoveImageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MoveImageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'planId')
    ..aOS(2, _omitFieldNames ? '' : 'imageId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MoveImageRequest clone() => MoveImageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MoveImageRequest copyWith(void Function(MoveImageRequest) updates) => super.copyWith((message) => updates(message as MoveImageRequest)) as MoveImageRequest;

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
  factory ResizeImageRequest({
    $core.String? planId,
    $core.String? imageId,
    $core.double? width,
    $core.double? height,
  }) {
    final $result = create();
    if (planId != null) {
      $result.planId = planId;
    }
    if (imageId != null) {
      $result.imageId = imageId;
    }
    if (width != null) {
      $result.width = width;
    }
    if (height != null) {
      $result.height = height;
    }
    return $result;
  }
  ResizeImageRequest._() : super();
  factory ResizeImageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResizeImageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResizeImageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'planId')
    ..aOS(2, _omitFieldNames ? '' : 'imageId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'width', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResizeImageRequest clone() => ResizeImageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResizeImageRequest copyWith(void Function(ResizeImageRequest) updates) => super.copyWith((message) => updates(message as ResizeImageRequest)) as ResizeImageRequest;

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
  factory RemoveImageRequest({
    $core.String? planId,
    $core.String? imageId,
  }) {
    final $result = create();
    if (planId != null) {
      $result.planId = planId;
    }
    if (imageId != null) {
      $result.imageId = imageId;
    }
    return $result;
  }
  RemoveImageRequest._() : super();
  factory RemoveImageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveImageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveImageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'planId')
    ..aOS(2, _omitFieldNames ? '' : 'imageId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveImageRequest clone() => RemoveImageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveImageRequest copyWith(void Function(RemoveImageRequest) updates) => super.copyWith((message) => updates(message as RemoveImageRequest)) as RemoveImageRequest;

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
  factory Plans({
    $core.Iterable<Plan>? plans,
  }) {
    final $result = create();
    if (plans != null) {
      $result.plans.addAll(plans);
    }
    return $result;
  }
  Plans._() : super();
  factory Plans.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Plans.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Plans', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..pc<Plan>(1, _omitFieldNames ? '' : 'plans', $pb.PbFieldType.PM, subBuilder: Plan.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Plans clone() => Plans()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Plans copyWith(void Function(Plans) updates) => super.copyWith((message) => updates(message as Plans)) as Plans;

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
  factory Plan({
    $core.String? name,
    $core.Iterable<FixturePosition>? positions,
    $core.Iterable<PlanScreen>? screens,
    $core.Iterable<PlanImage>? images,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (positions != null) {
      $result.positions.addAll(positions);
    }
    if (screens != null) {
      $result.screens.addAll(screens);
    }
    if (images != null) {
      $result.images.addAll(images);
    }
    return $result;
  }
  Plan._() : super();
  factory Plan.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Plan.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Plan', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<FixturePosition>(2, _omitFieldNames ? '' : 'positions', $pb.PbFieldType.PM, subBuilder: FixturePosition.create)
    ..pc<PlanScreen>(3, _omitFieldNames ? '' : 'screens', $pb.PbFieldType.PM, subBuilder: PlanScreen.create)
    ..pc<PlanImage>(4, _omitFieldNames ? '' : 'images', $pb.PbFieldType.PM, subBuilder: PlanImage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Plan clone() => Plan()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Plan copyWith(void Function(Plan) updates) => super.copyWith((message) => updates(message as Plan)) as Plan;

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
  factory FixturePosition({
    $0.FixtureId? id,
    $core.double? x,
    $core.double? y,
    $core.double? width,
    $core.double? height,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (width != null) {
      $result.width = width;
    }
    if (height != null) {
      $result.height = height;
    }
    return $result;
  }
  FixturePosition._() : super();
  factory FixturePosition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixturePosition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixturePosition', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOM<$0.FixtureId>(1, _omitFieldNames ? '' : 'id', subBuilder: $0.FixtureId.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'width', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixturePosition clone() => FixturePosition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixturePosition copyWith(void Function(FixturePosition) updates) => super.copyWith((message) => updates(message as FixturePosition)) as FixturePosition;

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
}

class PlanScreen extends $pb.GeneratedMessage {
  factory PlanScreen({
    $core.int? id,
    $core.int? x,
    $core.int? y,
    $core.int? width,
    $core.int? height,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (width != null) {
      $result.width = width;
    }
    if (height != null) {
      $result.height = height;
    }
    return $result;
  }
  PlanScreen._() : super();
  factory PlanScreen.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlanScreen.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlanScreen', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'x', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'y', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'width', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlanScreen clone() => PlanScreen()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlanScreen copyWith(void Function(PlanScreen) updates) => super.copyWith((message) => updates(message as PlanScreen)) as PlanScreen;

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
  factory PlanImage({
    $core.String? id,
    $core.double? x,
    $core.double? y,
    $core.double? width,
    $core.double? height,
    $core.double? transparency,
    $core.List<$core.int>? data,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (width != null) {
      $result.width = width;
    }
    if (height != null) {
      $result.height = height;
    }
    if (transparency != null) {
      $result.transparency = transparency;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  PlanImage._() : super();
  factory PlanImage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlanImage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlanImage', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.plans'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'width', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'transparency', $pb.PbFieldType.OD)
    ..a<$core.List<$core.int>>(7, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlanImage clone() => PlanImage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlanImage copyWith(void Function(PlanImage) updates) => super.copyWith((message) => updates(message as PlanImage)) as PlanImage;

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
