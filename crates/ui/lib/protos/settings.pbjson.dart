///
//  Generated code. Do not modify.
//  source: settings.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use settingsDescriptor instead')
const Settings$json = const {
  '1': 'Settings',
  '2': const [
    const {'1': 'categories', '3': 1, '4': 3, '5': 11, '6': '.mizer.settings.SettingsCategory', '10': 'categories'},
    const {'1': 'ui', '3': 2, '4': 1, '5': 11, '6': '.mizer.settings.UiSettings', '10': 'ui'},
  ],
};

/// Descriptor for `Settings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingsDescriptor = $convert.base64Decode('CghTZXR0aW5ncxJACgpjYXRlZ29yaWVzGAEgAygLMiAubWl6ZXIuc2V0dGluZ3MuU2V0dGluZ3NDYXRlZ29yeVIKY2F0ZWdvcmllcxIqCgJ1aRgCIAEoCzIaLm1pemVyLnNldHRpbmdzLlVpU2V0dGluZ3NSAnVp');
@$core.Deprecated('Use uiSettingsDescriptor instead')
const UiSettings$json = const {
  '1': 'UiSettings',
  '2': const [
    const {'1': 'language', '3': 1, '4': 1, '5': 9, '10': 'language'},
    const {'1': 'hotkeys', '3': 2, '4': 3, '5': 11, '6': '.mizer.settings.UiSettings.HotkeysEntry', '10': 'hotkeys'},
  ],
  '3': const [UiSettings_HotkeysEntry$json],
};

@$core.Deprecated('Use uiSettingsDescriptor instead')
const UiSettings_HotkeysEntry$json = const {
  '1': 'HotkeysEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.mizer.settings.Hotkeys', '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `UiSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uiSettingsDescriptor = $convert.base64Decode('CgpVaVNldHRpbmdzEhoKCGxhbmd1YWdlGAEgASgJUghsYW5ndWFnZRJBCgdob3RrZXlzGAIgAygLMicubWl6ZXIuc2V0dGluZ3MuVWlTZXR0aW5ncy5Ib3RrZXlzRW50cnlSB2hvdGtleXMaUwoMSG90a2V5c0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5Ei0KBXZhbHVlGAIgASgLMhcubWl6ZXIuc2V0dGluZ3MuSG90a2V5c1IFdmFsdWU6AjgB');
@$core.Deprecated('Use settingsCategoryDescriptor instead')
const SettingsCategory$json = const {
  '1': 'SettingsCategory',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'groups', '3': 2, '4': 3, '5': 11, '6': '.mizer.settings.SettingsGroup', '10': 'groups'},
  ],
};

/// Descriptor for `SettingsCategory`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingsCategoryDescriptor = $convert.base64Decode('ChBTZXR0aW5nc0NhdGVnb3J5EhQKBXRpdGxlGAEgASgJUgV0aXRsZRI1CgZncm91cHMYAiADKAsyHS5taXplci5zZXR0aW5ncy5TZXR0aW5nc0dyb3VwUgZncm91cHM=');
@$core.Deprecated('Use settingsGroupDescriptor instead')
const SettingsGroup$json = const {
  '1': 'SettingsGroup',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'title', '17': true},
    const {'1': 'settings', '3': 2, '4': 3, '5': 11, '6': '.mizer.settings.Setting', '10': 'settings'},
  ],
  '8': const [
    const {'1': '_title'},
  ],
};

/// Descriptor for `SettingsGroup`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingsGroupDescriptor = $convert.base64Decode('Cg1TZXR0aW5nc0dyb3VwEhkKBXRpdGxlGAEgASgJSABSBXRpdGxliAEBEjMKCHNldHRpbmdzGAIgAygLMhcubWl6ZXIuc2V0dGluZ3MuU2V0dGluZ1IIc2V0dGluZ3NCCAoGX3RpdGxl');
@$core.Deprecated('Use settingDescriptor instead')
const Setting$json = const {
  '1': 'Setting',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'default_value', '3': 3, '4': 1, '5': 8, '10': 'defaultValue'},
    const {'1': 'select', '3': 4, '4': 1, '5': 11, '6': '.mizer.settings.SelectSetting', '9': 0, '10': 'select'},
    const {'1': 'boolean', '3': 5, '4': 1, '5': 11, '6': '.mizer.settings.BoolSetting', '9': 0, '10': 'boolean'},
    const {'1': 'path', '3': 6, '4': 1, '5': 11, '6': '.mizer.settings.PathSetting', '9': 0, '10': 'path'},
    const {'1': 'path_list', '3': 7, '4': 1, '5': 11, '6': '.mizer.settings.PathListSetting', '9': 0, '10': 'pathList'},
    const {'1': 'hotkey', '3': 8, '4': 1, '5': 11, '6': '.mizer.settings.HotkeySetting', '9': 0, '10': 'hotkey'},
  ],
  '8': const [
    const {'1': 'value'},
  ],
};

