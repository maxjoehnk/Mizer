//
//  Generated code. Do not modify.
//  source: settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Settings extends $pb.GeneratedMessage {
  factory Settings({
    Hotkeys? hotkeys,
    PathSettings? paths,
    General? general,
  }) {
    final $result = create();
    if (hotkeys != null) {
      $result.hotkeys = hotkeys;
    }
    if (paths != null) {
      $result.paths = paths;
    }
    if (general != null) {
      $result.general = general;
    }
    return $result;
  }
  Settings._() : super();
  factory Settings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Settings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Settings', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOM<Hotkeys>(1, _omitFieldNames ? '' : 'hotkeys', subBuilder: Hotkeys.create)
    ..aOM<PathSettings>(2, _omitFieldNames ? '' : 'paths', subBuilder: PathSettings.create)
    ..aOM<General>(3, _omitFieldNames ? '' : 'general', subBuilder: General.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Settings clone() => Settings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Settings copyWith(void Function(Settings) updates) => super.copyWith((message) => updates(message as Settings)) as Settings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Settings create() => Settings._();
  Settings createEmptyInstance() => create();
  static $pb.PbList<Settings> createRepeated() => $pb.PbList<Settings>();
  @$core.pragma('dart2js:noInline')
  static Settings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Settings>(create);
  static Settings? _defaultInstance;

  @$pb.TagNumber(1)
  Hotkeys get hotkeys => $_getN(0);
  @$pb.TagNumber(1)
  set hotkeys(Hotkeys v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasHotkeys() => $_has(0);
  @$pb.TagNumber(1)
  void clearHotkeys() => clearField(1);
  @$pb.TagNumber(1)
  Hotkeys ensureHotkeys() => $_ensure(0);

  @$pb.TagNumber(2)
  PathSettings get paths => $_getN(1);
  @$pb.TagNumber(2)
  set paths(PathSettings v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaths() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaths() => clearField(2);
  @$pb.TagNumber(2)
  PathSettings ensurePaths() => $_ensure(1);

  @$pb.TagNumber(3)
  General get general => $_getN(2);
  @$pb.TagNumber(3)
  set general(General v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGeneral() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneral() => clearField(3);
  @$pb.TagNumber(3)
  General ensureGeneral() => $_ensure(2);
}

class PathSettings extends $pb.GeneratedMessage {
  factory PathSettings({
    $core.String? mediaStorage,
    $core.String? midiDeviceProfiles,
    $core.String? openFixtureLibrary,
    $core.String? qlcplus,
    $core.String? gdtf,
    $core.String? mizer,
  }) {
    final $result = create();
    if (mediaStorage != null) {
      $result.mediaStorage = mediaStorage;
    }
    if (midiDeviceProfiles != null) {
      $result.midiDeviceProfiles = midiDeviceProfiles;
    }
    if (openFixtureLibrary != null) {
      $result.openFixtureLibrary = openFixtureLibrary;
    }
    if (qlcplus != null) {
      $result.qlcplus = qlcplus;
    }
    if (gdtf != null) {
      $result.gdtf = gdtf;
    }
    if (mizer != null) {
      $result.mizer = mizer;
    }
    return $result;
  }
  PathSettings._() : super();
  factory PathSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PathSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PathSettings', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'mediaStorage')
    ..aOS(2, _omitFieldNames ? '' : 'midiDeviceProfiles')
    ..aOS(3, _omitFieldNames ? '' : 'openFixtureLibrary')
    ..aOS(4, _omitFieldNames ? '' : 'qlcplus')
    ..aOS(5, _omitFieldNames ? '' : 'gdtf')
    ..aOS(6, _omitFieldNames ? '' : 'mizer')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PathSettings clone() => PathSettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PathSettings copyWith(void Function(PathSettings) updates) => super.copyWith((message) => updates(message as PathSettings)) as PathSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PathSettings create() => PathSettings._();
  PathSettings createEmptyInstance() => create();
  static $pb.PbList<PathSettings> createRepeated() => $pb.PbList<PathSettings>();
  @$core.pragma('dart2js:noInline')
  static PathSettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PathSettings>(create);
  static PathSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mediaStorage => $_getSZ(0);
  @$pb.TagNumber(1)
  set mediaStorage($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMediaStorage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaStorage() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get midiDeviceProfiles => $_getSZ(1);
  @$pb.TagNumber(2)
  set midiDeviceProfiles($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMidiDeviceProfiles() => $_has(1);
  @$pb.TagNumber(2)
  void clearMidiDeviceProfiles() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get openFixtureLibrary => $_getSZ(2);
  @$pb.TagNumber(3)
  set openFixtureLibrary($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOpenFixtureLibrary() => $_has(2);
  @$pb.TagNumber(3)
  void clearOpenFixtureLibrary() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get qlcplus => $_getSZ(3);
  @$pb.TagNumber(4)
  set qlcplus($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasQlcplus() => $_has(3);
  @$pb.TagNumber(4)
  void clearQlcplus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get gdtf => $_getSZ(4);
  @$pb.TagNumber(5)
  set gdtf($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGdtf() => $_has(4);
  @$pb.TagNumber(5)
  void clearGdtf() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get mizer => $_getSZ(5);
  @$pb.TagNumber(6)
  set mizer($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMizer() => $_has(5);
  @$pb.TagNumber(6)
  void clearMizer() => clearField(6);
}

class Hotkeys extends $pb.GeneratedMessage {
  factory Hotkeys({
    $core.Map<$core.String, $core.String>? global,
    $core.Map<$core.String, $core.String>? layouts,
    $core.Map<$core.String, $core.String>? programmer,
    $core.Map<$core.String, $core.String>? nodes,
    $core.Map<$core.String, $core.String>? patch,
    $core.Map<$core.String, $core.String>? sequencer,
    $core.Map<$core.String, $core.String>? plan,
    $core.Map<$core.String, $core.String>? effects,
  }) {
    final $result = create();
    if (global != null) {
      $result.global.addAll(global);
    }
    if (layouts != null) {
      $result.layouts.addAll(layouts);
    }
    if (programmer != null) {
      $result.programmer.addAll(programmer);
    }
    if (nodes != null) {
      $result.nodes.addAll(nodes);
    }
    if (patch != null) {
      $result.patch.addAll(patch);
    }
    if (sequencer != null) {
      $result.sequencer.addAll(sequencer);
    }
    if (plan != null) {
      $result.plan.addAll(plan);
    }
    if (effects != null) {
      $result.effects.addAll(effects);
    }
    return $result;
  }
  Hotkeys._() : super();
  factory Hotkeys.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Hotkeys.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Hotkeys', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..m<$core.String, $core.String>(1, _omitFieldNames ? '' : 'global', entryClassName: 'Hotkeys.GlobalEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('mizer.settings'))
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'layouts', entryClassName: 'Hotkeys.LayoutsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('mizer.settings'))
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'programmer', entryClassName: 'Hotkeys.ProgrammerEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('mizer.settings'))
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'nodes', entryClassName: 'Hotkeys.NodesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('mizer.settings'))
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'patch', entryClassName: 'Hotkeys.PatchEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('mizer.settings'))
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'sequencer', entryClassName: 'Hotkeys.SequencerEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('mizer.settings'))
    ..m<$core.String, $core.String>(7, _omitFieldNames ? '' : 'plan', entryClassName: 'Hotkeys.PlanEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('mizer.settings'))
    ..m<$core.String, $core.String>(8, _omitFieldNames ? '' : 'effects', entryClassName: 'Hotkeys.EffectsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('mizer.settings'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Hotkeys clone() => Hotkeys()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Hotkeys copyWith(void Function(Hotkeys) updates) => super.copyWith((message) => updates(message as Hotkeys)) as Hotkeys;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Hotkeys create() => Hotkeys._();
  Hotkeys createEmptyInstance() => create();
  static $pb.PbList<Hotkeys> createRepeated() => $pb.PbList<Hotkeys>();
  @$core.pragma('dart2js:noInline')
  static Hotkeys getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Hotkeys>(create);
  static Hotkeys? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.String> get global => $_getMap(0);

  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get layouts => $_getMap(1);

  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get programmer => $_getMap(2);

  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.String> get nodes => $_getMap(3);

  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.String> get patch => $_getMap(4);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get sequencer => $_getMap(5);

  @$pb.TagNumber(7)
  $core.Map<$core.String, $core.String> get plan => $_getMap(6);

  @$pb.TagNumber(8)
  $core.Map<$core.String, $core.String> get effects => $_getMap(7);
}

class General extends $pb.GeneratedMessage {
  factory General({
    $core.String? language,
  }) {
    final $result = create();
    if (language != null) {
      $result.language = language;
    }
    return $result;
  }
  General._() : super();
  factory General.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory General.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'General', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'language')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  General clone() => General()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  General copyWith(void Function(General) updates) => super.copyWith((message) => updates(message as General)) as General;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static General create() => General._();
  General createEmptyInstance() => create();
  static $pb.PbList<General> createRepeated() => $pb.PbList<General>();
  @$core.pragma('dart2js:noInline')
  static General getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<General>(create);
  static General? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get language => $_getSZ(0);
  @$pb.TagNumber(1)
  set language($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLanguage() => $_has(0);
  @$pb.TagNumber(1)
  void clearLanguage() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
