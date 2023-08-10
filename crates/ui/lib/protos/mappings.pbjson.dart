///
//  Generated code. Do not modify.
//  source: mappings.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use mappingRequestDescriptor instead')
const MappingRequest$json = const {
  '1': 'MappingRequest',
  '2': const [
    const {'1': 'midi', '3': 1, '4': 1, '5': 11, '6': '.mizer.mappings.MidiMapping', '9': 0, '10': 'midi'},
    const {'1': 'sequencer_go', '3': 10, '4': 1, '5': 11, '6': '.mizer.mappings.SequencerGoAction', '9': 1, '10': 'sequencerGo'},
    const {'1': 'sequencer_stop', '3': 11, '4': 1, '5': 11, '6': '.mizer.mappings.SequencerStopAction', '9': 1, '10': 'sequencerStop'},
    const {'1': 'layout_control', '3': 12, '4': 1, '5': 11, '6': '.mizer.mappings.LayoutControlAction', '9': 1, '10': 'layoutControl'},
    const {'1': 'programmer_highlight', '3': 13, '4': 1, '5': 11, '6': '.mizer.mappings.ProgrammerHighlightAction', '9': 1, '10': 'programmerHighlight'},
    const {'1': 'programmer_clear', '3': 14, '4': 1, '5': 11, '6': '.mizer.mappings.ProgrammerClearAction', '9': 1, '10': 'programmerClear'},
  ],
  '8': const [
    const {'1': 'binding'},
    const {'1': 'action'},
  ],
};

/// Descriptor for `MappingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mappingRequestDescriptor = $convert.base64Decode('Cg5NYXBwaW5nUmVxdWVzdBIxCgRtaWRpGAEgASgLMhsubWl6ZXIubWFwcGluZ3MuTWlkaU1hcHBpbmdIAFIEbWlkaRJGCgxzZXF1ZW5jZXJfZ28YCiABKAsyIS5taXplci5tYXBwaW5ncy5TZXF1ZW5jZXJHb0FjdGlvbkgBUgtzZXF1ZW5jZXJHbxJMCg5zZXF1ZW5jZXJfc3RvcBgLIAEoCzIjLm1pemVyLm1hcHBpbmdzLlNlcXVlbmNlclN0b3BBY3Rpb25IAVINc2VxdWVuY2VyU3RvcBJMCg5sYXlvdXRfY29udHJvbBgMIAEoCzIjLm1pemVyLm1hcHBpbmdzLkxheW91dENvbnRyb2xBY3Rpb25IAVINbGF5b3V0Q29udHJvbBJeChRwcm9ncmFtbWVyX2hpZ2hsaWdodBgNIAEoCzIpLm1pemVyLm1hcHBpbmdzLlByb2dyYW1tZXJIaWdobGlnaHRBY3Rpb25IAVITcHJvZ3JhbW1lckhpZ2hsaWdodBJSChBwcm9ncmFtbWVyX2NsZWFyGA4gASgLMiUubWl6ZXIubWFwcGluZ3MuUHJvZ3JhbW1lckNsZWFyQWN0aW9uSAFSD3Byb2dyYW1tZXJDbGVhckIJCgdiaW5kaW5nQggKBmFjdGlvbg==');
@$core.Deprecated('Use midiMappingDescriptor instead')
const MidiMapping$json = const {
  '1': 'MidiMapping',
  '2': const [
    const {'1': 'config', '3': 1, '4': 1, '5': 11, '6': '.mizer.nodes.MidiNodeConfig', '10': 'config'},
    const {'1': 'input_mapping', '3': 2, '4': 1, '5': 8, '10': 'inputMapping'},
  ],
};

/// Descriptor for `MidiMapping`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiMappingDescriptor = $convert.base64Decode('CgtNaWRpTWFwcGluZxIzCgZjb25maWcYASABKAsyGy5taXplci5ub2Rlcy5NaWRpTm9kZUNvbmZpZ1IGY29uZmlnEiMKDWlucHV0X21hcHBpbmcYAiABKAhSDGlucHV0TWFwcGluZw==');
@$core.Deprecated('Use sequencerGoActionDescriptor instead')
const SequencerGoAction$json = const {
  '1': 'SequencerGoAction',
  '2': const [
    const {'1': 'sequencer_id', '3': 1, '4': 1, '5': 13, '10': 'sequencerId'},
  ],
};

/// Descriptor for `SequencerGoAction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequencerGoActionDescriptor = $convert.base64Decode('ChFTZXF1ZW5jZXJHb0FjdGlvbhIhCgxzZXF1ZW5jZXJfaWQYASABKA1SC3NlcXVlbmNlcklk');
@$core.Deprecated('Use sequencerStopActionDescriptor instead')
const SequencerStopAction$json = const {
  '1': 'SequencerStopAction',
  '2': const [
    const {'1': 'sequencer_id', '3': 1, '4': 1, '5': 13, '10': 'sequencerId'},
  ],
};

/// Descriptor for `SequencerStopAction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequencerStopActionDescriptor = $convert.base64Decode('ChNTZXF1ZW5jZXJTdG9wQWN0aW9uEiEKDHNlcXVlbmNlcl9pZBgBIAEoDVILc2VxdWVuY2VySWQ=');
@$core.Deprecated('Use layoutControlActionDescriptor instead')
const LayoutControlAction$json = const {
  '1': 'LayoutControlAction',
  '2': const [
    const {'1': 'control_node', '3': 1, '4': 1, '5': 9, '10': 'controlNode'},
  ],
};

/// Descriptor for `LayoutControlAction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List layoutControlActionDescriptor = $convert.base64Decode('ChNMYXlvdXRDb250cm9sQWN0aW9uEiEKDGNvbnRyb2xfbm9kZRgBIAEoCVILY29udHJvbE5vZGU=');
@$core.Deprecated('Use programmerHighlightActionDescriptor instead')
const ProgrammerHighlightAction$json = const {
  '1': 'ProgrammerHighlightAction',
};

/// Descriptor for `ProgrammerHighlightAction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List programmerHighlightActionDescriptor = $convert.base64Decode('ChlQcm9ncmFtbWVySGlnaGxpZ2h0QWN0aW9u');
@$core.Deprecated('Use programmerClearActionDescriptor instead')
const ProgrammerClearAction$json = const {
  '1': 'ProgrammerClearAction',
};

/// Descriptor for `ProgrammerClearAction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List programmerClearActionDescriptor = $convert.base64Decode('ChVQcm9ncmFtbWVyQ2xlYXJBY3Rpb24=');
