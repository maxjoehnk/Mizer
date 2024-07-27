//
//  Generated code. Do not modify.
//  source: programmer.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use presetTargetDescriptor instead')
const PresetTarget$json = {
  '1': 'PresetTarget',
  '2': [
    {'1': 'PRESET_TARGET_UNIVERSAL', '2': 0},
    {'1': 'PRESET_TARGET_SELECTIVE', '2': 1},
  ],
};

/// Descriptor for `PresetTarget`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List presetTargetDescriptor = $convert.base64Decode(
    'CgxQcmVzZXRUYXJnZXQSGwoXUFJFU0VUX1RBUkdFVF9VTklWRVJTQUwQABIbChdQUkVTRVRfVE'
    'FSR0VUX1NFTEVDVElWRRAB');

@$core.Deprecated('Use programmerStateDescriptor instead')
const ProgrammerState$json = {
  '1': 'ProgrammerState',
  '2': [
    {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
    {'1': 'active_fixtures', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'activeFixtures'},
    {'1': 'active_groups', '3': 3, '4': 3, '5': 13, '10': 'activeGroups'},
    {'1': 'selection', '3': 4, '4': 1, '5': 11, '6': '.mizer.programmer.FixtureSelection', '10': 'selection'},
    {'1': 'controls', '3': 5, '4': 3, '5': 11, '6': '.mizer.programmer.ProgrammerChannel', '10': 'controls'},
    {'1': 'highlight', '3': 6, '4': 1, '5': 8, '10': 'highlight'},
    {'1': 'block_size', '3': 7, '4': 1, '5': 13, '10': 'blockSize'},
    {'1': 'groups', '3': 8, '4': 1, '5': 13, '10': 'groups'},
    {'1': 'wings', '3': 9, '4': 1, '5': 13, '10': 'wings'},
    {'1': 'effects', '3': 10, '4': 3, '5': 11, '6': '.mizer.programmer.EffectProgrammerState', '10': 'effects'},
    {'1': 'offline', '3': 11, '4': 1, '5': 8, '10': 'offline'},
  ],
};

/// Descriptor for `ProgrammerState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List programmerStateDescriptor = $convert.base64Decode(
    'Cg9Qcm9ncmFtbWVyU3RhdGUSNQoIZml4dHVyZXMYASADKAsyGS5taXplci5maXh0dXJlcy5GaX'
    'h0dXJlSWRSCGZpeHR1cmVzEkIKD2FjdGl2ZV9maXh0dXJlcxgCIAMoCzIZLm1pemVyLmZpeHR1'
    'cmVzLkZpeHR1cmVJZFIOYWN0aXZlRml4dHVyZXMSIwoNYWN0aXZlX2dyb3VwcxgDIAMoDVIMYW'
    'N0aXZlR3JvdXBzEkAKCXNlbGVjdGlvbhgEIAEoCzIiLm1pemVyLnByb2dyYW1tZXIuRml4dHVy'
    'ZVNlbGVjdGlvblIJc2VsZWN0aW9uEj8KCGNvbnRyb2xzGAUgAygLMiMubWl6ZXIucHJvZ3JhbW'
    '1lci5Qcm9ncmFtbWVyQ2hhbm5lbFIIY29udHJvbHMSHAoJaGlnaGxpZ2h0GAYgASgIUgloaWdo'
    'bGlnaHQSHQoKYmxvY2tfc2l6ZRgHIAEoDVIJYmxvY2tTaXplEhYKBmdyb3VwcxgIIAEoDVIGZ3'
    'JvdXBzEhQKBXdpbmdzGAkgASgNUgV3aW5ncxJBCgdlZmZlY3RzGAogAygLMicubWl6ZXIucHJv'
    'Z3JhbW1lci5FZmZlY3RQcm9ncmFtbWVyU3RhdGVSB2VmZmVjdHMSGAoHb2ZmbGluZRgLIAEoCF'
    'IHb2ZmbGluZQ==');

