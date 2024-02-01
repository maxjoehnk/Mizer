//
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use fixturePriorityDescriptor instead')
const FixturePriority$json = {
  '1': 'FixturePriority',
  '2': [
    {'1': 'PRIORITY_HTP', '2': 0},
    {'1': 'PRIORITY_LTP_HIGHEST', '2': 1},
    {'1': 'PRIORITY_LTP_HIGH', '2': 2},
    {'1': 'PRIORITY_LTP_NORMAL', '2': 3},
    {'1': 'PRIORITY_LTP_LOW', '2': 4},
    {'1': 'PRIORITY_LTP_LOWEST', '2': 5},
  ],
};

/// Descriptor for `FixturePriority`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fixturePriorityDescriptor = $convert.base64Decode(
    'Cg9GaXh0dXJlUHJpb3JpdHkSEAoMUFJJT1JJVFlfSFRQEAASGAoUUFJJT1JJVFlfTFRQX0hJR0'
    'hFU1QQARIVChFQUklPUklUWV9MVFBfSElHSBACEhcKE1BSSU9SSVRZX0xUUF9OT1JNQUwQAxIU'
    'ChBQUklPUklUWV9MVFBfTE9XEAQSFwoTUFJJT1JJVFlfTFRQX0xPV0VTVBAF');

@$core.Deprecated('Use getSequenceRequestDescriptor instead')
const GetSequenceRequest$json = {
  '1': 'GetSequenceRequest',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
  ],
};

/// Descriptor for `GetSequenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSequenceRequestDescriptor = $convert.base64Decode(
    'ChJHZXRTZXF1ZW5jZVJlcXVlc3QSGgoIc2VxdWVuY2UYASABKA1SCHNlcXVlbmNl');

@$core.Deprecated('Use deleteSequenceRequestDescriptor instead')
const DeleteSequenceRequest$json = {
  '1': 'DeleteSequenceRequest',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
  ],
};

/// Descriptor for `DeleteSequenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteSequenceRequestDescriptor = $convert.base64Decode(
    'ChVEZWxldGVTZXF1ZW5jZVJlcXVlc3QSGgoIc2VxdWVuY2UYASABKA1SCHNlcXVlbmNl');

@$core.Deprecated('Use sequenceGoRequestDescriptor instead')
const SequenceGoRequest$json = {
  '1': 'SequenceGoRequest',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
  ],
};

/// Descriptor for `SequenceGoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceGoRequestDescriptor = $convert.base64Decode(
    'ChFTZXF1ZW5jZUdvUmVxdWVzdBIaCghzZXF1ZW5jZRgBIAEoDVIIc2VxdWVuY2U=');

@$core.Deprecated('Use sequenceStopRequestDescriptor instead')
const SequenceStopRequest$json = {
  '1': 'SequenceStopRequest',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
  ],
};

/// Descriptor for `SequenceStopRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceStopRequestDescriptor = $convert.base64Decode(
    'ChNTZXF1ZW5jZVN0b3BSZXF1ZXN0EhoKCHNlcXVlbmNlGAEgASgNUghzZXF1ZW5jZQ==');

@$core.Deprecated('Use cueTriggerRequestDescriptor instead')
const CueTriggerRequest$json = {
  '1': 'CueTriggerRequest',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    {'1': 'cue', '3': 2, '4': 1, '5': 13, '10': 'cue'},
    {'1': 'trigger', '3': 3, '4': 1, '5': 14, '6': '.mizer.sequencer.CueTrigger.Type', '10': 'trigger'},
  ],
};

/// Descriptor for `CueTriggerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTriggerRequestDescriptor = $convert.base64Decode(
    'ChFDdWVUcmlnZ2VyUmVxdWVzdBIaCghzZXF1ZW5jZRgBIAEoDVIIc2VxdWVuY2USEAoDY3VlGA'
    'IgASgNUgNjdWUSOgoHdHJpZ2dlchgDIAEoDjIgLm1pemVyLnNlcXVlbmNlci5DdWVUcmlnZ2Vy'
    'LlR5cGVSB3RyaWdnZXI=');

@$core.Deprecated('Use cueTriggerTimeRequestDescriptor instead')
const CueTriggerTimeRequest$json = {
  '1': 'CueTriggerTimeRequest',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    {'1': 'cue', '3': 2, '4': 1, '5': 13, '10': 'cue'},
    {'1': 'time', '3': 3, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '10': 'time'},
  ],
};

