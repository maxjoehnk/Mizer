//
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'fixtures.pb.dart' as $0;
import 'sequencer.pbenum.dart';

export 'sequencer.pbenum.dart';

class GetSequenceRequest extends $pb.GeneratedMessage {
  factory GetSequenceRequest({
    $core.int? sequence,
  }) {
    final $result = create();
    if (sequence != null) {
      $result.sequence = sequence;
    }
    return $result;
  }
  GetSequenceRequest._() : super();
  factory GetSequenceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSequenceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSequenceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSequenceRequest clone() => GetSequenceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSequenceRequest copyWith(void Function(GetSequenceRequest) updates) => super.copyWith((message) => updates(message as GetSequenceRequest)) as GetSequenceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSequenceRequest create() => GetSequenceRequest._();
  GetSequenceRequest createEmptyInstance() => create();
  static $pb.PbList<GetSequenceRequest> createRepeated() => $pb.PbList<GetSequenceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSequenceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSequenceRequest>(create);
  static GetSequenceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => clearField(1);
}

class DeleteSequenceRequest extends $pb.GeneratedMessage {
  factory DeleteSequenceRequest({
    $core.int? sequence,
  }) {
    final $result = create();
    if (sequence != null) {
      $result.sequence = sequence;
    }
    return $result;
  }
  DeleteSequenceRequest._() : super();
  factory DeleteSequenceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteSequenceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteSequenceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteSequenceRequest clone() => DeleteSequenceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteSequenceRequest copyWith(void Function(DeleteSequenceRequest) updates) => super.copyWith((message) => updates(message as DeleteSequenceRequest)) as DeleteSequenceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteSequenceRequest create() => DeleteSequenceRequest._();
  DeleteSequenceRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteSequenceRequest> createRepeated() => $pb.PbList<DeleteSequenceRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteSequenceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteSequenceRequest>(create);
  static DeleteSequenceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => clearField(1);
}

class SequenceGoRequest extends $pb.GeneratedMessage {
  factory SequenceGoRequest({
    $core.int? sequence,
  }) {
    final $result = create();
    if (sequence != null) {
      $result.sequence = sequence;
    }
    return $result;
  }
  SequenceGoRequest._() : super();
  factory SequenceGoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequenceGoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SequenceGoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequenceGoRequest clone() => SequenceGoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequenceGoRequest copyWith(void Function(SequenceGoRequest) updates) => super.copyWith((message) => updates(message as SequenceGoRequest)) as SequenceGoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SequenceGoRequest create() => SequenceGoRequest._();
  SequenceGoRequest createEmptyInstance() => create();
  static $pb.PbList<SequenceGoRequest> createRepeated() => $pb.PbList<SequenceGoRequest>();
  @$core.pragma('dart2js:noInline')
  static SequenceGoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequenceGoRequest>(create);
  static SequenceGoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => clearField(1);
}

class SequenceStopRequest extends $pb.GeneratedMessage {
  factory SequenceStopRequest({
    $core.int? sequence,
  }) {
    final $result = create();
    if (sequence != null) {
      $result.sequence = sequence;
    }
    return $result;
  }
  SequenceStopRequest._() : super();
  factory SequenceStopRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequenceStopRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SequenceStopRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequenceStopRequest clone() => SequenceStopRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequenceStopRequest copyWith(void Function(SequenceStopRequest) updates) => super.copyWith((message) => updates(message as SequenceStopRequest)) as SequenceStopRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SequenceStopRequest create() => SequenceStopRequest._();
  SequenceStopRequest createEmptyInstance() => create();
  static $pb.PbList<SequenceStopRequest> createRepeated() => $pb.PbList<SequenceStopRequest>();
  @$core.pragma('dart2js:noInline')
  static SequenceStopRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequenceStopRequest>(create);
  static SequenceStopRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => clearField(1);
}

