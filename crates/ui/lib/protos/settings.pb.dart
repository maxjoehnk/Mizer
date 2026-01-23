///
//  Generated code. Do not modify.
//  source: settings.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Settings extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Settings', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..pc<SettingsCategory>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categories', $pb.PbFieldType.PM, subBuilder: SettingsCategory.create)
    ..aOM<UiSettings>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ui', subBuilder: UiSettings.create)
    ..hasRequiredFields = false
  ;

  Settings._() : super();
  factory Settings({
    $core.Iterable<SettingsCategory>? categories,
    UiSettings? ui,
  }) {
    final _result = create();
    if (categories != null) {
      _result.categories.addAll(categories);
    }
    if (ui != null) {
      _result.ui = ui;
    }
    return _result;
  }
  factory Settings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Settings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Settings clone() => Settings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Settings copyWith(void Function(Settings) updates) => super.copyWith((message) => updates(message as Settings)) as Settings; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Settings create() => Settings._();
  Settings createEmptyInstance() => create();
  static $pb.PbList<Settings> createRepeated() => $pb.PbList<Settings>();
  @$core.pragma('dart2js:noInline')
  static Settings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Settings>(create);
  static Settings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SettingsCategory> get categories => $_getList(0);

  @$pb.TagNumber(2)
  UiSettings get ui => $_getN(1);
  @$pb.TagNumber(2)
  set ui(UiSettings v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUi() => $_has(1);
  @$pb.TagNumber(2)
  void clearUi() => clearField(2);
  @$pb.TagNumber(2)
  UiSettings ensureUi() => $_ensure(1);
}

class UiSettings extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UiSettings', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'language')
    ..m<$core.String, Hotkeys>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hotkeys', entryClassName: 'UiSettings.HotkeysEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: Hotkeys.create, packageName: const $pb.PackageName('mizer.settings'))
    ..hasRequiredFields = false
  ;

  UiSettings._() : super();
  factory UiSettings({
    $core.String? language,
    $core.Map<$core.String, Hotkeys>? hotkeys,
  }) {
    final _result = create();
    if (language != null) {
      _result.language = language;
    }
    if (hotkeys != null) {
      _result.hotkeys.addAll(hotkeys);
    }
    return _result;
  }
  factory UiSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UiSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UiSettings clone() => UiSettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UiSettings copyWith(void Function(UiSettings) updates) => super.copyWith((message) => updates(message as UiSettings)) as UiSettings; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UiSettings create() => UiSettings._();
  UiSettings createEmptyInstance() => create();
  static $pb.PbList<UiSettings> createRepeated() => $pb.PbList<UiSettings>();
  @$core.pragma('dart2js:noInline')
  static UiSettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UiSettings>(create);
  static UiSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get language => $_getSZ(0);
  @$pb.TagNumber(1)
  set language($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLanguage() => $_has(0);
  @$pb.TagNumber(1)
  void clearLanguage() => clearField(1);

  @$pb.TagNumber(2)
  $core.Map<$core.String, Hotkeys> get hotkeys => $_getMap(1);
}

class SettingsCategory extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SettingsCategory', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..pc<SettingsGroup>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groups', $pb.PbFieldType.PM, subBuilder: SettingsGroup.create)
    ..hasRequiredFields = false
  ;

  SettingsCategory._() : super();
  factory SettingsCategory({
    $core.String? title,
    $core.Iterable<SettingsGroup>? groups,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (groups != null) {
      _result.groups.addAll(groups);
    }
    return _result;
  }
  factory SettingsCategory.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SettingsCategory.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SettingsCategory clone() => SettingsCategory()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SettingsCategory copyWith(void Function(SettingsCategory) updates) => super.copyWith((message) => updates(message as SettingsCategory)) as SettingsCategory; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SettingsCategory create() => SettingsCategory._();
  SettingsCategory createEmptyInstance() => create();
  static $pb.PbList<SettingsCategory> createRepeated() => $pb.PbList<SettingsCategory>();
  @$core.pragma('dart2js:noInline')
  static SettingsCategory getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SettingsCategory>(create);
  static SettingsCategory? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<SettingsGroup> get groups => $_getList(1);
}

