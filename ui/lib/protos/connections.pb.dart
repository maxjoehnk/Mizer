///
//  Generated code. Do not modify.
//  source: connections.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'connections.pbenum.dart';

export 'connections.pbenum.dart';

class MonitorDmxRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonitorDmxRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputId', protoName: 'outputId')
    ..hasRequiredFields = false
  ;

  MonitorDmxRequest._() : super();
  factory MonitorDmxRequest({
    $core.String? outputId,
  }) {
    final _result = create();
    if (outputId != null) {
      _result.outputId = outputId;
    }
    return _result;
  }
  factory MonitorDmxRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorDmxRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorDmxRequest clone() => MonitorDmxRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorDmxRequest copyWith(void Function(MonitorDmxRequest) updates) => super.copyWith((message) => updates(message as MonitorDmxRequest)) as MonitorDmxRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MonitorDmxRequest create() => MonitorDmxRequest._();
  MonitorDmxRequest createEmptyInstance() => create();
  static $pb.PbList<MonitorDmxRequest> createRepeated() => $pb.PbList<MonitorDmxRequest>();
  @$core.pragma('dart2js:noInline')
  static MonitorDmxRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonitorDmxRequest>(create);
  static MonitorDmxRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get outputId => $_getSZ(0);
  @$pb.TagNumber(1)
  set outputId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOutputId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutputId() => clearField(1);
}

class MonitorDmxResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonitorDmxResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..pc<MonitorDmxUniverse>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'universes', $pb.PbFieldType.PM, subBuilder: MonitorDmxUniverse.create)
    ..hasRequiredFields = false
  ;

  MonitorDmxResponse._() : super();
  factory MonitorDmxResponse({
    $core.Iterable<MonitorDmxUniverse>? universes,
  }) {
    final _result = create();
    if (universes != null) {
      _result.universes.addAll(universes);
    }
    return _result;
  }
  factory MonitorDmxResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorDmxResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorDmxResponse clone() => MonitorDmxResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorDmxResponse copyWith(void Function(MonitorDmxResponse) updates) => super.copyWith((message) => updates(message as MonitorDmxResponse)) as MonitorDmxResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MonitorDmxResponse create() => MonitorDmxResponse._();
  MonitorDmxResponse createEmptyInstance() => create();
  static $pb.PbList<MonitorDmxResponse> createRepeated() => $pb.PbList<MonitorDmxResponse>();
  @$core.pragma('dart2js:noInline')
  static MonitorDmxResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonitorDmxResponse>(create);
  static MonitorDmxResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MonitorDmxUniverse> get universes => $_getList(0);
}

class MonitorDmxUniverse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonitorDmxUniverse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'universe', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  MonitorDmxUniverse._() : super();
  factory MonitorDmxUniverse({
    $core.int? universe,
    $core.List<$core.int>? channels,
  }) {
    final _result = create();
    if (universe != null) {
      _result.universe = universe;
    }
    if (channels != null) {
      _result.channels = channels;
    }
    return _result;
  }
  factory MonitorDmxUniverse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorDmxUniverse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorDmxUniverse clone() => MonitorDmxUniverse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorDmxUniverse copyWith(void Function(MonitorDmxUniverse) updates) => super.copyWith((message) => updates(message as MonitorDmxUniverse)) as MonitorDmxUniverse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MonitorDmxUniverse create() => MonitorDmxUniverse._();
  MonitorDmxUniverse createEmptyInstance() => create();
  static $pb.PbList<MonitorDmxUniverse> createRepeated() => $pb.PbList<MonitorDmxUniverse>();
  @$core.pragma('dart2js:noInline')
  static MonitorDmxUniverse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonitorDmxUniverse>(create);
  static MonitorDmxUniverse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get universe => $_getIZ(0);
  @$pb.TagNumber(1)
  set universe($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUniverse() => $_has(0);
  @$pb.TagNumber(1)
  void clearUniverse() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get channels => $_getN(1);
  @$pb.TagNumber(2)
  set channels($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannels() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannels() => clearField(2);
}

class GetConnectionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetConnectionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetConnectionsRequest._() : super();
  factory GetConnectionsRequest() => create();
  factory GetConnectionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetConnectionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetConnectionsRequest clone() => GetConnectionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetConnectionsRequest copyWith(void Function(GetConnectionsRequest) updates) => super.copyWith((message) => updates(message as GetConnectionsRequest)) as GetConnectionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetConnectionsRequest create() => GetConnectionsRequest._();
  GetConnectionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetConnectionsRequest> createRepeated() => $pb.PbList<GetConnectionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetConnectionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetConnectionsRequest>(create);
  static GetConnectionsRequest? _defaultInstance;
}

