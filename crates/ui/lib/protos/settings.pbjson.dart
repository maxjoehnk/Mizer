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
    const {'1': 'hotkeys', '3': 1, '4': 1, '5': 11, '6': '.mizer.settings.Hotkeys', '10': 'hotkeys'},
    const {'1': 'paths', '3': 2, '4': 1, '5': 11, '6': '.mizer.settings.PathSettings', '10': 'paths'},
    const {'1': 'general', '3': 3, '4': 1, '5': 11, '6': '.mizer.settings.General', '10': 'general'},
  ],
};

/// Descriptor for `Settings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingsDescriptor = $convert.base64Decode('CghTZXR0aW5ncxIxCgdob3RrZXlzGAEgASgLMhcubWl6ZXIuc2V0dGluZ3MuSG90a2V5c1IHaG90a2V5cxIyCgVwYXRocxgCIAEoCzIcLm1pemVyLnNldHRpbmdzLlBhdGhTZXR0aW5nc1IFcGF0aHMSMQoHZ2VuZXJhbBgDIAEoCzIXLm1pemVyLnNldHRpbmdzLkdlbmVyYWxSB2dlbmVyYWw=');
@$core.Deprecated('Use pathSettingsDescriptor instead')
const PathSettings$json = const {
  '1': 'PathSettings',
  '2': const [
    const {'1': 'midi_device_profiles', '3': 1, '4': 1, '5': 9, '10': 'midiDeviceProfiles'},
    const {'1': 'open_fixture_library', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'openFixtureLibrary', '17': true},
    const {'1': 'qlcplus', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'qlcplus', '17': true},
    const {'1': 'gdtf', '3': 4, '4': 1, '5': 9, '9': 2, '10': 'gdtf', '17': true},
    const {'1': 'mizer', '3': 5, '4': 1, '5': 9, '9': 3, '10': 'mizer', '17': true},
  ],
  '8': const [
    const {'1': '_open_fixture_library'},
    const {'1': '_qlcplus'},
    const {'1': '_gdtf'},
    const {'1': '_mizer'},
  ],
};

/// Descriptor for `PathSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pathSettingsDescriptor = $convert.base64Decode('CgxQYXRoU2V0dGluZ3MSMAoUbWlkaV9kZXZpY2VfcHJvZmlsZXMYASABKAlSEm1pZGlEZXZpY2VQcm9maWxlcxI1ChRvcGVuX2ZpeHR1cmVfbGlicmFyeRgCIAEoCUgAUhJvcGVuRml4dHVyZUxpYnJhcnmIAQESHQoHcWxjcGx1cxgDIAEoCUgBUgdxbGNwbHVziAEBEhcKBGdkdGYYBCABKAlIAlIEZ2R0ZogBARIZCgVtaXplchgFIAEoCUgDUgVtaXplcogBAUIXChVfb3Blbl9maXh0dXJlX2xpYnJhcnlCCgoIX3FsY3BsdXNCBwoFX2dkdGZCCAoGX21pemVy');
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
    const {'1': 'plan', '3': 7, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.PlanEntry', '10': 'plan'},
    const {'1': 'effects', '3': 8, '4': 3, '5': 11, '6': '.mizer.settings.Hotkeys.EffectsEntry', '10': 'effects'},
  ],
  '3': const [Hotkeys_GlobalEntry$json, Hotkeys_LayoutsEntry$json, Hotkeys_ProgrammerEntry$json, Hotkeys_NodesEntry$json, Hotkeys_PatchEntry$json, Hotkeys_SequencerEntry$json, Hotkeys_PlanEntry$json, Hotkeys_EffectsEntry$json],
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

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_PlanEntry$json = const {
  '1': 'PlanEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use hotkeysDescriptor instead')
const Hotkeys_EffectsEntry$json = const {
  '1': 'EffectsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `Hotkeys`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hotkeysDescriptor = $convert.base64Decode('CgdIb3RrZXlzEjsKBmdsb2JhbBgBIAMoCzIjLm1pemVyLnNldHRpbmdzLkhvdGtleXMuR2xvYmFsRW50cnlSBmdsb2JhbBI+CgdsYXlvdXRzGAIgAygLMiQubWl6ZXIuc2V0dGluZ3MuSG90a2V5cy5MYXlvdXRzRW50cnlSB2xheW91dHMSRwoKcHJvZ3JhbW1lchgDIAMoCzInLm1pemVyLnNldHRpbmdzLkhvdGtleXMuUHJvZ3JhbW1lckVudHJ5Ugpwcm9ncmFtbWVyEjgKBW5vZGVzGAQgAygLMiIubWl6ZXIuc2V0dGluZ3MuSG90a2V5cy5Ob2Rlc0VudHJ5UgVub2RlcxI4CgVwYXRjaBgFIAMoCzIiLm1pemVyLnNldHRpbmdzLkhvdGtleXMuUGF0Y2hFbnRyeVIFcGF0Y2gSRAoJc2VxdWVuY2VyGAYgAygLMiYubWl6ZXIuc2V0dGluZ3MuSG90a2V5cy5TZXF1ZW5jZXJFbnRyeVIJc2VxdWVuY2VyEjUKBHBsYW4YByADKAsyIS5taXplci5zZXR0aW5ncy5Ib3RrZXlzLlBsYW5FbnRyeVIEcGxhbhI+CgdlZmZlY3RzGAggAygLMiQubWl6ZXIuc2V0dGluZ3MuSG90a2V5cy5FZmZlY3RzRW50cnlSB2VmZmVjdHMaOQoLR2xvYmFsRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo6CgxMYXlvdXRzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo9Cg9Qcm9ncmFtbWVyRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo4CgpOb2Rlc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOAoKUGF0Y2hFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjwKDlNlcXVlbmNlckVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaNwoJUGxhbkVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaOgoMRWZmZWN0c0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use generalDescriptor instead')
const General$json = const {
  '1': 'General',
  '2': const [
    const {'1': 'language', '3': 1, '4': 1, '5': 9, '10': 'language'},
  ],
};

/// Descriptor for `General`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generalDescriptor = $convert.base64Decode('CgdHZW5lcmFsEhoKCGxhbmd1YWdlGAEgASgJUghsYW5ndWFnZQ==');
