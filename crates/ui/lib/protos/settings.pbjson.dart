//
//  Generated code. Do not modify.
//  source: settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use settingsDescriptor instead')
const Settings$json = {
  '1': 'Settings',
  '2': [
    {'1': 'hotkeys', '3': 1, '4': 1, '5': 11, '6': '.mizer.settings.Hotkeys', '10': 'hotkeys'},
    {'1': 'paths', '3': 2, '4': 1, '5': 11, '6': '.mizer.settings.PathSettings', '10': 'paths'},
    {'1': 'general', '3': 3, '4': 1, '5': 11, '6': '.mizer.settings.General', '10': 'general'},
  ],
};

/// Descriptor for `Settings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingsDescriptor = $convert.base64Decode(
    'CghTZXR0aW5ncxIxCgdob3RrZXlzGAEgASgLMhcubWl6ZXIuc2V0dGluZ3MuSG90a2V5c1IHaG'
    '90a2V5cxIyCgVwYXRocxgCIAEoCzIcLm1pemVyLnNldHRpbmdzLlBhdGhTZXR0aW5nc1IFcGF0'
    'aHMSMQoHZ2VuZXJhbBgDIAEoCzIXLm1pemVyLnNldHRpbmdzLkdlbmVyYWxSB2dlbmVyYWw=');

@$core.Deprecated('Use pathSettingsDescriptor instead')
const PathSettings$json = {
  '1': 'PathSettings',
  '2': [
    {'1': 'media_storage', '3': 1, '4': 1, '5': 9, '10': 'mediaStorage'},
    {'1': 'midi_device_profiles', '3': 2, '4': 3, '5': 9, '10': 'midiDeviceProfiles'},
    {'1': 'open_fixture_library', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'openFixtureLibrary', '17': true},
    {'1': 'qlcplus', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'qlcplus', '17': true},
    {'1': 'gdtf', '3': 5, '4': 1, '5': 9, '9': 2, '10': 'gdtf', '17': true},
    {'1': 'mizer', '3': 6, '4': 1, '5': 9, '9': 3, '10': 'mizer', '17': true},
  ],
  '8': [
    {'1': '_open_fixture_library'},
    {'1': '_qlcplus'},
    {'1': '_gdtf'},
    {'1': '_mizer'},
  ],
};

