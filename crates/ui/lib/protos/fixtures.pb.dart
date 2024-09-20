//
//  Generated code. Do not modify.
//  source: fixtures.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'fixtures.pbenum.dart';

export 'fixtures.pbenum.dart';

class AddFixturesRequest extends $pb.GeneratedMessage {
  factory AddFixturesRequest({
    AddFixtureRequest? request,
    $core.int? count,
  }) {
    final $result = create();
    if (request != null) {
      $result.request = request;
    }
    if (count != null) {
      $result.count = count;
    }
    return $result;
  }
  AddFixturesRequest._() : super();
  factory AddFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddFixturesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOM<AddFixtureRequest>(1, _omitFieldNames ? '' : 'request', subBuilder: AddFixtureRequest.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'count', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddFixturesRequest clone() => AddFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddFixturesRequest copyWith(void Function(AddFixturesRequest) updates) => super.copyWith((message) => updates(message as AddFixturesRequest)) as AddFixturesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddFixturesRequest create() => AddFixturesRequest._();
  AddFixturesRequest createEmptyInstance() => create();
  static $pb.PbList<AddFixturesRequest> createRepeated() => $pb.PbList<AddFixturesRequest>();
  @$core.pragma('dart2js:noInline')
  static AddFixturesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddFixturesRequest>(create);
  static AddFixturesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  AddFixtureRequest get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(AddFixtureRequest v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => clearField(1);
  @$pb.TagNumber(1)
  AddFixtureRequest ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get count => $_getIZ(1);
  @$pb.TagNumber(2)
  set count($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCount() => clearField(2);
}

class AddFixtureRequest extends $pb.GeneratedMessage {
  factory AddFixtureRequest({
    $core.String? definitionId,
    $core.String? mode,
    $core.int? id,
    $core.int? channel,
    $core.int? universe,
    $core.String? name,
  }) {
    final $result = create();
    if (definitionId != null) {
      $result.definitionId = definitionId;
    }
    if (mode != null) {
      $result.mode = mode;
    }
    if (id != null) {
      $result.id = id;
    }
    if (channel != null) {
      $result.channel = channel;
    }
    if (universe != null) {
      $result.universe = universe;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  AddFixtureRequest._() : super();
  factory AddFixtureRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddFixtureRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddFixtureRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'definitionId')
    ..aOS(2, _omitFieldNames ? '' : 'mode')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'channel', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'universe', $pb.PbFieldType.OU3)
    ..aOS(6, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddFixtureRequest clone() => AddFixtureRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddFixtureRequest copyWith(void Function(AddFixtureRequest) updates) => super.copyWith((message) => updates(message as AddFixtureRequest)) as AddFixtureRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddFixtureRequest create() => AddFixtureRequest._();
  AddFixtureRequest createEmptyInstance() => create();
  static $pb.PbList<AddFixtureRequest> createRepeated() => $pb.PbList<AddFixtureRequest>();
  @$core.pragma('dart2js:noInline')
  static AddFixtureRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddFixtureRequest>(create);
  static AddFixtureRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get definitionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set definitionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDefinitionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDefinitionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get mode => $_getSZ(1);
  @$pb.TagNumber(2)
  set mode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearMode() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get id => $_getIZ(2);
  @$pb.TagNumber(3)
  set id($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasId() => $_has(2);
  @$pb.TagNumber(3)
  void clearId() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get channel => $_getIZ(3);
  @$pb.TagNumber(4)
  set channel($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasChannel() => $_has(3);
  @$pb.TagNumber(4)
  void clearChannel() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get universe => $_getIZ(4);
  @$pb.TagNumber(5)
  set universe($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUniverse() => $_has(4);
  @$pb.TagNumber(5)
  void clearUniverse() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get name => $_getSZ(5);
  @$pb.TagNumber(6)
  set name($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasName() => $_has(5);
  @$pb.TagNumber(6)
  void clearName() => clearField(6);
}

class GetFixturesRequest extends $pb.GeneratedMessage {
  factory GetFixturesRequest() => create();
  GetFixturesRequest._() : super();
  factory GetFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFixturesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFixturesRequest clone() => GetFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFixturesRequest copyWith(void Function(GetFixturesRequest) updates) => super.copyWith((message) => updates(message as GetFixturesRequest)) as GetFixturesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFixturesRequest create() => GetFixturesRequest._();
  GetFixturesRequest createEmptyInstance() => create();
  static $pb.PbList<GetFixturesRequest> createRepeated() => $pb.PbList<GetFixturesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFixturesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFixturesRequest>(create);
  static GetFixturesRequest? _defaultInstance;
}

class DeleteFixturesRequest extends $pb.GeneratedMessage {
  factory DeleteFixturesRequest({
    $core.Iterable<$core.int>? fixtureIds,
  }) {
    final $result = create();
    if (fixtureIds != null) {
      $result.fixtureIds.addAll(fixtureIds);
    }
    return $result;
  }
  DeleteFixturesRequest._() : super();
  factory DeleteFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteFixturesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'fixtureIds', $pb.PbFieldType.KU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteFixturesRequest clone() => DeleteFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteFixturesRequest copyWith(void Function(DeleteFixturesRequest) updates) => super.copyWith((message) => updates(message as DeleteFixturesRequest)) as DeleteFixturesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteFixturesRequest create() => DeleteFixturesRequest._();
  DeleteFixturesRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteFixturesRequest> createRepeated() => $pb.PbList<DeleteFixturesRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteFixturesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteFixturesRequest>(create);
  static DeleteFixturesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get fixtureIds => $_getList(0);
}

class UpdateFixtureRequest_UpdateFixtureLimit extends $pb.GeneratedMessage {
  factory UpdateFixtureRequest_UpdateFixtureLimit({
    $core.String? channel,
    $core.double? min,
    $core.double? max,
  }) {
    final $result = create();
    if (channel != null) {
      $result.channel = channel;
    }
    if (min != null) {
      $result.min = min;
    }
    if (max != null) {
      $result.max = max;
    }
    return $result;
  }
  UpdateFixtureRequest_UpdateFixtureLimit._() : super();
  factory UpdateFixtureRequest_UpdateFixtureLimit.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFixtureRequest_UpdateFixtureLimit.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateFixtureRequest.UpdateFixtureLimit', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channel')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'min', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'max', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFixtureRequest_UpdateFixtureLimit clone() => UpdateFixtureRequest_UpdateFixtureLimit()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFixtureRequest_UpdateFixtureLimit copyWith(void Function(UpdateFixtureRequest_UpdateFixtureLimit) updates) => super.copyWith((message) => updates(message as UpdateFixtureRequest_UpdateFixtureLimit)) as UpdateFixtureRequest_UpdateFixtureLimit;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFixtureRequest_UpdateFixtureLimit create() => UpdateFixtureRequest_UpdateFixtureLimit._();
  UpdateFixtureRequest_UpdateFixtureLimit createEmptyInstance() => create();
  static $pb.PbList<UpdateFixtureRequest_UpdateFixtureLimit> createRepeated() => $pb.PbList<UpdateFixtureRequest_UpdateFixtureLimit>();
  @$core.pragma('dart2js:noInline')
  static UpdateFixtureRequest_UpdateFixtureLimit getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFixtureRequest_UpdateFixtureLimit>(create);
  static UpdateFixtureRequest_UpdateFixtureLimit? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channel => $_getSZ(0);
  @$pb.TagNumber(1)
  set channel($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get min => $_getN(1);
  @$pb.TagNumber(2)
  set min($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMin() => $_has(1);
  @$pb.TagNumber(2)
  void clearMin() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get max => $_getN(2);
  @$pb.TagNumber(3)
  set max($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMax() => $_has(2);
  @$pb.TagNumber(3)
  void clearMax() => clearField(3);
}

class UpdateFixtureRequest extends $pb.GeneratedMessage {
  factory UpdateFixtureRequest({
    $core.int? fixtureId,
    $core.bool? invertPan,
    $core.bool? invertTilt,
    $core.bool? reversePixelOrder,
    $core.String? name,
    FixtureAddress? address,
    UpdateFixtureRequest_UpdateFixtureLimit? limit,
  }) {
    final $result = create();
    if (fixtureId != null) {
      $result.fixtureId = fixtureId;
    }
    if (invertPan != null) {
      $result.invertPan = invertPan;
    }
    if (invertTilt != null) {
      $result.invertTilt = invertTilt;
    }
    if (reversePixelOrder != null) {
      $result.reversePixelOrder = reversePixelOrder;
    }
    if (name != null) {
      $result.name = name;
    }
    if (address != null) {
      $result.address = address;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  UpdateFixtureRequest._() : super();
  factory UpdateFixtureRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFixtureRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateFixtureRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'fixtureId', $pb.PbFieldType.OU3)
    ..aOB(2, _omitFieldNames ? '' : 'invertPan')
    ..aOB(3, _omitFieldNames ? '' : 'invertTilt')
    ..aOB(4, _omitFieldNames ? '' : 'reversePixelOrder')
    ..aOS(5, _omitFieldNames ? '' : 'name')
    ..aOM<FixtureAddress>(6, _omitFieldNames ? '' : 'address', subBuilder: FixtureAddress.create)
    ..aOM<UpdateFixtureRequest_UpdateFixtureLimit>(7, _omitFieldNames ? '' : 'limit', subBuilder: UpdateFixtureRequest_UpdateFixtureLimit.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFixtureRequest clone() => UpdateFixtureRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFixtureRequest copyWith(void Function(UpdateFixtureRequest) updates) => super.copyWith((message) => updates(message as UpdateFixtureRequest)) as UpdateFixtureRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFixtureRequest create() => UpdateFixtureRequest._();
  UpdateFixtureRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateFixtureRequest> createRepeated() => $pb.PbList<UpdateFixtureRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateFixtureRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFixtureRequest>(create);
  static UpdateFixtureRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get fixtureId => $_getIZ(0);
  @$pb.TagNumber(1)
  set fixtureId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFixtureId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFixtureId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get invertPan => $_getBF(1);
  @$pb.TagNumber(2)
  set invertPan($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvertPan() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvertPan() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get invertTilt => $_getBF(2);
  @$pb.TagNumber(3)
  set invertTilt($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInvertTilt() => $_has(2);
  @$pb.TagNumber(3)
  void clearInvertTilt() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get reversePixelOrder => $_getBF(3);
  @$pb.TagNumber(4)
  set reversePixelOrder($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReversePixelOrder() => $_has(3);
  @$pb.TagNumber(4)
  void clearReversePixelOrder() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get name => $_getSZ(4);
  @$pb.TagNumber(5)
  set name($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(4);
  @$pb.TagNumber(5)
  void clearName() => clearField(5);

  @$pb.TagNumber(6)
  FixtureAddress get address => $_getN(5);
  @$pb.TagNumber(6)
  set address(FixtureAddress v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasAddress() => $_has(5);
  @$pb.TagNumber(6)
  void clearAddress() => clearField(6);
  @$pb.TagNumber(6)
  FixtureAddress ensureAddress() => $_ensure(5);

  @$pb.TagNumber(7)
  UpdateFixtureRequest_UpdateFixtureLimit get limit => $_getN(6);
  @$pb.TagNumber(7)
  set limit(UpdateFixtureRequest_UpdateFixtureLimit v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearLimit() => clearField(7);
  @$pb.TagNumber(7)
  UpdateFixtureRequest_UpdateFixtureLimit ensureLimit() => $_ensure(6);
}

class FixtureAddress extends $pb.GeneratedMessage {
  factory FixtureAddress({
    $core.int? universe,
    $core.int? channel,
  }) {
    final $result = create();
    if (universe != null) {
      $result.universe = universe;
    }
    if (channel != null) {
      $result.channel = channel;
    }
    return $result;
  }
  FixtureAddress._() : super();
  factory FixtureAddress.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureAddress.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureAddress', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'universe', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'channel', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureAddress clone() => FixtureAddress()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureAddress copyWith(void Function(FixtureAddress) updates) => super.copyWith((message) => updates(message as FixtureAddress)) as FixtureAddress;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureAddress create() => FixtureAddress._();
  FixtureAddress createEmptyInstance() => create();
  static $pb.PbList<FixtureAddress> createRepeated() => $pb.PbList<FixtureAddress>();
  @$core.pragma('dart2js:noInline')
  static FixtureAddress getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureAddress>(create);
  static FixtureAddress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get universe => $_getIZ(0);
  @$pb.TagNumber(1)
  set universe($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUniverse() => $_has(0);
  @$pb.TagNumber(1)
  void clearUniverse() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get channel => $_getIZ(1);
  @$pb.TagNumber(2)
  set channel($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannel() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannel() => clearField(2);
}

enum FixtureId_Id {
  fixture, 
  subFixture, 
  notSet
}

class FixtureId extends $pb.GeneratedMessage {
  factory FixtureId({
    $core.int? fixture,
    SubFixtureId? subFixture,
  }) {
    final $result = create();
    if (fixture != null) {
      $result.fixture = fixture;
    }
    if (subFixture != null) {
      $result.subFixture = subFixture;
    }
    return $result;
  }
  FixtureId._() : super();
  factory FixtureId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, FixtureId_Id> _FixtureId_IdByTag = {
    1 : FixtureId_Id.fixture,
    2 : FixtureId_Id.subFixture,
    0 : FixtureId_Id.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureId', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..a<$core.int>(1, _omitFieldNames ? '' : 'fixture', $pb.PbFieldType.OU3)
    ..aOM<SubFixtureId>(2, _omitFieldNames ? '' : 'subFixture', subBuilder: SubFixtureId.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureId clone() => FixtureId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureId copyWith(void Function(FixtureId) updates) => super.copyWith((message) => updates(message as FixtureId)) as FixtureId;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureId create() => FixtureId._();
  FixtureId createEmptyInstance() => create();
  static $pb.PbList<FixtureId> createRepeated() => $pb.PbList<FixtureId>();
  @$core.pragma('dart2js:noInline')
  static FixtureId getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureId>(create);
  static FixtureId? _defaultInstance;

  FixtureId_Id whichId() => _FixtureId_IdByTag[$_whichOneof(0)]!;
  void clearId() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.int get fixture => $_getIZ(0);
  @$pb.TagNumber(1)
  set fixture($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFixture() => $_has(0);
  @$pb.TagNumber(1)
  void clearFixture() => clearField(1);

  @$pb.TagNumber(2)
  SubFixtureId get subFixture => $_getN(1);
  @$pb.TagNumber(2)
  set subFixture(SubFixtureId v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSubFixture() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubFixture() => clearField(2);
  @$pb.TagNumber(2)
  SubFixtureId ensureSubFixture() => $_ensure(1);
}

class SubFixtureId extends $pb.GeneratedMessage {
  factory SubFixtureId({
    $core.int? fixtureId,
    $core.int? childId,
  }) {
    final $result = create();
    if (fixtureId != null) {
      $result.fixtureId = fixtureId;
    }
    if (childId != null) {
      $result.childId = childId;
    }
    return $result;
  }
  SubFixtureId._() : super();
  factory SubFixtureId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubFixtureId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubFixtureId', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'fixtureId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'childId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubFixtureId clone() => SubFixtureId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubFixtureId copyWith(void Function(SubFixtureId) updates) => super.copyWith((message) => updates(message as SubFixtureId)) as SubFixtureId;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubFixtureId create() => SubFixtureId._();
  SubFixtureId createEmptyInstance() => create();
  static $pb.PbList<SubFixtureId> createRepeated() => $pb.PbList<SubFixtureId>();
  @$core.pragma('dart2js:noInline')
  static SubFixtureId getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubFixtureId>(create);
  static SubFixtureId? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get fixtureId => $_getIZ(0);
  @$pb.TagNumber(1)
  set fixtureId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFixtureId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFixtureId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get childId => $_getIZ(1);
  @$pb.TagNumber(2)
  set childId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChildId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChildId() => clearField(2);
}

class Fixtures extends $pb.GeneratedMessage {
  factory Fixtures({
    $core.Iterable<Fixture>? fixtures,
  }) {
    final $result = create();
    if (fixtures != null) {
      $result.fixtures.addAll(fixtures);
    }
    return $result;
  }
  Fixtures._() : super();
  factory Fixtures.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Fixtures.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Fixtures', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..pc<Fixture>(1, _omitFieldNames ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: Fixture.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Fixtures clone() => Fixtures()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Fixtures copyWith(void Function(Fixtures) updates) => super.copyWith((message) => updates(message as Fixtures)) as Fixtures;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Fixtures create() => Fixtures._();
  Fixtures createEmptyInstance() => create();
  static $pb.PbList<Fixtures> createRepeated() => $pb.PbList<Fixtures>();
  @$core.pragma('dart2js:noInline')
  static Fixtures getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Fixtures>(create);
  static Fixtures? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Fixture> get fixtures => $_getList(0);
}

class Fixture extends $pb.GeneratedMessage {
  factory Fixture({
    $core.int? id,
    $core.String? name,
    $core.String? manufacturer,
    $core.String? model,
    $core.String? mode,
    $core.int? universe,
    $core.int? channel,
    $core.int? channelCount,
    $core.Iterable<FixtureChannel>? channels,
    $core.Iterable<SubFixture>? children,
    FixtureConfig? config,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (manufacturer != null) {
      $result.manufacturer = manufacturer;
    }
    if (model != null) {
      $result.model = model;
    }
    if (mode != null) {
      $result.mode = mode;
    }
    if (universe != null) {
      $result.universe = universe;
    }
    if (channel != null) {
      $result.channel = channel;
    }
    if (channelCount != null) {
      $result.channelCount = channelCount;
    }
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    if (children != null) {
      $result.children.addAll(children);
    }
    if (config != null) {
      $result.config = config;
    }
    return $result;
  }
  Fixture._() : super();
  factory Fixture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Fixture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Fixture', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'manufacturer')
    ..aOS(4, _omitFieldNames ? '' : 'model')
    ..aOS(5, _omitFieldNames ? '' : 'mode')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'universe', $pb.PbFieldType.OU3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'channel', $pb.PbFieldType.OU3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'channelCount', $pb.PbFieldType.OU3)
    ..pc<FixtureChannel>(9, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: FixtureChannel.create)
    ..pc<SubFixture>(10, _omitFieldNames ? '' : 'children', $pb.PbFieldType.PM, subBuilder: SubFixture.create)
    ..aOM<FixtureConfig>(11, _omitFieldNames ? '' : 'config', subBuilder: FixtureConfig.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Fixture clone() => Fixture()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Fixture copyWith(void Function(Fixture) updates) => super.copyWith((message) => updates(message as Fixture)) as Fixture;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Fixture create() => Fixture._();
  Fixture createEmptyInstance() => create();
  static $pb.PbList<Fixture> createRepeated() => $pb.PbList<Fixture>();
  @$core.pragma('dart2js:noInline')
  static Fixture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Fixture>(create);
  static Fixture? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
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
  $core.String get manufacturer => $_getSZ(2);
  @$pb.TagNumber(3)
  set manufacturer($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasManufacturer() => $_has(2);
  @$pb.TagNumber(3)
  void clearManufacturer() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get model => $_getSZ(3);
  @$pb.TagNumber(4)
  set model($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasModel() => $_has(3);
  @$pb.TagNumber(4)
  void clearModel() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get mode => $_getSZ(4);
  @$pb.TagNumber(5)
  set mode($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMode() => $_has(4);
  @$pb.TagNumber(5)
  void clearMode() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get universe => $_getIZ(5);
  @$pb.TagNumber(6)
  set universe($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUniverse() => $_has(5);
  @$pb.TagNumber(6)
  void clearUniverse() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get channel => $_getIZ(6);
  @$pb.TagNumber(7)
  set channel($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasChannel() => $_has(6);
  @$pb.TagNumber(7)
  void clearChannel() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get channelCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set channelCount($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasChannelCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearChannelCount() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<FixtureChannel> get channels => $_getList(8);

  @$pb.TagNumber(10)
  $core.List<SubFixture> get children => $_getList(9);

  @$pb.TagNumber(11)
  FixtureConfig get config => $_getN(10);
  @$pb.TagNumber(11)
  set config(FixtureConfig v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasConfig() => $_has(10);
  @$pb.TagNumber(11)
  void clearConfig() => clearField(11);
  @$pb.TagNumber(11)
  FixtureConfig ensureConfig() => $_ensure(10);
}

class FixtureConfig extends $pb.GeneratedMessage {
  factory FixtureConfig({
    $core.bool? invertPan,
    $core.bool? invertTilt,
    $core.bool? reversePixelOrder,
    $core.Iterable<FixtureChannelLimit>? channelLimits,
  }) {
    final $result = create();
    if (invertPan != null) {
      $result.invertPan = invertPan;
    }
    if (invertTilt != null) {
      $result.invertTilt = invertTilt;
    }
    if (reversePixelOrder != null) {
      $result.reversePixelOrder = reversePixelOrder;
    }
    if (channelLimits != null) {
      $result.channelLimits.addAll(channelLimits);
    }
    return $result;
  }
  FixtureConfig._() : super();
  factory FixtureConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'invertPan')
    ..aOB(2, _omitFieldNames ? '' : 'invertTilt')
    ..aOB(3, _omitFieldNames ? '' : 'reversePixelOrder')
    ..pc<FixtureChannelLimit>(4, _omitFieldNames ? '' : 'channelLimits', $pb.PbFieldType.PM, subBuilder: FixtureChannelLimit.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureConfig clone() => FixtureConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureConfig copyWith(void Function(FixtureConfig) updates) => super.copyWith((message) => updates(message as FixtureConfig)) as FixtureConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureConfig create() => FixtureConfig._();
  FixtureConfig createEmptyInstance() => create();
  static $pb.PbList<FixtureConfig> createRepeated() => $pb.PbList<FixtureConfig>();
  @$core.pragma('dart2js:noInline')
  static FixtureConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureConfig>(create);
  static FixtureConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get invertPan => $_getBF(0);
  @$pb.TagNumber(1)
  set invertPan($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvertPan() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvertPan() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get invertTilt => $_getBF(1);
  @$pb.TagNumber(2)
  set invertTilt($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvertTilt() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvertTilt() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get reversePixelOrder => $_getBF(2);
  @$pb.TagNumber(3)
  set reversePixelOrder($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReversePixelOrder() => $_has(2);
  @$pb.TagNumber(3)
  void clearReversePixelOrder() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<FixtureChannelLimit> get channelLimits => $_getList(3);
}

class FixtureChannelLimit extends $pb.GeneratedMessage {
  factory FixtureChannelLimit({
    $core.String? channel,
    $core.double? min,
    $core.double? max,
  }) {
    final $result = create();
    if (channel != null) {
      $result.channel = channel;
    }
    if (min != null) {
      $result.min = min;
    }
    if (max != null) {
      $result.max = max;
    }
    return $result;
  }
  FixtureChannelLimit._() : super();
  factory FixtureChannelLimit.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureChannelLimit.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureChannelLimit', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channel')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'min', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'max', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureChannelLimit clone() => FixtureChannelLimit()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureChannelLimit copyWith(void Function(FixtureChannelLimit) updates) => super.copyWith((message) => updates(message as FixtureChannelLimit)) as FixtureChannelLimit;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureChannelLimit create() => FixtureChannelLimit._();
  FixtureChannelLimit createEmptyInstance() => create();
  static $pb.PbList<FixtureChannelLimit> createRepeated() => $pb.PbList<FixtureChannelLimit>();
  @$core.pragma('dart2js:noInline')
  static FixtureChannelLimit getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureChannelLimit>(create);
  static FixtureChannelLimit? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channel => $_getSZ(0);
  @$pb.TagNumber(1)
  set channel($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get min => $_getN(1);
  @$pb.TagNumber(2)
  set min($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMin() => $_has(1);
  @$pb.TagNumber(2)
  void clearMin() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get max => $_getN(2);
  @$pb.TagNumber(3)
  set max($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMax() => $_has(2);
  @$pb.TagNumber(3)
  void clearMax() => clearField(3);
}

class SubFixture extends $pb.GeneratedMessage {
  factory SubFixture({
    $core.int? id,
    $core.String? name,
    $core.Iterable<FixtureChannel>? channels,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    return $result;
  }
  SubFixture._() : super();
  factory SubFixture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubFixture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubFixture', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pc<FixtureChannel>(3, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: FixtureChannel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubFixture clone() => SubFixture()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubFixture copyWith(void Function(SubFixture) updates) => super.copyWith((message) => updates(message as SubFixture)) as SubFixture;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubFixture create() => SubFixture._();
  SubFixture createEmptyInstance() => create();
  static $pb.PbList<SubFixture> createRepeated() => $pb.PbList<SubFixture>();
  @$core.pragma('dart2js:noInline')
  static SubFixture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubFixture>(create);
  static SubFixture? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
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
  $core.List<FixtureChannel> get channels => $_getList(2);
}

class FixtureChannel extends $pb.GeneratedMessage {
  factory FixtureChannel({
    $core.String? channel,
    $core.String? label,
    FixtureChannelCategory? category,
    $core.Iterable<FixtureChannelPreset>? presets,
    FixtureValue? value,
  }) {
    final $result = create();
    if (channel != null) {
      $result.channel = channel;
    }
    if (label != null) {
      $result.label = label;
    }
    if (category != null) {
      $result.category = category;
    }
    if (presets != null) {
      $result.presets.addAll(presets);
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  FixtureChannel._() : super();
  factory FixtureChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureChannel', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channel')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..e<FixtureChannelCategory>(3, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: FixtureChannelCategory.NONE, valueOf: FixtureChannelCategory.valueOf, enumValues: FixtureChannelCategory.values)
    ..pc<FixtureChannelPreset>(4, _omitFieldNames ? '' : 'presets', $pb.PbFieldType.PM, subBuilder: FixtureChannelPreset.create)
    ..aOM<FixtureValue>(5, _omitFieldNames ? '' : 'value', subBuilder: FixtureValue.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureChannel clone() => FixtureChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureChannel copyWith(void Function(FixtureChannel) updates) => super.copyWith((message) => updates(message as FixtureChannel)) as FixtureChannel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureChannel create() => FixtureChannel._();
  FixtureChannel createEmptyInstance() => create();
  static $pb.PbList<FixtureChannel> createRepeated() => $pb.PbList<FixtureChannel>();
  @$core.pragma('dart2js:noInline')
  static FixtureChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureChannel>(create);
  static FixtureChannel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channel => $_getSZ(0);
  @$pb.TagNumber(1)
  set channel($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);

  @$pb.TagNumber(3)
  FixtureChannelCategory get category => $_getN(2);
  @$pb.TagNumber(3)
  set category(FixtureChannelCategory v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<FixtureChannelPreset> get presets => $_getList(3);

  @$pb.TagNumber(5)
  FixtureValue get value => $_getN(4);
  @$pb.TagNumber(5)
  set value(FixtureValue v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearValue() => clearField(5);
  @$pb.TagNumber(5)
  FixtureValue ensureValue() => $_ensure(4);
}

class FixtureChannelDefinition extends $pb.GeneratedMessage {
  factory FixtureChannelDefinition({
    $core.String? channel,
    $core.String? label,
    FixtureChannelCategory? category,
    $core.Iterable<FixtureChannelPreset>? presets,
  }) {
    final $result = create();
    if (channel != null) {
      $result.channel = channel;
    }
    if (label != null) {
      $result.label = label;
    }
    if (category != null) {
      $result.category = category;
    }
    if (presets != null) {
      $result.presets.addAll(presets);
    }
    return $result;
  }
  FixtureChannelDefinition._() : super();
  factory FixtureChannelDefinition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureChannelDefinition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureChannelDefinition', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channel')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..e<FixtureChannelCategory>(3, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: FixtureChannelCategory.NONE, valueOf: FixtureChannelCategory.valueOf, enumValues: FixtureChannelCategory.values)
    ..pc<FixtureChannelPreset>(4, _omitFieldNames ? '' : 'presets', $pb.PbFieldType.PM, subBuilder: FixtureChannelPreset.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureChannelDefinition clone() => FixtureChannelDefinition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureChannelDefinition copyWith(void Function(FixtureChannelDefinition) updates) => super.copyWith((message) => updates(message as FixtureChannelDefinition)) as FixtureChannelDefinition;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureChannelDefinition create() => FixtureChannelDefinition._();
  FixtureChannelDefinition createEmptyInstance() => create();
  static $pb.PbList<FixtureChannelDefinition> createRepeated() => $pb.PbList<FixtureChannelDefinition>();
  @$core.pragma('dart2js:noInline')
  static FixtureChannelDefinition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureChannelDefinition>(create);
  static FixtureChannelDefinition? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channel => $_getSZ(0);
  @$pb.TagNumber(1)
  set channel($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);

  @$pb.TagNumber(3)
  FixtureChannelCategory get category => $_getN(2);
  @$pb.TagNumber(3)
  set category(FixtureChannelCategory v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<FixtureChannelPreset> get presets => $_getList(3);
}

class FixtureChannelPreset extends $pb.GeneratedMessage {
  factory FixtureChannelPreset({
    FixtureValue? value,
    $core.String? name,
    FixtureImage? image,
    $core.Iterable<$core.String>? colors,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (name != null) {
      $result.name = name;
    }
    if (image != null) {
      $result.image = image;
    }
    if (colors != null) {
      $result.colors.addAll(colors);
    }
    return $result;
  }
  FixtureChannelPreset._() : super();
  factory FixtureChannelPreset.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureChannelPreset.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureChannelPreset', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOM<FixtureValue>(1, _omitFieldNames ? '' : 'value', subBuilder: FixtureValue.create)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<FixtureImage>(3, _omitFieldNames ? '' : 'image', subBuilder: FixtureImage.create)
    ..pPS(4, _omitFieldNames ? '' : 'colors')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureChannelPreset clone() => FixtureChannelPreset()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureChannelPreset copyWith(void Function(FixtureChannelPreset) updates) => super.copyWith((message) => updates(message as FixtureChannelPreset)) as FixtureChannelPreset;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureChannelPreset create() => FixtureChannelPreset._();
  FixtureChannelPreset createEmptyInstance() => create();
  static $pb.PbList<FixtureChannelPreset> createRepeated() => $pb.PbList<FixtureChannelPreset>();
  @$core.pragma('dart2js:noInline')
  static FixtureChannelPreset getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureChannelPreset>(create);
  static FixtureChannelPreset? _defaultInstance;

  @$pb.TagNumber(1)
  FixtureValue get value => $_getN(0);
  @$pb.TagNumber(1)
  set value(FixtureValue v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
  @$pb.TagNumber(1)
  FixtureValue ensureValue() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  FixtureImage get image => $_getN(2);
  @$pb.TagNumber(3)
  set image(FixtureImage v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearImage() => clearField(3);
  @$pb.TagNumber(3)
  FixtureImage ensureImage() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<$core.String> get colors => $_getList(3);
}

enum FixtureValue_Value {
  percent, 
  notSet
}

class FixtureValue extends $pb.GeneratedMessage {
  factory FixtureValue({
    $core.double? percent,
  }) {
    final $result = create();
    if (percent != null) {
      $result.percent = percent;
    }
    return $result;
  }
  FixtureValue._() : super();
  factory FixtureValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, FixtureValue_Value> _FixtureValue_ValueByTag = {
    1 : FixtureValue_Value.percent,
    0 : FixtureValue_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..oo(0, [1])
    ..a<$core.double>(1, _omitFieldNames ? '' : 'percent', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureValue clone() => FixtureValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureValue copyWith(void Function(FixtureValue) updates) => super.copyWith((message) => updates(message as FixtureValue)) as FixtureValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureValue create() => FixtureValue._();
  FixtureValue createEmptyInstance() => create();
  static $pb.PbList<FixtureValue> createRepeated() => $pb.PbList<FixtureValue>();
  @$core.pragma('dart2js:noInline')
  static FixtureValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureValue>(create);
  static FixtureValue? _defaultInstance;

  FixtureValue_Value whichValue() => _FixtureValue_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.double get percent => $_getN(0);
  @$pb.TagNumber(1)
  set percent($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPercent() => $_has(0);
  @$pb.TagNumber(1)
  void clearPercent() => clearField(1);
}

enum FixtureImage_Image {
  svg, 
  raster, 
  notSet
}

class FixtureImage extends $pb.GeneratedMessage {
  factory FixtureImage({
    $core.String? svg,
    $core.List<$core.int>? raster,
  }) {
    final $result = create();
    if (svg != null) {
      $result.svg = svg;
    }
    if (raster != null) {
      $result.raster = raster;
    }
    return $result;
  }
  FixtureImage._() : super();
  factory FixtureImage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureImage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, FixtureImage_Image> _FixtureImage_ImageByTag = {
    1 : FixtureImage_Image.svg,
    2 : FixtureImage_Image.raster,
    0 : FixtureImage_Image.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureImage', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'svg')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'raster', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureImage clone() => FixtureImage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureImage copyWith(void Function(FixtureImage) updates) => super.copyWith((message) => updates(message as FixtureImage)) as FixtureImage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureImage create() => FixtureImage._();
  FixtureImage createEmptyInstance() => create();
  static $pb.PbList<FixtureImage> createRepeated() => $pb.PbList<FixtureImage>();
  @$core.pragma('dart2js:noInline')
  static FixtureImage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureImage>(create);
  static FixtureImage? _defaultInstance;

  FixtureImage_Image whichImage() => _FixtureImage_ImageByTag[$_whichOneof(0)]!;
  void clearImage() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get svg => $_getSZ(0);
  @$pb.TagNumber(1)
  set svg($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSvg() => $_has(0);
  @$pb.TagNumber(1)
  void clearSvg() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get raster => $_getN(1);
  @$pb.TagNumber(2)
  set raster($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRaster() => $_has(1);
  @$pb.TagNumber(2)
  void clearRaster() => clearField(2);
}

class GetFixtureDefinitionsRequest extends $pb.GeneratedMessage {
  factory GetFixtureDefinitionsRequest() => create();
  GetFixtureDefinitionsRequest._() : super();
  factory GetFixtureDefinitionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFixtureDefinitionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFixtureDefinitionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFixtureDefinitionsRequest clone() => GetFixtureDefinitionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFixtureDefinitionsRequest copyWith(void Function(GetFixtureDefinitionsRequest) updates) => super.copyWith((message) => updates(message as GetFixtureDefinitionsRequest)) as GetFixtureDefinitionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFixtureDefinitionsRequest create() => GetFixtureDefinitionsRequest._();
  GetFixtureDefinitionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFixtureDefinitionsRequest> createRepeated() => $pb.PbList<GetFixtureDefinitionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFixtureDefinitionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFixtureDefinitionsRequest>(create);
  static GetFixtureDefinitionsRequest? _defaultInstance;
}

class FixtureDefinitions extends $pb.GeneratedMessage {
  factory FixtureDefinitions({
    $core.Iterable<FixtureDefinition>? definitions,
  }) {
    final $result = create();
    if (definitions != null) {
      $result.definitions.addAll(definitions);
    }
    return $result;
  }
  FixtureDefinitions._() : super();
  factory FixtureDefinitions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureDefinitions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureDefinitions', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..pc<FixtureDefinition>(1, _omitFieldNames ? '' : 'definitions', $pb.PbFieldType.PM, subBuilder: FixtureDefinition.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureDefinitions clone() => FixtureDefinitions()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureDefinitions copyWith(void Function(FixtureDefinitions) updates) => super.copyWith((message) => updates(message as FixtureDefinitions)) as FixtureDefinitions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureDefinitions create() => FixtureDefinitions._();
  FixtureDefinitions createEmptyInstance() => create();
  static $pb.PbList<FixtureDefinitions> createRepeated() => $pb.PbList<FixtureDefinitions>();
  @$core.pragma('dart2js:noInline')
  static FixtureDefinitions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureDefinitions>(create);
  static FixtureDefinitions? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FixtureDefinition> get definitions => $_getList(0);
}

class FixtureDefinition extends $pb.GeneratedMessage {
  factory FixtureDefinition({
    $core.String? id,
    $core.String? name,
    $core.String? manufacturer,
    $core.Iterable<FixtureMode>? modes,
    FixturePhysicalData? physical,
    $core.Iterable<$core.String>? tags,
    $core.String? provider,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (manufacturer != null) {
      $result.manufacturer = manufacturer;
    }
    if (modes != null) {
      $result.modes.addAll(modes);
    }
    if (physical != null) {
      $result.physical = physical;
    }
    if (tags != null) {
      $result.tags.addAll(tags);
    }
    if (provider != null) {
      $result.provider = provider;
    }
    return $result;
  }
  FixtureDefinition._() : super();
  factory FixtureDefinition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureDefinition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureDefinition', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'manufacturer')
    ..pc<FixtureMode>(4, _omitFieldNames ? '' : 'modes', $pb.PbFieldType.PM, subBuilder: FixtureMode.create)
    ..aOM<FixturePhysicalData>(5, _omitFieldNames ? '' : 'physical', subBuilder: FixturePhysicalData.create)
    ..pPS(6, _omitFieldNames ? '' : 'tags')
    ..aOS(7, _omitFieldNames ? '' : 'provider')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureDefinition clone() => FixtureDefinition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureDefinition copyWith(void Function(FixtureDefinition) updates) => super.copyWith((message) => updates(message as FixtureDefinition)) as FixtureDefinition;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureDefinition create() => FixtureDefinition._();
  FixtureDefinition createEmptyInstance() => create();
  static $pb.PbList<FixtureDefinition> createRepeated() => $pb.PbList<FixtureDefinition>();
  @$core.pragma('dart2js:noInline')
  static FixtureDefinition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureDefinition>(create);
  static FixtureDefinition? _defaultInstance;

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
  $core.String get manufacturer => $_getSZ(2);
  @$pb.TagNumber(3)
  set manufacturer($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasManufacturer() => $_has(2);
  @$pb.TagNumber(3)
  void clearManufacturer() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<FixtureMode> get modes => $_getList(3);

  @$pb.TagNumber(5)
  FixturePhysicalData get physical => $_getN(4);
  @$pb.TagNumber(5)
  set physical(FixturePhysicalData v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhysical() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhysical() => clearField(5);
  @$pb.TagNumber(5)
  FixturePhysicalData ensurePhysical() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.List<$core.String> get tags => $_getList(5);

  @$pb.TagNumber(7)
  $core.String get provider => $_getSZ(6);
  @$pb.TagNumber(7)
  set provider($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasProvider() => $_has(6);
  @$pb.TagNumber(7)
  void clearProvider() => clearField(7);
}

class FixtureMode extends $pb.GeneratedMessage {
  factory FixtureMode({
    $core.String? name,
    $core.Iterable<FixtureChannelDefinition>? channels,
    $core.int? dmxFootprint,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    if (dmxFootprint != null) {
      $result.dmxFootprint = dmxFootprint;
    }
    return $result;
  }
  FixtureMode._() : super();
  factory FixtureMode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureMode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureMode', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<FixtureChannelDefinition>(2, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: FixtureChannelDefinition.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'dmxFootprint', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureMode clone() => FixtureMode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureMode copyWith(void Function(FixtureMode) updates) => super.copyWith((message) => updates(message as FixtureMode)) as FixtureMode;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureMode create() => FixtureMode._();
  FixtureMode createEmptyInstance() => create();
  static $pb.PbList<FixtureMode> createRepeated() => $pb.PbList<FixtureMode>();
  @$core.pragma('dart2js:noInline')
  static FixtureMode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureMode>(create);
  static FixtureMode? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<FixtureChannelDefinition> get channels => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get dmxFootprint => $_getIZ(2);
  @$pb.TagNumber(3)
  set dmxFootprint($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDmxFootprint() => $_has(2);
  @$pb.TagNumber(3)
  void clearDmxFootprint() => clearField(3);
}

class FixturePhysicalData extends $pb.GeneratedMessage {
  factory FixturePhysicalData({
    $core.double? width,
    $core.double? height,
    $core.double? depth,
    $core.double? weight,
  }) {
    final $result = create();
    if (width != null) {
      $result.width = width;
    }
    if (height != null) {
      $result.height = height;
    }
    if (depth != null) {
      $result.depth = depth;
    }
    if (weight != null) {
      $result.weight = weight;
    }
    return $result;
  }
  FixturePhysicalData._() : super();
  factory FixturePhysicalData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixturePhysicalData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixturePhysicalData', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'width', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'depth', $pb.PbFieldType.OF)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'weight', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixturePhysicalData clone() => FixturePhysicalData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixturePhysicalData copyWith(void Function(FixturePhysicalData) updates) => super.copyWith((message) => updates(message as FixturePhysicalData)) as FixturePhysicalData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixturePhysicalData create() => FixturePhysicalData._();
  FixturePhysicalData createEmptyInstance() => create();
  static $pb.PbList<FixturePhysicalData> createRepeated() => $pb.PbList<FixturePhysicalData>();
  @$core.pragma('dart2js:noInline')
  static FixturePhysicalData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixturePhysicalData>(create);
  static FixturePhysicalData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get width => $_getN(0);
  @$pb.TagNumber(1)
  set width($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWidth() => $_has(0);
  @$pb.TagNumber(1)
  void clearWidth() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get height => $_getN(1);
  @$pb.TagNumber(2)
  set height($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get depth => $_getN(2);
  @$pb.TagNumber(3)
  set depth($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDepth() => $_has(2);
  @$pb.TagNumber(3)
  void clearDepth() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get weight => $_getN(3);
  @$pb.TagNumber(4)
  set weight($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasWeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearWeight() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
