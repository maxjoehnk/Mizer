///
//  Generated code. Do not modify.
//  source: programmer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use subscribeProgrammerRequestDescriptor instead')
const SubscribeProgrammerRequest$json = const {
  '1': 'SubscribeProgrammerRequest',
};

/// Descriptor for `SubscribeProgrammerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeProgrammerRequestDescriptor = $convert.base64Decode('ChpTdWJzY3JpYmVQcm9ncmFtbWVyUmVxdWVzdA==');
@$core.Deprecated('Use programmerStateDescriptor instead')
const ProgrammerState$json = const {
  '1': 'ProgrammerState',
  '2': const [
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
    const {'1': 'active_fixtures', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'activeFixtures'},
    const {'1': 'active_groups', '3': 3, '4': 3, '5': 13, '10': 'activeGroups'},
    const {'1': 'selection', '3': 4, '4': 1, '5': 11, '6': '.mizer.programmer.FixtureSelection', '10': 'selection'},
    const {'1': 'controls', '3': 5, '4': 3, '5': 11, '6': '.mizer.programmer.ProgrammerChannel', '10': 'controls'},
    const {'1': 'highlight', '3': 6, '4': 1, '5': 8, '10': 'highlight'},
    const {'1': 'block_size', '3': 7, '4': 1, '5': 13, '10': 'blockSize'},
    const {'1': 'groups', '3': 8, '4': 1, '5': 13, '10': 'groups'},
    const {'1': 'wings', '3': 9, '4': 1, '5': 13, '10': 'wings'},
    const {'1': 'effects', '3': 10, '4': 3, '5': 11, '6': '.mizer.programmer.EffectProgrammerState', '10': 'effects'},
  ],
};

/// Descriptor for `ProgrammerState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List programmerStateDescriptor = $convert.base64Decode('Cg9Qcm9ncmFtbWVyU3RhdGUSNQoIZml4dHVyZXMYASADKAsyGS5taXplci5maXh0dXJlcy5GaXh0dXJlSWRSCGZpeHR1cmVzEkIKD2FjdGl2ZV9maXh0dXJlcxgCIAMoCzIZLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVJZFIOYWN0aXZlRml4dHVyZXMSIwoNYWN0aXZlX2dyb3VwcxgDIAMoDVIMYWN0aXZlR3JvdXBzEkAKCXNlbGVjdGlvbhgEIAEoCzIiLm1pemVyLnByb2dyYW1tZXIuRml4dHVyZVNlbGVjdGlvblIJc2VsZWN0aW9uEj8KCGNvbnRyb2xzGAUgAygLMiMubWl6ZXIucHJvZ3JhbW1lci5Qcm9ncmFtbWVyQ2hhbm5lbFIIY29udHJvbHMSHAoJaGlnaGxpZ2h0GAYgASgIUgloaWdobGlnaHQSHQoKYmxvY2tfc2l6ZRgHIAEoDVIJYmxvY2tTaXplEhYKBmdyb3VwcxgIIAEoDVIGZ3JvdXBzEhQKBXdpbmdzGAkgASgNUgV3aW5ncxJBCgdlZmZlY3RzGAogAygLMicubWl6ZXIucHJvZ3JhbW1lci5FZmZlY3RQcm9ncmFtbWVyU3RhdGVSB2VmZmVjdHM=');
@$core.Deprecated('Use fixtureSelectionDescriptor instead')
const FixtureSelection$json = const {
  '1': 'FixtureSelection',
  '2': const [
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.programmer.FixtureSelection.GroupedFixtureList', '10': 'fixtures'},
  ],
  '3': const [FixtureSelection_GroupedFixtureList$json],
};

@$core.Deprecated('Use fixtureSelectionDescriptor instead')
const FixtureSelection_GroupedFixtureList$json = const {
  '1': 'GroupedFixtureList',
  '2': const [
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
  ],
};