/// Descriptor for `CueTriggerTimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTriggerTimeRequestDescriptor = $convert.base64Decode(
    'ChVDdWVUcmlnZ2VyVGltZVJlcXVlc3QSGgoIc2VxdWVuY2UYASABKA1SCHNlcXVlbmNlEhAKA2'
    'N1ZRgCIAEoDVIDY3VlEiwKBHRpbWUYAyABKAsyGC5taXplci5zZXF1ZW5jZXIuQ3VlVGltZVIE'
    'dGltZQ==');

@$core.Deprecated('Use cueEffectOffsetTimeRequestDescriptor instead')
const CueEffectOffsetTimeRequest$json = {
  '1': 'CueEffectOffsetTimeRequest',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    {'1': 'cue', '3': 2, '4': 1, '5': 13, '10': 'cue'},
    {'1': 'effect', '3': 3, '4': 1, '5': 13, '10': 'effect'},
    {'1': 'time', '3': 4, '4': 1, '5': 1, '9': 0, '10': 'time', '17': true},
  ],
  '8': [
    {'1': '_time'},
  ],
};

/// Descriptor for `CueEffectOffsetTimeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueEffectOffsetTimeRequestDescriptor = $convert.base64Decode(
    'ChpDdWVFZmZlY3RPZmZzZXRUaW1lUmVxdWVzdBIaCghzZXF1ZW5jZRgBIAEoDVIIc2VxdWVuY2'
    'USEAoDY3VlGAIgASgNUgNjdWUSFgoGZWZmZWN0GAMgASgNUgZlZmZlY3QSFwoEdGltZRgEIAEo'
    'AUgAUgR0aW1liAEBQgcKBV90aW1l');

@$core.Deprecated('Use cueNameRequestDescriptor instead')
const CueNameRequest$json = {
  '1': 'CueNameRequest',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    {'1': 'cue', '3': 2, '4': 1, '5': 13, '10': 'cue'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `CueNameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueNameRequestDescriptor = $convert.base64Decode(
    'Cg5DdWVOYW1lUmVxdWVzdBIaCghzZXF1ZW5jZRgBIAEoDVIIc2VxdWVuY2USEAoDY3VlGAIgAS'
    'gNUgNjdWUSEgoEbmFtZRgDIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use cueValueRequestDescriptor instead')
const CueValueRequest$json = {
  '1': 'CueValueRequest',
  '2': [
    {'1': 'sequence_id', '3': 1, '4': 1, '5': 13, '10': 'sequenceId'},
    {'1': 'cue_id', '3': 2, '4': 1, '5': 13, '10': 'cueId'},
    {'1': 'control_index', '3': 3, '4': 1, '5': 13, '10': 'controlIndex'},
    {'1': 'value', '3': 4, '4': 1, '5': 11, '6': '.mizer.sequencer.CueValue', '10': 'value'},
  ],
};

/// Descriptor for `CueValueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueValueRequestDescriptor = $convert.base64Decode(
    'Cg9DdWVWYWx1ZVJlcXVlc3QSHwoLc2VxdWVuY2VfaWQYASABKA1SCnNlcXVlbmNlSWQSFQoGY3'
    'VlX2lkGAIgASgNUgVjdWVJZBIjCg1jb250cm9sX2luZGV4GAMgASgNUgxjb250cm9sSW5kZXgS'
    'LwoFdmFsdWUYBCABKAsyGS5taXplci5zZXF1ZW5jZXIuQ3VlVmFsdWVSBXZhbHVl');

@$core.Deprecated('Use cueTimingRequestDescriptor instead')
const CueTimingRequest$json = {
  '1': 'CueTimingRequest',
  '2': [
    {'1': 'sequence_id', '3': 1, '4': 1, '5': 13, '10': 'sequenceId'},
    {'1': 'cue_id', '3': 2, '4': 1, '5': 13, '10': 'cueId'},
    {'1': 'time', '3': 3, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimer', '10': 'time'},
  ],
};

/// Descriptor for `CueTimingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTimingRequestDescriptor = $convert.base64Decode(
    'ChBDdWVUaW1pbmdSZXF1ZXN0Eh8KC3NlcXVlbmNlX2lkGAEgASgNUgpzZXF1ZW5jZUlkEhUKBm'
    'N1ZV9pZBgCIAEoDVIFY3VlSWQSLQoEdGltZRgDIAEoCzIZLm1pemVyLnNlcXVlbmNlci5DdWVU'
    'aW1lclIEdGltZQ==');

@$core.Deprecated('Use sequenceWrapAroundRequestDescriptor instead')
const SequenceWrapAroundRequest$json = {
  '1': 'SequenceWrapAroundRequest',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    {'1': 'wrap_around', '3': 2, '4': 1, '5': 8, '10': 'wrapAround'},
  ],
};

/// Descriptor for `SequenceWrapAroundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceWrapAroundRequestDescriptor = $convert.base64Decode(
    'ChlTZXF1ZW5jZVdyYXBBcm91bmRSZXF1ZXN0EhoKCHNlcXVlbmNlGAEgASgNUghzZXF1ZW5jZR'
    'IfCgt3cmFwX2Fyb3VuZBgCIAEoCFIKd3JhcEFyb3VuZA==');