@$core.Deprecated('Use fixtureSelectionDescriptor instead')
const FixtureSelection$json = {
  '1': 'FixtureSelection',
  '2': [
    {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.programmer.FixtureSelection.GroupedFixtureList', '10': 'fixtures'},
  ],
  '3': [FixtureSelection_GroupedFixtureList$json],
};

@$core.Deprecated('Use fixtureSelectionDescriptor instead')
const FixtureSelection_GroupedFixtureList$json = {
  '1': 'GroupedFixtureList',
  '2': [
    {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
  ],
};

/// Descriptor for `FixtureSelection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureSelectionDescriptor = $convert.base64Decode(
    'ChBGaXh0dXJlU2VsZWN0aW9uElEKCGZpeHR1cmVzGAEgAygLMjUubWl6ZXIucHJvZ3JhbW1lci'
    '5GaXh0dXJlU2VsZWN0aW9uLkdyb3VwZWRGaXh0dXJlTGlzdFIIZml4dHVyZXMaSwoSR3JvdXBl'
    'ZEZpeHR1cmVMaXN0EjUKCGZpeHR1cmVzGAEgAygLMhkubWl6ZXIuZml4dHVyZXMuRml4dHVyZU'
    'lkUghmaXh0dXJlcw==');

@$core.Deprecated('Use programmerChannelDescriptor instead')
const ProgrammerChannel$json = {
  '1': 'ProgrammerChannel',
  '2': [
    {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
    {'1': 'control', '3': 2, '4': 1, '5': 14, '6': '.mizer.fixtures.FixtureControl', '10': 'control'},
    {'1': 'fader', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'fader'},
    {'1': 'color', '3': 4, '4': 1, '5': 11, '6': '.mizer.fixtures.ColorMixerChannel', '9': 0, '10': 'color'},
    {'1': 'generic', '3': 5, '4': 1, '5': 11, '6': '.mizer.programmer.ProgrammerChannel.GenericValue', '9': 0, '10': 'generic'},
    {'1': 'preset', '3': 6, '4': 1, '5': 11, '6': '.mizer.programmer.PresetId', '9': 0, '10': 'preset'},
  ],
  '3': [ProgrammerChannel_GenericValue$json],
  '4': [ProgrammerChannel_ColorChannel$json],
  '8': [
    {'1': 'value'},
  ],
};

@$core.Deprecated('Use programmerChannelDescriptor instead')
const ProgrammerChannel_GenericValue$json = {
  '1': 'GenericValue',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

@$core.Deprecated('Use programmerChannelDescriptor instead')
const ProgrammerChannel_ColorChannel$json = {
  '1': 'ColorChannel',
  '2': [
    {'1': 'RED', '2': 0},
    {'1': 'GREEN', '2': 1},
    {'1': 'BLUE', '2': 2},
  ],
};

/// Descriptor for `ProgrammerChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List programmerChannelDescriptor = $convert.base64Decode(
    'ChFQcm9ncmFtbWVyQ2hhbm5lbBI1CghmaXh0dXJlcxgBIAMoCzIZLm1pemVyLmZpeHR1cmVzLk'
    'ZpeHR1cmVJZFIIZml4dHVyZXMSOAoHY29udHJvbBgCIAEoDjIeLm1pemVyLmZpeHR1cmVzLkZp'
    'eHR1cmVDb250cm9sUgdjb250cm9sEhYKBWZhZGVyGAMgASgBSABSBWZhZGVyEjkKBWNvbG9yGA'
    'QgASgLMiEubWl6ZXIuZml4dHVyZXMuQ29sb3JNaXhlckNoYW5uZWxIAFIFY29sb3ISTAoHZ2Vu'
    'ZXJpYxgFIAEoCzIwLm1pemVyLnByb2dyYW1tZXIuUHJvZ3JhbW1lckNoYW5uZWwuR2VuZXJpY1'
    'ZhbHVlSABSB2dlbmVyaWMSNAoGcHJlc2V0GAYgASgLMhoubWl6ZXIucHJvZ3JhbW1lci5QcmVz'
    'ZXRJZEgAUgZwcmVzZXQaOAoMR2VuZXJpY1ZhbHVlEhIKBG5hbWUYASABKAlSBG5hbWUSFAoFdm'
    'FsdWUYAiABKAFSBXZhbHVlIiwKDENvbG9yQ2hhbm5lbBIHCgNSRUQQABIJCgVHUkVFThABEggK'
    'BEJMVUUQAkIHCgV2YWx1ZQ==');

@$core.Deprecated('Use effectProgrammerStateDescriptor instead')
const EffectProgrammerState$json = {
  '1': 'EffectProgrammerState',
  '2': [
    {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    {'1': 'effect_rate', '3': 2, '4': 1, '5': 1, '10': 'effectRate'},
    {'1': 'effect_offset', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'effectOffset', '17': true},
  ],
  '8': [
    {'1': '_effect_offset'},
  ],
};

/// Descriptor for `EffectProgrammerState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List effectProgrammerStateDescriptor = $convert.base64Decode(
    'ChVFZmZlY3RQcm9ncmFtbWVyU3RhdGUSGwoJZWZmZWN0X2lkGAEgASgNUghlZmZlY3RJZBIfCg'
    'tlZmZlY3RfcmF0ZRgCIAEoAVIKZWZmZWN0UmF0ZRIoCg1lZmZlY3Rfb2Zmc2V0GAMgASgBSABS'
    'DGVmZmVjdE9mZnNldIgBAUIQCg5fZWZmZWN0X29mZnNldA==');

@$core.Deprecated('Use writeEffectRateRequestDescriptor instead')
const WriteEffectRateRequest$json = {
  '1': 'WriteEffectRateRequest',
  '2': [
    {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    {'1': 'effect_rate', '3': 2, '4': 1, '5': 1, '10': 'effectRate'},
  ],
};

/// Descriptor for `WriteEffectRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeEffectRateRequestDescriptor = $convert.base64Decode(
    'ChZXcml0ZUVmZmVjdFJhdGVSZXF1ZXN0EhsKCWVmZmVjdF9pZBgBIAEoDVIIZWZmZWN0SWQSHw'
    'oLZWZmZWN0X3JhdGUYAiABKAFSCmVmZmVjdFJhdGU=');

@$core.Deprecated('Use writeEffectOffsetRequestDescriptor instead')
const WriteEffectOffsetRequest$json = {
  '1': 'WriteEffectOffsetRequest',
  '2': [
    {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    {'1': 'effect_offset', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'effectOffset', '17': true},
  ],
  '8': [
    {'1': '_effect_offset'},
  ],
};

/// Descriptor for `WriteEffectOffsetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeEffectOffsetRequestDescriptor = $convert.base64Decode(
    'ChhXcml0ZUVmZmVjdE9mZnNldFJlcXVlc3QSGwoJZWZmZWN0X2lkGAEgASgNUghlZmZlY3RJZB'
    'IoCg1lZmZlY3Rfb2Zmc2V0GAIgASgBSABSDGVmZmVjdE9mZnNldIgBAUIQCg5fZWZmZWN0X29m'
    'ZnNldA==');

@$core.Deprecated('Use writeControlRequestDescriptor instead')
const WriteControlRequest$json = {
  '1': 'WriteControlRequest',
  '2': [
    {'1': 'control', '3': 1, '4': 1, '5': 14, '6': '.mizer.fixtures.FixtureControl', '10': 'control'},
    {'1': 'fader', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'fader'},
    {'1': 'color', '3': 3, '4': 1, '5': 11, '6': '.mizer.fixtures.ColorMixerChannel', '9': 0, '10': 'color'},
    {'1': 'generic', '3': 4, '4': 1, '5': 11, '6': '.mizer.programmer.WriteControlRequest.GenericValue', '9': 0, '10': 'generic'},
  ],
  '3': [WriteControlRequest_GenericValue$json],
  '8': [
    {'1': 'value'},
  ],
};

@$core.Deprecated('Use writeControlRequestDescriptor instead')
const WriteControlRequest_GenericValue$json = {
  '1': 'GenericValue',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `WriteControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeControlRequestDescriptor = $convert.base64Decode(
    'ChNXcml0ZUNvbnRyb2xSZXF1ZXN0EjgKB2NvbnRyb2wYASABKA4yHi5taXplci5maXh0dXJlcy'
    '5GaXh0dXJlQ29udHJvbFIHY29udHJvbBIWCgVmYWRlchgCIAEoAUgAUgVmYWRlchI5CgVjb2xv'
    'chgDIAEoCzIhLm1pemVyLmZpeHR1cmVzLkNvbG9yTWl4ZXJDaGFubmVsSABSBWNvbG9yEk4KB2'
    'dlbmVyaWMYBCABKAsyMi5taXplci5wcm9ncmFtbWVyLldyaXRlQ29udHJvbFJlcXVlc3QuR2Vu'
    'ZXJpY1ZhbHVlSABSB2dlbmVyaWMaOAoMR2VuZXJpY1ZhbHVlEhIKBG5hbWUYASABKAlSBG5hbW'
    'USFAoFdmFsdWUYAiABKAFSBXZhbHVlQgcKBXZhbHVl');

@$core.Deprecated('Use selectFixturesRequestDescriptor instead')
const SelectFixturesRequest$json = {
  '1': 'SelectFixturesRequest',
  '2': [
    {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
  ],
};

/// Descriptor for `SelectFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectFixturesRequestDescriptor = $convert.base64Decode(
    'ChVTZWxlY3RGaXh0dXJlc1JlcXVlc3QSNQoIZml4dHVyZXMYASADKAsyGS5taXplci5maXh0dX'
    'Jlcy5GaXh0dXJlSWRSCGZpeHR1cmVz');

@$core.Deprecated('Use unselectFixturesRequestDescriptor instead')
const UnselectFixturesRequest$json = {
  '1': 'UnselectFixturesRequest',
  '2': [
    {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
  ],
};

/// Descriptor for `UnselectFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unselectFixturesRequestDescriptor = $convert.base64Decode(
    'ChdVbnNlbGVjdEZpeHR1cmVzUmVxdWVzdBI1CghmaXh0dXJlcxgBIAMoCzIZLm1pemVyLmZpeH'
    'R1cmVzLkZpeHR1cmVJZFIIZml4dHVyZXM=');

@$core.Deprecated('Use emptyRequestDescriptor instead')
const EmptyRequest$json = {
  '1': 'EmptyRequest',
};

/// Descriptor for `EmptyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyRequestDescriptor = $convert.base64Decode(
    'CgxFbXB0eVJlcXVlc3Q=');

@$core.Deprecated('Use emptyResponseDescriptor instead')
const EmptyResponse$json = {
  '1': 'EmptyResponse',
};

/// Descriptor for `EmptyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyResponseDescriptor = $convert.base64Decode(
    'Cg1FbXB0eVJlc3BvbnNl');

@$core.Deprecated('Use highlightRequestDescriptor instead')
const HighlightRequest$json = {
  '1': 'HighlightRequest',
  '2': [
    {'1': 'highlight', '3': 1, '4': 1, '5': 8, '10': 'highlight'},
  ],
};

/// Descriptor for `HighlightRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List highlightRequestDescriptor = $convert.base64Decode(
    'ChBIaWdobGlnaHRSZXF1ZXN0EhwKCWhpZ2hsaWdodBgBIAEoCFIJaGlnaGxpZ2h0');

