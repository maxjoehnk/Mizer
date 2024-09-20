//
//  Generated code. Do not modify.
//  source: effects.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use addEffectRequestDescriptor instead')
const AddEffectRequest$json = {
  '1': 'AddEffectRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AddEffectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addEffectRequestDescriptor = $convert.base64Decode(
    'ChBBZGRFZmZlY3RSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWU=');

@$core.Deprecated('Use updateEffectStepRequestDescriptor instead')
const UpdateEffectStepRequest$json = {
  '1': 'UpdateEffectStepRequest',
  '2': [
    {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    {'1': 'channel_index', '3': 2, '4': 1, '5': 13, '10': 'channelIndex'},
    {'1': 'step_index', '3': 3, '4': 1, '5': 13, '10': 'stepIndex'},
    {'1': 'step', '3': 4, '4': 1, '5': 11, '6': '.mizer.effects.EffectStep', '10': 'step'},
  ],
};

/// Descriptor for `UpdateEffectStepRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEffectStepRequestDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVFZmZlY3RTdGVwUmVxdWVzdBIbCgllZmZlY3RfaWQYASABKA1SCGVmZmVjdElkEi'
    'MKDWNoYW5uZWxfaW5kZXgYAiABKA1SDGNoYW5uZWxJbmRleBIdCgpzdGVwX2luZGV4GAMgASgN'
    'UglzdGVwSW5kZXgSLQoEc3RlcBgEIAEoCzIZLm1pemVyLmVmZmVjdHMuRWZmZWN0U3RlcFIEc3'
    'RlcA==');

@$core.Deprecated('Use addEffectChannelRequestDescriptor instead')
const AddEffectChannelRequest$json = {
  '1': 'AddEffectChannelRequest',
  '2': [
    {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    {'1': 'fixture_channel', '3': 2, '4': 1, '5': 9, '10': 'fixtureChannel'},
  ],
};

/// Descriptor for `AddEffectChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addEffectChannelRequestDescriptor = $convert.base64Decode(
    'ChdBZGRFZmZlY3RDaGFubmVsUmVxdWVzdBIbCgllZmZlY3RfaWQYASABKA1SCGVmZmVjdElkEi'
    'cKD2ZpeHR1cmVfY2hhbm5lbBgCIAEoCVIOZml4dHVyZUNoYW5uZWw=');

@$core.Deprecated('Use deleteEffectChannelRequestDescriptor instead')
const DeleteEffectChannelRequest$json = {
  '1': 'DeleteEffectChannelRequest',
  '2': [
    {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    {'1': 'channel_index', '3': 2, '4': 1, '5': 13, '10': 'channelIndex'},
  ],
};

/// Descriptor for `DeleteEffectChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteEffectChannelRequestDescriptor = $convert.base64Decode(
    'ChpEZWxldGVFZmZlY3RDaGFubmVsUmVxdWVzdBIbCgllZmZlY3RfaWQYASABKA1SCGVmZmVjdE'
    'lkEiMKDWNoYW5uZWxfaW5kZXgYAiABKA1SDGNoYW5uZWxJbmRleA==');

@$core.Deprecated('Use addEffectStepRequestDescriptor instead')
const AddEffectStepRequest$json = {
  '1': 'AddEffectStepRequest',
  '2': [
    {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    {'1': 'channel_index', '3': 2, '4': 1, '5': 13, '10': 'channelIndex'},
    {'1': 'step', '3': 3, '4': 1, '5': 11, '6': '.mizer.effects.EffectStep', '10': 'step'},
  ],
};

/// Descriptor for `AddEffectStepRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addEffectStepRequestDescriptor = $convert.base64Decode(
    'ChRBZGRFZmZlY3RTdGVwUmVxdWVzdBIbCgllZmZlY3RfaWQYASABKA1SCGVmZmVjdElkEiMKDW'
    'NoYW5uZWxfaW5kZXgYAiABKA1SDGNoYW5uZWxJbmRleBItCgRzdGVwGAMgASgLMhkubWl6ZXIu'
    'ZWZmZWN0cy5FZmZlY3RTdGVwUgRzdGVw');

@$core.Deprecated('Use deleteEffectStepRequestDescriptor instead')
const DeleteEffectStepRequest$json = {
  '1': 'DeleteEffectStepRequest',
  '2': [
    {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    {'1': 'channel_index', '3': 2, '4': 1, '5': 13, '10': 'channelIndex'},
    {'1': 'step_index', '3': 3, '4': 1, '5': 13, '10': 'stepIndex'},
  ],
};

/// Descriptor for `DeleteEffectStepRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteEffectStepRequestDescriptor = $convert.base64Decode(
    'ChdEZWxldGVFZmZlY3RTdGVwUmVxdWVzdBIbCgllZmZlY3RfaWQYASABKA1SCGVmZmVjdElkEi'
    'MKDWNoYW5uZWxfaW5kZXgYAiABKA1SDGNoYW5uZWxJbmRleBIdCgpzdGVwX2luZGV4GAMgASgN'
    'UglzdGVwSW5kZXg=');

@$core.Deprecated('Use effectsDescriptor instead')
const Effects$json = {
  '1': 'Effects',
  '2': [
    {'1': 'effects', '3': 1, '4': 3, '5': 11, '6': '.mizer.effects.Effect', '10': 'effects'},
  ],
};

