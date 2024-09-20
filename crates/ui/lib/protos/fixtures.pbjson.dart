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

@$core.Deprecated('Use fixtureChannelCategoryDescriptor instead')
const FixtureChannelCategory$json = {
  '1': 'FixtureChannelCategory',
  '2': [
    {'1': 'NONE', '2': 0},
    {'1': 'DIMMER', '2': 1},
    {'1': 'COLOR', '2': 2},
    {'1': 'POSITION', '2': 3},
    {'1': 'GOBO', '2': 4},
    {'1': 'BEAM', '2': 5},
    {'1': 'SHAPER', '2': 6},
    {'1': 'CUSTOM', '2': 7},
  ],
};

/// Descriptor for `FixtureChannelCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fixtureChannelCategoryDescriptor = $convert.base64Decode(
    'ChZGaXh0dXJlQ2hhbm5lbENhdGVnb3J5EggKBE5PTkUQABIKCgZESU1NRVIQARIJCgVDT0xPUh'
    'ACEgwKCFBPU0lUSU9OEAMSCAoER09CTxAEEggKBEJFQU0QBRIKCgZTSEFQRVIQBhIKCgZDVVNU'
    'T00QBw==');

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
    {'1': 'channel', '3': 1, '4': 1, '5': 9, '10': 'channel'},
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
    'cmVMaW1pdEgFUgVsaW1pdIgBARpsChJVcGRhdGVGaXh0dXJlTGltaXQSGAoHY2hhbm5lbBgBIA'
    'EoCVIHY2hhbm5lbBIVCgNtaW4YAiABKAFIAFIDbWluiAEBEhUKA21heBgDIAEoAUgBUgNtYXiI'
    'AQFCBgoEX21pbkIGCgRfbWF4Qg0KC19pbnZlcnRfcGFuQg4KDF9pbnZlcnRfdGlsdEIWChRfcm'
    'V2ZXJzZV9waXhlbF9vcmRlckIHCgVfbmFtZUIKCghfYWRkcmVzc0IICgZfbGltaXQ=');

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
    {'1': 'channels', '3': 9, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureChannel', '10': 'channels'},
    {'1': 'children', '3': 10, '4': 3, '5': 11, '6': '.mizer.fixtures.SubFixture', '10': 'children'},
    {'1': 'config', '3': 11, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureConfig', '10': 'config'},
  ],
};

/// Descriptor for `Fixture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureDescriptor = $convert.base64Decode(
    'CgdGaXh0dXJlEg4KAmlkGAEgASgNUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiIKDG1hbnVmYW'
    'N0dXJlchgDIAEoCVIMbWFudWZhY3R1cmVyEhQKBW1vZGVsGAQgASgJUgVtb2RlbBISCgRtb2Rl'
    'GAUgASgJUgRtb2RlEhoKCHVuaXZlcnNlGAYgASgNUgh1bml2ZXJzZRIYCgdjaGFubmVsGAcgAS'
    'gNUgdjaGFubmVsEiMKDWNoYW5uZWxfY291bnQYCCABKA1SDGNoYW5uZWxDb3VudBI6CghjaGFu'
    'bmVscxgJIAMoCzIeLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVDaGFubmVsUghjaGFubmVscxI2Cg'
    'hjaGlsZHJlbhgKIAMoCzIaLm1pemVyLmZpeHR1cmVzLlN1YkZpeHR1cmVSCGNoaWxkcmVuEjUK'
    'BmNvbmZpZxgLIAEoCzIdLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVDb25maWdSBmNvbmZpZw==');

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
    {'1': 'channel', '3': 1, '4': 1, '5': 9, '10': 'channel'},
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
    'ChNGaXh0dXJlQ2hhbm5lbExpbWl0EhgKB2NoYW5uZWwYASABKAlSB2NoYW5uZWwSFQoDbWluGA'
    'IgASgBSABSA21pbogBARIVCgNtYXgYAyABKAFIAVIDbWF4iAEBQgYKBF9taW5CBgoEX21heA==');

@$core.Deprecated('Use subFixtureDescriptor instead')
const SubFixture$json = {
  '1': 'SubFixture',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'channels', '3': 3, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureChannel', '10': 'channels'},
  ],
};

/// Descriptor for `SubFixture`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subFixtureDescriptor = $convert.base64Decode(
    'CgpTdWJGaXh0dXJlEg4KAmlkGAEgASgNUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEjoKCGNoYW'
    '5uZWxzGAMgAygLMh4ubWl6ZXIuZml4dHVyZXMuRml4dHVyZUNoYW5uZWxSCGNoYW5uZWxz');

@$core.Deprecated('Use fixtureChannelDescriptor instead')
const FixtureChannel$json = {
  '1': 'FixtureChannel',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 9, '10': 'channel'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'label', '17': true},
    {'1': 'category', '3': 3, '4': 1, '5': 14, '6': '.mizer.fixtures.FixtureChannelCategory', '10': 'category'},
    {'1': 'presets', '3': 4, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureChannelPreset', '10': 'presets'},
    {'1': 'value', '3': 5, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureValue', '9': 1, '10': 'value', '17': true},
  ],
  '8': [
    {'1': '_label'},
    {'1': '_value'},
  ],
};

