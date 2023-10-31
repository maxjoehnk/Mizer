//
//  Generated code. Do not modify.
//  source: transport.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'transport.pbenum.dart';

export 'transport.pbenum.dart';

class Transport extends $pb.GeneratedMessage {
  factory Transport({
    TransportState? state,
    $core.double? speed,
    Timecode? timecode,
    $core.double? fps,
  }) {
    final $result = create();
    if (state != null) {
      $result.state = state;
    }
    if (speed != null) {
      $result.speed = speed;
    }
    if (timecode != null) {
      $result.timecode = timecode;
    }
    if (fps != null) {
      $result.fps = fps;
    }
    return $result;
  }
  Transport._() : super();
  factory Transport.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Transport.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Transport', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.transport'), createEmptyInstance: create)
    ..e<TransportState>(1, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: TransportState.STOPPED, valueOf: TransportState.valueOf, enumValues: TransportState.values)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'speed', $pb.PbFieldType.OD)
    ..aOM<Timecode>(3, _omitFieldNames ? '' : 'timecode', subBuilder: Timecode.create)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'fps', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Transport clone() => Transport()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Transport copyWith(void Function(Transport) updates) => super.copyWith((message) => updates(message as Transport)) as Transport;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transport create() => Transport._();
  Transport createEmptyInstance() => create();
  static $pb.PbList<Transport> createRepeated() => $pb.PbList<Transport>();
  @$core.pragma('dart2js:noInline')
  static Transport getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transport>(create);
  static Transport? _defaultInstance;

  @$pb.TagNumber(1)
  TransportState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(TransportState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get speed => $_getN(1);
  @$pb.TagNumber(2)
  set speed($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSpeed() => $_has(1);
  @$pb.TagNumber(2)
  void clearSpeed() => clearField(2);

  @$pb.TagNumber(3)
  Timecode get timecode => $_getN(2);
  @$pb.TagNumber(3)
  set timecode(Timecode v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimecode() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimecode() => clearField(3);
  @$pb.TagNumber(3)
  Timecode ensureTimecode() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.double get fps => $_getN(3);
  @$pb.TagNumber(4)
  set fps($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFps() => $_has(3);
  @$pb.TagNumber(4)
  void clearFps() => clearField(4);
}

class Timecode extends $pb.GeneratedMessage {
  factory Timecode({
    $fixnum.Int64? frames,
    $fixnum.Int64? seconds,
    $fixnum.Int64? minutes,
    $fixnum.Int64? hours,
  }) {
    final $result = create();
    if (frames != null) {
      $result.frames = frames;
    }
    if (seconds != null) {
      $result.seconds = seconds;
    }
    if (minutes != null) {
      $result.minutes = minutes;
    }
    if (hours != null) {
      $result.hours = hours;
    }
    return $result;
  }
  Timecode._() : super();
  factory Timecode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Timecode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Timecode', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.transport'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'frames', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'seconds', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'minutes', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'hours', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Timecode clone() => Timecode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Timecode copyWith(void Function(Timecode) updates) => super.copyWith((message) => updates(message as Timecode)) as Timecode;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Timecode create() => Timecode._();
  Timecode createEmptyInstance() => create();
  static $pb.PbList<Timecode> createRepeated() => $pb.PbList<Timecode>();
  @$core.pragma('dart2js:noInline')
  static Timecode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Timecode>(create);
  static Timecode? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get frames => $_getI64(0);
  @$pb.TagNumber(1)
  set frames($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFrames() => $_has(0);
  @$pb.TagNumber(1)
  void clearFrames() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get seconds => $_getI64(1);
  @$pb.TagNumber(2)
  set seconds($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSeconds() => $_has(1);
  @$pb.TagNumber(2)
  void clearSeconds() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get minutes => $_getI64(2);
  @$pb.TagNumber(3)
  set minutes($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMinutes() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinutes() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get hours => $_getI64(3);
  @$pb.TagNumber(4)
  set hours($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHours() => $_has(3);
  @$pb.TagNumber(4)
  void clearHours() => clearField(4);
}

class SetTransportRequest extends $pb.GeneratedMessage {
  factory SetTransportRequest({
    TransportState? state,
  }) {
    final $result = create();
    if (state != null) {
      $result.state = state;
    }
    return $result;
  }
  SetTransportRequest._() : super();
  factory SetTransportRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetTransportRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetTransportRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.transport'), createEmptyInstance: create)
    ..e<TransportState>(1, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: TransportState.STOPPED, valueOf: TransportState.valueOf, enumValues: TransportState.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetTransportRequest clone() => SetTransportRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetTransportRequest copyWith(void Function(SetTransportRequest) updates) => super.copyWith((message) => updates(message as SetTransportRequest)) as SetTransportRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetTransportRequest create() => SetTransportRequest._();
  SetTransportRequest createEmptyInstance() => create();
  static $pb.PbList<SetTransportRequest> createRepeated() => $pb.PbList<SetTransportRequest>();
  @$core.pragma('dart2js:noInline')
  static SetTransportRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetTransportRequest>(create);
  static SetTransportRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TransportState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(TransportState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => clearField(1);
}

class SetBpmRequest extends $pb.GeneratedMessage {
  factory SetBpmRequest({
    $core.double? bpm,
  }) {
    final $result = create();
    if (bpm != null) {
      $result.bpm = bpm;
    }
    return $result;
  }
  SetBpmRequest._() : super();
  factory SetBpmRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetBpmRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetBpmRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.transport'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'bpm', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetBpmRequest clone() => SetBpmRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetBpmRequest copyWith(void Function(SetBpmRequest) updates) => super.copyWith((message) => updates(message as SetBpmRequest)) as SetBpmRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetBpmRequest create() => SetBpmRequest._();
  SetBpmRequest createEmptyInstance() => create();
  static $pb.PbList<SetBpmRequest> createRepeated() => $pb.PbList<SetBpmRequest>();
  @$core.pragma('dart2js:noInline')
  static SetBpmRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetBpmRequest>(create);
  static SetBpmRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get bpm => $_getN(0);
  @$pb.TagNumber(1)
  set bpm($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBpm() => $_has(0);
  @$pb.TagNumber(1)
  void clearBpm() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
