//
//  Generated code. Do not modify.
//  source: effects.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'effects.pbenum.dart';
import 'sequencer.pb.dart' as $1;

export 'effects.pbenum.dart';

class AddEffectRequest extends $pb.GeneratedMessage {
  factory AddEffectRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  AddEffectRequest._() : super();
  factory AddEffectRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddEffectRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddEffectRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddEffectRequest clone() => AddEffectRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddEffectRequest copyWith(void Function(AddEffectRequest) updates) => super.copyWith((message) => updates(message as AddEffectRequest)) as AddEffectRequest;

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
  factory UpdateEffectStepRequest({
    $core.int? effectId,
    $core.int? channelIndex,
    $core.int? stepIndex,
    EffectStep? step,
  }) {
    final $result = create();
    if (effectId != null) {
      $result.effectId = effectId;
    }
    if (channelIndex != null) {
      $result.channelIndex = channelIndex;
    }
    if (stepIndex != null) {
      $result.stepIndex = stepIndex;
    }
    if (step != null) {
      $result.step = step;
    }
    return $result;
  }
  UpdateEffectStepRequest._() : super();
  factory UpdateEffectStepRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateEffectStepRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateEffectStepRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'channelIndex', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'stepIndex', $pb.PbFieldType.OU3)
    ..aOM<EffectStep>(4, _omitFieldNames ? '' : 'step', subBuilder: EffectStep.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateEffectStepRequest clone() => UpdateEffectStepRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateEffectStepRequest copyWith(void Function(UpdateEffectStepRequest) updates) => super.copyWith((message) => updates(message as UpdateEffectStepRequest)) as UpdateEffectStepRequest;

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
  factory AddEffectChannelRequest({
    $core.int? effectId,
    EffectControl? control,
  }) {
    final $result = create();
    if (effectId != null) {
      $result.effectId = effectId;
    }
    if (control != null) {
      $result.control = control;
    }
    return $result;
  }
  AddEffectChannelRequest._() : super();
  factory AddEffectChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddEffectChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddEffectChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..e<EffectControl>(2, _omitFieldNames ? '' : 'control', $pb.PbFieldType.OE, defaultOrMaker: EffectControl.INTENSITY, valueOf: EffectControl.valueOf, enumValues: EffectControl.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddEffectChannelRequest clone() => AddEffectChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddEffectChannelRequest copyWith(void Function(AddEffectChannelRequest) updates) => super.copyWith((message) => updates(message as AddEffectChannelRequest)) as AddEffectChannelRequest;

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
  EffectControl get control => $_getN(1);
  @$pb.TagNumber(2)
  set control(EffectControl v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasControl() => $_has(1);
  @$pb.TagNumber(2)
  void clearControl() => clearField(2);
}

class DeleteEffectChannelRequest extends $pb.GeneratedMessage {
  factory DeleteEffectChannelRequest({
    $core.int? effectId,
    $core.int? channelIndex,
  }) {
    final $result = create();
    if (effectId != null) {
      $result.effectId = effectId;
    }
    if (channelIndex != null) {
      $result.channelIndex = channelIndex;
    }
    return $result;
  }
  DeleteEffectChannelRequest._() : super();
  factory DeleteEffectChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteEffectChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteEffectChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'channelIndex', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteEffectChannelRequest clone() => DeleteEffectChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteEffectChannelRequest copyWith(void Function(DeleteEffectChannelRequest) updates) => super.copyWith((message) => updates(message as DeleteEffectChannelRequest)) as DeleteEffectChannelRequest;

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
  factory AddEffectStepRequest({
    $core.int? effectId,
    $core.int? channelIndex,
    EffectStep? step,
  }) {
    final $result = create();
    if (effectId != null) {
      $result.effectId = effectId;
    }
    if (channelIndex != null) {
      $result.channelIndex = channelIndex;
    }
    if (step != null) {
      $result.step = step;
    }
    return $result;
  }
  AddEffectStepRequest._() : super();
  factory AddEffectStepRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddEffectStepRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddEffectStepRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'channelIndex', $pb.PbFieldType.OU3)
    ..aOM<EffectStep>(3, _omitFieldNames ? '' : 'step', subBuilder: EffectStep.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddEffectStepRequest clone() => AddEffectStepRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddEffectStepRequest copyWith(void Function(AddEffectStepRequest) updates) => super.copyWith((message) => updates(message as AddEffectStepRequest)) as AddEffectStepRequest;

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
  factory DeleteEffectStepRequest({
    $core.int? effectId,
    $core.int? channelIndex,
    $core.int? stepIndex,
  }) {
    final $result = create();
    if (effectId != null) {
      $result.effectId = effectId;
    }
    if (channelIndex != null) {
      $result.channelIndex = channelIndex;
    }
    if (stepIndex != null) {
      $result.stepIndex = stepIndex;
    }
    return $result;
  }
  DeleteEffectStepRequest._() : super();
  factory DeleteEffectStepRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteEffectStepRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteEffectStepRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'channelIndex', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'stepIndex', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteEffectStepRequest clone() => DeleteEffectStepRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteEffectStepRequest copyWith(void Function(DeleteEffectStepRequest) updates) => super.copyWith((message) => updates(message as DeleteEffectStepRequest)) as DeleteEffectStepRequest;

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
  factory Effects({
    $core.Iterable<Effect>? effects,
  }) {
    final $result = create();
    if (effects != null) {
      $result.effects.addAll(effects);
    }
    return $result;
  }
  Effects._() : super();
  factory Effects.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Effects.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Effects', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..pc<Effect>(1, _omitFieldNames ? '' : 'effects', $pb.PbFieldType.PM, subBuilder: Effect.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Effects clone() => Effects()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Effects copyWith(void Function(Effects) updates) => super.copyWith((message) => updates(message as Effects)) as Effects;

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
  factory Effect({
    $core.int? id,
    $core.String? name,
    $core.Iterable<EffectChannel>? channels,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    return $result;
  }
  Effect._() : super();
  factory Effect.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Effect.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Effect', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pc<EffectChannel>(3, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: EffectChannel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Effect clone() => Effect()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Effect copyWith(void Function(Effect) updates) => super.copyWith((message) => updates(message as Effect)) as Effect;

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
  factory EffectChannel({
    EffectControl? control,
    $core.Iterable<EffectStep>? steps,
  }) {
    final $result = create();
    if (control != null) {
      $result.control = control;
    }
    if (steps != null) {
      $result.steps.addAll(steps);
    }
    return $result;
  }
  EffectChannel._() : super();
  factory EffectChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EffectChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EffectChannel', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..e<EffectControl>(1, _omitFieldNames ? '' : 'control', $pb.PbFieldType.OE, defaultOrMaker: EffectControl.INTENSITY, valueOf: EffectControl.valueOf, enumValues: EffectControl.values)
    ..pc<EffectStep>(2, _omitFieldNames ? '' : 'steps', $pb.PbFieldType.PM, subBuilder: EffectStep.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EffectChannel clone() => EffectChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EffectChannel copyWith(void Function(EffectChannel) updates) => super.copyWith((message) => updates(message as EffectChannel)) as EffectChannel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EffectChannel create() => EffectChannel._();
  EffectChannel createEmptyInstance() => create();
  static $pb.PbList<EffectChannel> createRepeated() => $pb.PbList<EffectChannel>();
  @$core.pragma('dart2js:noInline')
  static EffectChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EffectChannel>(create);
  static EffectChannel? _defaultInstance;

  @$pb.TagNumber(1)
  EffectControl get control => $_getN(0);
  @$pb.TagNumber(1)
  set control(EffectControl v) { setField(1, v); }
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
  factory EffectStep({
    $1.CueValue? value,
    SimpleControlPoint? simple,
    QuadraticControlPoint? quadratic,
    CubicControlPoint? cubic,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (simple != null) {
      $result.simple = simple;
    }
    if (quadratic != null) {
      $result.quadratic = quadratic;
    }
    if (cubic != null) {
      $result.cubic = cubic;
    }
    return $result;
  }
  EffectStep._() : super();
  factory EffectStep.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EffectStep.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, EffectStep_ControlPoint> _EffectStep_ControlPointByTag = {
    2 : EffectStep_ControlPoint.simple,
    3 : EffectStep_ControlPoint.quadratic,
    4 : EffectStep_ControlPoint.cubic,
    0 : EffectStep_ControlPoint.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EffectStep', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4])
    ..aOM<$1.CueValue>(1, _omitFieldNames ? '' : 'value', subBuilder: $1.CueValue.create)
    ..aOM<SimpleControlPoint>(2, _omitFieldNames ? '' : 'simple', subBuilder: SimpleControlPoint.create)
    ..aOM<QuadraticControlPoint>(3, _omitFieldNames ? '' : 'quadratic', subBuilder: QuadraticControlPoint.create)
    ..aOM<CubicControlPoint>(4, _omitFieldNames ? '' : 'cubic', subBuilder: CubicControlPoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EffectStep clone() => EffectStep()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EffectStep copyWith(void Function(EffectStep) updates) => super.copyWith((message) => updates(message as EffectStep)) as EffectStep;

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
  factory SimpleControlPoint() => create();
  SimpleControlPoint._() : super();
  factory SimpleControlPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SimpleControlPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SimpleControlPoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SimpleControlPoint clone() => SimpleControlPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SimpleControlPoint copyWith(void Function(SimpleControlPoint) updates) => super.copyWith((message) => updates(message as SimpleControlPoint)) as SimpleControlPoint;

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
  factory QuadraticControlPoint({
    $core.double? c0a,
    $core.double? c0b,
  }) {
    final $result = create();
    if (c0a != null) {
      $result.c0a = c0a;
    }
    if (c0b != null) {
      $result.c0b = c0b;
    }
    return $result;
  }
  QuadraticControlPoint._() : super();
  factory QuadraticControlPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QuadraticControlPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QuadraticControlPoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'c0a', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'c0b', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QuadraticControlPoint clone() => QuadraticControlPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QuadraticControlPoint copyWith(void Function(QuadraticControlPoint) updates) => super.copyWith((message) => updates(message as QuadraticControlPoint)) as QuadraticControlPoint;

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
  factory CubicControlPoint({
    $core.double? c0a,
    $core.double? c0b,
    $core.double? c1a,
    $core.double? c1b,
  }) {
    final $result = create();
    if (c0a != null) {
      $result.c0a = c0a;
    }
    if (c0b != null) {
      $result.c0b = c0b;
    }
    if (c1a != null) {
      $result.c1a = c1a;
    }
    if (c1b != null) {
      $result.c1b = c1b;
    }
    return $result;
  }
  CubicControlPoint._() : super();
  factory CubicControlPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CubicControlPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CubicControlPoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'c0a', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'c0b', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'c1a', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'c1b', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CubicControlPoint clone() => CubicControlPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CubicControlPoint copyWith(void Function(CubicControlPoint) updates) => super.copyWith((message) => updates(message as CubicControlPoint)) as CubicControlPoint;

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
