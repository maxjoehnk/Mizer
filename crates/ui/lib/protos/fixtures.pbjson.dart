//
//  Generated code. Do not modify.
//  source: fixtures.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use fixtureControlDescriptor instead')
const FixtureControl$json = {
  '1': 'FixtureControl',
  '2': [
    {'1': 'NONE', '2': 0},
    {'1': 'INTENSITY', '2': 1},
    {'1': 'SHUTTER', '2': 2},
    {'1': 'COLOR_MIXER', '2': 3},
    {'1': 'COLOR_WHEEL', '2': 4},
    {'1': 'PAN', '2': 5},
    {'1': 'TILT', '2': 6},
    {'1': 'FOCUS', '2': 7},
    {'1': 'ZOOM', '2': 8},
    {'1': 'PRISM', '2': 9},
    {'1': 'IRIS', '2': 10},
    {'1': 'FROST', '2': 11},
    {'1': 'GOBO', '2': 12},
    {'1': 'GENERIC', '2': 13},
  ],
};

/// Descriptor for `FixtureControl`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fixtureControlDescriptor = $convert.base64Decode(
    'Cg5GaXh0dXJlQ29udHJvbBIICgROT05FEAASDQoJSU5URU5TSVRZEAESCwoHU0hVVFRFUhACEg'
    '8KC0NPTE9SX01JWEVSEAMSDwoLQ09MT1JfV0hFRUwQBBIHCgNQQU4QBRIICgRUSUxUEAYSCQoF'
    'Rk9DVVMQBxIICgRaT09NEAgSCQoFUFJJU00QCRIICgRJUklTEAoSCQoFRlJPU1QQCxIICgRHT0'
    'JPEAwSCwoHR0VORVJJQxAN');

@$core.Deprecated('Use addFixturesRequestDescriptor instead')
const AddFixturesRequest$json = {
  '1': 'AddFixturesRequest',
  '2': [
    {'1': 'request', '3': 1, '4': 1, '5': 11, '6': '.mizer.fixtures.AddFixtureRequest', '10': 'request'},
    {'1': 'count', '3': 2, '4': 1, '5': 13, '10': 'count'},
  ],
};

/// Descriptor for `AddFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addFixturesRequestDescriptor = $convert.base64Decode(
    'ChJBZGRGaXh0dXJlc1JlcXVlc3QSOwoHcmVxdWVzdBgBIAEoCzIhLm1pemVyLmZpeHR1cmVzLk'
    'FkZEZpeHR1cmVSZXF1ZXN0UgdyZXF1ZXN0EhQKBWNvdW50GAIgASgNUgVjb3VudA==');

