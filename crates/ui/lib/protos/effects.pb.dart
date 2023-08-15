///
//  Generated code. Do not modify.
//  source: effects.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'fixtures.pb.dart' as $0;
import 'sequencer.pb.dart' as $1;

import 'fixtures.pbenum.dart' as $0;

class AddEffectRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddEffectRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  AddEffectRequest._() : super();
  factory AddEffectRequest({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory AddEffectRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddEffectRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddEffectRequest clone() => AddEffectRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddEffectRequest copyWith(void Function(AddEffectRequest) updates) => super.copyWith((message) => updates(message as AddEffectRequest)) as AddEffectRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddEffectRequest create() => AddEffectRequest._();
  AddEffectRequest createEmptyInstance() => create();
  static $pb.PbList<AddEffectRequest> createRepeated() => $pb.PbList<AddEffectRequest>();
  @$core.pragma('dart2js:noInline')
  static AddEffectRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddEffectRequest>(create);
  static AddEffectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class UpdateEffectStepRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateEffectStepRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelIndex', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stepIndex', $pb.PbFieldType.OU3)
    ..aOM<EffectStep>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'step', subBuilder: EffectStep.create)
    ..hasRequiredFields = false
  ;

  UpdateEffectStepRequest._() : super();
  factory UpdateEffectStepRequest({
    $core.int? effectId,
    $core.int? channelIndex,
    $core.int? stepIndex,
    EffectStep? step,
  }) {
    final _result = create();
    if (effectId != null) {
      _result.effectId = effectId;
    }
    if (channelIndex != null) {
      _result.channelIndex = channelIndex;
    }
    if (stepIndex != null) {
      _result.stepIndex = stepIndex;
    }
    if (step != null) {
      _result.step = step;
    }
    return _result;
  }
  factory UpdateEffectStepRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateEffectStepRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateEffectStepRequest clone() => UpdateEffectStepRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateEffectStepRequest copyWith(void Function(UpdateEffectStepRequest) updates) => super.copyWith((message) => updates(message as UpdateEffectStepRequest)) as UpdateEffectStepRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateEffectStepRequest create() => UpdateEffectStepRequest._();
  UpdateEffectStepRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateEffectStepRequest> createRepeated() => $pb.PbList<UpdateEffectStepRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateEffectStepRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateEffectStepRequest>(create);
  static UpdateEffectStepRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get effectId => $_getIZ(0);
  @$pb.TagNumber(1)
  set effectId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEffectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEffectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get channelIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set channelIndex($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelIndex() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get stepIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set stepIndex($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStepIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearStepIndex() => clearField(3);

  @$pb.TagNumber(4)
  EffectStep get step => $_getN(3);
  @$pb.TagNumber(4)
  set step(EffectStep v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStep() => $_has(3);
  @$pb.TagNumber(4)
  void clearStep() => clearField(4);
  @$pb.TagNumber(4)
  EffectStep ensureStep() => $_ensure(3);
}

class AddEffectChannelRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddEffectChannelRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..aOM<$0.FixtureFaderControl>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'control', subBuilder: $0.FixtureFaderControl.create)
    ..hasRequiredFields = false
  ;

  AddEffectChannelRequest._() : super();
  factory AddEffectChannelRequest({
    $core.int? effectId,
    $0.FixtureFaderControl? control,
  }) {
    final _result = create();
    if (effectId != null) {
      _result.effectId = effectId;
    }
    if (control != null) {
      _result.control = control;
    }
    return _result;
  }
  factory AddEffectChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddEffectChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddEffectChannelRequest clone() => AddEffectChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddEffectChannelRequest copyWith(void Function(AddEffectChannelRequest) updates) => super.copyWith((message) => updates(message as AddEffectChannelRequest)) as AddEffectChannelRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddEffectChannelRequest create() => AddEffectChannelRequest._();
  AddEffectChannelRequest createEmptyInstance() => create();
  static $pb.PbList<AddEffectChannelRequest> createRepeated() => $pb.PbList<AddEffectChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static AddEffectChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddEffectChannelRequest>(create);
  static AddEffectChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get effectId => $_getIZ(0);
  @$pb.TagNumber(1)
  set effectId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEffectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEffectId() => clearField(1);

  @$pb.TagNumber(2)
  $0.FixtureFaderControl get control => $_getN(1);
  @$pb.TagNumber(2)
  set control($0.FixtureFaderControl v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasControl() => $_has(1);
  @$pb.TagNumber(2)
  void clearControl() => clearField(2);
  @$pb.TagNumber(2)
  $0.FixtureFaderControl ensureControl() => $_ensure(1);
}

class DeleteEffectChannelRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteEffectChannelRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelIndex', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  DeleteEffectChannelRequest._() : super();
  factory DeleteEffectChannelRequest({
    $core.int? effectId,
    $core.int? channelIndex,
  }) {
    final _result = create();
    if (effectId != null) {
      _result.effectId = effectId;
    }
    if (channelIndex != null) {
      _result.channelIndex = channelIndex;
    }
    return _result;
  }
  factory DeleteEffectChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteEffectChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteEffectChannelRequest clone() => DeleteEffectChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteEffectChannelRequest copyWith(void Function(DeleteEffectChannelRequest) updates) => super.copyWith((message) => updates(message as DeleteEffectChannelRequest)) as DeleteEffectChannelRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteEffectChannelRequest create() => DeleteEffectChannelRequest._();
  DeleteEffectChannelRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteEffectChannelRequest> createRepeated() => $pb.PbList<DeleteEffectChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteEffectChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteEffectChannelRequest>(create);
  static DeleteEffectChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get effectId => $_getIZ(0);
  @$pb.TagNumber(1)
  set effectId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEffectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEffectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get channelIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set channelIndex($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelIndex() => clearField(2);
}

class AddEffectStepRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddEffectStepRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelIndex', $pb.PbFieldType.OU3)
    ..aOM<EffectStep>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'step', subBuilder: EffectStep.create)
    ..hasRequiredFields = false
  ;

  AddEffectStepRequest._() : super();
  factory AddEffectStepRequest({
    $core.int? effectId,
    $core.int? channelIndex,
    EffectStep? step,
  }) {
    final _result = create();
    if (effectId != null) {
      _result.effectId = effectId;
    }
    if (channelIndex != null) {
      _result.channelIndex = channelIndex;
    }
    if (step != null) {
      _result.step = step;
    }
    return _result;
  }
  factory AddEffectStepRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddEffectStepRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddEffectStepRequest clone() => AddEffectStepRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddEffectStepRequest copyWith(void Function(AddEffectStepRequest) updates) => super.copyWith((message) => updates(message as AddEffectStepRequest)) as AddEffectStepRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddEffectStepRequest create() => AddEffectStepRequest._();
  AddEffectStepRequest createEmptyInstance() => create();
  static $pb.PbList<AddEffectStepRequest> createRepeated() => $pb.PbList<AddEffectStepRequest>();
  @$core.pragma('dart2js:noInline')
  static AddEffectStepRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddEffectStepRequest>(create);
  static AddEffectStepRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get effectId => $_getIZ(0);
  @$pb.TagNumber(1)
  set effectId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEffectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEffectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get channelIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set channelIndex($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelIndex() => clearField(2);

  @$pb.TagNumber(3)
  EffectStep get step => $_getN(2);
  @$pb.TagNumber(3)
  set step(EffectStep v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStep() => $_has(2);
  @$pb.TagNumber(3)
  void clearStep() => clearField(3);
  @$pb.TagNumber(3)
  EffectStep ensureStep() => $_ensure(2);
}

class DeleteEffectStepRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteEffectStepRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channelIndex', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stepIndex', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  DeleteEffectStepRequest._() : super();
  factory DeleteEffectStepRequest({
    $core.int? effectId,
    $core.int? channelIndex,
    $core.int? stepIndex,
  }) {
    final _result = create();
    if (effectId != null) {
      _result.effectId = effectId;
    }
    if (channelIndex != null) {
      _result.channelIndex = channelIndex;
    }
    if (stepIndex != null) {
      _result.stepIndex = stepIndex;
    }
    return _result;
  }
  factory DeleteEffectStepRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteEffectStepRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteEffectStepRequest clone() => DeleteEffectStepRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteEffectStepRequest copyWith(void Function(DeleteEffectStepRequest) updates) => super.copyWith((message) => updates(message as DeleteEffectStepRequest)) as DeleteEffectStepRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteEffectStepRequest create() => DeleteEffectStepRequest._();
  DeleteEffectStepRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteEffectStepRequest> createRepeated() => $pb.PbList<DeleteEffectStepRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteEffectStepRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteEffectStepRequest>(create);
  static DeleteEffectStepRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get effectId => $_getIZ(0);
  @$pb.TagNumber(1)
  set effectId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEffectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEffectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get channelIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set channelIndex($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelIndex() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get stepIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set stepIndex($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStepIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearStepIndex() => clearField(3);
}

class Effects extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Effects', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..pc<Effect>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effects', $pb.PbFieldType.PM, subBuilder: Effect.create)
    ..hasRequiredFields = false
  ;

  Effects._() : super();
  factory Effects({
    $core.Iterable<Effect>? effects,
  }) {
    final _result = create();
    if (effects != null) {
      _result.effects.addAll(effects);
    }
    return _result;
  }
  factory Effects.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Effects.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Effects clone() => Effects()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Effects copyWith(void Function(Effects) updates) => super.copyWith((message) => updates(message as Effects)) as Effects; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Effects create() => Effects._();
  Effects createEmptyInstance() => create();
  static $pb.PbList<Effects> createRepeated() => $pb.PbList<Effects>();
  @$core.pragma('dart2js:noInline')
  static Effects getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Effects>(create);
  static Effects? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Effect> get effects => $_getList(0);
}

