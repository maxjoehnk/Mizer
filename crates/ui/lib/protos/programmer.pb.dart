//
//  Generated code. Do not modify.
//  source: programmer.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'fixtures.pb.dart' as $0;
import 'fixtures.pbenum.dart' as $0;
import 'programmer.pbenum.dart';

export 'programmer.pbenum.dart';

class ProgrammerState extends $pb.GeneratedMessage {
  factory ProgrammerState({
    $core.Iterable<$0.FixtureId>? fixtures,
    $core.Iterable<$0.FixtureId>? activeFixtures,
    $core.Iterable<$core.int>? activeGroups,
    FixtureSelection? selection,
    $core.Iterable<ProgrammerChannel>? controls,
    $core.bool? highlight,
    $core.int? blockSize,
    $core.int? groups,
    $core.int? wings,
    $core.Iterable<EffectProgrammerState>? effects,
    $core.bool? offline,
  }) {
    final $result = create();
    if (fixtures != null) {
      $result.fixtures.addAll(fixtures);
    }
    if (activeFixtures != null) {
      $result.activeFixtures.addAll(activeFixtures);
    }
    if (activeGroups != null) {
      $result.activeGroups.addAll(activeGroups);
    }
    if (selection != null) {
      $result.selection = selection;
    }
    if (controls != null) {
      $result.controls.addAll(controls);
    }
    if (highlight != null) {
      $result.highlight = highlight;
    }
    if (blockSize != null) {
      $result.blockSize = blockSize;
    }
    if (groups != null) {
      $result.groups = groups;
    }
    if (wings != null) {
      $result.wings = wings;
    }
    if (effects != null) {
      $result.effects.addAll(effects);
    }
    if (offline != null) {
      $result.offline = offline;
    }
    return $result;
  }
  ProgrammerState._() : super();
  factory ProgrammerState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProgrammerState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProgrammerState', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<$0.FixtureId>(1, _omitFieldNames ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..pc<$0.FixtureId>(2, _omitFieldNames ? '' : 'activeFixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..p<$core.int>(3, _omitFieldNames ? '' : 'activeGroups', $pb.PbFieldType.KU3)
    ..aOM<FixtureSelection>(4, _omitFieldNames ? '' : 'selection', subBuilder: FixtureSelection.create)
    ..pc<ProgrammerChannel>(5, _omitFieldNames ? '' : 'controls', $pb.PbFieldType.PM, subBuilder: ProgrammerChannel.create)
    ..aOB(6, _omitFieldNames ? '' : 'highlight')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'blockSize', $pb.PbFieldType.OU3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'groups', $pb.PbFieldType.OU3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'wings', $pb.PbFieldType.OU3)
    ..pc<EffectProgrammerState>(10, _omitFieldNames ? '' : 'effects', $pb.PbFieldType.PM, subBuilder: EffectProgrammerState.create)
    ..aOB(11, _omitFieldNames ? '' : 'offline')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProgrammerState clone() => ProgrammerState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProgrammerState copyWith(void Function(ProgrammerState) updates) => super.copyWith((message) => updates(message as ProgrammerState)) as ProgrammerState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProgrammerState create() => ProgrammerState._();
  ProgrammerState createEmptyInstance() => create();
  static $pb.PbList<ProgrammerState> createRepeated() => $pb.PbList<ProgrammerState>();
  @$core.pragma('dart2js:noInline')
  static ProgrammerState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProgrammerState>(create);
  static ProgrammerState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.FixtureId> get fixtures => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$0.FixtureId> get activeFixtures => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.int> get activeGroups => $_getList(2);

  @$pb.TagNumber(4)
  FixtureSelection get selection => $_getN(3);
  @$pb.TagNumber(4)
  set selection(FixtureSelection v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSelection() => $_has(3);
  @$pb.TagNumber(4)
  void clearSelection() => clearField(4);
  @$pb.TagNumber(4)
  FixtureSelection ensureSelection() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.List<ProgrammerChannel> get controls => $_getList(4);

  @$pb.TagNumber(6)
  $core.bool get highlight => $_getBF(5);
  @$pb.TagNumber(6)
  set highlight($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHighlight() => $_has(5);
  @$pb.TagNumber(6)
  void clearHighlight() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get blockSize => $_getIZ(6);
  @$pb.TagNumber(7)
  set blockSize($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBlockSize() => $_has(6);
  @$pb.TagNumber(7)
  void clearBlockSize() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get groups => $_getIZ(7);
  @$pb.TagNumber(8)
  set groups($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasGroups() => $_has(7);
  @$pb.TagNumber(8)
  void clearGroups() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get wings => $_getIZ(8);
  @$pb.TagNumber(9)
  set wings($core.int v) { $_setUnsignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasWings() => $_has(8);
  @$pb.TagNumber(9)
  void clearWings() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<EffectProgrammerState> get effects => $_getList(9);

  @$pb.TagNumber(11)
  $core.bool get offline => $_getBF(10);
  @$pb.TagNumber(11)
  set offline($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasOffline() => $_has(10);
  @$pb.TagNumber(11)
  void clearOffline() => clearField(11);
}

class FixtureSelection_GroupedFixtureList extends $pb.GeneratedMessage {
  factory FixtureSelection_GroupedFixtureList({
    $core.Iterable<$0.FixtureId>? fixtures,
  }) {
    final $result = create();
    if (fixtures != null) {
      $result.fixtures.addAll(fixtures);
    }
    return $result;
  }
  FixtureSelection_GroupedFixtureList._() : super();
  factory FixtureSelection_GroupedFixtureList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureSelection_GroupedFixtureList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureSelection.GroupedFixtureList', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<$0.FixtureId>(1, _omitFieldNames ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureSelection_GroupedFixtureList clone() => FixtureSelection_GroupedFixtureList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureSelection_GroupedFixtureList copyWith(void Function(FixtureSelection_GroupedFixtureList) updates) => super.copyWith((message) => updates(message as FixtureSelection_GroupedFixtureList)) as FixtureSelection_GroupedFixtureList;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureSelection_GroupedFixtureList create() => FixtureSelection_GroupedFixtureList._();
  FixtureSelection_GroupedFixtureList createEmptyInstance() => create();
  static $pb.PbList<FixtureSelection_GroupedFixtureList> createRepeated() => $pb.PbList<FixtureSelection_GroupedFixtureList>();
  @$core.pragma('dart2js:noInline')
  static FixtureSelection_GroupedFixtureList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureSelection_GroupedFixtureList>(create);
  static FixtureSelection_GroupedFixtureList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.FixtureId> get fixtures => $_getList(0);
}

class FixtureSelection extends $pb.GeneratedMessage {
  factory FixtureSelection({
    $core.Iterable<FixtureSelection_GroupedFixtureList>? fixtures,
  }) {
    final $result = create();
    if (fixtures != null) {
      $result.fixtures.addAll(fixtures);
    }
    return $result;
  }
  FixtureSelection._() : super();
  factory FixtureSelection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureSelection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FixtureSelection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<FixtureSelection_GroupedFixtureList>(1, _omitFieldNames ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: FixtureSelection_GroupedFixtureList.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureSelection clone() => FixtureSelection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureSelection copyWith(void Function(FixtureSelection) updates) => super.copyWith((message) => updates(message as FixtureSelection)) as FixtureSelection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FixtureSelection create() => FixtureSelection._();
  FixtureSelection createEmptyInstance() => create();
  static $pb.PbList<FixtureSelection> createRepeated() => $pb.PbList<FixtureSelection>();
  @$core.pragma('dart2js:noInline')
  static FixtureSelection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureSelection>(create);
  static FixtureSelection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FixtureSelection_GroupedFixtureList> get fixtures => $_getList(0);
}

class ProgrammerChannel_GenericValue extends $pb.GeneratedMessage {
  factory ProgrammerChannel_GenericValue({
    $core.String? name,
    $core.double? value,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  ProgrammerChannel_GenericValue._() : super();
  factory ProgrammerChannel_GenericValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProgrammerChannel_GenericValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProgrammerChannel.GenericValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProgrammerChannel_GenericValue clone() => ProgrammerChannel_GenericValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProgrammerChannel_GenericValue copyWith(void Function(ProgrammerChannel_GenericValue) updates) => super.copyWith((message) => updates(message as ProgrammerChannel_GenericValue)) as ProgrammerChannel_GenericValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProgrammerChannel_GenericValue create() => ProgrammerChannel_GenericValue._();
  ProgrammerChannel_GenericValue createEmptyInstance() => create();
  static $pb.PbList<ProgrammerChannel_GenericValue> createRepeated() => $pb.PbList<ProgrammerChannel_GenericValue>();
  @$core.pragma('dart2js:noInline')
  static ProgrammerChannel_GenericValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProgrammerChannel_GenericValue>(create);
  static ProgrammerChannel_GenericValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

enum ProgrammerChannel_Value {
  fader, 
  color, 
  generic, 
  preset, 
  notSet
}

class ProgrammerChannel extends $pb.GeneratedMessage {
  factory ProgrammerChannel({
    $core.Iterable<$0.FixtureId>? fixtures,
    $0.FixtureControl? control,
    $core.double? fader,
    $0.ColorMixerChannel? color,
    ProgrammerChannel_GenericValue? generic,
    PresetId? preset,
  }) {
    final $result = create();
    if (fixtures != null) {
      $result.fixtures.addAll(fixtures);
    }
    if (control != null) {
      $result.control = control;
    }
    if (fader != null) {
      $result.fader = fader;
    }
    if (color != null) {
      $result.color = color;
    }
    if (generic != null) {
      $result.generic = generic;
    }
    if (preset != null) {
      $result.preset = preset;
    }
    return $result;
  }
  ProgrammerChannel._() : super();
  factory ProgrammerChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProgrammerChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ProgrammerChannel_Value> _ProgrammerChannel_ValueByTag = {
    3 : ProgrammerChannel_Value.fader,
    4 : ProgrammerChannel_Value.color,
    5 : ProgrammerChannel_Value.generic,
    6 : ProgrammerChannel_Value.preset,
    0 : ProgrammerChannel_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProgrammerChannel', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6])
    ..pc<$0.FixtureId>(1, _omitFieldNames ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..e<$0.FixtureControl>(2, _omitFieldNames ? '' : 'control', $pb.PbFieldType.OE, defaultOrMaker: $0.FixtureControl.NONE, valueOf: $0.FixtureControl.valueOf, enumValues: $0.FixtureControl.values)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'fader', $pb.PbFieldType.OD)
    ..aOM<$0.ColorMixerChannel>(4, _omitFieldNames ? '' : 'color', subBuilder: $0.ColorMixerChannel.create)
    ..aOM<ProgrammerChannel_GenericValue>(5, _omitFieldNames ? '' : 'generic', subBuilder: ProgrammerChannel_GenericValue.create)
    ..aOM<PresetId>(6, _omitFieldNames ? '' : 'preset', subBuilder: PresetId.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProgrammerChannel clone() => ProgrammerChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProgrammerChannel copyWith(void Function(ProgrammerChannel) updates) => super.copyWith((message) => updates(message as ProgrammerChannel)) as ProgrammerChannel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProgrammerChannel create() => ProgrammerChannel._();
  ProgrammerChannel createEmptyInstance() => create();
  static $pb.PbList<ProgrammerChannel> createRepeated() => $pb.PbList<ProgrammerChannel>();
  @$core.pragma('dart2js:noInline')
  static ProgrammerChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProgrammerChannel>(create);
  static ProgrammerChannel? _defaultInstance;

  ProgrammerChannel_Value whichValue() => _ProgrammerChannel_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.List<$0.FixtureId> get fixtures => $_getList(0);

  @$pb.TagNumber(2)
  $0.FixtureControl get control => $_getN(1);
  @$pb.TagNumber(2)
  set control($0.FixtureControl v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasControl() => $_has(1);
  @$pb.TagNumber(2)
  void clearControl() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get fader => $_getN(2);
  @$pb.TagNumber(3)
  set fader($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFader() => $_has(2);
  @$pb.TagNumber(3)
  void clearFader() => clearField(3);

  @$pb.TagNumber(4)
  $0.ColorMixerChannel get color => $_getN(3);
  @$pb.TagNumber(4)
  set color($0.ColorMixerChannel v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasColor() => $_has(3);
  @$pb.TagNumber(4)
  void clearColor() => clearField(4);
  @$pb.TagNumber(4)
  $0.ColorMixerChannel ensureColor() => $_ensure(3);

  @$pb.TagNumber(5)
  ProgrammerChannel_GenericValue get generic => $_getN(4);
  @$pb.TagNumber(5)
  set generic(ProgrammerChannel_GenericValue v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasGeneric() => $_has(4);
  @$pb.TagNumber(5)
  void clearGeneric() => clearField(5);
  @$pb.TagNumber(5)
  ProgrammerChannel_GenericValue ensureGeneric() => $_ensure(4);

  @$pb.TagNumber(6)
  PresetId get preset => $_getN(5);
  @$pb.TagNumber(6)
  set preset(PresetId v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasPreset() => $_has(5);
  @$pb.TagNumber(6)
  void clearPreset() => clearField(6);
  @$pb.TagNumber(6)
  PresetId ensurePreset() => $_ensure(5);
}

class EffectProgrammerState extends $pb.GeneratedMessage {
  factory EffectProgrammerState({
    $core.int? effectId,
    $core.double? effectRate,
    $core.double? effectOffset,
  }) {
    final $result = create();
    if (effectId != null) {
      $result.effectId = effectId;
    }
    if (effectRate != null) {
      $result.effectRate = effectRate;
    }
    if (effectOffset != null) {
      $result.effectOffset = effectOffset;
    }
    return $result;
  }
  EffectProgrammerState._() : super();
  factory EffectProgrammerState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EffectProgrammerState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EffectProgrammerState', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'effectRate', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'effectOffset', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EffectProgrammerState clone() => EffectProgrammerState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EffectProgrammerState copyWith(void Function(EffectProgrammerState) updates) => super.copyWith((message) => updates(message as EffectProgrammerState)) as EffectProgrammerState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EffectProgrammerState create() => EffectProgrammerState._();
  EffectProgrammerState createEmptyInstance() => create();
  static $pb.PbList<EffectProgrammerState> createRepeated() => $pb.PbList<EffectProgrammerState>();
  @$core.pragma('dart2js:noInline')
  static EffectProgrammerState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EffectProgrammerState>(create);
  static EffectProgrammerState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get effectId => $_getIZ(0);
  @$pb.TagNumber(1)
  set effectId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEffectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEffectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get effectRate => $_getN(1);
  @$pb.TagNumber(2)
  set effectRate($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEffectRate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEffectRate() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get effectOffset => $_getN(2);
  @$pb.TagNumber(3)
  set effectOffset($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEffectOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearEffectOffset() => clearField(3);
}

class WriteEffectRateRequest extends $pb.GeneratedMessage {
  factory WriteEffectRateRequest({
    $core.int? effectId,
    $core.double? effectRate,
  }) {
    final $result = create();
    if (effectId != null) {
      $result.effectId = effectId;
    }
    if (effectRate != null) {
      $result.effectRate = effectRate;
    }
    return $result;
  }
  WriteEffectRateRequest._() : super();
  factory WriteEffectRateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteEffectRateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WriteEffectRateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'effectRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteEffectRateRequest clone() => WriteEffectRateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteEffectRateRequest copyWith(void Function(WriteEffectRateRequest) updates) => super.copyWith((message) => updates(message as WriteEffectRateRequest)) as WriteEffectRateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WriteEffectRateRequest create() => WriteEffectRateRequest._();
  WriteEffectRateRequest createEmptyInstance() => create();
  static $pb.PbList<WriteEffectRateRequest> createRepeated() => $pb.PbList<WriteEffectRateRequest>();
  @$core.pragma('dart2js:noInline')
  static WriteEffectRateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteEffectRateRequest>(create);
  static WriteEffectRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get effectId => $_getIZ(0);
  @$pb.TagNumber(1)
  set effectId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEffectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEffectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get effectRate => $_getN(1);
  @$pb.TagNumber(2)
  set effectRate($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEffectRate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEffectRate() => clearField(2);
}

class WriteEffectOffsetRequest extends $pb.GeneratedMessage {
  factory WriteEffectOffsetRequest({
    $core.int? effectId,
    $core.double? effectOffset,
  }) {
    final $result = create();
    if (effectId != null) {
      $result.effectId = effectId;
    }
    if (effectOffset != null) {
      $result.effectOffset = effectOffset;
    }
    return $result;
  }
  WriteEffectOffsetRequest._() : super();
  factory WriteEffectOffsetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteEffectOffsetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WriteEffectOffsetRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'effectOffset', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteEffectOffsetRequest clone() => WriteEffectOffsetRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteEffectOffsetRequest copyWith(void Function(WriteEffectOffsetRequest) updates) => super.copyWith((message) => updates(message as WriteEffectOffsetRequest)) as WriteEffectOffsetRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WriteEffectOffsetRequest create() => WriteEffectOffsetRequest._();
  WriteEffectOffsetRequest createEmptyInstance() => create();
  static $pb.PbList<WriteEffectOffsetRequest> createRepeated() => $pb.PbList<WriteEffectOffsetRequest>();
  @$core.pragma('dart2js:noInline')
  static WriteEffectOffsetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteEffectOffsetRequest>(create);
  static WriteEffectOffsetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get effectId => $_getIZ(0);
  @$pb.TagNumber(1)
  set effectId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEffectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEffectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get effectOffset => $_getN(1);
  @$pb.TagNumber(2)
  set effectOffset($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEffectOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearEffectOffset() => clearField(2);
}

class WriteControlRequest_GenericValue extends $pb.GeneratedMessage {
  factory WriteControlRequest_GenericValue({
    $core.String? name,
    $core.double? value,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  WriteControlRequest_GenericValue._() : super();
  factory WriteControlRequest_GenericValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteControlRequest_GenericValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WriteControlRequest.GenericValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteControlRequest_GenericValue clone() => WriteControlRequest_GenericValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteControlRequest_GenericValue copyWith(void Function(WriteControlRequest_GenericValue) updates) => super.copyWith((message) => updates(message as WriteControlRequest_GenericValue)) as WriteControlRequest_GenericValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WriteControlRequest_GenericValue create() => WriteControlRequest_GenericValue._();
  WriteControlRequest_GenericValue createEmptyInstance() => create();
  static $pb.PbList<WriteControlRequest_GenericValue> createRepeated() => $pb.PbList<WriteControlRequest_GenericValue>();
  @$core.pragma('dart2js:noInline')
  static WriteControlRequest_GenericValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteControlRequest_GenericValue>(create);
  static WriteControlRequest_GenericValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

enum WriteControlRequest_Value {
  fader, 
  color, 
  generic, 
  notSet
}

class WriteControlRequest extends $pb.GeneratedMessage {
  factory WriteControlRequest({
    $0.FixtureControl? control,
    $core.double? fader,
    $0.ColorMixerChannel? color,
    WriteControlRequest_GenericValue? generic,
  }) {
    final $result = create();
    if (control != null) {
      $result.control = control;
    }
    if (fader != null) {
      $result.fader = fader;
    }
    if (color != null) {
      $result.color = color;
    }
    if (generic != null) {
      $result.generic = generic;
    }
    return $result;
  }
  WriteControlRequest._() : super();
  factory WriteControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, WriteControlRequest_Value> _WriteControlRequest_ValueByTag = {
    2 : WriteControlRequest_Value.fader,
    3 : WriteControlRequest_Value.color,
    4 : WriteControlRequest_Value.generic,
    0 : WriteControlRequest_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WriteControlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4])
    ..e<$0.FixtureControl>(1, _omitFieldNames ? '' : 'control', $pb.PbFieldType.OE, defaultOrMaker: $0.FixtureControl.NONE, valueOf: $0.FixtureControl.valueOf, enumValues: $0.FixtureControl.values)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'fader', $pb.PbFieldType.OD)
    ..aOM<$0.ColorMixerChannel>(3, _omitFieldNames ? '' : 'color', subBuilder: $0.ColorMixerChannel.create)
    ..aOM<WriteControlRequest_GenericValue>(4, _omitFieldNames ? '' : 'generic', subBuilder: WriteControlRequest_GenericValue.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteControlRequest clone() => WriteControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteControlRequest copyWith(void Function(WriteControlRequest) updates) => super.copyWith((message) => updates(message as WriteControlRequest)) as WriteControlRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WriteControlRequest create() => WriteControlRequest._();
  WriteControlRequest createEmptyInstance() => create();
  static $pb.PbList<WriteControlRequest> createRepeated() => $pb.PbList<WriteControlRequest>();
  @$core.pragma('dart2js:noInline')
  static WriteControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteControlRequest>(create);
  static WriteControlRequest? _defaultInstance;

  WriteControlRequest_Value whichValue() => _WriteControlRequest_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $0.FixtureControl get control => $_getN(0);
  @$pb.TagNumber(1)
  set control($0.FixtureControl v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasControl() => $_has(0);
  @$pb.TagNumber(1)
  void clearControl() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get fader => $_getN(1);
  @$pb.TagNumber(2)
  set fader($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFader() => $_has(1);
  @$pb.TagNumber(2)
  void clearFader() => clearField(2);

  @$pb.TagNumber(3)
  $0.ColorMixerChannel get color => $_getN(2);
  @$pb.TagNumber(3)
  set color($0.ColorMixerChannel v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasColor() => $_has(2);
  @$pb.TagNumber(3)
  void clearColor() => clearField(3);
  @$pb.TagNumber(3)
  $0.ColorMixerChannel ensureColor() => $_ensure(2);

  @$pb.TagNumber(4)
  WriteControlRequest_GenericValue get generic => $_getN(3);
  @$pb.TagNumber(4)
  set generic(WriteControlRequest_GenericValue v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasGeneric() => $_has(3);
  @$pb.TagNumber(4)
  void clearGeneric() => clearField(4);
  @$pb.TagNumber(4)
  WriteControlRequest_GenericValue ensureGeneric() => $_ensure(3);
}

class SelectFixturesRequest extends $pb.GeneratedMessage {
  factory SelectFixturesRequest({
    $core.Iterable<$0.FixtureId>? fixtures,
  }) {
    final $result = create();
    if (fixtures != null) {
      $result.fixtures.addAll(fixtures);
    }
    return $result;
  }
  SelectFixturesRequest._() : super();
  factory SelectFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SelectFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SelectFixturesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<$0.FixtureId>(1, _omitFieldNames ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SelectFixturesRequest clone() => SelectFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SelectFixturesRequest copyWith(void Function(SelectFixturesRequest) updates) => super.copyWith((message) => updates(message as SelectFixturesRequest)) as SelectFixturesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SelectFixturesRequest create() => SelectFixturesRequest._();
  SelectFixturesRequest createEmptyInstance() => create();
  static $pb.PbList<SelectFixturesRequest> createRepeated() => $pb.PbList<SelectFixturesRequest>();
  @$core.pragma('dart2js:noInline')
  static SelectFixturesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SelectFixturesRequest>(create);
  static SelectFixturesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.FixtureId> get fixtures => $_getList(0);
}

class UnselectFixturesRequest extends $pb.GeneratedMessage {
  factory UnselectFixturesRequest({
    $core.Iterable<$0.FixtureId>? fixtures,
  }) {
    final $result = create();
    if (fixtures != null) {
      $result.fixtures.addAll(fixtures);
    }
    return $result;
  }
  UnselectFixturesRequest._() : super();
  factory UnselectFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnselectFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UnselectFixturesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<$0.FixtureId>(1, _omitFieldNames ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnselectFixturesRequest clone() => UnselectFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnselectFixturesRequest copyWith(void Function(UnselectFixturesRequest) updates) => super.copyWith((message) => updates(message as UnselectFixturesRequest)) as UnselectFixturesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnselectFixturesRequest create() => UnselectFixturesRequest._();
  UnselectFixturesRequest createEmptyInstance() => create();
  static $pb.PbList<UnselectFixturesRequest> createRepeated() => $pb.PbList<UnselectFixturesRequest>();
  @$core.pragma('dart2js:noInline')
  static UnselectFixturesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnselectFixturesRequest>(create);
  static UnselectFixturesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.FixtureId> get fixtures => $_getList(0);
}

class EmptyRequest extends $pb.GeneratedMessage {
  factory EmptyRequest() => create();
  EmptyRequest._() : super();
  factory EmptyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmptyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmptyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmptyRequest clone() => EmptyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmptyRequest copyWith(void Function(EmptyRequest) updates) => super.copyWith((message) => updates(message as EmptyRequest)) as EmptyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmptyRequest create() => EmptyRequest._();
  EmptyRequest createEmptyInstance() => create();
  static $pb.PbList<EmptyRequest> createRepeated() => $pb.PbList<EmptyRequest>();
  @$core.pragma('dart2js:noInline')
  static EmptyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmptyRequest>(create);
  static EmptyRequest? _defaultInstance;
}

class EmptyResponse extends $pb.GeneratedMessage {
  factory EmptyResponse() => create();
  EmptyResponse._() : super();
  factory EmptyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmptyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmptyResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmptyResponse clone() => EmptyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmptyResponse copyWith(void Function(EmptyResponse) updates) => super.copyWith((message) => updates(message as EmptyResponse)) as EmptyResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmptyResponse create() => EmptyResponse._();
  EmptyResponse createEmptyInstance() => create();
  static $pb.PbList<EmptyResponse> createRepeated() => $pb.PbList<EmptyResponse>();
  @$core.pragma('dart2js:noInline')
  static EmptyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmptyResponse>(create);
  static EmptyResponse? _defaultInstance;
}

class HighlightRequest extends $pb.GeneratedMessage {
  factory HighlightRequest({
    $core.bool? highlight,
  }) {
    final $result = create();
    if (highlight != null) {
      $result.highlight = highlight;
    }
    return $result;
  }
  HighlightRequest._() : super();
  factory HighlightRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HighlightRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HighlightRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'highlight')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HighlightRequest clone() => HighlightRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HighlightRequest copyWith(void Function(HighlightRequest) updates) => super.copyWith((message) => updates(message as HighlightRequest)) as HighlightRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HighlightRequest create() => HighlightRequest._();
  HighlightRequest createEmptyInstance() => create();
  static $pb.PbList<HighlightRequest> createRepeated() => $pb.PbList<HighlightRequest>();
  @$core.pragma('dart2js:noInline')
  static HighlightRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HighlightRequest>(create);
  static HighlightRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get highlight => $_getBF(0);
  @$pb.TagNumber(1)
  set highlight($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHighlight() => $_has(0);
  @$pb.TagNumber(1)
  void clearHighlight() => clearField(1);
}

class StoreRequest extends $pb.GeneratedMessage {
  factory StoreRequest({
    $core.int? sequenceId,
    StoreRequest_Mode? storeMode,
    $core.int? cueId,
  }) {
    final $result = create();
    if (sequenceId != null) {
      $result.sequenceId = sequenceId;
    }
    if (storeMode != null) {
      $result.storeMode = storeMode;
    }
    if (cueId != null) {
      $result.cueId = cueId;
    }
    return $result;
  }
  StoreRequest._() : super();
  factory StoreRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StoreRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StoreRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequenceId', $pb.PbFieldType.OU3)
    ..e<StoreRequest_Mode>(2, _omitFieldNames ? '' : 'storeMode', $pb.PbFieldType.OE, defaultOrMaker: StoreRequest_Mode.OVERWRITE, valueOf: StoreRequest_Mode.valueOf, enumValues: StoreRequest_Mode.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'cueId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StoreRequest clone() => StoreRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StoreRequest copyWith(void Function(StoreRequest) updates) => super.copyWith((message) => updates(message as StoreRequest)) as StoreRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StoreRequest create() => StoreRequest._();
  StoreRequest createEmptyInstance() => create();
  static $pb.PbList<StoreRequest> createRepeated() => $pb.PbList<StoreRequest>();
  @$core.pragma('dart2js:noInline')
  static StoreRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StoreRequest>(create);
  static StoreRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.int get cueId => $_getIZ(2);
  @$pb.TagNumber(3)
  set cueId($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCueId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCueId() => clearField(3);
}

class StoreResponse extends $pb.GeneratedMessage {
  factory StoreResponse() => create();
  StoreResponse._() : super();
  factory StoreResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StoreResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StoreResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StoreResponse clone() => StoreResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StoreResponse copyWith(void Function(StoreResponse) updates) => super.copyWith((message) => updates(message as StoreResponse)) as StoreResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StoreResponse create() => StoreResponse._();
  StoreResponse createEmptyInstance() => create();
  static $pb.PbList<StoreResponse> createRepeated() => $pb.PbList<StoreResponse>();
  @$core.pragma('dart2js:noInline')
  static StoreResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StoreResponse>(create);
  static StoreResponse? _defaultInstance;
}

class StorePresetRequest_NewPreset extends $pb.GeneratedMessage {
  factory StorePresetRequest_NewPreset({
    PresetId_PresetType? type,
    $core.String? label,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (label != null) {
      $result.label = label;
    }
    return $result;
  }
  StorePresetRequest_NewPreset._() : super();
  factory StorePresetRequest_NewPreset.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorePresetRequest_NewPreset.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StorePresetRequest.NewPreset', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..e<PresetId_PresetType>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: PresetId_PresetType.INTENSITY, valueOf: PresetId_PresetType.valueOf, enumValues: PresetId_PresetType.values)
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorePresetRequest_NewPreset clone() => StorePresetRequest_NewPreset()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorePresetRequest_NewPreset copyWith(void Function(StorePresetRequest_NewPreset) updates) => super.copyWith((message) => updates(message as StorePresetRequest_NewPreset)) as StorePresetRequest_NewPreset;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StorePresetRequest_NewPreset create() => StorePresetRequest_NewPreset._();
  StorePresetRequest_NewPreset createEmptyInstance() => create();
  static $pb.PbList<StorePresetRequest_NewPreset> createRepeated() => $pb.PbList<StorePresetRequest_NewPreset>();
  @$core.pragma('dart2js:noInline')
  static StorePresetRequest_NewPreset getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StorePresetRequest_NewPreset>(create);
  static StorePresetRequest_NewPreset? _defaultInstance;

  @$pb.TagNumber(1)
  PresetId_PresetType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(PresetId_PresetType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);
}

enum StorePresetRequest_Target {
  existing, 
  newPreset, 
  notSet
}

class StorePresetRequest extends $pb.GeneratedMessage {
  factory StorePresetRequest({
    PresetId? existing,
    StorePresetRequest_NewPreset? newPreset,
  }) {
    final $result = create();
    if (existing != null) {
      $result.existing = existing;
    }
    if (newPreset != null) {
      $result.newPreset = newPreset;
    }
    return $result;
  }
  StorePresetRequest._() : super();
  factory StorePresetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StorePresetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, StorePresetRequest_Target> _StorePresetRequest_TargetByTag = {
    1 : StorePresetRequest_Target.existing,
    2 : StorePresetRequest_Target.newPreset,
    0 : StorePresetRequest_Target.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StorePresetRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<PresetId>(1, _omitFieldNames ? '' : 'existing', subBuilder: PresetId.create)
    ..aOM<StorePresetRequest_NewPreset>(2, _omitFieldNames ? '' : 'newPreset', subBuilder: StorePresetRequest_NewPreset.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StorePresetRequest clone() => StorePresetRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StorePresetRequest copyWith(void Function(StorePresetRequest) updates) => super.copyWith((message) => updates(message as StorePresetRequest)) as StorePresetRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StorePresetRequest create() => StorePresetRequest._();
  StorePresetRequest createEmptyInstance() => create();
  static $pb.PbList<StorePresetRequest> createRepeated() => $pb.PbList<StorePresetRequest>();
  @$core.pragma('dart2js:noInline')
  static StorePresetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StorePresetRequest>(create);
  static StorePresetRequest? _defaultInstance;

  StorePresetRequest_Target whichTarget() => _StorePresetRequest_TargetByTag[$_whichOneof(0)]!;
  void clearTarget() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  PresetId get existing => $_getN(0);
  @$pb.TagNumber(1)
  set existing(PresetId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasExisting() => $_has(0);
  @$pb.TagNumber(1)
  void clearExisting() => clearField(1);
  @$pb.TagNumber(1)
  PresetId ensureExisting() => $_ensure(0);

  @$pb.TagNumber(2)
  StorePresetRequest_NewPreset get newPreset => $_getN(1);
  @$pb.TagNumber(2)
  set newPreset(StorePresetRequest_NewPreset v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewPreset() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewPreset() => clearField(2);
  @$pb.TagNumber(2)
  StorePresetRequest_NewPreset ensureNewPreset() => $_ensure(1);
}

class RenamePresetRequest extends $pb.GeneratedMessage {
  factory RenamePresetRequest({
    PresetId? id,
    $core.String? label,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (label != null) {
      $result.label = label;
    }
    return $result;
  }
  RenamePresetRequest._() : super();
  factory RenamePresetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenamePresetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RenamePresetRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..aOM<PresetId>(1, _omitFieldNames ? '' : 'id', subBuilder: PresetId.create)
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenamePresetRequest clone() => RenamePresetRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenamePresetRequest copyWith(void Function(RenamePresetRequest) updates) => super.copyWith((message) => updates(message as RenamePresetRequest)) as RenamePresetRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RenamePresetRequest create() => RenamePresetRequest._();
  RenamePresetRequest createEmptyInstance() => create();
  static $pb.PbList<RenamePresetRequest> createRepeated() => $pb.PbList<RenamePresetRequest>();
  @$core.pragma('dart2js:noInline')
  static RenamePresetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RenamePresetRequest>(create);
  static RenamePresetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  PresetId get id => $_getN(0);
  @$pb.TagNumber(1)
  set id(PresetId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
  @$pb.TagNumber(1)
  PresetId ensureId() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);
}

class PresetsRequest extends $pb.GeneratedMessage {
  factory PresetsRequest() => create();
  PresetsRequest._() : super();
  factory PresetsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PresetsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PresetsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PresetsRequest clone() => PresetsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PresetsRequest copyWith(void Function(PresetsRequest) updates) => super.copyWith((message) => updates(message as PresetsRequest)) as PresetsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PresetsRequest create() => PresetsRequest._();
  PresetsRequest createEmptyInstance() => create();
  static $pb.PbList<PresetsRequest> createRepeated() => $pb.PbList<PresetsRequest>();
  @$core.pragma('dart2js:noInline')
  static PresetsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PresetsRequest>(create);
  static PresetsRequest? _defaultInstance;
}

class PresetId extends $pb.GeneratedMessage {
  factory PresetId({
    $core.int? id,
    PresetId_PresetType? type,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (type != null) {
      $result.type = type;
    }
    return $result;
  }
  PresetId._() : super();
  factory PresetId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PresetId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PresetId', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..e<PresetId_PresetType>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: PresetId_PresetType.INTENSITY, valueOf: PresetId_PresetType.valueOf, enumValues: PresetId_PresetType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PresetId clone() => PresetId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PresetId copyWith(void Function(PresetId) updates) => super.copyWith((message) => updates(message as PresetId)) as PresetId;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PresetId create() => PresetId._();
  PresetId createEmptyInstance() => create();
  static $pb.PbList<PresetId> createRepeated() => $pb.PbList<PresetId>();
  @$core.pragma('dart2js:noInline')
  static PresetId getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PresetId>(create);
  static PresetId? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  PresetId_PresetType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(PresetId_PresetType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);
}

class Presets extends $pb.GeneratedMessage {
  factory Presets({
    $core.Iterable<Preset>? intensities,
    $core.Iterable<Preset>? shutters,
    $core.Iterable<Preset>? colors,
    $core.Iterable<Preset>? positions,
  }) {
    final $result = create();
    if (intensities != null) {
      $result.intensities.addAll(intensities);
    }
    if (shutters != null) {
      $result.shutters.addAll(shutters);
    }
    if (colors != null) {
      $result.colors.addAll(colors);
    }
    if (positions != null) {
      $result.positions.addAll(positions);
    }
    return $result;
  }
  Presets._() : super();
  factory Presets.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Presets.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Presets', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<Preset>(1, _omitFieldNames ? '' : 'intensities', $pb.PbFieldType.PM, subBuilder: Preset.create)
    ..pc<Preset>(2, _omitFieldNames ? '' : 'shutters', $pb.PbFieldType.PM, subBuilder: Preset.create)
    ..pc<Preset>(3, _omitFieldNames ? '' : 'colors', $pb.PbFieldType.PM, subBuilder: Preset.create)
    ..pc<Preset>(4, _omitFieldNames ? '' : 'positions', $pb.PbFieldType.PM, subBuilder: Preset.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Presets clone() => Presets()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Presets copyWith(void Function(Presets) updates) => super.copyWith((message) => updates(message as Presets)) as Presets;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Presets create() => Presets._();
  Presets createEmptyInstance() => create();
  static $pb.PbList<Presets> createRepeated() => $pb.PbList<Presets>();
  @$core.pragma('dart2js:noInline')
  static Presets getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Presets>(create);
  static Presets? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Preset> get intensities => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<Preset> get shutters => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<Preset> get colors => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<Preset> get positions => $_getList(3);
}

class Preset_Color extends $pb.GeneratedMessage {
  factory Preset_Color({
    $core.double? red,
    $core.double? green,
    $core.double? blue,
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
    return $result;
  }
  Preset_Color._() : super();
  factory Preset_Color.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Preset_Color.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Preset.Color', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'red', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'green', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'blue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Preset_Color clone() => Preset_Color()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Preset_Color copyWith(void Function(Preset_Color) updates) => super.copyWith((message) => updates(message as Preset_Color)) as Preset_Color;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Preset_Color create() => Preset_Color._();
  Preset_Color createEmptyInstance() => create();
  static $pb.PbList<Preset_Color> createRepeated() => $pb.PbList<Preset_Color>();
  @$core.pragma('dart2js:noInline')
  static Preset_Color getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Preset_Color>(create);
  static Preset_Color? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get red => $_getN(0);
  @$pb.TagNumber(1)
  set red($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRed() => $_has(0);
  @$pb.TagNumber(1)
  void clearRed() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get green => $_getN(1);
  @$pb.TagNumber(2)
  set green($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGreen() => $_has(1);
  @$pb.TagNumber(2)
  void clearGreen() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get blue => $_getN(2);
  @$pb.TagNumber(3)
  set blue($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBlue() => $_has(2);
  @$pb.TagNumber(3)
  void clearBlue() => clearField(3);
}

class Preset_Position extends $pb.GeneratedMessage {
  factory Preset_Position({
    $core.double? tilt,
    $core.double? pan,
  }) {
    final $result = create();
    if (tilt != null) {
      $result.tilt = tilt;
    }
    if (pan != null) {
      $result.pan = pan;
    }
    return $result;
  }
  Preset_Position._() : super();
  factory Preset_Position.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Preset_Position.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Preset.Position', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'tilt', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'pan', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Preset_Position clone() => Preset_Position()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Preset_Position copyWith(void Function(Preset_Position) updates) => super.copyWith((message) => updates(message as Preset_Position)) as Preset_Position;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Preset_Position create() => Preset_Position._();
  Preset_Position createEmptyInstance() => create();
  static $pb.PbList<Preset_Position> createRepeated() => $pb.PbList<Preset_Position>();
  @$core.pragma('dart2js:noInline')
  static Preset_Position getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Preset_Position>(create);
  static Preset_Position? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get tilt => $_getN(0);
  @$pb.TagNumber(1)
  set tilt($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTilt() => $_has(0);
  @$pb.TagNumber(1)
  void clearTilt() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get pan => $_getN(1);
  @$pb.TagNumber(2)
  set pan($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPan() => $_has(1);
  @$pb.TagNumber(2)
  void clearPan() => clearField(2);
}

enum Preset_Value {
  fader, 
  color, 
  position, 
  notSet
}

class Preset extends $pb.GeneratedMessage {
  factory Preset({
    PresetId? id,
    $core.String? label,
    $core.double? fader,
    Preset_Color? color,
    Preset_Position? position,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (label != null) {
      $result.label = label;
    }
    if (fader != null) {
      $result.fader = fader;
    }
    if (color != null) {
      $result.color = color;
    }
    if (position != null) {
      $result.position = position;
    }
    return $result;
  }
  Preset._() : super();
  factory Preset.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Preset.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Preset_Value> _Preset_ValueByTag = {
    3 : Preset_Value.fader,
    4 : Preset_Value.color,
    5 : Preset_Value.position,
    0 : Preset_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Preset', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5])
    ..aOM<PresetId>(1, _omitFieldNames ? '' : 'id', subBuilder: PresetId.create)
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'fader', $pb.PbFieldType.OD)
    ..aOM<Preset_Color>(4, _omitFieldNames ? '' : 'color', subBuilder: Preset_Color.create)
    ..aOM<Preset_Position>(5, _omitFieldNames ? '' : 'position', subBuilder: Preset_Position.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Preset clone() => Preset()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Preset copyWith(void Function(Preset) updates) => super.copyWith((message) => updates(message as Preset)) as Preset;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Preset create() => Preset._();
  Preset createEmptyInstance() => create();
  static $pb.PbList<Preset> createRepeated() => $pb.PbList<Preset>();
  @$core.pragma('dart2js:noInline')
  static Preset getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Preset>(create);
  static Preset? _defaultInstance;

  Preset_Value whichValue() => _Preset_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  PresetId get id => $_getN(0);
  @$pb.TagNumber(1)
  set id(PresetId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
  @$pb.TagNumber(1)
  PresetId ensureId() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get fader => $_getN(2);
  @$pb.TagNumber(3)
  set fader($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFader() => $_has(2);
  @$pb.TagNumber(3)
  void clearFader() => clearField(3);

  @$pb.TagNumber(4)
  Preset_Color get color => $_getN(3);
  @$pb.TagNumber(4)
  set color(Preset_Color v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasColor() => $_has(3);
  @$pb.TagNumber(4)
  void clearColor() => clearField(4);
  @$pb.TagNumber(4)
  Preset_Color ensureColor() => $_ensure(3);

  @$pb.TagNumber(5)
  Preset_Position get position => $_getN(4);
  @$pb.TagNumber(5)
  set position(Preset_Position v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPosition() => $_has(4);
  @$pb.TagNumber(5)
  void clearPosition() => clearField(5);
  @$pb.TagNumber(5)
  Preset_Position ensurePosition() => $_ensure(4);
}

class CallPresetResponse extends $pb.GeneratedMessage {
  factory CallPresetResponse() => create();
  CallPresetResponse._() : super();
  factory CallPresetResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CallPresetResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CallPresetResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CallPresetResponse clone() => CallPresetResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CallPresetResponse copyWith(void Function(CallPresetResponse) updates) => super.copyWith((message) => updates(message as CallPresetResponse)) as CallPresetResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CallPresetResponse create() => CallPresetResponse._();
  CallPresetResponse createEmptyInstance() => create();
  static $pb.PbList<CallPresetResponse> createRepeated() => $pb.PbList<CallPresetResponse>();
  @$core.pragma('dart2js:noInline')
  static CallPresetResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CallPresetResponse>(create);
  static CallPresetResponse? _defaultInstance;
}

class GroupsRequest extends $pb.GeneratedMessage {
  factory GroupsRequest() => create();
  GroupsRequest._() : super();
  factory GroupsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GroupsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupsRequest clone() => GroupsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupsRequest copyWith(void Function(GroupsRequest) updates) => super.copyWith((message) => updates(message as GroupsRequest)) as GroupsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GroupsRequest create() => GroupsRequest._();
  GroupsRequest createEmptyInstance() => create();
  static $pb.PbList<GroupsRequest> createRepeated() => $pb.PbList<GroupsRequest>();
  @$core.pragma('dart2js:noInline')
  static GroupsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupsRequest>(create);
  static GroupsRequest? _defaultInstance;
}

class Groups extends $pb.GeneratedMessage {
  factory Groups({
    $core.Iterable<Group>? groups,
  }) {
    final $result = create();
    if (groups != null) {
      $result.groups.addAll(groups);
    }
    return $result;
  }
  Groups._() : super();
  factory Groups.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Groups.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Groups', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<Group>(1, _omitFieldNames ? '' : 'groups', $pb.PbFieldType.PM, subBuilder: Group.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Groups clone() => Groups()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Groups copyWith(void Function(Groups) updates) => super.copyWith((message) => updates(message as Groups)) as Groups;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Groups create() => Groups._();
  Groups createEmptyInstance() => create();
  static $pb.PbList<Groups> createRepeated() => $pb.PbList<Groups>();
  @$core.pragma('dart2js:noInline')
  static Groups getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Groups>(create);
  static Groups? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Group> get groups => $_getList(0);
}

class Group extends $pb.GeneratedMessage {
  factory Group({
    $core.int? id,
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
  Group._() : super();
  factory Group.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Group.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Group', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Group clone() => Group()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Group copyWith(void Function(Group) updates) => super.copyWith((message) => updates(message as Group)) as Group;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Group create() => Group._();
  Group createEmptyInstance() => create();
  static $pb.PbList<Group> createRepeated() => $pb.PbList<Group>();
  @$core.pragma('dart2js:noInline')
  static Group getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Group>(create);
  static Group? _defaultInstance;

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
}

class SelectGroupRequest extends $pb.GeneratedMessage {
  factory SelectGroupRequest({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  SelectGroupRequest._() : super();
  factory SelectGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SelectGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SelectGroupRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SelectGroupRequest clone() => SelectGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SelectGroupRequest copyWith(void Function(SelectGroupRequest) updates) => super.copyWith((message) => updates(message as SelectGroupRequest)) as SelectGroupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SelectGroupRequest create() => SelectGroupRequest._();
  SelectGroupRequest createEmptyInstance() => create();
  static $pb.PbList<SelectGroupRequest> createRepeated() => $pb.PbList<SelectGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static SelectGroupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SelectGroupRequest>(create);
  static SelectGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class SelectGroupResponse extends $pb.GeneratedMessage {
  factory SelectGroupResponse() => create();
  SelectGroupResponse._() : super();
  factory SelectGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SelectGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SelectGroupResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SelectGroupResponse clone() => SelectGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SelectGroupResponse copyWith(void Function(SelectGroupResponse) updates) => super.copyWith((message) => updates(message as SelectGroupResponse)) as SelectGroupResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SelectGroupResponse create() => SelectGroupResponse._();
  SelectGroupResponse createEmptyInstance() => create();
  static $pb.PbList<SelectGroupResponse> createRepeated() => $pb.PbList<SelectGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static SelectGroupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SelectGroupResponse>(create);
  static SelectGroupResponse? _defaultInstance;
}

class AddGroupRequest extends $pb.GeneratedMessage {
  factory AddGroupRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  AddGroupRequest._() : super();
  factory AddGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddGroupRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddGroupRequest clone() => AddGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddGroupRequest copyWith(void Function(AddGroupRequest) updates) => super.copyWith((message) => updates(message as AddGroupRequest)) as AddGroupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddGroupRequest create() => AddGroupRequest._();
  AddGroupRequest createEmptyInstance() => create();
  static $pb.PbList<AddGroupRequest> createRepeated() => $pb.PbList<AddGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static AddGroupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddGroupRequest>(create);
  static AddGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class RenameGroupRequest extends $pb.GeneratedMessage {
  factory RenameGroupRequest({
    $core.int? id,
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
  RenameGroupRequest._() : super();
  factory RenameGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenameGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RenameGroupRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenameGroupRequest clone() => RenameGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenameGroupRequest copyWith(void Function(RenameGroupRequest) updates) => super.copyWith((message) => updates(message as RenameGroupRequest)) as RenameGroupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RenameGroupRequest create() => RenameGroupRequest._();
  RenameGroupRequest createEmptyInstance() => create();
  static $pb.PbList<RenameGroupRequest> createRepeated() => $pb.PbList<RenameGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static RenameGroupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RenameGroupRequest>(create);
  static RenameGroupRequest? _defaultInstance;

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
}

class AssignFixturesToGroupRequest extends $pb.GeneratedMessage {
  factory AssignFixturesToGroupRequest({
    $core.int? id,
    $core.Iterable<$0.FixtureId>? fixtures,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (fixtures != null) {
      $result.fixtures.addAll(fixtures);
    }
    return $result;
  }
  AssignFixturesToGroupRequest._() : super();
  factory AssignFixturesToGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AssignFixturesToGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AssignFixturesToGroupRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..pc<$0.FixtureId>(2, _omitFieldNames ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AssignFixturesToGroupRequest clone() => AssignFixturesToGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AssignFixturesToGroupRequest copyWith(void Function(AssignFixturesToGroupRequest) updates) => super.copyWith((message) => updates(message as AssignFixturesToGroupRequest)) as AssignFixturesToGroupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AssignFixturesToGroupRequest create() => AssignFixturesToGroupRequest._();
  AssignFixturesToGroupRequest createEmptyInstance() => create();
  static $pb.PbList<AssignFixturesToGroupRequest> createRepeated() => $pb.PbList<AssignFixturesToGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static AssignFixturesToGroupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AssignFixturesToGroupRequest>(create);
  static AssignFixturesToGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$0.FixtureId> get fixtures => $_getList(1);
}

class AssignFixtureSelectionToGroupRequest extends $pb.GeneratedMessage {
  factory AssignFixtureSelectionToGroupRequest({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  AssignFixtureSelectionToGroupRequest._() : super();
  factory AssignFixtureSelectionToGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AssignFixtureSelectionToGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AssignFixtureSelectionToGroupRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AssignFixtureSelectionToGroupRequest clone() => AssignFixtureSelectionToGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AssignFixtureSelectionToGroupRequest copyWith(void Function(AssignFixtureSelectionToGroupRequest) updates) => super.copyWith((message) => updates(message as AssignFixtureSelectionToGroupRequest)) as AssignFixtureSelectionToGroupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AssignFixtureSelectionToGroupRequest create() => AssignFixtureSelectionToGroupRequest._();
  AssignFixtureSelectionToGroupRequest createEmptyInstance() => create();
  static $pb.PbList<AssignFixtureSelectionToGroupRequest> createRepeated() => $pb.PbList<AssignFixtureSelectionToGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static AssignFixtureSelectionToGroupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AssignFixtureSelectionToGroupRequest>(create);
  static AssignFixtureSelectionToGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class AssignFixturesToGroupResponse extends $pb.GeneratedMessage {
  factory AssignFixturesToGroupResponse() => create();
  AssignFixturesToGroupResponse._() : super();
  factory AssignFixturesToGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AssignFixturesToGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AssignFixturesToGroupResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AssignFixturesToGroupResponse clone() => AssignFixturesToGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AssignFixturesToGroupResponse copyWith(void Function(AssignFixturesToGroupResponse) updates) => super.copyWith((message) => updates(message as AssignFixturesToGroupResponse)) as AssignFixturesToGroupResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AssignFixturesToGroupResponse create() => AssignFixturesToGroupResponse._();
  AssignFixturesToGroupResponse createEmptyInstance() => create();
  static $pb.PbList<AssignFixturesToGroupResponse> createRepeated() => $pb.PbList<AssignFixturesToGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static AssignFixturesToGroupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AssignFixturesToGroupResponse>(create);
  static AssignFixturesToGroupResponse? _defaultInstance;
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