/// Descriptor for `PathSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pathSettingsDescriptor = $convert.base64Decode(
    'CgxQYXRoU2V0dGluZ3MSIwoNbWVkaWFfc3RvcmFnZRgBIAEoCVIMbWVkaWFTdG9yYWdlEjAKFG'
    '1pZGlfZGV2aWNlX3Byb2ZpbGVzGAIgAygJUhJtaWRpRGV2aWNlUHJvZmlsZXMSNQoUb3Blbl9m'
    'aXh0dXJlX2xpYnJhcnkYAyABKAlIAFISb3BlbkZpeHR1cmVMaWJyYXJ5iAEBEh0KB3FsY3BsdX'
    'MYBCABKAlIAVIHcWxjcGx1c4gBARIXCgRnZHRmGAUgASgJSAJSBGdkdGaIAQESGQoFbWl6ZXIY'
    'BiABKAlIA1IFbWl6ZXKIAQFCFwoVX29wZW5fZml4dHVyZV9saWJyYXJ5QgoKCF9xbGNwbHVzQg'
    'cKBV9nZHRmQggKBl9taXplcg==');

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys$json = {
  '1': 'Hotkeys',
  '2': [
    {'1': 'global', '3': 1, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.GlobalEntry', '10': 'global'},
    {'1': 'layouts', '3': 2, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.LayoutsEntry', '10': 'layouts'},
    {'1': 'programmer', '3': 3, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.ProgrammerEntry', '10': 'programmer'},
    {'1': 'nodes', '3': 4, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.NodesEntry', '10': 'nodes'},
    {'1': 'patch', '3': 5, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.PatchEntry', '10': 'patch'},
    {'1': 'sequencer', '3': 6, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.SequencerEntry', '10': 'sequencer'},
    {'1': 'plan', '3': 7, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.PlanEntry', '10': 'plan'},
    {'1': 'effects', '3': 8, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.EffectsEntry', '10': 'effects'},
    {'1': 'media', '3': 9, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.MediaEntry', '10': 'media'},
  ],
  '3': [Hotkeys_GlobalEntry$json, Hotkeys_LayoutsEntry$json, Hotkeys_ProgrammerEntry$json, Hotkeys_NodesEntry$json, Hotkeys_PatchEntry$json, Hotkeys_SequencerEntry$json, Hotkeys_PlanEntry$json, Hotkeys_EffectsEntry$json, Hotkeys_MediaEntry$json],
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_GlobalEntry$json = {
  '1': 'GlobalEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_LayoutsEntry$json = {
  '1': 'LayoutsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_ProgrammerEntry$json = {
  '1': 'ProgrammerEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_NodesEntry$json = {
  '1': 'NodesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_PatchEntry$json = {
  '1': 'PatchEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_SequencerEntry$json = {
  '1': 'SequencerEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_PlanEntry$json = {
  '1': 'PlanEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_EffectsEntry$json = {
  '1': 'EffectsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_MediaEntry$json = {
  '1': 'MediaEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Hotkeys`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hotkeysDescriptor = $convert.base64Decode(
    'CgdIb3RrZXlzEjsKBmdsb2JhbBgBIAMoCzIjLm1pemVyLnNldHRpbmdzLkhvdGtleXMuR2xvYm'
    'FsRW50cnlSBmdsb2JhbBI+CgdsYXlvdXRzGAIgAygLMiQubWl6ZXIuc2V0dGluZ3MuSG90a2V5'
    'cy5MYXlvdXRzRW50cnlSB2xheW91dHMSRwoKcHJvZ3JhbW1lchgDIAMoCzInLm1pemVyLnNldH'
    'RpbmdzLkhvdGtleXMuUHJvZ3JhbW1lckVudHJ5Ugpwcm9ncmFtbWVyEjgKBW5vZGVzGAQgAygL'
    'MiIubWl6ZXIuc2V0dGluZ3MuSG90a2V5cy5Ob2Rlc0VudHJ5UgVub2RlcxI4CgVwYXRjaBgFIA'
    'MoCzIiLm1pemVyLnNldHRpbmdzLkhvdGtleXMuUGF0Y2hFbnRyeVIFcGF0Y2gSRAoJc2VxdWVu'
    'Y2VyGAYgAygLMiYubWl6ZXIuc2V0dGluZ3MuSG90a2V5cy5TZXF1ZW5jZXJFbnRyeVIJc2VxdW'
    'VuY2VyEjUKBHBsYW4YByADKAsyIS5taXplci5zZXR0aW5ncy5Ib3RrZXlzLlBsYW5FbnRyeVIE'
    'cGxhbhI+CgdlZmZlY3RzGAggAygLMiQubWl6ZXIuc2V0dGluZ3MuSG90a2V5cy5FZmZlY3RzRW'
    '50cnlSB2VmZmVjdHMSOAoFbWVkaWEYCSADKAsyIi5taXplci5zZXR0aW5ncy5Ib3RrZXlzLk1l'
    'ZGlhRW50cnlSBW1lZGlhGjkKC0dsb2JhbEVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbH'
    'VlGAIgASgJUgV2YWx1ZToCOAEaOgoMTGF5b3V0c0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQK'
    'BXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaPQoPUHJvZ3JhbW1lckVudHJ5EhAKA2tleRgBIAEoCV'
    'IDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOAoKTm9kZXNFbnRyeRIQCgNrZXkYASAB'
    'KAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjgKClBhdGNoRW50cnkSEAoDa2V5GA'
    'EgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo8Cg5TZXF1ZW5jZXJFbnRyeRIQ'
    'CgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjcKCVBsYW5FbnRyeR'
    'IQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjoKDEVmZmVjdHNF'
    'bnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjgKCk1lZG'
    'lhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use generalDescriptor instead')
const General$json = {
  '1': 'General',
  '2': [
    {'1': 'language', '3': 1, '4': 1, '5': 9, '10': 'language'},
    {'1': 'auto_load_last_project', '3': 2, '4': 1, '5': 8, '10': 'autoLoadLastProject'},
  ],
};

/// Descriptor for `General`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generalDescriptor = $convert.base64Decode(
    'CgdHZW5lcmFsEhoKCGxhbmd1YWdlGAEgASgJUghsYW5ndWFnZRIzChZhdXRvX2xvYWRfbGFzdF'
    '9wcm9qZWN0GAIgASgIUhNhdXRvTG9hZExhc3RQcm9qZWN0');

@$core.Deprecated('Use midiDeviceProfilesDescriptor instead')
const MidiDeviceProfiles$json = {
  '1': 'MidiDeviceProfiles',
  '2': [
    {'1': 'profiles', '3': 1, '4': 3, '5': 11, '6': '.mizer.settings.MidiDeviceProfile', '10': 'profiles'},
  ],
};

/// Descriptor for `MidiDeviceProfiles`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiDeviceProfilesDescriptor = $convert.base64Decode(
    'ChJNaWRpRGV2aWNlUHJvZmlsZXMSPQoIcHJvZmlsZXMYASADKAsyIS5taXplci5zZXR0aW5ncy'
    '5NaWRpRGV2aWNlUHJvZmlsZVIIcHJvZmlsZXM=');

@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile$json = {
  '1': 'MidiDeviceProfile',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'manufacturer', '3': 2, '4': 1, '5': 9, '10': 'manufacturer'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'keyword', '3': 4, '4': 1, '5': 9, '10': 'keyword'},
    {'1': 'file_path', '3': 5, '4': 1, '5': 9, '10': 'filePath'},
    {'1': 'errors', '3': 7, '4': 3, '5': 11, '6': '.mizer.settings.Error', '10': 'errors'},
  ],
};

/// Descriptor for `MidiDeviceProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiDeviceProfileDescriptor = $convert.base64Decode(
    'ChFNaWRpRGV2aWNlUHJvZmlsZRIOCgJpZBgBIAEoCVICaWQSIgoMbWFudWZhY3R1cmVyGAIgAS'
    'gJUgxtYW51ZmFjdHVyZXISEgoEbmFtZRgDIAEoCVIEbmFtZRIYCgdrZXl3b3JkGAQgASgJUgdr'
    'ZXl3b3JkEhsKCWZpbGVfcGF0aBgFIAEoCVIIZmlsZVBhdGgSLQoGZXJyb3JzGAcgAygLMhUubW'
    'l6ZXIuc2V0dGluZ3MuRXJyb3JSBmVycm9ycw==');

@$core.Deprecated('Use errorDescriptor instead')
const Error$json = {
  '1': 'Error',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 9, '10': 'timestamp'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Error`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorDescriptor = $convert.base64Decode(
    'CgVFcnJvchIcCgl0aW1lc3RhbXAYASABKAlSCXRpbWVzdGFtcBIYCgdtZXNzYWdlGAIgASgJUg'
    'dtZXNzYWdl');

