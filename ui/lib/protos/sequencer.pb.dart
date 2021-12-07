///
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'fixtures.pb.dart' as $0;

import 'sequencer.pbenum.dart';

export 'sequencer.pbenum.dart';

class GetSequencesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSequencesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetSequencesRequest._() : super();
  factory GetSequencesRequest() => create();
  factory GetSequencesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSequencesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSequencesRequest clone() => GetSequencesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSequencesRequest copyWith(void Function(GetSequencesRequest) updates) => super.copyWith((message) => updates(message as GetSequencesRequest)) as GetSequencesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSequencesRequest create() => GetSequencesRequest._();
  GetSequencesRequest createEmptyInstance() => create();
  static $pb.PbList<GetSequencesRequest> createRepeated() => $pb.PbList<GetSequencesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSequencesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSequencesRequest>(create);
  static GetSequencesRequest? _defaultInstance;
}

class GetSequenceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSequenceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  GetSequenceRequest._() : super();
  factory GetSequenceRequest({
    $core.int? sequence,
  }) {
    final _result = create();
    if (sequence != null) {
      _result.sequence = sequence;
    }
    return _result;
  }
  factory GetSequenceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSequenceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSequenceRequest clone() => GetSequenceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSequenceRequest copyWith(void Function(GetSequenceRequest) updates) => super.copyWith((message) => updates(message as GetSequenceRequest)) as GetSequenceRequest; // ignore: deprecated_member_use
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

class AddSequenceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddSequenceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  AddSequenceRequest._() : super();
  factory AddSequenceRequest() => create();
  factory AddSequenceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddSequenceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddSequenceRequest clone() => AddSequenceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddSequenceRequest copyWith(void Function(AddSequenceRequest) updates) => super.copyWith((message) => updates(message as AddSequenceRequest)) as AddSequenceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddSequenceRequest create() => AddSequenceRequest._();
  AddSequenceRequest createEmptyInstance() => create();
  static $pb.PbList<AddSequenceRequest> createRepeated() => $pb.PbList<AddSequenceRequest>();
  @$core.pragma('dart2js:noInline')
  static AddSequenceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddSequenceRequest>(create);
  static AddSequenceRequest? _defaultInstance;
}

class DeleteSequenceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteSequenceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  DeleteSequenceRequest._() : super();
  factory DeleteSequenceRequest({
    $core.int? sequence,
  }) {
    final _result = create();
    if (sequence != null) {
      _result.sequence = sequence;
    }
    return _result;
  }
  factory DeleteSequenceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteSequenceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteSequenceRequest clone() => DeleteSequenceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteSequenceRequest copyWith(void Function(DeleteSequenceRequest) updates) => super.copyWith((message) => updates(message as DeleteSequenceRequest)) as DeleteSequenceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SequenceGoRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  SequenceGoRequest._() : super();
  factory SequenceGoRequest({
    $core.int? sequence,
  }) {
    final _result = create();
    if (sequence != null) {
      _result.sequence = sequence;
    }
    return _result;
  }
  factory SequenceGoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequenceGoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequenceGoRequest clone() => SequenceGoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequenceGoRequest copyWith(void Function(SequenceGoRequest) updates) => super.copyWith((message) => updates(message as SequenceGoRequest)) as SequenceGoRequest; // ignore: deprecated_member_use
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

class CueTriggerRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CueTriggerRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequence', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cue', $pb.PbFieldType.OU3)
    ..e<CueTrigger>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'trigger', $pb.PbFieldType.OE, defaultOrMaker: CueTrigger.GO, valueOf: CueTrigger.valueOf, enumValues: CueTrigger.values)
    ..hasRequiredFields = false
  ;

  CueTriggerRequest._() : super();
  factory CueTriggerRequest({
    $core.int? sequence,
    $core.int? cue,
    CueTrigger? trigger,
  }) {
    final _result = create();
    if (sequence != null) {
      _result.sequence = sequence;
    }
    if (cue != null) {
      _result.cue = cue;
    }
    if (trigger != null) {
      _result.trigger = trigger;
    }
    return _result;
  }
  factory CueTriggerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueTriggerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueTriggerRequest clone() => CueTriggerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueTriggerRequest copyWith(void Function(CueTriggerRequest) updates) => super.copyWith((message) => updates(message as CueTriggerRequest)) as CueTriggerRequest; // ignore: deprecated_member_use
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
  CueTrigger get trigger => $_getN(2);
  @$pb.TagNumber(3)
  set trigger(CueTrigger v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTrigger() => $_has(2);
  @$pb.TagNumber(3)
  void clearTrigger() => clearField(3);
}

class EmptyResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EmptyResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  EmptyResponse._() : super();
  factory EmptyResponse() => create();
  factory EmptyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmptyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmptyResponse clone() => EmptyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmptyResponse copyWith(void Function(EmptyResponse) updates) => super.copyWith((message) => updates(message as EmptyResponse)) as EmptyResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EmptyResponse create() => EmptyResponse._();
  EmptyResponse createEmptyInstance() => create();
  static $pb.PbList<EmptyResponse> createRepeated() => $pb.PbList<EmptyResponse>();
  @$core.pragma('dart2js:noInline')
  static EmptyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmptyResponse>(create);
  static EmptyResponse? _defaultInstance;
}

class Sequences extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Sequences', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..pc<Sequence>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequences', $pb.PbFieldType.PM, subBuilder: Sequence.create)
    ..hasRequiredFields = false
  ;

  Sequences._() : super();
  factory Sequences({
    $core.Iterable<Sequence>? sequences,
  }) {
    final _result = create();
    if (sequences != null) {
      _result.sequences.addAll(sequences);
    }
    return _result;
  }
  factory Sequences.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Sequences.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Sequences clone() => Sequences()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Sequences copyWith(void Function(Sequences) updates) => super.copyWith((message) => updates(message as Sequences)) as Sequences; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Sequence', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<Cue>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cues', $pb.PbFieldType.PM, subBuilder: Cue.create)
    ..hasRequiredFields = false
  ;

  Sequence._() : super();
  factory Sequence({
    $core.int? id,
    $core.String? name,
    $core.Iterable<Cue>? cues,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (cues != null) {
      _result.cues.addAll(cues);
    }
    return _result;
  }
  factory Sequence.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Sequence.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Sequence clone() => Sequence()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Sequence copyWith(void Function(Sequence) updates) => super.copyWith((message) => updates(message as Sequence)) as Sequence; // ignore: deprecated_member_use
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
}

