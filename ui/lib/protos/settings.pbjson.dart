///
//  Generated code. Do not modify.
//  source: settings.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use requestSettingsDescriptor instead')
const RequestSettings$json = const {
  '1': 'RequestSettings',
};

/// Descriptor for `RequestSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestSettingsDescriptor = $convert.base64Decode('Cg9SZXF1ZXN0U2V0dGluZ3M=');
@$core.Deprecated('Use settingsDescriptor instead')
const Settings$json = const {
  '1': 'Settings',
  '2': const [
    const {'1': 'hotkeys', '3': 1, '4': 1, '5': 11, '6': '.mizer.settings.Hotkeys', '10': 'hotkeys'},
  ],
};

/// Descriptor for `Settings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingsDescriptor = $convert.base64Decode('CghTZXR0aW5ncxIxCgdob3RrZXlzGAEgASgLMhcubWl6ZXIuc2V0dGluZ3MuSG90a2V5c1IHaG90a2V5cw==');
@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys$json = const {
  '1': 'Hotkeys',
  '2': const [
    const {'1': 'global', '3': 1, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.GlobalEntry', '10': 'global'},
    const {'1': 'layouts', '3': 2, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.LayoutsEntry', '10': 'layouts'},
    const {'1': 'programmer', '3': 3, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.ProgrammerEntry', '10': 'programmer'},
    const {'1': 'nodes', '3': 4, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.NodesEntry', '10': 'nodes'},
    const {'1': 'patch', '3': 5, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.PatchEntry', '10': 'patch'},
    const {'1': 'sequencer', '3': 6, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.SequencerEntry', '10': 'sequencer'},
  ],
  '3': const [Hotkeys_GlobalEntry$json, Hotkeys_LayoutsEntry$json, Hotkeys_ProgrammerEntry$json, Hotkeys_NodesEntry$json, Hotkeys_PatchEntry$json, Hotkeys_SequencerEntry$json],
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_GlobalEntry$json = const {
  '1': 'GlobalEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_LayoutsEntry$json = const {
  '1': 'LayoutsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_ProgrammerEntry$json = const {
  '1': 'ProgrammerEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_NodesEntry$json = const {
  '1': 'NodesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_PatchEntry$json = const {
  '1': 'PatchEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_SequencerEntry$json = const {
  '1': 'SequencerEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Hotkeys`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hotkeysDescriptor = $convert.base64Decode('CgdIb3RrZXlzEjsKBmdsb2JhbBgBIAMoCzIjLm1pemVyLnNldHRpbmdzLkhvdGtleXMuR2xvYmFsRW50cnlSBmdsb2JhbBI+CgdsYXlvdXRzGAIgAygLMiQubWl6ZXIuc2V0dGluZ3MuSG90a2V5cy5MYXlvdXRzRW50cnlSB2xheW91dHMSRwoKcHJvZ3JhbW1lchgDIAMoCzInLm1pemVyLnNldHRpbmdzLkhvdGtleXMuUHJvZ3JhbW1lckVudHJ5Ugpwcm9ncmFtbWVyEjgKBW5vZGVzGAQgAygLMiIubWl6ZXIuc2V0dGluZ3MuSG90a2V5cy5Ob2Rlc0VudHJ5UgVub2RlcxI4CgVwYXRjaBgFIAMoCzIiLm1pemVyLnNldHRpbmdzLkhvdGtleXMuUGF0Y2hFbnRyeVIFcGF0Y2gSRAoJc2VxdWVuY2VyGAYgAygLMiYubWl6ZXIuc2V0dGluZ3MuSG90a2V5cy5TZXF1ZW5jZXJFbnRyeVIJc2VxdWVuY2VyGjkKC0dsb2JhbEVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOgoMTGF5b3V0c0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaPQoPUHJvZ3JhbW1lckVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOAoKTm9kZXNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjgKClBhdGNoRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo8Cg5TZXF1ZW5jZXJFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
