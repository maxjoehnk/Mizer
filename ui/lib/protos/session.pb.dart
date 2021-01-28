///
//  Generated code. Do not modify.
//  source: session.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ClientAnnouncement extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClientAnnouncement', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  ClientAnnouncement._() : super();
  factory ClientAnnouncement({
    $core.String name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory ClientAnnouncement.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClientAnnouncement.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClientAnnouncement clone() => ClientAnnouncement()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClientAnnouncement copyWith(void Function(ClientAnnouncement) updates) => super.copyWith((message) => updates(message as ClientAnnouncement)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClientAnnouncement create() => ClientAnnouncement._();
  ClientAnnouncement createEmptyInstance() => create();
  static $pb.PbList<ClientAnnouncement> createRepeated() => $pb.PbList<ClientAnnouncement>();
  @$core.pragma('dart2js:noInline')
  static ClientAnnouncement getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClientAnnouncement>(create);
  static ClientAnnouncement _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class SessionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SessionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SessionRequest._() : super();
  factory SessionRequest() => create();
  factory SessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SessionRequest clone() => SessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SessionRequest copyWith(void Function(SessionRequest) updates) => super.copyWith((message) => updates(message as SessionRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SessionRequest create() => SessionRequest._();
  SessionRequest createEmptyInstance() => create();
  static $pb.PbList<SessionRequest> createRepeated() => $pb.PbList<SessionRequest>();
  @$core.pragma('dart2js:noInline')
  static SessionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SessionRequest>(create);
  static SessionRequest _defaultInstance;
}

class Session extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Session', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..pc<SessionDevice>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'devices', $pb.PbFieldType.PM, subBuilder: SessionDevice.create)
    ..hasRequiredFields = false
  ;

  Session._() : super();
  factory Session({
    $core.Iterable<SessionDevice> devices,
  }) {
    final _result = create();
    if (devices != null) {
      _result.devices.addAll(devices);
    }
    return _result;
  }
  factory Session.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Session.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Session clone() => Session()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Session copyWith(void Function(Session) updates) => super.copyWith((message) => updates(message as Session)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Session create() => Session._();
  Session createEmptyInstance() => create();
  static $pb.PbList<Session> createRepeated() => $pb.PbList<Session>();
  @$core.pragma('dart2js:noInline')
  static Session getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Session>(create);
  static Session _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SessionDevice> get devices => $_getList(0);
}

class SessionDevice extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SessionDevice', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ips')
    ..aOM<DeviceClock>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'clock', subBuilder: DeviceClock.create)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ping', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  SessionDevice._() : super();
  factory SessionDevice({
    $core.String name,
    $core.Iterable<$core.String> ips,
    DeviceClock clock,
    $core.double ping,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (ips != null) {
      _result.ips.addAll(ips);
    }
    if (clock != null) {
      _result.clock = clock;
    }
    if (ping != null) {
      _result.ping = ping;
    }
    return _result;
  }
  factory SessionDevice.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SessionDevice.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SessionDevice clone() => SessionDevice()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SessionDevice copyWith(void Function(SessionDevice) updates) => super.copyWith((message) => updates(message as SessionDevice)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SessionDevice create() => SessionDevice._();
  SessionDevice createEmptyInstance() => create();
  static $pb.PbList<SessionDevice> createRepeated() => $pb.PbList<SessionDevice>();
  @$core.pragma('dart2js:noInline')
  static SessionDevice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SessionDevice>(create);
  static SessionDevice _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get ips => $_getList(1);

  @$pb.TagNumber(3)
  DeviceClock get clock => $_getN(2);
  @$pb.TagNumber(3)
  set clock(DeviceClock v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasClock() => $_has(2);
  @$pb.TagNumber(3)
  void clearClock() => clearField(3);
  @$pb.TagNumber(3)
  DeviceClock ensureClock() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.double get ping => $_getN(3);
  @$pb.TagNumber(4)
  set ping($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPing() => $_has(3);
  @$pb.TagNumber(4)
  void clearPing() => clearField(4);
}

class DeviceClock extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeviceClock', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'master')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'drift', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  DeviceClock._() : super();
  factory DeviceClock({
    $core.bool master,
    $core.double drift,
  }) {
    final _result = create();
    if (master != null) {
      _result.master = master;
    }
    if (drift != null) {
      _result.drift = drift;
    }
    return _result;
  }
  factory DeviceClock.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeviceClock.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeviceClock clone() => DeviceClock()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeviceClock copyWith(void Function(DeviceClock) updates) => super.copyWith((message) => updates(message as DeviceClock)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeviceClock create() => DeviceClock._();
  DeviceClock createEmptyInstance() => create();
  static $pb.PbList<DeviceClock> createRepeated() => $pb.PbList<DeviceClock>();
  @$core.pragma('dart2js:noInline')
  static DeviceClock getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeviceClock>(create);
  static DeviceClock _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get master => $_getBF(0);
  @$pb.TagNumber(1)
  set master($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMaster() => $_has(0);
  @$pb.TagNumber(1)
  void clearMaster() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get drift => $_getN(1);
  @$pb.TagNumber(2)
  set drift($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDrift() => $_has(1);
  @$pb.TagNumber(2)
  void clearDrift() => clearField(2);
}

