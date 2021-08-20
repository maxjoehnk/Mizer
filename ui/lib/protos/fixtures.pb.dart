///
//  Generated code. Do not modify.
//  source: fixtures.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class AddFixturesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddFixturesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..pc<AddFixtureRequest>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requests', $pb.PbFieldType.PM, subBuilder: AddFixtureRequest.create)
    ..hasRequiredFields = false
  ;

  AddFixturesRequest._() : super();
  factory AddFixturesRequest({
    $core.Iterable<AddFixtureRequest> requests,
  }) {
    final _result = create();
    if (requests != null) {
      _result.requests.addAll(requests);
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
  AddFixturesRequest copyWith(void Function(AddFixturesRequest) updates) => super.copyWith((message) => updates(message as AddFixturesRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddFixturesRequest create() => AddFixturesRequest._();
  AddFixturesRequest createEmptyInstance() => create();
  static $pb.PbList<AddFixturesRequest> createRepeated() => $pb.PbList<AddFixturesRequest>();
  @$core.pragma('dart2js:noInline')
  static AddFixturesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddFixturesRequest>(create);
  static AddFixturesRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AddFixtureRequest> get requests => $_getList(0);
}

class AddFixtureRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddFixtureRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'definitionId', protoName: 'definitionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mode')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'universe', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  AddFixtureRequest._() : super();
  factory AddFixtureRequest({
    $core.String definitionId,
    $core.String mode,
    $core.int id,
    $core.int channel,
    $core.int universe,
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
  AddFixtureRequest copyWith(void Function(AddFixtureRequest) updates) => super.copyWith((message) => updates(message as AddFixtureRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddFixtureRequest create() => AddFixtureRequest._();
  AddFixtureRequest createEmptyInstance() => create();
  static $pb.PbList<AddFixtureRequest> createRepeated() => $pb.PbList<AddFixtureRequest>();
  @$core.pragma('dart2js:noInline')
  static AddFixtureRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddFixtureRequest>(create);
  static AddFixtureRequest _defaultInstance;

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
}

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

enum WriteFixtureChannelRequest_Value {
  fader, 
  color, 
  notSet
}

class WriteFixtureChannelRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, WriteFixtureChannelRequest_Value> _WriteFixtureChannelRequest_ValueByTag = {
    3 : WriteFixtureChannelRequest_Value.fader,
    4 : WriteFixtureChannelRequest_Value.color,
    0 : WriteFixtureChannelRequest_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteFixtureChannelRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..p<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ids', $pb.PbFieldType.PU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fader', $pb.PbFieldType.OD)
    ..aOM<ColorChannel>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', subBuilder: ColorChannel.create)
    ..hasRequiredFields = false
  ;

  WriteFixtureChannelRequest._() : super();
  factory WriteFixtureChannelRequest({
    $core.Iterable<$core.int> ids,
    $core.String channel,
    $core.double fader,
    ColorChannel color,
  }) {
    final _result = create();
    if (ids != null) {
      _result.ids.addAll(ids);
    }
    if (channel != null) {
      _result.channel = channel;
    }
    if (fader != null) {
      _result.fader = fader;
    }
    if (color != null) {
      _result.color = color;
    }
    return _result;
  }
  factory WriteFixtureChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteFixtureChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteFixtureChannelRequest clone() => WriteFixtureChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteFixtureChannelRequest copyWith(void Function(WriteFixtureChannelRequest) updates) => super.copyWith((message) => updates(message as WriteFixtureChannelRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteFixtureChannelRequest create() => WriteFixtureChannelRequest._();
  WriteFixtureChannelRequest createEmptyInstance() => create();
  static $pb.PbList<WriteFixtureChannelRequest> createRepeated() => $pb.PbList<WriteFixtureChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static WriteFixtureChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteFixtureChannelRequest>(create);
  static WriteFixtureChannelRequest _defaultInstance;

  WriteFixtureChannelRequest_Value whichValue() => _WriteFixtureChannelRequest_ValueByTag[$_whichOneof(0)];
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.List<$core.int> get ids => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get channel => $_getSZ(1);
  @$pb.TagNumber(2)
  set channel($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannel() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannel() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get fader => $_getN(2);
  @$pb.TagNumber(3)
  set fader($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFader() => $_has(2);
  @$pb.TagNumber(3)
  void clearFader() => clearField(3);

  @$pb.TagNumber(4)
  ColorChannel get color => $_getN(3);
  @$pb.TagNumber(4)
  set color(ColorChannel v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasColor() => $_has(3);
  @$pb.TagNumber(4)
  void clearColor() => clearField(4);
  @$pb.TagNumber(4)
  ColorChannel ensureColor() => $_ensure(3);
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
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'manufacturer')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mode')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'universe', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..pc<FixtureChannelGroup>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: FixtureChannelGroup.create)
    ..pc<DmxChannel>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dmxChannels', $pb.PbFieldType.PM, protoName: 'dmxChannels', subBuilder: DmxChannel.create)
    ..hasRequiredFields = false
  ;

  Fixture._() : super();
  factory Fixture({
    $core.int id,
    $core.String name,
    $core.String manufacturer,
    $core.String mode,
    $core.int universe,
    $core.int channel,
    $core.Iterable<FixtureChannelGroup> channels,
    $core.Iterable<DmxChannel> dmxChannels,
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
    if (mode != null) {
      _result.mode = mode;
    }
    if (universe != null) {
      _result.universe = universe;
    }
    if (channel != null) {
      _result.channel = channel;
    }
    if (channels != null) {
      _result.channels.addAll(channels);
    }
    if (dmxChannels != null) {
      _result.dmxChannels.addAll(dmxChannels);
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
  $core.String get mode => $_getSZ(3);
  @$pb.TagNumber(4)
  set mode($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMode() => $_has(3);
  @$pb.TagNumber(4)
  void clearMode() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get universe => $_getIZ(4);
  @$pb.TagNumber(5)
  set universe($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUniverse() => $_has(4);
  @$pb.TagNumber(5)
  void clearUniverse() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get channel => $_getIZ(5);
  @$pb.TagNumber(6)
  set channel($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasChannel() => $_has(5);
  @$pb.TagNumber(6)
  void clearChannel() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<FixtureChannelGroup> get channels => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<DmxChannel> get dmxChannels => $_getList(7);
}

enum FixtureChannelGroup_Channel {
  generic, 
  color, 
  pan, 
  tilt, 
  focus, 
  zoom, 
  prism, 
  intensity, 
  shutter, 
  iris, 
  frost, 
  notSet
}

class FixtureChannelGroup extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, FixtureChannelGroup_Channel> _FixtureChannelGroup_ChannelByTag = {
    2 : FixtureChannelGroup_Channel.generic,
    3 : FixtureChannelGroup_Channel.color,
    4 : FixtureChannelGroup_Channel.pan,
    5 : FixtureChannelGroup_Channel.tilt,
    6 : FixtureChannelGroup_Channel.focus,
    7 : FixtureChannelGroup_Channel.zoom,
    8 : FixtureChannelGroup_Channel.prism,
    9 : FixtureChannelGroup_Channel.intensity,
    10 : FixtureChannelGroup_Channel.shutter,
    11 : FixtureChannelGroup_Channel.iris,
    12 : FixtureChannelGroup_Channel.frost,
    0 : FixtureChannelGroup_Channel.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureChannelGroup', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOM<GenericChannel>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generic', subBuilder: GenericChannel.create)
    ..aOM<ColorChannel>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', subBuilder: ColorChannel.create)
    ..aOM<AxisChannel>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pan', subBuilder: AxisChannel.create)
    ..aOM<AxisChannel>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tilt', subBuilder: AxisChannel.create)
    ..aOM<GenericChannel>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'focus', subBuilder: GenericChannel.create)
    ..aOM<GenericChannel>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'zoom', subBuilder: GenericChannel.create)
    ..aOM<GenericChannel>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'prism', subBuilder: GenericChannel.create)
    ..aOM<GenericChannel>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'intensity', subBuilder: GenericChannel.create)
    ..aOM<GenericChannel>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shutter', subBuilder: GenericChannel.create)
    ..aOM<GenericChannel>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'iris', subBuilder: GenericChannel.create)
    ..aOM<GenericChannel>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frost', subBuilder: GenericChannel.create)
    ..hasRequiredFields = false
  ;

  FixtureChannelGroup._() : super();
  factory FixtureChannelGroup({
    $core.String name,
    GenericChannel generic,
    ColorChannel color,
    AxisChannel pan,
    AxisChannel tilt,
    GenericChannel focus,
    GenericChannel zoom,
    GenericChannel prism,
    GenericChannel intensity,
    GenericChannel shutter,
    GenericChannel iris,
    GenericChannel frost,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (generic != null) {
      _result.generic = generic;
    }
    if (color != null) {
      _result.color = color;
    }
    if (pan != null) {
      _result.pan = pan;
    }
    if (tilt != null) {
      _result.tilt = tilt;
    }
    if (focus != null) {
      _result.focus = focus;
    }
    if (zoom != null) {
      _result.zoom = zoom;
    }
    if (prism != null) {
      _result.prism = prism;
    }
    if (intensity != null) {
      _result.intensity = intensity;
    }
    if (shutter != null) {
      _result.shutter = shutter;
    }
    if (iris != null) {
      _result.iris = iris;
    }
    if (frost != null) {
      _result.frost = frost;
    }
    return _result;
  }
  factory FixtureChannelGroup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureChannelGroup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureChannelGroup clone() => FixtureChannelGroup()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureChannelGroup copyWith(void Function(FixtureChannelGroup) updates) => super.copyWith((message) => updates(message as FixtureChannelGroup)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureChannelGroup create() => FixtureChannelGroup._();
  FixtureChannelGroup createEmptyInstance() => create();
  static $pb.PbList<FixtureChannelGroup> createRepeated() => $pb.PbList<FixtureChannelGroup>();
  @$core.pragma('dart2js:noInline')
  static FixtureChannelGroup getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureChannelGroup>(create);
  static FixtureChannelGroup _defaultInstance;

  FixtureChannelGroup_Channel whichChannel() => _FixtureChannelGroup_ChannelByTag[$_whichOneof(0)];
  void clearChannel() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  GenericChannel get generic => $_getN(1);
  @$pb.TagNumber(2)
  set generic(GenericChannel v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasGeneric() => $_has(1);
  @$pb.TagNumber(2)
  void clearGeneric() => clearField(2);
  @$pb.TagNumber(2)
  GenericChannel ensureGeneric() => $_ensure(1);

  @$pb.TagNumber(3)
  ColorChannel get color => $_getN(2);
  @$pb.TagNumber(3)
  set color(ColorChannel v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasColor() => $_has(2);
  @$pb.TagNumber(3)
  void clearColor() => clearField(3);
  @$pb.TagNumber(3)
  ColorChannel ensureColor() => $_ensure(2);

  @$pb.TagNumber(4)
  AxisChannel get pan => $_getN(3);
  @$pb.TagNumber(4)
  set pan(AxisChannel v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPan() => $_has(3);
  @$pb.TagNumber(4)
  void clearPan() => clearField(4);
  @$pb.TagNumber(4)
  AxisChannel ensurePan() => $_ensure(3);

  @$pb.TagNumber(5)
  AxisChannel get tilt => $_getN(4);
  @$pb.TagNumber(5)
  set tilt(AxisChannel v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTilt() => $_has(4);
  @$pb.TagNumber(5)
  void clearTilt() => clearField(5);
  @$pb.TagNumber(5)
  AxisChannel ensureTilt() => $_ensure(4);

  @$pb.TagNumber(6)
  GenericChannel get focus => $_getN(5);
  @$pb.TagNumber(6)
  set focus(GenericChannel v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasFocus() => $_has(5);
  @$pb.TagNumber(6)
  void clearFocus() => clearField(6);
  @$pb.TagNumber(6)
  GenericChannel ensureFocus() => $_ensure(5);

  @$pb.TagNumber(7)
  GenericChannel get zoom => $_getN(6);
  @$pb.TagNumber(7)
  set zoom(GenericChannel v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasZoom() => $_has(6);
  @$pb.TagNumber(7)
  void clearZoom() => clearField(7);
  @$pb.TagNumber(7)
  GenericChannel ensureZoom() => $_ensure(6);

  @$pb.TagNumber(8)
  GenericChannel get prism => $_getN(7);
  @$pb.TagNumber(8)
  set prism(GenericChannel v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasPrism() => $_has(7);
  @$pb.TagNumber(8)
  void clearPrism() => clearField(8);
  @$pb.TagNumber(8)
  GenericChannel ensurePrism() => $_ensure(7);

  @$pb.TagNumber(9)
  GenericChannel get intensity => $_getN(8);
  @$pb.TagNumber(9)
  set intensity(GenericChannel v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasIntensity() => $_has(8);
  @$pb.TagNumber(9)
  void clearIntensity() => clearField(9);
  @$pb.TagNumber(9)
  GenericChannel ensureIntensity() => $_ensure(8);

  @$pb.TagNumber(10)
  GenericChannel get shutter => $_getN(9);
  @$pb.TagNumber(10)
  set shutter(GenericChannel v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasShutter() => $_has(9);
  @$pb.TagNumber(10)
  void clearShutter() => clearField(10);
  @$pb.TagNumber(10)
  GenericChannel ensureShutter() => $_ensure(9);

  @$pb.TagNumber(11)
  GenericChannel get iris => $_getN(10);
  @$pb.TagNumber(11)
  set iris(GenericChannel v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasIris() => $_has(10);
  @$pb.TagNumber(11)
  void clearIris() => clearField(11);
  @$pb.TagNumber(11)
  GenericChannel ensureIris() => $_ensure(10);

  @$pb.TagNumber(12)
  GenericChannel get frost => $_getN(11);
  @$pb.TagNumber(12)
  set frost(GenericChannel v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasFrost() => $_has(11);
  @$pb.TagNumber(12)
  void clearFrost() => clearField(12);
  @$pb.TagNumber(12)
  GenericChannel ensureFrost() => $_ensure(11);
}

class DmxChannel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DmxChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  DmxChannel._() : super();
  factory DmxChannel({
    $core.String name,
    $core.double value,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory DmxChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DmxChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DmxChannel clone() => DmxChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DmxChannel copyWith(void Function(DmxChannel) updates) => super.copyWith((message) => updates(message as DmxChannel)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DmxChannel create() => DmxChannel._();
  DmxChannel createEmptyInstance() => create();
  static $pb.PbList<DmxChannel> createRepeated() => $pb.PbList<DmxChannel>();
  @$core.pragma('dart2js:noInline')
  static DmxChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DmxChannel>(create);
  static DmxChannel _defaultInstance;

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
}

class GenericChannel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenericChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GenericChannel._() : super();
  factory GenericChannel({
    $core.double value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
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
  GenericChannel copyWith(void Function(GenericChannel) updates) => super.copyWith((message) => updates(message as GenericChannel)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenericChannel create() => GenericChannel._();
  GenericChannel createEmptyInstance() => create();
  static $pb.PbList<GenericChannel> createRepeated() => $pb.PbList<GenericChannel>();
  @$core.pragma('dart2js:noInline')
  static GenericChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenericChannel>(create);
  static GenericChannel _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class ColorChannel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ColorChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'red', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'green', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ColorChannel._() : super();
  factory ColorChannel({
    $core.double red,
    $core.double green,
    $core.double blue,
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
  factory ColorChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ColorChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ColorChannel clone() => ColorChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ColorChannel copyWith(void Function(ColorChannel) updates) => super.copyWith((message) => updates(message as ColorChannel)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ColorChannel create() => ColorChannel._();
  ColorChannel createEmptyInstance() => create();
  static $pb.PbList<ColorChannel> createRepeated() => $pb.PbList<ColorChannel>();
  @$core.pragma('dart2js:noInline')
  static ColorChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ColorChannel>(create);
  static ColorChannel _defaultInstance;

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

class AxisChannel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AxisChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'angleFrom', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'angleTo', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  AxisChannel._() : super();
  factory AxisChannel({
    $core.double value,
    $core.double angleFrom,
    $core.double angleTo,
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
  AxisChannel copyWith(void Function(AxisChannel) updates) => super.copyWith((message) => updates(message as AxisChannel)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AxisChannel create() => AxisChannel._();
  AxisChannel createEmptyInstance() => create();
  static $pb.PbList<AxisChannel> createRepeated() => $pb.PbList<AxisChannel>();
  @$core.pragma('dart2js:noInline')
  static AxisChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AxisChannel>(create);
  static AxisChannel _defaultInstance;

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

class GetFixtureDefinitionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFixtureDefinitionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
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
  GetFixtureDefinitionsRequest copyWith(void Function(GetFixtureDefinitionsRequest) updates) => super.copyWith((message) => updates(message as GetFixtureDefinitionsRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFixtureDefinitionsRequest create() => GetFixtureDefinitionsRequest._();
  GetFixtureDefinitionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFixtureDefinitionsRequest> createRepeated() => $pb.PbList<GetFixtureDefinitionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFixtureDefinitionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFixtureDefinitionsRequest>(create);
  static GetFixtureDefinitionsRequest _defaultInstance;
}

class FixtureDefinitions extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureDefinitions', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..pc<FixtureDefinition>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'definitions', $pb.PbFieldType.PM, subBuilder: FixtureDefinition.create)
    ..hasRequiredFields = false
  ;

  FixtureDefinitions._() : super();
  factory FixtureDefinitions({
    $core.Iterable<FixtureDefinition> definitions,
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
  FixtureDefinitions copyWith(void Function(FixtureDefinitions) updates) => super.copyWith((message) => updates(message as FixtureDefinitions)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureDefinitions create() => FixtureDefinitions._();
  FixtureDefinitions createEmptyInstance() => create();
  static $pb.PbList<FixtureDefinitions> createRepeated() => $pb.PbList<FixtureDefinitions>();
  @$core.pragma('dart2js:noInline')
  static FixtureDefinitions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureDefinitions>(create);
  static FixtureDefinitions _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FixtureDefinition> get definitions => $_getList(0);
}

class FixtureDefinition extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureDefinition', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'manufacturer')
    ..pc<FixtureMode>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'modes', $pb.PbFieldType.PM, subBuilder: FixtureMode.create)
    ..aOM<FixturePhysicalData>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'physical', subBuilder: FixturePhysicalData.create)
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags')
    ..hasRequiredFields = false
  ;

  FixtureDefinition._() : super();
  factory FixtureDefinition({
    $core.String id,
    $core.String name,
    $core.String manufacturer,
    $core.Iterable<FixtureMode> modes,
    FixturePhysicalData physical,
    $core.Iterable<$core.String> tags,
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
  FixtureDefinition copyWith(void Function(FixtureDefinition) updates) => super.copyWith((message) => updates(message as FixtureDefinition)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureDefinition create() => FixtureDefinition._();
  FixtureDefinition createEmptyInstance() => create();
  static $pb.PbList<FixtureDefinition> createRepeated() => $pb.PbList<FixtureDefinition>();
  @$core.pragma('dart2js:noInline')
  static FixtureDefinition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureDefinition>(create);
  static FixtureDefinition _defaultInstance;

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
}

class FixtureMode extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureMode', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<FixtureChannel>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: FixtureChannel.create)
    ..hasRequiredFields = false
  ;

  FixtureMode._() : super();
  factory FixtureMode({
    $core.String name,
    $core.Iterable<FixtureChannel> channels,
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
  FixtureMode copyWith(void Function(FixtureMode) updates) => super.copyWith((message) => updates(message as FixtureMode)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureMode create() => FixtureMode._();
  FixtureMode createEmptyInstance() => create();
  static $pb.PbList<FixtureMode> createRepeated() => $pb.PbList<FixtureMode>();
  @$core.pragma('dart2js:noInline')
  static FixtureMode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureMode>(create);
  static FixtureMode _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureChannel.CoarseResolution', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  FixtureChannel_CoarseResolution._() : super();
  factory FixtureChannel_CoarseResolution({
    $core.int channel,
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
  FixtureChannel_CoarseResolution copyWith(void Function(FixtureChannel_CoarseResolution) updates) => super.copyWith((message) => updates(message as FixtureChannel_CoarseResolution)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureChannel_CoarseResolution create() => FixtureChannel_CoarseResolution._();
  FixtureChannel_CoarseResolution createEmptyInstance() => create();
  static $pb.PbList<FixtureChannel_CoarseResolution> createRepeated() => $pb.PbList<FixtureChannel_CoarseResolution>();
  @$core.pragma('dart2js:noInline')
  static FixtureChannel_CoarseResolution getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureChannel_CoarseResolution>(create);
  static FixtureChannel_CoarseResolution _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureChannel.FineResolution', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fineChannel', $pb.PbFieldType.OU3, protoName: 'fineChannel')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coarseChannel', $pb.PbFieldType.OU3, protoName: 'coarseChannel')
    ..hasRequiredFields = false
  ;

  FixtureChannel_FineResolution._() : super();
  factory FixtureChannel_FineResolution({
    $core.int fineChannel,
    $core.int coarseChannel,
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
  FixtureChannel_FineResolution copyWith(void Function(FixtureChannel_FineResolution) updates) => super.copyWith((message) => updates(message as FixtureChannel_FineResolution)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureChannel_FineResolution create() => FixtureChannel_FineResolution._();
  FixtureChannel_FineResolution createEmptyInstance() => create();
  static $pb.PbList<FixtureChannel_FineResolution> createRepeated() => $pb.PbList<FixtureChannel_FineResolution>();
  @$core.pragma('dart2js:noInline')
  static FixtureChannel_FineResolution getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureChannel_FineResolution>(create);
  static FixtureChannel_FineResolution _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureChannel.FinestResolution', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'finestChannel', $pb.PbFieldType.OU3, protoName: 'finestChannel')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fineChannel', $pb.PbFieldType.OU3, protoName: 'fineChannel')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coarseChannel', $pb.PbFieldType.OU3, protoName: 'coarseChannel')
    ..hasRequiredFields = false
  ;

  FixtureChannel_FinestResolution._() : super();
  factory FixtureChannel_FinestResolution({
    $core.int finestChannel,
    $core.int fineChannel,
    $core.int coarseChannel,
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
  FixtureChannel_FinestResolution copyWith(void Function(FixtureChannel_FinestResolution) updates) => super.copyWith((message) => updates(message as FixtureChannel_FinestResolution)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureChannel_FinestResolution create() => FixtureChannel_FinestResolution._();
  FixtureChannel_FinestResolution createEmptyInstance() => create();
  static $pb.PbList<FixtureChannel_FinestResolution> createRepeated() => $pb.PbList<FixtureChannel_FinestResolution>();
  @$core.pragma('dart2js:noInline')
  static FixtureChannel_FinestResolution getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureChannel_FinestResolution>(create);
  static FixtureChannel_FinestResolution _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOM<FixtureChannel_CoarseResolution>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coarse', subBuilder: FixtureChannel_CoarseResolution.create)
    ..aOM<FixtureChannel_FineResolution>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fine', subBuilder: FixtureChannel_FineResolution.create)
    ..aOM<FixtureChannel_FinestResolution>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'finest', subBuilder: FixtureChannel_FinestResolution.create)
    ..hasRequiredFields = false
  ;

  FixtureChannel._() : super();
  factory FixtureChannel({
    $core.String name,
    FixtureChannel_CoarseResolution coarse,
    FixtureChannel_FineResolution fine,
    FixtureChannel_FinestResolution finest,
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
  FixtureChannel copyWith(void Function(FixtureChannel) updates) => super.copyWith((message) => updates(message as FixtureChannel)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureChannel create() => FixtureChannel._();
  FixtureChannel createEmptyInstance() => create();
  static $pb.PbList<FixtureChannel> createRepeated() => $pb.PbList<FixtureChannel>();
  @$core.pragma('dart2js:noInline')
  static FixtureChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureChannel>(create);
  static FixtureChannel _defaultInstance;

  FixtureChannel_Resolution whichResolution() => _FixtureChannel_ResolutionByTag[$_whichOneof(0)];
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixturePhysicalData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OF)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OF)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'depth', $pb.PbFieldType.OF)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'weight', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  FixturePhysicalData._() : super();
  factory FixturePhysicalData({
    $core.double width,
    $core.double height,
    $core.double depth,
    $core.double weight,
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
  FixturePhysicalData copyWith(void Function(FixturePhysicalData) updates) => super.copyWith((message) => updates(message as FixturePhysicalData)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixturePhysicalData create() => FixturePhysicalData._();
  FixturePhysicalData createEmptyInstance() => create();
  static $pb.PbList<FixturePhysicalData> createRepeated() => $pb.PbList<FixturePhysicalData>();
  @$core.pragma('dart2js:noInline')
  static FixturePhysicalData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixturePhysicalData>(create);
  static FixturePhysicalData _defaultInstance;

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