/// Descriptor for `Effects`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List effectsDescriptor = $convert.base64Decode(
    'CgdFZmZlY3RzEi8KB2VmZmVjdHMYASADKAsyFS5taXplci5lZmZlY3RzLkVmZmVjdFIHZWZmZW'
    'N0cw==');

@$core.Deprecated('Use effectDescriptor instead')
const Effect$json = {
  '1': 'Effect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'channels', '3': 3, '4': 3, '5': 11, '6': '.mizer.effects.EffectChannel', '10': 'channels'},
  ],
};

/// Descriptor for `Effect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List effectDescriptor = $convert.base64Decode(
    'CgZFZmZlY3QSDgoCaWQYASABKA1SAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSOAoIY2hhbm5lbH'
    'MYAyADKAsyHC5taXplci5lZmZlY3RzLkVmZmVjdENoYW5uZWxSCGNoYW5uZWxz');

@$core.Deprecated('Use effectChannelDescriptor instead')
const EffectChannel$json = {
  '1': 'EffectChannel',
  '2': [
    {'1': 'fixture_channel', '3': 1, '4': 1, '5': 9, '10': 'fixtureChannel'},
    {'1': 'steps', '3': 2, '4': 3, '5': 11, '6': '.mizer.effects.EffectStep', '10': 'steps'},
  ],
};

/// Descriptor for `EffectChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List effectChannelDescriptor = $convert.base64Decode(
    'Cg1FZmZlY3RDaGFubmVsEicKD2ZpeHR1cmVfY2hhbm5lbBgBIAEoCVIOZml4dHVyZUNoYW5uZW'
    'wSLwoFc3RlcHMYAiADKAsyGS5taXplci5lZmZlY3RzLkVmZmVjdFN0ZXBSBXN0ZXBz');

@$core.Deprecated('Use effectStepDescriptor instead')
const EffectStep$json = {
  '1': 'EffectStep',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 11, '6': '.mizer.sequencer.CueValue', '10': 'value'},
    {'1': 'simple', '3': 2, '4': 1, '5': 11, '6': '.mizer.effects.SimpleControlPoint', '9': 0, '10': 'simple'},
    {'1': 'quadratic', '3': 3, '4': 1, '5': 11, '6': '.mizer.effects.QuadraticControlPoint', '9': 0, '10': 'quadratic'},
    {'1': 'cubic', '3': 4, '4': 1, '5': 11, '6': '.mizer.effects.CubicControlPoint', '9': 0, '10': 'cubic'},
  ],
  '8': [
    {'1': 'control_point'},
  ],
};

/// Descriptor for `EffectStep`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List effectStepDescriptor = $convert.base64Decode(
    'CgpFZmZlY3RTdGVwEi8KBXZhbHVlGAEgASgLMhkubWl6ZXIuc2VxdWVuY2VyLkN1ZVZhbHVlUg'
    'V2YWx1ZRI7CgZzaW1wbGUYAiABKAsyIS5taXplci5lZmZlY3RzLlNpbXBsZUNvbnRyb2xQb2lu'
    'dEgAUgZzaW1wbGUSRAoJcXVhZHJhdGljGAMgASgLMiQubWl6ZXIuZWZmZWN0cy5RdWFkcmF0aW'
    'NDb250cm9sUG9pbnRIAFIJcXVhZHJhdGljEjgKBWN1YmljGAQgASgLMiAubWl6ZXIuZWZmZWN0'
    'cy5DdWJpY0NvbnRyb2xQb2ludEgAUgVjdWJpY0IPCg1jb250cm9sX3BvaW50');

@$core.Deprecated('Use simpleControlPointDescriptor instead')
const SimpleControlPoint$json = {
  '1': 'SimpleControlPoint',
};

/// Descriptor for `SimpleControlPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simpleControlPointDescriptor = $convert.base64Decode(
    'ChJTaW1wbGVDb250cm9sUG9pbnQ=');

@$core.Deprecated('Use quadraticControlPointDescriptor instead')
const QuadraticControlPoint$json = {
  '1': 'QuadraticControlPoint',
  '2': [
    {'1': 'c0a', '3': 1, '4': 1, '5': 1, '10': 'c0a'},
    {'1': 'c0b', '3': 2, '4': 1, '5': 1, '10': 'c0b'},
  ],
};

/// Descriptor for `QuadraticControlPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quadraticControlPointDescriptor = $convert.base64Decode(
    'ChVRdWFkcmF0aWNDb250cm9sUG9pbnQSEAoDYzBhGAEgASgBUgNjMGESEAoDYzBiGAIgASgBUg'
    'NjMGI=');

@$core.Deprecated('Use cubicControlPointDescriptor instead')
const CubicControlPoint$json = {
  '1': 'CubicControlPoint',
  '2': [
    {'1': 'c0a', '3': 1, '4': 1, '5': 1, '10': 'c0a'},
    {'1': 'c0b', '3': 2, '4': 1, '5': 1, '10': 'c0b'},
    {'1': 'c1a', '3': 3, '4': 1, '5': 1, '10': 'c1a'},
    {'1': 'c1b', '3': 4, '4': 1, '5': 1, '10': 'c1b'},
  ],
};

/// Descriptor for `CubicControlPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cubicControlPointDescriptor = $convert.base64Decode(
    'ChFDdWJpY0NvbnRyb2xQb2ludBIQCgNjMGEYASABKAFSA2MwYRIQCgNjMGIYAiABKAFSA2MwYh'
    'IQCgNjMWEYAyABKAFSA2MxYRIQCgNjMWIYBCABKAFSA2MxYg==');