@$core.Deprecated('Use storeRequestDescriptor instead')
const StoreRequest$json = {
  '1': 'StoreRequest',
  '2': [
    {'1': 'sequence_id', '3': 1, '4': 1, '5': 13, '10': 'sequenceId'},
    {'1': 'store_mode', '3': 2, '4': 1, '5': 14, '6': '.mizer.programmer.StoreRequest.Mode', '10': 'storeMode'},
    {'1': 'cue_id', '3': 3, '4': 1, '5': 13, '9': 0, '10': 'cueId', '17': true},
  ],
  '4': [StoreRequest_Mode$json],
  '8': [
    {'1': '_cue_id'},
  ],
};

@$core.Deprecated('Use storeRequestDescriptor instead')
const StoreRequest_Mode$json = {
  '1': 'Mode',
  '2': [
    {'1': 'OVERWRITE', '2': 0},
    {'1': 'MERGE', '2': 1},
    {'1': 'ADD_CUE', '2': 2},
  ],
};

/// Descriptor for `StoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storeRequestDescriptor = $convert.base64Decode(
    'CgxTdG9yZVJlcXVlc3QSHwoLc2VxdWVuY2VfaWQYASABKA1SCnNlcXVlbmNlSWQSQgoKc3Rvcm'
    'VfbW9kZRgCIAEoDjIjLm1pemVyLnByb2dyYW1tZXIuU3RvcmVSZXF1ZXN0Lk1vZGVSCXN0b3Jl'
    'TW9kZRIaCgZjdWVfaWQYAyABKA1IAFIFY3VlSWSIAQEiLQoETW9kZRINCglPVkVSV1JJVEUQAB'
    'IJCgVNRVJHRRABEgsKB0FERF9DVUUQAkIJCgdfY3VlX2lk');

