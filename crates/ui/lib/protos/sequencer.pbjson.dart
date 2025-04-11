///
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use fixturePriorityDescriptor instead')
const FixturePriority$json = const {
  '1': 'FixturePriority',
  '2': const [
    const {'1': 'PRIORITY_HTP', '2': 0},
    const {'1': 'PRIORITY_LTP_HIGHEST', '2': 1},
    const {'1': 'PRIORITY_LTP_HIGH', '2': 2},
    const {'1': 'PRIORITY_LTP_NORMAL', '2': 3},
    const {'1': 'PRIORITY_LTP_LOW', '2': 4},
    const {'1': 'PRIORITY_LTP_LOWEST', '2': 5},
  ],
};

/// Descriptor for `FixturePriority`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fixturePriorityDescriptor = $convert.base64Decode('Cg9GaXh0dXJlUHJpb3JpdHkSEAoMUFJJT1JJVFlfSFRQEAASGAoUUFJJT1JJVFlfTFRQX0hJR0hFU1QQARIVChFQUklPUklUWV9MVFBfSElHSBACEhcKE1BSSU9SSVRZX0xUUF9OT1JNQUwQAxIUChBQUklPUklUWV9MVFBfTE9XEAQSFwoTUFJJT1JJVFlfTFRQX0xPV0VTVBAF');
@$core.Deprecated('Use getSequencesRequestDescriptor instead')
const GetSequencesRequest$json = const {
  '1': 'GetSequencesRequest',
};

/// Descriptor for `GetSequencesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSequencesRequestDescriptor = $convert.base64Decode('ChNHZXRTZXF1ZW5jZXNSZXF1ZXN0');
@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode('CgVFbXB0eQ==');
@$core.Deprecated('Use sequencerStateDescriptor instead')
const SequencerState$json = const {
  '1': 'SequencerState',
  '2': const [
    const {'1': 'sequences', '3': 1, '4': 3, '5': 11, '6': '.mizer.sequencer.SequenceState', '10': 'sequences'},
  ],
};

/// Descriptor for `SequencerState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequencerStateDescriptor = $convert.base64Decode('Cg5TZXF1ZW5jZXJTdGF0ZRI8CglzZXF1ZW5jZXMYASADKAsyHi5taXplci5zZXF1ZW5jZXIuU2VxdWVuY2VTdGF0ZVIJc2VxdWVuY2Vz');
@$core.Deprecated('Use sequenceStateDescriptor instead')
const SequenceState$json = const {
  '1': 'SequenceState',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'active', '3': 3, '4': 1, '5': 8, '10': 'active'},
    const {'1': 'rate', '3': 4, '4': 1, '5': 1, '10': 'rate'},
  ],
};

/// Descriptor for `SequenceState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceStateDescriptor = $convert.base64Decode('Cg1TZXF1ZW5jZVN0YXRlEhoKCHNlcXVlbmNlGAEgASgNUghzZXF1ZW5jZRISCgRuYW1lGAIgASgJUgRuYW1lEhYKBmFjdGl2ZRgDIAEoCFIGYWN0aXZlEhIKBHJhdGUYBCABKAFSBHJhdGU=');
@$core.Deprecated('Use getSequenceRequestDescriptor instead')
const GetSequenceRequest$json = const {
  '1': 'GetSequenceRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
  ],
};

/// Descriptor for `GetSequenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSequenceRequestDescriptor = $convert.base64Decode('ChJHZXRTZXF1ZW5jZVJlcXVlc3QSGgoIc2VxdWVuY2UYASABKA1SCHNlcXVlbmNl');
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
@$core.Deprecated('Use sequenceStopRequestDescriptor instead')
const SequenceStopRequest$json = const {
  '1': 'SequenceStopRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
  ],
};

/// Descriptor for `SequenceStopRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceStopRequestDescriptor = $convert.base64Decode('ChNTZXF1ZW5jZVN0b3BSZXF1ZXN0EhoKCHNlcXVlbmNlGAEgASgNUghzZXF1ZW5jZQ==');
@$core.Deprecated('Use cueTriggerRequestDescriptor instead')
const CueTriggerRequest$json = const {
  '1': 'CueTriggerRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    const {'1': 'cue', '3': 2, '4': 1, '5': 13, '10': 'cue'},
    const {'1': 'trigger', '3': 3, '4': 1, '5': 14, '6': '.mizer.sequencer.CueTrigger.Type', '10': 'trigger'},
  ],
};

