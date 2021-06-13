///
//  Generated code. Do not modify.
//  source: transport.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'transport.pbenum.dart';

export 'transport.pbenum.dart';

class SubscribeTransportRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscribeTransportRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SubscribeTransportRequest._() : super();
  factory SubscribeTransportRequest() => create();
  factory SubscribeTransportRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeTransportRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeTransportRequest clone() => SubscribeTransportRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeTransportRequest copyWith(void Function(SubscribeTransportRequest) updates) => super.copyWith((message) => updates(message as SubscribeTransportRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeTransportRequest create() => SubscribeTransportRequest._();
  SubscribeTransportRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeTransportRequest> createRepeated() => $pb.PbList<SubscribeTransportRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeTransportRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeTransportRequest>(create);
  static SubscribeTransportRequest _defaultInstance;
}

class Transport extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Transport', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..e<TransportState>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: TransportState.Stopped, valueOf: TransportState.valueOf, enumValues: TransportState.values)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'speed', $pb.PbFieldType.OD)
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frames')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'time', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Transport._() : super();
  factory Transport({
    TransportState state,
    $core.double speed,
    $fixnum.Int64 frames,
    $core.double time,
  }) {
    final _result = create();
    if (state != null) {
      _result.state = state;
    }
    if (speed != null) {
      _result.speed = speed;
    }
    if (frames != null) {
      _result.frames = frames;
    }
    if (time != null) {
      _result.time = time;
    }
    return _result;
  }
  factory Transport.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Transport.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Transport clone() => Transport()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Transport copyWith(void Function(Transport) updates) => super.copyWith((message) => updates(message as Transport)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Transport create() => Transport._();
  Transport createEmptyInstance() => create();
  static $pb.PbList<Transport> createRepeated() => $pb.PbList<Transport>();
  @$core.pragma('dart2js:noInline')
  static Transport getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transport>(create);
  static Transport _defaultInstance;

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
  $fixnum.Int64 get frames => $_getI64(2);
  @$pb.TagNumber(3)
  set frames($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFrames() => $_has(2);
  @$pb.TagNumber(3)
  void clearFrames() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get time => $_getN(3);
  @$pb.TagNumber(4)
  set time($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearTime() => clearField(4);
}

class SetTransportRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetTransportRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..e<TransportState>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: TransportState.Stopped, valueOf: TransportState.valueOf, enumValues: TransportState.values)
    ..hasRequiredFields = false
  ;

  SetTransportRequest._() : super();
  factory SetTransportRequest({
    TransportState state,
  }) {
    final _result = create();
    if (state != null) {
      _result.state = state;
    }
    return _result;
  }
  factory SetTransportRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetTransportRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetTransportRequest clone() => SetTransportRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetTransportRequest copyWith(void Function(SetTransportRequest) updates) => super.copyWith((message) => updates(message as SetTransportRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetTransportRequest create() => SetTransportRequest._();
  SetTransportRequest createEmptyInstance() => create();
  static $pb.PbList<SetTransportRequest> createRepeated() => $pb.PbList<SetTransportRequest>();
  @$core.pragma('dart2js:noInline')
  static SetTransportRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetTransportRequest>(create);
  static SetTransportRequest _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetBpmRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bpm', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  SetBpmRequest._() : super();
  factory SetBpmRequest({
    $core.double bpm,
  }) {
    final _result = create();
    if (bpm != null) {
      _result.bpm = bpm;
    }
    return _result;
  }
  factory SetBpmRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetBpmRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetBpmRequest clone() => SetBpmRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetBpmRequest copyWith(void Function(SetBpmRequest) updates) => super.copyWith((message) => updates(message as SetBpmRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetBpmRequest create() => SetBpmRequest._();
  SetBpmRequest createEmptyInstance() => create();
  static $pb.PbList<SetBpmRequest> createRepeated() => $pb.PbList<SetBpmRequest>();
  @$core.pragma('dart2js:noInline')
  static SetBpmRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetBpmRequest>(create);
  static SetBpmRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get bpm => $_getN(0);
  @$pb.TagNumber(1)
  set bpm($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBpm() => $_has(0);
  @$pb.TagNumber(1)
  void clearBpm() => clearField(1);
}