@$core.Deprecated('Use addFixtureRequestDescriptor instead')
const AddFixtureRequest$json = {
  '1': 'AddFixtureRequest',
  '2': [
    {'1': 'definition_id', '3': 1, '4': 1, '5': 9, '10': 'definitionId'},
    {'1': 'mode', '3': 2, '4': 1, '5': 9, '10': 'mode'},
    {'1': 'id', '3': 3, '4': 1, '5': 13, '10': 'id'},
    {'1': 'channel', '3': 4, '4': 1, '5': 13, '10': 'channel'},
    {'1': 'universe', '3': 5, '4': 1, '5': 13, '10': 'universe'},
    {'1': 'name', '3': 6, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AddFixtureRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addFixtureRequestDescriptor = $convert.base64Decode(
    'ChFBZGRGaXh0dXJlUmVxdWVzdBIjCg1kZWZpbml0aW9uX2lkGAEgASgJUgxkZWZpbml0aW9uSW'
    'QSEgoEbW9kZRgCIAEoCVIEbW9kZRIOCgJpZBgDIAEoDVICaWQSGAoHY2hhbm5lbBgEIAEoDVIH'
    'Y2hhbm5lbBIaCgh1bml2ZXJzZRgFIAEoDVIIdW5pdmVyc2USEgoEbmFtZRgGIAEoCVIEbmFtZQ'
    '==');

@$core.Deprecated('Use getFixturesRequestDescriptor instead')
const GetFixturesRequest$json = {
  '1': 'GetFixturesRequest',
};

/// Descriptor for `GetFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFixturesRequestDescriptor = $convert.base64Decode(
    'ChJHZXRGaXh0dXJlc1JlcXVlc3Q=');

@$core.Deprecated('Use deleteFixturesRequestDescriptor instead')
const DeleteFixturesRequest$json = {
  '1': 'DeleteFixturesRequest',
  '2': [
    {'1': 'fixture_ids', '3': 1, '4': 3, '5': 13, '10': 'fixtureIds'},
  ],
};

/// Descriptor for `DeleteFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteFixturesRequestDescriptor = $convert.base64Decode(
    'ChVEZWxldGVGaXh0dXJlc1JlcXVlc3QSHwoLZml4dHVyZV9pZHMYASADKA1SCmZpeHR1cmVJZH'
    'M=');

@$core.Deprecated('Use updateFixtureRequestDescriptor instead')
const UpdateFixtureRequest$json = {
  '1': 'UpdateFixtureRequest',
  '2': [
    {'1': 'fixture_id', '3': 1, '4': 1, '5': 13, '10': 'fixtureId'},
    {'1': 'invert_pan', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'invertPan', '17': true},
    {'1': 'invert_tilt', '3': 3, '4': 1, '5': 8, '9': 1, '10': 'invertTilt', '17': true},
    {'1': 'reverse_pixel_order', '3': 4, '4': 1, '5': 8, '9': 2, '10': 'reversePixelOrder', '17': true},
    {'1': 'name', '3': 5, '4': 1, '5': 9, '9': 3, '10': 'name', '17': true},
    {'1': 'address', '3': 6, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureAddress', '9': 4, '10': 'address', '17': true},
    {'1': 'limit', '3': 7, '4': 1, '5': 11, '6': '.mizer.fixtures.UpdateFixtureRequest.UpdateFixtureLimit', '9': 5, '10': 'limit', '17': true},
  ],
  '3': [UpdateFixtureRequest_UpdateFixtureLimit$json],
  '8': [
    {'1': '_invert_pan'},
    {'1': '_invert_tilt'},
    {'1': '_reverse_pixel_order'},
    {'1': '_name'},
    {'1': '_address'},
    {'1': '_limit'},
  ],
};

@$core.Deprecated('Use updateFixtureRequestDescriptor instead')
const UpdateFixtureRequest_UpdateFixtureLimit$json = {
  '1': 'UpdateFixtureLimit',
  '2': [
    {'1': 'control', '3': 1, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureFaderControl', '10': 'control'},
    {'1': 'min', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'min', '17': true},
    {'1': 'max', '3': 3, '4': 1, '5': 1, '9': 1, '10': 'max', '17': true},
  ],
  '8': [
    {'1': '_min'},
    {'1': '_max'},
  ],
};

/// Descriptor for `UpdateFixtureRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFixtureRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVGaXh0dXJlUmVxdWVzdBIdCgpmaXh0dXJlX2lkGAEgASgNUglmaXh0dXJlSWQSIg'
    'oKaW52ZXJ0X3BhbhgCIAEoCEgAUglpbnZlcnRQYW6IAQESJAoLaW52ZXJ0X3RpbHQYAyABKAhI'
    'AVIKaW52ZXJ0VGlsdIgBARIzChNyZXZlcnNlX3BpeGVsX29yZGVyGAQgASgISAJSEXJldmVyc2'
    'VQaXhlbE9yZGVyiAEBEhcKBG5hbWUYBSABKAlIA1IEbmFtZYgBARI9CgdhZGRyZXNzGAYgASgL'
    'Mh4ubWl6ZXIuZml4dHVyZXMuRml4dHVyZUFkZHJlc3NIBFIHYWRkcmVzc4gBARJSCgVsaW1pdB'
    'gHIAEoCzI3Lm1pemVyLmZpeHR1cmVzLlVwZGF0ZUZpeHR1cmVSZXF1ZXN0LlVwZGF0ZUZpeHR1'
    'cmVMaW1pdEgFUgVsaW1pdIgBARqRAQoSVXBkYXRlRml4dHVyZUxpbWl0Ej0KB2NvbnRyb2wYAS'
    'ABKAsyIy5taXplci5maXh0dXJlcy5GaXh0dXJlRmFkZXJDb250cm9sUgdjb250cm9sEhUKA21p'
    'bhgCIAEoAUgAUgNtaW6IAQESFQoDbWF4GAMgASgBSAFSA21heIgBAUIGCgRfbWluQgYKBF9tYX'
    'hCDQoLX2ludmVydF9wYW5CDgoMX2ludmVydF90aWx0QhYKFF9yZXZlcnNlX3BpeGVsX29yZGVy'
    'QgcKBV9uYW1lQgoKCF9hZGRyZXNzQggKBl9saW1pdA==');

@$core.Deprecated('Use fixtureAddressDescriptor instead')
const FixtureAddress$json = {
  '1': 'FixtureAddress',
  '2': [
    {'1': 'universe', '3': 1, '4': 1, '5': 13, '10': 'universe'},
    {'1': 'channel', '3': 2, '4': 1, '5': 13, '10': 'channel'},
  ],
};

/// Descriptor for `FixtureAddress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureAddressDescriptor = $convert.base64Decode(
    'Cg5GaXh0dXJlQWRkcmVzcxIaCgh1bml2ZXJzZRgBIAEoDVIIdW5pdmVyc2USGAoHY2hhbm5lbB'
    'gCIAEoDVIHY2hhbm5lbA==');

@$core.Deprecated('Use fixtureIdDescriptor instead')
const FixtureId$json = {
  '1': 'FixtureId',
  '2': [
    {'1': 'fixture', '3': 1, '4': 1, '5': 13, '9': 0, '10': 'fixture'},
    {'1': 'sub_fixture', '3': 2, '4': 1, '5': 11, '6': '.mizer.fixtures.SubFixtureId', '9': 0, '10': 'subFixture'},
  ],
  '8': [
    {'1': 'id'},
  ],
};

/// Descriptor for `FixtureId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureIdDescriptor = $convert.base64Decode(
    'CglGaXh0dXJlSWQSGgoHZml4dHVyZRgBIAEoDUgAUgdmaXh0dXJlEj8KC3N1Yl9maXh0dXJlGA'
    'IgASgLMhwubWl6ZXIuZml4dHVyZXMuU3ViRml4dHVyZUlkSABSCnN1YkZpeHR1cmVCBAoCaWQ=');