@$core.Deprecated('Use storeResponseDescriptor instead')
const StoreResponse$json = {
  '1': 'StoreResponse',
};

/// Descriptor for `StoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storeResponseDescriptor = $convert.base64Decode(
    'Cg1TdG9yZVJlc3BvbnNl');

@$core.Deprecated('Use storePresetRequestDescriptor instead')
const StorePresetRequest$json = {
  '1': 'StorePresetRequest',
  '2': [
    {'1': 'existing', '3': 1, '4': 1, '5': 11, '6': '.mizer.programmer.PresetId', '9': 0, '10': 'existing'},
    {'1': 'new_preset', '3': 2, '4': 1, '5': 11, '6': '.mizer.programmer.StorePresetRequest.NewPreset', '9': 0, '10': 'newPreset'},
  ],
  '3': [StorePresetRequest_NewPreset$json],
  '8': [
    {'1': 'target'},
  ],
};

@$core.Deprecated('Use storePresetRequestDescriptor instead')
const StorePresetRequest_NewPreset$json = {
  '1': 'NewPreset',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.programmer.PresetId.PresetType', '10': 'type'},
    {'1': 'target', '3': 2, '4': 1, '5': 14, '6': '.mizer.programmer.PresetTarget', '10': 'target'},
    {'1': 'label', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'label', '17': true},
  ],
  '8': [
    {'1': '_label'},
  ],
};

