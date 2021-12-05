///
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use cueTriggerDescriptor instead')
const CueTrigger$json = const {
  '1': 'CueTrigger',
  '2': const [
    const {'1': 'GO', '2': 0},
    const {'1': 'FOLLOW', '2': 1},
    const {'1': 'BEATS', '2': 2},
    const {'1': 'TIMECODE', '2': 3},
  ],
};

/// Descriptor for `CueTrigger`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cueTriggerDescriptor = $convert.base64Decode('CgpDdWVUcmlnZ2VyEgYKAkdPEAASCgoGRk9MTE9XEAESCQoFQkVBVFMQAhIMCghUSU1FQ09ERRAD');
@$core.Deprecated('Use cueControlDescriptor instead')
const CueControl$json = const {
  '1': 'CueControl',
  '2': const [
    const {'1': 'INTENSITY', '2': 0},
    const {'1': 'SHUTTER', '2': 1},
    const {'1': 'COLOR_RED', '2': 2},
    const {'1': 'COLOR_GREEN', '2': 3},
    const {'1': 'COLOR_BLUE', '2': 4},
    const {'1': 'PAN', '2': 5},
    const {'1': 'TILT', '2': 6},
    const {'1': 'FOCUS', '2': 7},
    const {'1': 'ZOOM', '2': 8},
    const {'1': 'PRISM', '2': 9},
    const {'1': 'IRIS', '2': 10},
    const {'1': 'FROST', '2': 11},
    const {'1': 'GENERIC', '2': 12},
  ],
};

/// Descriptor for `CueControl`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cueControlDescriptor = $convert.base64Decode('CgpDdWVDb250cm9sEg0KCUlOVEVOU0lUWRAAEgsKB1NIVVRURVIQARINCglDT0xPUl9SRUQQAhIPCgtDT0xPUl9HUkVFThADEg4KCkNPTE9SX0JMVUUQBBIHCgNQQU4QBRIICgRUSUxUEAYSCQoFRk9DVVMQBxIICgRaT09NEAgSCQoFUFJJU00QCRIICgRJUklTEAoSCQoFRlJPU1QQCxILCgdHRU5FUklDEAw=');
@$core.Deprecated('Use getSequencesRequestDescriptor instead')
const GetSequencesRequest$json = const {
  '1': 'GetSequencesRequest',
};

/// Descriptor for `GetSequencesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSequencesRequestDescriptor = $convert.base64Decode('ChNHZXRTZXF1ZW5jZXNSZXF1ZXN0');
@$core.Deprecated('Use getSequenceRequestDescriptor instead')
const GetSequenceRequest$json = const {
  '1': 'GetSequenceRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
  ],
};

/// Descriptor for `GetSequenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSequenceRequestDescriptor = $convert.base64Decode('ChJHZXRTZXF1ZW5jZVJlcXVlc3QSGgoIc2VxdWVuY2UYASABKA1SCHNlcXVlbmNl');
@$core.Deprecated('Use addSequenceRequestDescriptor instead')
const AddSequenceRequest$json = const {
  '1': 'AddSequenceRequest',
};

/// Descriptor for `AddSequenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addSequenceRequestDescriptor = $convert.base64Decode('ChJBZGRTZXF1ZW5jZVJlcXVlc3Q=');
@$core.Deprecated('Use deleteSequenceRequestDescriptor instead')
const DeleteSequenceRequest$json = const {
  '1': 'DeleteSequenceRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
  ],
};

/// Descriptor for `DeleteSequenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteSequenceRequestDescriptor = $convert.base64Decode('ChVEZWxldGVTZXF1ZW5jZVJlcXVlc3QSGgoIc2VxdWVuY2UYASABKA1SCHNlcXVlbmNl');
@$core.Deprecated('Use sequenceGoRequestDescriptor instead')
const SequenceGoRequest$json = const {
  '1': 'SequenceGoRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
  ],
};

/// Descriptor for `SequenceGoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceGoRequestDescriptor = $convert.base64Decode('ChFTZXF1ZW5jZUdvUmVxdWVzdBIaCghzZXF1ZW5jZRgBIAEoDVIIc2VxdWVuY2U=');
@$core.Deprecated('Use emptyResponseDescriptor instead')
const EmptyResponse$json = const {
  '1': 'EmptyResponse',
};