@$core.Deprecated('Use subFixtureIdDescriptor instead')
const SubFixtureId$json = {
  '1': 'SubFixtureId',
  '2': [
    {'1': 'fixture_id', '3': 1, '4': 1, '5': 13, '10': 'fixtureId'},
    {'1': 'child_id', '3': 2, '4': 1, '5': 13, '10': 'childId'},
  ],
};

/// Descriptor for `SubFixtureId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subFixtureIdDescriptor = $convert.base64Decode(
    'CgxTdWJGaXh0dXJlSWQSHQoKZml4dHVyZV9pZBgBIAEoDVIJZml4dHVyZUlkEhkKCGNoaWxkX2'
    'lkGAIgASgNUgdjaGlsZElk');

@$core.Deprecated('Use fixturesDescriptor instead')
const Fixtures$json = {
  '1': 'Fixtures',
  '2': [
    {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.Fixture', '10': 'fixtures'},
  ],
};

/// Descriptor for `Fixtures`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixturesDescriptor = $convert.base64Decode(
    'CghGaXh0dXJlcxIzCghmaXh0dXJlcxgBIAMoCzIXLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVSCG'
    'ZpeHR1cmVz');

@$core.Deprecated('Use fixtureDescriptor instead')
const Fixture$json = {
  '1': 'Fixture',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'manufacturer', '3': 3, '4': 1, '5': 9, '10': 'manufacturer'},
    {'1': 'model', '3': 4, '4': 1, '5': 9, '10': 'model'},
    {'1': 'mode', '3': 5, '4': 1, '5': 9, '10': 'mode'},
    {'1': 'universe', '3': 6, '4': 1, '5': 13, '10': 'universe'},
    {'1': 'channel', '3': 7, '4': 1, '5': 13, '10': 'channel'},
    {'1': 'channel_count', '3': 8, '4': 1, '5': 13, '10': 'channelCount'},
    {'1': 'controls', '3': 9, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureControls', '10': 'controls'},
    {'1': 'children', '3': 10, '4': 3, '5': 11, '6': '.mizer.fixtures.SubFixture', '10': 'children'},
    {'1': 'config', '3': 11, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureConfig', '10': 'config'},
  ],
};