@$core.Deprecated('Use sequenceStopOnLastCueRequestDescriptor instead')
const SequenceStopOnLastCueRequest$json = {
  '1': 'SequenceStopOnLastCueRequest',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    {'1': 'stop_on_last_cue', '3': 2, '4': 1, '5': 8, '10': 'stopOnLastCue'},
  ],
};

/// Descriptor for `SequenceStopOnLastCueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceStopOnLastCueRequestDescriptor = $convert.base64Decode(
    'ChxTZXF1ZW5jZVN0b3BPbkxhc3RDdWVSZXF1ZXN0EhoKCHNlcXVlbmNlGAEgASgNUghzZXF1ZW'
    '5jZRInChBzdG9wX29uX2xhc3RfY3VlGAIgASgIUg1zdG9wT25MYXN0Q3Vl');

@$core.Deprecated('Use sequencePriorityRequestDescriptor instead')
const SequencePriorityRequest$json = {
  '1': 'SequencePriorityRequest',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    {'1': 'priority', '3': 2, '4': 1, '5': 14, '6': '.mizer.sequencer.FixturePriority', '10': 'priority'},
  ],
};

/// Descriptor for `SequencePriorityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequencePriorityRequestDescriptor = $convert.base64Decode(
    'ChdTZXF1ZW5jZVByaW9yaXR5UmVxdWVzdBIaCghzZXF1ZW5jZRgBIAEoDVIIc2VxdWVuY2USPA'
    'oIcHJpb3JpdHkYAiABKA4yIC5taXplci5zZXF1ZW5jZXIuRml4dHVyZVByaW9yaXR5Ughwcmlv'
    'cml0eQ==');

@$core.Deprecated('Use sequenceNameRequestDescriptor instead')
const SequenceNameRequest$json = {
  '1': 'SequenceNameRequest',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `SequenceNameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceNameRequestDescriptor = $convert.base64Decode(
    'ChNTZXF1ZW5jZU5hbWVSZXF1ZXN0EhoKCHNlcXVlbmNlGAEgASgNUghzZXF1ZW5jZRISCgRuYW'
    '1lGAIgASgJUgRuYW1l');

@$core.Deprecated('Use sequencesDescriptor instead')
const Sequences$json = {
  '1': 'Sequences',
  '2': [
    {'1': 'sequences', '3': 1, '4': 3, '5': 11, '6': '.mizer.sequencer.Sequence', '10': 'sequences'},
  ],
};

/// Descriptor for `Sequences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequencesDescriptor = $convert.base64Decode(
    'CglTZXF1ZW5jZXMSNwoJc2VxdWVuY2VzGAEgAygLMhkubWl6ZXIuc2VxdWVuY2VyLlNlcXVlbm'
    'NlUglzZXF1ZW5jZXM=');

@$core.Deprecated('Use sequenceDescriptor instead')
const Sequence$json = {
  '1': 'Sequence',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'cues', '3': 3, '4': 3, '5': 11, '6': '.mizer.sequencer.Cue', '10': 'cues'},
    {'1': 'fixtures', '3': 4, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
    {'1': 'wrap_around', '3': 5, '4': 1, '5': 8, '10': 'wrapAround'},
    {'1': 'stop_on_last_cue', '3': 6, '4': 1, '5': 8, '10': 'stopOnLastCue'},
    {'1': 'priority', '3': 7, '4': 1, '5': 14, '6': '.mizer.sequencer.FixturePriority', '10': 'priority'},
  ],
};

