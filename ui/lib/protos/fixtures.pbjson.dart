///
//  Generated code. Do not modify.
//  source: fixtures.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use fixtureControlDescriptor instead')
const FixtureControl$json = const {
  '1': 'FixtureControl',
  '2': const [
    const {'1': 'INTENSITY', '2': 0},
    const {'1': 'SHUTTER', '2': 1},
    const {'1': 'COLOR_MIXER', '2': 2},
    const {'1': 'COLOR_WHEEL', '2': 3},
    const {'1': 'PAN', '2': 4},
    const {'1': 'TILT', '2': 5},
    const {'1': 'FOCUS', '2': 6},
    const {'1': 'ZOOM', '2': 7},
    const {'1': 'PRISM', '2': 8},
    const {'1': 'IRIS', '2': 9},
    const {'1': 'FROST', '2': 10},
    const {'1': 'GOBO', '2': 11},
    const {'1': 'GENERIC', '2': 12},
  ],
};

/// Descriptor for `FixtureControl`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fixtureControlDescriptor = $convert.base64Decode('Cg5GaXh0dXJlQ29udHJvbBINCglJTlRFTlNJVFkQABILCgdTSFVUVEVSEAESDwoLQ09MT1JfTUlYRVIQAhIPCgtDT0xPUl9XSEVFTBADEgcKA1BBThAEEggKBFRJTFQQBRIJCgVGT0NVUxAGEggKBFpPT00QBxIJCgVQUklTTRAIEggKBElSSVMQCRIJCgVGUk9TVBAKEggKBEdPQk8QCxILCgdHRU5FUklDEAw=');
@$core.Deprecated('Use addFixturesRequestDescriptor instead')
const AddFixturesRequest$json = const {
  '1': 'AddFixturesRequest',
  '2': const [
    const {'1': 'request', '3': 1, '4': 1, '5': 11, '6': '.mizer.fixtures.AddFixtureRequest', '10': 'request'},
    const {'1': 'count', '3': 2, '4': 1, '5': 13, '10': 'count'},
  ],
};