/// Descriptor for `Fixture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureDescriptor = $convert.base64Decode(
    'CgdGaXh0dXJlEg4KAmlkGAEgASgNUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiIKDG1hbnVmYW'
    'N0dXJlchgDIAEoCVIMbWFudWZhY3R1cmVyEhQKBW1vZGVsGAQgASgJUgVtb2RlbBISCgRtb2Rl'
    'GAUgASgJUgRtb2RlEhoKCHVuaXZlcnNlGAYgASgNUgh1bml2ZXJzZRIYCgdjaGFubmVsGAcgAS'
    'gNUgdjaGFubmVsEiMKDWNoYW5uZWxfY291bnQYCCABKA1SDGNoYW5uZWxDb3VudBI7Cghjb250'
    'cm9scxgJIAMoCzIfLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVDb250cm9sc1IIY29udHJvbHMSNg'
    'oIY2hpbGRyZW4YCiADKAsyGi5taXplci5maXh0dXJlcy5TdWJGaXh0dXJlUghjaGlsZHJlbhI1'
    'CgZjb25maWcYCyABKAsyHS5taXplci5maXh0dXJlcy5GaXh0dXJlQ29uZmlnUgZjb25maWc=');

@$core.Deprecated('Use fixtureConfigDescriptor instead')
const FixtureConfig$json = {
  '1': 'FixtureConfig',
  '2': [
    {'1': 'invert_pan', '3': 1, '4': 1, '5': 8, '10': 'invertPan'},
    {'1': 'invert_tilt', '3': 2, '4': 1, '5': 8, '10': 'invertTilt'},
    {'1': 'reverse_pixel_order', '3': 3, '4': 1, '5': 8, '10': 'reversePixelOrder'},
    {'1': 'channel_limits', '3': 4, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureChannelLimit', '10': 'channelLimits'},
  ],
};

/// Descriptor for `FixtureConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureConfigDescriptor = $convert.base64Decode(
    'Cg1GaXh0dXJlQ29uZmlnEh0KCmludmVydF9wYW4YASABKAhSCWludmVydFBhbhIfCgtpbnZlcn'
    'RfdGlsdBgCIAEoCFIKaW52ZXJ0VGlsdBIuChNyZXZlcnNlX3BpeGVsX29yZGVyGAMgASgIUhFy'
    'ZXZlcnNlUGl4ZWxPcmRlchJKCg5jaGFubmVsX2xpbWl0cxgEIAMoCzIjLm1pemVyLmZpeHR1cm'
    'VzLkZpeHR1cmVDaGFubmVsTGltaXRSDWNoYW5uZWxMaW1pdHM=');

@$core.Deprecated('Use fixtureChannelLimitDescriptor instead')
const FixtureChannelLimit$json = {
  '1': 'FixtureChannelLimit',
  '2': [
    {'1': 'control', '3': 1, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureFaderControl', '10': 'control'},
    {'1': 'min', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'min', '17': true},
    {'1': 'max', '3': 3, '4': 1, '5': 1, '9': 1, '10': 'max', '17': true},
  ],
  '8': [
    {'1': '_min'},
    {'1': '_max'},
  ],
};

/// Descriptor for `FixtureChannelLimit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureChannelLimitDescriptor = $convert.base64Decode(
    'ChNGaXh0dXJlQ2hhbm5lbExpbWl0Ej0KB2NvbnRyb2wYASABKAsyIy5taXplci5maXh0dXJlcy'
    '5GaXh0dXJlRmFkZXJDb250cm9sUgdjb250cm9sEhUKA21pbhgCIAEoAUgAUgNtaW6IAQESFQoD'
    'bWF4GAMgASgBSAFSA21heIgBAUIGCgRfbWluQgYKBF9tYXg=');

@$core.Deprecated('Use subFixtureDescriptor instead')
const SubFixture$json = {
  '1': 'SubFixture',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'controls', '3': 3, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureControls', '10': 'controls'},
  ],
};

/// Descriptor for `SubFixture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subFixtureDescriptor = $convert.base64Decode(
    'CgpTdWJGaXh0dXJlEg4KAmlkGAEgASgNUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEjsKCGNvbn'
    'Ryb2xzGAMgAygLMh8ubWl6ZXIuZml4dHVyZXMuRml4dHVyZUNvbnRyb2xzUghjb250cm9scw==');

