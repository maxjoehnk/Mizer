///
//  Generated code. Do not modify.
//  source: fixtures.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'fixtures.pbenum.dart';

export 'fixtures.pbenum.dart';

class AddFixturesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddFixturesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOM<AddFixtureRequest>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'request', subBuilder: AddFixtureRequest.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'count', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  AddFixturesRequest._() : super();
  factory AddFixturesRequest({
    AddFixtureRequest? request,
    $core.int? count,
  }) {
    final _result = create();
    if (request != null) {
      _result.request = request;
    }
    if (count != null) {
      _result.count = count;
    }
    return _result;
  }
  factory AddFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddFixturesRequest clone() => AddFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddFixturesRequest copyWith(void Function(AddFixturesRequest) updates) => super.copyWith((message) => updates(message as AddFixturesRequest)) as AddFixturesRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddFixtureRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'definitionId', protoName: 'definitionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mode')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'universe', $pb.PbFieldType.OU3)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  AddFixtureRequest._() : super();
  factory AddFixtureRequest({
    $core.String? definitionId,
    $core.String? mode,
    $core.int? id,
    $core.int? channel,
    $core.int? universe,
    $core.String? name,
  }) {
    final _result = create();
    if (definitionId != null) {
      _result.definitionId = definitionId;
    }
    if (mode != null) {
      _result.mode = mode;
    }
    if (id != null) {
      _result.id = id;
    }
    if (channel != null) {
      _result.channel = channel;
    }
    if (universe != null) {
      _result.universe = universe;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory AddFixtureRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddFixtureRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddFixtureRequest clone() => AddFixtureRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddFixtureRequest copyWith(void Function(AddFixtureRequest) updates) => super.copyWith((message) => updates(message as AddFixtureRequest)) as AddFixtureRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFixturesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetFixturesRequest._() : super();
  factory GetFixturesRequest() => create();
  factory GetFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFixturesRequest clone() => GetFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFixturesRequest copyWith(void Function(GetFixturesRequest) updates) => super.copyWith((message) => updates(message as GetFixturesRequest)) as GetFixturesRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteFixturesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..p<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtureIds', $pb.PbFieldType.PU3, protoName: 'fixtureIds')
    ..hasRequiredFields = false
  ;

  DeleteFixturesRequest._() : super();
  factory DeleteFixturesRequest({
    $core.Iterable<$core.int>? fixtureIds,
  }) {
    final _result = create();
    if (fixtureIds != null) {
      _result.fixtureIds.addAll(fixtureIds);
    }
    return _result;
  }
  factory DeleteFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteFixturesRequest clone() => DeleteFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteFixturesRequest copyWith(void Function(DeleteFixturesRequest) updates) => super.copyWith((message) => updates(message as DeleteFixturesRequest)) as DeleteFixturesRequest; // ignore: deprecated_member_use
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

class UpdateFixtureRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateFixtureRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtureId', $pb.PbFieldType.OU3, protoName: 'fixtureId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invertPan')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invertTilt')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reversePixelOrder')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOM<FixtureAddress>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address', subBuilder: FixtureAddress.create)
    ..hasRequiredFields = false
  ;

  UpdateFixtureRequest._() : super();
  factory UpdateFixtureRequest({
    $core.int? fixtureId,
    $core.bool? invertPan,
    $core.bool? invertTilt,
    $core.bool? reversePixelOrder,
    $core.String? name,
    FixtureAddress? address,
  }) {
    final _result = create();
    if (fixtureId != null) {
      _result.fixtureId = fixtureId;
    }
    if (invertPan != null) {
      _result.invertPan = invertPan;
    }
    if (invertTilt != null) {
      _result.invertTilt = invertTilt;
    }
    if (reversePixelOrder != null) {
      _result.reversePixelOrder = reversePixelOrder;
    }
    if (name != null) {
      _result.name = name;
    }
    if (address != null) {
      _result.address = address;
    }
    return _result;
  }
  factory UpdateFixtureRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFixtureRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFixtureRequest clone() => UpdateFixtureRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFixtureRequest copyWith(void Function(UpdateFixtureRequest) updates) => super.copyWith((message) => updates(message as UpdateFixtureRequest)) as UpdateFixtureRequest; // ignore: deprecated_member_use
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
}

