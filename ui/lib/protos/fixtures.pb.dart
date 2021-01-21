///
//  Generated code. Do not modify.
//  source: fixtures.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GetFixturesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFixturesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
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
  GetFixturesRequest copyWith(void Function(GetFixturesRequest) updates) => super.copyWith((message) => updates(message as GetFixturesRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFixturesRequest create() => GetFixturesRequest._();
  GetFixturesRequest createEmptyInstance() => create();
  static $pb.PbList<GetFixturesRequest> createRepeated() => $pb.PbList<GetFixturesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFixturesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFixturesRequest>(create);
  static GetFixturesRequest _defaultInstance;
}

class Fixtures extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Fixtures', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..pc<Fixture>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: Fixture.create)
    ..hasRequiredFields = false
  ;

  Fixtures._() : super();
  factory Fixtures({
    $core.Iterable<Fixture> fixtures,
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
  Fixtures copyWith(void Function(Fixtures) updates) => super.copyWith((message) => updates(message as Fixtures)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Fixtures create() => Fixtures._();
  Fixtures createEmptyInstance() => create();
  static $pb.PbList<Fixtures> createRepeated() => $pb.PbList<Fixtures>();
  @$core.pragma('dart2js:noInline')
  static Fixtures getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Fixtures>(create);
  static Fixtures _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Fixture> get fixtures => $_getList(0);
}

class Fixture extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Fixture', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'manufacturer')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'universe', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Fixture._() : super();
  factory Fixture({
    $core.String id,
    $core.String name,
    $core.String manufacturer,
    $core.int universe,
    $core.int channel,
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
    if (universe != null) {
      _result.universe = universe;
    }
    if (channel != null) {
      _result.channel = channel;
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
  Fixture copyWith(void Function(Fixture) updates) => super.copyWith((message) => updates(message as Fixture)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Fixture create() => Fixture._();
  Fixture createEmptyInstance() => create();
  static $pb.PbList<Fixture> createRepeated() => $pb.PbList<Fixture>();
  @$core.pragma('dart2js:noInline')
  static Fixture getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Fixture>(create);
  static Fixture _defaultInstance;

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
  $core.int get universe => $_getIZ(3);
  @$pb.TagNumber(4)
  set universe($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUniverse() => $_has(3);
  @$pb.TagNumber(4)
  void clearUniverse() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get channel => $_getIZ(4);
  @$pb.TagNumber(5)
  set channel($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasChannel() => $_has(4);
  @$pb.TagNumber(5)
  void clearChannel() => clearField(5);
}