/// Descriptor for `FixtureSelection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureSelectionDescriptor = $convert.base64Decode('ChBGaXh0dXJlU2VsZWN0aW9uElEKCGZpeHR1cmVzGAEgAygLMjUubWl6ZXIucHJvZ3JhbW1lci5GaXh0dXJlU2VsZWN0aW9uLkdyb3VwZWRGaXh0dXJlTGlzdFIIZml4dHVyZXMaSwoSR3JvdXBlZEZpeHR1cmVMaXN0EjUKCGZpeHR1cmVzGAEgAygLMhkubWl6ZXIuZml4dHVyZXMuRml4dHVyZUlkUghmaXh0dXJlcw==');
@$core.Deprecated('Use programmerChannelDescriptor instead')
const ProgrammerChannel$json = const {
  '1': 'ProgrammerChannel',
  '2': const [
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
    const {'1': 'control', '3': 2, '4': 1, '5': 14, '6': '.mizer.fixtures.FixtureControl', '10': 'control'},
    const {'1': 'fader', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'fader'},
    const {'1': 'color', '3': 4, '4': 1, '5': 11, '6': '.mizer.fixtures.ColorMixerChannel', '9': 0, '10': 'color'},
    const {'1': 'generic', '3': 5, '4': 1, '5': 11, '6': '.mizer.programmer.ProgrammerChannel.GenericValue', '9': 0, '10': 'generic'},
    const {'1': 'world', '3': 6, '4': 1, '5': 11, '6': '.mizer.fixtures.WorldPosition', '9': 0, '10': 'world'},
  ],
  '3': const [ProgrammerChannel_GenericValue$json],
  '4': const [ProgrammerChannel_ColorChannel$json],
  '8': const [
    const {'1': 'value'},
  ],
};