class CueTriggerRequest extends $pb.GeneratedMessage {
  factory CueTriggerRequest({
    $core.int? sequence,
    $core.int? cue,
    CueTrigger_Type? trigger,
  }) {
    final $result = create();
    if (sequence != null) {
      $result.sequence = sequence;
    }
    if (cue != null) {
      $result.cue = cue;
    }
    if (trigger != null) {
      $result.trigger = trigger;
    }
    return $result;
  }
  CueTriggerRequest._() : super();
  factory CueTriggerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueTriggerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueTriggerRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'cue', $pb.PbFieldType.OU3)
    ..e<CueTrigger_Type>(3, _omitFieldNames ? '' : 'trigger', $pb.PbFieldType.OE, defaultOrMaker: CueTrigger_Type.GO, valueOf: CueTrigger_Type.valueOf, enumValues: CueTrigger_Type.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueTriggerRequest clone() => CueTriggerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueTriggerRequest copyWith(void Function(CueTriggerRequest) updates) => super.copyWith((message) => updates(message as CueTriggerRequest)) as CueTriggerRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueTriggerRequest create() => CueTriggerRequest._();
  CueTriggerRequest createEmptyInstance() => create();
  static $pb.PbList<CueTriggerRequest> createRepeated() => $pb.PbList<CueTriggerRequest>();
  @$core.pragma('dart2js:noInline')
  static CueTriggerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueTriggerRequest>(create);
  static CueTriggerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get cue => $_getIZ(1);
  @$pb.TagNumber(2)
  set cue($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCue() => $_has(1);
  @$pb.TagNumber(2)
  void clearCue() => clearField(2);

  @$pb.TagNumber(3)
  CueTrigger_Type get trigger => $_getN(2);
  @$pb.TagNumber(3)
  set trigger(CueTrigger_Type v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTrigger() => $_has(2);
  @$pb.TagNumber(3)
  void clearTrigger() => clearField(3);
}

class CueTriggerTimeRequest extends $pb.GeneratedMessage {
  factory CueTriggerTimeRequest({
    $core.int? sequence,
    $core.int? cue,
    CueTime? time,
  }) {
    final $result = create();
    if (sequence != null) {
      $result.sequence = sequence;
    }
    if (cue != null) {
      $result.cue = cue;
    }
    if (time != null) {
      $result.time = time;
    }
    return $result;
  }
  CueTriggerTimeRequest._() : super();
  factory CueTriggerTimeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueTriggerTimeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueTriggerTimeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'cue', $pb.PbFieldType.OU3)
    ..aOM<CueTime>(3, _omitFieldNames ? '' : 'time', subBuilder: CueTime.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueTriggerTimeRequest clone() => CueTriggerTimeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueTriggerTimeRequest copyWith(void Function(CueTriggerTimeRequest) updates) => super.copyWith((message) => updates(message as CueTriggerTimeRequest)) as CueTriggerTimeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueTriggerTimeRequest create() => CueTriggerTimeRequest._();
  CueTriggerTimeRequest createEmptyInstance() => create();
  static $pb.PbList<CueTriggerTimeRequest> createRepeated() => $pb.PbList<CueTriggerTimeRequest>();
  @$core.pragma('dart2js:noInline')
  static CueTriggerTimeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueTriggerTimeRequest>(create);
  static CueTriggerTimeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get cue => $_getIZ(1);
  @$pb.TagNumber(2)
  set cue($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCue() => $_has(1);
  @$pb.TagNumber(2)
  void clearCue() => clearField(2);

  @$pb.TagNumber(3)
  CueTime get time => $_getN(2);
  @$pb.TagNumber(3)
  set time(CueTime v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearTime() => clearField(3);
  @$pb.TagNumber(3)
  CueTime ensureTime() => $_ensure(2);
}

class CueEffectOffsetTimeRequest extends $pb.GeneratedMessage {
  factory CueEffectOffsetTimeRequest({
    $core.int? sequence,
    $core.int? cue,
    $core.int? effect,
    $core.double? time,
  }) {
    final $result = create();
    if (sequence != null) {
      $result.sequence = sequence;
    }
    if (cue != null) {
      $result.cue = cue;
    }
    if (effect != null) {
      $result.effect = effect;
    }
    if (time != null) {
      $result.time = time;
    }
    return $result;
  }
  CueEffectOffsetTimeRequest._() : super();
  factory CueEffectOffsetTimeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueEffectOffsetTimeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueEffectOffsetTimeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'cue', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'effect', $pb.PbFieldType.OU3)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'time', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueEffectOffsetTimeRequest clone() => CueEffectOffsetTimeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueEffectOffsetTimeRequest copyWith(void Function(CueEffectOffsetTimeRequest) updates) => super.copyWith((message) => updates(message as CueEffectOffsetTimeRequest)) as CueEffectOffsetTimeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueEffectOffsetTimeRequest create() => CueEffectOffsetTimeRequest._();
  CueEffectOffsetTimeRequest createEmptyInstance() => create();
  static $pb.PbList<CueEffectOffsetTimeRequest> createRepeated() => $pb.PbList<CueEffectOffsetTimeRequest>();
  @$core.pragma('dart2js:noInline')
  static CueEffectOffsetTimeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueEffectOffsetTimeRequest>(create);
  static CueEffectOffsetTimeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get cue => $_getIZ(1);
  @$pb.TagNumber(2)
  set cue($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCue() => $_has(1);
  @$pb.TagNumber(2)
  void clearCue() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get effect => $_getIZ(2);
  @$pb.TagNumber(3)
  set effect($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEffect() => $_has(2);
  @$pb.TagNumber(3)
  void clearEffect() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get time => $_getN(3);
  @$pb.TagNumber(4)
  set time($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearTime() => clearField(4);
}

class CueNameRequest extends $pb.GeneratedMessage {
  factory CueNameRequest({
    $core.int? sequence,
    $core.int? cue,
    $core.String? name,
  }) {
    final $result = create();
    if (sequence != null) {
      $result.sequence = sequence;
    }
    if (cue != null) {
      $result.cue = cue;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  CueNameRequest._() : super();
  factory CueNameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueNameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueNameRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'cue', $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueNameRequest clone() => CueNameRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueNameRequest copyWith(void Function(CueNameRequest) updates) => super.copyWith((message) => updates(message as CueNameRequest)) as CueNameRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueNameRequest create() => CueNameRequest._();
  CueNameRequest createEmptyInstance() => create();
  static $pb.PbList<CueNameRequest> createRepeated() => $pb.PbList<CueNameRequest>();
  @$core.pragma('dart2js:noInline')
  static CueNameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueNameRequest>(create);
  static CueNameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get cue => $_getIZ(1);
  @$pb.TagNumber(2)
  set cue($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCue() => $_has(1);
  @$pb.TagNumber(2)
  void clearCue() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);
}

class CueValueRequest extends $pb.GeneratedMessage {
  factory CueValueRequest({
    $core.int? sequenceId,
    $core.int? cueId,
    $core.int? controlIndex,
    CueValue? value,
  }) {
    final $result = create();
    if (sequenceId != null) {
      $result.sequenceId = sequenceId;
    }
    if (cueId != null) {
      $result.cueId = cueId;
    }
    if (controlIndex != null) {
      $result.controlIndex = controlIndex;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  CueValueRequest._() : super();
  factory CueValueRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueValueRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueValueRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequenceId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'cueId', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'controlIndex', $pb.PbFieldType.OU3)
    ..aOM<CueValue>(4, _omitFieldNames ? '' : 'value', subBuilder: CueValue.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueValueRequest clone() => CueValueRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueValueRequest copyWith(void Function(CueValueRequest) updates) => super.copyWith((message) => updates(message as CueValueRequest)) as CueValueRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueValueRequest create() => CueValueRequest._();
  CueValueRequest createEmptyInstance() => create();
  static $pb.PbList<CueValueRequest> createRepeated() => $pb.PbList<CueValueRequest>();
  @$core.pragma('dart2js:noInline')
  static CueValueRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueValueRequest>(create);
  static CueValueRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequenceId => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequenceId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequenceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequenceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get cueId => $_getIZ(1);
  @$pb.TagNumber(2)
  set cueId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCueId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCueId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get controlIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set controlIndex($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasControlIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearControlIndex() => clearField(3);

  @$pb.TagNumber(4)
  CueValue get value => $_getN(3);
  @$pb.TagNumber(4)
  set value(CueValue v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearValue() => clearField(4);
  @$pb.TagNumber(4)
  CueValue ensureValue() => $_ensure(3);
}

class CueTimingRequest extends $pb.GeneratedMessage {
  factory CueTimingRequest({
    $core.int? sequenceId,
    $core.int? cueId,
    CueTimer? time,
  }) {
    final $result = create();
    if (sequenceId != null) {
      $result.sequenceId = sequenceId;
    }
    if (cueId != null) {
      $result.cueId = cueId;
    }
    if (time != null) {
      $result.time = time;
    }
    return $result;
  }
  CueTimingRequest._() : super();
  factory CueTimingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueTimingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueTimingRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequenceId', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'cueId', $pb.PbFieldType.OU3)
    ..aOM<CueTimer>(3, _omitFieldNames ? '' : 'time', subBuilder: CueTimer.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueTimingRequest clone() => CueTimingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueTimingRequest copyWith(void Function(CueTimingRequest) updates) => super.copyWith((message) => updates(message as CueTimingRequest)) as CueTimingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueTimingRequest create() => CueTimingRequest._();
  CueTimingRequest createEmptyInstance() => create();
  static $pb.PbList<CueTimingRequest> createRepeated() => $pb.PbList<CueTimingRequest>();
  @$core.pragma('dart2js:noInline')
  static CueTimingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueTimingRequest>(create);
  static CueTimingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequenceId => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequenceId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequenceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequenceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get cueId => $_getIZ(1);
  @$pb.TagNumber(2)
  set cueId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCueId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCueId() => clearField(2);

  @$pb.TagNumber(3)
  CueTimer get time => $_getN(2);
  @$pb.TagNumber(3)
  set time(CueTimer v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearTime() => clearField(3);
  @$pb.TagNumber(3)
  CueTimer ensureTime() => $_ensure(2);
}

class SequenceWrapAroundRequest extends $pb.GeneratedMessage {
  factory SequenceWrapAroundRequest({
    $core.int? sequence,
    $core.bool? wrapAround,
  }) {
    final $result = create();
    if (sequence != null) {
      $result.sequence = sequence;
    }
    if (wrapAround != null) {
      $result.wrapAround = wrapAround;
    }
    return $result;
  }
  SequenceWrapAroundRequest._() : super();
  factory SequenceWrapAroundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequenceWrapAroundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SequenceWrapAroundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..aOB(2, _omitFieldNames ? '' : 'wrapAround')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequenceWrapAroundRequest clone() => SequenceWrapAroundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequenceWrapAroundRequest copyWith(void Function(SequenceWrapAroundRequest) updates) => super.copyWith((message) => updates(message as SequenceWrapAroundRequest)) as SequenceWrapAroundRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SequenceWrapAroundRequest create() => SequenceWrapAroundRequest._();
  SequenceWrapAroundRequest createEmptyInstance() => create();
  static $pb.PbList<SequenceWrapAroundRequest> createRepeated() => $pb.PbList<SequenceWrapAroundRequest>();
  @$core.pragma('dart2js:noInline')
  static SequenceWrapAroundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequenceWrapAroundRequest>(create);
  static SequenceWrapAroundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get wrapAround => $_getBF(1);
  @$pb.TagNumber(2)
  set wrapAround($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWrapAround() => $_has(1);
  @$pb.TagNumber(2)
  void clearWrapAround() => clearField(2);
}

class SequenceStopOnLastCueRequest extends $pb.GeneratedMessage {
  factory SequenceStopOnLastCueRequest({
    $core.int? sequence,
    $core.bool? stopOnLastCue,
  }) {
    final $result = create();
    if (sequence != null) {
      $result.sequence = sequence;
    }
    if (stopOnLastCue != null) {
      $result.stopOnLastCue = stopOnLastCue;
    }
    return $result;
  }
  SequenceStopOnLastCueRequest._() : super();
  factory SequenceStopOnLastCueRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequenceStopOnLastCueRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SequenceStopOnLastCueRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..aOB(2, _omitFieldNames ? '' : 'stopOnLastCue')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequenceStopOnLastCueRequest clone() => SequenceStopOnLastCueRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequenceStopOnLastCueRequest copyWith(void Function(SequenceStopOnLastCueRequest) updates) => super.copyWith((message) => updates(message as SequenceStopOnLastCueRequest)) as SequenceStopOnLastCueRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SequenceStopOnLastCueRequest create() => SequenceStopOnLastCueRequest._();
  SequenceStopOnLastCueRequest createEmptyInstance() => create();
  static $pb.PbList<SequenceStopOnLastCueRequest> createRepeated() => $pb.PbList<SequenceStopOnLastCueRequest>();
  @$core.pragma('dart2js:noInline')
  static SequenceStopOnLastCueRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequenceStopOnLastCueRequest>(create);
  static SequenceStopOnLastCueRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get stopOnLastCue => $_getBF(1);
  @$pb.TagNumber(2)
  set stopOnLastCue($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStopOnLastCue() => $_has(1);
  @$pb.TagNumber(2)
  void clearStopOnLastCue() => clearField(2);
}

class SequencePriorityRequest extends $pb.GeneratedMessage {
  factory SequencePriorityRequest({
    $core.int? sequence,
    FixturePriority? priority,
  }) {
    final $result = create();
    if (sequence != null) {
      $result.sequence = sequence;
    }
    if (priority != null) {
      $result.priority = priority;
    }
    return $result;
  }
  SequencePriorityRequest._() : super();
  factory SequencePriorityRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequencePriorityRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SequencePriorityRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..e<FixturePriority>(2, _omitFieldNames ? '' : 'priority', $pb.PbFieldType.OE, defaultOrMaker: FixturePriority.PRIORITY_HTP, valueOf: FixturePriority.valueOf, enumValues: FixturePriority.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequencePriorityRequest clone() => SequencePriorityRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequencePriorityRequest copyWith(void Function(SequencePriorityRequest) updates) => super.copyWith((message) => updates(message as SequencePriorityRequest)) as SequencePriorityRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SequencePriorityRequest create() => SequencePriorityRequest._();
  SequencePriorityRequest createEmptyInstance() => create();
  static $pb.PbList<SequencePriorityRequest> createRepeated() => $pb.PbList<SequencePriorityRequest>();
  @$core.pragma('dart2js:noInline')
  static SequencePriorityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequencePriorityRequest>(create);
  static SequencePriorityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => clearField(1);

  @$pb.TagNumber(2)
  FixturePriority get priority => $_getN(1);
  @$pb.TagNumber(2)
  set priority(FixturePriority v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPriority() => $_has(1);
  @$pb.TagNumber(2)
  void clearPriority() => clearField(2);
}

class SequenceNameRequest extends $pb.GeneratedMessage {
  factory SequenceNameRequest({
    $core.int? sequence,
    $core.String? name,
  }) {
    final $result = create();
    if (sequence != null) {
      $result.sequence = sequence;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  SequenceNameRequest._() : super();
  factory SequenceNameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequenceNameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SequenceNameRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequenceNameRequest clone() => SequenceNameRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequenceNameRequest copyWith(void Function(SequenceNameRequest) updates) => super.copyWith((message) => updates(message as SequenceNameRequest)) as SequenceNameRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SequenceNameRequest create() => SequenceNameRequest._();
  SequenceNameRequest createEmptyInstance() => create();
  static $pb.PbList<SequenceNameRequest> createRepeated() => $pb.PbList<SequenceNameRequest>();
  @$core.pragma('dart2js:noInline')
  static SequenceNameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequenceNameRequest>(create);
  static SequenceNameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequence($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class Sequences extends $pb.GeneratedMessage {
  factory Sequences({
    $core.Iterable<Sequence>? sequences,
  }) {
    final $result = create();
    if (sequences != null) {
      $result.sequences.addAll(sequences);
    }
    return $result;
  }
  Sequences._() : super();
  factory Sequences.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Sequences.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Sequences', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..pc<Sequence>(1, _omitFieldNames ? '' : 'sequences', $pb.PbFieldType.PM, subBuilder: Sequence.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Sequences clone() => Sequences()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Sequences copyWith(void Function(Sequences) updates) => super.copyWith((message) => updates(message as Sequences)) as Sequences;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Sequences create() => Sequences._();
  Sequences createEmptyInstance() => create();
  static $pb.PbList<Sequences> createRepeated() => $pb.PbList<Sequences>();
  @$core.pragma('dart2js:noInline')
  static Sequences getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Sequences>(create);
  static Sequences? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Sequence> get sequences => $_getList(0);
}

class Sequence extends $pb.GeneratedMessage {
  factory Sequence({
    $core.int? id,
    $core.String? name,
    $core.Iterable<Cue>? cues,
    $core.Iterable<$0.FixtureId>? fixtures,
    $core.bool? wrapAround,
    $core.bool? stopOnLastCue,
    FixturePriority? priority,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (cues != null) {
      $result.cues.addAll(cues);
    }
    if (fixtures != null) {
      $result.fixtures.addAll(fixtures);
    }
    if (wrapAround != null) {
      $result.wrapAround = wrapAround;
    }
    if (stopOnLastCue != null) {
      $result.stopOnLastCue = stopOnLastCue;
    }
    if (priority != null) {
      $result.priority = priority;
    }
    return $result;
  }
  Sequence._() : super();
  factory Sequence.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Sequence.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Sequence', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pc<Cue>(3, _omitFieldNames ? '' : 'cues', $pb.PbFieldType.PM, subBuilder: Cue.create)
    ..pc<$0.FixtureId>(4, _omitFieldNames ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..aOB(5, _omitFieldNames ? '' : 'wrapAround')
    ..aOB(6, _omitFieldNames ? '' : 'stopOnLastCue')
    ..e<FixturePriority>(7, _omitFieldNames ? '' : 'priority', $pb.PbFieldType.OE, defaultOrMaker: FixturePriority.PRIORITY_HTP, valueOf: FixturePriority.valueOf, enumValues: FixturePriority.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Sequence clone() => Sequence()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Sequence copyWith(void Function(Sequence) updates) => super.copyWith((message) => updates(message as Sequence)) as Sequence;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Sequence create() => Sequence._();
  Sequence createEmptyInstance() => create();
  static $pb.PbList<Sequence> createRepeated() => $pb.PbList<Sequence>();
  @$core.pragma('dart2js:noInline')
  static Sequence getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Sequence>(create);
  static Sequence? _defaultInstance;

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
  $core.List<Cue> get cues => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$0.FixtureId> get fixtures => $_getList(3);

  @$pb.TagNumber(5)
  $core.bool get wrapAround => $_getBF(4);
  @$pb.TagNumber(5)
  set wrapAround($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasWrapAround() => $_has(4);
  @$pb.TagNumber(5)
  void clearWrapAround() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get stopOnLastCue => $_getBF(5);
  @$pb.TagNumber(6)
  set stopOnLastCue($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStopOnLastCue() => $_has(5);
  @$pb.TagNumber(6)
  void clearStopOnLastCue() => clearField(6);

  @$pb.TagNumber(7)
  FixturePriority get priority => $_getN(6);
  @$pb.TagNumber(7)
  set priority(FixturePriority v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasPriority() => $_has(6);
  @$pb.TagNumber(7)
  void clearPriority() => clearField(7);
}

class Cue extends $pb.GeneratedMessage {
  factory Cue({
    $core.int? id,
    $core.String? name,
    CueTrigger? trigger,
    $core.Iterable<CueControl>? controls,
    CueTimings? cueTimings,
    CueTimings? dimmerTimings,
    CueTimings? positionTimings,
    CueTimings? colorTimings,
    $core.Iterable<CueEffect>? effects,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (trigger != null) {
      $result.trigger = trigger;
    }
    if (controls != null) {
      $result.controls.addAll(controls);
    }
    if (cueTimings != null) {
      $result.cueTimings = cueTimings;
    }
    if (dimmerTimings != null) {
      $result.dimmerTimings = dimmerTimings;
    }
    if (positionTimings != null) {
      $result.positionTimings = positionTimings;
    }
    if (colorTimings != null) {
      $result.colorTimings = colorTimings;
    }
    if (effects != null) {
      $result.effects.addAll(effects);
    }
    return $result;
  }
  Cue._() : super();
  factory Cue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Cue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Cue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<CueTrigger>(3, _omitFieldNames ? '' : 'trigger', subBuilder: CueTrigger.create)
    ..pc<CueControl>(4, _omitFieldNames ? '' : 'controls', $pb.PbFieldType.PM, subBuilder: CueControl.create)
    ..aOM<CueTimings>(5, _omitFieldNames ? '' : 'cueTimings', subBuilder: CueTimings.create)
    ..aOM<CueTimings>(6, _omitFieldNames ? '' : 'dimmerTimings', subBuilder: CueTimings.create)
    ..aOM<CueTimings>(7, _omitFieldNames ? '' : 'positionTimings', subBuilder: CueTimings.create)
    ..aOM<CueTimings>(8, _omitFieldNames ? '' : 'colorTimings', subBuilder: CueTimings.create)
    ..pc<CueEffect>(9, _omitFieldNames ? '' : 'effects', $pb.PbFieldType.PM, subBuilder: CueEffect.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Cue clone() => Cue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Cue copyWith(void Function(Cue) updates) => super.copyWith((message) => updates(message as Cue)) as Cue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Cue create() => Cue._();
  Cue createEmptyInstance() => create();
  static $pb.PbList<Cue> createRepeated() => $pb.PbList<Cue>();
  @$core.pragma('dart2js:noInline')
  static Cue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Cue>(create);
  static Cue? _defaultInstance;

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
  CueTrigger get trigger => $_getN(2);
  @$pb.TagNumber(3)
  set trigger(CueTrigger v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTrigger() => $_has(2);
  @$pb.TagNumber(3)
  void clearTrigger() => clearField(3);
  @$pb.TagNumber(3)
  CueTrigger ensureTrigger() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<CueControl> get controls => $_getList(3);

  @$pb.TagNumber(5)
  CueTimings get cueTimings => $_getN(4);
  @$pb.TagNumber(5)
  set cueTimings(CueTimings v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCueTimings() => $_has(4);
  @$pb.TagNumber(5)
  void clearCueTimings() => clearField(5);
  @$pb.TagNumber(5)
  CueTimings ensureCueTimings() => $_ensure(4);

  @$pb.TagNumber(6)
  CueTimings get dimmerTimings => $_getN(5);
  @$pb.TagNumber(6)
  set dimmerTimings(CueTimings v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasDimmerTimings() => $_has(5);
  @$pb.TagNumber(6)
  void clearDimmerTimings() => clearField(6);
  @$pb.TagNumber(6)
  CueTimings ensureDimmerTimings() => $_ensure(5);

  @$pb.TagNumber(7)
  CueTimings get positionTimings => $_getN(6);
  @$pb.TagNumber(7)
  set positionTimings(CueTimings v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasPositionTimings() => $_has(6);
  @$pb.TagNumber(7)
  void clearPositionTimings() => clearField(7);
  @$pb.TagNumber(7)
  CueTimings ensurePositionTimings() => $_ensure(6);

  @$pb.TagNumber(8)
  CueTimings get colorTimings => $_getN(7);
  @$pb.TagNumber(8)
  set colorTimings(CueTimings v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasColorTimings() => $_has(7);
  @$pb.TagNumber(8)
  void clearColorTimings() => clearField(8);
  @$pb.TagNumber(8)
  CueTimings ensureColorTimings() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.List<CueEffect> get effects => $_getList(8);
}

class CueEffect extends $pb.GeneratedMessage {
  factory CueEffect({
    $core.int? effectId,
    $core.Iterable<$0.FixtureId>? fixtures,
    $core.double? effectOffsets,
    $core.double? effectRate,
  }) {
    final $result = create();
    if (effectId != null) {
      $result.effectId = effectId;
    }
    if (fixtures != null) {
      $result.fixtures.addAll(fixtures);
    }
    if (effectOffsets != null) {
      $result.effectOffsets = effectOffsets;
    }
    if (effectRate != null) {
      $result.effectRate = effectRate;
    }
    return $result;
  }
  CueEffect._() : super();
  factory CueEffect.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueEffect.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueEffect', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..pc<$0.FixtureId>(2, _omitFieldNames ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'effectOffsets', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'effectRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueEffect clone() => CueEffect()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueEffect copyWith(void Function(CueEffect) updates) => super.copyWith((message) => updates(message as CueEffect)) as CueEffect;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueEffect create() => CueEffect._();
  CueEffect createEmptyInstance() => create();
  static $pb.PbList<CueEffect> createRepeated() => $pb.PbList<CueEffect>();
  @$core.pragma('dart2js:noInline')
  static CueEffect getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueEffect>(create);
  static CueEffect? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get effectId => $_getIZ(0);
  @$pb.TagNumber(1)
  set effectId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEffectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEffectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$0.FixtureId> get fixtures => $_getList(1);

  @$pb.TagNumber(3)
  $core.double get effectOffsets => $_getN(2);
  @$pb.TagNumber(3)
  set effectOffsets($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEffectOffsets() => $_has(2);
  @$pb.TagNumber(3)
  void clearEffectOffsets() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get effectRate => $_getN(3);
  @$pb.TagNumber(4)
  set effectRate($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEffectRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEffectRate() => clearField(4);
}

class CueTimings extends $pb.GeneratedMessage {
  factory CueTimings({
    CueTimer? fade,
    CueTimer? delay,
  }) {
    final $result = create();
    if (fade != null) {
      $result.fade = fade;
    }
    if (delay != null) {
      $result.delay = delay;
    }
    return $result;
  }
  CueTimings._() : super();
  factory CueTimings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueTimings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueTimings', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..aOM<CueTimer>(8, _omitFieldNames ? '' : 'fade', subBuilder: CueTimer.create)
    ..aOM<CueTimer>(9, _omitFieldNames ? '' : 'delay', subBuilder: CueTimer.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueTimings clone() => CueTimings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueTimings copyWith(void Function(CueTimings) updates) => super.copyWith((message) => updates(message as CueTimings)) as CueTimings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueTimings create() => CueTimings._();
  CueTimings createEmptyInstance() => create();
  static $pb.PbList<CueTimings> createRepeated() => $pb.PbList<CueTimings>();
  @$core.pragma('dart2js:noInline')
  static CueTimings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueTimings>(create);
  static CueTimings? _defaultInstance;

  @$pb.TagNumber(8)
  CueTimer get fade => $_getN(0);
  @$pb.TagNumber(8)
  set fade(CueTimer v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasFade() => $_has(0);
  @$pb.TagNumber(8)
  void clearFade() => clearField(8);
  @$pb.TagNumber(8)
  CueTimer ensureFade() => $_ensure(0);

  @$pb.TagNumber(9)
  CueTimer get delay => $_getN(1);
  @$pb.TagNumber(9)
  set delay(CueTimer v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasDelay() => $_has(1);
  @$pb.TagNumber(9)
  void clearDelay() => clearField(9);
  @$pb.TagNumber(9)
  CueTimer ensureDelay() => $_ensure(1);
}

class CueTrigger extends $pb.GeneratedMessage {
  factory CueTrigger({
    CueTrigger_Type? type,
    CueTime? time,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (time != null) {
      $result.time = time;
    }
    return $result;
  }
  CueTrigger._() : super();
  factory CueTrigger.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueTrigger.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueTrigger', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..e<CueTrigger_Type>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: CueTrigger_Type.GO, valueOf: CueTrigger_Type.valueOf, enumValues: CueTrigger_Type.values)
    ..aOM<CueTime>(2, _omitFieldNames ? '' : 'time', subBuilder: CueTime.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueTrigger clone() => CueTrigger()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueTrigger copyWith(void Function(CueTrigger) updates) => super.copyWith((message) => updates(message as CueTrigger)) as CueTrigger;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueTrigger create() => CueTrigger._();
  CueTrigger createEmptyInstance() => create();
  static $pb.PbList<CueTrigger> createRepeated() => $pb.PbList<CueTrigger>();
  @$core.pragma('dart2js:noInline')
  static CueTrigger getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueTrigger>(create);
  static CueTrigger? _defaultInstance;

  @$pb.TagNumber(1)
  CueTrigger_Type get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(CueTrigger_Type v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  CueTime get time => $_getN(1);
  @$pb.TagNumber(2)
  set time(CueTime v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearTime() => clearField(2);
  @$pb.TagNumber(2)
  CueTime ensureTime() => $_ensure(1);
}

class CueControl extends $pb.GeneratedMessage {
  factory CueControl({
    $core.String? fixtureChannel,
    CueValue? value,
    $core.Iterable<$0.FixtureId>? fixtures,
  }) {
    final $result = create();
    if (fixtureChannel != null) {
      $result.fixtureChannel = fixtureChannel;
    }
    if (value != null) {
      $result.value = value;
    }
    if (fixtures != null) {
      $result.fixtures.addAll(fixtures);
    }
    return $result;
  }
  CueControl._() : super();
  factory CueControl.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueControl.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueControl', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fixtureChannel', protoName: 'fixtureChannel')
    ..aOM<CueValue>(2, _omitFieldNames ? '' : 'value', subBuilder: CueValue.create)
    ..pc<$0.FixtureId>(3, _omitFieldNames ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueControl clone() => CueControl()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueControl copyWith(void Function(CueControl) updates) => super.copyWith((message) => updates(message as CueControl)) as CueControl;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueControl create() => CueControl._();
  CueControl createEmptyInstance() => create();
  static $pb.PbList<CueControl> createRepeated() => $pb.PbList<CueControl>();
  @$core.pragma('dart2js:noInline')
  static CueControl getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueControl>(create);
  static CueControl? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fixtureChannel => $_getSZ(0);
  @$pb.TagNumber(1)
  set fixtureChannel($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFixtureChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearFixtureChannel() => clearField(1);

  @$pb.TagNumber(2)
  CueValue get value => $_getN(1);
  @$pb.TagNumber(2)
  set value(CueValue v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
  @$pb.TagNumber(2)
  CueValue ensureValue() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<$0.FixtureId> get fixtures => $_getList(2);
}

enum CueValue_Value {
  direct, 
  range, 
  notSet
}

class CueValue extends $pb.GeneratedMessage {
  factory CueValue({
    $core.double? direct,
    CueValueRange? range,
  }) {
    final $result = create();
    if (direct != null) {
      $result.direct = direct;
    }
    if (range != null) {
      $result.range = range;
    }
    return $result;
  }
  CueValue._() : super();
  factory CueValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, CueValue_Value> _CueValue_ValueByTag = {
    3 : CueValue_Value.direct,
    4 : CueValue_Value.range,
    0 : CueValue_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..a<$core.double>(3, _omitFieldNames ? '' : 'direct', $pb.PbFieldType.OD)
    ..aOM<CueValueRange>(4, _omitFieldNames ? '' : 'range', subBuilder: CueValueRange.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueValue clone() => CueValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueValue copyWith(void Function(CueValue) updates) => super.copyWith((message) => updates(message as CueValue)) as CueValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueValue create() => CueValue._();
  CueValue createEmptyInstance() => create();
  static $pb.PbList<CueValue> createRepeated() => $pb.PbList<CueValue>();
  @$core.pragma('dart2js:noInline')
  static CueValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueValue>(create);
  static CueValue? _defaultInstance;

  CueValue_Value whichValue() => _CueValue_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(3)
  $core.double get direct => $_getN(0);
  @$pb.TagNumber(3)
  set direct($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(3)
  $core.bool hasDirect() => $_has(0);
  @$pb.TagNumber(3)
  void clearDirect() => clearField(3);

  @$pb.TagNumber(4)
  CueValueRange get range => $_getN(1);
  @$pb.TagNumber(4)
  set range(CueValueRange v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRange() => $_has(1);
  @$pb.TagNumber(4)
  void clearRange() => clearField(4);
  @$pb.TagNumber(4)
  CueValueRange ensureRange() => $_ensure(1);
}

enum CueTimer_Timer {
  direct, 
  range, 
  notSet
}

class CueTimer extends $pb.GeneratedMessage {
  factory CueTimer({
    $core.bool? hasTimer,
    CueTime? direct,
    CueTimerRange? range,
  }) {
    final $result = create();
    if (hasTimer != null) {
      $result.hasTimer = hasTimer;
    }
    if (direct != null) {
      $result.direct = direct;
    }
    if (range != null) {
      $result.range = range;
    }
    return $result;
  }
  CueTimer._() : super();
  factory CueTimer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueTimer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, CueTimer_Timer> _CueTimer_TimerByTag = {
    2 : CueTimer_Timer.direct,
    3 : CueTimer_Timer.range,
    0 : CueTimer_Timer.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueTimer', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOB(1, _omitFieldNames ? '' : 'hasTimer')
    ..aOM<CueTime>(2, _omitFieldNames ? '' : 'direct', subBuilder: CueTime.create)
    ..aOM<CueTimerRange>(3, _omitFieldNames ? '' : 'range', subBuilder: CueTimerRange.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueTimer clone() => CueTimer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueTimer copyWith(void Function(CueTimer) updates) => super.copyWith((message) => updates(message as CueTimer)) as CueTimer;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueTimer create() => CueTimer._();
  CueTimer createEmptyInstance() => create();
  static $pb.PbList<CueTimer> createRepeated() => $pb.PbList<CueTimer>();
  @$core.pragma('dart2js:noInline')
  static CueTimer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueTimer>(create);
  static CueTimer? _defaultInstance;

  CueTimer_Timer whichTimer() => _CueTimer_TimerByTag[$_whichOneof(0)]!;
  void clearTimer() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.bool get hasTimer => $_getBF(0);
  @$pb.TagNumber(1)
  set hasTimer($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHasTimer() => $_has(0);
  @$pb.TagNumber(1)
  void clearHasTimer() => clearField(1);

  @$pb.TagNumber(2)
  CueTime get direct => $_getN(1);
  @$pb.TagNumber(2)
  set direct(CueTime v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDirect() => $_has(1);
  @$pb.TagNumber(2)
  void clearDirect() => clearField(2);
  @$pb.TagNumber(2)
  CueTime ensureDirect() => $_ensure(1);

  @$pb.TagNumber(3)
  CueTimerRange get range => $_getN(2);
  @$pb.TagNumber(3)
  set range(CueTimerRange v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRange() => $_has(2);
  @$pb.TagNumber(3)
  void clearRange() => clearField(3);
  @$pb.TagNumber(3)
  CueTimerRange ensureRange() => $_ensure(2);
}

class CueValueRange extends $pb.GeneratedMessage {
  factory CueValueRange({
    $core.double? from,
    $core.double? to,
  }) {
    final $result = create();
    if (from != null) {
      $result.from = from;
    }
    if (to != null) {
      $result.to = to;
    }
    return $result;
  }
  CueValueRange._() : super();
  factory CueValueRange.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueValueRange.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueValueRange', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'from', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'to', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueValueRange clone() => CueValueRange()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueValueRange copyWith(void Function(CueValueRange) updates) => super.copyWith((message) => updates(message as CueValueRange)) as CueValueRange;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueValueRange create() => CueValueRange._();
  CueValueRange createEmptyInstance() => create();
  static $pb.PbList<CueValueRange> createRepeated() => $pb.PbList<CueValueRange>();
  @$core.pragma('dart2js:noInline')
  static CueValueRange getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueValueRange>(create);
  static CueValueRange? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get from => $_getN(0);
  @$pb.TagNumber(1)
  set from($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFrom() => $_has(0);
  @$pb.TagNumber(1)
  void clearFrom() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get to => $_getN(1);
  @$pb.TagNumber(2)
  set to($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTo() => $_has(1);
  @$pb.TagNumber(2)
  void clearTo() => clearField(2);
}

enum CueTime_Time {
  seconds, 
  beats, 
  notSet
}

class CueTime extends $pb.GeneratedMessage {
  factory CueTime({
    $core.double? seconds,
    $core.double? beats,
  }) {
    final $result = create();
    if (seconds != null) {
      $result.seconds = seconds;
    }
    if (beats != null) {
      $result.beats = beats;
    }
    return $result;
  }
  CueTime._() : super();
  factory CueTime.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueTime.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, CueTime_Time> _CueTime_TimeByTag = {
    1 : CueTime_Time.seconds,
    2 : CueTime_Time.beats,
    0 : CueTime_Time.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueTime', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..a<$core.double>(1, _omitFieldNames ? '' : 'seconds', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'beats', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueTime clone() => CueTime()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueTime copyWith(void Function(CueTime) updates) => super.copyWith((message) => updates(message as CueTime)) as CueTime;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueTime create() => CueTime._();
  CueTime createEmptyInstance() => create();
  static $pb.PbList<CueTime> createRepeated() => $pb.PbList<CueTime>();
  @$core.pragma('dart2js:noInline')
  static CueTime getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueTime>(create);
  static CueTime? _defaultInstance;

  CueTime_Time whichTime() => _CueTime_TimeByTag[$_whichOneof(0)]!;
  void clearTime() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.double get seconds => $_getN(0);
  @$pb.TagNumber(1)
  set seconds($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearSeconds() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get beats => $_getN(1);
  @$pb.TagNumber(2)
  set beats($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBeats() => $_has(1);
  @$pb.TagNumber(2)
  void clearBeats() => clearField(2);
}

class CueTimerRange extends $pb.GeneratedMessage {
  factory CueTimerRange({
    CueTime? from,
    CueTime? to,
  }) {
    final $result = create();
    if (from != null) {
      $result.from = from;
    }
    if (to != null) {
      $result.to = to;
    }
    return $result;
  }
  CueTimerRange._() : super();
  factory CueTimerRange.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueTimerRange.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CueTimerRange', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..aOM<CueTime>(1, _omitFieldNames ? '' : 'from', subBuilder: CueTime.create)
    ..aOM<CueTime>(2, _omitFieldNames ? '' : 'to', subBuilder: CueTime.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueTimerRange clone() => CueTimerRange()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueTimerRange copyWith(void Function(CueTimerRange) updates) => super.copyWith((message) => updates(message as CueTimerRange)) as CueTimerRange;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CueTimerRange create() => CueTimerRange._();
  CueTimerRange createEmptyInstance() => create();
  static $pb.PbList<CueTimerRange> createRepeated() => $pb.PbList<CueTimerRange>();
  @$core.pragma('dart2js:noInline')
  static CueTimerRange getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueTimerRange>(create);
  static CueTimerRange? _defaultInstance;

  @$pb.TagNumber(1)
  CueTime get from => $_getN(0);
  @$pb.TagNumber(1)
  set from(CueTime v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFrom() => $_has(0);
  @$pb.TagNumber(1)
  void clearFrom() => clearField(1);
  @$pb.TagNumber(1)
  CueTime ensureFrom() => $_ensure(0);

  @$pb.TagNumber(2)
  CueTime get to => $_getN(1);
  @$pb.TagNumber(2)
  set to(CueTime v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTo() => $_has(1);
  @$pb.TagNumber(2)
  void clearTo() => clearField(2);
  @$pb.TagNumber(2)
  CueTime ensureTo() => $_ensure(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