class Connections extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Connections', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..pc<Connection>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'connections', $pb.PbFieldType.PM, subBuilder: Connection.create)
    ..hasRequiredFields = false
  ;

  Connections._() : super();
  factory Connections({
    $core.Iterable<Connection>? connections,
  }) {
    final _result = create();
    if (connections != null) {
      _result.connections.addAll(connections);
    }
    return _result;
  }
  factory Connections.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Connections.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Connections clone() => Connections()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Connections copyWith(void Function(Connections) updates) => super.copyWith((message) => updates(message as Connections)) as Connections; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Connections create() => Connections._();
  Connections createEmptyInstance() => create();
  static $pb.PbList<Connections> createRepeated() => $pb.PbList<Connections>();
  @$core.pragma('dart2js:noInline')
  static Connections getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Connections>(create);
  static Connections? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Connection> get connections => $_getList(0);
}

enum Connection_Connection {
  dmx, 
  midi, 
  osc, 
  proDJLink, 
  helios, 
  notSet
}

class Connection extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Connection_Connection> _Connection_ConnectionByTag = {
    10 : Connection_Connection.dmx,
    11 : Connection_Connection.midi,
    12 : Connection_Connection.osc,
    13 : Connection_Connection.proDJLink,
    14 : Connection_Connection.helios,
    0 : Connection_Connection.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Connection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..oo(0, [10, 11, 12, 13, 14])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOM<DmxConnection>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dmx', subBuilder: DmxConnection.create)
    ..aOM<MidiConnection>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'midi', subBuilder: MidiConnection.create)
    ..aOM<OscConnection>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'osc', subBuilder: OscConnection.create)
    ..aOM<ProDjLinkConnection>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'proDJLink', protoName: 'proDJLink', subBuilder: ProDjLinkConnection.create)
    ..aOM<HeliosConnection>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'helios', subBuilder: HeliosConnection.create)
    ..hasRequiredFields = false
  ;

  Connection._() : super();
  factory Connection({
    $core.String? name,
    DmxConnection? dmx,
    MidiConnection? midi,
    OscConnection? osc,
    ProDjLinkConnection? proDJLink,
    HeliosConnection? helios,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (dmx != null) {
      _result.dmx = dmx;
    }
    if (midi != null) {
      _result.midi = midi;
    }
    if (osc != null) {
      _result.osc = osc;
    }
    if (proDJLink != null) {
      _result.proDJLink = proDJLink;
    }
    if (helios != null) {
      _result.helios = helios;
    }
    return _result;
  }
  factory Connection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Connection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Connection clone() => Connection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Connection copyWith(void Function(Connection) updates) => super.copyWith((message) => updates(message as Connection)) as Connection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Connection create() => Connection._();
  Connection createEmptyInstance() => create();
  static $pb.PbList<Connection> createRepeated() => $pb.PbList<Connection>();
  @$core.pragma('dart2js:noInline')
  static Connection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Connection>(create);
  static Connection? _defaultInstance;

  Connection_Connection whichConnection() => _Connection_ConnectionByTag[$_whichOneof(0)]!;
  void clearConnection() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(10)
  DmxConnection get dmx => $_getN(1);
  @$pb.TagNumber(10)
  set dmx(DmxConnection v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasDmx() => $_has(1);
  @$pb.TagNumber(10)
  void clearDmx() => clearField(10);
  @$pb.TagNumber(10)
  DmxConnection ensureDmx() => $_ensure(1);

  @$pb.TagNumber(11)
  MidiConnection get midi => $_getN(2);
  @$pb.TagNumber(11)
  set midi(MidiConnection v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasMidi() => $_has(2);
  @$pb.TagNumber(11)
  void clearMidi() => clearField(11);
  @$pb.TagNumber(11)
  MidiConnection ensureMidi() => $_ensure(2);

  @$pb.TagNumber(12)
  OscConnection get osc => $_getN(3);
  @$pb.TagNumber(12)
  set osc(OscConnection v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasOsc() => $_has(3);
  @$pb.TagNumber(12)
  void clearOsc() => clearField(12);
  @$pb.TagNumber(12)
  OscConnection ensureOsc() => $_ensure(3);

  @$pb.TagNumber(13)
  ProDjLinkConnection get proDJLink => $_getN(4);
  @$pb.TagNumber(13)
  set proDJLink(ProDjLinkConnection v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasProDJLink() => $_has(4);
  @$pb.TagNumber(13)
  void clearProDJLink() => clearField(13);
  @$pb.TagNumber(13)
  ProDjLinkConnection ensureProDJLink() => $_ensure(4);

  @$pb.TagNumber(14)
  HeliosConnection get helios => $_getN(5);
  @$pb.TagNumber(14)
  set helios(HeliosConnection v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasHelios() => $_has(5);
  @$pb.TagNumber(14)
  void clearHelios() => clearField(14);
  @$pb.TagNumber(14)
  HeliosConnection ensureHelios() => $_ensure(5);
}

class DmxConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DmxConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputId', protoName: 'outputId')
    ..hasRequiredFields = false
  ;

  DmxConnection._() : super();
  factory DmxConnection({
    $core.String? outputId,
  }) {
    final _result = create();
    if (outputId != null) {
      _result.outputId = outputId;
    }
    return _result;
  }
  factory DmxConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DmxConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DmxConnection clone() => DmxConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DmxConnection copyWith(void Function(DmxConnection) updates) => super.copyWith((message) => updates(message as DmxConnection)) as DmxConnection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DmxConnection create() => DmxConnection._();
  DmxConnection createEmptyInstance() => create();
  static $pb.PbList<DmxConnection> createRepeated() => $pb.PbList<DmxConnection>();
  @$core.pragma('dart2js:noInline')
  static DmxConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DmxConnection>(create);
  static DmxConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get outputId => $_getSZ(0);
  @$pb.TagNumber(1)
  set outputId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOutputId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutputId() => clearField(1);
}

class HeliosConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HeliosConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firmware')
    ..hasRequiredFields = false
  ;

  HeliosConnection._() : super();
  factory HeliosConnection({
    $core.String? name,
    $core.String? firmware,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (firmware != null) {
      _result.firmware = firmware;
    }
    return _result;
  }
  factory HeliosConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HeliosConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HeliosConnection clone() => HeliosConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HeliosConnection copyWith(void Function(HeliosConnection) updates) => super.copyWith((message) => updates(message as HeliosConnection)) as HeliosConnection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HeliosConnection create() => HeliosConnection._();
  HeliosConnection createEmptyInstance() => create();
  static $pb.PbList<HeliosConnection> createRepeated() => $pb.PbList<HeliosConnection>();
  @$core.pragma('dart2js:noInline')
  static HeliosConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HeliosConnection>(create);
  static HeliosConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get firmware => $_getSZ(1);
  @$pb.TagNumber(2)
  set firmware($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirmware() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirmware() => clearField(2);
}

class MidiConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  MidiConnection._() : super();
  factory MidiConnection() => create();
  factory MidiConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiConnection clone() => MidiConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiConnection copyWith(void Function(MidiConnection) updates) => super.copyWith((message) => updates(message as MidiConnection)) as MidiConnection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MidiConnection create() => MidiConnection._();
  MidiConnection createEmptyInstance() => create();
  static $pb.PbList<MidiConnection> createRepeated() => $pb.PbList<MidiConnection>();
  @$core.pragma('dart2js:noInline')
  static MidiConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiConnection>(create);
  static MidiConnection? _defaultInstance;
}

class OscConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OscConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inputPort', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputPort', $pb.PbFieldType.OU3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputAddress')
    ..hasRequiredFields = false
  ;

  OscConnection._() : super();
  factory OscConnection({
    $core.int? inputPort,
    $core.int? outputPort,
    $core.String? outputAddress,
  }) {
    final _result = create();
    if (inputPort != null) {
      _result.inputPort = inputPort;
    }
    if (outputPort != null) {
      _result.outputPort = outputPort;
    }
    if (outputAddress != null) {
      _result.outputAddress = outputAddress;
    }
    return _result;
  }
  factory OscConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OscConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OscConnection clone() => OscConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OscConnection copyWith(void Function(OscConnection) updates) => super.copyWith((message) => updates(message as OscConnection)) as OscConnection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OscConnection create() => OscConnection._();
  OscConnection createEmptyInstance() => create();
  static $pb.PbList<OscConnection> createRepeated() => $pb.PbList<OscConnection>();
  @$core.pragma('dart2js:noInline')
  static OscConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OscConnection>(create);
  static OscConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get inputPort => $_getIZ(0);
  @$pb.TagNumber(1)
  set inputPort($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInputPort() => $_has(0);
  @$pb.TagNumber(1)
  void clearInputPort() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get outputPort => $_getIZ(1);
  @$pb.TagNumber(2)
  set outputPort($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOutputPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutputPort() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get outputAddress => $_getSZ(2);
  @$pb.TagNumber(3)
  set outputAddress($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOutputAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearOutputAddress() => clearField(3);
}

class ProDjLinkConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProDjLinkConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'model')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerNumber', $pb.PbFieldType.OU3, protoName: 'playerNumber')
    ..aOM<CdjPlayback>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playback', subBuilder: CdjPlayback.create)
    ..hasRequiredFields = false
  ;

  ProDjLinkConnection._() : super();
  factory ProDjLinkConnection({
    $core.String? address,
    $core.String? model,
    $core.int? playerNumber,
    CdjPlayback? playback,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    if (model != null) {
      _result.model = model;
    }
    if (playerNumber != null) {
      _result.playerNumber = playerNumber;
    }
    if (playback != null) {
      _result.playback = playback;
    }
    return _result;
  }
  factory ProDjLinkConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProDjLinkConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProDjLinkConnection clone() => ProDjLinkConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProDjLinkConnection copyWith(void Function(ProDjLinkConnection) updates) => super.copyWith((message) => updates(message as ProDjLinkConnection)) as ProDjLinkConnection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProDjLinkConnection create() => ProDjLinkConnection._();
  ProDjLinkConnection createEmptyInstance() => create();
  static $pb.PbList<ProDjLinkConnection> createRepeated() => $pb.PbList<ProDjLinkConnection>();
  @$core.pragma('dart2js:noInline')
  static ProDjLinkConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProDjLinkConnection>(create);
  static ProDjLinkConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get model => $_getSZ(1);
  @$pb.TagNumber(2)
  set model($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasModel() => $_has(1);
  @$pb.TagNumber(2)
  void clearModel() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get playerNumber => $_getIZ(2);
  @$pb.TagNumber(3)
  set playerNumber($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPlayerNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlayerNumber() => clearField(3);

  @$pb.TagNumber(5)
  CdjPlayback get playback => $_getN(3);
  @$pb.TagNumber(5)
  set playback(CdjPlayback v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPlayback() => $_has(3);
  @$pb.TagNumber(5)
  void clearPlayback() => clearField(5);
  @$pb.TagNumber(5)
  CdjPlayback ensurePlayback() => $_ensure(3);
}

class CdjPlayback_Track extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CdjPlayback.Track', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'artist')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..hasRequiredFields = false
  ;

  CdjPlayback_Track._() : super();
  factory CdjPlayback_Track({
    $core.String? artist,
    $core.String? title,
  }) {
    final _result = create();
    if (artist != null) {
      _result.artist = artist;
    }
    if (title != null) {
      _result.title = title;
    }
    return _result;
  }
  factory CdjPlayback_Track.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CdjPlayback_Track.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CdjPlayback_Track clone() => CdjPlayback_Track()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CdjPlayback_Track copyWith(void Function(CdjPlayback_Track) updates) => super.copyWith((message) => updates(message as CdjPlayback_Track)) as CdjPlayback_Track; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CdjPlayback_Track create() => CdjPlayback_Track._();
  CdjPlayback_Track createEmptyInstance() => create();
  static $pb.PbList<CdjPlayback_Track> createRepeated() => $pb.PbList<CdjPlayback_Track>();
  @$core.pragma('dart2js:noInline')
  static CdjPlayback_Track getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CdjPlayback_Track>(create);
  static CdjPlayback_Track? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get artist => $_getSZ(0);
  @$pb.TagNumber(1)
  set artist($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasArtist() => $_has(0);
  @$pb.TagNumber(1)
  void clearArtist() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);
}

class CdjPlayback extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CdjPlayback', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'live')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bpm', $pb.PbFieldType.OD)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frame', $pb.PbFieldType.OU3)
    ..e<CdjPlayback_State>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playback', $pb.PbFieldType.OE, defaultOrMaker: CdjPlayback_State.Loading, valueOf: CdjPlayback_State.valueOf, enumValues: CdjPlayback_State.values)
    ..aOM<CdjPlayback_Track>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'track', subBuilder: CdjPlayback_Track.create)
    ..hasRequiredFields = false
  ;

  CdjPlayback._() : super();
  factory CdjPlayback({
    $core.bool? live,
    $core.double? bpm,
    $core.int? frame,
    CdjPlayback_State? playback,
    CdjPlayback_Track? track,
  }) {
    final _result = create();
    if (live != null) {
      _result.live = live;
    }
    if (bpm != null) {
      _result.bpm = bpm;
    }
    if (frame != null) {
      _result.frame = frame;
    }
    if (playback != null) {
      _result.playback = playback;
    }
    if (track != null) {
      _result.track = track;
    }
    return _result;
  }
  factory CdjPlayback.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CdjPlayback.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CdjPlayback clone() => CdjPlayback()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CdjPlayback copyWith(void Function(CdjPlayback) updates) => super.copyWith((message) => updates(message as CdjPlayback)) as CdjPlayback; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CdjPlayback create() => CdjPlayback._();
  CdjPlayback createEmptyInstance() => create();
  static $pb.PbList<CdjPlayback> createRepeated() => $pb.PbList<CdjPlayback>();
  @$core.pragma('dart2js:noInline')
  static CdjPlayback getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CdjPlayback>(create);
  static CdjPlayback? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get live => $_getBF(0);
  @$pb.TagNumber(1)
  set live($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLive() => $_has(0);
  @$pb.TagNumber(1)
  void clearLive() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get bpm => $_getN(1);
  @$pb.TagNumber(2)
  set bpm($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBpm() => $_has(1);
  @$pb.TagNumber(2)
  void clearBpm() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get frame => $_getIZ(2);
  @$pb.TagNumber(3)
  set frame($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFrame() => $_has(2);
  @$pb.TagNumber(3)
  void clearFrame() => clearField(3);

  @$pb.TagNumber(4)
  CdjPlayback_State get playback => $_getN(3);
  @$pb.TagNumber(4)
  set playback(CdjPlayback_State v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPlayback() => $_has(3);
  @$pb.TagNumber(4)
  void clearPlayback() => clearField(4);

  @$pb.TagNumber(5)
  CdjPlayback_Track get track => $_getN(4);
  @$pb.TagNumber(5)
  set track(CdjPlayback_Track v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTrack() => $_has(4);
  @$pb.TagNumber(5)
  void clearTrack() => clearField(5);
  @$pb.TagNumber(5)
  CdjPlayback_Track ensureTrack() => $_ensure(4);
}