/// Descriptor for `CueTriggerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTriggerRequestDescriptor = $convert.base64Decode('ChFDdWVUcmlnZ2VyUmVxdWVzdBIaCghzZXF1ZW5jZRgBIAEoDVIIc2VxdWVuY2USEAoDY3VlGAIgASgNUgNjdWUSOgoHdHJpZ2dlchgDIAEoDjIgLm1pemVyLnNlcXVlbmNlci5DdWVUcmlnZ2VyLlR5cGVSB3RyaWdnZXI=');
@$core.Deprecated('Use cueTriggerTimeRequestDescriptor instead')
const CueTriggerTimeRequest$json = const {
  '1': 'CueTriggerTimeRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    const {'1': 'cue', '3': 2, '4': 1, '5': 13, '10': 'cue'},
    const {'1': 'time', '3': 3, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '10': 'time'},
  ],
};

/// Descriptor for `CueTriggerTimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTriggerTimeRequestDescriptor = $convert.base64Decode('ChVDdWVUcmlnZ2VyVGltZVJlcXVlc3QSGgoIc2VxdWVuY2UYASABKA1SCHNlcXVlbmNlEhAKA2N1ZRgCIAEoDVIDY3VlEiwKBHRpbWUYAyABKAsyGC5taXplci5zZXF1ZW5jZXIuQ3VlVGltZVIEdGltZQ==');
@$core.Deprecated('Use cueEffectOffsetTimeRequestDescriptor instead')
const CueEffectOffsetTimeRequest$json = const {
  '1': 'CueEffectOffsetTimeRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    const {'1': 'cue', '3': 2, '4': 1, '5': 13, '10': 'cue'},
    const {'1': 'effect', '3': 3, '4': 1, '5': 13, '10': 'effect'},
    const {'1': 'time', '3': 4, '4': 1, '5': 1, '9': 0, '10': 'time', '17': true},
  ],
  '8': const [
    const {'1': '_time'},
  ],
};

/// Descriptor for `CueEffectOffsetTimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueEffectOffsetTimeRequestDescriptor = $convert.base64Decode('ChpDdWVFZmZlY3RPZmZzZXRUaW1lUmVxdWVzdBIaCghzZXF1ZW5jZRgBIAEoDVIIc2VxdWVuY2USEAoDY3VlGAIgASgNUgNjdWUSFgoGZWZmZWN0GAMgASgNUgZlZmZlY3QSFwoEdGltZRgEIAEoAUgAUgR0aW1liAEBQgcKBV90aW1l');
@$core.Deprecated('Use cueNameRequestDescriptor instead')
const CueNameRequest$json = const {
  '1': 'CueNameRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    const {'1': 'cue', '3': 2, '4': 1, '5': 13, '10': 'cue'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `CueNameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueNameRequestDescriptor = $convert.base64Decode('Cg5DdWVOYW1lUmVxdWVzdBIaCghzZXF1ZW5jZRgBIAEoDVIIc2VxdWVuY2USEAoDY3VlGAIgASgNUgNjdWUSEgoEbmFtZRgDIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use cueValueRequestDescriptor instead')
const CueValueRequest$json = const {
  '1': 'CueValueRequest',
  '2': const [
    const {'1': 'sequence_id', '3': 1, '4': 1, '5': 13, '10': 'sequenceId'},
    const {'1': 'cue_id', '3': 2, '4': 1, '5': 13, '10': 'cueId'},
    const {'1': 'control_index', '3': 3, '4': 1, '5': 13, '10': 'controlIndex'},
    const {'1': 'value', '3': 4, '4': 1, '5': 11, '6': '.mizer.sequencer.CueValue', '10': 'value'},
  ],
};

/// Descriptor for `CueValueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueValueRequestDescriptor = $convert.base64Decode('Cg9DdWVWYWx1ZVJlcXVlc3QSHwoLc2VxdWVuY2VfaWQYASABKA1SCnNlcXVlbmNlSWQSFQoGY3VlX2lkGAIgASgNUgVjdWVJZBIjCg1jb250cm9sX2luZGV4GAMgASgNUgxjb250cm9sSW5kZXgSLwoFdmFsdWUYBCABKAsyGS5taXplci5zZXF1ZW5jZXIuQ3VlVmFsdWVSBXZhbHVl');
@$core.Deprecated('Use cueTimingRequestDescriptor instead')
const CueTimingRequest$json = const {
  '1': 'CueTimingRequest',
  '2': const [
    const {'1': 'sequence_id', '3': 1, '4': 1, '5': 13, '10': 'sequenceId'},
    const {'1': 'cue_id', '3': 2, '4': 1, '5': 13, '10': 'cueId'},
    const {'1': 'time', '3': 3, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimer', '10': 'time'},
  ],
};

/// Descriptor for `CueTimingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTimingRequestDescriptor = $convert.base64Decode('ChBDdWVUaW1pbmdSZXF1ZXN0Eh8KC3NlcXVlbmNlX2lkGAEgASgNUgpzZXF1ZW5jZUlkEhUKBmN1ZV9pZBgCIAEoDVIFY3VlSWQSLQoEdGltZRgDIAEoCzIZLm1pemVyLnNlcXVlbmNlci5DdWVUaW1lclIEdGltZQ==');
@$core.Deprecated('Use sequenceWrapAroundRequestDescriptor instead')
const SequenceWrapAroundRequest$json = const {
  '1': 'SequenceWrapAroundRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    const {'1': 'wrap_around', '3': 2, '4': 1, '5': 8, '10': 'wrapAround'},
  ],
};

/// Descriptor for `SequenceWrapAroundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceWrapAroundRequestDescriptor = $convert.base64Decode('ChlTZXF1ZW5jZVdyYXBBcm91bmRSZXF1ZXN0EhoKCHNlcXVlbmNlGAEgASgNUghzZXF1ZW5jZRIfCgt3cmFwX2Fyb3VuZBgCIAEoCFIKd3JhcEFyb3VuZA==');
@$core.Deprecated('Use sequenceStopOnLastCueRequestDescriptor instead')
const SequenceStopOnLastCueRequest$json = const {
  '1': 'SequenceStopOnLastCueRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    const {'1': 'stop_on_last_cue', '3': 2, '4': 1, '5': 8, '10': 'stopOnLastCue'},
  ],
};