class FixtureAddress extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureAddress', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'universe', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  FixtureAddress._() : super();
  factory FixtureAddress({
    $core.int? universe,
    $core.int? channel,
  }) {
    final _result = create();
    if (universe != null) {
      _result.universe = universe;
    }
    if (channel != null) {
      _result.channel = channel;
    }
    return _result;
  }
  factory FixtureAddress.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureAddress.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureAddress clone() => FixtureAddress()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureAddress copyWith(void Function(FixtureAddress) updates) => super.copyWith((message) => updates(message as FixtureAddress)) as FixtureAddress; // ignore: deprecated_member_use
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
  static const $core.Map<$core.int, FixtureId_Id> _FixtureId_IdByTag = {
    1 : FixtureId_Id.fixture,
    2 : FixtureId_Id.subFixture,
    0 : FixtureId_Id.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureId', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixture', $pb.PbFieldType.OU3)
    ..aOM<SubFixtureId>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subFixture', subBuilder: SubFixtureId.create)
    ..hasRequiredFields = false
  ;

  FixtureId._() : super();
  factory FixtureId({
    $core.int? fixture,
    SubFixtureId? subFixture,
  }) {
    final _result = create();
    if (fixture != null) {
      _result.fixture = fixture;
    }
    if (subFixture != null) {
      _result.subFixture = subFixture;
    }
    return _result;
  }
  factory FixtureId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureId clone() => FixtureId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureId copyWith(void Function(FixtureId) updates) => super.copyWith((message) => updates(message as FixtureId)) as FixtureId; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubFixtureId', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtureId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'childId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  SubFixtureId._() : super();
  factory SubFixtureId({
    $core.int? fixtureId,
    $core.int? childId,
  }) {
    final _result = create();
    if (fixtureId != null) {
      _result.fixtureId = fixtureId;
    }
    if (childId != null) {
      _result.childId = childId;
    }
    return _result;
  }
  factory SubFixtureId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubFixtureId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubFixtureId clone() => SubFixtureId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubFixtureId copyWith(void Function(SubFixtureId) updates) => super.copyWith((message) => updates(message as SubFixtureId)) as SubFixtureId; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Fixtures', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..pc<Fixture>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: Fixture.create)
    ..hasRequiredFields = false
  ;

  Fixtures._() : super();
  factory Fixtures({
    $core.Iterable<Fixture>? fixtures,
  }) {
    final _result = create();
    if (fixtures != null) {
      _result.fixtures.addAll(fixtures);
    }
    return _result;
  }
  factory Fixtures.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Fixtures.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Fixtures clone() => Fixtures()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Fixtures copyWith(void Function(Fixtures) updates) => super.copyWith((message) => updates(message as Fixtures)) as Fixtures; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Fixture', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'manufacturer')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'model')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mode')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'universe', $pb.PbFieldType.OU3)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelCount', $pb.PbFieldType.OU3)
    ..pc<FixtureControls>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controls', $pb.PbFieldType.PM, subBuilder: FixtureControls.create)
    ..pc<SubFixture>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'children', $pb.PbFieldType.PM, subBuilder: SubFixture.create)
    ..aOM<FixtureConfig>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'config', subBuilder: FixtureConfig.create)
    ..hasRequiredFields = false
  ;

  Fixture._() : super();
  factory Fixture({
    $core.int? id,
    $core.String? name,
    $core.String? manufacturer,
    $core.String? model,
    $core.String? mode,
    $core.int? universe,
    $core.int? channel,
    $core.int? channelCount,
    $core.Iterable<FixtureControls>? controls,
    $core.Iterable<SubFixture>? children,
    FixtureConfig? config,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (manufacturer != null) {
      _result.manufacturer = manufacturer;
    }
    if (model != null) {
      _result.model = model;
    }
    if (mode != null) {
      _result.mode = mode;
    }
    if (universe != null) {
      _result.universe = universe;
    }
    if (channel != null) {
      _result.channel = channel;
    }
    if (channelCount != null) {
      _result.channelCount = channelCount;
    }
    if (controls != null) {
      _result.controls.addAll(controls);
    }
    if (children != null) {
      _result.children.addAll(children);
    }
    if (config != null) {
      _result.config = config;
    }
    return _result;
  }
  factory Fixture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Fixture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Fixture clone() => Fixture()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Fixture copyWith(void Function(Fixture) updates) => super.copyWith((message) => updates(message as Fixture)) as Fixture; // ignore: deprecated_member_use
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
  $core.List<FixtureControls> get controls => $_getList(8);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invertPan')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invertTilt')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reversePixelOrder')
    ..hasRequiredFields = false
  ;

  FixtureConfig._() : super();
  factory FixtureConfig({
    $core.bool? invertPan,
    $core.bool? invertTilt,
    $core.bool? reversePixelOrder,
  }) {
    final _result = create();
    if (invertPan != null) {
      _result.invertPan = invertPan;
    }
    if (invertTilt != null) {
      _result.invertTilt = invertTilt;
    }
    if (reversePixelOrder != null) {
      _result.reversePixelOrder = reversePixelOrder;
    }
    return _result;
  }
  factory FixtureConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureConfig clone() => FixtureConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureConfig copyWith(void Function(FixtureConfig) updates) => super.copyWith((message) => updates(message as FixtureConfig)) as FixtureConfig; // ignore: deprecated_member_use
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
}

class SubFixture extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubFixture', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<FixtureControls>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controls', $pb.PbFieldType.PM, subBuilder: FixtureControls.create)
    ..hasRequiredFields = false
  ;

  SubFixture._() : super();
  factory SubFixture({
    $core.int? id,
    $core.String? name,
    $core.Iterable<FixtureControls>? controls,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (controls != null) {
      _result.controls.addAll(controls);
    }
    return _result;
  }
  factory SubFixture.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubFixture.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubFixture clone() => SubFixture()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubFixture copyWith(void Function(SubFixture) updates) => super.copyWith((message) => updates(message as SubFixture)) as SubFixture; // ignore: deprecated_member_use
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
  $core.List<FixtureControls> get controls => $_getList(2);
}

