///
//  Generated code. Do not modify.
//  source: programmer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'fixtures.pb.dart' as $0;

import 'fixtures.pbenum.dart' as $0;
import 'programmer.pbenum.dart';

export 'programmer.pbenum.dart';

class SubscribeProgrammerRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscribeProgrammerRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
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
  SubscribeProgrammerRequest copyWith(void Function(SubscribeProgrammerRequest) updates) => super.copyWith((message) => updates(message as SubscribeProgrammerRequest)) as SubscribeProgrammerRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeProgrammerRequest create() => SubscribeProgrammerRequest._();
  SubscribeProgrammerRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeProgrammerRequest> createRepeated() => $pb.PbList<SubscribeProgrammerRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeProgrammerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeProgrammerRequest>(create);
  static SubscribeProgrammerRequest? _defaultInstance;
}

class ProgrammerState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProgrammerState', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<$0.FixtureId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..pc<$0.FixtureId>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeFixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..p<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeGroups', $pb.PbFieldType.KU3)
    ..aOM<FixtureSelection>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selection', subBuilder: FixtureSelection.create)
    ..pc<ProgrammerChannel>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controls', $pb.PbFieldType.PM, subBuilder: ProgrammerChannel.create)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'highlight')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blockSize', $pb.PbFieldType.OU3)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groups', $pb.PbFieldType.OU3)
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'wings', $pb.PbFieldType.OU3)
    ..pc<EffectProgrammerState>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effects', $pb.PbFieldType.PM, subBuilder: EffectProgrammerState.create)
    ..hasRequiredFields = false
  ;

  ProgrammerState._() : super();
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
  }) {
    final _result = create();
    if (fixtures != null) {
      _result.fixtures.addAll(fixtures);
    }
    if (activeFixtures != null) {
      _result.activeFixtures.addAll(activeFixtures);
    }
    if (activeGroups != null) {
      _result.activeGroups.addAll(activeGroups);
    }
    if (selection != null) {
      _result.selection = selection;
    }
    if (controls != null) {
      _result.controls.addAll(controls);
    }
    if (highlight != null) {
      _result.highlight = highlight;
    }
    if (blockSize != null) {
      _result.blockSize = blockSize;
    }
    if (groups != null) {
      _result.groups = groups;
    }
    if (wings != null) {
      _result.wings = wings;
    }
    if (effects != null) {
      _result.effects.addAll(effects);
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
  ProgrammerState copyWith(void Function(ProgrammerState) updates) => super.copyWith((message) => updates(message as ProgrammerState)) as ProgrammerState; // ignore: deprecated_member_use
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
}

class FixtureSelection_GroupedFixtureList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureSelection.GroupedFixtureList', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<$0.FixtureId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..hasRequiredFields = false
  ;

  FixtureSelection_GroupedFixtureList._() : super();
  factory FixtureSelection_GroupedFixtureList({
    $core.Iterable<$0.FixtureId>? fixtures,
  }) {
    final _result = create();
    if (fixtures != null) {
      _result.fixtures.addAll(fixtures);
    }
    return _result;
  }
  factory FixtureSelection_GroupedFixtureList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureSelection_GroupedFixtureList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureSelection_GroupedFixtureList clone() => FixtureSelection_GroupedFixtureList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureSelection_GroupedFixtureList copyWith(void Function(FixtureSelection_GroupedFixtureList) updates) => super.copyWith((message) => updates(message as FixtureSelection_GroupedFixtureList)) as FixtureSelection_GroupedFixtureList; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureSelection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<FixtureSelection_GroupedFixtureList>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: FixtureSelection_GroupedFixtureList.create)
    ..hasRequiredFields = false
  ;

  FixtureSelection._() : super();
  factory FixtureSelection({
    $core.Iterable<FixtureSelection_GroupedFixtureList>? fixtures,
  }) {
    final _result = create();
    if (fixtures != null) {
      _result.fixtures.addAll(fixtures);
    }
    return _result;
  }
  factory FixtureSelection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureSelection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureSelection clone() => FixtureSelection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureSelection copyWith(void Function(FixtureSelection) updates) => super.copyWith((message) => updates(message as FixtureSelection)) as FixtureSelection; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProgrammerChannel.GenericValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ProgrammerChannel_GenericValue._() : super();
  factory ProgrammerChannel_GenericValue({
    $core.String? name,
    $core.double? value,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory ProgrammerChannel_GenericValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProgrammerChannel_GenericValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProgrammerChannel_GenericValue clone() => ProgrammerChannel_GenericValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProgrammerChannel_GenericValue copyWith(void Function(ProgrammerChannel_GenericValue) updates) => super.copyWith((message) => updates(message as ProgrammerChannel_GenericValue)) as ProgrammerChannel_GenericValue; // ignore: deprecated_member_use
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
  notSet
}

class ProgrammerChannel extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, ProgrammerChannel_Value> _ProgrammerChannel_ValueByTag = {
    3 : ProgrammerChannel_Value.fader,
    4 : ProgrammerChannel_Value.color,
    5 : ProgrammerChannel_Value.generic,
    0 : ProgrammerChannel_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProgrammerChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5])
    ..pc<$0.FixtureId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..e<$0.FixtureControl>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'control', $pb.PbFieldType.OE, defaultOrMaker: $0.FixtureControl.INTENSITY, valueOf: $0.FixtureControl.valueOf, enumValues: $0.FixtureControl.values)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fader', $pb.PbFieldType.OD)
    ..aOM<$0.ColorMixerChannel>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', subBuilder: $0.ColorMixerChannel.create)
    ..aOM<ProgrammerChannel_GenericValue>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generic', subBuilder: ProgrammerChannel_GenericValue.create)
    ..hasRequiredFields = false
  ;

  ProgrammerChannel._() : super();
  factory ProgrammerChannel({
    $core.Iterable<$0.FixtureId>? fixtures,
    $0.FixtureControl? control,
    $core.double? fader,
    $0.ColorMixerChannel? color,
    ProgrammerChannel_GenericValue? generic,
  }) {
    final _result = create();
    if (fixtures != null) {
      _result.fixtures.addAll(fixtures);
    }
    if (control != null) {
      _result.control = control;
    }
    if (fader != null) {
      _result.fader = fader;
    }
    if (color != null) {
      _result.color = color;
    }
    if (generic != null) {
      _result.generic = generic;
    }
    return _result;
  }
  factory ProgrammerChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProgrammerChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProgrammerChannel clone() => ProgrammerChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProgrammerChannel copyWith(void Function(ProgrammerChannel) updates) => super.copyWith((message) => updates(message as ProgrammerChannel)) as ProgrammerChannel; // ignore: deprecated_member_use
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
}

