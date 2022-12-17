///
//  Generated code. Do not modify.
//  source: mappings.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'nodes.pb.dart' as $0;

class MappingResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MappingResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.mappings'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  MappingResult._() : super();
  factory MappingResult() => create();
  factory MappingResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MappingResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MappingResult clone() => MappingResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MappingResult copyWith(void Function(MappingResult) updates) => super.copyWith((message) => updates(message as MappingResult)) as MappingResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MappingResult create() => MappingResult._();
  MappingResult createEmptyInstance() => create();
  static $pb.PbList<MappingResult> createRepeated() => $pb.PbList<MappingResult>();
  @$core.pragma('dart2js:noInline')
  static MappingResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MappingResult>(create);
  static MappingResult? _defaultInstance;
}

enum MappingRequest_Binding {
  midi, 
  notSet
}

enum MappingRequest_Action {
  sequencerGo, 
  sequencerStop, 
  layoutControl, 
  programmerHighlight, 
  programmerClear, 
  notSet
}

class MappingRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, MappingRequest_Binding> _MappingRequest_BindingByTag = {
    1 : MappingRequest_Binding.midi,
    0 : MappingRequest_Binding.notSet
  };
  static const $core.Map<$core.int, MappingRequest_Action> _MappingRequest_ActionByTag = {
    10 : MappingRequest_Action.sequencerGo,
    11 : MappingRequest_Action.sequencerStop,
    12 : MappingRequest_Action.layoutControl,
    13 : MappingRequest_Action.programmerHighlight,
    14 : MappingRequest_Action.programmerClear,
    0 : MappingRequest_Action.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MappingRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.mappings'), createEmptyInstance: create)
    ..oo(0, [1])
    ..oo(1, [10, 11, 12, 13, 14])
    ..aOM<MidiMapping>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'midi', subBuilder: MidiMapping.create)
    ..aOM<SequencerGoAction>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequencerGo', subBuilder: SequencerGoAction.create)
    ..aOM<SequencerStopAction>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequencerStop', subBuilder: SequencerStopAction.create)
    ..aOM<LayoutControlAction>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'layoutControl', subBuilder: LayoutControlAction.create)
    ..aOM<ProgrammerHighlightAction>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'programmerHighlight', subBuilder: ProgrammerHighlightAction.create)
    ..aOM<ProgrammerClearAction>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'programmerClear', subBuilder: ProgrammerClearAction.create)
    ..hasRequiredFields = false
  ;

  MappingRequest._() : super();
  factory MappingRequest({
    MidiMapping? midi,
    SequencerGoAction? sequencerGo,
    SequencerStopAction? sequencerStop,
    LayoutControlAction? layoutControl,
    ProgrammerHighlightAction? programmerHighlight,
    ProgrammerClearAction? programmerClear,
  }) {
    final _result = create();
    if (midi != null) {
      _result.midi = midi;
    }
    if (sequencerGo != null) {
      _result.sequencerGo = sequencerGo;
    }
    if (sequencerStop != null) {
      _result.sequencerStop = sequencerStop;
    }
    if (layoutControl != null) {
      _result.layoutControl = layoutControl;
    }
    if (programmerHighlight != null) {
      _result.programmerHighlight = programmerHighlight;
    }
    if (programmerClear != null) {
      _result.programmerClear = programmerClear;
    }
    return _result;
  }
  factory MappingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MappingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MappingRequest clone() => MappingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MappingRequest copyWith(void Function(MappingRequest) updates) => super.copyWith((message) => updates(message as MappingRequest)) as MappingRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MappingRequest create() => MappingRequest._();
  MappingRequest createEmptyInstance() => create();
  static $pb.PbList<MappingRequest> createRepeated() => $pb.PbList<MappingRequest>();
  @$core.pragma('dart2js:noInline')
  static MappingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MappingRequest>(create);
  static MappingRequest? _defaultInstance;

  MappingRequest_Binding whichBinding() => _MappingRequest_BindingByTag[$_whichOneof(0)]!;
  void clearBinding() => clearField($_whichOneof(0));

  MappingRequest_Action whichAction() => _MappingRequest_ActionByTag[$_whichOneof(1)]!;
  void clearAction() => clearField($_whichOneof(1));

  @$pb.TagNumber(1)
  MidiMapping get midi => $_getN(0);
  @$pb.TagNumber(1)
  set midi(MidiMapping v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMidi() => $_has(0);
  @$pb.TagNumber(1)
  void clearMidi() => clearField(1);
  @$pb.TagNumber(1)
  MidiMapping ensureMidi() => $_ensure(0);

  @$pb.TagNumber(10)
  SequencerGoAction get sequencerGo => $_getN(1);
  @$pb.TagNumber(10)
  set sequencerGo(SequencerGoAction v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasSequencerGo() => $_has(1);
  @$pb.TagNumber(10)
  void clearSequencerGo() => clearField(10);
  @$pb.TagNumber(10)
  SequencerGoAction ensureSequencerGo() => $_ensure(1);

  @$pb.TagNumber(11)
  SequencerStopAction get sequencerStop => $_getN(2);
  @$pb.TagNumber(11)
  set sequencerStop(SequencerStopAction v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasSequencerStop() => $_has(2);
  @$pb.TagNumber(11)
  void clearSequencerStop() => clearField(11);
  @$pb.TagNumber(11)
  SequencerStopAction ensureSequencerStop() => $_ensure(2);

  @$pb.TagNumber(12)
  LayoutControlAction get layoutControl => $_getN(3);
  @$pb.TagNumber(12)
  set layoutControl(LayoutControlAction v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasLayoutControl() => $_has(3);
  @$pb.TagNumber(12)
  void clearLayoutControl() => clearField(12);
  @$pb.TagNumber(12)
  LayoutControlAction ensureLayoutControl() => $_ensure(3);

  @$pb.TagNumber(13)
  ProgrammerHighlightAction get programmerHighlight => $_getN(4);
  @$pb.TagNumber(13)
  set programmerHighlight(ProgrammerHighlightAction v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasProgrammerHighlight() => $_has(4);
  @$pb.TagNumber(13)
  void clearProgrammerHighlight() => clearField(13);
  @$pb.TagNumber(13)
  ProgrammerHighlightAction ensureProgrammerHighlight() => $_ensure(4);

  @$pb.TagNumber(14)
  ProgrammerClearAction get programmerClear => $_getN(5);
  @$pb.TagNumber(14)
  set programmerClear(ProgrammerClearAction v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasProgrammerClear() => $_has(5);
  @$pb.TagNumber(14)
  void clearProgrammerClear() => clearField(14);
  @$pb.TagNumber(14)
  ProgrammerClearAction ensureProgrammerClear() => $_ensure(5);
}

class MidiMapping extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiMapping', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.mappings'), createEmptyInstance: create)
    ..aOM<$0.MidiNodeConfig>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'config', subBuilder: $0.MidiNodeConfig.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inputMapping')
    ..hasRequiredFields = false
  ;

  MidiMapping._() : super();
  factory MidiMapping({
    $0.MidiNodeConfig? config,
    $core.bool? inputMapping,
  }) {
    final _result = create();
    if (config != null) {
      _result.config = config;
    }
    if (inputMapping != null) {
      _result.inputMapping = inputMapping;
    }
    return _result;
  }
  factory MidiMapping.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiMapping.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiMapping clone() => MidiMapping()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiMapping copyWith(void Function(MidiMapping) updates) => super.copyWith((message) => updates(message as MidiMapping)) as MidiMapping; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MidiMapping create() => MidiMapping._();
  MidiMapping createEmptyInstance() => create();
  static $pb.PbList<MidiMapping> createRepeated() => $pb.PbList<MidiMapping>();
  @$core.pragma('dart2js:noInline')
  static MidiMapping getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiMapping>(create);
  static MidiMapping? _defaultInstance;

  @$pb.TagNumber(1)
  $0.MidiNodeConfig get config => $_getN(0);
  @$pb.TagNumber(1)
  set config($0.MidiNodeConfig v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasConfig() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfig() => clearField(1);
  @$pb.TagNumber(1)
  $0.MidiNodeConfig ensureConfig() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get inputMapping => $_getBF(1);
  @$pb.TagNumber(2)
  set inputMapping($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInputMapping() => $_has(1);
  @$pb.TagNumber(2)
  void clearInputMapping() => clearField(2);
}

class SequencerGoAction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SequencerGoAction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.mappings'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequencerId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  SequencerGoAction._() : super();
  factory SequencerGoAction({
    $core.int? sequencerId,
  }) {
    final _result = create();
    if (sequencerId != null) {
      _result.sequencerId = sequencerId;
    }
    return _result;
  }
  factory SequencerGoAction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequencerGoAction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequencerGoAction clone() => SequencerGoAction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequencerGoAction copyWith(void Function(SequencerGoAction) updates) => super.copyWith((message) => updates(message as SequencerGoAction)) as SequencerGoAction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SequencerGoAction create() => SequencerGoAction._();
  SequencerGoAction createEmptyInstance() => create();
  static $pb.PbList<SequencerGoAction> createRepeated() => $pb.PbList<SequencerGoAction>();
  @$core.pragma('dart2js:noInline')
  static SequencerGoAction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequencerGoAction>(create);
  static SequencerGoAction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequencerId => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequencerId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequencerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequencerId() => clearField(1);
}

class SequencerStopAction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SequencerStopAction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.mappings'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequencerId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  SequencerStopAction._() : super();
  factory SequencerStopAction({
    $core.int? sequencerId,
  }) {
    final _result = create();
    if (sequencerId != null) {
      _result.sequencerId = sequencerId;
    }
    return _result;
  }
  factory SequencerStopAction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequencerStopAction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequencerStopAction clone() => SequencerStopAction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequencerStopAction copyWith(void Function(SequencerStopAction) updates) => super.copyWith((message) => updates(message as SequencerStopAction)) as SequencerStopAction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SequencerStopAction create() => SequencerStopAction._();
  SequencerStopAction createEmptyInstance() => create();
  static $pb.PbList<SequencerStopAction> createRepeated() => $pb.PbList<SequencerStopAction>();
  @$core.pragma('dart2js:noInline')
  static SequencerStopAction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequencerStopAction>(create);
  static SequencerStopAction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequencerId => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequencerId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequencerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequencerId() => clearField(1);
}

class LayoutControlAction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LayoutControlAction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.mappings'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controlNode')
    ..hasRequiredFields = false
  ;

  LayoutControlAction._() : super();
  factory LayoutControlAction({
    $core.String? controlNode,
  }) {
    final _result = create();
    if (controlNode != null) {
      _result.controlNode = controlNode;
    }
    return _result;
  }
  factory LayoutControlAction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LayoutControlAction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LayoutControlAction clone() => LayoutControlAction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LayoutControlAction copyWith(void Function(LayoutControlAction) updates) => super.copyWith((message) => updates(message as LayoutControlAction)) as LayoutControlAction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LayoutControlAction create() => LayoutControlAction._();
  LayoutControlAction createEmptyInstance() => create();
  static $pb.PbList<LayoutControlAction> createRepeated() => $pb.PbList<LayoutControlAction>();
  @$core.pragma('dart2js:noInline')
  static LayoutControlAction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LayoutControlAction>(create);
  static LayoutControlAction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get controlNode => $_getSZ(0);
  @$pb.TagNumber(1)
  set controlNode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasControlNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearControlNode() => clearField(1);
}