class Effect extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Effect', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<EffectChannel>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: EffectChannel.create)
    ..hasRequiredFields = false
  ;

  Effect._() : super();
  factory Effect({
    $core.int? id,
    $core.String? name,
    $core.Iterable<EffectChannel>? channels,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (channels != null) {
      _result.channels.addAll(channels);
    }
    return _result;
  }
  factory Effect.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Effect.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Effect clone() => Effect()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Effect copyWith(void Function(Effect) updates) => super.copyWith((message) => updates(message as Effect)) as Effect; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Effect create() => Effect._();
  Effect createEmptyInstance() => create();
  static $pb.PbList<Effect> createRepeated() => $pb.PbList<Effect>();
  @$core.pragma('dart2js:noInline')
  static Effect getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Effect>(create);
  static Effect? _defaultInstance;

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
  $core.List<EffectChannel> get channels => $_getList(2);
}

class EffectChannel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EffectChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..e<$0.FixtureControl>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'control', $pb.PbFieldType.OE, defaultOrMaker: $0.FixtureControl.INTENSITY, valueOf: $0.FixtureControl.valueOf, enumValues: $0.FixtureControl.values)
    ..pc<EffectStep>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'steps', $pb.PbFieldType.PM, subBuilder: EffectStep.create)
    ..hasRequiredFields = false
  ;

  EffectChannel._() : super();
  factory EffectChannel({
    $0.FixtureControl? control,
    $core.Iterable<EffectStep>? steps,
  }) {
    final _result = create();
    if (control != null) {
      _result.control = control;
    }
    if (steps != null) {
      _result.steps.addAll(steps);
    }
    return _result;
  }
  factory EffectChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EffectChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EffectChannel clone() => EffectChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EffectChannel copyWith(void Function(EffectChannel) updates) => super.copyWith((message) => updates(message as EffectChannel)) as EffectChannel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EffectChannel create() => EffectChannel._();
  EffectChannel createEmptyInstance() => create();
  static $pb.PbList<EffectChannel> createRepeated() => $pb.PbList<EffectChannel>();
  @$core.pragma('dart2js:noInline')
  static EffectChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EffectChannel>(create);
  static EffectChannel? _defaultInstance;

  @$pb.TagNumber(1)
  $0.FixtureControl get control => $_getN(0);
  @$pb.TagNumber(1)
  set control($0.FixtureControl v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasControl() => $_has(0);
  @$pb.TagNumber(1)
  void clearControl() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<EffectStep> get steps => $_getList(1);
}