enum FixtureControls_Value {
  fader, 
  colorMixer, 
  colorWheel, 
  axis, 
  gobo, 
  generic, 
  notSet
}

class FixtureControls extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, FixtureControls_Value> _FixtureControls_ValueByTag = {
    2 : FixtureControls_Value.fader,
    3 : FixtureControls_Value.colorMixer,
    4 : FixtureControls_Value.colorWheel,
    5 : FixtureControls_Value.axis,
    6 : FixtureControls_Value.gobo,
    7 : FixtureControls_Value.generic,
    0 : FixtureControls_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureControls', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5, 6, 7])
    ..e<FixtureControl>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'control', $pb.PbFieldType.OE, defaultOrMaker: FixtureControl.INTENSITY, valueOf: FixtureControl.valueOf, enumValues: FixtureControl.values)
    ..aOM<FaderChannel>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fader', subBuilder: FaderChannel.create)
    ..aOM<ColorMixerChannel>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'colorMixer', subBuilder: ColorMixerChannel.create)
    ..aOM<ColorWheelChannel>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'colorWheel', subBuilder: ColorWheelChannel.create)
    ..aOM<AxisChannel>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'axis', subBuilder: AxisChannel.create)
    ..aOM<GoboChannel>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gobo', subBuilder: GoboChannel.create)
    ..aOM<GenericChannel>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generic', subBuilder: GenericChannel.create)
    ..hasRequiredFields = false
  ;

  FixtureControls._() : super();
  factory FixtureControls({
    FixtureControl? control,
    FaderChannel? fader,
    ColorMixerChannel? colorMixer,
    ColorWheelChannel? colorWheel,
    AxisChannel? axis,
    GoboChannel? gobo,
    GenericChannel? generic,
  }) {
    final _result = create();
    if (control != null) {
      _result.control = control;
    }
    if (fader != null) {
      _result.fader = fader;
    }
    if (colorMixer != null) {
      _result.colorMixer = colorMixer;
    }
    if (colorWheel != null) {
      _result.colorWheel = colorWheel;
    }
    if (axis != null) {
      _result.axis = axis;
    }
    if (gobo != null) {
      _result.gobo = gobo;
    }
    if (generic != null) {
      _result.generic = generic;
    }
    return _result;
  }
  factory FixtureControls.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureControls.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureControls clone() => FixtureControls()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureControls copyWith(void Function(FixtureControls) updates) => super.copyWith((message) => updates(message as FixtureControls)) as FixtureControls; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureControls create() => FixtureControls._();
  FixtureControls createEmptyInstance() => create();
  static $pb.PbList<FixtureControls> createRepeated() => $pb.PbList<FixtureControls>();
  @$core.pragma('dart2js:noInline')
  static FixtureControls getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureControls>(create);
  static FixtureControls? _defaultInstance;

  FixtureControls_Value whichValue() => _FixtureControls_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  FixtureControl get control => $_getN(0);
  @$pb.TagNumber(1)
  set control(FixtureControl v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasControl() => $_has(0);
  @$pb.TagNumber(1)
  void clearControl() => clearField(1);

  @$pb.TagNumber(2)
  FaderChannel get fader => $_getN(1);
  @$pb.TagNumber(2)
  set fader(FaderChannel v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasFader() => $_has(1);
  @$pb.TagNumber(2)
  void clearFader() => clearField(2);
  @$pb.TagNumber(2)
  FaderChannel ensureFader() => $_ensure(1);

  @$pb.TagNumber(3)
  ColorMixerChannel get colorMixer => $_getN(2);
  @$pb.TagNumber(3)
  set colorMixer(ColorMixerChannel v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasColorMixer() => $_has(2);
  @$pb.TagNumber(3)
  void clearColorMixer() => clearField(3);
  @$pb.TagNumber(3)
  ColorMixerChannel ensureColorMixer() => $_ensure(2);

  @$pb.TagNumber(4)
  ColorWheelChannel get colorWheel => $_getN(3);
  @$pb.TagNumber(4)
  set colorWheel(ColorWheelChannel v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasColorWheel() => $_has(3);
  @$pb.TagNumber(4)
  void clearColorWheel() => clearField(4);
  @$pb.TagNumber(4)
  ColorWheelChannel ensureColorWheel() => $_ensure(3);

  @$pb.TagNumber(5)
  AxisChannel get axis => $_getN(4);
  @$pb.TagNumber(5)
  set axis(AxisChannel v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasAxis() => $_has(4);
  @$pb.TagNumber(5)
  void clearAxis() => clearField(5);
  @$pb.TagNumber(5)
  AxisChannel ensureAxis() => $_ensure(4);

  @$pb.TagNumber(6)
  GoboChannel get gobo => $_getN(5);
  @$pb.TagNumber(6)
  set gobo(GoboChannel v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasGobo() => $_has(5);
  @$pb.TagNumber(6)
  void clearGobo() => clearField(6);
  @$pb.TagNumber(6)
  GoboChannel ensureGobo() => $_ensure(5);

  @$pb.TagNumber(7)
  GenericChannel get generic => $_getN(6);
  @$pb.TagNumber(7)
  set generic(GenericChannel v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasGeneric() => $_has(6);
  @$pb.TagNumber(7)
  void clearGeneric() => clearField(7);
  @$pb.TagNumber(7)
  GenericChannel ensureGeneric() => $_ensure(6);
}

class FaderChannel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FaderChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  FaderChannel._() : super();
  factory FaderChannel({
    $core.double? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory FaderChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FaderChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FaderChannel clone() => FaderChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FaderChannel copyWith(void Function(FaderChannel) updates) => super.copyWith((message) => updates(message as FaderChannel)) as FaderChannel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FaderChannel create() => FaderChannel._();
  FaderChannel createEmptyInstance() => create();
  static $pb.PbList<FaderChannel> createRepeated() => $pb.PbList<FaderChannel>();
  @$core.pragma('dart2js:noInline')
  static FaderChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FaderChannel>(create);
  static FaderChannel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class ColorMixerChannel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ColorMixerChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'red', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'green', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ColorMixerChannel._() : super();
  factory ColorMixerChannel({
    $core.double? red,
    $core.double? green,
    $core.double? blue,
  }) {
    final _result = create();
    if (red != null) {
      _result.red = red;
    }
    if (green != null) {
      _result.green = green;
    }
    if (blue != null) {
      _result.blue = blue;
    }
    return _result;
  }
  factory ColorMixerChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ColorMixerChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ColorMixerChannel clone() => ColorMixerChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ColorMixerChannel copyWith(void Function(ColorMixerChannel) updates) => super.copyWith((message) => updates(message as ColorMixerChannel)) as ColorMixerChannel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ColorMixerChannel create() => ColorMixerChannel._();
  ColorMixerChannel createEmptyInstance() => create();
  static $pb.PbList<ColorMixerChannel> createRepeated() => $pb.PbList<ColorMixerChannel>();
  @$core.pragma('dart2js:noInline')
  static ColorMixerChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ColorMixerChannel>(create);
  static ColorMixerChannel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get red => $_getN(0);
  @$pb.TagNumber(1)
  set red($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRed() => $_has(0);
  @$pb.TagNumber(1)
  void clearRed() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get green => $_getN(1);
  @$pb.TagNumber(2)
  set green($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGreen() => $_has(1);
  @$pb.TagNumber(2)
  void clearGreen() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get blue => $_getN(2);
  @$pb.TagNumber(3)
  set blue($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBlue() => $_has(2);
  @$pb.TagNumber(3)
  void clearBlue() => clearField(3);
}

class ColorWheelChannel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ColorWheelChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..pc<ColorWheelSlot>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'colors', $pb.PbFieldType.PM, subBuilder: ColorWheelSlot.create)
    ..hasRequiredFields = false
  ;

  ColorWheelChannel._() : super();
  factory ColorWheelChannel({
    $core.double? value,
    $core.Iterable<ColorWheelSlot>? colors,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (colors != null) {
      _result.colors.addAll(colors);
    }
    return _result;
  }
  factory ColorWheelChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ColorWheelChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ColorWheelChannel clone() => ColorWheelChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ColorWheelChannel copyWith(void Function(ColorWheelChannel) updates) => super.copyWith((message) => updates(message as ColorWheelChannel)) as ColorWheelChannel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ColorWheelChannel create() => ColorWheelChannel._();
  ColorWheelChannel createEmptyInstance() => create();
  static $pb.PbList<ColorWheelChannel> createRepeated() => $pb.PbList<ColorWheelChannel>();
  @$core.pragma('dart2js:noInline')
  static ColorWheelChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ColorWheelChannel>(create);
  static ColorWheelChannel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<ColorWheelSlot> get colors => $_getList(1);
}

class ColorWheelSlot extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ColorWheelSlot', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'colors')
    ..hasRequiredFields = false
  ;

  ColorWheelSlot._() : super();
  factory ColorWheelSlot({
    $core.String? name,
    $core.double? value,
    $core.Iterable<$core.String>? colors,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (value != null) {
      _result.value = value;
    }
    if (colors != null) {
      _result.colors.addAll(colors);
    }
    return _result;
  }
  factory ColorWheelSlot.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ColorWheelSlot.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ColorWheelSlot clone() => ColorWheelSlot()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ColorWheelSlot copyWith(void Function(ColorWheelSlot) updates) => super.copyWith((message) => updates(message as ColorWheelSlot)) as ColorWheelSlot; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ColorWheelSlot create() => ColorWheelSlot._();
  ColorWheelSlot createEmptyInstance() => create();
  static $pb.PbList<ColorWheelSlot> createRepeated() => $pb.PbList<ColorWheelSlot>();
  @$core.pragma('dart2js:noInline')
  static ColorWheelSlot getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ColorWheelSlot>(create);
  static ColorWheelSlot? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get colors => $_getList(2);
}

class AxisChannel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AxisChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'angleFrom', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'angleTo', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  AxisChannel._() : super();
  factory AxisChannel({
    $core.double? value,
    $core.double? angleFrom,
    $core.double? angleTo,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (angleFrom != null) {
      _result.angleFrom = angleFrom;
    }
    if (angleTo != null) {
      _result.angleTo = angleTo;
    }
    return _result;
  }
  factory AxisChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AxisChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AxisChannel clone() => AxisChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AxisChannel copyWith(void Function(AxisChannel) updates) => super.copyWith((message) => updates(message as AxisChannel)) as AxisChannel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AxisChannel create() => AxisChannel._();
  AxisChannel createEmptyInstance() => create();
  static $pb.PbList<AxisChannel> createRepeated() => $pb.PbList<AxisChannel>();
  @$core.pragma('dart2js:noInline')
  static AxisChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AxisChannel>(create);
  static AxisChannel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get angleFrom => $_getN(1);
  @$pb.TagNumber(2)
  set angleFrom($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAngleFrom() => $_has(1);
  @$pb.TagNumber(2)
  void clearAngleFrom() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get angleTo => $_getN(2);
  @$pb.TagNumber(3)
  set angleTo($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAngleTo() => $_has(2);
  @$pb.TagNumber(3)
  void clearAngleTo() => clearField(3);
}

class GoboChannel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GoboChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..pc<Gobo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gobos', $pb.PbFieldType.PM, subBuilder: Gobo.create)
    ..hasRequiredFields = false
  ;

  GoboChannel._() : super();
  factory GoboChannel({
    $core.double? value,
    $core.Iterable<Gobo>? gobos,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (gobos != null) {
      _result.gobos.addAll(gobos);
    }
    return _result;
  }
  factory GoboChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GoboChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GoboChannel clone() => GoboChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GoboChannel copyWith(void Function(GoboChannel) updates) => super.copyWith((message) => updates(message as GoboChannel)) as GoboChannel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GoboChannel create() => GoboChannel._();
  GoboChannel createEmptyInstance() => create();
  static $pb.PbList<GoboChannel> createRepeated() => $pb.PbList<GoboChannel>();
  @$core.pragma('dart2js:noInline')
  static GoboChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GoboChannel>(create);
  static GoboChannel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Gobo> get gobos => $_getList(1);
}

enum Gobo_Image {
  svg, 
  raster, 
  notSet
}

class Gobo extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Gobo_Image> _Gobo_ImageByTag = {
    3 : Gobo_Image.svg,
    4 : Gobo_Image.raster,
    0 : Gobo_Image.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Gobo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'svg')
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'raster', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Gobo._() : super();
  factory Gobo({
    $core.String? name,
    $core.double? value,
    $core.String? svg,
    $core.List<$core.int>? raster,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (value != null) {
      _result.value = value;
    }
    if (svg != null) {
      _result.svg = svg;
    }
    if (raster != null) {
      _result.raster = raster;
    }
    return _result;
  }
  factory Gobo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Gobo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Gobo clone() => Gobo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Gobo copyWith(void Function(Gobo) updates) => super.copyWith((message) => updates(message as Gobo)) as Gobo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Gobo create() => Gobo._();
  Gobo createEmptyInstance() => create();
  static $pb.PbList<Gobo> createRepeated() => $pb.PbList<Gobo>();
  @$core.pragma('dart2js:noInline')
  static Gobo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Gobo>(create);
  static Gobo? _defaultInstance;

  Gobo_Image whichImage() => _Gobo_ImageByTag[$_whichOneof(0)]!;
  void clearImage() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get svg => $_getSZ(2);
  @$pb.TagNumber(3)
  set svg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSvg() => $_has(2);
  @$pb.TagNumber(3)
  void clearSvg() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get raster => $_getN(3);
  @$pb.TagNumber(4)
  set raster($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRaster() => $_has(3);
  @$pb.TagNumber(4)
  void clearRaster() => clearField(4);
}

class GenericChannel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenericChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  GenericChannel._() : super();
  factory GenericChannel({
    $core.double? value,
    $core.String? name,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory GenericChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenericChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenericChannel clone() => GenericChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenericChannel copyWith(void Function(GenericChannel) updates) => super.copyWith((message) => updates(message as GenericChannel)) as GenericChannel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenericChannel create() => GenericChannel._();
  GenericChannel createEmptyInstance() => create();
  static $pb.PbList<GenericChannel> createRepeated() => $pb.PbList<GenericChannel>();
  @$core.pragma('dart2js:noInline')
  static GenericChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenericChannel>(create);
  static GenericChannel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class GetFixtureDefinitionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFixtureDefinitionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetFixtureDefinitionsRequest._() : super();
  factory GetFixtureDefinitionsRequest() => create();
  factory GetFixtureDefinitionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFixtureDefinitionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFixtureDefinitionsRequest clone() => GetFixtureDefinitionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFixtureDefinitionsRequest copyWith(void Function(GetFixtureDefinitionsRequest) updates) => super.copyWith((message) => updates(message as GetFixtureDefinitionsRequest)) as GetFixtureDefinitionsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureDefinitions', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..pc<FixtureDefinition>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'definitions', $pb.PbFieldType.PM, subBuilder: FixtureDefinition.create)
    ..hasRequiredFields = false
  ;

  FixtureDefinitions._() : super();
  factory FixtureDefinitions({
    $core.Iterable<FixtureDefinition>? definitions,
  }) {
    final _result = create();
    if (definitions != null) {
      _result.definitions.addAll(definitions);
    }
    return _result;
  }
  factory FixtureDefinitions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureDefinitions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureDefinitions clone() => FixtureDefinitions()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureDefinitions copyWith(void Function(FixtureDefinitions) updates) => super.copyWith((message) => updates(message as FixtureDefinitions)) as FixtureDefinitions; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureDefinition', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'manufacturer')
    ..pc<FixtureMode>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'modes', $pb.PbFieldType.PM, subBuilder: FixtureMode.create)
    ..aOM<FixturePhysicalData>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'physical', subBuilder: FixturePhysicalData.create)
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..hasRequiredFields = false
  ;

  FixtureDefinition._() : super();
  factory FixtureDefinition({
    $core.String? id,
    $core.String? name,
    $core.String? manufacturer,
    $core.Iterable<FixtureMode>? modes,
    FixturePhysicalData? physical,
    $core.Iterable<$core.String>? tags,
    $core.String? provider,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (manufacturer != null) {
      _result.manufacturer = manufacturer;
    }
    if (modes != null) {
      _result.modes.addAll(modes);
    }
    if (physical != null) {
      _result.physical = physical;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (provider != null) {
      _result.provider = provider;
    }
    return _result;
  }
  factory FixtureDefinition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureDefinition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureDefinition clone() => FixtureDefinition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureDefinition copyWith(void Function(FixtureDefinition) updates) => super.copyWith((message) => updates(message as FixtureDefinition)) as FixtureDefinition; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureMode', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<FixtureChannel>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: FixtureChannel.create)
    ..hasRequiredFields = false
  ;

  FixtureMode._() : super();
  factory FixtureMode({
    $core.String? name,
    $core.Iterable<FixtureChannel>? channels,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (channels != null) {
      _result.channels.addAll(channels);
    }
    return _result;
  }
  factory FixtureMode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureMode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureMode clone() => FixtureMode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureMode copyWith(void Function(FixtureMode) updates) => super.copyWith((message) => updates(message as FixtureMode)) as FixtureMode; // ignore: deprecated_member_use
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
  $core.List<FixtureChannel> get channels => $_getList(1);
}

class FixtureChannel_CoarseResolution extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureChannel.CoarseResolution', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  FixtureChannel_CoarseResolution._() : super();
  factory FixtureChannel_CoarseResolution({
    $core.int? channel,
  }) {
    final _result = create();
    if (channel != null) {
      _result.channel = channel;
    }
    return _result;
  }
  factory FixtureChannel_CoarseResolution.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureChannel_CoarseResolution.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureChannel_CoarseResolution clone() => FixtureChannel_CoarseResolution()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureChannel_CoarseResolution copyWith(void Function(FixtureChannel_CoarseResolution) updates) => super.copyWith((message) => updates(message as FixtureChannel_CoarseResolution)) as FixtureChannel_CoarseResolution; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureChannel_CoarseResolution create() => FixtureChannel_CoarseResolution._();
  FixtureChannel_CoarseResolution createEmptyInstance() => create();
  static $pb.PbList<FixtureChannel_CoarseResolution> createRepeated() => $pb.PbList<FixtureChannel_CoarseResolution>();
  @$core.pragma('dart2js:noInline')
  static FixtureChannel_CoarseResolution getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureChannel_CoarseResolution>(create);
  static FixtureChannel_CoarseResolution? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get channel => $_getIZ(0);
  @$pb.TagNumber(1)
  set channel($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);
}

class FixtureChannel_FineResolution extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureChannel.FineResolution', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fineChannel', $pb.PbFieldType.OU3, protoName: 'fineChannel')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coarseChannel', $pb.PbFieldType.OU3, protoName: 'coarseChannel')
    ..hasRequiredFields = false
  ;

  FixtureChannel_FineResolution._() : super();
  factory FixtureChannel_FineResolution({
    $core.int? fineChannel,
    $core.int? coarseChannel,
  }) {
    final _result = create();
    if (fineChannel != null) {
      _result.fineChannel = fineChannel;
    }
    if (coarseChannel != null) {
      _result.coarseChannel = coarseChannel;
    }
    return _result;
  }
  factory FixtureChannel_FineResolution.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureChannel_FineResolution.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureChannel_FineResolution clone() => FixtureChannel_FineResolution()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureChannel_FineResolution copyWith(void Function(FixtureChannel_FineResolution) updates) => super.copyWith((message) => updates(message as FixtureChannel_FineResolution)) as FixtureChannel_FineResolution; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureChannel_FineResolution create() => FixtureChannel_FineResolution._();
  FixtureChannel_FineResolution createEmptyInstance() => create();
  static $pb.PbList<FixtureChannel_FineResolution> createRepeated() => $pb.PbList<FixtureChannel_FineResolution>();
  @$core.pragma('dart2js:noInline')
  static FixtureChannel_FineResolution getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureChannel_FineResolution>(create);
  static FixtureChannel_FineResolution? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get fineChannel => $_getIZ(0);
  @$pb.TagNumber(1)
  set fineChannel($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFineChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearFineChannel() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get coarseChannel => $_getIZ(1);
  @$pb.TagNumber(2)
  set coarseChannel($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCoarseChannel() => $_has(1);
  @$pb.TagNumber(2)
  void clearCoarseChannel() => clearField(2);
}

class FixtureChannel_FinestResolution extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureChannel.FinestResolution', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'finestChannel', $pb.PbFieldType.OU3, protoName: 'finestChannel')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fineChannel', $pb.PbFieldType.OU3, protoName: 'fineChannel')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coarseChannel', $pb.PbFieldType.OU3, protoName: 'coarseChannel')
    ..hasRequiredFields = false
  ;

  FixtureChannel_FinestResolution._() : super();
  factory FixtureChannel_FinestResolution({
    $core.int? finestChannel,
    $core.int? fineChannel,
    $core.int? coarseChannel,
  }) {
    final _result = create();
    if (finestChannel != null) {
      _result.finestChannel = finestChannel;
    }
    if (fineChannel != null) {
      _result.fineChannel = fineChannel;
    }
    if (coarseChannel != null) {
      _result.coarseChannel = coarseChannel;
    }
    return _result;
  }
  factory FixtureChannel_FinestResolution.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureChannel_FinestResolution.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureChannel_FinestResolution clone() => FixtureChannel_FinestResolution()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureChannel_FinestResolution copyWith(void Function(FixtureChannel_FinestResolution) updates) => super.copyWith((message) => updates(message as FixtureChannel_FinestResolution)) as FixtureChannel_FinestResolution; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureChannel_FinestResolution create() => FixtureChannel_FinestResolution._();
  FixtureChannel_FinestResolution createEmptyInstance() => create();
  static $pb.PbList<FixtureChannel_FinestResolution> createRepeated() => $pb.PbList<FixtureChannel_FinestResolution>();
  @$core.pragma('dart2js:noInline')
  static FixtureChannel_FinestResolution getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureChannel_FinestResolution>(create);
  static FixtureChannel_FinestResolution? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get finestChannel => $_getIZ(0);
  @$pb.TagNumber(1)
  set finestChannel($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFinestChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearFinestChannel() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get fineChannel => $_getIZ(1);
  @$pb.TagNumber(2)
  set fineChannel($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFineChannel() => $_has(1);
  @$pb.TagNumber(2)
  void clearFineChannel() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get coarseChannel => $_getIZ(2);
  @$pb.TagNumber(3)
  set coarseChannel($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCoarseChannel() => $_has(2);
  @$pb.TagNumber(3)
  void clearCoarseChannel() => clearField(3);
}

enum FixtureChannel_Resolution {
  coarse, 
  fine, 
  finest, 
  notSet
}

class FixtureChannel extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, FixtureChannel_Resolution> _FixtureChannel_ResolutionByTag = {
    2 : FixtureChannel_Resolution.coarse,
    3 : FixtureChannel_Resolution.fine,
    4 : FixtureChannel_Resolution.finest,
    0 : FixtureChannel_Resolution.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOM<FixtureChannel_CoarseResolution>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coarse', subBuilder: FixtureChannel_CoarseResolution.create)
    ..aOM<FixtureChannel_FineResolution>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fine', subBuilder: FixtureChannel_FineResolution.create)
    ..aOM<FixtureChannel_FinestResolution>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'finest', subBuilder: FixtureChannel_FinestResolution.create)
    ..hasRequiredFields = false
  ;

  FixtureChannel._() : super();
  factory FixtureChannel({
    $core.String? name,
    FixtureChannel_CoarseResolution? coarse,
    FixtureChannel_FineResolution? fine,
    FixtureChannel_FinestResolution? finest,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (coarse != null) {
      _result.coarse = coarse;
    }
    if (fine != null) {
      _result.fine = fine;
    }
    if (finest != null) {
      _result.finest = finest;
    }
    return _result;
  }
  factory FixtureChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureChannel clone() => FixtureChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureChannel copyWith(void Function(FixtureChannel) updates) => super.copyWith((message) => updates(message as FixtureChannel)) as FixtureChannel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureChannel create() => FixtureChannel._();
  FixtureChannel createEmptyInstance() => create();
  static $pb.PbList<FixtureChannel> createRepeated() => $pb.PbList<FixtureChannel>();
  @$core.pragma('dart2js:noInline')
  static FixtureChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureChannel>(create);
  static FixtureChannel? _defaultInstance;

  FixtureChannel_Resolution whichResolution() => _FixtureChannel_ResolutionByTag[$_whichOneof(0)]!;
  void clearResolution() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  FixtureChannel_CoarseResolution get coarse => $_getN(1);
  @$pb.TagNumber(2)
  set coarse(FixtureChannel_CoarseResolution v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCoarse() => $_has(1);
  @$pb.TagNumber(2)
  void clearCoarse() => clearField(2);
  @$pb.TagNumber(2)
  FixtureChannel_CoarseResolution ensureCoarse() => $_ensure(1);

  @$pb.TagNumber(3)
  FixtureChannel_FineResolution get fine => $_getN(2);
  @$pb.TagNumber(3)
  set fine(FixtureChannel_FineResolution v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFine() => $_has(2);
  @$pb.TagNumber(3)
  void clearFine() => clearField(3);
  @$pb.TagNumber(3)
  FixtureChannel_FineResolution ensureFine() => $_ensure(2);

  @$pb.TagNumber(4)
  FixtureChannel_FinestResolution get finest => $_getN(3);
  @$pb.TagNumber(4)
  set finest(FixtureChannel_FinestResolution v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasFinest() => $_has(3);
  @$pb.TagNumber(4)
  void clearFinest() => clearField(4);
  @$pb.TagNumber(4)
  FixtureChannel_FinestResolution ensureFinest() => $_ensure(3);
}

class FixturePhysicalData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixturePhysicalData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OF)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OF)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'depth', $pb.PbFieldType.OF)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'weight', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  FixturePhysicalData._() : super();
  factory FixturePhysicalData({
    $core.double? width,
    $core.double? height,
    $core.double? depth,
    $core.double? weight,
  }) {
    final _result = create();
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    if (depth != null) {
      _result.depth = depth;
    }
    if (weight != null) {
      _result.weight = weight;
    }
    return _result;
  }
  factory FixturePhysicalData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixturePhysicalData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixturePhysicalData clone() => FixturePhysicalData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixturePhysicalData copyWith(void Function(FixturePhysicalData) updates) => super.copyWith((message) => updates(message as FixturePhysicalData)) as FixturePhysicalData; // ignore: deprecated_member_use
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

class FixtureFaderControl extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureFaderControl', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.fixtures'), createEmptyInstance: create)
    ..e<FixtureControl>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'control', $pb.PbFieldType.OE, defaultOrMaker: FixtureControl.INTENSITY, valueOf: FixtureControl.valueOf, enumValues: FixtureControl.values)
    ..e<FixtureFaderControl_ColorMixerControlChannel>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'colorMixerChannel', $pb.PbFieldType.OE, defaultOrMaker: FixtureFaderControl_ColorMixerControlChannel.RED, valueOf: FixtureFaderControl_ColorMixerControlChannel.valueOf, enumValues: FixtureFaderControl_ColorMixerControlChannel.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'genericChannel')
    ..hasRequiredFields = false
  ;

  FixtureFaderControl._() : super();
  factory FixtureFaderControl({
    FixtureControl? control,
    FixtureFaderControl_ColorMixerControlChannel? colorMixerChannel,
    $core.String? genericChannel,
  }) {
    final _result = create();
    if (control != null) {
      _result.control = control;
    }
    if (colorMixerChannel != null) {
      _result.colorMixerChannel = colorMixerChannel;
    }
    if (genericChannel != null) {
      _result.genericChannel = genericChannel;
    }
    return _result;
  }
  factory FixtureFaderControl.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureFaderControl.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureFaderControl clone() => FixtureFaderControl()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureFaderControl copyWith(void Function(FixtureFaderControl) updates) => super.copyWith((message) => updates(message as FixtureFaderControl)) as FixtureFaderControl; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureFaderControl create() => FixtureFaderControl._();
  FixtureFaderControl createEmptyInstance() => create();
  static $pb.PbList<FixtureFaderControl> createRepeated() => $pb.PbList<FixtureFaderControl>();
  @$core.pragma('dart2js:noInline')
  static FixtureFaderControl getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureFaderControl>(create);
  static FixtureFaderControl? _defaultInstance;

  @$pb.TagNumber(1)
  FixtureControl get control => $_getN(0);
  @$pb.TagNumber(1)
  set control(FixtureControl v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasControl() => $_has(0);
  @$pb.TagNumber(1)
  void clearControl() => clearField(1);

  @$pb.TagNumber(2)
  FixtureFaderControl_ColorMixerControlChannel get colorMixerChannel => $_getN(1);
  @$pb.TagNumber(2)
  set colorMixerChannel(FixtureFaderControl_ColorMixerControlChannel v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasColorMixerChannel() => $_has(1);
  @$pb.TagNumber(2)
  void clearColorMixerChannel() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get genericChannel => $_getSZ(2);
  @$pb.TagNumber(3)
  set genericChannel($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGenericChannel() => $_has(2);
  @$pb.TagNumber(3)
  void clearGenericChannel() => clearField(3);
}