/// Descriptor for `AddFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addFixturesRequestDescriptor = $convert.base64Decode('ChJBZGRGaXh0dXJlc1JlcXVlc3QSOwoHcmVxdWVzdBgBIAEoCzIhLm1pemVyLmZpeHR1cmVzLkFkZEZpeHR1cmVSZXF1ZXN0UgdyZXF1ZXN0EhQKBWNvdW50GAIgASgNUgVjb3VudA==');
@$core.Deprecated('Use addFixtureRequestDescriptor instead')
const AddFixtureRequest$json = const {
  '1': 'AddFixtureRequest',
  '2': const [
    const {'1': 'definitionId', '3': 1, '4': 1, '5': 9, '10': 'definitionId'},
    const {'1': 'mode', '3': 2, '4': 1, '5': 9, '10': 'mode'},
    const {'1': 'id', '3': 3, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'channel', '3': 4, '4': 1, '5': 13, '10': 'channel'},
    const {'1': 'universe', '3': 5, '4': 1, '5': 13, '10': 'universe'},
    const {'1': 'name', '3': 6, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AddFixtureRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addFixtureRequestDescriptor = $convert.base64Decode('ChFBZGRGaXh0dXJlUmVxdWVzdBIiCgxkZWZpbml0aW9uSWQYASABKAlSDGRlZmluaXRpb25JZBISCgRtb2RlGAIgASgJUgRtb2RlEg4KAmlkGAMgASgNUgJpZBIYCgdjaGFubmVsGAQgASgNUgdjaGFubmVsEhoKCHVuaXZlcnNlGAUgASgNUgh1bml2ZXJzZRISCgRuYW1lGAYgASgJUgRuYW1l');
@$core.Deprecated('Use getFixturesRequestDescriptor instead')
const GetFixturesRequest$json = const {
  '1': 'GetFixturesRequest',
};

/// Descriptor for `GetFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFixturesRequestDescriptor = $convert.base64Decode('ChJHZXRGaXh0dXJlc1JlcXVlc3Q=');
@$core.Deprecated('Use deleteFixturesRequestDescriptor instead')
const DeleteFixturesRequest$json = const {
  '1': 'DeleteFixturesRequest',
  '2': const [
    const {'1': 'fixtureIds', '3': 1, '4': 3, '5': 13, '10': 'fixtureIds'},
  ],
};

/// Descriptor for `DeleteFixturesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteFixturesRequestDescriptor = $convert.base64Decode('ChVEZWxldGVGaXh0dXJlc1JlcXVlc3QSHgoKZml4dHVyZUlkcxgBIAMoDVIKZml4dHVyZUlkcw==');
@$core.Deprecated('Use updateFixtureRequestDescriptor instead')
const UpdateFixtureRequest$json = const {
  '1': 'UpdateFixtureRequest',
  '2': const [
    const {'1': 'fixtureId', '3': 1, '4': 1, '5': 13, '10': 'fixtureId'},
    const {'1': 'invert_pan', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'invertPan', '17': true},
    const {'1': 'invert_tilt', '3': 3, '4': 1, '5': 8, '9': 1, '10': 'invertTilt', '17': true},
    const {'1': 'name', '3': 4, '4': 1, '5': 9, '9': 2, '10': 'name', '17': true},
    const {'1': 'address', '3': 5, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureAddress', '9': 3, '10': 'address', '17': true},
  ],
  '8': const [
    const {'1': '_invert_pan'},
    const {'1': '_invert_tilt'},
    const {'1': '_name'},
    const {'1': '_address'},
  ],
};

/// Descriptor for `UpdateFixtureRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFixtureRequestDescriptor = $convert.base64Decode('ChRVcGRhdGVGaXh0dXJlUmVxdWVzdBIcCglmaXh0dXJlSWQYASABKA1SCWZpeHR1cmVJZBIiCgppbnZlcnRfcGFuGAIgASgISABSCWludmVydFBhbogBARIkCgtpbnZlcnRfdGlsdBgDIAEoCEgBUgppbnZlcnRUaWx0iAEBEhcKBG5hbWUYBCABKAlIAlIEbmFtZYgBARI9CgdhZGRyZXNzGAUgASgLMh4ubWl6ZXIuZml4dHVyZXMuRml4dHVyZUFkZHJlc3NIA1IHYWRkcmVzc4gBAUINCgtfaW52ZXJ0X3BhbkIOCgxfaW52ZXJ0X3RpbHRCBwoFX25hbWVCCgoIX2FkZHJlc3M=');
@$core.Deprecated('Use fixtureAddressDescriptor instead')
const FixtureAddress$json = const {
  '1': 'FixtureAddress',
  '2': const [
    const {'1': 'universe', '3': 1, '4': 1, '5': 13, '10': 'universe'},
    const {'1': 'channel', '3': 2, '4': 1, '5': 13, '10': 'channel'},
  ],
};

/// Descriptor for `FixtureAddress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureAddressDescriptor = $convert.base64Decode('Cg5GaXh0dXJlQWRkcmVzcxIaCgh1bml2ZXJzZRgBIAEoDVIIdW5pdmVyc2USGAoHY2hhbm5lbBgCIAEoDVIHY2hhbm5lbA==');
@$core.Deprecated('Use fixtureIdDescriptor instead')
const FixtureId$json = const {
  '1': 'FixtureId',
  '2': const [
    const {'1': 'fixture', '3': 1, '4': 1, '5': 13, '9': 0, '10': 'fixture'},
    const {'1': 'sub_fixture', '3': 2, '4': 1, '5': 11, '6': '.mizer.fixtures.SubFixtureId', '9': 0, '10': 'subFixture'},
  ],
  '8': const [
    const {'1': 'id'},
  ],
};

/// Descriptor for `FixtureId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureIdDescriptor = $convert.base64Decode('CglGaXh0dXJlSWQSGgoHZml4dHVyZRgBIAEoDUgAUgdmaXh0dXJlEj8KC3N1Yl9maXh0dXJlGAIgASgLMhwubWl6ZXIuZml4dHVyZXMuU3ViRml4dHVyZUlkSABSCnN1YkZpeHR1cmVCBAoCaWQ=');
@$core.Deprecated('Use subFixtureIdDescriptor instead')
const SubFixtureId$json = const {
  '1': 'SubFixtureId',
  '2': const [
    const {'1': 'fixture_id', '3': 1, '4': 1, '5': 13, '10': 'fixtureId'},
    const {'1': 'child_id', '3': 2, '4': 1, '5': 13, '10': 'childId'},
  ],
};

/// Descriptor for `SubFixtureId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subFixtureIdDescriptor = $convert.base64Decode('CgxTdWJGaXh0dXJlSWQSHQoKZml4dHVyZV9pZBgBIAEoDVIJZml4dHVyZUlkEhkKCGNoaWxkX2lkGAIgASgNUgdjaGlsZElk');
@$core.Deprecated('Use fixturesDescriptor instead')
const Fixtures$json = const {
  '1': 'Fixtures',
  '2': const [
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.Fixture', '10': 'fixtures'},
  ],
};

/// Descriptor for `Fixtures`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixturesDescriptor = $convert.base64Decode('CghGaXh0dXJlcxIzCghmaXh0dXJlcxgBIAMoCzIXLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVSCGZpeHR1cmVz');
@$core.Deprecated('Use fixtureDescriptor instead')
const Fixture$json = const {
  '1': 'Fixture',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'manufacturer', '3': 3, '4': 1, '5': 9, '10': 'manufacturer'},
    const {'1': 'model', '3': 4, '4': 1, '5': 9, '10': 'model'},
    const {'1': 'mode', '3': 5, '4': 1, '5': 9, '10': 'mode'},
    const {'1': 'universe', '3': 6, '4': 1, '5': 13, '10': 'universe'},
    const {'1': 'channel', '3': 7, '4': 1, '5': 13, '10': 'channel'},
    const {'1': 'channel_count', '3': 8, '4': 1, '5': 13, '10': 'channelCount'},
    const {'1': 'controls', '3': 9, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureControls', '10': 'controls'},
    const {'1': 'children', '3': 10, '4': 3, '5': 11, '6': '.mizer.fixtures.SubFixture', '10': 'children'},
    const {'1': 'config', '3': 11, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureConfig', '10': 'config'},
  ],
};

/// Descriptor for `Fixture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureDescriptor = $convert.base64Decode('CgdGaXh0dXJlEg4KAmlkGAEgASgNUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiIKDG1hbnVmYWN0dXJlchgDIAEoCVIMbWFudWZhY3R1cmVyEhQKBW1vZGVsGAQgASgJUgVtb2RlbBISCgRtb2RlGAUgASgJUgRtb2RlEhoKCHVuaXZlcnNlGAYgASgNUgh1bml2ZXJzZRIYCgdjaGFubmVsGAcgASgNUgdjaGFubmVsEiMKDWNoYW5uZWxfY291bnQYCCABKA1SDGNoYW5uZWxDb3VudBI7Cghjb250cm9scxgJIAMoCzIfLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVDb250cm9sc1IIY29udHJvbHMSNgoIY2hpbGRyZW4YCiADKAsyGi5taXplci5maXh0dXJlcy5TdWJGaXh0dXJlUghjaGlsZHJlbhI1CgZjb25maWcYCyABKAsyHS5taXplci5maXh0dXJlcy5GaXh0dXJlQ29uZmlnUgZjb25maWc=');
@$core.Deprecated('Use fixtureConfigDescriptor instead')
const FixtureConfig$json = const {
  '1': 'FixtureConfig',
  '2': const [
    const {'1': 'invert_pan', '3': 1, '4': 1, '5': 8, '10': 'invertPan'},
    const {'1': 'invert_tilt', '3': 2, '4': 1, '5': 8, '10': 'invertTilt'},
  ],
};

/// Descriptor for `FixtureConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureConfigDescriptor = $convert.base64Decode('Cg1GaXh0dXJlQ29uZmlnEh0KCmludmVydF9wYW4YASABKAhSCWludmVydFBhbhIfCgtpbnZlcnRfdGlsdBgCIAEoCFIKaW52ZXJ0VGlsdA==');
@$core.Deprecated('Use subFixtureDescriptor instead')
const SubFixture$json = const {
  '1': 'SubFixture',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'controls', '3': 3, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureControls', '10': 'controls'},
  ],
};

/// Descriptor for `SubFixture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subFixtureDescriptor = $convert.base64Decode('CgpTdWJGaXh0dXJlEg4KAmlkGAEgASgNUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEjsKCGNvbnRyb2xzGAMgAygLMh8ubWl6ZXIuZml4dHVyZXMuRml4dHVyZUNvbnRyb2xzUghjb250cm9scw==');
@$core.Deprecated('Use fixtureControlsDescriptor instead')
const FixtureControls$json = const {
  '1': 'FixtureControls',
  '2': const [
    const {'1': 'control', '3': 1, '4': 1, '5': 14, '6': '.mizer.fixtures.FixtureControl', '10': 'control'},
    const {'1': 'fader', '3': 2, '4': 1, '5': 11, '6': '.mizer.fixtures.FaderChannel', '9': 0, '10': 'fader'},
    const {'1': 'color_mixer', '3': 3, '4': 1, '5': 11, '6': '.mizer.fixtures.ColorMixerChannel', '9': 0, '10': 'colorMixer'},
    const {'1': 'color_wheel', '3': 4, '4': 1, '5': 11, '6': '.mizer.fixtures.ColorWheelChannel', '9': 0, '10': 'colorWheel'},
    const {'1': 'axis', '3': 5, '4': 1, '5': 11, '6': '.mizer.fixtures.AxisChannel', '9': 0, '10': 'axis'},
    const {'1': 'gobo', '3': 6, '4': 1, '5': 11, '6': '.mizer.fixtures.GoboChannel', '9': 0, '10': 'gobo'},
    const {'1': 'generic', '3': 7, '4': 1, '5': 11, '6': '.mizer.fixtures.GenericChannel', '9': 0, '10': 'generic'},
  ],
  '8': const [
    const {'1': 'value'},
  ],
};

/// Descriptor for `FixtureControls`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureControlsDescriptor = $convert.base64Decode('Cg9GaXh0dXJlQ29udHJvbHMSOAoHY29udHJvbBgBIAEoDjIeLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVDb250cm9sUgdjb250cm9sEjQKBWZhZGVyGAIgASgLMhwubWl6ZXIuZml4dHVyZXMuRmFkZXJDaGFubmVsSABSBWZhZGVyEkQKC2NvbG9yX21peGVyGAMgASgLMiEubWl6ZXIuZml4dHVyZXMuQ29sb3JNaXhlckNoYW5uZWxIAFIKY29sb3JNaXhlchJECgtjb2xvcl93aGVlbBgEIAEoCzIhLm1pemVyLmZpeHR1cmVzLkNvbG9yV2hlZWxDaGFubmVsSABSCmNvbG9yV2hlZWwSMQoEYXhpcxgFIAEoCzIbLm1pemVyLmZpeHR1cmVzLkF4aXNDaGFubmVsSABSBGF4aXMSMQoEZ29ibxgGIAEoCzIbLm1pemVyLmZpeHR1cmVzLkdvYm9DaGFubmVsSABSBGdvYm8SOgoHZ2VuZXJpYxgHIAEoCzIeLm1pemVyLmZpeHR1cmVzLkdlbmVyaWNDaGFubmVsSABSB2dlbmVyaWNCBwoFdmFsdWU=');
@$core.Deprecated('Use faderChannelDescriptor instead')
const FaderChannel$json = const {
  '1': 'FaderChannel',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `FaderChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List faderChannelDescriptor = $convert.base64Decode('CgxGYWRlckNoYW5uZWwSFAoFdmFsdWUYASABKAFSBXZhbHVl');
@$core.Deprecated('Use colorMixerChannelDescriptor instead')
const ColorMixerChannel$json = const {
  '1': 'ColorMixerChannel',
  '2': const [
    const {'1': 'red', '3': 1, '4': 1, '5': 1, '10': 'red'},
    const {'1': 'green', '3': 2, '4': 1, '5': 1, '10': 'green'},
    const {'1': 'blue', '3': 3, '4': 1, '5': 1, '10': 'blue'},
  ],
};

/// Descriptor for `ColorMixerChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List colorMixerChannelDescriptor = $convert.base64Decode('ChFDb2xvck1peGVyQ2hhbm5lbBIQCgNyZWQYASABKAFSA3JlZBIUCgVncmVlbhgCIAEoAVIFZ3JlZW4SEgoEYmx1ZRgDIAEoAVIEYmx1ZQ==');
@$core.Deprecated('Use colorWheelChannelDescriptor instead')
const ColorWheelChannel$json = const {
  '1': 'ColorWheelChannel',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'colors', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.ColorWheelSlot', '10': 'colors'},
  ],
};

/// Descriptor for `ColorWheelChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List colorWheelChannelDescriptor = $convert.base64Decode('ChFDb2xvcldoZWVsQ2hhbm5lbBIUCgV2YWx1ZRgBIAEoAVIFdmFsdWUSNgoGY29sb3JzGAIgAygLMh4ubWl6ZXIuZml4dHVyZXMuQ29sb3JXaGVlbFNsb3RSBmNvbG9ycw==');
@$core.Deprecated('Use colorWheelSlotDescriptor instead')
const ColorWheelSlot$json = const {
  '1': 'ColorWheelSlot',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'colors', '3': 3, '4': 3, '5': 9, '10': 'colors'},
  ],
};

/// Descriptor for `ColorWheelSlot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List colorWheelSlotDescriptor = $convert.base64Decode('Cg5Db2xvcldoZWVsU2xvdBISCgRuYW1lGAEgASgJUgRuYW1lEhQKBXZhbHVlGAIgASgBUgV2YWx1ZRIWCgZjb2xvcnMYAyADKAlSBmNvbG9ycw==');
@$core.Deprecated('Use axisChannelDescriptor instead')
const AxisChannel$json = const {
  '1': 'AxisChannel',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'angle_from', '3': 2, '4': 1, '5': 1, '10': 'angleFrom'},
    const {'1': 'angle_to', '3': 3, '4': 1, '5': 1, '10': 'angleTo'},
  ],
};