class EffectProgrammerState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EffectProgrammerState', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effectRate', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effectOffset', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  EffectProgrammerState._() : super();
  factory EffectProgrammerState({
    $core.int? effectId,
    $core.double? effectRate,
    $core.double? effectOffset,
  }) {
    final _result = create();
    if (effectId != null) {
      _result.effectId = effectId;
    }
    if (effectRate != null) {
      _result.effectRate = effectRate;
    }
    if (effectOffset != null) {
      _result.effectOffset = effectOffset;
    }
    return _result;
  }
  factory EffectProgrammerState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EffectProgrammerState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EffectProgrammerState clone() => EffectProgrammerState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EffectProgrammerState copyWith(void Function(EffectProgrammerState) updates) => super.copyWith((message) => updates(message as EffectProgrammerState)) as EffectProgrammerState; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteEffectRateRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effectRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  WriteEffectRateRequest._() : super();
  factory WriteEffectRateRequest({
    $core.int? effectId,
    $core.double? effectRate,
  }) {
    final _result = create();
    if (effectId != null) {
      _result.effectId = effectId;
    }
    if (effectRate != null) {
      _result.effectRate = effectRate;
    }
    return _result;
  }
  factory WriteEffectRateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteEffectRateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteEffectRateRequest clone() => WriteEffectRateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteEffectRateRequest copyWith(void Function(WriteEffectRateRequest) updates) => super.copyWith((message) => updates(message as WriteEffectRateRequest)) as WriteEffectRateRequest; // ignore: deprecated_member_use
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

class WriteEffectRateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteEffectRateResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  WriteEffectRateResponse._() : super();
  factory WriteEffectRateResponse() => create();
  factory WriteEffectRateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteEffectRateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteEffectRateResponse clone() => WriteEffectRateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteEffectRateResponse copyWith(void Function(WriteEffectRateResponse) updates) => super.copyWith((message) => updates(message as WriteEffectRateResponse)) as WriteEffectRateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteEffectRateResponse create() => WriteEffectRateResponse._();
  WriteEffectRateResponse createEmptyInstance() => create();
  static $pb.PbList<WriteEffectRateResponse> createRepeated() => $pb.PbList<WriteEffectRateResponse>();
  @$core.pragma('dart2js:noInline')
  static WriteEffectRateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteEffectRateResponse>(create);
  static WriteEffectRateResponse? _defaultInstance;
}

class WriteEffectOffsetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteEffectOffsetRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effectId', $pb.PbFieldType.OU3)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effectOffset', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  WriteEffectOffsetRequest._() : super();
  factory WriteEffectOffsetRequest({
    $core.int? effectId,
    $core.double? effectOffset,
  }) {
    final _result = create();
    if (effectId != null) {
      _result.effectId = effectId;
    }
    if (effectOffset != null) {
      _result.effectOffset = effectOffset;
    }
    return _result;
  }
  factory WriteEffectOffsetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteEffectOffsetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteEffectOffsetRequest clone() => WriteEffectOffsetRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteEffectOffsetRequest copyWith(void Function(WriteEffectOffsetRequest) updates) => super.copyWith((message) => updates(message as WriteEffectOffsetRequest)) as WriteEffectOffsetRequest; // ignore: deprecated_member_use
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

class WriteEffectOffsetResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteEffectOffsetResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  WriteEffectOffsetResponse._() : super();
  factory WriteEffectOffsetResponse() => create();
  factory WriteEffectOffsetResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteEffectOffsetResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteEffectOffsetResponse clone() => WriteEffectOffsetResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteEffectOffsetResponse copyWith(void Function(WriteEffectOffsetResponse) updates) => super.copyWith((message) => updates(message as WriteEffectOffsetResponse)) as WriteEffectOffsetResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteEffectOffsetResponse create() => WriteEffectOffsetResponse._();
  WriteEffectOffsetResponse createEmptyInstance() => create();
  static $pb.PbList<WriteEffectOffsetResponse> createRepeated() => $pb.PbList<WriteEffectOffsetResponse>();
  @$core.pragma('dart2js:noInline')
  static WriteEffectOffsetResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteEffectOffsetResponse>(create);
  static WriteEffectOffsetResponse? _defaultInstance;
}

class WriteControlRequest_GenericValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteControlRequest.GenericValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  WriteControlRequest_GenericValue._() : super();
  factory WriteControlRequest_GenericValue({
    $core.String? name,
    $core.double? value,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory WriteControlRequest_GenericValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteControlRequest_GenericValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteControlRequest_GenericValue clone() => WriteControlRequest_GenericValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteControlRequest_GenericValue copyWith(void Function(WriteControlRequest_GenericValue) updates) => super.copyWith((message) => updates(message as WriteControlRequest_GenericValue)) as WriteControlRequest_GenericValue; // ignore: deprecated_member_use
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
  static const $core.Map<$core.int, WriteControlRequest_Value> _WriteControlRequest_ValueByTag = {
    2 : WriteControlRequest_Value.fader,
    3 : WriteControlRequest_Value.color,
    4 : WriteControlRequest_Value.generic,
    0 : WriteControlRequest_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteControlRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4])
    ..e<$0.FixtureControl>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'control', $pb.PbFieldType.OE, defaultOrMaker: $0.FixtureControl.INTENSITY, valueOf: $0.FixtureControl.valueOf, enumValues: $0.FixtureControl.values)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fader', $pb.PbFieldType.OD)
    ..aOM<$0.ColorMixerChannel>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', subBuilder: $0.ColorMixerChannel.create)
    ..aOM<WriteControlRequest_GenericValue>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generic', subBuilder: WriteControlRequest_GenericValue.create)
    ..hasRequiredFields = false
  ;

  WriteControlRequest._() : super();
  factory WriteControlRequest({
    $0.FixtureControl? control,
    $core.double? fader,
    $0.ColorMixerChannel? color,
    WriteControlRequest_GenericValue? generic,
  }) {
    final _result = create();
    if (control != null) {
      _result.control = control;
    }
    if (fader != null) {
      _result.fader = fader;
    }
    if (color != null) {
      _result.color = color;
    }
    if (generic != null) {
      _result.generic = generic;
    }
    return _result;
  }
  factory WriteControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteControlRequest clone() => WriteControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteControlRequest copyWith(void Function(WriteControlRequest) updates) => super.copyWith((message) => updates(message as WriteControlRequest)) as WriteControlRequest; // ignore: deprecated_member_use
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

class WriteControlResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteControlResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  WriteControlResponse._() : super();
  factory WriteControlResponse() => create();
  factory WriteControlResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteControlResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteControlResponse clone() => WriteControlResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteControlResponse copyWith(void Function(WriteControlResponse) updates) => super.copyWith((message) => updates(message as WriteControlResponse)) as WriteControlResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteControlResponse create() => WriteControlResponse._();
  WriteControlResponse createEmptyInstance() => create();
  static $pb.PbList<WriteControlResponse> createRepeated() => $pb.PbList<WriteControlResponse>();
  @$core.pragma('dart2js:noInline')
  static WriteControlResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteControlResponse>(create);
  static WriteControlResponse? _defaultInstance;
}

class SelectFixturesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SelectFixturesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<$0.FixtureId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..hasRequiredFields = false
  ;

  SelectFixturesRequest._() : super();
  factory SelectFixturesRequest({
    $core.Iterable<$0.FixtureId>? fixtures,
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
  SelectFixturesRequest copyWith(void Function(SelectFixturesRequest) updates) => super.copyWith((message) => updates(message as SelectFixturesRequest)) as SelectFixturesRequest; // ignore: deprecated_member_use
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

class SelectFixturesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SelectFixturesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
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
  SelectFixturesResponse copyWith(void Function(SelectFixturesResponse) updates) => super.copyWith((message) => updates(message as SelectFixturesResponse)) as SelectFixturesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SelectFixturesResponse create() => SelectFixturesResponse._();
  SelectFixturesResponse createEmptyInstance() => create();
  static $pb.PbList<SelectFixturesResponse> createRepeated() => $pb.PbList<SelectFixturesResponse>();
  @$core.pragma('dart2js:noInline')
  static SelectFixturesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SelectFixturesResponse>(create);
  static SelectFixturesResponse? _defaultInstance;
}

class UnselectFixturesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnselectFixturesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<$0.FixtureId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..hasRequiredFields = false
  ;

  UnselectFixturesRequest._() : super();
  factory UnselectFixturesRequest({
    $core.Iterable<$0.FixtureId>? fixtures,
  }) {
    final _result = create();
    if (fixtures != null) {
      _result.fixtures.addAll(fixtures);
    }
    return _result;
  }
  factory UnselectFixturesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnselectFixturesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnselectFixturesRequest clone() => UnselectFixturesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnselectFixturesRequest copyWith(void Function(UnselectFixturesRequest) updates) => super.copyWith((message) => updates(message as UnselectFixturesRequest)) as UnselectFixturesRequest; // ignore: deprecated_member_use
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

class UnselectFixturesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnselectFixturesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  UnselectFixturesResponse._() : super();
  factory UnselectFixturesResponse() => create();
  factory UnselectFixturesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnselectFixturesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnselectFixturesResponse clone() => UnselectFixturesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnselectFixturesResponse copyWith(void Function(UnselectFixturesResponse) updates) => super.copyWith((message) => updates(message as UnselectFixturesResponse)) as UnselectFixturesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UnselectFixturesResponse create() => UnselectFixturesResponse._();
  UnselectFixturesResponse createEmptyInstance() => create();
  static $pb.PbList<UnselectFixturesResponse> createRepeated() => $pb.PbList<UnselectFixturesResponse>();
  @$core.pragma('dart2js:noInline')
  static UnselectFixturesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnselectFixturesResponse>(create);
  static UnselectFixturesResponse? _defaultInstance;
}

class ClearRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClearRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
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
  ClearRequest copyWith(void Function(ClearRequest) updates) => super.copyWith((message) => updates(message as ClearRequest)) as ClearRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClearRequest create() => ClearRequest._();
  ClearRequest createEmptyInstance() => create();
  static $pb.PbList<ClearRequest> createRepeated() => $pb.PbList<ClearRequest>();
  @$core.pragma('dart2js:noInline')
  static ClearRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClearRequest>(create);
  static ClearRequest? _defaultInstance;
}

class ClearResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClearResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
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
  ClearResponse copyWith(void Function(ClearResponse) updates) => super.copyWith((message) => updates(message as ClearResponse)) as ClearResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClearResponse create() => ClearResponse._();
  ClearResponse createEmptyInstance() => create();
  static $pb.PbList<ClearResponse> createRepeated() => $pb.PbList<ClearResponse>();
  @$core.pragma('dart2js:noInline')
  static ClearResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClearResponse>(create);
  static ClearResponse? _defaultInstance;
}

class HighlightRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HighlightRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'highlight')
    ..hasRequiredFields = false
  ;

  HighlightRequest._() : super();
  factory HighlightRequest({
    $core.bool? highlight,
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
  HighlightRequest copyWith(void Function(HighlightRequest) updates) => super.copyWith((message) => updates(message as HighlightRequest)) as HighlightRequest; // ignore: deprecated_member_use
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

class HighlightResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HighlightResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
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
  HighlightResponse copyWith(void Function(HighlightResponse) updates) => super.copyWith((message) => updates(message as HighlightResponse)) as HighlightResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HighlightResponse create() => HighlightResponse._();
  HighlightResponse createEmptyInstance() => create();
  static $pb.PbList<HighlightResponse> createRepeated() => $pb.PbList<HighlightResponse>();
  @$core.pragma('dart2js:noInline')
  static HighlightResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HighlightResponse>(create);
  static HighlightResponse? _defaultInstance;
}

class StoreRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StoreRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequenceId', $pb.PbFieldType.OU3)
    ..e<StoreRequest_Mode>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'storeMode', $pb.PbFieldType.OE, defaultOrMaker: StoreRequest_Mode.OVERWRITE, valueOf: StoreRequest_Mode.valueOf, enumValues: StoreRequest_Mode.values)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cueId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  StoreRequest._() : super();
  factory StoreRequest({
    $core.int? sequenceId,
    StoreRequest_Mode? storeMode,
    $core.int? cueId,
  }) {
    final _result = create();
    if (sequenceId != null) {
      _result.sequenceId = sequenceId;
    }
    if (storeMode != null) {
      _result.storeMode = storeMode;
    }
    if (cueId != null) {
      _result.cueId = cueId;
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
  StoreRequest copyWith(void Function(StoreRequest) updates) => super.copyWith((message) => updates(message as StoreRequest)) as StoreRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StoreResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
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
  StoreResponse copyWith(void Function(StoreResponse) updates) => super.copyWith((message) => updates(message as StoreResponse)) as StoreResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StoreResponse create() => StoreResponse._();
  StoreResponse createEmptyInstance() => create();
  static $pb.PbList<StoreResponse> createRepeated() => $pb.PbList<StoreResponse>();
  @$core.pragma('dart2js:noInline')
  static StoreResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StoreResponse>(create);
  static StoreResponse? _defaultInstance;
}

class PresetsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PresetsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  PresetsRequest._() : super();
  factory PresetsRequest() => create();
  factory PresetsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PresetsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PresetsRequest clone() => PresetsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PresetsRequest copyWith(void Function(PresetsRequest) updates) => super.copyWith((message) => updates(message as PresetsRequest)) as PresetsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PresetId', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..e<PresetId_PresetType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: PresetId_PresetType.INTENSITY, valueOf: PresetId_PresetType.valueOf, enumValues: PresetId_PresetType.values)
    ..hasRequiredFields = false
  ;

  PresetId._() : super();
  factory PresetId({
    $core.int? id,
    PresetId_PresetType? type,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory PresetId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PresetId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PresetId clone() => PresetId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PresetId copyWith(void Function(PresetId) updates) => super.copyWith((message) => updates(message as PresetId)) as PresetId; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Presets', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<Preset>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'intensities', $pb.PbFieldType.PM, subBuilder: Preset.create)
    ..pc<Preset>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shutters', $pb.PbFieldType.PM, subBuilder: Preset.create)
    ..pc<Preset>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'colors', $pb.PbFieldType.PM, subBuilder: Preset.create)
    ..pc<Preset>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'positions', $pb.PbFieldType.PM, subBuilder: Preset.create)
    ..hasRequiredFields = false
  ;

  Presets._() : super();
  factory Presets({
    $core.Iterable<Preset>? intensities,
    $core.Iterable<Preset>? shutters,
    $core.Iterable<Preset>? colors,
    $core.Iterable<Preset>? positions,
  }) {
    final _result = create();
    if (intensities != null) {
      _result.intensities.addAll(intensities);
    }
    if (shutters != null) {
      _result.shutters.addAll(shutters);
    }
    if (colors != null) {
      _result.colors.addAll(colors);
    }
    if (positions != null) {
      _result.positions.addAll(positions);
    }
    return _result;
  }
  factory Presets.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Presets.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Presets clone() => Presets()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Presets copyWith(void Function(Presets) updates) => super.copyWith((message) => updates(message as Presets)) as Presets; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Preset.Color', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'red', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'green', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Preset_Color._() : super();
  factory Preset_Color({
    $core.double? red,
    $core.double? green,
    $core.double? blue,
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
    return _result;
  }
  factory Preset_Color.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Preset_Color.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Preset_Color clone() => Preset_Color()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Preset_Color copyWith(void Function(Preset_Color) updates) => super.copyWith((message) => updates(message as Preset_Color)) as Preset_Color; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Preset.Position', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tilt', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pan', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Preset_Position._() : super();
  factory Preset_Position({
    $core.double? tilt,
    $core.double? pan,
  }) {
    final _result = create();
    if (tilt != null) {
      _result.tilt = tilt;
    }
    if (pan != null) {
      _result.pan = pan;
    }
    return _result;
  }
  factory Preset_Position.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Preset_Position.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Preset_Position clone() => Preset_Position()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Preset_Position copyWith(void Function(Preset_Position) updates) => super.copyWith((message) => updates(message as Preset_Position)) as Preset_Position; // ignore: deprecated_member_use
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
  static const $core.Map<$core.int, Preset_Value> _Preset_ValueByTag = {
    3 : Preset_Value.fader,
    4 : Preset_Value.color,
    5 : Preset_Value.position,
    0 : Preset_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Preset', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5])
    ..aOM<PresetId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', subBuilder: PresetId.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fader', $pb.PbFieldType.OD)
    ..aOM<Preset_Color>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', subBuilder: Preset_Color.create)
    ..aOM<Preset_Position>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: Preset_Position.create)
    ..hasRequiredFields = false
  ;

  Preset._() : super();
  factory Preset({
    PresetId? id,
    $core.String? label,
    $core.double? fader,
    Preset_Color? color,
    Preset_Position? position,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (label != null) {
      _result.label = label;
    }
    if (fader != null) {
      _result.fader = fader;
    }
    if (color != null) {
      _result.color = color;
    }
    if (position != null) {
      _result.position = position;
    }
    return _result;
  }
  factory Preset.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Preset.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Preset clone() => Preset()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Preset copyWith(void Function(Preset) updates) => super.copyWith((message) => updates(message as Preset)) as Preset; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CallPresetResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  CallPresetResponse._() : super();
  factory CallPresetResponse() => create();
  factory CallPresetResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CallPresetResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CallPresetResponse clone() => CallPresetResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CallPresetResponse copyWith(void Function(CallPresetResponse) updates) => super.copyWith((message) => updates(message as CallPresetResponse)) as CallPresetResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GroupsRequest._() : super();
  factory GroupsRequest() => create();
  factory GroupsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupsRequest clone() => GroupsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupsRequest copyWith(void Function(GroupsRequest) updates) => super.copyWith((message) => updates(message as GroupsRequest)) as GroupsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Groups', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..pc<Group>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groups', $pb.PbFieldType.PM, subBuilder: Group.create)
    ..hasRequiredFields = false
  ;

  Groups._() : super();
  factory Groups({
    $core.Iterable<Group>? groups,
  }) {
    final _result = create();
    if (groups != null) {
      _result.groups.addAll(groups);
    }
    return _result;
  }
  factory Groups.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Groups.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Groups clone() => Groups()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Groups copyWith(void Function(Groups) updates) => super.copyWith((message) => updates(message as Groups)) as Groups; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Group', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  Group._() : super();
  factory Group({
    $core.int? id,
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
  factory Group.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Group.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Group clone() => Group()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Group copyWith(void Function(Group) updates) => super.copyWith((message) => updates(message as Group)) as Group; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SelectGroupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  SelectGroupRequest._() : super();
  factory SelectGroupRequest({
    $core.int? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory SelectGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SelectGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SelectGroupRequest clone() => SelectGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SelectGroupRequest copyWith(void Function(SelectGroupRequest) updates) => super.copyWith((message) => updates(message as SelectGroupRequest)) as SelectGroupRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SelectGroupResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SelectGroupResponse._() : super();
  factory SelectGroupResponse() => create();
  factory SelectGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SelectGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SelectGroupResponse clone() => SelectGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SelectGroupResponse copyWith(void Function(SelectGroupResponse) updates) => super.copyWith((message) => updates(message as SelectGroupResponse)) as SelectGroupResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddGroupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  AddGroupRequest._() : super();
  factory AddGroupRequest({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory AddGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddGroupRequest clone() => AddGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddGroupRequest copyWith(void Function(AddGroupRequest) updates) => super.copyWith((message) => updates(message as AddGroupRequest)) as AddGroupRequest; // ignore: deprecated_member_use
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

class AssignFixturesToGroupRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AssignFixturesToGroupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..pc<$0.FixtureId>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtures', $pb.PbFieldType.PM, subBuilder: $0.FixtureId.create)
    ..hasRequiredFields = false
  ;

  AssignFixturesToGroupRequest._() : super();
  factory AssignFixturesToGroupRequest({
    $core.int? id,
    $core.Iterable<$0.FixtureId>? fixtures,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (fixtures != null) {
      _result.fixtures.addAll(fixtures);
    }
    return _result;
  }
  factory AssignFixturesToGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AssignFixturesToGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AssignFixturesToGroupRequest clone() => AssignFixturesToGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AssignFixturesToGroupRequest copyWith(void Function(AssignFixturesToGroupRequest) updates) => super.copyWith((message) => updates(message as AssignFixturesToGroupRequest)) as AssignFixturesToGroupRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AssignFixtureSelectionToGroupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  AssignFixtureSelectionToGroupRequest._() : super();
  factory AssignFixtureSelectionToGroupRequest({
    $core.int? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory AssignFixtureSelectionToGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AssignFixtureSelectionToGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AssignFixtureSelectionToGroupRequest clone() => AssignFixtureSelectionToGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AssignFixtureSelectionToGroupRequest copyWith(void Function(AssignFixtureSelectionToGroupRequest) updates) => super.copyWith((message) => updates(message as AssignFixtureSelectionToGroupRequest)) as AssignFixtureSelectionToGroupRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AssignFixturesToGroupResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.programmer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  AssignFixturesToGroupResponse._() : super();
  factory AssignFixturesToGroupResponse() => create();
  factory AssignFixturesToGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AssignFixturesToGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AssignFixturesToGroupResponse clone() => AssignFixturesToGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AssignFixturesToGroupResponse copyWith(void Function(AssignFixturesToGroupResponse) updates) => super.copyWith((message) => updates(message as AssignFixturesToGroupResponse)) as AssignFixturesToGroupResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AssignFixturesToGroupResponse create() => AssignFixturesToGroupResponse._();
  AssignFixturesToGroupResponse createEmptyInstance() => create();
  static $pb.PbList<AssignFixturesToGroupResponse> createRepeated() => $pb.PbList<AssignFixturesToGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static AssignFixturesToGroupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AssignFixturesToGroupResponse>(create);
  static AssignFixturesToGroupResponse? _defaultInstance;
}