enum EffectStep_ControlPoint {
  simple, 
  quadratic, 
  cubic, 
  notSet
}

class EffectStep extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, EffectStep_ControlPoint> _EffectStep_ControlPointByTag = {
    2 : EffectStep_ControlPoint.simple,
    3 : EffectStep_ControlPoint.quadratic,
    4 : EffectStep_ControlPoint.cubic,
    0 : EffectStep_ControlPoint.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EffectStep', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4])
    ..aOM<$1.CueValue>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', subBuilder: $1.CueValue.create)
    ..aOM<SimpleControlPoint>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'simple', subBuilder: SimpleControlPoint.create)
    ..aOM<QuadraticControlPoint>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quadratic', subBuilder: QuadraticControlPoint.create)
    ..aOM<CubicControlPoint>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cubic', subBuilder: CubicControlPoint.create)
    ..hasRequiredFields = false
  ;

  EffectStep._() : super();
  factory EffectStep({
    $1.CueValue? value,
    SimpleControlPoint? simple,
    QuadraticControlPoint? quadratic,
    CubicControlPoint? cubic,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (simple != null) {
      _result.simple = simple;
    }
    if (quadratic != null) {
      _result.quadratic = quadratic;
    }
    if (cubic != null) {
      _result.cubic = cubic;
    }
    return _result;
  }
  factory EffectStep.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EffectStep.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EffectStep clone() => EffectStep()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EffectStep copyWith(void Function(EffectStep) updates) => super.copyWith((message) => updates(message as EffectStep)) as EffectStep; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EffectStep create() => EffectStep._();
  EffectStep createEmptyInstance() => create();
  static $pb.PbList<EffectStep> createRepeated() => $pb.PbList<EffectStep>();
  @$core.pragma('dart2js:noInline')
  static EffectStep getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EffectStep>(create);
  static EffectStep? _defaultInstance;

  EffectStep_ControlPoint whichControlPoint() => _EffectStep_ControlPointByTag[$_whichOneof(0)]!;
  void clearControlPoint() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $1.CueValue get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($1.CueValue v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
  @$pb.TagNumber(1)
  $1.CueValue ensureValue() => $_ensure(0);

  @$pb.TagNumber(2)
  SimpleControlPoint get simple => $_getN(1);
  @$pb.TagNumber(2)
  set simple(SimpleControlPoint v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSimple() => $_has(1);
  @$pb.TagNumber(2)
  void clearSimple() => clearField(2);
  @$pb.TagNumber(2)
  SimpleControlPoint ensureSimple() => $_ensure(1);

  @$pb.TagNumber(3)
  QuadraticControlPoint get quadratic => $_getN(2);
  @$pb.TagNumber(3)
  set quadratic(QuadraticControlPoint v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuadratic() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuadratic() => clearField(3);
  @$pb.TagNumber(3)
  QuadraticControlPoint ensureQuadratic() => $_ensure(2);

  @$pb.TagNumber(4)
  CubicControlPoint get cubic => $_getN(3);
  @$pb.TagNumber(4)
  set cubic(CubicControlPoint v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCubic() => $_has(3);
  @$pb.TagNumber(4)
  void clearCubic() => clearField(4);
  @$pb.TagNumber(4)
  CubicControlPoint ensureCubic() => $_ensure(3);
}

class SimpleControlPoint extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SimpleControlPoint', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SimpleControlPoint._() : super();
  factory SimpleControlPoint() => create();
  factory SimpleControlPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SimpleControlPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SimpleControlPoint clone() => SimpleControlPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SimpleControlPoint copyWith(void Function(SimpleControlPoint) updates) => super.copyWith((message) => updates(message as SimpleControlPoint)) as SimpleControlPoint; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SimpleControlPoint create() => SimpleControlPoint._();
  SimpleControlPoint createEmptyInstance() => create();
  static $pb.PbList<SimpleControlPoint> createRepeated() => $pb.PbList<SimpleControlPoint>();
  @$core.pragma('dart2js:noInline')
  static SimpleControlPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SimpleControlPoint>(create);
  static SimpleControlPoint? _defaultInstance;
}

class QuadraticControlPoint extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QuadraticControlPoint', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0a', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0b', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  QuadraticControlPoint._() : super();
  factory QuadraticControlPoint({
    $core.double? c0a,
    $core.double? c0b,
  }) {
    final _result = create();
    if (c0a != null) {
      _result.c0a = c0a;
    }
    if (c0b != null) {
      _result.c0b = c0b;
    }
    return _result;
  }
  factory QuadraticControlPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QuadraticControlPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QuadraticControlPoint clone() => QuadraticControlPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QuadraticControlPoint copyWith(void Function(QuadraticControlPoint) updates) => super.copyWith((message) => updates(message as QuadraticControlPoint)) as QuadraticControlPoint; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QuadraticControlPoint create() => QuadraticControlPoint._();
  QuadraticControlPoint createEmptyInstance() => create();
  static $pb.PbList<QuadraticControlPoint> createRepeated() => $pb.PbList<QuadraticControlPoint>();
  @$core.pragma('dart2js:noInline')
  static QuadraticControlPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QuadraticControlPoint>(create);
  static QuadraticControlPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get c0a => $_getN(0);
  @$pb.TagNumber(1)
  set c0a($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasC0a() => $_has(0);
  @$pb.TagNumber(1)
  void clearC0a() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get c0b => $_getN(1);
  @$pb.TagNumber(2)
  set c0b($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasC0b() => $_has(1);
  @$pb.TagNumber(2)
  void clearC0b() => clearField(2);
}

class CubicControlPoint extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CubicControlPoint', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0a', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0b', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c1a', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c1b', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CubicControlPoint._() : super();
  factory CubicControlPoint({
    $core.double? c0a,
    $core.double? c0b,
    $core.double? c1a,
    $core.double? c1b,
  }) {
    final _result = create();
    if (c0a != null) {
      _result.c0a = c0a;
    }
    if (c0b != null) {
      _result.c0b = c0b;
    }
    if (c1a != null) {
      _result.c1a = c1a;
    }
    if (c1b != null) {
      _result.c1b = c1b;
    }
    return _result;
  }
  factory CubicControlPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CubicControlPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CubicControlPoint clone() => CubicControlPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CubicControlPoint copyWith(void Function(CubicControlPoint) updates) => super.copyWith((message) => updates(message as CubicControlPoint)) as CubicControlPoint; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CubicControlPoint create() => CubicControlPoint._();
  CubicControlPoint createEmptyInstance() => create();
  static $pb.PbList<CubicControlPoint> createRepeated() => $pb.PbList<CubicControlPoint>();
  @$core.pragma('dart2js:noInline')
  static CubicControlPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CubicControlPoint>(create);
  static CubicControlPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get c0a => $_getN(0);
  @$pb.TagNumber(1)
  set c0a($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasC0a() => $_has(0);
  @$pb.TagNumber(1)
  void clearC0a() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get c0b => $_getN(1);
  @$pb.TagNumber(2)
  set c0b($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasC0b() => $_has(1);
  @$pb.TagNumber(2)
  void clearC0b() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get c1a => $_getN(2);
  @$pb.TagNumber(3)
  set c1a($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasC1a() => $_has(2);
  @$pb.TagNumber(3)
  void clearC1a() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get c1b => $_getN(3);
  @$pb.TagNumber(4)
  set c1b($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasC1b() => $_has(3);
  @$pb.TagNumber(4)
  void clearC1b() => clearField(4);
}