/// Descriptor for `Setting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingDescriptor = $convert.base64Decode('CgdTZXR0aW5nEhAKA2tleRgBIAEoCVIDa2V5EhQKBXRpdGxlGAIgASgJUgV0aXRsZRIjCg1kZWZhdWx0X3ZhbHVlGAMgASgIUgxkZWZhdWx0VmFsdWUSNwoGc2VsZWN0GAQgASgLMh0ubWl6ZXIuc2V0dGluZ3MuU2VsZWN0U2V0dGluZ0gAUgZzZWxlY3QSNwoHYm9vbGVhbhgFIAEoCzIbLm1pemVyLnNldHRpbmdzLkJvb2xTZXR0aW5nSABSB2Jvb2xlYW4SMQoEcGF0aBgGIAEoCzIbLm1pemVyLnNldHRpbmdzLlBhdGhTZXR0aW5nSABSBHBhdGgSPgoJcGF0aF9saXN0GAcgASgLMh8ubWl6ZXIuc2V0dGluZ3MuUGF0aExpc3RTZXR0aW5nSABSCHBhdGhMaXN0EjcKBmhvdGtleRgIIAEoCzIdLm1pemVyLnNldHRpbmdzLkhvdGtleVNldHRpbmdIAFIGaG90a2V5QgcKBXZhbHVl');
@$core.Deprecated('Use updateSettingDescriptor instead')
const UpdateSetting$json = const {
  '1': 'UpdateSetting',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'select', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'select'},
    const {'1': 'boolean', '3': 3, '4': 1, '5': 8, '9': 0, '10': 'boolean'},
    const {'1': 'path', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'path'},
    const {'1': 'path_list', '3': 5, '4': 1, '5': 11, '6': '.mizer.settings.PathListSetting', '9': 0, '10': 'pathList'},
    const {'1': 'hotkey', '3': 6, '4': 1, '5': 9, '9': 0, '10': 'hotkey'},
  ],
  '8': const [
    const {'1': 'value'},
  ],
};

/// Descriptor for `UpdateSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSettingDescriptor = $convert.base64Decode('Cg1VcGRhdGVTZXR0aW5nEhAKA2tleRgBIAEoCVIDa2V5EhgKBnNlbGVjdBgCIAEoCUgAUgZzZWxlY3QSGgoHYm9vbGVhbhgDIAEoCEgAUgdib29sZWFuEhQKBHBhdGgYBCABKAlIAFIEcGF0aBI+CglwYXRoX2xpc3QYBSABKAsyHy5taXplci5zZXR0aW5ncy5QYXRoTGlzdFNldHRpbmdIAFIIcGF0aExpc3QSGAoGaG90a2V5GAYgASgJSABSBmhvdGtleUIHCgV2YWx1ZQ==');
@$core.Deprecated('Use selectSettingDescriptor instead')
const SelectSetting$json = const {
  '1': 'SelectSetting',
  '2': const [
    const {'1': 'selected', '3': 1, '4': 1, '5': 9, '10': 'selected'},
    const {'1': 'values', '3': 2, '4': 3, '5': 11, '6': '.mizer.settings.SelectOption', '10': 'values'},
  ],
};

/// Descriptor for `SelectSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectSettingDescriptor = $convert.base64Decode('Cg1TZWxlY3RTZXR0aW5nEhoKCHNlbGVjdGVkGAEgASgJUghzZWxlY3RlZBI0CgZ2YWx1ZXMYAiADKAsyHC5taXplci5zZXR0aW5ncy5TZWxlY3RPcHRpb25SBnZhbHVlcw==');
@$core.Deprecated('Use selectOptionDescriptor instead')
const SelectOption$json = const {
  '1': 'SelectOption',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
  ],
};

/// Descriptor for `SelectOption`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectOptionDescriptor = $convert.base64Decode('CgxTZWxlY3RPcHRpb24SFAoFdmFsdWUYASABKAlSBXZhbHVlEhQKBXRpdGxlGAIgASgJUgV0aXRsZQ==');
@$core.Deprecated('Use boolSettingDescriptor instead')
const BoolSetting$json = const {
  '1': 'BoolSetting',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 8, '10': 'value'},
  ],
};