/// Descriptor for `StorePresetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storePresetRequestDescriptor = $convert.base64Decode(
    'ChJTdG9yZVByZXNldFJlcXVlc3QSOAoIZXhpc3RpbmcYASABKAsyGi5taXplci5wcm9ncmFtbW'
    'VyLlByZXNldElkSABSCGV4aXN0aW5nEk8KCm5ld19wcmVzZXQYAiABKAsyLi5taXplci5wcm9n'
    'cmFtbWVyLlN0b3JlUHJlc2V0UmVxdWVzdC5OZXdQcmVzZXRIAFIJbmV3UHJlc2V0GqMBCglOZX'
    'dQcmVzZXQSOQoEdHlwZRgBIAEoDjIlLm1pemVyLnByb2dyYW1tZXIuUHJlc2V0SWQuUHJlc2V0'
    'VHlwZVIEdHlwZRI2CgZ0YXJnZXQYAiABKA4yHi5taXplci5wcm9ncmFtbWVyLlByZXNldFRhcm'
    'dldFIGdGFyZ2V0EhkKBWxhYmVsGAMgASgJSABSBWxhYmVsiAEBQggKBl9sYWJlbEIICgZ0YXJn'
    'ZXQ=');

@$core.Deprecated('Use renamePresetRequestDescriptor instead')
const RenamePresetRequest$json = {
  '1': 'RenamePresetRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.mizer.programmer.PresetId', '10': 'id'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
  ],
};