/// Descriptor for `AxisChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List axisChannelDescriptor = $convert.base64Decode('CgtBeGlzQ2hhbm5lbBIUCgV2YWx1ZRgBIAEoAVIFdmFsdWUSHQoKYW5nbGVfZnJvbRgCIAEoAVIJYW5nbGVGcm9tEhkKCGFuZ2xlX3RvGAMgASgBUgdhbmdsZVRv');
@$core.Deprecated('Use goboChannelDescriptor instead')
const GoboChannel$json = const {
  '1': 'GoboChannel',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'gobos', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.Gobo', '10': 'gobos'},
  ],
};

/// Descriptor for `GoboChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List goboChannelDescriptor = $convert.base64Decode('CgtHb2JvQ2hhbm5lbBIUCgV2YWx1ZRgBIAEoAVIFdmFsdWUSKgoFZ29ib3MYAiADKAsyFC5taXplci5maXh0dXJlcy5Hb2JvUgVnb2Jvcw==');
@$core.Deprecated('Use goboDescriptor instead')
const Gobo$json = const {
  '1': 'Gobo',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'svg', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'svg'},
    const {'1': 'raster', '3': 4, '4': 1, '5': 12, '9': 0, '10': 'raster'},
  ],
  '8': const [
    const {'1': 'image'},
  ],
};