@$core.Deprecated('Use fixtureControlsDescriptor instead')
const FixtureControls$json = {
  '1': 'FixtureControls',
  '2': [
    {'1': 'control', '3': 1, '4': 1, '5': 14, '6': '.mizer.fixtures.FixtureControl', '10': 'control'},
    {'1': 'fader', '3': 2, '4': 1, '5': 11, '6': '.mizer.fixtures.FaderChannel', '9': 0, '10': 'fader'},
    {'1': 'color_mixer', '3': 3, '4': 1, '5': 11, '6': '.mizer.fixtures.ColorMixerChannel', '9': 0, '10': 'colorMixer'},
    {'1': 'color_wheel', '3': 4, '4': 1, '5': 11, '6': '.mizer.fixtures.ColorWheelChannel', '9': 0, '10': 'colorWheel'},
    {'1': 'axis', '3': 5, '4': 1, '5': 11, '6': '.mizer.fixtures.AxisChannel', '9': 0, '10': 'axis'},
    {'1': 'gobo', '3': 6, '4': 1, '5': 11, '6': '.mizer.fixtures.GoboChannel', '9': 0, '10': 'gobo'},
    {'1': 'generic', '3': 7, '4': 1, '5': 11, '6': '.mizer.fixtures.GenericChannel', '9': 0, '10': 'generic'},
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `FixtureControls`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureControlsDescriptor = $convert.base64Decode(
    'Cg9GaXh0dXJlQ29udHJvbHMSOAoHY29udHJvbBgBIAEoDjIeLm1pemVyLmZpeHR1cmVzLkZpeH'
    'R1cmVDb250cm9sUgdjb250cm9sEjQKBWZhZGVyGAIgASgLMhwubWl6ZXIuZml4dHVyZXMuRmFk'
    'ZXJDaGFubmVsSABSBWZhZGVyEkQKC2NvbG9yX21peGVyGAMgASgLMiEubWl6ZXIuZml4dHVyZX'
    'MuQ29sb3JNaXhlckNoYW5uZWxIAFIKY29sb3JNaXhlchJECgtjb2xvcl93aGVlbBgEIAEoCzIh'
    'Lm1pemVyLmZpeHR1cmVzLkNvbG9yV2hlZWxDaGFubmVsSABSCmNvbG9yV2hlZWwSMQoEYXhpcx'
    'gFIAEoCzIbLm1pemVyLmZpeHR1cmVzLkF4aXNDaGFubmVsSABSBGF4aXMSMQoEZ29ibxgGIAEo'
    'CzIbLm1pemVyLmZpeHR1cmVzLkdvYm9DaGFubmVsSABSBGdvYm8SOgoHZ2VuZXJpYxgHIAEoCz'
    'IeLm1pemVyLmZpeHR1cmVzLkdlbmVyaWNDaGFubmVsSABSB2dlbmVyaWNCBwoFdmFsdWU=');

@$core.Deprecated('Use faderChannelDescriptor instead')
const FaderChannel$json = {
  '1': 'FaderChannel',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `FaderChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List faderChannelDescriptor = $convert.base64Decode(
    'CgxGYWRlckNoYW5uZWwSFAoFdmFsdWUYASABKAFSBXZhbHVl');

@$core.Deprecated('Use colorMixerChannelDescriptor instead')
const ColorMixerChannel$json = {
  '1': 'ColorMixerChannel',
  '2': [
    {'1': 'red', '3': 1, '4': 1, '5': 1, '10': 'red'},
    {'1': 'green', '3': 2, '4': 1, '5': 1, '10': 'green'},
    {'1': 'blue', '3': 3, '4': 1, '5': 1, '10': 'blue'},
  ],
};

/// Descriptor for `ColorMixerChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List colorMixerChannelDescriptor = $convert.base64Decode(
    'ChFDb2xvck1peGVyQ2hhbm5lbBIQCgNyZWQYASABKAFSA3JlZBIUCgVncmVlbhgCIAEoAVIFZ3'
    'JlZW4SEgoEYmx1ZRgDIAEoAVIEYmx1ZQ==');

@$core.Deprecated('Use colorWheelChannelDescriptor instead')
const ColorWheelChannel$json = {
  '1': 'ColorWheelChannel',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
    {'1': 'colors', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.ColorWheelSlot', '10': 'colors'},
  ],
};

/// Descriptor for `ColorWheelChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List colorWheelChannelDescriptor = $convert.base64Decode(
    'ChFDb2xvcldoZWVsQ2hhbm5lbBIUCgV2YWx1ZRgBIAEoAVIFdmFsdWUSNgoGY29sb3JzGAIgAy'
    'gLMh4ubWl6ZXIuZml4dHVyZXMuQ29sb3JXaGVlbFNsb3RSBmNvbG9ycw==');

@$core.Deprecated('Use colorWheelSlotDescriptor instead')
const ColorWheelSlot$json = {
  '1': 'ColorWheelSlot',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
    {'1': 'colors', '3': 3, '4': 3, '5': 9, '10': 'colors'},
  ],
};

/// Descriptor for `ColorWheelSlot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List colorWheelSlotDescriptor = $convert.base64Decode(
    'Cg5Db2xvcldoZWVsU2xvdBISCgRuYW1lGAEgASgJUgRuYW1lEhQKBXZhbHVlGAIgASgBUgV2YW'
    'x1ZRIWCgZjb2xvcnMYAyADKAlSBmNvbG9ycw==');

