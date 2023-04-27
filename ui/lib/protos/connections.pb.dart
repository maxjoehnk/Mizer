///
//  Generated code. Do not modify.
//  source: connections.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'connections.pbenum.dart';

export 'connections.pbenum.dart';

class MonitorDmxRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonitorDmxRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputId')
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

class MonitorMidiRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonitorMidiRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  MonitorMidiRequest._() : super();
  factory MonitorMidiRequest({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory MonitorMidiRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorMidiRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorMidiRequest clone() => MonitorMidiRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorMidiRequest copyWith(void Function(MonitorMidiRequest) updates) => super.copyWith((message) => updates(message as MonitorMidiRequest)) as MonitorMidiRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonitorMidiResponse.NoteMsg', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'note', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  MonitorMidiResponse_NoteMsg._() : super();
  factory MonitorMidiResponse_NoteMsg({
    $core.int? channel,
    $core.int? note,
    $core.int? value,
  }) {
    final _result = create();
    if (channel != null) {
      _result.channel = channel;
    }
    if (note != null) {
      _result.note = note;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory MonitorMidiResponse_NoteMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorMidiResponse_NoteMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorMidiResponse_NoteMsg clone() => MonitorMidiResponse_NoteMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorMidiResponse_NoteMsg copyWith(void Function(MonitorMidiResponse_NoteMsg) updates) => super.copyWith((message) => updates(message as MonitorMidiResponse_NoteMsg)) as MonitorMidiResponse_NoteMsg; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonitorMidiResponse.SysEx', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'manufacturer1', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'manufacturer2', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'manufacturer3', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'model', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  MonitorMidiResponse_SysEx._() : super();
  factory MonitorMidiResponse_SysEx({
    $core.int? manufacturer1,
    $core.int? manufacturer2,
    $core.int? manufacturer3,
    $core.int? model,
    $core.List<$core.int>? data,
  }) {
    final _result = create();
    if (manufacturer1 != null) {
      _result.manufacturer1 = manufacturer1;
    }
    if (manufacturer2 != null) {
      _result.manufacturer2 = manufacturer2;
    }
    if (manufacturer3 != null) {
      _result.manufacturer3 = manufacturer3;
    }
    if (model != null) {
      _result.model = model;
    }
    if (data != null) {
      _result.data = data;
    }
    return _result;
  }
  factory MonitorMidiResponse_SysEx.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorMidiResponse_SysEx.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorMidiResponse_SysEx clone() => MonitorMidiResponse_SysEx()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorMidiResponse_SysEx copyWith(void Function(MonitorMidiResponse_SysEx) updates) => super.copyWith((message) => updates(message as MonitorMidiResponse_SysEx)) as MonitorMidiResponse_SysEx; // ignore: deprecated_member_use
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
  static const $core.Map<$core.int, MonitorMidiResponse_Message> _MonitorMidiResponse_MessageByTag = {
    3 : MonitorMidiResponse_Message.cc,
    4 : MonitorMidiResponse_Message.noteOff,
    5 : MonitorMidiResponse_Message.noteOn,
    6 : MonitorMidiResponse_Message.sysEx,
    7 : MonitorMidiResponse_Message.unknown,
    0 : MonitorMidiResponse_Message.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonitorMidiResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6, 7])
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<MonitorMidiResponse_NoteMsg>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cc', subBuilder: MonitorMidiResponse_NoteMsg.create)
    ..aOM<MonitorMidiResponse_NoteMsg>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'noteOff', subBuilder: MonitorMidiResponse_NoteMsg.create)
    ..aOM<MonitorMidiResponse_NoteMsg>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'noteOn', subBuilder: MonitorMidiResponse_NoteMsg.create)
    ..aOM<MonitorMidiResponse_SysEx>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sysEx', subBuilder: MonitorMidiResponse_SysEx.create)
    ..a<$core.List<$core.int>>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unknown', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  MonitorMidiResponse._() : super();
  factory MonitorMidiResponse({
    $fixnum.Int64? timestamp,
    MonitorMidiResponse_NoteMsg? cc,
    MonitorMidiResponse_NoteMsg? noteOff,
    MonitorMidiResponse_NoteMsg? noteOn,
    MonitorMidiResponse_SysEx? sysEx,
    $core.List<$core.int>? unknown,
  }) {
    final _result = create();
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (cc != null) {
      _result.cc = cc;
    }
    if (noteOff != null) {
      _result.noteOff = noteOff;
    }
    if (noteOn != null) {
      _result.noteOn = noteOn;
    }
    if (sysEx != null) {
      _result.sysEx = sysEx;
    }
    if (unknown != null) {
      _result.unknown = unknown;
    }
    return _result;
  }
  factory MonitorMidiResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorMidiResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorMidiResponse clone() => MonitorMidiResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorMidiResponse copyWith(void Function(MonitorMidiResponse) updates) => super.copyWith((message) => updates(message as MonitorMidiResponse)) as MonitorMidiResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonitorOscRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  MonitorOscRequest._() : super();
  factory MonitorOscRequest({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory MonitorOscRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorOscRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorOscRequest clone() => MonitorOscRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorOscRequest copyWith(void Function(MonitorOscRequest) updates) => super.copyWith((message) => updates(message as MonitorOscRequest)) as MonitorOscRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonitorOscResponse.OscArgument.OscColor', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'red', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'green', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blue', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alpha', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  MonitorOscResponse_OscArgument_OscColor._() : super();
  factory MonitorOscResponse_OscArgument_OscColor({
    $core.int? red,
    $core.int? green,
    $core.int? blue,
    $core.int? alpha,
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
    if (alpha != null) {
      _result.alpha = alpha;
    }
    return _result;
  }
  factory MonitorOscResponse_OscArgument_OscColor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorOscResponse_OscArgument_OscColor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorOscResponse_OscArgument_OscColor clone() => MonitorOscResponse_OscArgument_OscColor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorOscResponse_OscArgument_OscColor copyWith(void Function(MonitorOscResponse_OscArgument_OscColor) updates) => super.copyWith((message) => updates(message as MonitorOscResponse_OscArgument_OscColor)) as MonitorOscResponse_OscArgument_OscColor; // ignore: deprecated_member_use
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
  notSet
}

class MonitorOscResponse_OscArgument extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, MonitorOscResponse_OscArgument_Argument> _MonitorOscResponse_OscArgument_ArgumentByTag = {
    1 : MonitorOscResponse_OscArgument_Argument.int_1,
    2 : MonitorOscResponse_OscArgument_Argument.float,
    3 : MonitorOscResponse_OscArgument_Argument.long,
    4 : MonitorOscResponse_OscArgument_Argument.double_4,
    5 : MonitorOscResponse_OscArgument_Argument.bool_5,
    6 : MonitorOscResponse_OscArgument_Argument.color,
    0 : MonitorOscResponse_OscArgument_Argument.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonitorOscResponse.OscArgument', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6])
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'int', $pb.PbFieldType.O3)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'float', $pb.PbFieldType.OF)
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'long')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'double', $pb.PbFieldType.OD)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bool')
    ..aOM<MonitorOscResponse_OscArgument_OscColor>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', subBuilder: MonitorOscResponse_OscArgument_OscColor.create)
    ..hasRequiredFields = false
  ;

  MonitorOscResponse_OscArgument._() : super();
  factory MonitorOscResponse_OscArgument({
    $core.int? int_1,
    $core.double? float,
    $fixnum.Int64? long,
    $core.double? double_4,
    $core.bool? bool_5,
    MonitorOscResponse_OscArgument_OscColor? color,
  }) {
    final _result = create();
    if (int_1 != null) {
      _result.int_1 = int_1;
    }
    if (float != null) {
      _result.float = float;
    }
    if (long != null) {
      _result.long = long;
    }
    if (double_4 != null) {
      _result.double_4 = double_4;
    }
    if (bool_5 != null) {
      _result.bool_5 = bool_5;
    }
    if (color != null) {
      _result.color = color;
    }
    return _result;
  }
  factory MonitorOscResponse_OscArgument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorOscResponse_OscArgument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorOscResponse_OscArgument clone() => MonitorOscResponse_OscArgument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorOscResponse_OscArgument copyWith(void Function(MonitorOscResponse_OscArgument) updates) => super.copyWith((message) => updates(message as MonitorOscResponse_OscArgument)) as MonitorOscResponse_OscArgument; // ignore: deprecated_member_use
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
}

class MonitorOscResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MonitorOscResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..pc<MonitorOscResponse_OscArgument>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'args', $pb.PbFieldType.PM, subBuilder: MonitorOscResponse_OscArgument.create)
    ..hasRequiredFields = false
  ;

  MonitorOscResponse._() : super();
  factory MonitorOscResponse({
    $fixnum.Int64? timestamp,
    $core.String? path,
    $core.Iterable<MonitorOscResponse_OscArgument>? args,
  }) {
    final _result = create();
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (path != null) {
      _result.path = path;
    }
    if (args != null) {
      _result.args.addAll(args);
    }
    return _result;
  }
  factory MonitorOscResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MonitorOscResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MonitorOscResponse clone() => MonitorOscResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MonitorOscResponse copyWith(void Function(MonitorOscResponse) updates) => super.copyWith((message) => updates(message as MonitorOscResponse)) as MonitorOscResponse; // ignore: deprecated_member_use
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

class GetDeviceProfilesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDeviceProfilesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetDeviceProfilesRequest._() : super();
  factory GetDeviceProfilesRequest() => create();
  factory GetDeviceProfilesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDeviceProfilesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDeviceProfilesRequest clone() => GetDeviceProfilesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDeviceProfilesRequest copyWith(void Function(GetDeviceProfilesRequest) updates) => super.copyWith((message) => updates(message as GetDeviceProfilesRequest)) as GetDeviceProfilesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDeviceProfilesRequest create() => GetDeviceProfilesRequest._();
  GetDeviceProfilesRequest createEmptyInstance() => create();
  static $pb.PbList<GetDeviceProfilesRequest> createRepeated() => $pb.PbList<GetDeviceProfilesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDeviceProfilesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDeviceProfilesRequest>(create);
  static GetDeviceProfilesRequest? _defaultInstance;
}

class ArtnetConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ArtnetConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'host')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'port', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  ArtnetConfig._() : super();
  factory ArtnetConfig({
    $core.String? name,
    $core.String? host,
    $core.int? port,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (host != null) {
      _result.host = host;
    }
    if (port != null) {
      _result.port = port;
    }
    return _result;
  }
  factory ArtnetConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ArtnetConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ArtnetConfig clone() => ArtnetConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ArtnetConfig copyWith(void Function(ArtnetConfig) updates) => super.copyWith((message) => updates(message as ArtnetConfig)) as ArtnetConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ArtnetConfig create() => ArtnetConfig._();
  ArtnetConfig createEmptyInstance() => create();
  static $pb.PbList<ArtnetConfig> createRepeated() => $pb.PbList<ArtnetConfig>();
  @$core.pragma('dart2js:noInline')
  static ArtnetConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ArtnetConfig>(create);
  static ArtnetConfig? _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SacnConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  SacnConfig._() : super();
  factory SacnConfig({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory SacnConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SacnConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SacnConfig clone() => SacnConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SacnConfig copyWith(void Function(SacnConfig) updates) => super.copyWith((message) => updates(message as SacnConfig)) as SacnConfig; // ignore: deprecated_member_use
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
  proDjLink, 
  helios, 
  etherDream, 
  gamepad, 
  mqtt, 
  g13, 
  notSet
}

class Connection extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Connection_Connection> _Connection_ConnectionByTag = {
    10 : Connection_Connection.dmx,
    11 : Connection_Connection.midi,
    12 : Connection_Connection.osc,
    13 : Connection_Connection.proDjLink,
    14 : Connection_Connection.helios,
    15 : Connection_Connection.etherDream,
    16 : Connection_Connection.gamepad,
    17 : Connection_Connection.mqtt,
    18 : Connection_Connection.g13,
    0 : Connection_Connection.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Connection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..oo(0, [10, 11, 12, 13, 14, 15, 16, 17, 18])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOM<DmxConnection>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dmx', subBuilder: DmxConnection.create)
    ..aOM<MidiConnection>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'midi', subBuilder: MidiConnection.create)
    ..aOM<OscConnection>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'osc', subBuilder: OscConnection.create)
    ..aOM<ProDjLinkConnection>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'proDjLink', subBuilder: ProDjLinkConnection.create)
    ..aOM<HeliosConnection>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'helios', subBuilder: HeliosConnection.create)
    ..aOM<EtherDreamConnection>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'etherDream', subBuilder: EtherDreamConnection.create)
    ..aOM<GamepadConnection>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gamepad', subBuilder: GamepadConnection.create)
    ..aOM<MqttConnection>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mqtt', subBuilder: MqttConnection.create)
    ..aOM<G13Connection>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'g13', subBuilder: G13Connection.create)
    ..hasRequiredFields = false
  ;

  Connection._() : super();
  factory Connection({
    $core.String? name,
    DmxConnection? dmx,
    MidiConnection? midi,
    OscConnection? osc,
    ProDjLinkConnection? proDjLink,
    HeliosConnection? helios,
    EtherDreamConnection? etherDream,
    GamepadConnection? gamepad,
    MqttConnection? mqtt,
    G13Connection? g13,
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
    if (proDjLink != null) {
      _result.proDjLink = proDjLink;
    }
    if (helios != null) {
      _result.helios = helios;
    }
    if (etherDream != null) {
      _result.etherDream = etherDream;
    }
    if (gamepad != null) {
      _result.gamepad = gamepad;
    }
    if (mqtt != null) {
      _result.mqtt = mqtt;
    }
    if (g13 != null) {
      _result.g13 = g13;
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
  ProDjLinkConnection get proDjLink => $_getN(4);
  @$pb.TagNumber(13)
  set proDjLink(ProDjLinkConnection v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasProDjLink() => $_has(4);
  @$pb.TagNumber(13)
  void clearProDjLink() => clearField(13);
  @$pb.TagNumber(13)
  ProDjLinkConnection ensureProDjLink() => $_ensure(4);

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
}

enum DmxConnection_Config {
  artnet, 
  sacn, 
  notSet
}

class DmxConnection extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, DmxConnection_Config> _DmxConnection_ConfigByTag = {
    3 : DmxConnection_Config.artnet,
    4 : DmxConnection_Config.sacn,
    0 : DmxConnection_Config.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DmxConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputId')
    ..aOM<ArtnetConfig>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'artnet', subBuilder: ArtnetConfig.create)
    ..aOM<SacnConfig>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sacn', subBuilder: SacnConfig.create)
    ..hasRequiredFields = false
  ;

  DmxConnection._() : super();
  factory DmxConnection({
    $core.String? outputId,
    ArtnetConfig? artnet,
    SacnConfig? sacn,
  }) {
    final _result = create();
    if (outputId != null) {
      _result.outputId = outputId;
    }
    if (artnet != null) {
      _result.artnet = artnet;
    }
    if (sacn != null) {
      _result.sacn = sacn;
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

  DmxConnection_Config whichConfig() => _DmxConnection_ConfigByTag[$_whichOneof(0)]!;
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
  ArtnetConfig get artnet => $_getN(1);
  @$pb.TagNumber(3)
  set artnet(ArtnetConfig v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasArtnet() => $_has(1);
  @$pb.TagNumber(3)
  void clearArtnet() => clearField(3);
  @$pb.TagNumber(3)
  ArtnetConfig ensureArtnet() => $_ensure(1);

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

class HeliosConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HeliosConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firmware', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  HeliosConnection._() : super();
  factory HeliosConnection({
    $core.String? name,
    $core.int? firmware,
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
  $core.int get firmware => $_getIZ(1);
  @$pb.TagNumber(2)
  set firmware($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirmware() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirmware() => clearField(2);
}

class EtherDreamConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EtherDreamConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  EtherDreamConnection._() : super();
  factory EtherDreamConnection({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory EtherDreamConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EtherDreamConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EtherDreamConnection clone() => EtherDreamConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EtherDreamConnection copyWith(void Function(EtherDreamConnection) updates) => super.copyWith((message) => updates(message as EtherDreamConnection)) as EtherDreamConnection; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GamepadConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  GamepadConnection._() : super();
  factory GamepadConnection({
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
  factory GamepadConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GamepadConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GamepadConnection clone() => GamepadConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GamepadConnection copyWith(void Function(GamepadConnection) updates) => super.copyWith((message) => updates(message as GamepadConnection)) as GamepadConnection; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'G13Connection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  G13Connection._() : super();
  factory G13Connection({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory G13Connection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory G13Connection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  G13Connection clone() => G13Connection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  G13Connection copyWith(void Function(G13Connection) updates) => super.copyWith((message) => updates(message as G13Connection)) as G13Connection; // ignore: deprecated_member_use
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

class MidiConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceProfile')
    ..hasRequiredFields = false
  ;

  MidiConnection._() : super();
  factory MidiConnection({
    $core.String? deviceProfile,
  }) {
    final _result = create();
    if (deviceProfile != null) {
      _result.deviceProfile = deviceProfile;
    }
    return _result;
  }
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiDeviceProfiles', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..pc<MidiDeviceProfile>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profiles', $pb.PbFieldType.PM, subBuilder: MidiDeviceProfile.create)
    ..hasRequiredFields = false
  ;

  MidiDeviceProfiles._() : super();
  factory MidiDeviceProfiles({
    $core.Iterable<MidiDeviceProfile>? profiles,
  }) {
    final _result = create();
    if (profiles != null) {
      _result.profiles.addAll(profiles);
    }
    return _result;
  }
  factory MidiDeviceProfiles.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfiles.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfiles clone() => MidiDeviceProfiles()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfiles copyWith(void Function(MidiDeviceProfiles) updates) => super.copyWith((message) => updates(message as MidiDeviceProfiles)) as MidiDeviceProfiles; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiDeviceProfile.Page', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<MidiDeviceProfile_Group>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groups', $pb.PbFieldType.PM, subBuilder: MidiDeviceProfile_Group.create)
    ..pc<MidiDeviceProfile_Control>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controls', $pb.PbFieldType.PM, subBuilder: MidiDeviceProfile_Control.create)
    ..hasRequiredFields = false
  ;

  MidiDeviceProfile_Page._() : super();
  factory MidiDeviceProfile_Page({
    $core.String? name,
    $core.Iterable<MidiDeviceProfile_Group>? groups,
    $core.Iterable<MidiDeviceProfile_Control>? controls,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (groups != null) {
      _result.groups.addAll(groups);
    }
    if (controls != null) {
      _result.controls.addAll(controls);
    }
    return _result;
  }
  factory MidiDeviceProfile_Page.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfile_Page.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile_Page clone() => MidiDeviceProfile_Page()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile_Page copyWith(void Function(MidiDeviceProfile_Page) updates) => super.copyWith((message) => updates(message as MidiDeviceProfile_Page)) as MidiDeviceProfile_Page; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiDeviceProfile.Group', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<MidiDeviceProfile_Control>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controls', $pb.PbFieldType.PM, subBuilder: MidiDeviceProfile_Control.create)
    ..hasRequiredFields = false
  ;

  MidiDeviceProfile_Group._() : super();
  factory MidiDeviceProfile_Group({
    $core.String? name,
    $core.Iterable<MidiDeviceProfile_Control>? controls,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (controls != null) {
      _result.controls.addAll(controls);
    }
    return _result;
  }
  factory MidiDeviceProfile_Group.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfile_Group.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile_Group clone() => MidiDeviceProfile_Group()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile_Group copyWith(void Function(MidiDeviceProfile_Group) updates) => super.copyWith((message) => updates(message as MidiDeviceProfile_Group)) as MidiDeviceProfile_Group; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiDeviceProfile.Control', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'note', $pb.PbFieldType.OU3)
    ..e<MidiDeviceProfile_ControlType>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controlType', $pb.PbFieldType.OE, defaultOrMaker: MidiDeviceProfile_ControlType.NOTE, valueOf: MidiDeviceProfile_ControlType.valueOf, enumValues: MidiDeviceProfile_ControlType.values)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasOutput')
    ..hasRequiredFields = false
  ;

  MidiDeviceProfile_Control._() : super();
  factory MidiDeviceProfile_Control({
    $core.String? id,
    $core.String? name,
    $core.int? channel,
    $core.int? note,
    MidiDeviceProfile_ControlType? controlType,
    $core.bool? hasOutput,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (channel != null) {
      _result.channel = channel;
    }
    if (note != null) {
      _result.note = note;
    }
    if (controlType != null) {
      _result.controlType = controlType;
    }
    if (hasOutput != null) {
      _result.hasOutput = hasOutput;
    }
    return _result;
  }
  factory MidiDeviceProfile_Control.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfile_Control.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile_Control clone() => MidiDeviceProfile_Control()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile_Control copyWith(void Function(MidiDeviceProfile_Control) updates) => super.copyWith((message) => updates(message as MidiDeviceProfile_Control)) as MidiDeviceProfile_Control; // ignore: deprecated_member_use
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
  $core.int get channel => $_getIZ(2);
  @$pb.TagNumber(3)
  set channel($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannel() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannel() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get note => $_getIZ(3);
  @$pb.TagNumber(4)
  set note($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNote() => $_has(3);
  @$pb.TagNumber(4)
  void clearNote() => clearField(4);

  @$pb.TagNumber(5)
  MidiDeviceProfile_ControlType get controlType => $_getN(4);
  @$pb.TagNumber(5)
  set controlType(MidiDeviceProfile_ControlType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasControlType() => $_has(4);
  @$pb.TagNumber(5)
  void clearControlType() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasOutput => $_getBF(5);
  @$pb.TagNumber(6)
  set hasOutput($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasOutput() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasOutput() => clearField(6);
}

class MidiDeviceProfile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiDeviceProfile', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'manufacturer')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'model')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'layout')
    ..pc<MidiDeviceProfile_Page>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pages', $pb.PbFieldType.PM, subBuilder: MidiDeviceProfile_Page.create)
    ..hasRequiredFields = false
  ;

  MidiDeviceProfile._() : super();
  factory MidiDeviceProfile({
    $core.String? id,
    $core.String? manufacturer,
    $core.String? model,
    $core.String? layout,
    $core.Iterable<MidiDeviceProfile_Page>? pages,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (manufacturer != null) {
      _result.manufacturer = manufacturer;
    }
    if (model != null) {
      _result.model = model;
    }
    if (layout != null) {
      _result.layout = layout;
    }
    if (pages != null) {
      _result.pages.addAll(pages);
    }
    return _result;
  }
  factory MidiDeviceProfile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile clone() => MidiDeviceProfile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile copyWith(void Function(MidiDeviceProfile) updates) => super.copyWith((message) => updates(message as MidiDeviceProfile)) as MidiDeviceProfile; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OscConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'connectionId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inputPort', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputPort', $pb.PbFieldType.OU3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputAddress')
    ..hasRequiredFields = false
  ;

  OscConnection._() : super();
  factory OscConnection({
    $core.String? connectionId,
    $core.int? inputPort,
    $core.int? outputPort,
    $core.String? outputAddress,
  }) {
    final _result = create();
    if (connectionId != null) {
      _result.connectionId = connectionId;
    }
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

class ProDjLinkConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProDjLinkConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'model')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerNumber', $pb.PbFieldType.OU3)
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
    ..e<CdjPlayback_State>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playback', $pb.PbFieldType.OE, defaultOrMaker: CdjPlayback_State.LOADING, valueOf: CdjPlayback_State.valueOf, enumValues: CdjPlayback_State.values)
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

class MqttConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MqttConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'connectionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'password')
    ..hasRequiredFields = false
  ;

  MqttConnection._() : super();
  factory MqttConnection({
    $core.String? connectionId,
    $core.String? url,
    $core.String? username,
    $core.String? password,
  }) {
    final _result = create();
    if (connectionId != null) {
      _result.connectionId = connectionId;
    }
    if (url != null) {
      _result.url = url;
    }
    if (username != null) {
      _result.username = username;
    }
    if (password != null) {
      _result.password = password;
    }
    return _result;
  }
  factory MqttConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MqttConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MqttConnection clone() => MqttConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MqttConnection copyWith(void Function(MqttConnection) updates) => super.copyWith((message) => updates(message as MqttConnection)) as MqttConnection; // ignore: deprecated_member_use
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

enum ConfigureConnectionRequest_Config {
  dmx, 
  mqtt, 
  osc, 
  notSet
}

class ConfigureConnectionRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, ConfigureConnectionRequest_Config> _ConfigureConnectionRequest_ConfigByTag = {
    1 : ConfigureConnectionRequest_Config.dmx,
    2 : ConfigureConnectionRequest_Config.mqtt,
    3 : ConfigureConnectionRequest_Config.osc,
    0 : ConfigureConnectionRequest_Config.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConfigureConnectionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<DmxConnection>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dmx', subBuilder: DmxConnection.create)
    ..aOM<MqttConnection>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mqtt', subBuilder: MqttConnection.create)
    ..aOM<OscConnection>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'osc', subBuilder: OscConnection.create)
    ..hasRequiredFields = false
  ;

  ConfigureConnectionRequest._() : super();
  factory ConfigureConnectionRequest({
    DmxConnection? dmx,
    MqttConnection? mqtt,
    OscConnection? osc,
  }) {
    final _result = create();
    if (dmx != null) {
      _result.dmx = dmx;
    }
    if (mqtt != null) {
      _result.mqtt = mqtt;
    }
    if (osc != null) {
      _result.osc = osc;
    }
    return _result;
  }
  factory ConfigureConnectionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConfigureConnectionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConfigureConnectionRequest clone() => ConfigureConnectionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConfigureConnectionRequest copyWith(void Function(ConfigureConnectionRequest) updates) => super.copyWith((message) => updates(message as ConfigureConnectionRequest)) as ConfigureConnectionRequest; // ignore: deprecated_member_use
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
  DmxConnection get dmx => $_getN(0);
  @$pb.TagNumber(1)
  set dmx(DmxConnection v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDmx() => $_has(0);
  @$pb.TagNumber(1)
  void clearDmx() => clearField(1);
  @$pb.TagNumber(1)
  DmxConnection ensureDmx() => $_ensure(0);

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
}

