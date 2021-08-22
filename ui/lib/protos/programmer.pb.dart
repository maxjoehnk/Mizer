///
//  Generated code. Do not modify.
//  source: programmer.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'fixtures.pb.dart' as $0;

import 'programmer.pbenum.dart';

export 'programmer.pbenum.dart';

class SubscribeProgrammerRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscribeProgrammerRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SubscribeProgrammerRequest._() : super();
  factory SubscribeProgrammerRequest() => create();
  factory SubscribeProgrammerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeProgrammerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeProgrammerRequest clone() => SubscribeProgrammerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeProgrammerRequest copyWith(void Function(SubscribeProgrammerRequest) updates) => super.copyWith((message) => updates(message as SubscribeProgrammerRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeProgrammerRequest create() => SubscribeProgrammerRequest._();
  SubscribeProgrammerRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeProgrammerRequest> createRepeated() => $pb.PbList<SubscribeProgrammerRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeProgrammerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeProgrammerRequest>(create);
  static SubscribeProgrammerRequest _defaultInstance;
}

class ProgrammerState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProgrammerState', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..p<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtures', $pb.PbFieldType.PU3)
    ..hasRequiredFields = false
  ;

  ProgrammerState._() : super();
  factory ProgrammerState({
    $core.Iterable<$core.int> fixtures,
  }) {
    final _result = create();
    if (fixtures != null) {
      _result.fixtures.addAll(fixtures);
    }
    return _result;
  }
  factory ProgrammerState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProgrammerState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProgrammerState clone() => ProgrammerState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProgrammerState copyWith(void Function(ProgrammerState) updates) => super.copyWith((message) => updates(message as ProgrammerState)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProgrammerState create() => ProgrammerState._();
  ProgrammerState createEmptyInstance() => create();
  static $pb.PbList<ProgrammerState> createRepeated() => $pb.PbList<ProgrammerState>();
  @$core.pragma('dart2js:noInline')
  static ProgrammerState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProgrammerState>(create);
  static ProgrammerState _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get fixtures => $_getList(0);
}

enum WriteChannelsRequest_Value {
  fader, 
  color, 
  notSet
}

class WriteChannelsRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, WriteChannelsRequest_Value> _WriteChannelsRequest_ValueByTag = {
    2 : WriteChannelsRequest_Value.fader,
    3 : WriteChannelsRequest_Value.color,
    0 : WriteChannelsRequest_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteChannelsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fader', $pb.PbFieldType.OD)
    ..aOM<$0.ColorChannel>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', subBuilder: $0.ColorChannel.create)
    ..hasRequiredFields = false
  ;