/// Descriptor for `Sequence`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceDescriptor = $convert.base64Decode(
    'CghTZXF1ZW5jZRIOCgJpZBgBIAEoDVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIoCgRjdWVzGA'
    'MgAygLMhQubWl6ZXIuc2VxdWVuY2VyLkN1ZVIEY3VlcxI1CghmaXh0dXJlcxgEIAMoCzIZLm1p'
    'emVyLmZpeHR1cmVzLkZpeHR1cmVJZFIIZml4dHVyZXMSHwoLd3JhcF9hcm91bmQYBSABKAhSCn'
    'dyYXBBcm91bmQSJwoQc3RvcF9vbl9sYXN0X2N1ZRgGIAEoCFINc3RvcE9uTGFzdEN1ZRI8Cghw'
    'cmlvcml0eRgHIAEoDjIgLm1pemVyLnNlcXVlbmNlci5GaXh0dXJlUHJpb3JpdHlSCHByaW9yaX'
    'R5');

@$core.Deprecated('Use cueDescriptor instead')
const Cue$json = {
  '1': 'Cue',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'trigger', '3': 3, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTrigger', '10': 'trigger'},
    {'1': 'controls', '3': 4, '4': 3, '5': 11, '6': '.mizer.sequencer.CueControl', '10': 'controls'},
    {'1': 'cue_timings', '3': 5, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimings', '10': 'cueTimings'},
    {'1': 'dimmer_timings', '3': 6, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimings', '10': 'dimmerTimings'},
    {'1': 'position_timings', '3': 7, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimings', '10': 'positionTimings'},
    {'1': 'color_timings', '3': 8, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimings', '10': 'colorTimings'},
    {'1': 'effects', '3': 9, '4': 3, '5': 11, '6': '.mizer.sequencer.CueEffect', '10': 'effects'},
  ],
};

/// Descriptor for `Cue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueDescriptor = $convert.base64Decode(
    'CgNDdWUSDgoCaWQYASABKA1SAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSNQoHdHJpZ2dlchgDIA'
    'EoCzIbLm1pemVyLnNlcXVlbmNlci5DdWVUcmlnZ2VyUgd0cmlnZ2VyEjcKCGNvbnRyb2xzGAQg'
    'AygLMhsubWl6ZXIuc2VxdWVuY2VyLkN1ZUNvbnRyb2xSCGNvbnRyb2xzEjwKC2N1ZV90aW1pbm'
    'dzGAUgASgLMhsubWl6ZXIuc2VxdWVuY2VyLkN1ZVRpbWluZ3NSCmN1ZVRpbWluZ3MSQgoOZGlt'
    'bWVyX3RpbWluZ3MYBiABKAsyGy5taXplci5zZXF1ZW5jZXIuQ3VlVGltaW5nc1INZGltbWVyVG'
    'ltaW5ncxJGChBwb3NpdGlvbl90aW1pbmdzGAcgASgLMhsubWl6ZXIuc2VxdWVuY2VyLkN1ZVRp'
    'bWluZ3NSD3Bvc2l0aW9uVGltaW5ncxJACg1jb2xvcl90aW1pbmdzGAggASgLMhsubWl6ZXIuc2'
    'VxdWVuY2VyLkN1ZVRpbWluZ3NSDGNvbG9yVGltaW5ncxI0CgdlZmZlY3RzGAkgAygLMhoubWl6'
    'ZXIuc2VxdWVuY2VyLkN1ZUVmZmVjdFIHZWZmZWN0cw==');

@$core.Deprecated('Use cueEffectDescriptor instead')
const CueEffect$json = {
  '1': 'CueEffect',
  '2': [
    {'1': 'effect_id', '3': 1, '4': 1, '5': 13, '10': 'effectId'},
    {'1': 'fixtures', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
    {'1': 'effect_offsets', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'effectOffsets', '17': true},
    {'1': 'effect_rate', '3': 4, '4': 1, '5': 1, '9': 1, '10': 'effectRate', '17': true},
  ],
  '8': [
    {'1': '_effect_offsets'},
    {'1': '_effect_rate'},
  ],
};

/// Descriptor for `CueEffect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueEffectDescriptor = $convert.base64Decode(
    'CglDdWVFZmZlY3QSGwoJZWZmZWN0X2lkGAEgASgNUghlZmZlY3RJZBI1CghmaXh0dXJlcxgCIA'
    'MoCzIZLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVJZFIIZml4dHVyZXMSKgoOZWZmZWN0X29mZnNl'
    'dHMYAyABKAFIAFINZWZmZWN0T2Zmc2V0c4gBARIkCgtlZmZlY3RfcmF0ZRgEIAEoAUgBUgplZm'
    'ZlY3RSYXRliAEBQhEKD19lZmZlY3Rfb2Zmc2V0c0IOCgxfZWZmZWN0X3JhdGU=');

@$core.Deprecated('Use cueTimingsDescriptor instead')
const CueTimings$json = {
  '1': 'CueTimings',
  '2': [
    {'1': 'fade', '3': 8, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimer', '10': 'fade'},
    {'1': 'delay', '3': 9, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimer', '10': 'delay'},
  ],
};

/// Descriptor for `CueTimings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTimingsDescriptor = $convert.base64Decode(
    'CgpDdWVUaW1pbmdzEi0KBGZhZGUYCCABKAsyGS5taXplci5zZXF1ZW5jZXIuQ3VlVGltZXJSBG'
    'ZhZGUSLwoFZGVsYXkYCSABKAsyGS5taXplci5zZXF1ZW5jZXIuQ3VlVGltZXJSBWRlbGF5');

@$core.Deprecated('Use cueTriggerDescriptor instead')
const CueTrigger$json = {
  '1': 'CueTrigger',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.sequencer.CueTrigger.Type', '10': 'type'},
    {'1': 'time', '3': 2, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '9': 0, '10': 'time', '17': true},
  ],
  '4': [CueTrigger_Type$json],
  '8': [
    {'1': '_time'},
  ],
};

@$core.Deprecated('Use cueTriggerDescriptor instead')
const CueTrigger_Type$json = {
  '1': 'Type',
  '2': [
    {'1': 'GO', '2': 0},
    {'1': 'FOLLOW', '2': 1},
    {'1': 'TIME', '2': 2},
    {'1': 'BEATS', '2': 3},
    {'1': 'TIMECODE', '2': 4},
  ],
};

/// Descriptor for `CueTrigger`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTriggerDescriptor = $convert.base64Decode(
    'CgpDdWVUcmlnZ2VyEjQKBHR5cGUYASABKA4yIC5taXplci5zZXF1ZW5jZXIuQ3VlVHJpZ2dlci'
    '5UeXBlUgR0eXBlEjEKBHRpbWUYAiABKAsyGC5taXplci5zZXF1ZW5jZXIuQ3VlVGltZUgAUgR0'
    'aW1liAEBIj0KBFR5cGUSBgoCR08QABIKCgZGT0xMT1cQARIICgRUSU1FEAISCQoFQkVBVFMQAx'
    'IMCghUSU1FQ09ERRAEQgcKBV90aW1l');

@$core.Deprecated('Use cueControlDescriptor instead')
const CueControl$json = {
  '1': 'CueControl',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.sequencer.CueControl.Type', '10': 'type'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.mizer.sequencer.CueValue', '10': 'value'},
    {'1': 'fixtures', '3': 3, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureId', '10': 'fixtures'},
  ],
  '4': [CueControl_Type$json],
};