/// Descriptor for `BoolSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List boolSettingDescriptor = $convert.base64Decode('CgtCb29sU2V0dGluZxIUCgV2YWx1ZRgBIAEoCFIFdmFsdWU=');
@$core.Deprecated('Use pathSettingDescriptor instead')
const PathSetting$json = const {
  '1': 'PathSetting',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `PathSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pathSettingDescriptor = $convert.base64Decode('CgtQYXRoU2V0dGluZxISCgRwYXRoGAEgASgJUgRwYXRo');
@$core.Deprecated('Use pathListSettingDescriptor instead')
const PathListSetting$json = const {
  '1': 'PathListSetting',
  '2': const [
    const {'1': 'paths', '3': 1, '4': 3, '5': 9, '10': 'paths'},
  ],
};

/// Descriptor for `PathListSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pathListSettingDescriptor = $convert.base64Decode('Cg9QYXRoTGlzdFNldHRpbmcSFAoFcGF0aHMYASADKAlSBXBhdGhz');
@$core.Deprecated('Use hotkeySettingDescriptor instead')
const HotkeySetting$json = const {
  '1': 'HotkeySetting',
  '2': const [
    const {'1': 'combination', '3': 1, '4': 1, '5': 9, '10': 'combination'},
  ],
};

/// Descriptor for `HotkeySetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hotkeySettingDescriptor = $convert.base64Decode('Cg1Ib3RrZXlTZXR0aW5nEiAKC2NvbWJpbmF0aW9uGAEgASgJUgtjb21iaW5hdGlvbg==');
@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys$json = const {
  '1': 'Hotkeys',
  '2': const [
    const {'1': 'keys', '3': 1, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.KeysEntry', '10': 'keys'},
  ],
  '3': const [Hotkeys_KeysEntry$json],
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_KeysEntry$json = const {
  '1': 'KeysEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Hotkeys`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hotkeysDescriptor = $convert.base64Decode('CgdIb3RrZXlzEjUKBGtleXMYASADKAsyIS5taXplci5zZXR0aW5ncy5Ib3RrZXlzLktleXNFbnRyeVIEa2V5cxo3CglLZXlzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use midiDeviceProfilesDescriptor instead')
const MidiDeviceProfiles$json = const {
  '1': 'MidiDeviceProfiles',
  '2': const [
    const {'1': 'profiles', '3': 1, '4': 3, '5': 11, '6': '.mizer.settings.MidiDeviceProfile', '10': 'profiles'},
  ],
};

/// Descriptor for `MidiDeviceProfiles`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiDeviceProfilesDescriptor = $convert.base64Decode('ChJNaWRpRGV2aWNlUHJvZmlsZXMSPQoIcHJvZmlsZXMYASADKAsyIS5taXplci5zZXR0aW5ncy5NaWRpRGV2aWNlUHJvZmlsZVIIcHJvZmlsZXM=');
@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile$json = const {
  '1': 'MidiDeviceProfile',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'manufacturer', '3': 2, '4': 1, '5': 9, '10': 'manufacturer'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'file_path', '3': 4, '4': 1, '5': 9, '10': 'filePath'},
    const {'1': 'errors', '3': 5, '4': 3, '5': 11, '6': '.mizer.settings.Error', '10': 'errors'},
  ],
};

/// Descriptor for `MidiDeviceProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiDeviceProfileDescriptor = $convert.base64Decode('ChFNaWRpRGV2aWNlUHJvZmlsZRIOCgJpZBgBIAEoCVICaWQSIgoMbWFudWZhY3R1cmVyGAIgASgJUgxtYW51ZmFjdHVyZXISEgoEbmFtZRgDIAEoCVIEbmFtZRIbCglmaWxlX3BhdGgYBCABKAlSCGZpbGVQYXRoEi0KBmVycm9ycxgFIAMoCzIVLm1pemVyLnNldHRpbmdzLkVycm9yUgZlcnJvcnM=');
@$core.Deprecated('Use errorDescriptor instead')
const Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'timestamp', '3': 1, '4': 1, '5': 9, '10': 'timestamp'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Error`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorDescriptor = $convert.base64Decode('CgVFcnJvchIcCgl0aW1lc3RhbXAYASABKAlSCXRpbWVzdGFtcBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
