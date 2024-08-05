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
    $core.Iterable<$core.String>? midiDeviceProfiles,
    $core.Iterable<$core.String>? openFixtureLibrary,
    $core.Iterable<$core.String>? qlcplus,
    $core.Iterable<$core.String>? gdtf,
    $core.Iterable<$core.String>? mizer,
  }) {
    final $result = create();
    if (mediaStorage != null) {
      $result.mediaStorage = mediaStorage;
    }
    if (midiDeviceProfiles != null) {
      $result.midiDeviceProfiles.addAll(midiDeviceProfiles);
    }
    if (openFixtureLibrary != null) {
      $result.openFixtureLibrary.addAll(openFixtureLibrary);
    }
    if (qlcplus != null) {
      $result.qlcplus.addAll(qlcplus);
    }
    if (gdtf != null) {
      $result.gdtf.addAll(gdtf);
    }
    if (mizer != null) {
      $result.mizer.addAll(mizer);
    }
    return $result;
  }
  PathSettings._() : super();
  factory PathSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PathSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PathSettings', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'mediaStorage')
    ..pPS(2, _omitFieldNames ? '' : 'midiDeviceProfiles')
    ..pPS(3, _omitFieldNames ? '' : 'openFixtureLibrary')
    ..pPS(4, _omitFieldNames ? '' : 'qlcplus')
    ..pPS(5, _omitFieldNames ? '' : 'gdtf')
    ..pPS(6, _omitFieldNames ? '' : 'mizer')
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
  $core.List<$core.String> get midiDeviceProfiles => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.String> get openFixtureLibrary => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$core.String> get qlcplus => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<$core.String> get gdtf => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<$core.String> get mizer => $_getList(5);
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
    $core.Map<$core.String, $core.String>? media,
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
    if (media != null) {
      $result.media.addAll(media);
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
    ..m<$core.String, $core.String>(9, _omitFieldNames ? '' : 'media', entryClassName: 'Hotkeys.MediaEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('mizer.settings'))
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

  @$pb.TagNumber(9)
  $core.Map<$core.String, $core.String> get media => $_getMap(8);
}

class General extends $pb.GeneratedMessage {
  factory General({
    $core.String? language,
    $core.bool? autoLoadLastProject,
  }) {
    final $result = create();
    if (language != null) {
      $result.language = language;
    }
    if (autoLoadLastProject != null) {
      $result.autoLoadLastProject = autoLoadLastProject;
    }
    return $result;
  }
  General._() : super();
  factory General.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory General.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'General', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'language')
    ..aOB(2, _omitFieldNames ? '' : 'autoLoadLastProject')
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

  @$pb.TagNumber(2)
  $core.bool get autoLoadLastProject => $_getBF(1);
  @$pb.TagNumber(2)
  set autoLoadLastProject($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAutoLoadLastProject() => $_has(1);
  @$pb.TagNumber(2)
  void clearAutoLoadLastProject() => clearField(2);
}

class MidiDeviceProfiles extends $pb.GeneratedMessage {
  factory MidiDeviceProfiles({
    $core.Iterable<MidiDeviceProfile>? profiles,
  }) {
    final $result = create();
    if (profiles != null) {
      $result.profiles.addAll(profiles);
    }
    return $result;
  }
  MidiDeviceProfiles._() : super();
  factory MidiDeviceProfiles.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfiles.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MidiDeviceProfiles', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..pc<MidiDeviceProfile>(1, _omitFieldNames ? '' : 'profiles', $pb.PbFieldType.PM, subBuilder: MidiDeviceProfile.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfiles clone() => MidiDeviceProfiles()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfiles copyWith(void Function(MidiDeviceProfiles) updates) => super.copyWith((message) => updates(message as MidiDeviceProfiles)) as MidiDeviceProfiles;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfiles create() => MidiDeviceProfiles._();
  MidiDeviceProfiles createEmptyInstance() => create();
  static $pb.PbList<MidiDeviceProfiles> createRepeated() => $pb.PbList<MidiDeviceProfiles>();
  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfiles getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiDeviceProfiles>(create);
  static MidiDeviceProfiles? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MidiDeviceProfile> get profiles => $_getList(0);
}

class MidiDeviceProfile extends $pb.GeneratedMessage {
  factory MidiDeviceProfile({
    $core.String? id,
    $core.String? manufacturer,
    $core.String? name,
    $core.String? filePath,
    $core.Iterable<Error>? errors,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (manufacturer != null) {
      $result.manufacturer = manufacturer;
    }
    if (name != null) {
      $result.name = name;
    }
    if (filePath != null) {
      $result.filePath = filePath;
    }
    if (errors != null) {
      $result.errors.addAll(errors);
    }
    return $result;
  }
  MidiDeviceProfile._() : super();
  factory MidiDeviceProfile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MidiDeviceProfile', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'manufacturer')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'filePath')
    ..pc<Error>(5, _omitFieldNames ? '' : 'errors', $pb.PbFieldType.PM, subBuilder: Error.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile clone() => MidiDeviceProfile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile copyWith(void Function(MidiDeviceProfile) updates) => super.copyWith((message) => updates(message as MidiDeviceProfile)) as MidiDeviceProfile;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfile create() => MidiDeviceProfile._();
  MidiDeviceProfile createEmptyInstance() => create();
  static $pb.PbList<MidiDeviceProfile> createRepeated() => $pb.PbList<MidiDeviceProfile>();
  @$core.pragma('dart2js:noInline')
  static MidiDeviceProfile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiDeviceProfile>(create);
  static MidiDeviceProfile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get manufacturer => $_getSZ(1);
  @$pb.TagNumber(2)
  set manufacturer($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasManufacturer() => $_has(1);
  @$pb.TagNumber(2)
  void clearManufacturer() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get filePath => $_getSZ(3);
  @$pb.TagNumber(4)
  set filePath($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFilePath() => $_has(3);
  @$pb.TagNumber(4)
  void clearFilePath() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<Error> get errors => $_getList(4);
}

class Error extends $pb.GeneratedMessage {
  factory Error({
    $core.String? timestamp,
    $core.String? message,
  }) {
    final $result = create();
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  Error._() : super();
  factory Error.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Error.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Error', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'timestamp')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Error clone() => Error()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Error copyWith(void Function(Error) updates) => super.copyWith((message) => updates(message as Error)) as Error;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Error create() => Error._();
  Error createEmptyInstance() => create();
  static $pb.PbList<Error> createRepeated() => $pb.PbList<Error>();
  @$core.pragma('dart2js:noInline')
  static Error getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Error>(create);
  static Error? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get timestamp => $_getSZ(0);
  @$pb.TagNumber(1)
  set timestamp($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