@$core.Deprecated('Use axisChannelDescriptor instead')
const AxisChannel$json = {
  '1': 'AxisChannel',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
    {'1': 'angle_from', '3': 2, '4': 1, '5': 1, '10': 'angleFrom'},
    {'1': 'angle_to', '3': 3, '4': 1, '5': 1, '10': 'angleTo'},
  ],
};

/// Descriptor for `AxisChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List axisChannelDescriptor = $convert.base64Decode(
    'CgtBeGlzQ2hhbm5lbBIUCgV2YWx1ZRgBIAEoAVIFdmFsdWUSHQoKYW5nbGVfZnJvbRgCIAEoAV'
    'IJYW5nbGVGcm9tEhkKCGFuZ2xlX3RvGAMgASgBUgdhbmdsZVRv');

@$core.Deprecated('Use goboChannelDescriptor instead')
const GoboChannel$json = {
  '1': 'GoboChannel',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
    {'1': 'gobos', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.Gobo', '10': 'gobos'},
  ],
};

/// Descriptor for `GoboChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List goboChannelDescriptor = $convert.base64Decode(
    'CgtHb2JvQ2hhbm5lbBIUCgV2YWx1ZRgBIAEoAVIFdmFsdWUSKgoFZ29ib3MYAiADKAsyFC5taX'
    'plci5maXh0dXJlcy5Hb2JvUgVnb2Jvcw==');

@$core.Deprecated('Use goboDescriptor instead')
const Gobo$json = {
  '1': 'Gobo',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
    {'1': 'svg', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'svg'},
    {'1': 'raster', '3': 4, '4': 1, '5': 12, '9': 0, '10': 'raster'},
  ],
  '8': [
    {'1': 'image'},
  ],
};

/// Descriptor for `Gobo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List goboDescriptor = $convert.base64Decode(
    'CgRHb2JvEhIKBG5hbWUYASABKAlSBG5hbWUSFAoFdmFsdWUYAiABKAFSBXZhbHVlEhIKA3N2Zx'
    'gDIAEoCUgAUgNzdmcSGAoGcmFzdGVyGAQgASgMSABSBnJhc3RlckIHCgVpbWFnZQ==');

@$core.Deprecated('Use genericChannelDescriptor instead')
const GenericChannel$json = {
  '1': 'GenericChannel',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GenericChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List genericChannelDescriptor = $convert.base64Decode(
    'Cg5HZW5lcmljQ2hhbm5lbBIUCgV2YWx1ZRgBIAEoAVIFdmFsdWUSEgoEbmFtZRgCIAEoCVIEbm'
    'FtZQ==');

@$core.Deprecated('Use getFixtureDefinitionsRequestDescriptor instead')
const GetFixtureDefinitionsRequest$json = {
  '1': 'GetFixtureDefinitionsRequest',
};

/// Descriptor for `GetFixtureDefinitionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFixtureDefinitionsRequestDescriptor = $convert.base64Decode(
    'ChxHZXRGaXh0dXJlRGVmaW5pdGlvbnNSZXF1ZXN0');

@$core.Deprecated('Use fixtureDefinitionsDescriptor instead')
const FixtureDefinitions$json = {
  '1': 'FixtureDefinitions',
  '2': [
    {'1': 'definitions', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureDefinition', '10': 'definitions'},
  ],
};

/// Descriptor for `FixtureDefinitions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureDefinitionsDescriptor = $convert.base64Decode(
    'ChJGaXh0dXJlRGVmaW5pdGlvbnMSQwoLZGVmaW5pdGlvbnMYASADKAsyIS5taXplci5maXh0dX'
    'Jlcy5GaXh0dXJlRGVmaW5pdGlvblILZGVmaW5pdGlvbnM=');

