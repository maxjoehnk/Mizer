//
//  Generated code. Do not modify.
//  source: connections.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'connections.pbenum.dart';

export 'connections.pbenum.dart';

class MonitorDmxRequest extends $pb.GeneratedMessage {
  factory MonitorDmxRequest({
    $core.String? outputId,
  }) {
    final $result = create();
    if (outputId != null) {
      $result.outputId = outputId;
    }
    return $result;
  }
  MonitorDmxRequest._() : super();
  factory MonitorDmxRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorDmxRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MonitorDmxRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'outputId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorDmxRequest clone() => MonitorDmxRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorDmxRequest copyWith(void Function(MonitorDmxRequest) updates) => super.copyWith((message) => updates(message as MonitorDmxRequest)) as MonitorDmxRequest;

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

class ChangeMidiDeviceProfileRequest extends $pb.GeneratedMessage {
  factory ChangeMidiDeviceProfileRequest({
    $core.String? deviceId,
    $core.String? profileId,
  }) {
    final $result = create();
    if (deviceId != null) {
      $result.deviceId = deviceId;
    }
    if (profileId != null) {
      $result.profileId = profileId;
    }
    return $result;
  }
  ChangeMidiDeviceProfileRequest._() : super();
  factory ChangeMidiDeviceProfileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangeMidiDeviceProfileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChangeMidiDeviceProfileRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceId')
    ..aOS(2, _omitFieldNames ? '' : 'profileId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangeMidiDeviceProfileRequest clone() => ChangeMidiDeviceProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangeMidiDeviceProfileRequest copyWith(void Function(ChangeMidiDeviceProfileRequest) updates) => super.copyWith((message) => updates(message as ChangeMidiDeviceProfileRequest)) as ChangeMidiDeviceProfileRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangeMidiDeviceProfileRequest create() => ChangeMidiDeviceProfileRequest._();
  ChangeMidiDeviceProfileRequest createEmptyInstance() => create();
  static $pb.PbList<ChangeMidiDeviceProfileRequest> createRepeated() => $pb.PbList<ChangeMidiDeviceProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static ChangeMidiDeviceProfileRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangeMidiDeviceProfileRequest>(create);
  static ChangeMidiDeviceProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get profileId => $_getSZ(1);
  @$pb.TagNumber(2)
  set profileId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProfileId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProfileId() => clearField(2);
}

class MonitorDmxResponse extends $pb.GeneratedMessage {
  factory MonitorDmxResponse({
    $core.Iterable<MonitorDmxUniverse>? universes,
  }) {
    final $result = create();
    if (universes != null) {
      $result.universes.addAll(universes);
    }
    return $result;
  }
  MonitorDmxResponse._() : super();
  factory MonitorDmxResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorDmxResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MonitorDmxResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..pc<MonitorDmxUniverse>(1, _omitFieldNames ? '' : 'universes', $pb.PbFieldType.PM, subBuilder: MonitorDmxUniverse.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorDmxResponse clone() => MonitorDmxResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorDmxResponse copyWith(void Function(MonitorDmxResponse) updates) => super.copyWith((message) => updates(message as MonitorDmxResponse)) as MonitorDmxResponse;

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
  factory MonitorDmxUniverse({
    $core.int? universe,
    $core.List<$core.int>? channels,
  }) {
    final $result = create();
    if (universe != null) {
      $result.universe = universe;
    }
    if (channels != null) {
      $result.channels = channels;
    }
    return $result;
  }
  MonitorDmxUniverse._() : super();
  factory MonitorDmxUniverse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorDmxUniverse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MonitorDmxUniverse', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'universe', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorDmxUniverse clone() => MonitorDmxUniverse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorDmxUniverse copyWith(void Function(MonitorDmxUniverse) updates) => super.copyWith((message) => updates(message as MonitorDmxUniverse)) as MonitorDmxUniverse;

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

class MonitorMidiRequest extends $pb.GeneratedMessage {
  factory MonitorMidiRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  MonitorMidiRequest._() : super();
  factory MonitorMidiRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorMidiRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MonitorMidiRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorMidiRequest clone() => MonitorMidiRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorMidiRequest copyWith(void Function(MonitorMidiRequest) updates) => super.copyWith((message) => updates(message as MonitorMidiRequest)) as MonitorMidiRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitorMidiRequest create() => MonitorMidiRequest._();
  MonitorMidiRequest createEmptyInstance() => create();
  static $pb.PbList<MonitorMidiRequest> createRepeated() => $pb.PbList<MonitorMidiRequest>();
  @$core.pragma('dart2js:noInline')
  static MonitorMidiRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonitorMidiRequest>(create);
  static MonitorMidiRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class MonitorMidiResponse_NoteMsg extends $pb.GeneratedMessage {
  factory MonitorMidiResponse_NoteMsg({
    $core.int? channel,
    $core.int? note,
    $core.int? value,
  }) {
    final $result = create();
    if (channel != null) {
      $result.channel = channel;
    }
    if (note != null) {
      $result.note = note;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  MonitorMidiResponse_NoteMsg._() : super();
  factory MonitorMidiResponse_NoteMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorMidiResponse_NoteMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MonitorMidiResponse.NoteMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'channel', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'note', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorMidiResponse_NoteMsg clone() => MonitorMidiResponse_NoteMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorMidiResponse_NoteMsg copyWith(void Function(MonitorMidiResponse_NoteMsg) updates) => super.copyWith((message) => updates(message as MonitorMidiResponse_NoteMsg)) as MonitorMidiResponse_NoteMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitorMidiResponse_NoteMsg create() => MonitorMidiResponse_NoteMsg._();
  MonitorMidiResponse_NoteMsg createEmptyInstance() => create();
  static $pb.PbList<MonitorMidiResponse_NoteMsg> createRepeated() => $pb.PbList<MonitorMidiResponse_NoteMsg>();
  @$core.pragma('dart2js:noInline')
  static MonitorMidiResponse_NoteMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonitorMidiResponse_NoteMsg>(create);
  static MonitorMidiResponse_NoteMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get channel => $_getIZ(0);
  @$pb.TagNumber(1)
  set channel($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get note => $_getIZ(1);
  @$pb.TagNumber(2)
  set note($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNote() => $_has(1);
  @$pb.TagNumber(2)
  void clearNote() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get value => $_getIZ(2);
  @$pb.TagNumber(3)
  set value($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => clearField(3);
}

class MonitorMidiResponse_SysEx extends $pb.GeneratedMessage {
  factory MonitorMidiResponse_SysEx({
    $core.int? manufacturer1,
    $core.int? manufacturer2,
    $core.int? manufacturer3,
    $core.int? model,
    $core.List<$core.int>? data,
  }) {
    final $result = create();
    if (manufacturer1 != null) {
      $result.manufacturer1 = manufacturer1;
    }
    if (manufacturer2 != null) {
      $result.manufacturer2 = manufacturer2;
    }
    if (manufacturer3 != null) {
      $result.manufacturer3 = manufacturer3;
    }
    if (model != null) {
      $result.model = model;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  MonitorMidiResponse_SysEx._() : super();
  factory MonitorMidiResponse_SysEx.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorMidiResponse_SysEx.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MonitorMidiResponse.SysEx', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'manufacturer1', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'manufacturer2', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'manufacturer3', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'model', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorMidiResponse_SysEx clone() => MonitorMidiResponse_SysEx()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorMidiResponse_SysEx copyWith(void Function(MonitorMidiResponse_SysEx) updates) => super.copyWith((message) => updates(message as MonitorMidiResponse_SysEx)) as MonitorMidiResponse_SysEx;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitorMidiResponse_SysEx create() => MonitorMidiResponse_SysEx._();
  MonitorMidiResponse_SysEx createEmptyInstance() => create();
  static $pb.PbList<MonitorMidiResponse_SysEx> createRepeated() => $pb.PbList<MonitorMidiResponse_SysEx>();
  @$core.pragma('dart2js:noInline')
  static MonitorMidiResponse_SysEx getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonitorMidiResponse_SysEx>(create);
  static MonitorMidiResponse_SysEx? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get manufacturer1 => $_getIZ(0);
  @$pb.TagNumber(1)
  set manufacturer1($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasManufacturer1() => $_has(0);
  @$pb.TagNumber(1)
  void clearManufacturer1() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get manufacturer2 => $_getIZ(1);
  @$pb.TagNumber(2)
  set manufacturer2($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasManufacturer2() => $_has(1);
  @$pb.TagNumber(2)
  void clearManufacturer2() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get manufacturer3 => $_getIZ(2);
  @$pb.TagNumber(3)
  set manufacturer3($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasManufacturer3() => $_has(2);
  @$pb.TagNumber(3)
  void clearManufacturer3() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get model => $_getIZ(3);
  @$pb.TagNumber(4)
  set model($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasModel() => $_has(3);
  @$pb.TagNumber(4)
  void clearModel() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get data => $_getN(4);
  @$pb.TagNumber(5)
  set data($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasData() => $_has(4);
  @$pb.TagNumber(5)
  void clearData() => clearField(5);
}

enum MonitorMidiResponse_Message {
  cc, 
  noteOff, 
  noteOn, 
  sysEx, 
  unknown, 
  notSet
}

class MonitorMidiResponse extends $pb.GeneratedMessage {
  factory MonitorMidiResponse({
    $fixnum.Int64? timestamp,
    MonitorMidiResponse_NoteMsg? cc,
    MonitorMidiResponse_NoteMsg? noteOff,
    MonitorMidiResponse_NoteMsg? noteOn,
    MonitorMidiResponse_SysEx? sysEx,
    $core.List<$core.int>? unknown,
  }) {
    final $result = create();
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (cc != null) {
      $result.cc = cc;
    }
    if (noteOff != null) {
      $result.noteOff = noteOff;
    }
    if (noteOn != null) {
      $result.noteOn = noteOn;
    }
    if (sysEx != null) {
      $result.sysEx = sysEx;
    }
    if (unknown != null) {
      $result.unknown = unknown;
    }
    return $result;
  }
  MonitorMidiResponse._() : super();
  factory MonitorMidiResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorMidiResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, MonitorMidiResponse_Message> _MonitorMidiResponse_MessageByTag = {
    3 : MonitorMidiResponse_Message.cc,
    4 : MonitorMidiResponse_Message.noteOff,
    5 : MonitorMidiResponse_Message.noteOn,
    6 : MonitorMidiResponse_Message.sysEx,
    7 : MonitorMidiResponse_Message.unknown,
    0 : MonitorMidiResponse_Message.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MonitorMidiResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6, 7])
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<MonitorMidiResponse_NoteMsg>(3, _omitFieldNames ? '' : 'cc', subBuilder: MonitorMidiResponse_NoteMsg.create)
    ..aOM<MonitorMidiResponse_NoteMsg>(4, _omitFieldNames ? '' : 'noteOff', subBuilder: MonitorMidiResponse_NoteMsg.create)
    ..aOM<MonitorMidiResponse_NoteMsg>(5, _omitFieldNames ? '' : 'noteOn', subBuilder: MonitorMidiResponse_NoteMsg.create)
    ..aOM<MonitorMidiResponse_SysEx>(6, _omitFieldNames ? '' : 'sysEx', subBuilder: MonitorMidiResponse_SysEx.create)
    ..a<$core.List<$core.int>>(7, _omitFieldNames ? '' : 'unknown', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorMidiResponse clone() => MonitorMidiResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorMidiResponse copyWith(void Function(MonitorMidiResponse) updates) => super.copyWith((message) => updates(message as MonitorMidiResponse)) as MonitorMidiResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitorMidiResponse create() => MonitorMidiResponse._();
  MonitorMidiResponse createEmptyInstance() => create();
  static $pb.PbList<MonitorMidiResponse> createRepeated() => $pb.PbList<MonitorMidiResponse>();
  @$core.pragma('dart2js:noInline')
  static MonitorMidiResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonitorMidiResponse>(create);
  static MonitorMidiResponse? _defaultInstance;

  MonitorMidiResponse_Message whichMessage() => _MonitorMidiResponse_MessageByTag[$_whichOneof(0)]!;
  void clearMessage() => clearField($_whichOneof(0));

  @$pb.TagNumber(2)
  $fixnum.Int64 get timestamp => $_getI64(0);
  @$pb.TagNumber(2)
  set timestamp($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(2)
  void clearTimestamp() => clearField(2);

  @$pb.TagNumber(3)
  MonitorMidiResponse_NoteMsg get cc => $_getN(1);
  @$pb.TagNumber(3)
  set cc(MonitorMidiResponse_NoteMsg v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCc() => $_has(1);
  @$pb.TagNumber(3)
  void clearCc() => clearField(3);
  @$pb.TagNumber(3)
  MonitorMidiResponse_NoteMsg ensureCc() => $_ensure(1);

  @$pb.TagNumber(4)
  MonitorMidiResponse_NoteMsg get noteOff => $_getN(2);
  @$pb.TagNumber(4)
  set noteOff(MonitorMidiResponse_NoteMsg v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasNoteOff() => $_has(2);
  @$pb.TagNumber(4)
  void clearNoteOff() => clearField(4);
  @$pb.TagNumber(4)
  MonitorMidiResponse_NoteMsg ensureNoteOff() => $_ensure(2);

  @$pb.TagNumber(5)
  MonitorMidiResponse_NoteMsg get noteOn => $_getN(3);
  @$pb.TagNumber(5)
  set noteOn(MonitorMidiResponse_NoteMsg v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasNoteOn() => $_has(3);
  @$pb.TagNumber(5)
  void clearNoteOn() => clearField(5);
  @$pb.TagNumber(5)
  MonitorMidiResponse_NoteMsg ensureNoteOn() => $_ensure(3);

  @$pb.TagNumber(6)
  MonitorMidiResponse_SysEx get sysEx => $_getN(4);
  @$pb.TagNumber(6)
  set sysEx(MonitorMidiResponse_SysEx v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasSysEx() => $_has(4);
  @$pb.TagNumber(6)
  void clearSysEx() => clearField(6);
  @$pb.TagNumber(6)
  MonitorMidiResponse_SysEx ensureSysEx() => $_ensure(4);

  @$pb.TagNumber(7)
  $core.List<$core.int> get unknown => $_getN(5);
  @$pb.TagNumber(7)
  set unknown($core.List<$core.int> v) { $_setBytes(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasUnknown() => $_has(5);
  @$pb.TagNumber(7)
  void clearUnknown() => clearField(7);
}

class MonitorOscRequest extends $pb.GeneratedMessage {
  factory MonitorOscRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  MonitorOscRequest._() : super();
  factory MonitorOscRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorOscRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MonitorOscRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorOscRequest clone() => MonitorOscRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorOscRequest copyWith(void Function(MonitorOscRequest) updates) => super.copyWith((message) => updates(message as MonitorOscRequest)) as MonitorOscRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitorOscRequest create() => MonitorOscRequest._();
  MonitorOscRequest createEmptyInstance() => create();
  static $pb.PbList<MonitorOscRequest> createRepeated() => $pb.PbList<MonitorOscRequest>();
  @$core.pragma('dart2js:noInline')
  static MonitorOscRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonitorOscRequest>(create);
  static MonitorOscRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class MonitorOscResponse_OscArgument_OscColor extends $pb.GeneratedMessage {
  factory MonitorOscResponse_OscArgument_OscColor({
    $core.int? red,
    $core.int? green,
    $core.int? blue,
    $core.int? alpha,
  }) {
    final $result = create();
    if (red != null) {
      $result.red = red;
    }
    if (green != null) {
      $result.green = green;
    }
    if (blue != null) {
      $result.blue = blue;
    }
    if (alpha != null) {
      $result.alpha = alpha;
    }
    return $result;
  }
  MonitorOscResponse_OscArgument_OscColor._() : super();
  factory MonitorOscResponse_OscArgument_OscColor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorOscResponse_OscArgument_OscColor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MonitorOscResponse.OscArgument.OscColor', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'red', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'green', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'blue', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'alpha', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorOscResponse_OscArgument_OscColor clone() => MonitorOscResponse_OscArgument_OscColor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorOscResponse_OscArgument_OscColor copyWith(void Function(MonitorOscResponse_OscArgument_OscColor) updates) => super.copyWith((message) => updates(message as MonitorOscResponse_OscArgument_OscColor)) as MonitorOscResponse_OscArgument_OscColor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitorOscResponse_OscArgument_OscColor create() => MonitorOscResponse_OscArgument_OscColor._();
  MonitorOscResponse_OscArgument_OscColor createEmptyInstance() => create();
  static $pb.PbList<MonitorOscResponse_OscArgument_OscColor> createRepeated() => $pb.PbList<MonitorOscResponse_OscArgument_OscColor>();
  @$core.pragma('dart2js:noInline')
  static MonitorOscResponse_OscArgument_OscColor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonitorOscResponse_OscArgument_OscColor>(create);
  static MonitorOscResponse_OscArgument_OscColor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get red => $_getIZ(0);
  @$pb.TagNumber(1)
  set red($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRed() => $_has(0);
  @$pb.TagNumber(1)
  void clearRed() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get green => $_getIZ(1);
  @$pb.TagNumber(2)
  set green($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGreen() => $_has(1);
  @$pb.TagNumber(2)
  void clearGreen() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get blue => $_getIZ(2);
  @$pb.TagNumber(3)
  set blue($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBlue() => $_has(2);
  @$pb.TagNumber(3)
  void clearBlue() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get alpha => $_getIZ(3);
  @$pb.TagNumber(4)
  set alpha($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAlpha() => $_has(3);
  @$pb.TagNumber(4)
  void clearAlpha() => clearField(4);
}

enum MonitorOscResponse_OscArgument_Argument {
  int_1, 
  float, 
  long, 
  double_4, 
  bool_5, 
  color, 
  string, 
  notSet
}

class MonitorOscResponse_OscArgument extends $pb.GeneratedMessage {
  factory MonitorOscResponse_OscArgument({
    $core.int? int_1,
    $core.double? float,
    $fixnum.Int64? long,
    $core.double? double_4,
    $core.bool? bool_5,
    MonitorOscResponse_OscArgument_OscColor? color,
    $core.String? string,
  }) {
    final $result = create();
    if (int_1 != null) {
      $result.int_1 = int_1;
    }
    if (float != null) {
      $result.float = float;
    }
    if (long != null) {
      $result.long = long;
    }
    if (double_4 != null) {
      $result.double_4 = double_4;
    }
    if (bool_5 != null) {
      $result.bool_5 = bool_5;
    }
    if (color != null) {
      $result.color = color;
    }
    if (string != null) {
      $result.string = string;
    }
    return $result;
  }
  MonitorOscResponse_OscArgument._() : super();
  factory MonitorOscResponse_OscArgument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorOscResponse_OscArgument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, MonitorOscResponse_OscArgument_Argument> _MonitorOscResponse_OscArgument_ArgumentByTag = {
    1 : MonitorOscResponse_OscArgument_Argument.int_1,
    2 : MonitorOscResponse_OscArgument_Argument.float,
    3 : MonitorOscResponse_OscArgument_Argument.long,
    4 : MonitorOscResponse_OscArgument_Argument.double_4,
    5 : MonitorOscResponse_OscArgument_Argument.bool_5,
    6 : MonitorOscResponse_OscArgument_Argument.color,
    7 : MonitorOscResponse_OscArgument_Argument.string,
    0 : MonitorOscResponse_OscArgument_Argument.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MonitorOscResponse.OscArgument', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7])
    ..a<$core.int>(1, _omitFieldNames ? '' : 'int', $pb.PbFieldType.O3)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'float', $pb.PbFieldType.OF)
    ..aInt64(3, _omitFieldNames ? '' : 'long')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'double', $pb.PbFieldType.OD)
    ..aOB(5, _omitFieldNames ? '' : 'bool')
    ..aOM<MonitorOscResponse_OscArgument_OscColor>(6, _omitFieldNames ? '' : 'color', subBuilder: MonitorOscResponse_OscArgument_OscColor.create)
    ..aOS(7, _omitFieldNames ? '' : 'string')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorOscResponse_OscArgument clone() => MonitorOscResponse_OscArgument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorOscResponse_OscArgument copyWith(void Function(MonitorOscResponse_OscArgument) updates) => super.copyWith((message) => updates(message as MonitorOscResponse_OscArgument)) as MonitorOscResponse_OscArgument;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitorOscResponse_OscArgument create() => MonitorOscResponse_OscArgument._();
  MonitorOscResponse_OscArgument createEmptyInstance() => create();
  static $pb.PbList<MonitorOscResponse_OscArgument> createRepeated() => $pb.PbList<MonitorOscResponse_OscArgument>();
  @$core.pragma('dart2js:noInline')
  static MonitorOscResponse_OscArgument getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonitorOscResponse_OscArgument>(create);
  static MonitorOscResponse_OscArgument? _defaultInstance;

  MonitorOscResponse_OscArgument_Argument whichArgument() => _MonitorOscResponse_OscArgument_ArgumentByTag[$_whichOneof(0)]!;
  void clearArgument() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.int get int_1 => $_getIZ(0);
  @$pb.TagNumber(1)
  set int_1($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInt_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearInt_1() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get float => $_getN(1);
  @$pb.TagNumber(2)
  set float($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFloat() => $_has(1);
  @$pb.TagNumber(2)
  void clearFloat() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get long => $_getI64(2);
  @$pb.TagNumber(3)
  set long($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLong() => $_has(2);
  @$pb.TagNumber(3)
  void clearLong() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get double_4 => $_getN(3);
  @$pb.TagNumber(4)
  set double_4($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDouble_4() => $_has(3);
  @$pb.TagNumber(4)
  void clearDouble_4() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get bool_5 => $_getBF(4);
  @$pb.TagNumber(5)
  set bool_5($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBool_5() => $_has(4);
  @$pb.TagNumber(5)
  void clearBool_5() => clearField(5);

  @$pb.TagNumber(6)
  MonitorOscResponse_OscArgument_OscColor get color => $_getN(5);
  @$pb.TagNumber(6)
  set color(MonitorOscResponse_OscArgument_OscColor v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasColor() => $_has(5);
  @$pb.TagNumber(6)
  void clearColor() => clearField(6);
  @$pb.TagNumber(6)
  MonitorOscResponse_OscArgument_OscColor ensureColor() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get string => $_getSZ(6);
  @$pb.TagNumber(7)
  set string($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasString() => $_has(6);
  @$pb.TagNumber(7)
  void clearString() => clearField(7);
}

class MonitorOscResponse extends $pb.GeneratedMessage {
  factory MonitorOscResponse({
    $fixnum.Int64? timestamp,
    $core.String? path,
    $core.Iterable<MonitorOscResponse_OscArgument>? args,
  }) {
    final $result = create();
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (path != null) {
      $result.path = path;
    }
    if (args != null) {
      $result.args.addAll(args);
    }
    return $result;
  }
  MonitorOscResponse._() : super();
  factory MonitorOscResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorOscResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MonitorOscResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'path')
    ..pc<MonitorOscResponse_OscArgument>(3, _omitFieldNames ? '' : 'args', $pb.PbFieldType.PM, subBuilder: MonitorOscResponse_OscArgument.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorOscResponse clone() => MonitorOscResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorOscResponse copyWith(void Function(MonitorOscResponse) updates) => super.copyWith((message) => updates(message as MonitorOscResponse)) as MonitorOscResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitorOscResponse create() => MonitorOscResponse._();
  MonitorOscResponse createEmptyInstance() => create();
  static $pb.PbList<MonitorOscResponse> createRepeated() => $pb.PbList<MonitorOscResponse>();
  @$core.pragma('dart2js:noInline')
  static MonitorOscResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MonitorOscResponse>(create);
  static MonitorOscResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get timestamp => $_getI64(0);
  @$pb.TagNumber(1)
  set timestamp($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<MonitorOscResponse_OscArgument> get args => $_getList(2);
}

class GetConnectionsRequest extends $pb.GeneratedMessage {
  factory GetConnectionsRequest() => create();
  GetConnectionsRequest._() : super();
  factory GetConnectionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetConnectionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetConnectionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetConnectionsRequest clone() => GetConnectionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetConnectionsRequest copyWith(void Function(GetConnectionsRequest) updates) => super.copyWith((message) => updates(message as GetConnectionsRequest)) as GetConnectionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetConnectionsRequest create() => GetConnectionsRequest._();
  GetConnectionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetConnectionsRequest> createRepeated() => $pb.PbList<GetConnectionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetConnectionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetConnectionsRequest>(create);
  static GetConnectionsRequest? _defaultInstance;
}

class GetDeviceProfilesRequest extends $pb.GeneratedMessage {
  factory GetDeviceProfilesRequest() => create();
  GetDeviceProfilesRequest._() : super();
  factory GetDeviceProfilesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDeviceProfilesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDeviceProfilesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDeviceProfilesRequest clone() => GetDeviceProfilesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDeviceProfilesRequest copyWith(void Function(GetDeviceProfilesRequest) updates) => super.copyWith((message) => updates(message as GetDeviceProfilesRequest)) as GetDeviceProfilesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDeviceProfilesRequest create() => GetDeviceProfilesRequest._();
  GetDeviceProfilesRequest createEmptyInstance() => create();
  static $pb.PbList<GetDeviceProfilesRequest> createRepeated() => $pb.PbList<GetDeviceProfilesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDeviceProfilesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDeviceProfilesRequest>(create);
  static GetDeviceProfilesRequest? _defaultInstance;
}

class ArtnetOutputConfig extends $pb.GeneratedMessage {
  factory ArtnetOutputConfig({
    $core.String? name,
    $core.String? host,
    $core.int? port,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (host != null) {
      $result.host = host;
    }
    if (port != null) {
      $result.port = port;
    }
    return $result;
  }
  ArtnetOutputConfig._() : super();
  factory ArtnetOutputConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ArtnetOutputConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ArtnetOutputConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'host')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'port', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ArtnetOutputConfig clone() => ArtnetOutputConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ArtnetOutputConfig copyWith(void Function(ArtnetOutputConfig) updates) => super.copyWith((message) => updates(message as ArtnetOutputConfig)) as ArtnetOutputConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ArtnetOutputConfig create() => ArtnetOutputConfig._();
  ArtnetOutputConfig createEmptyInstance() => create();
  static $pb.PbList<ArtnetOutputConfig> createRepeated() => $pb.PbList<ArtnetOutputConfig>();
  @$core.pragma('dart2js:noInline')
  static ArtnetOutputConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ArtnetOutputConfig>(create);
  static ArtnetOutputConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get host => $_getSZ(1);
  @$pb.TagNumber(2)
  set host($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHost() => $_has(1);
  @$pb.TagNumber(2)
  void clearHost() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get port => $_getIZ(2);
  @$pb.TagNumber(3)
  set port($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPort() => $_has(2);
  @$pb.TagNumber(3)
  void clearPort() => clearField(3);
}

class ArtnetInputConfig extends $pb.GeneratedMessage {
  factory ArtnetInputConfig({
    $core.String? name,
    $core.String? host,
    $core.int? port,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (host != null) {
      $result.host = host;
    }
    if (port != null) {
      $result.port = port;
    }
    return $result;
  }
  ArtnetInputConfig._() : super();
  factory ArtnetInputConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ArtnetInputConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ArtnetInputConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'host')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'port', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ArtnetInputConfig clone() => ArtnetInputConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ArtnetInputConfig copyWith(void Function(ArtnetInputConfig) updates) => super.copyWith((message) => updates(message as ArtnetInputConfig)) as ArtnetInputConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ArtnetInputConfig create() => ArtnetInputConfig._();
  ArtnetInputConfig createEmptyInstance() => create();
  static $pb.PbList<ArtnetInputConfig> createRepeated() => $pb.PbList<ArtnetInputConfig>();
  @$core.pragma('dart2js:noInline')
  static ArtnetInputConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ArtnetInputConfig>(create);
  static ArtnetInputConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get host => $_getSZ(1);
  @$pb.TagNumber(2)
  set host($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHost() => $_has(1);
  @$pb.TagNumber(2)
  void clearHost() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get port => $_getIZ(2);
  @$pb.TagNumber(3)
  set port($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPort() => $_has(2);
  @$pb.TagNumber(3)
  void clearPort() => clearField(3);
}

class SacnConfig extends $pb.GeneratedMessage {
  factory SacnConfig({
    $core.String? name,
    $core.int? priority,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (priority != null) {
      $result.priority = priority;
    }
    return $result;
  }
  SacnConfig._() : super();
  factory SacnConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SacnConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SacnConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'priority', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SacnConfig clone() => SacnConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SacnConfig copyWith(void Function(SacnConfig) updates) => super.copyWith((message) => updates(message as SacnConfig)) as SacnConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SacnConfig create() => SacnConfig._();
  SacnConfig createEmptyInstance() => create();
  static $pb.PbList<SacnConfig> createRepeated() => $pb.PbList<SacnConfig>();
  @$core.pragma('dart2js:noInline')
  static SacnConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SacnConfig>(create);
  static SacnConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get priority => $_getIZ(1);
  @$pb.TagNumber(2)
  set priority($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPriority() => $_has(1);
  @$pb.TagNumber(2)
  void clearPriority() => clearField(2);
}

class Connections extends $pb.GeneratedMessage {
  factory Connections({
    $core.Iterable<Connection>? connections,
  }) {
    final $result = create();
    if (connections != null) {
      $result.connections.addAll(connections);
    }
    return $result;
  }
  Connections._() : super();
  factory Connections.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Connections.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Connections', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..pc<Connection>(1, _omitFieldNames ? '' : 'connections', $pb.PbFieldType.PM, subBuilder: Connection.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Connections clone() => Connections()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Connections copyWith(void Function(Connections) updates) => super.copyWith((message) => updates(message as Connections)) as Connections;

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
  dmxOutput, 
  dmxInput, 
  midi, 
  osc, 
  helios, 
  etherDream, 
  gamepad, 
  mqtt, 
  g13, 
  webcam, 
  cdj, 
  djm, 
  ndiSource, 
  citp, 
  x1, 
  notSet
}

class Connection extends $pb.GeneratedMessage {
  factory Connection({
    $core.String? name,
    DmxOutputConnection? dmxOutput,
    DmxInputConnection? dmxInput,
    MidiConnection? midi,
    OscConnection? osc,
    HeliosConnection? helios,
    EtherDreamConnection? etherDream,
    GamepadConnection? gamepad,
    MqttConnection? mqtt,
    G13Connection? g13,
    WebcamConnection? webcam,
    PioneerCdjConnection? cdj,
    PioneerDjmConnection? djm,
    NdiSourceConnection? ndiSource,
    CitpConnection? citp,
    TraktorKontrolX1Connection? x1,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (dmxOutput != null) {
      $result.dmxOutput = dmxOutput;
    }
    if (dmxInput != null) {
      $result.dmxInput = dmxInput;
    }
    if (midi != null) {
      $result.midi = midi;
    }
    if (osc != null) {
      $result.osc = osc;
    }
    if (helios != null) {
      $result.helios = helios;
    }
    if (etherDream != null) {
      $result.etherDream = etherDream;
    }
    if (gamepad != null) {
      $result.gamepad = gamepad;
    }
    if (mqtt != null) {
      $result.mqtt = mqtt;
    }
    if (g13 != null) {
      $result.g13 = g13;
    }
    if (webcam != null) {
      $result.webcam = webcam;
    }
    if (cdj != null) {
      $result.cdj = cdj;
    }
    if (djm != null) {
      $result.djm = djm;
    }
    if (ndiSource != null) {
      $result.ndiSource = ndiSource;
    }
    if (citp != null) {
      $result.citp = citp;
    }
    if (x1 != null) {
      $result.x1 = x1;
    }
    return $result;
  }
  Connection._() : super();
  factory Connection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Connection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Connection_Connection> _Connection_ConnectionByTag = {
    10 : Connection_Connection.dmxOutput,
    11 : Connection_Connection.dmxInput,
    12 : Connection_Connection.midi,
    13 : Connection_Connection.osc,
    14 : Connection_Connection.helios,
    15 : Connection_Connection.etherDream,
    16 : Connection_Connection.gamepad,
    17 : Connection_Connection.mqtt,
    18 : Connection_Connection.g13,
    19 : Connection_Connection.webcam,
    20 : Connection_Connection.cdj,
    21 : Connection_Connection.djm,
    22 : Connection_Connection.ndiSource,
    23 : Connection_Connection.citp,
    24 : Connection_Connection.x1,
    0 : Connection_Connection.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Connection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..oo(0, [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<DmxOutputConnection>(10, _omitFieldNames ? '' : 'dmxOutput', subBuilder: DmxOutputConnection.create)
    ..aOM<DmxInputConnection>(11, _omitFieldNames ? '' : 'dmxInput', subBuilder: DmxInputConnection.create)
    ..aOM<MidiConnection>(12, _omitFieldNames ? '' : 'midi', subBuilder: MidiConnection.create)
    ..aOM<OscConnection>(13, _omitFieldNames ? '' : 'osc', subBuilder: OscConnection.create)
    ..aOM<HeliosConnection>(14, _omitFieldNames ? '' : 'helios', subBuilder: HeliosConnection.create)
    ..aOM<EtherDreamConnection>(15, _omitFieldNames ? '' : 'etherDream', subBuilder: EtherDreamConnection.create)
    ..aOM<GamepadConnection>(16, _omitFieldNames ? '' : 'gamepad', subBuilder: GamepadConnection.create)
    ..aOM<MqttConnection>(17, _omitFieldNames ? '' : 'mqtt', subBuilder: MqttConnection.create)
    ..aOM<G13Connection>(18, _omitFieldNames ? '' : 'g13', subBuilder: G13Connection.create)
    ..aOM<WebcamConnection>(19, _omitFieldNames ? '' : 'webcam', subBuilder: WebcamConnection.create)
    ..aOM<PioneerCdjConnection>(20, _omitFieldNames ? '' : 'cdj', subBuilder: PioneerCdjConnection.create)
    ..aOM<PioneerDjmConnection>(21, _omitFieldNames ? '' : 'djm', subBuilder: PioneerDjmConnection.create)
    ..aOM<NdiSourceConnection>(22, _omitFieldNames ? '' : 'ndiSource', subBuilder: NdiSourceConnection.create)
    ..aOM<CitpConnection>(23, _omitFieldNames ? '' : 'citp', subBuilder: CitpConnection.create)
    ..aOM<TraktorKontrolX1Connection>(24, _omitFieldNames ? '' : 'x1', subBuilder: TraktorKontrolX1Connection.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Connection clone() => Connection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Connection copyWith(void Function(Connection) updates) => super.copyWith((message) => updates(message as Connection)) as Connection;

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
  DmxOutputConnection get dmxOutput => $_getN(1);
  @$pb.TagNumber(10)
  set dmxOutput(DmxOutputConnection v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasDmxOutput() => $_has(1);
  @$pb.TagNumber(10)
  void clearDmxOutput() => clearField(10);
  @$pb.TagNumber(10)
  DmxOutputConnection ensureDmxOutput() => $_ensure(1);

  @$pb.TagNumber(11)
  DmxInputConnection get dmxInput => $_getN(2);
  @$pb.TagNumber(11)
  set dmxInput(DmxInputConnection v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasDmxInput() => $_has(2);
  @$pb.TagNumber(11)
  void clearDmxInput() => clearField(11);
  @$pb.TagNumber(11)
  DmxInputConnection ensureDmxInput() => $_ensure(2);

  @$pb.TagNumber(12)
  MidiConnection get midi => $_getN(3);
  @$pb.TagNumber(12)
  set midi(MidiConnection v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasMidi() => $_has(3);
  @$pb.TagNumber(12)
  void clearMidi() => clearField(12);
  @$pb.TagNumber(12)
  MidiConnection ensureMidi() => $_ensure(3);

  @$pb.TagNumber(13)
  OscConnection get osc => $_getN(4);
  @$pb.TagNumber(13)
  set osc(OscConnection v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasOsc() => $_has(4);
  @$pb.TagNumber(13)
  void clearOsc() => clearField(13);
  @$pb.TagNumber(13)
  OscConnection ensureOsc() => $_ensure(4);

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

  @$pb.TagNumber(15)
  EtherDreamConnection get etherDream => $_getN(6);
  @$pb.TagNumber(15)
  set etherDream(EtherDreamConnection v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasEtherDream() => $_has(6);
  @$pb.TagNumber(15)
  void clearEtherDream() => clearField(15);
  @$pb.TagNumber(15)
  EtherDreamConnection ensureEtherDream() => $_ensure(6);

  @$pb.TagNumber(16)
  GamepadConnection get gamepad => $_getN(7);
  @$pb.TagNumber(16)
  set gamepad(GamepadConnection v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasGamepad() => $_has(7);
  @$pb.TagNumber(16)
  void clearGamepad() => clearField(16);
  @$pb.TagNumber(16)
  GamepadConnection ensureGamepad() => $_ensure(7);

  @$pb.TagNumber(17)
  MqttConnection get mqtt => $_getN(8);
  @$pb.TagNumber(17)
  set mqtt(MqttConnection v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasMqtt() => $_has(8);
  @$pb.TagNumber(17)
  void clearMqtt() => clearField(17);
  @$pb.TagNumber(17)
  MqttConnection ensureMqtt() => $_ensure(8);

  @$pb.TagNumber(18)
  G13Connection get g13 => $_getN(9);
  @$pb.TagNumber(18)
  set g13(G13Connection v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasG13() => $_has(9);
  @$pb.TagNumber(18)
  void clearG13() => clearField(18);
  @$pb.TagNumber(18)
  G13Connection ensureG13() => $_ensure(9);

  @$pb.TagNumber(19)
  WebcamConnection get webcam => $_getN(10);
  @$pb.TagNumber(19)
  set webcam(WebcamConnection v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasWebcam() => $_has(10);
  @$pb.TagNumber(19)
  void clearWebcam() => clearField(19);
  @$pb.TagNumber(19)
  WebcamConnection ensureWebcam() => $_ensure(10);

  @$pb.TagNumber(20)
  PioneerCdjConnection get cdj => $_getN(11);
  @$pb.TagNumber(20)
  set cdj(PioneerCdjConnection v) { setField(20, v); }
  @$pb.TagNumber(20)
  $core.bool hasCdj() => $_has(11);
  @$pb.TagNumber(20)
  void clearCdj() => clearField(20);
  @$pb.TagNumber(20)
  PioneerCdjConnection ensureCdj() => $_ensure(11);

  @$pb.TagNumber(21)
  PioneerDjmConnection get djm => $_getN(12);
  @$pb.TagNumber(21)
  set djm(PioneerDjmConnection v) { setField(21, v); }
  @$pb.TagNumber(21)
  $core.bool hasDjm() => $_has(12);
  @$pb.TagNumber(21)
  void clearDjm() => clearField(21);
  @$pb.TagNumber(21)
  PioneerDjmConnection ensureDjm() => $_ensure(12);

  @$pb.TagNumber(22)
  NdiSourceConnection get ndiSource => $_getN(13);
  @$pb.TagNumber(22)
  set ndiSource(NdiSourceConnection v) { setField(22, v); }
  @$pb.TagNumber(22)
  $core.bool hasNdiSource() => $_has(13);
  @$pb.TagNumber(22)
  void clearNdiSource() => clearField(22);
  @$pb.TagNumber(22)
  NdiSourceConnection ensureNdiSource() => $_ensure(13);

  @$pb.TagNumber(23)
  CitpConnection get citp => $_getN(14);
  @$pb.TagNumber(23)
  set citp(CitpConnection v) { setField(23, v); }
  @$pb.TagNumber(23)
  $core.bool hasCitp() => $_has(14);
  @$pb.TagNumber(23)
  void clearCitp() => clearField(23);
  @$pb.TagNumber(23)
  CitpConnection ensureCitp() => $_ensure(14);

  @$pb.TagNumber(24)
  TraktorKontrolX1Connection get x1 => $_getN(15);
  @$pb.TagNumber(24)
  set x1(TraktorKontrolX1Connection v) { setField(24, v); }
  @$pb.TagNumber(24)
  $core.bool hasX1() => $_has(15);
  @$pb.TagNumber(24)
  void clearX1() => clearField(24);
  @$pb.TagNumber(24)
  TraktorKontrolX1Connection ensureX1() => $_ensure(15);
}

enum DmxOutputConnection_Config {
  artnet, 
  sacn, 
  notSet
}

class DmxOutputConnection extends $pb.GeneratedMessage {
  factory DmxOutputConnection({
    $core.String? outputId,
    ArtnetOutputConfig? artnet,
    SacnConfig? sacn,
  }) {
    final $result = create();
    if (outputId != null) {
      $result.outputId = outputId;
    }
    if (artnet != null) {
      $result.artnet = artnet;
    }
    if (sacn != null) {
      $result.sacn = sacn;
    }
    return $result;
  }
  DmxOutputConnection._() : super();
  factory DmxOutputConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DmxOutputConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, DmxOutputConnection_Config> _DmxOutputConnection_ConfigByTag = {
    3 : DmxOutputConnection_Config.artnet,
    4 : DmxOutputConnection_Config.sacn,
    0 : DmxOutputConnection_Config.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DmxOutputConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..aOS(1, _omitFieldNames ? '' : 'outputId')
    ..aOM<ArtnetOutputConfig>(3, _omitFieldNames ? '' : 'artnet', subBuilder: ArtnetOutputConfig.create)
    ..aOM<SacnConfig>(4, _omitFieldNames ? '' : 'sacn', subBuilder: SacnConfig.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DmxOutputConnection clone() => DmxOutputConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DmxOutputConnection copyWith(void Function(DmxOutputConnection) updates) => super.copyWith((message) => updates(message as DmxOutputConnection)) as DmxOutputConnection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DmxOutputConnection create() => DmxOutputConnection._();
  DmxOutputConnection createEmptyInstance() => create();
  static $pb.PbList<DmxOutputConnection> createRepeated() => $pb.PbList<DmxOutputConnection>();
  @$core.pragma('dart2js:noInline')
  static DmxOutputConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DmxOutputConnection>(create);
  static DmxOutputConnection? _defaultInstance;

  DmxOutputConnection_Config whichConfig() => _DmxOutputConnection_ConfigByTag[$_whichOneof(0)]!;
  void clearConfig() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get outputId => $_getSZ(0);
  @$pb.TagNumber(1)
  set outputId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOutputId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutputId() => clearField(1);

  @$pb.TagNumber(3)
  ArtnetOutputConfig get artnet => $_getN(1);
  @$pb.TagNumber(3)
  set artnet(ArtnetOutputConfig v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasArtnet() => $_has(1);
  @$pb.TagNumber(3)
  void clearArtnet() => clearField(3);
  @$pb.TagNumber(3)
  ArtnetOutputConfig ensureArtnet() => $_ensure(1);

  @$pb.TagNumber(4)
  SacnConfig get sacn => $_getN(2);
  @$pb.TagNumber(4)
  set sacn(SacnConfig v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSacn() => $_has(2);
  @$pb.TagNumber(4)
  void clearSacn() => clearField(4);
  @$pb.TagNumber(4)
  SacnConfig ensureSacn() => $_ensure(2);
}

enum DmxInputConnection_Config {
  artnet, 
  notSet
}

class DmxInputConnection extends $pb.GeneratedMessage {
  factory DmxInputConnection({
    $core.String? id,
    ArtnetInputConfig? artnet,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (artnet != null) {
      $result.artnet = artnet;
    }
    return $result;
  }
  DmxInputConnection._() : super();
  factory DmxInputConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DmxInputConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, DmxInputConnection_Config> _DmxInputConnection_ConfigByTag = {
    2 : DmxInputConnection_Config.artnet,
    0 : DmxInputConnection_Config.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DmxInputConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..oo(0, [2])
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<ArtnetInputConfig>(2, _omitFieldNames ? '' : 'artnet', subBuilder: ArtnetInputConfig.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DmxInputConnection clone() => DmxInputConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DmxInputConnection copyWith(void Function(DmxInputConnection) updates) => super.copyWith((message) => updates(message as DmxInputConnection)) as DmxInputConnection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DmxInputConnection create() => DmxInputConnection._();
  DmxInputConnection createEmptyInstance() => create();
  static $pb.PbList<DmxInputConnection> createRepeated() => $pb.PbList<DmxInputConnection>();
  @$core.pragma('dart2js:noInline')
  static DmxInputConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DmxInputConnection>(create);
  static DmxInputConnection? _defaultInstance;

  DmxInputConnection_Config whichConfig() => _DmxInputConnection_ConfigByTag[$_whichOneof(0)]!;
  void clearConfig() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  ArtnetInputConfig get artnet => $_getN(1);
  @$pb.TagNumber(2)
  set artnet(ArtnetInputConfig v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasArtnet() => $_has(1);
  @$pb.TagNumber(2)
  void clearArtnet() => clearField(2);
  @$pb.TagNumber(2)
  ArtnetInputConfig ensureArtnet() => $_ensure(1);
}

class HeliosConnection extends $pb.GeneratedMessage {
  factory HeliosConnection({
    $core.String? name,
    $core.int? firmware,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (firmware != null) {
      $result.firmware = firmware;
    }
    return $result;
  }
  HeliosConnection._() : super();
  factory HeliosConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HeliosConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HeliosConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'firmware', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HeliosConnection clone() => HeliosConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HeliosConnection copyWith(void Function(HeliosConnection) updates) => super.copyWith((message) => updates(message as HeliosConnection)) as HeliosConnection;

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
  $core.int get firmware => $_getIZ(1);
  @$pb.TagNumber(2)
  set firmware($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirmware() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirmware() => clearField(2);
}

class EtherDreamConnection extends $pb.GeneratedMessage {
  factory EtherDreamConnection({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  EtherDreamConnection._() : super();
  factory EtherDreamConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EtherDreamConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EtherDreamConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EtherDreamConnection clone() => EtherDreamConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EtherDreamConnection copyWith(void Function(EtherDreamConnection) updates) => super.copyWith((message) => updates(message as EtherDreamConnection)) as EtherDreamConnection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EtherDreamConnection create() => EtherDreamConnection._();
  EtherDreamConnection createEmptyInstance() => create();
  static $pb.PbList<EtherDreamConnection> createRepeated() => $pb.PbList<EtherDreamConnection>();
  @$core.pragma('dart2js:noInline')
  static EtherDreamConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EtherDreamConnection>(create);
  static EtherDreamConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class GamepadConnection extends $pb.GeneratedMessage {
  factory GamepadConnection({
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
  GamepadConnection._() : super();
  factory GamepadConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GamepadConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GamepadConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GamepadConnection clone() => GamepadConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GamepadConnection copyWith(void Function(GamepadConnection) updates) => super.copyWith((message) => updates(message as GamepadConnection)) as GamepadConnection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GamepadConnection create() => GamepadConnection._();
  GamepadConnection createEmptyInstance() => create();
  static $pb.PbList<GamepadConnection> createRepeated() => $pb.PbList<GamepadConnection>();
  @$core.pragma('dart2js:noInline')
  static GamepadConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GamepadConnection>(create);
  static GamepadConnection? _defaultInstance;

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

class G13Connection extends $pb.GeneratedMessage {
  factory G13Connection({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  G13Connection._() : super();
  factory G13Connection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory G13Connection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'G13Connection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  G13Connection clone() => G13Connection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  G13Connection copyWith(void Function(G13Connection) updates) => super.copyWith((message) => updates(message as G13Connection)) as G13Connection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static G13Connection create() => G13Connection._();
  G13Connection createEmptyInstance() => create();
  static $pb.PbList<G13Connection> createRepeated() => $pb.PbList<G13Connection>();
  @$core.pragma('dart2js:noInline')
  static G13Connection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<G13Connection>(create);
  static G13Connection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class TraktorKontrolX1Connection extends $pb.GeneratedMessage {
  factory TraktorKontrolX1Connection({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  TraktorKontrolX1Connection._() : super();
  factory TraktorKontrolX1Connection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TraktorKontrolX1Connection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TraktorKontrolX1Connection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TraktorKontrolX1Connection clone() => TraktorKontrolX1Connection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TraktorKontrolX1Connection copyWith(void Function(TraktorKontrolX1Connection) updates) => super.copyWith((message) => updates(message as TraktorKontrolX1Connection)) as TraktorKontrolX1Connection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TraktorKontrolX1Connection create() => TraktorKontrolX1Connection._();
  TraktorKontrolX1Connection createEmptyInstance() => create();
  static $pb.PbList<TraktorKontrolX1Connection> createRepeated() => $pb.PbList<TraktorKontrolX1Connection>();
  @$core.pragma('dart2js:noInline')
  static TraktorKontrolX1Connection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TraktorKontrolX1Connection>(create);
  static TraktorKontrolX1Connection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class WebcamConnection extends $pb.GeneratedMessage {
  factory WebcamConnection({
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
  WebcamConnection._() : super();
  factory WebcamConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WebcamConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WebcamConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WebcamConnection clone() => WebcamConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WebcamConnection copyWith(void Function(WebcamConnection) updates) => super.copyWith((message) => updates(message as WebcamConnection)) as WebcamConnection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebcamConnection create() => WebcamConnection._();
  WebcamConnection createEmptyInstance() => create();
  static $pb.PbList<WebcamConnection> createRepeated() => $pb.PbList<WebcamConnection>();
  @$core.pragma('dart2js:noInline')
  static WebcamConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WebcamConnection>(create);
  static WebcamConnection? _defaultInstance;

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

class NdiSourceConnection extends $pb.GeneratedMessage {
  factory NdiSourceConnection({
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
  NdiSourceConnection._() : super();
  factory NdiSourceConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NdiSourceConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NdiSourceConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NdiSourceConnection clone() => NdiSourceConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NdiSourceConnection copyWith(void Function(NdiSourceConnection) updates) => super.copyWith((message) => updates(message as NdiSourceConnection)) as NdiSourceConnection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NdiSourceConnection create() => NdiSourceConnection._();
  NdiSourceConnection createEmptyInstance() => create();
  static $pb.PbList<NdiSourceConnection> createRepeated() => $pb.PbList<NdiSourceConnection>();
  @$core.pragma('dart2js:noInline')
  static NdiSourceConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NdiSourceConnection>(create);
  static NdiSourceConnection? _defaultInstance;

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

class MidiConnection extends $pb.GeneratedMessage {
  factory MidiConnection({
    $core.String? deviceProfile,
  }) {
    final $result = create();
    if (deviceProfile != null) {
      $result.deviceProfile = deviceProfile;
    }
    return $result;
  }
  MidiConnection._() : super();
  factory MidiConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MidiConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceProfile')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiConnection clone() => MidiConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiConnection copyWith(void Function(MidiConnection) updates) => super.copyWith((message) => updates(message as MidiConnection)) as MidiConnection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MidiConnection create() => MidiConnection._();
  MidiConnection createEmptyInstance() => create();
  static $pb.PbList<MidiConnection> createRepeated() => $pb.PbList<MidiConnection>();
  @$core.pragma('dart2js:noInline')
  static MidiConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiConnection>(create);
  static MidiConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceProfile => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceProfile($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceProfile() => clearField(1);
}

class MidiDeviceProfiles extends $pb.GeneratedMessage {
  factory MidiDeviceProfiles({
    $core.Iterable<MidiDeviceProfile>? profiles,
  }) {
    final $result = create();
    if (profiles != null) {
      $result.profiles.addAll(profiles);
    }
    return $result;
  }
  MidiDeviceProfiles._() : super();
  factory MidiDeviceProfiles.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfiles.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MidiDeviceProfiles', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..pc<MidiDeviceProfile>(1, _omitFieldNames ? '' : 'profiles', $pb.PbFieldType.PM, subBuilder: MidiDeviceProfile.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfiles clone() => MidiDeviceProfiles()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfiles copyWith(void Function(MidiDeviceProfiles) updates) => super.copyWith((message) => updates(message as MidiDeviceProfiles)) as MidiDeviceProfiles;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfiles create() => MidiDeviceProfiles._();
  MidiDeviceProfiles createEmptyInstance() => create();
  static $pb.PbList<MidiDeviceProfiles> createRepeated() => $pb.PbList<MidiDeviceProfiles>();
  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfiles getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiDeviceProfiles>(create);
  static MidiDeviceProfiles? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MidiDeviceProfile> get profiles => $_getList(0);
}

class MidiDeviceProfile_Page extends $pb.GeneratedMessage {
  factory MidiDeviceProfile_Page({
    $core.String? name,
    $core.Iterable<MidiDeviceProfile_Group>? groups,
    $core.Iterable<MidiDeviceProfile_Control>? controls,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (groups != null) {
      $result.groups.addAll(groups);
    }
    if (controls != null) {
      $result.controls.addAll(controls);
    }
    return $result;
  }
  MidiDeviceProfile_Page._() : super();
  factory MidiDeviceProfile_Page.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfile_Page.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MidiDeviceProfile.Page', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<MidiDeviceProfile_Group>(2, _omitFieldNames ? '' : 'groups', $pb.PbFieldType.PM, subBuilder: MidiDeviceProfile_Group.create)
    ..pc<MidiDeviceProfile_Control>(3, _omitFieldNames ? '' : 'controls', $pb.PbFieldType.PM, subBuilder: MidiDeviceProfile_Control.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile_Page clone() => MidiDeviceProfile_Page()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile_Page copyWith(void Function(MidiDeviceProfile_Page) updates) => super.copyWith((message) => updates(message as MidiDeviceProfile_Page)) as MidiDeviceProfile_Page;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfile_Page create() => MidiDeviceProfile_Page._();
  MidiDeviceProfile_Page createEmptyInstance() => create();
  static $pb.PbList<MidiDeviceProfile_Page> createRepeated() => $pb.PbList<MidiDeviceProfile_Page>();
  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfile_Page getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiDeviceProfile_Page>(create);
  static MidiDeviceProfile_Page? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<MidiDeviceProfile_Group> get groups => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<MidiDeviceProfile_Control> get controls => $_getList(2);
}

class MidiDeviceProfile_Group extends $pb.GeneratedMessage {
  factory MidiDeviceProfile_Group({
    $core.String? name,
    $core.Iterable<MidiDeviceProfile_Control>? controls,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (controls != null) {
      $result.controls.addAll(controls);
    }
    return $result;
  }
  MidiDeviceProfile_Group._() : super();
  factory MidiDeviceProfile_Group.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfile_Group.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MidiDeviceProfile.Group', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<MidiDeviceProfile_Control>(2, _omitFieldNames ? '' : 'controls', $pb.PbFieldType.PM, subBuilder: MidiDeviceProfile_Control.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile_Group clone() => MidiDeviceProfile_Group()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile_Group copyWith(void Function(MidiDeviceProfile_Group) updates) => super.copyWith((message) => updates(message as MidiDeviceProfile_Group)) as MidiDeviceProfile_Group;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfile_Group create() => MidiDeviceProfile_Group._();
  MidiDeviceProfile_Group createEmptyInstance() => create();
  static $pb.PbList<MidiDeviceProfile_Group> createRepeated() => $pb.PbList<MidiDeviceProfile_Group>();
  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfile_Group getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiDeviceProfile_Group>(create);
  static MidiDeviceProfile_Group? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<MidiDeviceProfile_Control> get controls => $_getList(1);
}

class MidiDeviceProfile_Control extends $pb.GeneratedMessage {
  factory MidiDeviceProfile_Control({
    $core.String? id,
    $core.String? name,
    $core.bool? hasInput,
    $core.bool? hasOutput,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (hasInput != null) {
      $result.hasInput = hasInput;
    }
    if (hasOutput != null) {
      $result.hasOutput = hasOutput;
    }
    return $result;
  }
  MidiDeviceProfile_Control._() : super();
  factory MidiDeviceProfile_Control.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfile_Control.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MidiDeviceProfile.Control', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOB(3, _omitFieldNames ? '' : 'hasInput')
    ..aOB(4, _omitFieldNames ? '' : 'hasOutput')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile_Control clone() => MidiDeviceProfile_Control()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile_Control copyWith(void Function(MidiDeviceProfile_Control) updates) => super.copyWith((message) => updates(message as MidiDeviceProfile_Control)) as MidiDeviceProfile_Control;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfile_Control create() => MidiDeviceProfile_Control._();
  MidiDeviceProfile_Control createEmptyInstance() => create();
  static $pb.PbList<MidiDeviceProfile_Control> createRepeated() => $pb.PbList<MidiDeviceProfile_Control>();
  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfile_Control getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiDeviceProfile_Control>(create);
  static MidiDeviceProfile_Control? _defaultInstance;

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
  $core.bool get hasInput => $_getBF(2);
  @$pb.TagNumber(3)
  set hasInput($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHasInput() => $_has(2);
  @$pb.TagNumber(3)
  void clearHasInput() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get hasOutput => $_getBF(3);
  @$pb.TagNumber(4)
  set hasOutput($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHasOutput() => $_has(3);
  @$pb.TagNumber(4)
  void clearHasOutput() => clearField(4);
}

class MidiDeviceProfile extends $pb.GeneratedMessage {
  factory MidiDeviceProfile({
    $core.String? id,
    $core.String? manufacturer,
    $core.String? model,
    $core.String? layout,
    $core.Iterable<MidiDeviceProfile_Page>? pages,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (manufacturer != null) {
      $result.manufacturer = manufacturer;
    }
    if (model != null) {
      $result.model = model;
    }
    if (layout != null) {
      $result.layout = layout;
    }
    if (pages != null) {
      $result.pages.addAll(pages);
    }
    return $result;
  }
  MidiDeviceProfile._() : super();
  factory MidiDeviceProfile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MidiDeviceProfile', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'manufacturer')
    ..aOS(3, _omitFieldNames ? '' : 'model')
    ..aOS(4, _omitFieldNames ? '' : 'layout')
    ..pc<MidiDeviceProfile_Page>(5, _omitFieldNames ? '' : 'pages', $pb.PbFieldType.PM, subBuilder: MidiDeviceProfile_Page.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile clone() => MidiDeviceProfile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile copyWith(void Function(MidiDeviceProfile) updates) => super.copyWith((message) => updates(message as MidiDeviceProfile)) as MidiDeviceProfile;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfile create() => MidiDeviceProfile._();
  MidiDeviceProfile createEmptyInstance() => create();
  static $pb.PbList<MidiDeviceProfile> createRepeated() => $pb.PbList<MidiDeviceProfile>();
  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiDeviceProfile>(create);
  static MidiDeviceProfile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get manufacturer => $_getSZ(1);
  @$pb.TagNumber(2)
  set manufacturer($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasManufacturer() => $_has(1);
  @$pb.TagNumber(2)
  void clearManufacturer() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get model => $_getSZ(2);
  @$pb.TagNumber(3)
  set model($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasModel() => $_has(2);
  @$pb.TagNumber(3)
  void clearModel() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get layout => $_getSZ(3);
  @$pb.TagNumber(4)
  set layout($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLayout() => $_has(3);
  @$pb.TagNumber(4)
  void clearLayout() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<MidiDeviceProfile_Page> get pages => $_getList(4);
}

class OscConnection extends $pb.GeneratedMessage {
  factory OscConnection({
    $core.String? connectionId,
    $core.int? inputPort,
    $core.int? outputPort,
    $core.String? outputAddress,
  }) {
    final $result = create();
    if (connectionId != null) {
      $result.connectionId = connectionId;
    }
    if (inputPort != null) {
      $result.inputPort = inputPort;
    }
    if (outputPort != null) {
      $result.outputPort = outputPort;
    }
    if (outputAddress != null) {
      $result.outputAddress = outputAddress;
    }
    return $result;
  }
  OscConnection._() : super();
  factory OscConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OscConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OscConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'connectionId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'inputPort', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'outputPort', $pb.PbFieldType.OU3)
    ..aOS(4, _omitFieldNames ? '' : 'outputAddress')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OscConnection clone() => OscConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OscConnection copyWith(void Function(OscConnection) updates) => super.copyWith((message) => updates(message as OscConnection)) as OscConnection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OscConnection create() => OscConnection._();
  OscConnection createEmptyInstance() => create();
  static $pb.PbList<OscConnection> createRepeated() => $pb.PbList<OscConnection>();
  @$core.pragma('dart2js:noInline')
  static OscConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OscConnection>(create);
  static OscConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get connectionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set connectionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasConnectionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConnectionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get inputPort => $_getIZ(1);
  @$pb.TagNumber(2)
  set inputPort($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInputPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearInputPort() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get outputPort => $_getIZ(2);
  @$pb.TagNumber(3)
  set outputPort($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOutputPort() => $_has(2);
  @$pb.TagNumber(3)
  void clearOutputPort() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get outputAddress => $_getSZ(3);
  @$pb.TagNumber(4)
  set outputAddress($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOutputAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutputAddress() => clearField(4);
}

class PioneerCdjConnection extends $pb.GeneratedMessage {
  factory PioneerCdjConnection({
    $core.String? id,
    $core.String? address,
    $core.String? model,
    $core.int? playerNumber,
    CdjPlayback? playback,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (address != null) {
      $result.address = address;
    }
    if (model != null) {
      $result.model = model;
    }
    if (playerNumber != null) {
      $result.playerNumber = playerNumber;
    }
    if (playback != null) {
      $result.playback = playback;
    }
    return $result;
  }
  PioneerCdjConnection._() : super();
  factory PioneerCdjConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PioneerCdjConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PioneerCdjConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'address')
    ..aOS(3, _omitFieldNames ? '' : 'model')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'playerNumber', $pb.PbFieldType.OU3)
    ..aOM<CdjPlayback>(5, _omitFieldNames ? '' : 'playback', subBuilder: CdjPlayback.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PioneerCdjConnection clone() => PioneerCdjConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PioneerCdjConnection copyWith(void Function(PioneerCdjConnection) updates) => super.copyWith((message) => updates(message as PioneerCdjConnection)) as PioneerCdjConnection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PioneerCdjConnection create() => PioneerCdjConnection._();
  PioneerCdjConnection createEmptyInstance() => create();
  static $pb.PbList<PioneerCdjConnection> createRepeated() => $pb.PbList<PioneerCdjConnection>();
  @$core.pragma('dart2js:noInline')
  static PioneerCdjConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PioneerCdjConnection>(create);
  static PioneerCdjConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get address => $_getSZ(1);
  @$pb.TagNumber(2)
  set address($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddress() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get model => $_getSZ(2);
  @$pb.TagNumber(3)
  set model($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasModel() => $_has(2);
  @$pb.TagNumber(3)
  void clearModel() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get playerNumber => $_getIZ(3);
  @$pb.TagNumber(4)
  set playerNumber($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPlayerNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPlayerNumber() => clearField(4);

  @$pb.TagNumber(5)
  CdjPlayback get playback => $_getN(4);
  @$pb.TagNumber(5)
  set playback(CdjPlayback v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPlayback() => $_has(4);
  @$pb.TagNumber(5)
  void clearPlayback() => clearField(5);
  @$pb.TagNumber(5)
  CdjPlayback ensurePlayback() => $_ensure(4);
}

class PioneerDjmConnection extends $pb.GeneratedMessage {
  factory PioneerDjmConnection({
    $core.String? id,
    $core.String? address,
    $core.String? model,
    $core.int? playerNumber,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (address != null) {
      $result.address = address;
    }
    if (model != null) {
      $result.model = model;
    }
    if (playerNumber != null) {
      $result.playerNumber = playerNumber;
    }
    return $result;
  }
  PioneerDjmConnection._() : super();
  factory PioneerDjmConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PioneerDjmConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PioneerDjmConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'address')
    ..aOS(3, _omitFieldNames ? '' : 'model')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'playerNumber', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PioneerDjmConnection clone() => PioneerDjmConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PioneerDjmConnection copyWith(void Function(PioneerDjmConnection) updates) => super.copyWith((message) => updates(message as PioneerDjmConnection)) as PioneerDjmConnection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PioneerDjmConnection create() => PioneerDjmConnection._();
  PioneerDjmConnection createEmptyInstance() => create();
  static $pb.PbList<PioneerDjmConnection> createRepeated() => $pb.PbList<PioneerDjmConnection>();
  @$core.pragma('dart2js:noInline')
  static PioneerDjmConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PioneerDjmConnection>(create);
  static PioneerDjmConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get address => $_getSZ(1);
  @$pb.TagNumber(2)
  set address($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddress() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get model => $_getSZ(2);
  @$pb.TagNumber(3)
  set model($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasModel() => $_has(2);
  @$pb.TagNumber(3)
  void clearModel() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get playerNumber => $_getIZ(3);
  @$pb.TagNumber(4)
  set playerNumber($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPlayerNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPlayerNumber() => clearField(4);
}

class CdjPlayback_Track extends $pb.GeneratedMessage {
  factory CdjPlayback_Track({
    $core.String? artist,
    $core.String? title,
  }) {
    final $result = create();
    if (artist != null) {
      $result.artist = artist;
    }
    if (title != null) {
      $result.title = title;
    }
    return $result;
  }
  CdjPlayback_Track._() : super();
  factory CdjPlayback_Track.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CdjPlayback_Track.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CdjPlayback.Track', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'artist')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CdjPlayback_Track clone() => CdjPlayback_Track()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CdjPlayback_Track copyWith(void Function(CdjPlayback_Track) updates) => super.copyWith((message) => updates(message as CdjPlayback_Track)) as CdjPlayback_Track;

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
  factory CdjPlayback({
    $core.bool? live,
    $core.double? bpm,
    $core.int? frame,
    CdjPlayback_State? playback,
    CdjPlayback_Track? track,
  }) {
    final $result = create();
    if (live != null) {
      $result.live = live;
    }
    if (bpm != null) {
      $result.bpm = bpm;
    }
    if (frame != null) {
      $result.frame = frame;
    }
    if (playback != null) {
      $result.playback = playback;
    }
    if (track != null) {
      $result.track = track;
    }
    return $result;
  }
  CdjPlayback._() : super();
  factory CdjPlayback.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CdjPlayback.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CdjPlayback', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'live')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'bpm', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'frame', $pb.PbFieldType.OU3)
    ..e<CdjPlayback_State>(4, _omitFieldNames ? '' : 'playback', $pb.PbFieldType.OE, defaultOrMaker: CdjPlayback_State.LOADING, valueOf: CdjPlayback_State.valueOf, enumValues: CdjPlayback_State.values)
    ..aOM<CdjPlayback_Track>(5, _omitFieldNames ? '' : 'track', subBuilder: CdjPlayback_Track.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CdjPlayback clone() => CdjPlayback()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CdjPlayback copyWith(void Function(CdjPlayback) updates) => super.copyWith((message) => updates(message as CdjPlayback)) as CdjPlayback;

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

class MqttConnection extends $pb.GeneratedMessage {
  factory MqttConnection({
    $core.String? connectionId,
    $core.String? url,
    $core.String? username,
    $core.String? password,
  }) {
    final $result = create();
    if (connectionId != null) {
      $result.connectionId = connectionId;
    }
    if (url != null) {
      $result.url = url;
    }
    if (username != null) {
      $result.username = username;
    }
    if (password != null) {
      $result.password = password;
    }
    return $result;
  }
  MqttConnection._() : super();
  factory MqttConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MqttConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MqttConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'connectionId')
    ..aOS(2, _omitFieldNames ? '' : 'url')
    ..aOS(3, _omitFieldNames ? '' : 'username')
    ..aOS(4, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MqttConnection clone() => MqttConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MqttConnection copyWith(void Function(MqttConnection) updates) => super.copyWith((message) => updates(message as MqttConnection)) as MqttConnection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MqttConnection create() => MqttConnection._();
  MqttConnection createEmptyInstance() => create();
  static $pb.PbList<MqttConnection> createRepeated() => $pb.PbList<MqttConnection>();
  @$core.pragma('dart2js:noInline')
  static MqttConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MqttConnection>(create);
  static MqttConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get connectionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set connectionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasConnectionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConnectionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get username => $_getSZ(2);
  @$pb.TagNumber(3)
  set username($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearUsername() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get password => $_getSZ(3);
  @$pb.TagNumber(4)
  set password($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPassword() => $_has(3);
  @$pb.TagNumber(4)
  void clearPassword() => clearField(4);
}

class CitpConnection extends $pb.GeneratedMessage {
  factory CitpConnection({
    $core.String? connectionId,
    $core.String? name,
    CitpConnection_CitpKind? kind,
    $core.String? state,
  }) {
    final $result = create();
    if (connectionId != null) {
      $result.connectionId = connectionId;
    }
    if (name != null) {
      $result.name = name;
    }
    if (kind != null) {
      $result.kind = kind;
    }
    if (state != null) {
      $result.state = state;
    }
    return $result;
  }
  CitpConnection._() : super();
  factory CitpConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CitpConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CitpConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'connectionId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..e<CitpConnection_CitpKind>(3, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE, defaultOrMaker: CitpConnection_CitpKind.CITP_KIND_LIGHTING_CONSOLE, valueOf: CitpConnection_CitpKind.valueOf, enumValues: CitpConnection_CitpKind.values)
    ..aOS(4, _omitFieldNames ? '' : 'state')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CitpConnection clone() => CitpConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CitpConnection copyWith(void Function(CitpConnection) updates) => super.copyWith((message) => updates(message as CitpConnection)) as CitpConnection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CitpConnection create() => CitpConnection._();
  CitpConnection createEmptyInstance() => create();
  static $pb.PbList<CitpConnection> createRepeated() => $pb.PbList<CitpConnection>();
  @$core.pragma('dart2js:noInline')
  static CitpConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CitpConnection>(create);
  static CitpConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get connectionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set connectionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasConnectionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConnectionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  CitpConnection_CitpKind get kind => $_getN(2);
  @$pb.TagNumber(3)
  set kind(CitpConnection_CitpKind v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearKind() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get state => $_getSZ(3);
  @$pb.TagNumber(4)
  set state($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasState() => $_has(3);
  @$pb.TagNumber(4)
  void clearState() => clearField(4);
}

enum ConfigureConnectionRequest_Config {
  dmxOutput, 
  mqtt, 
  osc, 
  dmxInput, 
  notSet
}

class ConfigureConnectionRequest extends $pb.GeneratedMessage {
  factory ConfigureConnectionRequest({
    DmxOutputConnection? dmxOutput,
    MqttConnection? mqtt,
    OscConnection? osc,
    DmxInputConnection? dmxInput,
  }) {
    final $result = create();
    if (dmxOutput != null) {
      $result.dmxOutput = dmxOutput;
    }
    if (mqtt != null) {
      $result.mqtt = mqtt;
    }
    if (osc != null) {
      $result.osc = osc;
    }
    if (dmxInput != null) {
      $result.dmxInput = dmxInput;
    }
    return $result;
  }
  ConfigureConnectionRequest._() : super();
  factory ConfigureConnectionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConfigureConnectionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ConfigureConnectionRequest_Config> _ConfigureConnectionRequest_ConfigByTag = {
    1 : ConfigureConnectionRequest_Config.dmxOutput,
    2 : ConfigureConnectionRequest_Config.mqtt,
    3 : ConfigureConnectionRequest_Config.osc,
    4 : ConfigureConnectionRequest_Config.dmxInput,
    0 : ConfigureConnectionRequest_Config.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConfigureConnectionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.connections'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<DmxOutputConnection>(1, _omitFieldNames ? '' : 'dmxOutput', subBuilder: DmxOutputConnection.create)
    ..aOM<MqttConnection>(2, _omitFieldNames ? '' : 'mqtt', subBuilder: MqttConnection.create)
    ..aOM<OscConnection>(3, _omitFieldNames ? '' : 'osc', subBuilder: OscConnection.create)
    ..aOM<DmxInputConnection>(4, _omitFieldNames ? '' : 'dmxInput', subBuilder: DmxInputConnection.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConfigureConnectionRequest clone() => ConfigureConnectionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConfigureConnectionRequest copyWith(void Function(ConfigureConnectionRequest) updates) => super.copyWith((message) => updates(message as ConfigureConnectionRequest)) as ConfigureConnectionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfigureConnectionRequest create() => ConfigureConnectionRequest._();
  ConfigureConnectionRequest createEmptyInstance() => create();
  static $pb.PbList<ConfigureConnectionRequest> createRepeated() => $pb.PbList<ConfigureConnectionRequest>();
  @$core.pragma('dart2js:noInline')
  static ConfigureConnectionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConfigureConnectionRequest>(create);
  static ConfigureConnectionRequest? _defaultInstance;

  ConfigureConnectionRequest_Config whichConfig() => _ConfigureConnectionRequest_ConfigByTag[$_whichOneof(0)]!;
  void clearConfig() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  DmxOutputConnection get dmxOutput => $_getN(0);
  @$pb.TagNumber(1)
  set dmxOutput(DmxOutputConnection v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDmxOutput() => $_has(0);
  @$pb.TagNumber(1)
  void clearDmxOutput() => clearField(1);
  @$pb.TagNumber(1)
  DmxOutputConnection ensureDmxOutput() => $_ensure(0);

  @$pb.TagNumber(2)
  MqttConnection get mqtt => $_getN(1);
  @$pb.TagNumber(2)
  set mqtt(MqttConnection v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMqtt() => $_has(1);
  @$pb.TagNumber(2)
  void clearMqtt() => clearField(2);
  @$pb.TagNumber(2)
  MqttConnection ensureMqtt() => $_ensure(1);

  @$pb.TagNumber(3)
  OscConnection get osc => $_getN(2);
  @$pb.TagNumber(3)
  set osc(OscConnection v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOsc() => $_has(2);
  @$pb.TagNumber(3)
  void clearOsc() => clearField(3);
  @$pb.TagNumber(3)
  OscConnection ensureOsc() => $_ensure(2);

  @$pb.TagNumber(4)
  DmxInputConnection get dmxInput => $_getN(3);
  @$pb.TagNumber(4)
  set dmxInput(DmxInputConnection v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDmxInput() => $_has(3);
  @$pb.TagNumber(4)
  void clearDmxInput() => clearField(4);
  @$pb.TagNumber(4)
  DmxInputConnection ensureDmxInput() => $_ensure(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