/// Descriptor for `Gobo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List goboDescriptor = $convert.base64Decode('CgRHb2JvEhIKBG5hbWUYASABKAlSBG5hbWUSFAoFdmFsdWUYAiABKAFSBXZhbHVlEhIKA3N2ZxgDIAEoCUgAUgNzdmcSGAoGcmFzdGVyGAQgASgMSABSBnJhc3RlckIHCgVpbWFnZQ==');
@$core.Deprecated('Use genericChannelDescriptor instead')
const GenericChannel$json = const {
  '1': 'GenericChannel',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GenericChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List genericChannelDescriptor = $convert.base64Decode('Cg5HZW5lcmljQ2hhbm5lbBIUCgV2YWx1ZRgBIAEoAVIFdmFsdWUSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use getFixtureDefinitionsRequestDescriptor instead')
const GetFixtureDefinitionsRequest$json = const {
  '1': 'GetFixtureDefinitionsRequest',
};

/// Descriptor for `GetFixtureDefinitionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFixtureDefinitionsRequestDescriptor = $convert.base64Decode('ChxHZXRGaXh0dXJlRGVmaW5pdGlvbnNSZXF1ZXN0');
@$core.Deprecated('Use fixtureDefinitionsDescriptor instead')
const FixtureDefinitions$json = const {
  '1': 'FixtureDefinitions',
  '2': const [
    const {'1': 'definitions', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureDefinition', '10': 'definitions'},
  ],
};

/// Descriptor for `FixtureDefinitions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureDefinitionsDescriptor = $convert.base64Decode('ChJGaXh0dXJlRGVmaW5pdGlvbnMSQwoLZGVmaW5pdGlvbnMYASADKAsyIS5taXplci5maXh0dXJlcy5GaXh0dXJlRGVmaW5pdGlvblILZGVmaW5pdGlvbnM=');
@$core.Deprecated('Use fixtureDefinitionDescriptor instead')
const FixtureDefinition$json = const {
  '1': 'FixtureDefinition',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'manufacturer', '3': 3, '4': 1, '5': 9, '10': 'manufacturer'},
    const {'1': 'modes', '3': 4, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureMode', '10': 'modes'},
    const {'1': 'physical', '3': 5, '4': 1, '5': 11, '6': '.mizer.fixtures.FixturePhysicalData', '10': 'physical'},
    const {'1': 'tags', '3': 6, '4': 3, '5': 9, '10': 'tags'},
    const {'1': 'provider', '3': 7, '4': 1, '5': 9, '10': 'provider'},
  ],
};

/// Descriptor for `FixtureDefinition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureDefinitionDescriptor = $convert.base64Decode('ChFGaXh0dXJlRGVmaW5pdGlvbhIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIiCgxtYW51ZmFjdHVyZXIYAyABKAlSDG1hbnVmYWN0dXJlchIxCgVtb2RlcxgEIAMoCzIbLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVNb2RlUgVtb2RlcxI/CghwaHlzaWNhbBgFIAEoCzIjLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVQaHlzaWNhbERhdGFSCHBoeXNpY2FsEhIKBHRhZ3MYBiADKAlSBHRhZ3MSGgoIcHJvdmlkZXIYByABKAlSCHByb3ZpZGVy');
@$core.Deprecated('Use fixtureModeDescriptor instead')
const FixtureMode$json = const {
  '1': 'FixtureMode',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'channels', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureChannel', '10': 'channels'},
  ],
};