/// Descriptor for `RenamePresetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renamePresetRequestDescriptor = $convert.base64Decode(
    'ChNSZW5hbWVQcmVzZXRSZXF1ZXN0EioKAmlkGAEgASgLMhoubWl6ZXIucHJvZ3JhbW1lci5Qcm'
    'VzZXRJZFICaWQSFAoFbGFiZWwYAiABKAlSBWxhYmVs');

@$core.Deprecated('Use presetsRequestDescriptor instead')
const PresetsRequest$json = {
  '1': 'PresetsRequest',
};

/// Descriptor for `PresetsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List presetsRequestDescriptor = $convert.base64Decode(
    'Cg5QcmVzZXRzUmVxdWVzdA==');

@$core.Deprecated('Use presetIdDescriptor instead')
const PresetId$json = {
  '1': 'PresetId',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.mizer.programmer.PresetId.PresetType', '10': 'type'},
  ],
  '4': [PresetId_PresetType$json],
};

@$core.Deprecated('Use presetIdDescriptor instead')
const PresetId_PresetType$json = {
  '1': 'PresetType',
  '2': [
    {'1': 'INTENSITY', '2': 0},
    {'1': 'SHUTTER', '2': 1},
    {'1': 'COLOR', '2': 2},
    {'1': 'POSITION', '2': 3},
  ],
};

/// Descriptor for `PresetId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List presetIdDescriptor = $convert.base64Decode(
    'CghQcmVzZXRJZBIOCgJpZBgBIAEoDVICaWQSOQoEdHlwZRgCIAEoDjIlLm1pemVyLnByb2dyYW'
    '1tZXIuUHJlc2V0SWQuUHJlc2V0VHlwZVIEdHlwZSJBCgpQcmVzZXRUeXBlEg0KCUlOVEVOU0lU'
    'WRAAEgsKB1NIVVRURVIQARIJCgVDT0xPUhACEgwKCFBPU0lUSU9OEAM=');

@$core.Deprecated('Use presetsDescriptor instead')
const Presets$json = {
  '1': 'Presets',
  '2': [
    {'1': 'intensities', '3': 1, '4': 3, '5': 11, '6': '.mizer.programmer.Preset', '10': 'intensities'},
    {'1': 'shutters', '3': 2, '4': 3, '5': 11, '6': '.mizer.programmer.Preset', '10': 'shutters'},
    {'1': 'colors', '3': 3, '4': 3, '5': 11, '6': '.mizer.programmer.Preset', '10': 'colors'},
    {'1': 'positions', '3': 4, '4': 3, '5': 11, '6': '.mizer.programmer.Preset', '10': 'positions'},
  ],
};

/// Descriptor for `Presets`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List presetsDescriptor = $convert.base64Decode(
    'CgdQcmVzZXRzEjoKC2ludGVuc2l0aWVzGAEgAygLMhgubWl6ZXIucHJvZ3JhbW1lci5QcmVzZX'
    'RSC2ludGVuc2l0aWVzEjQKCHNodXR0ZXJzGAIgAygLMhgubWl6ZXIucHJvZ3JhbW1lci5QcmVz'
    'ZXRSCHNodXR0ZXJzEjAKBmNvbG9ycxgDIAMoCzIYLm1pemVyLnByb2dyYW1tZXIuUHJlc2V0Ug'
    'Zjb2xvcnMSNgoJcG9zaXRpb25zGAQgAygLMhgubWl6ZXIucHJvZ3JhbW1lci5QcmVzZXRSCXBv'
    'c2l0aW9ucw==');