class SettingsGroup extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SettingsGroup', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..pc<Setting>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settings', $pb.PbFieldType.PM, subBuilder: Setting.create)
    ..hasRequiredFields = false
  ;

  SettingsGroup._() : super();
  factory SettingsGroup({
    $core.String? title,
    $core.Iterable<Setting>? settings,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (settings != null) {
      _result.settings.addAll(settings);
    }
    return _result;
  }
  factory SettingsGroup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SettingsGroup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SettingsGroup clone() => SettingsGroup()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SettingsGroup copyWith(void Function(SettingsGroup) updates) => super.copyWith((message) => updates(message as SettingsGroup)) as SettingsGroup; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SettingsGroup create() => SettingsGroup._();
  SettingsGroup createEmptyInstance() => create();
  static $pb.PbList<SettingsGroup> createRepeated() => $pb.PbList<SettingsGroup>();
  @$core.pragma('dart2js:noInline')
  static SettingsGroup getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SettingsGroup>(create);
  static SettingsGroup? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Setting> get settings => $_getList(1);
}

enum Setting_Value {
  select, 
  boolean, 
  path, 
  pathList, 
  hotkey, 
  notSet
}

class Setting extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Setting_Value> _Setting_ValueByTag = {
    4 : Setting_Value.select,
    5 : Setting_Value.boolean,
    6 : Setting_Value.path,
    7 : Setting_Value.pathList,
    8 : Setting_Value.hotkey,
    0 : Setting_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Setting', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..oo(0, [4, 5, 6, 7, 8])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'defaultValue')
    ..aOM<SelectSetting>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'select', subBuilder: SelectSetting.create)
    ..aOM<BoolSetting>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'boolean', subBuilder: BoolSetting.create)
    ..aOM<PathSetting>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path', subBuilder: PathSetting.create)
    ..aOM<PathListSetting>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pathList', subBuilder: PathListSetting.create)
    ..aOM<HotkeySetting>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hotkey', subBuilder: HotkeySetting.create)
    ..hasRequiredFields = false
  ;

  Setting._() : super();
  factory Setting({
    $core.String? key,
    $core.String? title,
    $core.bool? defaultValue,
    SelectSetting? select,
    BoolSetting? boolean,
    PathSetting? path,
    PathListSetting? pathList,
    HotkeySetting? hotkey,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (title != null) {
      _result.title = title;
    }
    if (defaultValue != null) {
      _result.defaultValue = defaultValue;
    }
    if (select != null) {
      _result.select = select;
    }
    if (boolean != null) {
      _result.boolean = boolean;
    }
    if (path != null) {
      _result.path = path;
    }
    if (pathList != null) {
      _result.pathList = pathList;
    }
    if (hotkey != null) {
      _result.hotkey = hotkey;
    }
    return _result;
  }
  factory Setting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Setting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Setting clone() => Setting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Setting copyWith(void Function(Setting) updates) => super.copyWith((message) => updates(message as Setting)) as Setting; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Setting create() => Setting._();
  Setting createEmptyInstance() => create();
  static $pb.PbList<Setting> createRepeated() => $pb.PbList<Setting>();
  @$core.pragma('dart2js:noInline')
  static Setting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Setting>(create);
  static Setting? _defaultInstance;

  Setting_Value whichValue() => _Setting_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get defaultValue => $_getBF(2);
  @$pb.TagNumber(3)
  set defaultValue($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDefaultValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearDefaultValue() => clearField(3);

  @$pb.TagNumber(4)
  SelectSetting get select => $_getN(3);
  @$pb.TagNumber(4)
  set select(SelectSetting v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSelect() => $_has(3);
  @$pb.TagNumber(4)
  void clearSelect() => clearField(4);
  @$pb.TagNumber(4)
  SelectSetting ensureSelect() => $_ensure(3);

  @$pb.TagNumber(5)
  BoolSetting get boolean => $_getN(4);
  @$pb.TagNumber(5)
  set boolean(BoolSetting v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasBoolean() => $_has(4);
  @$pb.TagNumber(5)
  void clearBoolean() => clearField(5);
  @$pb.TagNumber(5)
  BoolSetting ensureBoolean() => $_ensure(4);

  @$pb.TagNumber(6)
  PathSetting get path => $_getN(5);
  @$pb.TagNumber(6)
  set path(PathSetting v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasPath() => $_has(5);
  @$pb.TagNumber(6)
  void clearPath() => clearField(6);
  @$pb.TagNumber(6)
  PathSetting ensurePath() => $_ensure(5);

  @$pb.TagNumber(7)
  PathListSetting get pathList => $_getN(6);
  @$pb.TagNumber(7)
  set pathList(PathListSetting v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasPathList() => $_has(6);
  @$pb.TagNumber(7)
  void clearPathList() => clearField(7);
  @$pb.TagNumber(7)
  PathListSetting ensurePathList() => $_ensure(6);

  @$pb.TagNumber(8)
  HotkeySetting get hotkey => $_getN(7);
  @$pb.TagNumber(8)
  set hotkey(HotkeySetting v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasHotkey() => $_has(7);
  @$pb.TagNumber(8)
  void clearHotkey() => clearField(8);
  @$pb.TagNumber(8)
  HotkeySetting ensureHotkey() => $_ensure(7);
}

enum UpdateSetting_Value {
  select, 
  boolean, 
  path, 
  pathList, 
  hotkey, 
  notSet
}

class UpdateSetting extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, UpdateSetting_Value> _UpdateSetting_ValueByTag = {
    2 : UpdateSetting_Value.select,
    3 : UpdateSetting_Value.boolean,
    4 : UpdateSetting_Value.path,
    5 : UpdateSetting_Value.pathList,
    6 : UpdateSetting_Value.hotkey,
    0 : UpdateSetting_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateSetting', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5, 6])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'select')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'boolean')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..aOM<PathListSetting>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pathList', subBuilder: PathListSetting.create)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hotkey')
    ..hasRequiredFields = false
  ;

  UpdateSetting._() : super();
  factory UpdateSetting({
    $core.String? key,
    $core.String? select,
    $core.bool? boolean,
    $core.String? path,
    PathListSetting? pathList,
    $core.String? hotkey,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (select != null) {
      _result.select = select;
    }
    if (boolean != null) {
      _result.boolean = boolean;
    }
    if (path != null) {
      _result.path = path;
    }
    if (pathList != null) {
      _result.pathList = pathList;
    }
    if (hotkey != null) {
      _result.hotkey = hotkey;
    }
    return _result;
  }
  factory UpdateSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSetting clone() => UpdateSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSetting copyWith(void Function(UpdateSetting) updates) => super.copyWith((message) => updates(message as UpdateSetting)) as UpdateSetting; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateSetting create() => UpdateSetting._();
  UpdateSetting createEmptyInstance() => create();
  static $pb.PbList<UpdateSetting> createRepeated() => $pb.PbList<UpdateSetting>();
  @$core.pragma('dart2js:noInline')
  static UpdateSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSetting>(create);
  static UpdateSetting? _defaultInstance;

  UpdateSetting_Value whichValue() => _UpdateSetting_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get select => $_getSZ(1);
  @$pb.TagNumber(2)
  set select($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSelect() => $_has(1);
  @$pb.TagNumber(2)
  void clearSelect() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get boolean => $_getBF(2);
  @$pb.TagNumber(3)
  set boolean($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBoolean() => $_has(2);
  @$pb.TagNumber(3)
  void clearBoolean() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get path => $_getSZ(3);
  @$pb.TagNumber(4)
  set path($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPath() => $_has(3);
  @$pb.TagNumber(4)
  void clearPath() => clearField(4);

  @$pb.TagNumber(5)
  PathListSetting get pathList => $_getN(4);
  @$pb.TagNumber(5)
  set pathList(PathListSetting v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPathList() => $_has(4);
  @$pb.TagNumber(5)
  void clearPathList() => clearField(5);
  @$pb.TagNumber(5)
  PathListSetting ensurePathList() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get hotkey => $_getSZ(5);
  @$pb.TagNumber(6)
  set hotkey($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHotkey() => $_has(5);
  @$pb.TagNumber(6)
  void clearHotkey() => clearField(6);
}

class SelectSetting extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SelectSetting', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selected')
    ..pc<SelectOption>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'values', $pb.PbFieldType.PM, subBuilder: SelectOption.create)
    ..hasRequiredFields = false
  ;

  SelectSetting._() : super();
  factory SelectSetting({
    $core.String? selected,
    $core.Iterable<SelectOption>? values,
  }) {
    final _result = create();
    if (selected != null) {
      _result.selected = selected;
    }
    if (values != null) {
      _result.values.addAll(values);
    }
    return _result;
  }
  factory SelectSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SelectSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SelectSetting clone() => SelectSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SelectSetting copyWith(void Function(SelectSetting) updates) => super.copyWith((message) => updates(message as SelectSetting)) as SelectSetting; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SelectSetting create() => SelectSetting._();
  SelectSetting createEmptyInstance() => create();
  static $pb.PbList<SelectSetting> createRepeated() => $pb.PbList<SelectSetting>();
  @$core.pragma('dart2js:noInline')
  static SelectSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SelectSetting>(create);
  static SelectSetting? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get selected => $_getSZ(0);
  @$pb.TagNumber(1)
  set selected($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSelected() => $_has(0);
  @$pb.TagNumber(1)
  void clearSelected() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<SelectOption> get values => $_getList(1);
}

class SelectOption extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SelectOption', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..hasRequiredFields = false
  ;

  SelectOption._() : super();
  factory SelectOption({
    $core.String? value,
    $core.String? title,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (title != null) {
      _result.title = title;
    }
    return _result;
  }
  factory SelectOption.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SelectOption.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SelectOption clone() => SelectOption()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SelectOption copyWith(void Function(SelectOption) updates) => super.copyWith((message) => updates(message as SelectOption)) as SelectOption; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SelectOption create() => SelectOption._();
  SelectOption createEmptyInstance() => create();
  static $pb.PbList<SelectOption> createRepeated() => $pb.PbList<SelectOption>();
  @$core.pragma('dart2js:noInline')
  static SelectOption getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SelectOption>(create);
  static SelectOption? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);
}

class BoolSetting extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BoolSetting', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..hasRequiredFields = false
  ;

  BoolSetting._() : super();
  factory BoolSetting({
    $core.bool? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory BoolSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BoolSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BoolSetting clone() => BoolSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BoolSetting copyWith(void Function(BoolSetting) updates) => super.copyWith((message) => updates(message as BoolSetting)) as BoolSetting; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BoolSetting create() => BoolSetting._();
  BoolSetting createEmptyInstance() => create();
  static $pb.PbList<BoolSetting> createRepeated() => $pb.PbList<BoolSetting>();
  @$core.pragma('dart2js:noInline')
  static BoolSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BoolSetting>(create);
  static BoolSetting? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get value => $_getBF(0);
  @$pb.TagNumber(1)
  set value($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class PathSetting extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PathSetting', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..hasRequiredFields = false
  ;

  PathSetting._() : super();
  factory PathSetting({
    $core.String? path,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    return _result;
  }
  factory PathSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PathSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PathSetting clone() => PathSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PathSetting copyWith(void Function(PathSetting) updates) => super.copyWith((message) => updates(message as PathSetting)) as PathSetting; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PathSetting create() => PathSetting._();
  PathSetting createEmptyInstance() => create();
  static $pb.PbList<PathSetting> createRepeated() => $pb.PbList<PathSetting>();
  @$core.pragma('dart2js:noInline')
  static PathSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PathSetting>(create);
  static PathSetting? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);
}

class PathListSetting extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PathListSetting', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paths')
    ..hasRequiredFields = false
  ;

  PathListSetting._() : super();
  factory PathListSetting({
    $core.Iterable<$core.String>? paths,
  }) {
    final _result = create();
    if (paths != null) {
      _result.paths.addAll(paths);
    }
    return _result;
  }
  factory PathListSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PathListSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PathListSetting clone() => PathListSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PathListSetting copyWith(void Function(PathListSetting) updates) => super.copyWith((message) => updates(message as PathListSetting)) as PathListSetting; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PathListSetting create() => PathListSetting._();
  PathListSetting createEmptyInstance() => create();
  static $pb.PbList<PathListSetting> createRepeated() => $pb.PbList<PathListSetting>();
  @$core.pragma('dart2js:noInline')
  static PathListSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PathListSetting>(create);
  static PathListSetting? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get paths => $_getList(0);
}

class HotkeySetting extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HotkeySetting', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'combination')
    ..hasRequiredFields = false
  ;

  HotkeySetting._() : super();
  factory HotkeySetting({
    $core.String? combination,
  }) {
    final _result = create();
    if (combination != null) {
      _result.combination = combination;
    }
    return _result;
  }
  factory HotkeySetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HotkeySetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HotkeySetting clone() => HotkeySetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HotkeySetting copyWith(void Function(HotkeySetting) updates) => super.copyWith((message) => updates(message as HotkeySetting)) as HotkeySetting; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HotkeySetting create() => HotkeySetting._();
  HotkeySetting createEmptyInstance() => create();
  static $pb.PbList<HotkeySetting> createRepeated() => $pb.PbList<HotkeySetting>();
  @$core.pragma('dart2js:noInline')
  static HotkeySetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HotkeySetting>(create);
  static HotkeySetting? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get combination => $_getSZ(0);
  @$pb.TagNumber(1)
  set combination($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCombination() => $_has(0);
  @$pb.TagNumber(1)
  void clearCombination() => clearField(1);
}

class Hotkeys extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Hotkeys', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..m<$core.String, $core.String>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'keys', entryClassName: 'Hotkeys.KeysEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('mizer.settings'))
    ..hasRequiredFields = false
  ;

  Hotkeys._() : super();
  factory Hotkeys({
    $core.Map<$core.String, $core.String>? keys,
  }) {
    final _result = create();
    if (keys != null) {
      _result.keys.addAll(keys);
    }
    return _result;
  }
  factory Hotkeys.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Hotkeys.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Hotkeys clone() => Hotkeys()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Hotkeys copyWith(void Function(Hotkeys) updates) => super.copyWith((message) => updates(message as Hotkeys)) as Hotkeys; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Hotkeys create() => Hotkeys._();
  Hotkeys createEmptyInstance() => create();
  static $pb.PbList<Hotkeys> createRepeated() => $pb.PbList<Hotkeys>();
  @$core.pragma('dart2js:noInline')
  static Hotkeys getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Hotkeys>(create);
  static Hotkeys? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.String> get keys => $_getMap(0);
}

class MidiDeviceProfiles extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiDeviceProfiles', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..pc<MidiDeviceProfile>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profiles', $pb.PbFieldType.PM, subBuilder: MidiDeviceProfile.create)
    ..hasRequiredFields = false
  ;

  MidiDeviceProfiles._() : super();
  factory MidiDeviceProfiles({
    $core.Iterable<MidiDeviceProfile>? profiles,
  }) {
    final _result = create();
    if (profiles != null) {
      _result.profiles.addAll(profiles);
    }
    return _result;
  }
  factory MidiDeviceProfiles.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfiles.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfiles clone() => MidiDeviceProfiles()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfiles copyWith(void Function(MidiDeviceProfiles) updates) => super.copyWith((message) => updates(message as MidiDeviceProfiles)) as MidiDeviceProfiles; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiDeviceProfile', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'manufacturer')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filePath')
    ..pc<Error>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errors', $pb.PbFieldType.PM, subBuilder: Error.create)
    ..hasRequiredFields = false
  ;

  MidiDeviceProfile._() : super();
  factory MidiDeviceProfile({
    $core.String? id,
    $core.String? manufacturer,
    $core.String? name,
    $core.String? filePath,
    $core.Iterable<Error>? errors,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (manufacturer != null) {
      _result.manufacturer = manufacturer;
    }
    if (name != null) {
      _result.name = name;
    }
    if (filePath != null) {
      _result.filePath = filePath;
    }
    if (errors != null) {
      _result.errors.addAll(errors);
    }
    return _result;
  }
  factory MidiDeviceProfile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiDeviceProfile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile clone() => MidiDeviceProfile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiDeviceProfile copyWith(void Function(MidiDeviceProfile) updates) => super.copyWith((message) => updates(message as MidiDeviceProfile)) as MidiDeviceProfile; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Error', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.settings'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  Error._() : super();
  factory Error({
    $core.String? timestamp,
    $core.String? message,
  }) {
    final _result = create();
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory Error.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Error.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Error clone() => Error()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Error copyWith(void Function(Error) updates) => super.copyWith((message) => updates(message as Error)) as Error; // ignore: deprecated_member_use
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