/// Descriptor for `FixtureMode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureModeDescriptor = $convert.base64Decode('CgtGaXh0dXJlTW9kZRISCgRuYW1lGAEgASgJUgRuYW1lEjoKCGNoYW5uZWxzGAIgAygLMh4ubWl6ZXIuZml4dHVyZXMuRml4dHVyZUNoYW5uZWxSCGNoYW5uZWxz');
@$core.Deprecated('Use fixtureChannelDescriptor instead')
const FixtureChannel$json = const {
  '1': 'FixtureChannel',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'coarse', '3': 2, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureChannel.CoarseResolution', '9': 0, '10': 'coarse'},
    const {'1': 'fine', '3': 3, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureChannel.FineResolution', '9': 0, '10': 'fine'},
    const {'1': 'finest', '3': 4, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureChannel.FinestResolution', '9': 0, '10': 'finest'},
  ],
  '3': const [FixtureChannel_CoarseResolution$json, FixtureChannel_FineResolution$json, FixtureChannel_FinestResolution$json],
  '8': const [
    const {'1': 'resolution'},
  ],
};

@$core.Deprecated('Use fixtureChannelDescriptor instead')
const FixtureChannel_CoarseResolution$json = const {
  '1': 'CoarseResolution',
  '2': const [
    const {'1': 'channel', '3': 1, '4': 1, '5': 13, '10': 'channel'},
  ],
};

@$core.Deprecated('Use fixtureChannelDescriptor instead')
const FixtureChannel_FineResolution$json = const {
  '1': 'FineResolution',
  '2': const [
    const {'1': 'fineChannel', '3': 1, '4': 1, '5': 13, '10': 'fineChannel'},
    const {'1': 'coarseChannel', '3': 2, '4': 1, '5': 13, '10': 'coarseChannel'},
  ],
};

@$core.Deprecated('Use fixtureChannelDescriptor instead')
const FixtureChannel_FinestResolution$json = const {
  '1': 'FinestResolution',
  '2': const [
    const {'1': 'finestChannel', '3': 1, '4': 1, '5': 13, '10': 'finestChannel'},
    const {'1': 'fineChannel', '3': 2, '4': 1, '5': 13, '10': 'fineChannel'},
    const {'1': 'coarseChannel', '3': 3, '4': 1, '5': 13, '10': 'coarseChannel'},
  ],
};

/// Descriptor for `FixtureChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureChannelDescriptor = $convert.base64Decode('Cg5GaXh0dXJlQ2hhbm5lbBISCgRuYW1lGAEgASgJUgRuYW1lEkkKBmNvYXJzZRgCIAEoCzIvLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVDaGFubmVsLkNvYXJzZVJlc29sdXRpb25IAFIGY29hcnNlEkMKBGZpbmUYAyABKAsyLS5taXplci5maXh0dXJlcy5GaXh0dXJlQ2hhbm5lbC5GaW5lUmVzb2x1dGlvbkgAUgRmaW5lEkkKBmZpbmVzdBgEIAEoCzIvLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVDaGFubmVsLkZpbmVzdFJlc29sdXRpb25IAFIGZmluZXN0GiwKEENvYXJzZVJlc29sdXRpb24SGAoHY2hhbm5lbBgBIAEoDVIHY2hhbm5lbBpYCg5GaW5lUmVzb2x1dGlvbhIgCgtmaW5lQ2hhbm5lbBgBIAEoDVILZmluZUNoYW5uZWwSJAoNY29hcnNlQ2hhbm5lbBgCIAEoDVINY29hcnNlQ2hhbm5lbBqAAQoQRmluZXN0UmVzb2x1dGlvbhIkCg1maW5lc3RDaGFubmVsGAEgASgNUg1maW5lc3RDaGFubmVsEiAKC2ZpbmVDaGFubmVsGAIgASgNUgtmaW5lQ2hhbm5lbBIkCg1jb2Fyc2VDaGFubmVsGAMgASgNUg1jb2Fyc2VDaGFubmVsQgwKCnJlc29sdXRpb24=');
@$core.Deprecated('Use fixturePhysicalDataDescriptor instead')
const FixturePhysicalData$json = const {
  '1': 'FixturePhysicalData',
  '2': const [
    const {'1': 'width', '3': 1, '4': 1, '5': 2, '10': 'width'},
    const {'1': 'height', '3': 2, '4': 1, '5': 2, '10': 'height'},
    const {'1': 'depth', '3': 3, '4': 1, '5': 2, '10': 'depth'},
    const {'1': 'weight', '3': 4, '4': 1, '5': 2, '10': 'weight'},
  ],
};

/// Descriptor for `FixturePhysicalData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixturePhysicalDataDescriptor = $convert.base64Decode('ChNGaXh0dXJlUGh5c2ljYWxEYXRhEhQKBXdpZHRoGAEgASgCUgV3aWR0aBIWCgZoZWlnaHQYAiABKAJSBmhlaWdodBIUCgVkZXB0aBgDIAEoAlIFZGVwdGgSFgoGd2VpZ2h0GAQgASgCUgZ3ZWlnaHQ=');