@$core.Deprecated('Use presetDescriptor instead')
const Preset$json = {
  '1': 'Preset',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.mizer.programmer.PresetId', '10': 'id'},
    {'1': 'target', '3': 2, '4': 1, '5': 14, '6': '.mizer.programmer.PresetTarget', '10': 'target'},
    {'1': 'label', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'label', '17': true},
    {'1': 'fader', '3': 4, '4': 1, '5': 1, '9': 0, '10': 'fader'},
    {'1': 'color', '3': 5, '4': 1, '5': 11, '6': '.mizer.programmer.Preset.Color', '9': 0, '10': 'color'},
    {'1': 'position', '3': 6, '4': 1, '5': 11, '6': '.mizer.programmer.Preset.Position', '9': 0, '10': 'position'},
  ],
  '3': [Preset_Color$json, Preset_Position$json],
  '8': [
    {'1': 'value'},
    {'1': '_label'},
  ],
};

@$core.Deprecated('Use presetDescriptor instead')
const Preset_Color$json = {
  '1': 'Color',
  '2': [
    {'1': 'red', '3': 1, '4': 1, '5': 1, '10': 'red'},
    {'1': 'green', '3': 2, '4': 1, '5': 1, '10': 'green'},
    {'1': 'blue', '3': 3, '4': 1, '5': 1, '10': 'blue'},
  ],
};

@$core.Deprecated('Use presetDescriptor instead')
const Preset_Position$json = {
  '1': 'Position',
  '2': [
    {'1': 'tilt', '3': 1, '4': 1, '5': 1, '9': 0, '10': 'tilt', '17': true},
    {'1': 'pan', '3': 2, '4': 1, '5': 1, '9': 1, '10': 'pan', '17': true},
  ],
  '8': [
    {'1': '_tilt'},
    {'1': '_pan'},
  ],
};

/// Descriptor for `Preset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List presetDescriptor = $convert.base64Decode(
    'CgZQcmVzZXQSKgoCaWQYASABKAsyGi5taXplci5wcm9ncmFtbWVyLlByZXNldElkUgJpZBI2Cg'
    'Z0YXJnZXQYAiABKA4yHi5taXplci5wcm9ncmFtbWVyLlByZXNldFRhcmdldFIGdGFyZ2V0EhkK'
    'BWxhYmVsGAMgASgJSAFSBWxhYmVsiAEBEhYKBWZhZGVyGAQgASgBSABSBWZhZGVyEjYKBWNvbG'
    '9yGAUgASgLMh4ubWl6ZXIucHJvZ3JhbW1lci5QcmVzZXQuQ29sb3JIAFIFY29sb3ISPwoIcG9z'
    'aXRpb24YBiABKAsyIS5taXplci5wcm9ncmFtbWVyLlByZXNldC5Qb3NpdGlvbkgAUghwb3NpdG'
    'lvbhpDCgVDb2xvchIQCgNyZWQYASABKAFSA3JlZBIUCgVncmVlbhgCIAEoAVIFZ3JlZW4SEgoE'
    'Ymx1ZRgDIAEoAVIEYmx1ZRpLCghQb3NpdGlvbhIXCgR0aWx0GAEgASgBSABSBHRpbHSIAQESFQ'
    'oDcGFuGAIgASgBSAFSA3BhbogBAUIHCgVfdGlsdEIGCgRfcGFuQgcKBXZhbHVlQggKBl9sYWJl'
    'bA==');

@$core.Deprecated('Use callPresetResponseDescriptor instead')
const CallPresetResponse$json = {
  '1': 'CallPresetResponse',
};

/// Descriptor for `CallPresetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List callPresetResponseDescriptor = $convert.base64Decode(
    'ChJDYWxsUHJlc2V0UmVzcG9uc2U=');

@$core.Deprecated('Use groupsRequestDescriptor instead')
const GroupsRequest$json = {
  '1': 'GroupsRequest',
};