@$core.Deprecated('Use cueControlDescriptor instead')
const CueControl_Type$json = {
  '1': 'Type',
  '2': [
    {'1': 'INTENSITY', '2': 0},
    {'1': 'SHUTTER', '2': 1},
    {'1': 'COLOR_RED', '2': 2},
    {'1': 'COLOR_GREEN', '2': 3},
    {'1': 'COLOR_BLUE', '2': 4},
    {'1': 'COLOR_WHEEL', '2': 5},
    {'1': 'PAN', '2': 6},
    {'1': 'TILT', '2': 7},
    {'1': 'FOCUS', '2': 8},
    {'1': 'ZOOM', '2': 9},
    {'1': 'PRISM', '2': 10},
    {'1': 'IRIS', '2': 11},
    {'1': 'FROST', '2': 12},
    {'1': 'GOBO', '2': 13},
    {'1': 'GENERIC', '2': 14},
  ],
};

/// Descriptor for `CueControl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueControlDescriptor = $convert.base64Decode(
    'CgpDdWVDb250cm9sEjQKBHR5cGUYASABKA4yIC5taXplci5zZXF1ZW5jZXIuQ3VlQ29udHJvbC'
    '5UeXBlUgR0eXBlEi8KBXZhbHVlGAIgASgLMhkubWl6ZXIuc2VxdWVuY2VyLkN1ZVZhbHVlUgV2'
    'YWx1ZRI1CghmaXh0dXJlcxgDIAMoCzIZLm1pemVyLmZpeHR1cmVzLkZpeHR1cmVJZFIIZml4dH'
    'VyZXMiwgEKBFR5cGUSDQoJSU5URU5TSVRZEAASCwoHU0hVVFRFUhABEg0KCUNPTE9SX1JFRBAC'
    'Eg8KC0NPTE9SX0dSRUVOEAMSDgoKQ09MT1JfQkxVRRAEEg8KC0NPTE9SX1dIRUVMEAUSBwoDUE'
    'FOEAYSCAoEVElMVBAHEgkKBUZPQ1VTEAgSCAoEWk9PTRAJEgkKBVBSSVNNEAoSCAoESVJJUxAL'
    'EgkKBUZST1NUEAwSCAoER09CTxANEgsKB0dFTkVSSUMQDg==');