@$core.Deprecated('Use fixtureDefinitionDescriptor instead')
const FixtureDefinition$json = {
  '1': 'FixtureDefinition',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'manufacturer', '3': 3, '4': 1, '5': 9, '10': 'manufacturer'},
    {'1': 'modes', '3': 4, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureMode', '10': 'modes'},
    {'1': 'physical', '3': 5, '4': 1, '5': 11, '6': '.mizer.fixtures.FixturePhysicalData', '10': 'physical'},
    {'1': 'tags', '3': 6, '4': 3, '5': 9, '10': 'tags'},
    {'1': 'provider', '3': 7, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `FixtureDefinition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureDefinitionDescriptor = $convert.base64Decode(
    'ChFGaXh0dXJlRGVmaW5pdGlvbhIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZR'
    'IiCgxtYW51ZmFjdHVyZXIYAyABKAlSDG1hbnVmYWN0dXJlchIxCgVtb2RlcxgEIAMoCzIbLm1p'
    'emVyLmZpeHR1cmVzLkZpeHR1cmVNb2RlUgVtb2RlcxI/CghwaHlzaWNhbBgFIAEoCzIjLm1pem'
    'VyLmZpeHR1cmVzLkZpeHR1cmVQaHlzaWNhbERhdGFSCHBoeXNpY2FsEhIKBHRhZ3MYBiADKAlS'
    'BHRhZ3MSGgoIcHJvdmlkZXIYByABKAlSCHByb3ZpZGVy');

@$core.Deprecated('Use fixtureModeDescriptor instead')
const FixtureMode$json = {
  '1': 'FixtureMode',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'channels', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureChannel', '10': 'channels'},
  ],
};

/// Descriptor for `FixtureMode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureModeDescriptor = $convert.base64Decode(
    'CgtGaXh0dXJlTW9kZRISCgRuYW1lGAEgASgJUgRuYW1lEjoKCGNoYW5uZWxzGAIgAygLMh4ubW'
    'l6ZXIuZml4dHVyZXMuRml4dHVyZUNoYW5uZWxSCGNoYW5uZWxz');

@$core.Deprecated('Use fixtureChannelDescriptor instead')
const FixtureChannel$json = {
  '1': 'FixtureChannel',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'coarse', '3': 2, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureChannel.CoarseResolution', '9': 0, '10': 'coarse'},
    {'1': 'fine', '3': 3, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureChannel.FineResolution', '9': 0, '10': 'fine'},
    {'1': 'finest', '3': 4, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureChannel.FinestResolution', '9': 0, '10': 'finest'},
  ],
  '3': [FixtureChannel_CoarseResolution$json, FixtureChannel_FineResolution$json, FixtureChannel_FinestResolution$json],
  '8': [
    {'1': 'resolution'},
  ],
};

@$core.Deprecated('Use fixtureChannelDescriptor instead')
const FixtureChannel_CoarseResolution$json = {
  '1': 'CoarseResolution',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 13, '10': 'channel'},
  ],
};

@$core.Deprecated('Use fixtureChannelDescriptor instead')
const FixtureChannel_FineResolution$json = {
  '1': 'FineResolution',
  '2': [
    {'1': 'fine_channel', '3': 1, '4': 1, '5': 13, '10': 'fineChannel'},
    {'1': 'coarse_channel', '3': 2, '4': 1, '5': 13, '10': 'coarseChannel'},
  ],
};

@$core.Deprecated('Use fixtureChannelDescriptor instead')
const FixtureChannel_FinestResolution$json = {
  '1': 'FinestResolution',
  '2': [
    {'1': 'finest_channel', '3': 1, '4': 1, '5': 13, '10': 'finestChannel'},
    {'1': 'fine_channel', '3': 2, '4': 1, '5': 13, '10': 'fineChannel'},
    {'1': 'coarse_channel', '3': 3, '4': 1, '5': 13, '10': 'coarseChannel'},
  ],
};

/// Descriptor for `FixtureChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureChannelDescriptor = $convert.base64Decode(
    'Cg5GaXh0dXJlQ2hhbm5lbBISCgRuYW1lGAEgASgJUgRuYW1lEkkKBmNvYXJzZRgCIAEoCzIvLm'
    '1pemVyLmZpeHR1cmVzLkZpeHR1cmVDaGFubmVsLkNvYXJzZVJlc29sdXRpb25IAFIGY29hcnNl'
    'EkMKBGZpbmUYAyABKAsyLS5taXplci5maXh0dXJlcy5GaXh0dXJlQ2hhbm5lbC5GaW5lUmVzb2'
    'x1dGlvbkgAUgRmaW5lEkkKBmZpbmVzdBgEIAEoCzIvLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVD'
    'aGFubmVsLkZpbmVzdFJlc29sdXRpb25IAFIGZmluZXN0GiwKEENvYXJzZVJlc29sdXRpb24SGA'
    'oHY2hhbm5lbBgBIAEoDVIHY2hhbm5lbBpaCg5GaW5lUmVzb2x1dGlvbhIhCgxmaW5lX2NoYW5u'
    'ZWwYASABKA1SC2ZpbmVDaGFubmVsEiUKDmNvYXJzZV9jaGFubmVsGAIgASgNUg1jb2Fyc2VDaG'
    'FubmVsGoMBChBGaW5lc3RSZXNvbHV0aW9uEiUKDmZpbmVzdF9jaGFubmVsGAEgASgNUg1maW5l'
    'c3RDaGFubmVsEiEKDGZpbmVfY2hhbm5lbBgCIAEoDVILZmluZUNoYW5uZWwSJQoOY29hcnNlX2'
    'NoYW5uZWwYAyABKA1SDWNvYXJzZUNoYW5uZWxCDAoKcmVzb2x1dGlvbg==');

