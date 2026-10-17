///
import 'dart:convert' as $convert;
//  Generated code. Do not modify.
//  source: effects.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use effectControlDescriptor instead')
const EffectControl$json = const {
  '1': 'EffectControl',
  '2': const [
    const {'1': 'INTENSITY', '2': 0},
    const {'1': 'SHUTTER', '2': 1},
    const {'1': 'COLOR_MIXER_RED', '2': 2},
    const {'1': 'COLOR_MIXER_GREEN', '2': 3},
    const {'1': 'COLOR_MIXER_BLUE', '2': 4},
    const {'1': 'COLOR_MIXER_AMBER', '2': 15},
    const {'1': 'COLOR_WHEEL', '2': 5},
    const {'1': 'PAN', '2': 6},
    const {'1': 'TILT', '2': 7},
    const {'1': 'FOCUS', '2': 8},
    const {'1': 'ZOOM', '2': 9},
    const {'1': 'PRISM', '2': 10},
    const {'1': 'IRIS', '2': 11},
    const {'1': 'FROST', '2': 12},
    const {'1': 'GOBO', '2': 13},
    const {'1': 'GENERIC', '2': 14},
  ],
};

/// Descriptor for `EffectControl`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List effectControlDescriptor = $convert.base64Decode('Cg1FZmZlY3RDb250cm9sEg0KCUlOVEVOU0lUWRAAEgsKB1NIVVRURVIQARITCg9DT0xPUl9NSVhFUl9SRUQQAhIVChFDT0xPUl9NSVhFUl9HUkVFThADEhQKEENPTE9SX01JWEVSX0JMVUUQBBIVChFDT0xPUl9NSVhFUl9BTUJFUhAPEg8KC0NPTE9SX1dIRUVMEAUSBwoDUEFOEAYSCAoEVElMVBAHEgkKBUZPQ1VTEAgSCAoEWk9PTRAJEgkKBVBSSVNNEAoSCAoESVJJUxALEgkKBUZST1NUEAwSCAoER09CTxANEgsKB0dFTkVSSUMQDg==');
@$core.Deprecated('Use addEffectRequestDescriptor instead')
const AddEffectRequest$json = const {
  '1': 'AddEffectRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AddEffectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addEffectRequestDescriptor = $convert.base64Decode('ChBBZGRFZmZlY3RSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWU=');
@$core.Deprecated('Use updateEffectStepRequestDescriptor instead')
const UpdateEffectStepRequest$json = const {
  '1': 'UpdateEffectStepRequest',
  '2': const [
    const {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    const {'1': 'channel_index', '3': 2, '4': 1, '5': 13, '10': 'channelIndex'},
    const {'1': 'step_index', '3': 3, '4': 1, '5': 13, '10': 'stepIndex'},
    const {'1': 'step', '3': 4, '4': 1, '5': 11, '6': '.mizer.effects.EffectStep', '10': 'step'},
  ],
};

/// Descriptor for `UpdateEffectStepRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEffectStepRequestDescriptor = $convert.base64Decode('ChdVcGRhdGVFZmZlY3RTdGVwUmVxdWVzdBIbCgllZmZlY3RfaWQYASABKA1SCGVmZmVjdElkEiMKDWNoYW5uZWxfaW5kZXgYAiABKA1SDGNoYW5uZWxJbmRleBIdCgpzdGVwX2luZGV4GAMgASgNUglzdGVwSW5kZXgSLQoEc3RlcBgEIAEoCzIZLm1pemVyLmVmZmVjdHMuRWZmZWN0U3RlcFIEc3RlcA==');
@$core.Deprecated('Use addEffectChannelRequestDescriptor instead')
const AddEffectChannelRequest$json = const {
  '1': 'AddEffectChannelRequest',
  '2': const [
    const {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    const {'1': 'control', '3': 2, '4': 1, '5': 14, '6': '.mizer.effects.EffectControl', '10': 'control'},
  ],
};

/// Descriptor for `AddEffectChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addEffectChannelRequestDescriptor = $convert.base64Decode('ChdBZGRFZmZlY3RDaGFubmVsUmVxdWVzdBIbCgllZmZlY3RfaWQYASABKA1SCGVmZmVjdElkEjYKB2NvbnRyb2wYAiABKA4yHC5taXplci5lZmZlY3RzLkVmZmVjdENvbnRyb2xSB2NvbnRyb2w=');
@$core.Deprecated('Use deleteEffectChannelRequestDescriptor instead')
const DeleteEffectChannelRequest$json = const {
  '1': 'DeleteEffectChannelRequest',
  '2': const [
    const {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    const {'1': 'channel_index', '3': 2, '4': 1, '5': 13, '10': 'channelIndex'},
  ],
};

/// Descriptor for `DeleteEffectChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteEffectChannelRequestDescriptor = $convert.base64Decode('ChpEZWxldGVFZmZlY3RDaGFubmVsUmVxdWVzdBIbCgllZmZlY3RfaWQYASABKA1SCGVmZmVjdElkEiMKDWNoYW5uZWxfaW5kZXgYAiABKA1SDGNoYW5uZWxJbmRleA==');
@$core.Deprecated('Use addEffectStepRequestDescriptor instead')
const AddEffectStepRequest$json = const {
  '1': 'AddEffectStepRequest',
  '2': const [
    const {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    const {'1': 'channel_index', '3': 2, '4': 1, '5': 13, '10': 'channelIndex'},
    const {'1': 'step', '3': 3, '4': 1, '5': 11, '6': '.mizer.effects.EffectStep', '10': 'step'},
  ],
};

/// Descriptor for `AddEffectStepRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addEffectStepRequestDescriptor = $convert.base64Decode('ChRBZGRFZmZlY3RTdGVwUmVxdWVzdBIbCgllZmZlY3RfaWQYASABKA1SCGVmZmVjdElkEiMKDWNoYW5uZWxfaW5kZXgYAiABKA1SDGNoYW5uZWxJbmRleBItCgRzdGVwGAMgASgLMhkubWl6ZXIuZWZmZWN0cy5FZmZlY3RTdGVwUgRzdGVw');
@$core.Deprecated('Use deleteEffectStepRequestDescriptor instead')
const DeleteEffectStepRequest$json = const {
  '1': 'DeleteEffectStepRequest',
  '2': const [
    const {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    const {'1': 'channel_index', '3': 2, '4': 1, '5': 13, '10': 'channelIndex'},
    const {'1': 'step_index', '3': 3, '4': 1, '5': 13, '10': 'stepIndex'},
  ],
};

/// Descriptor for `DeleteEffectStepRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteEffectStepRequestDescriptor = $convert.base64Decode('ChdEZWxldGVFZmZlY3RTdGVwUmVxdWVzdBIbCgllZmZlY3RfaWQYASABKA1SCGVmZmVjdElkEiMKDWNoYW5uZWxfaW5kZXgYAiABKA1SDGNoYW5uZWxJbmRleBIdCgpzdGVwX2luZGV4GAMgASgNUglzdGVwSW5kZXg=');
@$core.Deprecated('Use effectsDescriptor instead')
const Effects$json = const {
  '1': 'Effects',
  '2': const [
    const {'1': 'effects', '3': 1, '4': 3, '5': 11, '6': '.mizer.effects.Effect', '10': 'effects'},
  ],
};

/// Descriptor for `Effects`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List effectsDescriptor = $convert.base64Decode('CgdFZmZlY3RzEi8KB2VmZmVjdHMYASADKAsyFS5taXplci5lZmZlY3RzLkVmZmVjdFIHZWZmZWN0cw==');
@$core.Deprecated('Use effectDescriptor instead')
const Effect$json = const {
  '1': 'Effect',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'channels', '3': 3, '4': 3, '5': 11, '6': '.mizer.effects.EffectChannel', '10': 'channels'},
  ],
};

/// Descriptor for `Effect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List effectDescriptor = $convert.base64Decode('CgZFZmZlY3QSDgoCaWQYASABKA1SAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSOAoIY2hhbm5lbHMYAyADKAsyHC5taXplci5lZmZlY3RzLkVmZmVjdENoYW5uZWxSCGNoYW5uZWxz');
@$core.Deprecated('Use effectChannelDescriptor instead')
const EffectChannel$json = const {
  '1': 'EffectChannel',
  '2': const [
    const {'1': 'control', '3': 1, '4': 1, '5': 14, '6': '.mizer.effects.EffectControl', '10': 'control'},
    const {'1': 'steps', '3': 2, '4': 3, '5': 11, '6': '.mizer.effects.EffectStep', '10': 'steps'},
  ],
};

/// Descriptor for `EffectChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List effectChannelDescriptor = $convert.base64Decode('Cg1FZmZlY3RDaGFubmVsEjYKB2NvbnRyb2wYASABKA4yHC5taXplci5lZmZlY3RzLkVmZmVjdENvbnRyb2xSB2NvbnRyb2wSLwoFc3RlcHMYAiADKAsyGS5taXplci5lZmZlY3RzLkVmZmVjdFN0ZXBSBXN0ZXBz');
@$core.Deprecated('Use effectStepDescriptor instead')
const EffectStep$json = const {
  '1': 'EffectStep',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 11, '6': '.mizer.sequencer.CueValue', '10': 'value'},
    const {'1': 'simple', '3': 2, '4': 1, '5': 11, '6': '.mizer.effects.SimpleControlPoint', '9': 0, '10': 'simple'},
    const {'1': 'quadratic', '3': 3, '4': 1, '5': 11, '6': '.mizer.effects.QuadraticControlPoint', '9': 0, '10': 'quadratic'},
    const {'1': 'cubic', '3': 4, '4': 1, '5': 11, '6': '.mizer.effects.CubicControlPoint', '9': 0, '10': 'cubic'},
  ],
  '8': const [
    const {'1': 'control_point'},
  ],
};

/// Descriptor for `EffectStep`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List effectStepDescriptor = $convert.base64Decode('CgpFZmZlY3RTdGVwEi8KBXZhbHVlGAEgASgLMhkubWl6ZXIuc2VxdWVuY2VyLkN1ZVZhbHVlUgV2YWx1ZRI7CgZzaW1wbGUYAiABKAsyIS5taXplci5lZmZlY3RzLlNpbXBsZUNvbnRyb2xQb2ludEgAUgZzaW1wbGUSRAoJcXVhZHJhdGljGAMgASgLMiQubWl6ZXIuZWZmZWN0cy5RdWFkcmF0aWNDb250cm9sUG9pbnRIAFIJcXVhZHJhdGljEjgKBWN1YmljGAQgASgLMiAubWl6ZXIuZWZmZWN0cy5DdWJpY0NvbnRyb2xQb2ludEgAUgVjdWJpY0IPCg1jb250cm9sX3BvaW50');
@$core.Deprecated('Use simpleControlPointDescriptor instead')
const SimpleControlPoint$json = const {
  '1': 'SimpleControlPoint',
};

/// Descriptor for `SimpleControlPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simpleControlPointDescriptor = $convert.base64Decode('ChJTaW1wbGVDb250cm9sUG9pbnQ=');
@$core.Deprecated('Use quadraticControlPointDescriptor instead')
const QuadraticControlPoint$json = const {
  '1': 'QuadraticControlPoint',
  '2': const [
    const {'1': 'c0a', '3': 1, '4': 1, '5': 1, '10': 'c0a'},
    const {'1': 'c0b', '3': 2, '4': 1, '5': 1, '10': 'c0b'},
  ],
};

/// Descriptor for `QuadraticControlPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quadraticControlPointDescriptor = $convert.base64Decode('ChVRdWFkcmF0aWNDb250cm9sUG9pbnQSEAoDYzBhGAEgASgBUgNjMGESEAoDYzBiGAIgASgBUgNjMGI=');
@$core.Deprecated('Use cubicControlPointDescriptor instead')
const CubicControlPoint$json = const {
  '1': 'CubicControlPoint',
  '2': const [
    const {'1': 'c0a', '3': 1, '4': 1, '5': 1, '10': 'c0a'},
    const {'1': 'c0b', '3': 2, '4': 1, '5': 1, '10': 'c0b'},
    const {'1': 'c1a', '3': 3, '4': 1, '5': 1, '10': 'c1a'},
    const {'1': 'c1b', '3': 4, '4': 1, '5': 1, '10': 'c1b'},
  ],
};

/// Descriptor for `CubicControlPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cubicControlPointDescriptor = $convert.base64Decode('ChFDdWJpY0NvbnRyb2xQb2ludBIQCgNjMGEYASABKAFSA2MwYRIQCgNjMGIYAiABKAFSA2MwYhIQCgNjMWEYAyABKAFSA2MxYRIQCgNjMWIYBCABKAFSA2MxYg==');
