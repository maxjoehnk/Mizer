///
//  Generated code. Do not modify.
//  source: programmer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

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
  ],
};

/// Descriptor for `ProgrammerState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List programmerStateDescriptor = $convert.base64Decode('Cg9Qcm9ncmFtbWVyU3RhdGUSNQoIZml4dHVyZXMYASADKAsyGS5taXplci5maXh0dXJlcy5GaXh0dXJlSWRSCGZpeHR1cmVz');
@$core.Deprecated('Use writeControlRequestDescriptor instead')
const WriteControlRequest$json = const {
  '1': 'WriteControlRequest',
  '2': const [
    const {'1': 'control', '3': 1, '4': 1, '5': 14, '6': '.mizer.fixtures.FixtureControl', '10': 'control'},
    const {'1': 'fader', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'fader'},
    const {'1': 'color', '3': 3, '4': 1, '5': 11, '6': '.mizer.fixtures.ColorChannel', '9': 0, '10': 'color'},
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
final $typed_data.Uint8List writeControlRequestDescriptor = $convert.base64Decode('ChNXcml0ZUNvbnRyb2xSZXF1ZXN0EjgKB2NvbnRyb2wYASABKA4yHi5taXplci5maXh0dXJlcy5GaXh0dXJlQ29udHJvbFIHY29udHJvbBIWCgVmYWRlchgCIAEoAUgAUgVmYWRlchI0CgVjb2xvchgDIAEoCzIcLm1pemVyLmZpeHR1cmVzLkNvbG9yQ2hhbm5lbEgAUgVjb2xvchJOCgdnZW5lcmljGAQgASgLMjIubWl6ZXIucHJvZ3JhbW1lci5Xcml0ZUNvbnRyb2xSZXF1ZXN0LkdlbmVyaWNWYWx1ZUgAUgdnZW5lcmljGjgKDEdlbmVyaWNWYWx1ZRISCgRuYW1lGAEgASgJUgRuYW1lEhQKBXZhbHVlGAIgASgBUgV2YWx1ZUIHCgV2YWx1ZQ==');
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
  ],
  '4': const [StoreRequest_Mode$json],
};

@$core.Deprecated('Use storeRequestDescriptor instead')
const StoreRequest_Mode$json = const {
  '1': 'Mode',
  '2': const [
    const {'1': 'Overwrite', '2': 0},
    const {'1': 'Merge', '2': 1},
    const {'1': 'AddCue', '2': 2},
  ],
};

/// Descriptor for `StoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storeRequestDescriptor = $convert.base64Decode('CgxTdG9yZVJlcXVlc3QSHwoLc2VxdWVuY2VfaWQYASABKA1SCnNlcXVlbmNlSWQSQgoKc3RvcmVfbW9kZRgCIAEoDjIjLm1pemVyLnByb2dyYW1tZXIuU3RvcmVSZXF1ZXN0Lk1vZGVSCXN0b3JlTW9kZSIsCgRNb2RlEg0KCU92ZXJ3cml0ZRAAEgkKBU1lcmdlEAESCgoGQWRkQ3VlEAI=');
@$core.Deprecated('Use storeResponseDescriptor instead')
const StoreResponse$json = const {
  '1': 'StoreResponse',
};

/// Descriptor for `StoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storeResponseDescriptor = $convert.base64Decode('Cg1TdG9yZVJlc3BvbnNl');