@$core.Deprecated('Use cueValueDescriptor instead')
const CueValue$json = {
  '1': 'CueValue',
  '2': [
    {'1': 'direct', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'direct'},
    {'1': 'range', '3': 4, '4': 1, '5': 11, '6': '.mizer.sequencer.CueValueRange', '9': 0, '10': 'range'},
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `CueValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueValueDescriptor = $convert.base64Decode(
    'CghDdWVWYWx1ZRIYCgZkaXJlY3QYAyABKAFIAFIGZGlyZWN0EjYKBXJhbmdlGAQgASgLMh4ubW'
    'l6ZXIuc2VxdWVuY2VyLkN1ZVZhbHVlUmFuZ2VIAFIFcmFuZ2VCBwoFdmFsdWU=');

@$core.Deprecated('Use cueTimerDescriptor instead')
const CueTimer$json = {
  '1': 'CueTimer',
  '2': [
    {'1': 'has_timer', '3': 1, '4': 1, '5': 8, '10': 'hasTimer'},
    {'1': 'direct', '3': 2, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '9': 0, '10': 'direct'},
    {'1': 'range', '3': 3, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimerRange', '9': 0, '10': 'range'},
  ],
  '8': [
    {'1': 'timer'},
  ],
};

/// Descriptor for `CueTimer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTimerDescriptor = $convert.base64Decode(
    'CghDdWVUaW1lchIbCgloYXNfdGltZXIYASABKAhSCGhhc1RpbWVyEjIKBmRpcmVjdBgCIAEoCz'
    'IYLm1pemVyLnNlcXVlbmNlci5DdWVUaW1lSABSBmRpcmVjdBI2CgVyYW5nZRgDIAEoCzIeLm1p'
    'emVyLnNlcXVlbmNlci5DdWVUaW1lclJhbmdlSABSBXJhbmdlQgcKBXRpbWVy');

@$core.Deprecated('Use cueValueRangeDescriptor instead')
const CueValueRange$json = {
  '1': 'CueValueRange',
  '2': [
    {'1': 'from', '3': 1, '4': 1, '5': 1, '10': 'from'},
    {'1': 'to', '3': 2, '4': 1, '5': 1, '10': 'to'},
  ],
};

/// Descriptor for `CueValueRange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueValueRangeDescriptor = $convert.base64Decode(
    'Cg1DdWVWYWx1ZVJhbmdlEhIKBGZyb20YASABKAFSBGZyb20SDgoCdG8YAiABKAFSAnRv');

@$core.Deprecated('Use cueTimeDescriptor instead')
const CueTime$json = {
  '1': 'CueTime',
  '2': [
    {'1': 'seconds', '3': 1, '4': 1, '5': 1, '9': 0, '10': 'seconds'},
    {'1': 'beats', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'beats'},
  ],
  '8': [
    {'1': 'time'},
  ],
};

/// Descriptor for `CueTime`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTimeDescriptor = $convert.base64Decode(
    'CgdDdWVUaW1lEhoKB3NlY29uZHMYASABKAFIAFIHc2Vjb25kcxIWCgViZWF0cxgCIAEoAUgAUg'
    'ViZWF0c0IGCgR0aW1l');

@$core.Deprecated('Use cueTimerRangeDescriptor instead')
const CueTimerRange$json = {
  '1': 'CueTimerRange',
  '2': [
    {'1': 'from', '3': 1, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '10': 'from'},
    {'1': 'to', '3': 2, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '10': 'to'},
  ],
};

/// Descriptor for `CueTimerRange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cueTimerRangeDescriptor = $convert.base64Decode(
    'Cg1DdWVUaW1lclJhbmdlEiwKBGZyb20YASABKAsyGC5taXplci5zZXF1ZW5jZXIuQ3VlVGltZV'
    'IEZnJvbRIoCgJ0bxgCIAEoCzIYLm1pemVyLnNlcXVlbmNlci5DdWVUaW1lUgJ0bw==');