/// Descriptor for `EmptyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyResponseDescriptor = $convert.base64Decode('Cg1FbXB0eVJlc3BvbnNl');
@$core.Deprecated('Use sequencesDescriptor instead')
const Sequences$json = const {
  '1': 'Sequences',
  '2': const [
    const {'1': 'sequences', '3': 1, '4': 3, '5': 11, '6': '.mizer.sequencer.Sequence', '10': 'sequences'},
  ],
};

/// Descriptor for `Sequences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequencesDescriptor = $convert.base64Decode('CglTZXF1ZW5jZXMSNwoJc2VxdWVuY2VzGAEgAygLMhkubWl6ZXIuc2VxdWVuY2VyLlNlcXVlbmNlUglzZXF1ZW5jZXM=');
@$core.Deprecated('Use sequenceDescriptor instead')
const Sequence$json = const {
  '1': 'Sequence',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'cues', '3': 3, '4': 3, '5': 11, '6': '.mizer.sequencer.Cue', '10': 'cues'},
  ],
};

/// Descriptor for `Sequence`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceDescriptor = $convert.base64Decode('CghTZXF1ZW5jZRIOCgJpZBgBIAEoDVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIoCgRjdWVzGAMgAygLMhQubWl6ZXIuc2VxdWVuY2VyLkN1ZVIEY3Vlcw==');
@$core.Deprecated('Use cueDescriptor instead')
const Cue$json = const {
  '1': 'Cue',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'trigger', '3': 3, '4': 1, '5': 14, '6': '.mizer.sequencer.CueTrigger', '10': 'trigger'},
    const {'1': 'loop', '3': 4, '4': 1, '5': 8, '10': 'loop'},
    const {'1': 'channels', '3': 5, '4': 3, '5': 11, '6': '.mizer.sequencer.CueChannel', '10': 'channels'},
  ],
};