  WriteChannelsRequest._() : super();
  factory WriteChannelsRequest({
    $core.String channel,
    $core.double fader,
    $0.ColorChannel color,
  }) {
    final _result = create();
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
  factory WriteChannelsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteChannelsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteChannelsRequest clone() => WriteChannelsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteChannelsRequest copyWith(void Function(WriteChannelsRequest) updates) => super.copyWith((message) => updates(message as WriteChannelsRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteChannelsRequest create() => WriteChannelsRequest._();
  WriteChannelsRequest createEmptyInstance() => create();
  static $pb.PbList<WriteChannelsRequest> createRepeated() => $pb.PbList<WriteChannelsRequest>();
  @$core.pragma('dart2js:noInline')
  static WriteChannelsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteChannelsRequest>(create);
  static WriteChannelsRequest _defaultInstance;

  WriteChannelsRequest_Value whichValue() => _WriteChannelsRequest_ValueByTag[$_whichOneof(0)];
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get channel => $_getSZ(0);
  @$pb.TagNumber(1)
  set channel($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get fader => $_getN(1);
  @$pb.TagNumber(2)
  set fader($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFader() => $_has(1);
  @$pb.TagNumber(2)
  void clearFader() => clearField(2);

  @$pb.TagNumber(3)
  $0.ColorChannel get color => $_getN(2);
  @$pb.TagNumber(3)
  set color($0.ColorChannel v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasColor() => $_has(2);
  @$pb.TagNumber(3)
  void clearColor() => clearField(3);
  @$pb.TagNumber(3)
  $0.ColorChannel ensureColor() => $_ensure(2);
}

class WriteChannelsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteChannelsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  WriteChannelsResponse._() : super();
  factory WriteChannelsResponse() => create();
  factory WriteChannelsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteChannelsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteChannelsResponse clone() => WriteChannelsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteChannelsResponse copyWith(void Function(WriteChannelsResponse) updates) => super.copyWith((message) => updates(message as WriteChannelsResponse)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteChannelsResponse create() => WriteChannelsResponse._();
  WriteChannelsResponse createEmptyInstance() => create();
  static $pb.PbList<WriteChannelsResponse> createRepeated() => $pb.PbList<WriteChannelsResponse>();
  @$core.pragma('dart2js:noInline')
  static WriteChannelsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteChannelsResponse>(create);
  static WriteChannelsResponse _defaultInstance;
}

class SelectFixturesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SelectFixturesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..p<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtures', $pb.PbFieldType.PU3)
    ..hasRequiredFields = false
  ;

  SelectFixturesRequest._() : super();
  factory SelectFixturesRequest({
    $core.Iterable<$core.int> fixtures,
  }) {
    final _result = create();
    if (fixtures != null) {
      _result.fixtures.addAll(fixtures);
    }
    return _result;
  }
  factory SelectFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SelectFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SelectFixturesRequest clone() => SelectFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SelectFixturesRequest copyWith(void Function(SelectFixturesRequest) updates) => super.copyWith((message) => updates(message as SelectFixturesRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SelectFixturesRequest create() => SelectFixturesRequest._();
  SelectFixturesRequest createEmptyInstance() => create();
  static $pb.PbList<SelectFixturesRequest> createRepeated() => $pb.PbList<SelectFixturesRequest>();
  @$core.pragma('dart2js:noInline')
  static SelectFixturesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SelectFixturesRequest>(create);
  static SelectFixturesRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get fixtures => $_getList(0);
}

class SelectFixturesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SelectFixturesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SelectFixturesResponse._() : super();
  factory SelectFixturesResponse() => create();
  factory SelectFixturesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SelectFixturesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SelectFixturesResponse clone() => SelectFixturesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SelectFixturesResponse copyWith(void Function(SelectFixturesResponse) updates) => super.copyWith((message) => updates(message as SelectFixturesResponse)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SelectFixturesResponse create() => SelectFixturesResponse._();
  SelectFixturesResponse createEmptyInstance() => create();
  static $pb.PbList<SelectFixturesResponse> createRepeated() => $pb.PbList<SelectFixturesResponse>();
  @$core.pragma('dart2js:noInline')
  static SelectFixturesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SelectFixturesResponse>(create);
  static SelectFixturesResponse _defaultInstance;
}

class ClearRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClearRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ClearRequest._() : super();
  factory ClearRequest() => create();
  factory ClearRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClearRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClearRequest clone() => ClearRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClearRequest copyWith(void Function(ClearRequest) updates) => super.copyWith((message) => updates(message as ClearRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClearRequest create() => ClearRequest._();
  ClearRequest createEmptyInstance() => create();
  static $pb.PbList<ClearRequest> createRepeated() => $pb.PbList<ClearRequest>();
  @$core.pragma('dart2js:noInline')
  static ClearRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClearRequest>(create);
  static ClearRequest _defaultInstance;
}

class ClearResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClearResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ClearResponse._() : super();
  factory ClearResponse() => create();
  factory ClearResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClearResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClearResponse clone() => ClearResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClearResponse copyWith(void Function(ClearResponse) updates) => super.copyWith((message) => updates(message as ClearResponse)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClearResponse create() => ClearResponse._();
  ClearResponse createEmptyInstance() => create();
  static $pb.PbList<ClearResponse> createRepeated() => $pb.PbList<ClearResponse>();
  @$core.pragma('dart2js:noInline')
  static ClearResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClearResponse>(create);
  static ClearResponse _defaultInstance;
}

class HighlightRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HighlightRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'highlight')
    ..hasRequiredFields = false
  ;

  HighlightRequest._() : super();
  factory HighlightRequest({
    $core.bool highlight,
  }) {
    final _result = create();
    if (highlight != null) {
      _result.highlight = highlight;
    }
    return _result;
  }
  factory HighlightRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HighlightRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HighlightRequest clone() => HighlightRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HighlightRequest copyWith(void Function(HighlightRequest) updates) => super.copyWith((message) => updates(message as HighlightRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HighlightRequest create() => HighlightRequest._();
  HighlightRequest createEmptyInstance() => create();
  static $pb.PbList<HighlightRequest> createRepeated() => $pb.PbList<HighlightRequest>();
  @$core.pragma('dart2js:noInline')
  static HighlightRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HighlightRequest>(create);
  static HighlightRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get highlight => $_getBF(0);
  @$pb.TagNumber(1)
  set highlight($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHighlight() => $_has(0);
  @$pb.TagNumber(1)
  void clearHighlight() => clearField(1);
}

class HighlightResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HighlightResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  HighlightResponse._() : super();
  factory HighlightResponse() => create();
  factory HighlightResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HighlightResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HighlightResponse clone() => HighlightResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HighlightResponse copyWith(void Function(HighlightResponse) updates) => super.copyWith((message) => updates(message as HighlightResponse)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HighlightResponse create() => HighlightResponse._();
  HighlightResponse createEmptyInstance() => create();
  static $pb.PbList<HighlightResponse> createRepeated() => $pb.PbList<HighlightResponse>();
  @$core.pragma('dart2js:noInline')
  static HighlightResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HighlightResponse>(create);
  static HighlightResponse _defaultInstance;
}

class StoreRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StoreRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequenceId', $pb.PbFieldType.OU3)
    ..e<StoreRequest_Mode>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'storeMode', $pb.PbFieldType.OE, defaultOrMaker: StoreRequest_Mode.Overwrite, valueOf: StoreRequest_Mode.valueOf, enumValues: StoreRequest_Mode.values)
    ..hasRequiredFields = false
  ;

  StoreRequest._() : super();
  factory StoreRequest({
    $core.int sequenceId,
    StoreRequest_Mode storeMode,
  }) {
    final _result = create();
    if (sequenceId != null) {
      _result.sequenceId = sequenceId;
    }
    if (storeMode != null) {
      _result.storeMode = storeMode;
    }
    return _result;
  }
  factory StoreRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StoreRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StoreRequest clone() => StoreRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StoreRequest copyWith(void Function(StoreRequest) updates) => super.copyWith((message) => updates(message as StoreRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StoreRequest create() => StoreRequest._();
  StoreRequest createEmptyInstance() => create();
  static $pb.PbList<StoreRequest> createRepeated() => $pb.PbList<StoreRequest>();
  @$core.pragma('dart2js:noInline')
  static StoreRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StoreRequest>(create);
  static StoreRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequenceId => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequenceId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequenceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequenceId() => clearField(1);

  @$pb.TagNumber(2)
  StoreRequest_Mode get storeMode => $_getN(1);
  @$pb.TagNumber(2)
  set storeMode(StoreRequest_Mode v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStoreMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearStoreMode() => clearField(2);
}

class StoreResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StoreResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  StoreResponse._() : super();
  factory StoreResponse() => create();
  factory StoreResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StoreResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StoreResponse clone() => StoreResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StoreResponse copyWith(void Function(StoreResponse) updates) => super.copyWith((message) => updates(message as StoreResponse)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StoreResponse create() => StoreResponse._();
  StoreResponse createEmptyInstance() => create();
  static $pb.PbList<StoreResponse> createRepeated() => $pb.PbList<StoreResponse>();
  @$core.pragma('dart2js:noInline')
  static StoreResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StoreResponse>(create);
  static StoreResponse _defaultInstance;
}