/// Descriptor for `GroupsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupsRequestDescriptor = $convert.base64Decode(
    'Cg1Hcm91cHNSZXF1ZXN0');

@$core.Deprecated('Use groupsDescriptor instead')
const Groups$json = {
  '1': 'Groups',
  '2': [
    {'1': 'groups', '3': 1, '4': 3, '5': 11, '6': '.mizer.programmer.Group', '10': 'groups'},
  ],
};

/// Descriptor for `Groups`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupsDescriptor = $convert.base64Decode(
    'CgZHcm91cHMSLwoGZ3JvdXBzGAEgAygLMhcubWl6ZXIucHJvZ3JhbW1lci5Hcm91cFIGZ3JvdX'
    'Bz');

@$core.Deprecated('Use groupDescriptor instead')
const Group$json = {
  '1': 'Group',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `Group`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupDescriptor = $convert.base64Decode(
    'CgVHcm91cBIOCgJpZBgBIAEoDVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use selectGroupRequestDescriptor instead')
const SelectGroupRequest$json = {
  '1': 'SelectGroupRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
  ],
};

/// Descriptor for `SelectGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectGroupRequestDescriptor = $convert.base64Decode(
    'ChJTZWxlY3RHcm91cFJlcXVlc3QSDgoCaWQYASABKA1SAmlk');

@$core.Deprecated('Use selectGroupResponseDescriptor instead')
const SelectGroupResponse$json = {
  '1': 'SelectGroupResponse',
};

/// Descriptor for `SelectGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectGroupResponseDescriptor = $convert.base64Decode(
    'ChNTZWxlY3RHcm91cFJlc3BvbnNl');

@$core.Deprecated('Use addGroupRequestDescriptor instead')
const AddGroupRequest$json = {
  '1': 'AddGroupRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AddGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addGroupRequestDescriptor = $convert.base64Decode(
    'Cg9BZGRHcm91cFJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use renameGroupRequestDescriptor instead')
const RenameGroupRequest$json = {
  '1': 'RenameGroupRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `RenameGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renameGroupRequestDescriptor = $convert.base64Decode(
    'ChJSZW5hbWVHcm91cFJlcXVlc3QSDgoCaWQYASABKA1SAmlkEhIKBG5hbWUYAiABKAlSBG5hbW'
    'U=');

@$core.Deprecated('Use assignFixturesToGroupRequestDescriptor instead')
const AssignFixturesToGroupRequest$json = {
  '1': 'AssignFixturesToGroupRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'fixtures', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
  ],
};

/// Descriptor for `AssignFixturesToGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assignFixturesToGroupRequestDescriptor = $convert.base64Decode(
    'ChxBc3NpZ25GaXh0dXJlc1RvR3JvdXBSZXF1ZXN0Eg4KAmlkGAEgASgNUgJpZBI1CghmaXh0dX'
    'JlcxgCIAMoCzIZLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVJZFIIZml4dHVyZXM=');

@$core.Deprecated('Use assignFixtureSelectionToGroupRequestDescriptor instead')
const AssignFixtureSelectionToGroupRequest$json = {
  '1': 'AssignFixtureSelectionToGroupRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
  ],
};

/// Descriptor for `AssignFixtureSelectionToGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assignFixtureSelectionToGroupRequestDescriptor = $convert.base64Decode(
    'CiRBc3NpZ25GaXh0dXJlU2VsZWN0aW9uVG9Hcm91cFJlcXVlc3QSDgoCaWQYASABKA1SAmlk');

@$core.Deprecated('Use assignFixturesToGroupResponseDescriptor instead')
const AssignFixturesToGroupResponse$json = {
  '1': 'AssignFixturesToGroupResponse',
};

/// Descriptor for `AssignFixturesToGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assignFixturesToGroupResponseDescriptor = $convert.base64Decode(
    'Ch1Bc3NpZ25GaXh0dXJlc1RvR3JvdXBSZXNwb25zZQ==');