/// Descriptor for `SequenceStopOnLastCueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceStopOnLastCueRequestDescriptor = $convert.base64Decode('ChxTZXF1ZW5jZVN0b3BPbkxhc3RDdWVSZXF1ZXN0EhoKCHNlcXVlbmNlGAEgASgNUghzZXF1ZW5jZRInChBzdG9wX29uX2xhc3RfY3VlGAIgASgIUg1zdG9wT25MYXN0Q3Vl');
@$core.Deprecated('Use sequencePriorityRequestDescriptor instead')
const SequencePriorityRequest$json = const {
  '1': 'SequencePriorityRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    const {'1': 'priority', '3': 2, '4': 1, '5': 14, '6': '.mizer.sequencer.FixturePriority', '10': 'priority'},
  ],
};

/// Descriptor for `SequencePriorityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequencePriorityRequestDescriptor = $convert.base64Decode('ChdTZXF1ZW5jZVByaW9yaXR5UmVxdWVzdBIaCghzZXF1ZW5jZRgBIAEoDVIIc2VxdWVuY2USPAoIcHJpb3JpdHkYAiABKA4yIC5taXplci5zZXF1ZW5jZXIuRml4dHVyZVByaW9yaXR5Ughwcmlvcml0eQ==');
@$core.Deprecated('Use sequenceNameRequestDescriptor instead')
const SequenceNameRequest$json = const {
  '1': 'SequenceNameRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `SequenceNameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceNameRequestDescriptor = $convert.base64Decode('ChNTZXF1ZW5jZU5hbWVSZXF1ZXN0EhoKCHNlcXVlbmNlGAEgASgNUghzZXF1ZW5jZRISCgRuYW1lGAIgASgJUgRuYW1l');
@$core.Deprecated('Use assignSequencePortRequestDescriptor instead')
const AssignSequencePortRequest$json = const {
  '1': 'AssignSequencePortRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    const {'1': 'port', '3': 2, '4': 1, '5': 13, '10': 'port'},
  ],
};

/// Descriptor for `AssignSequencePortRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assignSequencePortRequestDescriptor = $convert.base64Decode('ChlBc3NpZ25TZXF1ZW5jZVBvcnRSZXF1ZXN0EhoKCHNlcXVlbmNlGAEgASgNUghzZXF1ZW5jZRISCgRwb3J0GAIgASgNUgRwb3J0');
@$core.Deprecated('Use removeSequencePortRequestDescriptor instead')
const RemoveSequencePortRequest$json = const {
  '1': 'RemoveSequencePortRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    const {'1': 'port', '3': 2, '4': 1, '5': 13, '10': 'port'},
  ],
};