@$core.Deprecated('Use programmerChannelDescriptor instead')
const ProgrammerChannel_GenericValue$json = const {
  '1': 'GenericValue',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

@$core.Deprecated('Use programmerChannelDescriptor instead')
const ProgrammerChannel_ColorChannel$json = const {
  '1': 'ColorChannel',
  '2': const [
    const {'1': 'RED', '2': 0},
    const {'1': 'GREEN', '2': 1},
    const {'1': 'BLUE', '2': 2},
  ],
};

/// Descriptor for `ProgrammerChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List programmerChannelDescriptor = $convert.base64Decode('ChFQcm9ncmFtbWVyQ2hhbm5lbBI1CghmaXh0dXJlcxgBIAMoCzIZLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVJZFIIZml4dHVyZXMSOAoHY29udHJvbBgCIAEoDjIeLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVDb250cm9sUgdjb250cm9sEhYKBWZhZGVyGAMgASgBSABSBWZhZGVyEjkKBWNvbG9yGAQgASgLMiEubWl6ZXIuZml4dHVyZXMuQ29sb3JNaXhlckNoYW5uZWxIAFIFY29sb3ISTAoHZ2VuZXJpYxgFIAEoCzIwLm1pemVyLnByb2dyYW1tZXIuUHJvZ3JhbW1lckNoYW5uZWwuR2VuZXJpY1ZhbHVlSABSB2dlbmVyaWMSNQoFd29ybGQYBiABKAsyHS5taXplci5maXh0dXJlcy5Xb3JsZFBvc2l0aW9uSABSBXdvcmxkGjgKDEdlbmVyaWNWYWx1ZRISCgRuYW1lGAEgASgJUgRuYW1lEhQKBXZhbHVlGAIgASgBUgV2YWx1ZSIsCgxDb2xvckNoYW5uZWwSBwoDUkVEEAASCQoFR1JFRU4QARIICgRCTFVFEAJCBwoFdmFsdWU=');
@$core.Deprecated('Use effectProgrammerStateDescriptor instead')
const EffectProgrammerState$json = const {
  '1': 'EffectProgrammerState',
  '2': const [
    const {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    const {'1': 'effect_rate', '3': 2, '4': 1, '5': 1, '10': 'effectRate'},
    const {'1': 'effect_offset', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'effectOffset', '17': true},
  ],
  '8': const [
    const {'1': '_effect_offset'},
  ],
};

/// Descriptor for `EffectProgrammerState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List effectProgrammerStateDescriptor = $convert.base64Decode('ChVFZmZlY3RQcm9ncmFtbWVyU3RhdGUSGwoJZWZmZWN0X2lkGAEgASgNUghlZmZlY3RJZBIfCgtlZmZlY3RfcmF0ZRgCIAEoAVIKZWZmZWN0UmF0ZRIoCg1lZmZlY3Rfb2Zmc2V0GAMgASgBSABSDGVmZmVjdE9mZnNldIgBAUIQCg5fZWZmZWN0X29mZnNldA==');
@$core.Deprecated('Use writeEffectRateRequestDescriptor instead')
const WriteEffectRateRequest$json = const {
  '1': 'WriteEffectRateRequest',
  '2': const [
    const {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    const {'1': 'effect_rate', '3': 2, '4': 1, '5': 1, '10': 'effectRate'},
  ],
};

/// Descriptor for `WriteEffectRateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeEffectRateRequestDescriptor = $convert.base64Decode('ChZXcml0ZUVmZmVjdFJhdGVSZXF1ZXN0EhsKCWVmZmVjdF9pZBgBIAEoDVIIZWZmZWN0SWQSHwoLZWZmZWN0X3JhdGUYAiABKAFSCmVmZmVjdFJhdGU=');
@$core.Deprecated('Use writeEffectRateResponseDescriptor instead')
const WriteEffectRateResponse$json = const {
  '1': 'WriteEffectRateResponse',
};

/// Descriptor for `WriteEffectRateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeEffectRateResponseDescriptor = $convert.base64Decode('ChdXcml0ZUVmZmVjdFJhdGVSZXNwb25zZQ==');
@$core.Deprecated('Use writeEffectOffsetRequestDescriptor instead')
const WriteEffectOffsetRequest$json = const {
  '1': 'WriteEffectOffsetRequest',
  '2': const [
    const {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    const {'1': 'effect_offset', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'effectOffset', '17': true},
  ],
  '8': const [
    const {'1': '_effect_offset'},
  ],
};

/// Descriptor for `WriteEffectOffsetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeEffectOffsetRequestDescriptor = $convert.base64Decode('ChhXcml0ZUVmZmVjdE9mZnNldFJlcXVlc3QSGwoJZWZmZWN0X2lkGAEgASgNUghlZmZlY3RJZBIoCg1lZmZlY3Rfb2Zmc2V0GAIgASgBSABSDGVmZmVjdE9mZnNldIgBAUIQCg5fZWZmZWN0X29mZnNldA==');
@$core.Deprecated('Use writeEffectOffsetResponseDescriptor instead')
const WriteEffectOffsetResponse$json = const {
  '1': 'WriteEffectOffsetResponse',
};

/// Descriptor for `WriteEffectOffsetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeEffectOffsetResponseDescriptor = $convert.base64Decode('ChlXcml0ZUVmZmVjdE9mZnNldFJlc3BvbnNl');
@$core.Deprecated('Use writeControlRequestDescriptor instead')
const WriteControlRequest$json = const {
  '1': 'WriteControlRequest',
  '2': const [
    const {'1': 'control', '3': 1, '4': 1, '5': 14, '6': '.mizer.fixtures.FixtureControl', '10': 'control'},
    const {'1': 'fader', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'fader'},
    const {'1': 'color', '3': 3, '4': 1, '5': 11, '6': '.mizer.fixtures.ColorMixerChannel', '9': 0, '10': 'color'},
    const {'1': 'generic', '3': 4, '4': 1, '5': 11, '6': '.mizer.programmer.WriteControlRequest.GenericValue', '9': 0, '10': 'generic'},
  ],
  '3': const [WriteControlRequest_GenericValue$json],
  '8': const [
    const {'1': 'value'},
  ],
};

@$core.Deprecated('Use writeControlRequestDescriptor instead')
const WriteControlRequest_GenericValue$json = const {
  '1': 'GenericValue',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `WriteControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeControlRequestDescriptor = $convert.base64Decode('ChNXcml0ZUNvbnRyb2xSZXF1ZXN0EjgKB2NvbnRyb2wYASABKA4yHi5taXplci5maXh0dXJlcy5GaXh0dXJlQ29udHJvbFIHY29udHJvbBIWCgVmYWRlchgCIAEoAUgAUgVmYWRlchI5CgVjb2xvchgDIAEoCzIhLm1pemVyLmZpeHR1cmVzLkNvbG9yTWl4ZXJDaGFubmVsSABSBWNvbG9yEk4KB2dlbmVyaWMYBCABKAsyMi5taXplci5wcm9ncmFtbWVyLldyaXRlQ29udHJvbFJlcXVlc3QuR2VuZXJpY1ZhbHVlSABSB2dlbmVyaWMaOAoMR2VuZXJpY1ZhbHVlEhIKBG5hbWUYASABKAlSBG5hbWUSFAoFdmFsdWUYAiABKAFSBXZhbHVlQgcKBXZhbHVl');
@$core.Deprecated('Use writeControlResponseDescriptor instead')
const WriteControlResponse$json = const {
  '1': 'WriteControlResponse',
};

/// Descriptor for `WriteControlResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeControlResponseDescriptor = $convert.base64Decode('ChRXcml0ZUNvbnRyb2xSZXNwb25zZQ==');
@$core.Deprecated('Use selectFixturesRequestDescriptor instead')
const SelectFixturesRequest$json = const {
  '1': 'SelectFixturesRequest',
  '2': const [
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
  ],
};

/// Descriptor for `SelectFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectFixturesRequestDescriptor = $convert.base64Decode('ChVTZWxlY3RGaXh0dXJlc1JlcXVlc3QSNQoIZml4dHVyZXMYASADKAsyGS5taXplci5maXh0dXJlcy5GaXh0dXJlSWRSCGZpeHR1cmVz');
@$core.Deprecated('Use selectFixturesResponseDescriptor instead')
const SelectFixturesResponse$json = const {
  '1': 'SelectFixturesResponse',
};

/// Descriptor for `SelectFixturesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectFixturesResponseDescriptor = $convert.base64Decode('ChZTZWxlY3RGaXh0dXJlc1Jlc3BvbnNl');
@$core.Deprecated('Use unselectFixturesRequestDescriptor instead')
const UnselectFixturesRequest$json = const {
  '1': 'UnselectFixturesRequest',
  '2': const [
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
  ],
};

/// Descriptor for `UnselectFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unselectFixturesRequestDescriptor = $convert.base64Decode('ChdVbnNlbGVjdEZpeHR1cmVzUmVxdWVzdBI1CghmaXh0dXJlcxgBIAMoCzIZLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVJZFIIZml4dHVyZXM=');
@$core.Deprecated('Use unselectFixturesResponseDescriptor instead')
const UnselectFixturesResponse$json = const {
  '1': 'UnselectFixturesResponse',
};

/// Descriptor for `UnselectFixturesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unselectFixturesResponseDescriptor = $convert.base64Decode('ChhVbnNlbGVjdEZpeHR1cmVzUmVzcG9uc2U=');
@$core.Deprecated('Use clearRequestDescriptor instead')
const ClearRequest$json = const {
  '1': 'ClearRequest',
};

/// Descriptor for `ClearRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clearRequestDescriptor = $convert.base64Decode('CgxDbGVhclJlcXVlc3Q=');
@$core.Deprecated('Use clearResponseDescriptor instead')
const ClearResponse$json = const {
  '1': 'ClearResponse',
};

/// Descriptor for `ClearResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clearResponseDescriptor = $convert.base64Decode('Cg1DbGVhclJlc3BvbnNl');
@$core.Deprecated('Use highlightRequestDescriptor instead')
const HighlightRequest$json = const {
  '1': 'HighlightRequest',
  '2': const [
    const {'1': 'highlight', '3': 1, '4': 1, '5': 8, '10': 'highlight'},
  ],
};

/// Descriptor for `HighlightRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List highlightRequestDescriptor = $convert.base64Decode('ChBIaWdobGlnaHRSZXF1ZXN0EhwKCWhpZ2hsaWdodBgBIAEoCFIJaGlnaGxpZ2h0');
@$core.Deprecated('Use highlightResponseDescriptor instead')
const HighlightResponse$json = const {
  '1': 'HighlightResponse',
};

/// Descriptor for `HighlightResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List highlightResponseDescriptor = $convert.base64Decode('ChFIaWdobGlnaHRSZXNwb25zZQ==');
@$core.Deprecated('Use storeRequestDescriptor instead')
const StoreRequest$json = const {
  '1': 'StoreRequest',
  '2': const [
    const {'1': 'sequence_id', '3': 1, '4': 1, '5': 13, '10': 'sequenceId'},
    const {'1': 'store_mode', '3': 2, '4': 1, '5': 14, '6': '.mizer.programmer.StoreRequest.Mode', '10': 'storeMode'},
    const {'1': 'cue_id', '3': 3, '4': 1, '5': 13, '9': 0, '10': 'cueId', '17': true},
  ],
  '4': const [StoreRequest_Mode$json],
  '8': const [
    const {'1': '_cue_id'},
  ],
};

@$core.Deprecated('Use storeRequestDescriptor instead')
const StoreRequest_Mode$json = const {
  '1': 'Mode',
  '2': const [
    const {'1': 'OVERWRITE', '2': 0},
    const {'1': 'MERGE', '2': 1},
    const {'1': 'ADD_CUE', '2': 2},
  ],
};

/// Descriptor for `StoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storeRequestDescriptor = $convert.base64Decode('CgxTdG9yZVJlcXVlc3QSHwoLc2VxdWVuY2VfaWQYASABKA1SCnNlcXVlbmNlSWQSQgoKc3RvcmVfbW9kZRgCIAEoDjIjLm1pemVyLnByb2dyYW1tZXIuU3RvcmVSZXF1ZXN0Lk1vZGVSCXN0b3JlTW9kZRIaCgZjdWVfaWQYAyABKA1IAFIFY3VlSWSIAQEiLQoETW9kZRINCglPVkVSV1JJVEUQABIJCgVNRVJHRRABEgsKB0FERF9DVUUQAkIJCgdfY3VlX2lk');
@$core.Deprecated('Use storeResponseDescriptor instead')
const StoreResponse$json = const {
  '1': 'StoreResponse',
};

/// Descriptor for `StoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storeResponseDescriptor = $convert.base64Decode('Cg1TdG9yZVJlc3BvbnNl');
@$core.Deprecated('Use storePresetRequestDescriptor instead')
const StorePresetRequest$json = const {
  '1': 'StorePresetRequest',
  '2': const [
    const {'1': 'existing', '3': 1, '4': 1, '5': 11, '6': '.mizer.programmer.PresetId', '9': 0, '10': 'existing'},
    const {'1': 'new_preset', '3': 2, '4': 1, '5': 11, '6': '.mizer.programmer.StorePresetRequest.NewPreset', '9': 0, '10': 'newPreset'},
  ],
  '3': const [StorePresetRequest_NewPreset$json],
  '8': const [
    const {'1': 'target'},
  ],
};

@$core.Deprecated('Use storePresetRequestDescriptor instead')
const StorePresetRequest_NewPreset$json = const {
  '1': 'NewPreset',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.programmer.PresetId.PresetType', '10': 'type'},
    const {'1': 'label', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'label', '17': true},
  ],
  '8': const [
    const {'1': '_label'},
  ],
};

/// Descriptor for `StorePresetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storePresetRequestDescriptor = $convert.base64Decode('ChJTdG9yZVByZXNldFJlcXVlc3QSOAoIZXhpc3RpbmcYASABKAsyGi5taXplci5wcm9ncmFtbWVyLlByZXNldElkSABSCGV4aXN0aW5nEk8KCm5ld19wcmVzZXQYAiABKAsyLi5taXplci5wcm9ncmFtbWVyLlN0b3JlUHJlc2V0UmVxdWVzdC5OZXdQcmVzZXRIAFIJbmV3UHJlc2V0GmsKCU5ld1ByZXNldBI5CgR0eXBlGAEgASgOMiUubWl6ZXIucHJvZ3JhbW1lci5QcmVzZXRJZC5QcmVzZXRUeXBlUgR0eXBlEhkKBWxhYmVsGAIgASgJSABSBWxhYmVsiAEBQggKBl9sYWJlbEIICgZ0YXJnZXQ=');
@$core.Deprecated('Use renamePresetRequestDescriptor instead')
const RenamePresetRequest$json = const {
  '1': 'RenamePresetRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.mizer.programmer.PresetId', '10': 'id'},
    const {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
  ],
};

/// Descriptor for `RenamePresetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renamePresetRequestDescriptor = $convert.base64Decode('ChNSZW5hbWVQcmVzZXRSZXF1ZXN0EioKAmlkGAEgASgLMhoubWl6ZXIucHJvZ3JhbW1lci5QcmVzZXRJZFICaWQSFAoFbGFiZWwYAiABKAlSBWxhYmVs');
@$core.Deprecated('Use presetsRequestDescriptor instead')
const PresetsRequest$json = const {
  '1': 'PresetsRequest',
};

/// Descriptor for `PresetsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List presetsRequestDescriptor = $convert.base64Decode('Cg5QcmVzZXRzUmVxdWVzdA==');
@$core.Deprecated('Use presetIdDescriptor instead')
const PresetId$json = const {
  '1': 'PresetId',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.mizer.programmer.PresetId.PresetType', '10': 'type'},
  ],
  '4': const [PresetId_PresetType$json],
};

@$core.Deprecated('Use presetIdDescriptor instead')
const PresetId_PresetType$json = const {
  '1': 'PresetType',
  '2': const [
    const {'1': 'INTENSITY', '2': 0},
    const {'1': 'SHUTTER', '2': 1},
    const {'1': 'COLOR', '2': 2},
    const {'1': 'POSITION', '2': 3},
  ],
};

/// Descriptor for `PresetId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List presetIdDescriptor = $convert.base64Decode('CghQcmVzZXRJZBIOCgJpZBgBIAEoDVICaWQSOQoEdHlwZRgCIAEoDjIlLm1pemVyLnByb2dyYW1tZXIuUHJlc2V0SWQuUHJlc2V0VHlwZVIEdHlwZSJBCgpQcmVzZXRUeXBlEg0KCUlOVEVOU0lUWRAAEgsKB1NIVVRURVIQARIJCgVDT0xPUhACEgwKCFBPU0lUSU9OEAM=');
@$core.Deprecated('Use presetsDescriptor instead')
const Presets$json = const {
  '1': 'Presets',
  '2': const [
    const {'1': 'intensities', '3': 1, '4': 3, '5': 11, '6': '.mizer.programmer.Preset', '10': 'intensities'},
    const {'1': 'shutters', '3': 2, '4': 3, '5': 11, '6': '.mizer.programmer.Preset', '10': 'shutters'},
    const {'1': 'colors', '3': 3, '4': 3, '5': 11, '6': '.mizer.programmer.Preset', '10': 'colors'},
    const {'1': 'positions', '3': 4, '4': 3, '5': 11, '6': '.mizer.programmer.Preset', '10': 'positions'},
  ],
};

/// Descriptor for `Presets`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List presetsDescriptor = $convert.base64Decode('CgdQcmVzZXRzEjoKC2ludGVuc2l0aWVzGAEgAygLMhgubWl6ZXIucHJvZ3JhbW1lci5QcmVzZXRSC2ludGVuc2l0aWVzEjQKCHNodXR0ZXJzGAIgAygLMhgubWl6ZXIucHJvZ3JhbW1lci5QcmVzZXRSCHNodXR0ZXJzEjAKBmNvbG9ycxgDIAMoCzIYLm1pemVyLnByb2dyYW1tZXIuUHJlc2V0UgZjb2xvcnMSNgoJcG9zaXRpb25zGAQgAygLMhgubWl6ZXIucHJvZ3JhbW1lci5QcmVzZXRSCXBvc2l0aW9ucw==');
@$core.Deprecated('Use presetDescriptor instead')
const Preset$json = const {
  '1': 'Preset',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.mizer.programmer.PresetId', '10': 'id'},
    const {'1': 'label', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'label', '17': true},
    const {'1': 'fader', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'fader'},
    const {'1': 'color', '3': 4, '4': 1, '5': 11, '6': '.mizer.programmer.Preset.Color', '9': 0, '10': 'color'},
    const {'1': 'position', '3': 5, '4': 1, '5': 11, '6': '.mizer.programmer.Preset.Position', '9': 0, '10': 'position'},
  ],
  '3': const [Preset_Color$json, Preset_Position$json, Preset_PanTilt$json],
  '8': const [
    const {'1': 'value'},
    const {'1': '_label'},
  ],
};

@$core.Deprecated('Use presetDescriptor instead')
const Preset_Color$json = const {
  '1': 'Color',
  '2': const [
    const {'1': 'red', '3': 1, '4': 1, '5': 1, '10': 'red'},
    const {'1': 'green', '3': 2, '4': 1, '5': 1, '10': 'green'},
    const {'1': 'blue', '3': 3, '4': 1, '5': 1, '10': 'blue'},
  ],
};

@$core.Deprecated('Use presetDescriptor instead')
const Preset_Position$json = const {
  '1': 'Position',
  '2': const [
    const {'1': 'pan_tilt', '3': 1, '4': 1, '5': 11, '6': '.mizer.programmer.Preset.PanTilt', '9': 0, '10': 'panTilt'},
    const {'1': 'world', '3': 2, '4': 1, '5': 11, '6': '.mizer.fixtures.WorldPosition', '9': 0, '10': 'world'},
  ],
  '8': const [
    const {'1': 'value'},
  ],
};

@$core.Deprecated('Use presetDescriptor instead')
const Preset_PanTilt$json = const {
  '1': 'PanTilt',
  '2': const [
    const {'1': 'tilt', '3': 1, '4': 1, '5': 1, '9': 0, '10': 'tilt', '17': true},
    const {'1': 'pan', '3': 2, '4': 1, '5': 1, '9': 1, '10': 'pan', '17': true},
  ],
  '8': const [
    const {'1': '_tilt'},
    const {'1': '_pan'},
  ],
};

/// Descriptor for `Preset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List presetDescriptor = $convert.base64Decode('CgZQcmVzZXQSKgoCaWQYASABKAsyGi5taXplci5wcm9ncmFtbWVyLlByZXNldElkUgJpZBIZCgVsYWJlbBgCIAEoCUgBUgVsYWJlbIgBARIWCgVmYWRlchgDIAEoAUgAUgVmYWRlchI2CgVjb2xvchgEIAEoCzIeLm1pemVyLnByb2dyYW1tZXIuUHJlc2V0LkNvbG9ySABSBWNvbG9yEj8KCHBvc2l0aW9uGAUgASgLMiEubWl6ZXIucHJvZ3JhbW1lci5QcmVzZXQuUG9zaXRpb25IAFIIcG9zaXRpb24aQwoFQ29sb3ISEAoDcmVkGAEgASgBUgNyZWQSFAoFZ3JlZW4YAiABKAFSBWdyZWVuEhIKBGJsdWUYAyABKAFSBGJsdWUaiQEKCFBvc2l0aW9uEj0KCHBhbl90aWx0GAEgASgLMiAubWl6ZXIucHJvZ3JhbW1lci5QcmVzZXQuUGFuVGlsdEgAUgdwYW5UaWx0EjUKBXdvcmxkGAIgASgLMh0ubWl6ZXIuZml4dHVyZXMuV29ybGRQb3NpdGlvbkgAUgV3b3JsZEIHCgV2YWx1ZRpKCgdQYW5UaWx0EhcKBHRpbHQYASABKAFIAFIEdGlsdIgBARIVCgNwYW4YAiABKAFIAVIDcGFuiAEBQgcKBV90aWx0QgYKBF9wYW5CBwoFdmFsdWVCCAoGX2xhYmVs');
@$core.Deprecated('Use callPresetResponseDescriptor instead')
const CallPresetResponse$json = const {
  '1': 'CallPresetResponse',
};

/// Descriptor for `CallPresetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List callPresetResponseDescriptor = $convert.base64Decode('ChJDYWxsUHJlc2V0UmVzcG9uc2U=');
@$core.Deprecated('Use groupsRequestDescriptor instead')
const GroupsRequest$json = const {
  '1': 'GroupsRequest',
};

/// Descriptor for `GroupsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupsRequestDescriptor = $convert.base64Decode('Cg1Hcm91cHNSZXF1ZXN0');
@$core.Deprecated('Use groupsDescriptor instead')
const Groups$json = const {
  '1': 'Groups',
  '2': const [
    const {'1': 'groups', '3': 1, '4': 3, '5': 11, '6': '.mizer.programmer.Group', '10': 'groups'},
  ],
};

/// Descriptor for `Groups`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupsDescriptor = $convert.base64Decode('CgZHcm91cHMSLwoGZ3JvdXBzGAEgAygLMhcubWl6ZXIucHJvZ3JhbW1lci5Hcm91cFIGZ3JvdXBz');
@$core.Deprecated('Use groupDescriptor instead')
const Group$json = const {
  '1': 'Group',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `Group`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupDescriptor = $convert.base64Decode('CgVHcm91cBIOCgJpZBgBIAEoDVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use selectGroupRequestDescriptor instead')
const SelectGroupRequest$json = const {
  '1': 'SelectGroupRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
  ],
};

/// Descriptor for `SelectGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectGroupRequestDescriptor = $convert.base64Decode('ChJTZWxlY3RHcm91cFJlcXVlc3QSDgoCaWQYASABKA1SAmlk');
@$core.Deprecated('Use selectGroupResponseDescriptor instead')
const SelectGroupResponse$json = const {
  '1': 'SelectGroupResponse',
};

/// Descriptor for `SelectGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectGroupResponseDescriptor = $convert.base64Decode('ChNTZWxlY3RHcm91cFJlc3BvbnNl');
@$core.Deprecated('Use addGroupRequestDescriptor instead')
const AddGroupRequest$json = const {
  '1': 'AddGroupRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AddGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addGroupRequestDescriptor = $convert.base64Decode('Cg9BZGRHcm91cFJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use renameGroupRequestDescriptor instead')
const RenameGroupRequest$json = const {
  '1': 'RenameGroupRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `RenameGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renameGroupRequestDescriptor = $convert.base64Decode('ChJSZW5hbWVHcm91cFJlcXVlc3QSDgoCaWQYASABKA1SAmlkEhIKBG5hbWUYAiABKAlSBG5hbWU=');
@$core.Deprecated('Use assignFixturesToGroupRequestDescriptor instead')
const AssignFixturesToGroupRequest$json = const {
  '1': 'AssignFixturesToGroupRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'fixtures', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
  ],
};

/// Descriptor for `AssignFixturesToGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assignFixturesToGroupRequestDescriptor = $convert.base64Decode('ChxBc3NpZ25GaXh0dXJlc1RvR3JvdXBSZXF1ZXN0Eg4KAmlkGAEgASgNUgJpZBI1CghmaXh0dXJlcxgCIAMoCzIZLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVJZFIIZml4dHVyZXM=');
@$core.Deprecated('Use assignFixtureSelectionToGroupRequestDescriptor instead')
const AssignFixtureSelectionToGroupRequest$json = const {
  '1': 'AssignFixtureSelectionToGroupRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
  ],
};

/// Descriptor for `AssignFixtureSelectionToGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assignFixtureSelectionToGroupRequestDescriptor = $convert.base64Decode('CiRBc3NpZ25GaXh0dXJlU2VsZWN0aW9uVG9Hcm91cFJlcXVlc3QSDgoCaWQYASABKA1SAmlk');
@$core.Deprecated('Use assignFixturesToGroupResponseDescriptor instead')
const AssignFixturesToGroupResponse$json = const {
  '1': 'AssignFixturesToGroupResponse',
};

/// Descriptor for `AssignFixturesToGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assignFixturesToGroupResponseDescriptor = $convert.base64Decode('Ch1Bc3NpZ25GaXh0dXJlc1RvR3JvdXBSZXNwb25zZQ==');
