///
//  Generated code. Do not modify.
//  source: timecode.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use noContentResponseDescriptor instead')
const NoContentResponse$json = const {
  '1': 'NoContentResponse',
};

/// Descriptor for `NoContentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List noContentResponseDescriptor = $convert.base64Decode('ChFOb0NvbnRlbnRSZXNwb25zZQ==');
@$core.Deprecated('Use addTimecodeRequestDescriptor instead')
const AddTimecodeRequest$json = const {
  '1': 'AddTimecodeRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AddTimecodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addTimecodeRequestDescriptor = $convert.base64Decode('ChJBZGRUaW1lY29kZVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use renameTimecodeRequestDescriptor instead')
const RenameTimecodeRequest$json = const {
  '1': 'RenameTimecodeRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `RenameTimecodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renameTimecodeRequestDescriptor = $convert.base64Decode('ChVSZW5hbWVUaW1lY29kZVJlcXVlc3QSDgoCaWQYASABKA1SAmlkEhIKBG5hbWUYAiABKAlSBG5hbWU=');
@$core.Deprecated('Use deleteTimecodeRequestDescriptor instead')
const DeleteTimecodeRequest$json = const {
  '1': 'DeleteTimecodeRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
  ],
};

/// Descriptor for `DeleteTimecodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteTimecodeRequestDescriptor = $convert.base64Decode('ChVEZWxldGVUaW1lY29kZVJlcXVlc3QSDgoCaWQYASABKA1SAmlk');
@$core.Deprecated('Use addTimecodeControlRequestDescriptor instead')
const AddTimecodeControlRequest$json = const {
  '1': 'AddTimecodeControlRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AddTimecodeControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addTimecodeControlRequestDescriptor = $convert.base64Decode('ChlBZGRUaW1lY29kZUNvbnRyb2xSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWU=');
@$core.Deprecated('Use renameTimecodeControlRequestDescriptor instead')
const RenameTimecodeControlRequest$json = const {
  '1': 'RenameTimecodeControlRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `RenameTimecodeControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renameTimecodeControlRequestDescriptor = $convert.base64Decode('ChxSZW5hbWVUaW1lY29kZUNvbnRyb2xSZXF1ZXN0Eg4KAmlkGAEgASgNUgJpZBISCgRuYW1lGAIgASgJUgRuYW1l');
@$core.Deprecated('Use deleteTimecodeControlRequestDescriptor instead')
const DeleteTimecodeControlRequest$json = const {
  '1': 'DeleteTimecodeControlRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
  ],
};

/// Descriptor for `DeleteTimecodeControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteTimecodeControlRequestDescriptor = $convert.base64Decode('ChxEZWxldGVUaW1lY29kZUNvbnRyb2xSZXF1ZXN0Eg4KAmlkGAEgASgNUgJpZA==');
@$core.Deprecated('Use allTimecodesDescriptor instead')
const AllTimecodes$json = const {
  '1': 'AllTimecodes',
  '2': const [
    const {'1': 'timecodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.timecode.Timecode', '10': 'timecodes'},
    const {'1': 'controls', '3': 2, '4': 3, '5': 11, '6': '.mizer.timecode.TimecodeControl', '10': 'controls'},
  ],
};

/// Descriptor for `AllTimecodes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allTimecodesDescriptor = $convert.base64Decode('CgxBbGxUaW1lY29kZXMSNgoJdGltZWNvZGVzGAEgAygLMhgubWl6ZXIudGltZWNvZGUuVGltZWNvZGVSCXRpbWVjb2RlcxI7Cghjb250cm9scxgCIAMoCzIfLm1pemVyLnRpbWVjb2RlLlRpbWVjb2RlQ29udHJvbFIIY29udHJvbHM=');
@$core.Deprecated('Use timecodeDescriptor instead')
const Timecode$json = const {
  '1': 'Timecode',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'controls', '3': 3, '4': 3, '5': 11, '6': '.mizer.timecode.TimecodeControlValues', '10': 'controls'},
  ],
};

/// Descriptor for `Timecode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timecodeDescriptor = $convert.base64Decode('CghUaW1lY29kZRIOCgJpZBgBIAEoDVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRJBCghjb250cm9scxgDIAMoCzIlLm1pemVyLnRpbWVjb2RlLlRpbWVjb2RlQ29udHJvbFZhbHVlc1IIY29udHJvbHM=');
@$core.Deprecated('Use timecodeControlDescriptor instead')
const TimecodeControl$json = const {
  '1': 'TimecodeControl',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `TimecodeControl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timecodeControlDescriptor = $convert.base64Decode('Cg9UaW1lY29kZUNvbnRyb2wSDgoCaWQYASABKA1SAmlkEhIKBG5hbWUYAiABKAlSBG5hbWU=');
@$core.Deprecated('Use timecodeControlValuesDescriptor instead')
const TimecodeControlValues$json = const {
  '1': 'TimecodeControlValues',
  '2': const [
    const {'1': 'control_id', '3': 1, '4': 1, '5': 13, '10': 'controlId'},
    const {'1': 'steps', '3': 2, '4': 3, '5': 11, '6': '.mizer.timecode.TimecodeControlValues.Step', '10': 'steps'},
  ],
  '3': const [TimecodeControlValues_Step$json],
};

@$core.Deprecated('Use timecodeControlValuesDescriptor instead')
const TimecodeControlValues_Step$json = const {
  '1': 'Step',
  '2': const [
    const {'1': 'x', '3': 1, '4': 1, '5': 1, '10': 'x'},
    const {'1': 'y', '3': 2, '4': 1, '5': 1, '10': 'y'},
    const {'1': 'c0a', '3': 3, '4': 1, '5': 1, '10': 'c0a'},
    const {'1': 'c0b', '3': 4, '4': 1, '5': 1, '10': 'c0b'},
    const {'1': 'c1a', '3': 5, '4': 1, '5': 1, '10': 'c1a'},
    const {'1': 'c1b', '3': 6, '4': 1, '5': 1, '10': 'c1b'},
  ],
};

/// Descriptor for `TimecodeControlValues`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timecodeControlValuesDescriptor = $convert.base64Decode('ChVUaW1lY29kZUNvbnRyb2xWYWx1ZXMSHQoKY29udHJvbF9pZBgBIAEoDVIJY29udHJvbElkEkAKBXN0ZXBzGAIgAygLMioubWl6ZXIudGltZWNvZGUuVGltZWNvZGVDb250cm9sVmFsdWVzLlN0ZXBSBXN0ZXBzGmoKBFN0ZXASDAoBeBgBIAEoAVIBeBIMCgF5GAIgASgBUgF5EhAKA2MwYRgDIAEoAVIDYzBhEhAKA2MwYhgEIAEoAVIDYzBiEhAKA2MxYRgFIAEoAVIDYzFhEhAKA2MxYhgGIAEoAVIDYzFi');