/// Descriptor for `RemoveSequencePortRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeSequencePortRequestDescriptor = $convert.base64Decode('ChlSZW1vdmVTZXF1ZW5jZVBvcnRSZXF1ZXN0EhoKCHNlcXVlbmNlGAEgASgNUghzZXF1ZW5jZRISCgRwb3J0GAIgASgNUgRwb3J0');
@$core.Deprecated('Use setSequencePortValueRequestDescriptor instead')
const SetSequencePortValueRequest$json = const {
  '1': 'SetSequencePortValueRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    const {'1': 'port', '3': 2, '4': 1, '5': 13, '10': 'port'},
    const {'1': 'cue', '3': 3, '4': 1, '5': 13, '10': 'cue'},
    const {'1': 'value', '3': 4, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `SetSequencePortValueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setSequencePortValueRequestDescriptor = $convert.base64Decode('ChtTZXRTZXF1ZW5jZVBvcnRWYWx1ZVJlcXVlc3QSGgoIc2VxdWVuY2UYASABKA1SCHNlcXVlbmNlEhIKBHBvcnQYAiABKA1SBHBvcnQSEAoDY3VlGAMgASgNUgNjdWUSFAoFdmFsdWUYBCABKAFSBXZhbHVl');
@$core.Deprecated('Use clearSequencePortValueRequestDescriptor instead')
const ClearSequencePortValueRequest$json = const {
  '1': 'ClearSequencePortValueRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    const {'1': 'port', '3': 2, '4': 1, '5': 13, '10': 'port'},
    const {'1': 'cue', '3': 3, '4': 1, '5': 13, '10': 'cue'},
  ],
};

/// Descriptor for `ClearSequencePortValueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clearSequencePortValueRequestDescriptor = $convert.base64Decode('Ch1DbGVhclNlcXVlbmNlUG9ydFZhbHVlUmVxdWVzdBIaCghzZXF1ZW5jZRgBIAEoDVIIc2VxdWVuY2USEgoEcG9ydBgCIAEoDVIEcG9ydBIQCgNjdWUYAyABKA1SA2N1ZQ==');
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
    const {'1': 'fixtures', '3': 4, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
    const {'1': 'ports', '3': 5, '4': 3, '5': 13, '10': 'ports'},
    const {'1': 'wrap_around', '3': 6, '4': 1, '5': 8, '10': 'wrapAround'},
    const {'1': 'stop_on_last_cue', '3': 7, '4': 1, '5': 8, '10': 'stopOnLastCue'},
    const {'1': 'priority', '3': 8, '4': 1, '5': 14, '6': '.mizer.sequencer.FixturePriority', '10': 'priority'},
  ],
};

/// Descriptor for `Sequence`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceDescriptor = $convert.base64Decode('CghTZXF1ZW5jZRIOCgJpZBgBIAEoDVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIoCgRjdWVzGAMgAygLMhQubWl6ZXIuc2VxdWVuY2VyLkN1ZVIEY3VlcxI1CghmaXh0dXJlcxgEIAMoCzIZLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVJZFIIZml4dHVyZXMSFAoFcG9ydHMYBSADKA1SBXBvcnRzEh8KC3dyYXBfYXJvdW5kGAYgASgIUgp3cmFwQXJvdW5kEicKEHN0b3Bfb25fbGFzdF9jdWUYByABKAhSDXN0b3BPbkxhc3RDdWUSPAoIcHJpb3JpdHkYCCABKA4yIC5taXplci5zZXF1ZW5jZXIuRml4dHVyZVByaW9yaXR5Ughwcmlvcml0eQ==');
@$core.Deprecated('Use cueDescriptor instead')
const Cue$json = const {
  '1': 'Cue',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'trigger', '3': 3, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTrigger', '10': 'trigger'},
    const {'1': 'controls', '3': 4, '4': 3, '5': 11, '6': '.mizer.sequencer.CueControl', '10': 'controls'},
    const {'1': 'cue_timings', '3': 5, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimings', '10': 'cueTimings'},
    const {'1': 'dimmer_timings', '3': 6, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimings', '10': 'dimmerTimings'},
    const {'1': 'position_timings', '3': 7, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimings', '10': 'positionTimings'},
    const {'1': 'color_timings', '3': 8, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimings', '10': 'colorTimings'},
    const {'1': 'effects', '3': 9, '4': 3, '5': 11, '6': '.mizer.sequencer.CueEffect', '10': 'effects'},
    const {'1': 'ports', '3': 10, '4': 3, '5': 11, '6': '.mizer.sequencer.CuePort', '10': 'ports'},
  ],
};

/// Descriptor for `Cue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueDescriptor = $convert.base64Decode('CgNDdWUSDgoCaWQYASABKA1SAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSNQoHdHJpZ2dlchgDIAEoCzIbLm1pemVyLnNlcXVlbmNlci5DdWVUcmlnZ2VyUgd0cmlnZ2VyEjcKCGNvbnRyb2xzGAQgAygLMhsubWl6ZXIuc2VxdWVuY2VyLkN1ZUNvbnRyb2xSCGNvbnRyb2xzEjwKC2N1ZV90aW1pbmdzGAUgASgLMhsubWl6ZXIuc2VxdWVuY2VyLkN1ZVRpbWluZ3NSCmN1ZVRpbWluZ3MSQgoOZGltbWVyX3RpbWluZ3MYBiABKAsyGy5taXplci5zZXF1ZW5jZXIuQ3VlVGltaW5nc1INZGltbWVyVGltaW5ncxJGChBwb3NpdGlvbl90aW1pbmdzGAcgASgLMhsubWl6ZXIuc2VxdWVuY2VyLkN1ZVRpbWluZ3NSD3Bvc2l0aW9uVGltaW5ncxJACg1jb2xvcl90aW1pbmdzGAggASgLMhsubWl6ZXIuc2VxdWVuY2VyLkN1ZVRpbWluZ3NSDGNvbG9yVGltaW5ncxI0CgdlZmZlY3RzGAkgAygLMhoubWl6ZXIuc2VxdWVuY2VyLkN1ZUVmZmVjdFIHZWZmZWN0cxIuCgVwb3J0cxgKIAMoCzIYLm1pemVyLnNlcXVlbmNlci5DdWVQb3J0UgVwb3J0cw==');
@$core.Deprecated('Use cueEffectDescriptor instead')
const CueEffect$json = const {
  '1': 'CueEffect',
  '2': const [
    const {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    const {'1': 'fixtures', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
    const {'1': 'effect_offsets', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'effectOffsets', '17': true},
    const {'1': 'effect_rate', '3': 4, '4': 1, '5': 1, '9': 1, '10': 'effectRate', '17': true},
  ],
  '8': const [
    const {'1': '_effect_offsets'},
    const {'1': '_effect_rate'},
  ],
};

/// Descriptor for `CueEffect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueEffectDescriptor = $convert.base64Decode('CglDdWVFZmZlY3QSGwoJZWZmZWN0X2lkGAEgASgNUghlZmZlY3RJZBI1CghmaXh0dXJlcxgCIAMoCzIZLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVJZFIIZml4dHVyZXMSKgoOZWZmZWN0X29mZnNldHMYAyABKAFIAFINZWZmZWN0T2Zmc2V0c4gBARIkCgtlZmZlY3RfcmF0ZRgEIAEoAUgBUgplZmZlY3RSYXRliAEBQhEKD19lZmZlY3Rfb2Zmc2V0c0IOCgxfZWZmZWN0X3JhdGU=');
@$core.Deprecated('Use cuePortDescriptor instead')
const CuePort$json = const {
  '1': 'CuePort',
  '2': const [
    const {'1': 'port_id', '3': 1, '4': 1, '5': 13, '10': 'portId'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `CuePort`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cuePortDescriptor = $convert.base64Decode('CgdDdWVQb3J0EhcKB3BvcnRfaWQYASABKA1SBnBvcnRJZBIUCgV2YWx1ZRgCIAEoAVIFdmFsdWU=');
@$core.Deprecated('Use cueTimingsDescriptor instead')
const CueTimings$json = const {
  '1': 'CueTimings',
  '2': const [
    const {'1': 'fade', '3': 8, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimer', '10': 'fade'},
    const {'1': 'delay', '3': 9, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimer', '10': 'delay'},
  ],
};

/// Descriptor for `CueTimings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTimingsDescriptor = $convert.base64Decode('CgpDdWVUaW1pbmdzEi0KBGZhZGUYCCABKAsyGS5taXplci5zZXF1ZW5jZXIuQ3VlVGltZXJSBGZhZGUSLwoFZGVsYXkYCSABKAsyGS5taXplci5zZXF1ZW5jZXIuQ3VlVGltZXJSBWRlbGF5');
@$core.Deprecated('Use cueTriggerDescriptor instead')
const CueTrigger$json = const {
  '1': 'CueTrigger',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.sequencer.CueTrigger.Type', '10': 'type'},
    const {'1': 'time', '3': 2, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '9': 0, '10': 'time', '17': true},
  ],
  '4': const [CueTrigger_Type$json],
  '8': const [
    const {'1': '_time'},
  ],
};

@$core.Deprecated('Use cueTriggerDescriptor instead')
const CueTrigger_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'GO', '2': 0},
    const {'1': 'FOLLOW', '2': 1},
    const {'1': 'TIME', '2': 2},
    const {'1': 'BEATS', '2': 3},
    const {'1': 'TIMECODE', '2': 4},
  ],
};

/// Descriptor for `CueTrigger`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTriggerDescriptor = $convert.base64Decode('CgpDdWVUcmlnZ2VyEjQKBHR5cGUYASABKA4yIC5taXplci5zZXF1ZW5jZXIuQ3VlVHJpZ2dlci5UeXBlUgR0eXBlEjEKBHRpbWUYAiABKAsyGC5taXplci5zZXF1ZW5jZXIuQ3VlVGltZUgAUgR0aW1liAEBIj0KBFR5cGUSBgoCR08QABIKCgZGT0xMT1cQARIICgRUSU1FEAISCQoFQkVBVFMQAxIMCghUSU1FQ09ERRAEQgcKBV90aW1l');
@$core.Deprecated('Use cueControlDescriptor instead')
const CueControl$json = const {
  '1': 'CueControl',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.sequencer.CueControl.Type', '10': 'type'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.mizer.sequencer.CueValue', '10': 'value'},
    const {'1': 'fixtures', '3': 3, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
  ],
  '4': const [CueControl_Type$json],
};

@$core.Deprecated('Use cueControlDescriptor instead')
const CueControl_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'INTENSITY', '2': 0},
    const {'1': 'SHUTTER', '2': 1},
    const {'1': 'COLOR_RED', '2': 2},
    const {'1': 'COLOR_GREEN', '2': 3},
    const {'1': 'COLOR_BLUE', '2': 4},
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

/// Descriptor for `CueControl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueControlDescriptor = $convert.base64Decode('CgpDdWVDb250cm9sEjQKBHR5cGUYASABKA4yIC5taXplci5zZXF1ZW5jZXIuQ3VlQ29udHJvbC5UeXBlUgR0eXBlEi8KBXZhbHVlGAIgASgLMhkubWl6ZXIuc2VxdWVuY2VyLkN1ZVZhbHVlUgV2YWx1ZRI1CghmaXh0dXJlcxgDIAMoCzIZLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVJZFIIZml4dHVyZXMiwgEKBFR5cGUSDQoJSU5URU5TSVRZEAASCwoHU0hVVFRFUhABEg0KCUNPTE9SX1JFRBACEg8KC0NPTE9SX0dSRUVOEAMSDgoKQ09MT1JfQkxVRRAEEg8KC0NPTE9SX1dIRUVMEAUSBwoDUEFOEAYSCAoEVElMVBAHEgkKBUZPQ1VTEAgSCAoEWk9PTRAJEgkKBVBSSVNNEAoSCAoESVJJUxALEgkKBUZST1NUEAwSCAoER09CTxANEgsKB0dFTkVSSUMQDg==');
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
    const {'1': 'has_timer', '3': 1, '4': 1, '5': 8, '10': 'hasTimer'},
    const {'1': 'direct', '3': 2, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '9': 0, '10': 'direct'},
    const {'1': 'range', '3': 3, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimerRange', '9': 0, '10': 'range'},
  ],
  '8': const [
    const {'1': 'timer'},
  ],
};

/// Descriptor for `CueTimer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTimerDescriptor = $convert.base64Decode('CghDdWVUaW1lchIbCgloYXNfdGltZXIYASABKAhSCGhhc1RpbWVyEjIKBmRpcmVjdBgCIAEoCzIYLm1pemVyLnNlcXVlbmNlci5DdWVUaW1lSABSBmRpcmVjdBI2CgVyYW5nZRgDIAEoCzIeLm1pemVyLnNlcXVlbmNlci5DdWVUaW1lclJhbmdlSABSBXJhbmdlQgcKBXRpbWVy');
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