class Cue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Cue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<CueTrigger>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'trigger', $pb.PbFieldType.OE, defaultOrMaker: CueTrigger.GO, valueOf: CueTrigger.valueOf, enumValues: CueTrigger.values)
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'loop')
    ..pc<CueChannel>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: CueChannel.create)
    ..hasRequiredFields = false
  ;

  Cue._() : super();
  factory Cue({
    $core.int? id,
    $core.String? name,
    CueTrigger? trigger,
    $core.bool? loop,
    $core.Iterable<CueChannel>? channels,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (trigger != null) {
      _result.trigger = trigger;
    }
    if (loop != null) {
      _result.loop = loop;
    }
    if (channels != null) {
      _result.channels.addAll(channels);
    }
    return _result;
  }
  factory Cue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Cue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Cue clone() => Cue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Cue copyWith(void Function(Cue) updates) => super.copyWith((message) => updates(message as Cue)) as Cue; // ignore: deprecated_member_use
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

  @$pb.TagNumber(4)
  $core.bool get loop => $_getBF(3);
  @$pb.TagNumber(4)
  set loop($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLoop() => $_has(3);
  @$pb.TagNumber(4)
  void clearLoop() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<CueChannel> get channels => $_getList(4);
}

class CueChannel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CueChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..pc<$0.FixtureId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..e<CueControl>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'control', $pb.PbFieldType.OE, defaultOrMaker: CueControl.INTENSITY, valueOf: CueControl.valueOf, enumValues: CueControl.values)
    ..aOM<CueValue>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', subBuilder: CueValue.create)
    ..aOM<CueTimer>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fade', subBuilder: CueTimer.create)
    ..aOM<CueTimer>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'delay', subBuilder: CueTimer.create)
    ..hasRequiredFields = false
  ;

  CueChannel._() : super();
  factory CueChannel({
    $core.Iterable<$0.FixtureId>? fixtures,
    CueControl? control,
    CueValue? value,
    CueTimer? fade,
    CueTimer? delay,
  }) {
    final _result = create();
    if (fixtures != null) {
      _result.fixtures.addAll(fixtures);
    }
    if (control != null) {
      _result.control = control;
    }
    if (value != null) {
      _result.value = value;
    }
    if (fade != null) {
      _result.fade = fade;
    }
    if (delay != null) {
      _result.delay = delay;
    }
    return _result;
  }
  factory CueChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueChannel clone() => CueChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueChannel copyWith(void Function(CueChannel) updates) => super.copyWith((message) => updates(message as CueChannel)) as CueChannel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CueChannel create() => CueChannel._();
  CueChannel createEmptyInstance() => create();
  static $pb.PbList<CueChannel> createRepeated() => $pb.PbList<CueChannel>();
  @$core.pragma('dart2js:noInline')
  static CueChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CueChannel>(create);
  static CueChannel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.FixtureId> get fixtures => $_getList(0);

  @$pb.TagNumber(2)
  CueControl get control => $_getN(1);
  @$pb.TagNumber(2)
  set control(CueControl v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasControl() => $_has(1);
  @$pb.TagNumber(2)
  void clearControl() => clearField(2);

  @$pb.TagNumber(3)
  CueValue get value => $_getN(2);
  @$pb.TagNumber(3)
  set value(CueValue v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => clearField(3);
  @$pb.TagNumber(3)
  CueValue ensureValue() => $_ensure(2);

  @$pb.TagNumber(4)
  CueTimer get fade => $_getN(3);
  @$pb.TagNumber(4)
  set fade(CueTimer v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasFade() => $_has(3);
  @$pb.TagNumber(4)
  void clearFade() => clearField(4);
  @$pb.TagNumber(4)
  CueTimer ensureFade() => $_ensure(3);

  @$pb.TagNumber(5)
  CueTimer get delay => $_getN(4);
  @$pb.TagNumber(5)
  set delay(CueTimer v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDelay() => $_has(4);
  @$pb.TagNumber(5)
  void clearDelay() => clearField(5);
  @$pb.TagNumber(5)
  CueTimer ensureDelay() => $_ensure(4);
}

enum CueValue_Value {
  direct, 
  range, 
  notSet
}

class CueValue extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, CueValue_Value> _CueValue_ValueByTag = {
    3 : CueValue_Value.direct,
    4 : CueValue_Value.range,
    0 : CueValue_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CueValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direct', $pb.PbFieldType.OD)
    ..aOM<CueValueRange>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'range', subBuilder: CueValueRange.create)
    ..hasRequiredFields = false
  ;

  CueValue._() : super();
  factory CueValue({
    $core.double? direct,
    CueValueRange? range,
  }) {
    final _result = create();
    if (direct != null) {
      _result.direct = direct;
    }
    if (range != null) {
      _result.range = range;
    }
    return _result;
  }
  factory CueValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueValue clone() => CueValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueValue copyWith(void Function(CueValue) updates) => super.copyWith((message) => updates(message as CueValue)) as CueValue; // ignore: deprecated_member_use
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
  static const $core.Map<$core.int, CueTimer_Timer> _CueTimer_TimerByTag = {
    2 : CueTimer_Timer.direct,
    3 : CueTimer_Timer.range,
    0 : CueTimer_Timer.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CueTimer', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasTimer', protoName: 'hasTimer')
    ..aOM<CueTime>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direct', subBuilder: CueTime.create)
    ..aOM<CueTimerRange>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'range', subBuilder: CueTimerRange.create)
    ..hasRequiredFields = false
  ;

  CueTimer._() : super();
  factory CueTimer({
    $core.bool? hasTimer,
    CueTime? direct,
    CueTimerRange? range,
  }) {
    final _result = create();
    if (hasTimer != null) {
      _result.hasTimer = hasTimer;
    }
    if (direct != null) {
      _result.direct = direct;
    }
    if (range != null) {
      _result.range = range;
    }
    return _result;
  }
  factory CueTimer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueTimer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueTimer clone() => CueTimer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueTimer copyWith(void Function(CueTimer) updates) => super.copyWith((message) => updates(message as CueTimer)) as CueTimer; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CueValueRange', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'to', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CueValueRange._() : super();
  factory CueValueRange({
    $core.double? from,
    $core.double? to,
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
  factory CueValueRange.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueValueRange.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueValueRange clone() => CueValueRange()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueValueRange copyWith(void Function(CueValueRange) updates) => super.copyWith((message) => updates(message as CueValueRange)) as CueValueRange; // ignore: deprecated_member_use
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
  static const $core.Map<$core.int, CueTime_Time> _CueTime_TimeByTag = {
    1 : CueTime_Time.seconds,
    2 : CueTime_Time.beats,
    0 : CueTime_Time.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CueTime', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'seconds', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beats', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CueTime._() : super();
  factory CueTime({
    $core.double? seconds,
    $core.double? beats,
  }) {
    final _result = create();
    if (seconds != null) {
      _result.seconds = seconds;
    }
    if (beats != null) {
      _result.beats = beats;
    }
    return _result;
  }
  factory CueTime.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueTime.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueTime clone() => CueTime()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueTime copyWith(void Function(CueTime) updates) => super.copyWith((message) => updates(message as CueTime)) as CueTime; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CueTimerRange', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.sequencer'), createEmptyInstance: create)
    ..aOM<CueTime>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from', subBuilder: CueTime.create)
    ..aOM<CueTime>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'to', subBuilder: CueTime.create)
    ..hasRequiredFields = false
  ;

  CueTimerRange._() : super();
  factory CueTimerRange({
    CueTime? from,
    CueTime? to,
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
  factory CueTimerRange.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CueTimerRange.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CueTimerRange clone() => CueTimerRange()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CueTimerRange copyWith(void Function(CueTimerRange) updates) => super.copyWith((message) => updates(message as CueTimerRange)) as CueTimerRange; // ignore: deprecated_member_use
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