class ProgrammerHighlightAction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProgrammerHighlightAction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.mappings'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ProgrammerHighlightAction._() : super();
  factory ProgrammerHighlightAction() => create();
  factory ProgrammerHighlightAction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProgrammerHighlightAction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProgrammerHighlightAction clone() => ProgrammerHighlightAction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProgrammerHighlightAction copyWith(void Function(ProgrammerHighlightAction) updates) => super.copyWith((message) => updates(message as ProgrammerHighlightAction)) as ProgrammerHighlightAction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProgrammerHighlightAction create() => ProgrammerHighlightAction._();
  ProgrammerHighlightAction createEmptyInstance() => create();
  static $pb.PbList<ProgrammerHighlightAction> createRepeated() => $pb.PbList<ProgrammerHighlightAction>();
  @$core.pragma('dart2js:noInline')
  static ProgrammerHighlightAction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProgrammerHighlightAction>(create);
  static ProgrammerHighlightAction? _defaultInstance;
}

class ProgrammerClearAction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProgrammerClearAction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.mappings'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ProgrammerClearAction._() : super();
  factory ProgrammerClearAction() => create();
  factory ProgrammerClearAction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProgrammerClearAction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProgrammerClearAction clone() => ProgrammerClearAction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProgrammerClearAction copyWith(void Function(ProgrammerClearAction) updates) => super.copyWith((message) => updates(message as ProgrammerClearAction)) as ProgrammerClearAction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProgrammerClearAction create() => ProgrammerClearAction._();
  ProgrammerClearAction createEmptyInstance() => create();
  static $pb.PbList<ProgrammerClearAction> createRepeated() => $pb.PbList<ProgrammerClearAction>();
  @$core.pragma('dart2js:noInline')
  static ProgrammerClearAction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProgrammerClearAction>(create);
  static ProgrammerClearAction? _defaultInstance;
}