@$core.Deprecated('Use fixturePhysicalDataDescriptor instead')
const FixturePhysicalData$json = {
  '1': 'FixturePhysicalData',
  '2': [
    {'1': 'width', '3': 1, '4': 1, '5': 2, '10': 'width'},
    {'1': 'height', '3': 2, '4': 1, '5': 2, '10': 'height'},
    {'1': 'depth', '3': 3, '4': 1, '5': 2, '10': 'depth'},
    {'1': 'weight', '3': 4, '4': 1, '5': 2, '10': 'weight'},
  ],
};

/// Descriptor for `FixturePhysicalData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixturePhysicalDataDescriptor = $convert.base64Decode(
    'ChNGaXh0dXJlUGh5c2ljYWxEYXRhEhQKBXdpZHRoGAEgASgCUgV3aWR0aBIWCgZoZWlnaHQYAi'
    'ABKAJSBmhlaWdodBIUCgVkZXB0aBgDIAEoAlIFZGVwdGgSFgoGd2VpZ2h0GAQgASgCUgZ3ZWln'
    'aHQ=');

@$core.Deprecated('Use fixtureFaderControlDescriptor instead')
const FixtureFaderControl$json = {
  '1': 'FixtureFaderControl',
  '2': [
    {'1': 'control', '3': 1, '4': 1, '5': 14, '6': '.mizer.fixtures.FixtureControl', '10': 'control'},
    {'1': 'color_mixer_channel', '3': 2, '4': 1, '5': 14, '6': '.mizer.fixtures.FixtureFaderControl.ColorMixerControlChannel', '9': 0, '10': 'colorMixerChannel', '17': true},
    {'1': 'generic_channel', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'genericChannel', '17': true},
  ],
  '4': [FixtureFaderControl_ColorMixerControlChannel$json],
  '8': [
    {'1': '_color_mixer_channel'},
    {'1': '_generic_channel'},
  ],
};

@$core.Deprecated('Use fixtureFaderControlDescriptor instead')
const FixtureFaderControl_ColorMixerControlChannel$json = {
  '1': 'ColorMixerControlChannel',
  '2': [
    {'1': 'RED', '2': 0},
    {'1': 'GREEN', '2': 1},
    {'1': 'BLUE', '2': 2},
  ],
};

/// Descriptor for `FixtureFaderControl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureFaderControlDescriptor = $convert.base64Decode(
    'ChNGaXh0dXJlRmFkZXJDb250cm9sEjgKB2NvbnRyb2wYASABKA4yHi5taXplci5maXh0dXJlcy'
    '5GaXh0dXJlQ29udHJvbFIHY29udHJvbBJxChNjb2xvcl9taXhlcl9jaGFubmVsGAIgASgOMjwu'
    'bWl6ZXIuZml4dHVyZXMuRml4dHVyZUZhZGVyQ29udHJvbC5Db2xvck1peGVyQ29udHJvbENoYW'
    '5uZWxIAFIRY29sb3JNaXhlckNoYW5uZWyIAQESLAoPZ2VuZXJpY19jaGFubmVsGAMgASgJSAFS'
    'DmdlbmVyaWNDaGFubmVsiAEBIjgKGENvbG9yTWl4ZXJDb250cm9sQ2hhbm5lbBIHCgNSRUQQAB'
    'IJCgVHUkVFThABEggKBEJMVUUQAkIWChRfY29sb3JfbWl4ZXJfY2hhbm5lbEISChBfZ2VuZXJp'
    'Y19jaGFubmVs');