/// Descriptor for `FixtureChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureChannelDescriptor = $convert.base64Decode(
    'Cg5GaXh0dXJlQ2hhbm5lbBIYCgdjaGFubmVsGAEgASgJUgdjaGFubmVsEhkKBWxhYmVsGAIgAS'
    'gJSABSBWxhYmVsiAEBEkIKCGNhdGVnb3J5GAMgASgOMiYubWl6ZXIuZml4dHVyZXMuRml4dHVy'
    'ZUNoYW5uZWxDYXRlZ29yeVIIY2F0ZWdvcnkSPgoHcHJlc2V0cxgEIAMoCzIkLm1pemVyLmZpeH'
    'R1cmVzLkZpeHR1cmVDaGFubmVsUHJlc2V0UgdwcmVzZXRzEjcKBXZhbHVlGAUgASgLMhwubWl6'
    'ZXIuZml4dHVyZXMuRml4dHVyZVZhbHVlSAFSBXZhbHVliAEBQggKBl9sYWJlbEIICgZfdmFsdW'
    'U=');

@$core.Deprecated('Use fixtureChannelDefinitionDescriptor instead')
const FixtureChannelDefinition$json = {
  '1': 'FixtureChannelDefinition',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 9, '10': 'channel'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'label', '17': true},
    {'1': 'category', '3': 3, '4': 1, '5': 14, '6': '.mizer.fixtures.FixtureChannelCategory', '10': 'category'},
    {'1': 'presets', '3': 4, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureChannelPreset', '10': 'presets'},
  ],
  '8': [
    {'1': '_label'},
  ],
};

/// Descriptor for `FixtureChannelDefinition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureChannelDefinitionDescriptor = $convert.base64Decode(
    'ChhGaXh0dXJlQ2hhbm5lbERlZmluaXRpb24SGAoHY2hhbm5lbBgBIAEoCVIHY2hhbm5lbBIZCg'
    'VsYWJlbBgCIAEoCUgAUgVsYWJlbIgBARJCCghjYXRlZ29yeRgDIAEoDjImLm1pemVyLmZpeHR1'
    'cmVzLkZpeHR1cmVDaGFubmVsQ2F0ZWdvcnlSCGNhdGVnb3J5Ej4KB3ByZXNldHMYBCADKAsyJC'
    '5taXplci5maXh0dXJlcy5GaXh0dXJlQ2hhbm5lbFByZXNldFIHcHJlc2V0c0IICgZfbGFiZWw=');

@$core.Deprecated('Use fixtureChannelPresetDescriptor instead')
const FixtureChannelPreset$json = {
  '1': 'FixtureChannelPreset',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureValue', '10': 'value'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'image', '3': 3, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureImage', '9': 0, '10': 'image', '17': true},
    {'1': 'colors', '3': 4, '4': 3, '5': 9, '10': 'colors'},
  ],
  '8': [
    {'1': '_image'},
  ],
};

/// Descriptor for `FixtureChannelPreset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureChannelPresetDescriptor = $convert.base64Decode(
    'ChRGaXh0dXJlQ2hhbm5lbFByZXNldBIyCgV2YWx1ZRgBIAEoCzIcLm1pemVyLmZpeHR1cmVzLk'
    'ZpeHR1cmVWYWx1ZVIFdmFsdWUSEgoEbmFtZRgCIAEoCVIEbmFtZRI3CgVpbWFnZRgDIAEoCzIc'
    'Lm1pemVyLmZpeHR1cmVzLkZpeHR1cmVJbWFnZUgAUgVpbWFnZYgBARIWCgZjb2xvcnMYBCADKA'
    'lSBmNvbG9yc0IICgZfaW1hZ2U=');

@$core.Deprecated('Use fixtureValueDescriptor instead')
const FixtureValue$json = {
  '1': 'FixtureValue',
  '2': [
    {'1': 'percent', '3': 1, '4': 1, '5': 1, '9': 0, '10': 'percent'},
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `FixtureValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureValueDescriptor = $convert.base64Decode(
    'CgxGaXh0dXJlVmFsdWUSGgoHcGVyY2VudBgBIAEoAUgAUgdwZXJjZW50QgcKBXZhbHVl');

@$core.Deprecated('Use fixtureImageDescriptor instead')
const FixtureImage$json = {
  '1': 'FixtureImage',
  '2': [
    {'1': 'svg', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'svg'},
    {'1': 'raster', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'raster'},
  ],
  '8': [
    {'1': 'image'},
  ],
};

/// Descriptor for `FixtureImage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureImageDescriptor = $convert.base64Decode(
    'CgxGaXh0dXJlSW1hZ2USEgoDc3ZnGAEgASgJSABSA3N2ZxIYCgZyYXN0ZXIYAiABKAxIAFIGcm'
    'FzdGVyQgcKBWltYWdl');

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
    {'1': 'channels', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureChannelDefinition', '10': 'channels'},
    {'1': 'dmx_footprint', '3': 3, '4': 1, '5': 13, '10': 'dmxFootprint'},
  ],
};

/// Descriptor for `FixtureMode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureModeDescriptor = $convert.base64Decode(
    'CgtGaXh0dXJlTW9kZRISCgRuYW1lGAEgASgJUgRuYW1lEkQKCGNoYW5uZWxzGAIgAygLMigubW'
    'l6ZXIuZml4dHVyZXMuRml4dHVyZUNoYW5uZWxEZWZpbml0aW9uUghjaGFubmVscxIjCg1kbXhf'
    'Zm9vdHByaW50GAMgASgNUgxkbXhGb290cHJpbnQ=');

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

