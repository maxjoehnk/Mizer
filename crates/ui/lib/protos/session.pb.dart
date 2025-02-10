///
//  Generated code. Do not modify.
//  source: session.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'session.pbenum.dart';

export 'session.pbenum.dart';

class LoadProjectRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoadProjectRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.session'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..hasRequiredFields = false
  ;

  LoadProjectRequest._() : super();
  factory LoadProjectRequest({
    $core.String? path,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    return _result;
  }
  factory LoadProjectRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoadProjectRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoadProjectRequest clone() => LoadProjectRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoadProjectRequest copyWith(void Function(LoadProjectRequest) updates) => super.copyWith((message) => updates(message as LoadProjectRequest)) as LoadProjectRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoadProjectRequest create() => LoadProjectRequest._();
  LoadProjectRequest createEmptyInstance() => create();
  static $pb.PbList<LoadProjectRequest> createRepeated() => $pb.PbList<LoadProjectRequest>();
  @$core.pragma('dart2js:noInline')
  static LoadProjectRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoadProjectRequest>(create);
  static LoadProjectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);
}

class SaveProjectAsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SaveProjectAsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.session'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..hasRequiredFields = false
  ;

  SaveProjectAsRequest._() : super();
  factory SaveProjectAsRequest({
    $core.String? path,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    return _result;
  }
  factory SaveProjectAsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SaveProjectAsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SaveProjectAsRequest clone() => SaveProjectAsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SaveProjectAsRequest copyWith(void Function(SaveProjectAsRequest) updates) => super.copyWith((message) => updates(message as SaveProjectAsRequest)) as SaveProjectAsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SaveProjectAsRequest create() => SaveProjectAsRequest._();
  SaveProjectAsRequest createEmptyInstance() => create();
  static $pb.PbList<SaveProjectAsRequest> createRepeated() => $pb.PbList<SaveProjectAsRequest>();
  @$core.pragma('dart2js:noInline')
  static SaveProjectAsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SaveProjectAsRequest>(create);
  static SaveProjectAsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);
}