/// Descriptor for `Cue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueDescriptor = $convert.base64Decode('CgNDdWUSDgoCaWQYASABKA1SAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSNQoHdHJpZ2dlchgDIAEoDjIbLm1pemVyLnNlcXVlbmNlci5DdWVUcmlnZ2VyUgd0cmlnZ2VyEhIKBGxvb3AYBCABKAhSBGxvb3ASNwoIY2hhbm5lbHMYBSADKAsyGy5taXplci5zZXF1ZW5jZXIuQ3VlQ2hhbm5lbFIIY2hhbm5lbHM=');
@$core.Deprecated('Use cueChannelDescriptor instead')
const CueChannel$json = const {
  '1': 'CueChannel',
  '2': const [
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
    const {'1': 'control', '3': 2, '4': 1, '5': 14, '6': '.mizer.sequencer.CueControl', '10': 'control'},
    const {'1': 'value', '3': 3, '4': 1, '5': 11, '6': '.mizer.sequencer.CueValue', '10': 'value'},
    const {'1': 'fade', '3': 4, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimer', '10': 'fade'},
    const {'1': 'delay', '3': 5, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimer', '10': 'delay'},
  ],
};

/// Descriptor for `CueChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueChannelDescriptor = $convert.base64Decode('CgpDdWVDaGFubmVsEjUKCGZpeHR1cmVzGAEgAygLMhkubWl6ZXIuZml4dHVyZXMuRml4dHVyZUlkUghmaXh0dXJlcxI1Cgdjb250cm9sGAIgASgOMhsubWl6ZXIuc2VxdWVuY2VyLkN1ZUNvbnRyb2xSB2NvbnRyb2wSLwoFdmFsdWUYAyABKAsyGS5taXplci5zZXF1ZW5jZXIuQ3VlVmFsdWVSBXZhbHVlEi0KBGZhZGUYBCABKAsyGS5taXplci5zZXF1ZW5jZXIuQ3VlVGltZXJSBGZhZGUSLwoFZGVsYXkYBSABKAsyGS5taXplci5zZXF1ZW5jZXIuQ3VlVGltZXJSBWRlbGF5');
@$core.Deprecated('Use cueValueDescriptor instead')
const CueValue$json = const {
  '1': 'CueValue',
  '2': const [
    const {'1': 'direct', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'direct'},
    const {'1': 'range', '3': 4, '4': 1, '5': 11, '6': '.mizer.sequencer.CueValueRange', '9': 0, '10': 'range'},
  ],
  '8': const [
    const {'1': 'value'},
  ],
};

/// Descriptor for `CueValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueValueDescriptor = $convert.base64Decode('CghDdWVWYWx1ZRIYCgZkaXJlY3QYAyABKAFIAFIGZGlyZWN0EjYKBXJhbmdlGAQgASgLMh4ubWl6ZXIuc2VxdWVuY2VyLkN1ZVZhbHVlUmFuZ2VIAFIFcmFuZ2VCBwoFdmFsdWU=');
@$core.Deprecated('Use cueTimerDescriptor instead')
const CueTimer$json = const {
  '1': 'CueTimer',
  '2': const [
    const {'1': 'hasTimer', '3': 1, '4': 1, '5': 8, '10': 'hasTimer'},
    const {'1': 'direct', '3': 2, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '9': 0, '10': 'direct'},
    const {'1': 'range', '3': 3, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimerRange', '9': 0, '10': 'range'},
  ],
  '8': const [
    const {'1': 'timer'},
  ],
};

/// Descriptor for `CueTimer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTimerDescriptor = $convert.base64Decode('CghDdWVUaW1lchIaCghoYXNUaW1lchgBIAEoCFIIaGFzVGltZXISMgoGZGlyZWN0GAIgASgLMhgubWl6ZXIuc2VxdWVuY2VyLkN1ZVRpbWVIAFIGZGlyZWN0EjYKBXJhbmdlGAMgASgLMh4ubWl6ZXIuc2VxdWVuY2VyLkN1ZVRpbWVyUmFuZ2VIAFIFcmFuZ2VCBwoFdGltZXI=');
@$core.Deprecated('Use cueValueRangeDescriptor instead')
const CueValueRange$json = const {
  '1': 'CueValueRange',
  '2': const [
    const {'1': 'from', '3': 1, '4': 1, '5': 1, '10': 'from'},
    const {'1': 'to', '3': 2, '4': 1, '5': 1, '10': 'to'},
  ],
};

/// Descriptor for `CueValueRange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueValueRangeDescriptor = $convert.base64Decode('Cg1DdWVWYWx1ZVJhbmdlEhIKBGZyb20YASABKAFSBGZyb20SDgoCdG8YAiABKAFSAnRv');
@$core.Deprecated('Use cueTimeDescriptor instead')
const CueTime$json = const {
  '1': 'CueTime',
  '2': const [
    const {'1': 'seconds', '3': 1, '4': 1, '5': 1, '9': 0, '10': 'seconds'},
    const {'1': 'beats', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'beats'},
  ],
  '8': const [
    const {'1': 'time'},
  ],
};

/// Descriptor for `CueTime`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTimeDescriptor = $convert.base64Decode('CgdDdWVUaW1lEhoKB3NlY29uZHMYASABKAFIAFIHc2Vjb25kcxIWCgViZWF0cxgCIAEoAUgAUgViZWF0c0IGCgR0aW1l');
@$core.Deprecated('Use cueTimerRangeDescriptor instead')
const CueTimerRange$json = const {
  '1': 'CueTimerRange',
  '2': const [
    const {'1': 'from', '3': 1, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '10': 'from'},
    const {'1': 'to', '3': 2, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '10': 'to'},
  ],
};

/// Descriptor for `CueTimerRange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTimerRangeDescriptor = $convert.base64Decode('Cg1DdWVUaW1lclJhbmdlEiwKBGZyb20YASABKAsyGC5taXplci5zZXF1ZW5jZXIuQ3VlVGltZVIEZnJvbRIoCgJ0bxgCIAEoCzIYLm1pemVyLnNlcXVlbmNlci5DdWVUaW1lUgJ0bw==');