class LoadProjectResult_MigrationResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoadProjectResult.MigrationResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.session'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'to', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  LoadProjectResult_MigrationResult._() : super();
  factory LoadProjectResult_MigrationResult({
    $core.int? from,
    $core.int? to,
  }) {
    final _result = create();
    if (from != null) {
      _result.from = from;
    }
    if (to != null) {
      _result.to = to;
    }
    return _result;
  }
  factory LoadProjectResult_MigrationResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoadProjectResult_MigrationResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoadProjectResult_MigrationResult clone() => LoadProjectResult_MigrationResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoadProjectResult_MigrationResult copyWith(void Function(LoadProjectResult_MigrationResult) updates) => super.copyWith((message) => updates(message as LoadProjectResult_MigrationResult)) as LoadProjectResult_MigrationResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoadProjectResult_MigrationResult create() => LoadProjectResult_MigrationResult._();
  LoadProjectResult_MigrationResult createEmptyInstance() => create();
  static $pb.PbList<LoadProjectResult_MigrationResult> createRepeated() => $pb.PbList<LoadProjectResult_MigrationResult>();
  @$core.pragma('dart2js:noInline')
  static LoadProjectResult_MigrationResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoadProjectResult_MigrationResult>(create);
  static LoadProjectResult_MigrationResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get from => $_getIZ(0);
  @$pb.TagNumber(1)
  set from($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFrom() => $_has(0);
  @$pb.TagNumber(1)
  void clearFrom() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get to => $_getIZ(1);
  @$pb.TagNumber(2)
  set to($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTo() => $_has(1);
  @$pb.TagNumber(2)
  void clearTo() => clearField(2);
}

class LoadProjectResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoadProjectResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.session'), createEmptyInstance: create)
    ..e<LoadProjectResult_State>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: LoadProjectResult_State.OK, valueOf: LoadProjectResult_State.valueOf, enumValues: LoadProjectResult_State.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'issues')
    ..aOM<LoadProjectResult_MigrationResult>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'migration', subBuilder: LoadProjectResult_MigrationResult.create)
    ..hasRequiredFields = false
  ;

  LoadProjectResult._() : super();
  factory LoadProjectResult({
    LoadProjectResult_State? state,
    $core.String? error,
    $core.Iterable<$core.String>? issues,
    LoadProjectResult_MigrationResult? migration,
  }) {
    final _result = create();
    if (state != null) {
      _result.state = state;
    }
    if (error != null) {
      _result.error = error;
    }
    if (issues != null) {
      _result.issues.addAll(issues);
    }
    if (migration != null) {
      _result.migration = migration;
    }
    return _result;
  }
  factory LoadProjectResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoadProjectResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoadProjectResult clone() => LoadProjectResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoadProjectResult copyWith(void Function(LoadProjectResult) updates) => super.copyWith((message) => updates(message as LoadProjectResult)) as LoadProjectResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoadProjectResult create() => LoadProjectResult._();
  LoadProjectResult createEmptyInstance() => create();
  static $pb.PbList<LoadProjectResult> createRepeated() => $pb.PbList<LoadProjectResult>();
  @$core.pragma('dart2js:noInline')
  static LoadProjectResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoadProjectResult>(create);
  static LoadProjectResult? _defaultInstance;

  @$pb.TagNumber(1)
  LoadProjectResult_State get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(LoadProjectResult_State v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get issues => $_getList(2);

  @$pb.TagNumber(4)
  LoadProjectResult_MigrationResult get migration => $_getN(3);
  @$pb.TagNumber(4)
  set migration(LoadProjectResult_MigrationResult v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMigration() => $_has(3);
  @$pb.TagNumber(4)
  void clearMigration() => clearField(4);
  @$pb.TagNumber(4)
  LoadProjectResult_MigrationResult ensureMigration() => $_ensure(3);
}

class ClientAnnouncement extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClientAnnouncement', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.session'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  ClientAnnouncement._() : super();
  factory ClientAnnouncement({
    $core.String? name,
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
  ClientAnnouncement copyWith(void Function(ClientAnnouncement) updates) => super.copyWith((message) => updates(message as ClientAnnouncement)) as ClientAnnouncement; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClientAnnouncement create() => ClientAnnouncement._();
  ClientAnnouncement createEmptyInstance() => create();
  static $pb.PbList<ClientAnnouncement> createRepeated() => $pb.PbList<ClientAnnouncement>();
  @$core.pragma('dart2js:noInline')
  static ClientAnnouncement getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClientAnnouncement>(create);
  static ClientAnnouncement? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class Session extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Session', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.session'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filePath')
    ..pc<SessionDevice>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'devices', $pb.PbFieldType.PM, subBuilder: SessionDevice.create)
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'projectHistory')
    ..hasRequiredFields = false
  ;

  Session._() : super();
  factory Session({
    $core.String? filePath,
    $core.Iterable<SessionDevice>? devices,
    $core.Iterable<$core.String>? projectHistory,
  }) {
    final _result = create();
    if (filePath != null) {
      _result.filePath = filePath;
    }
    if (devices != null) {
      _result.devices.addAll(devices);
    }
    if (projectHistory != null) {
      _result.projectHistory.addAll(projectHistory);
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
  Session copyWith(void Function(Session) updates) => super.copyWith((message) => updates(message as Session)) as Session; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Session create() => Session._();
  Session createEmptyInstance() => create();
  static $pb.PbList<Session> createRepeated() => $pb.PbList<Session>();
  @$core.pragma('dart2js:noInline')
  static Session getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Session>(create);
  static Session? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get filePath => $_getSZ(0);
  @$pb.TagNumber(1)
  set filePath($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFilePath() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilePath() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<SessionDevice> get devices => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.String> get projectHistory => $_getList(2);
}

class SessionDevice extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SessionDevice', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.session'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ips')
    ..aOM<DeviceClock>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'clock', subBuilder: DeviceClock.create)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ping', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  SessionDevice._() : super();
  factory SessionDevice({
    $core.String? name,
    $core.Iterable<$core.String>? ips,
    DeviceClock? clock,
    $core.double? ping,
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
  SessionDevice copyWith(void Function(SessionDevice) updates) => super.copyWith((message) => updates(message as SessionDevice)) as SessionDevice; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SessionDevice create() => SessionDevice._();
  SessionDevice createEmptyInstance() => create();
  static $pb.PbList<SessionDevice> createRepeated() => $pb.PbList<SessionDevice>();
  @$core.pragma('dart2js:noInline')
  static SessionDevice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SessionDevice>(create);
  static SessionDevice? _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeviceClock', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.session'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'master')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'drift', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  DeviceClock._() : super();
  factory DeviceClock({
    $core.bool? master,
    $core.double? drift,
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
  DeviceClock copyWith(void Function(DeviceClock) updates) => super.copyWith((message) => updates(message as DeviceClock)) as DeviceClock; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeviceClock create() => DeviceClock._();
  DeviceClock createEmptyInstance() => create();
  static $pb.PbList<DeviceClock> createRepeated() => $pb.PbList<DeviceClock>();
  @$core.pragma('dart2js:noInline')
  static DeviceClock getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeviceClock>(create);
  static DeviceClock? _defaultInstance;

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

class History extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'History', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.session'), createEmptyInstance: create)
    ..pc<HistoryItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: HistoryItem.create)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pointer', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  History._() : super();
  factory History({
    $core.Iterable<HistoryItem>? items,
    $fixnum.Int64? pointer,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    if (pointer != null) {
      _result.pointer = pointer;
    }
    return _result;
  }
  factory History.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory History.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  History clone() => History()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  History copyWith(void Function(History) updates) => super.copyWith((message) => updates(message as History)) as History; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static History create() => History._();
  History createEmptyInstance() => create();
  static $pb.PbList<History> createRepeated() => $pb.PbList<History>();
  @$core.pragma('dart2js:noInline')
  static History getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<History>(create);
  static History? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<HistoryItem> get items => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pointer => $_getI64(1);
  @$pb.TagNumber(2)
  set pointer($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPointer() => $_has(1);
  @$pb.TagNumber(2)
  void clearPointer() => clearField(2);
}

class HistoryItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HistoryItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.session'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  HistoryItem._() : super();
  factory HistoryItem({
    $core.String? label,
    $fixnum.Int64? timestamp,
  }) {
    final _result = create();
    if (label != null) {
      _result.label = label;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    return _result;
  }
  factory HistoryItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HistoryItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HistoryItem clone() => HistoryItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HistoryItem copyWith(void Function(HistoryItem) updates) => super.copyWith((message) => updates(message as HistoryItem)) as HistoryItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HistoryItem create() => HistoryItem._();
  HistoryItem createEmptyInstance() => create();
  static $pb.PbList<HistoryItem> createRepeated() => $pb.PbList<HistoryItem>();
  @$core.pragma('dart2js:noInline')
  static HistoryItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HistoryItem>(create);
  static HistoryItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get timestamp => $_getI64(1);
  @$pb.TagNumber(2)
  set timestamp($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestamp() => clearField(2);
}

