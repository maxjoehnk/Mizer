//
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use nodeCategoryDescriptor instead')
const NodeCategory$json = {
  '1': 'NodeCategory',
  '2': [
    {'1': 'NODE_CATEGORY_NONE', '2': 0},
    {'1': 'NODE_CATEGORY_STANDARD', '2': 1},
    {'1': 'NODE_CATEGORY_CONNECTIONS', '2': 2},
    {'1': 'NODE_CATEGORY_CONVERSIONS', '2': 3},
    {'1': 'NODE_CATEGORY_CONTROLS', '2': 4},
    {'1': 'NODE_CATEGORY_DATA', '2': 5},
    {'1': 'NODE_CATEGORY_COLOR', '2': 6},
    {'1': 'NODE_CATEGORY_AUDIO', '2': 7},
    {'1': 'NODE_CATEGORY_VIDEO', '2': 8},
    {'1': 'NODE_CATEGORY_LASER', '2': 9},
    {'1': 'NODE_CATEGORY_PIXEL', '2': 10},
  ],
};

/// Descriptor for `NodeCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List nodeCategoryDescriptor = $convert.base64Decode(
    'CgxOb2RlQ2F0ZWdvcnkSFgoSTk9ERV9DQVRFR09SWV9OT05FEAASGgoWTk9ERV9DQVRFR09SWV'
    '9TVEFOREFSRBABEh0KGU5PREVfQ0FURUdPUllfQ09OTkVDVElPTlMQAhIdChlOT0RFX0NBVEVH'
    'T1JZX0NPTlZFUlNJT05TEAMSGgoWTk9ERV9DQVRFR09SWV9DT05UUk9MUxAEEhYKEk5PREVfQ0'
    'FURUdPUllfREFUQRAFEhcKE05PREVfQ0FURUdPUllfQ09MT1IQBhIXChNOT0RFX0NBVEVHT1JZ'
    'X0FVRElPEAcSFwoTTk9ERV9DQVRFR09SWV9WSURFTxAIEhcKE05PREVfQ0FURUdPUllfTEFTRV'
    'IQCRIXChNOT0RFX0NBVEVHT1JZX1BJWEVMEAo=');

@$core.Deprecated('Use channelProtocolDescriptor instead')
const ChannelProtocol$json = {
  '1': 'ChannelProtocol',
  '2': [
    {'1': 'SINGLE', '2': 0},
    {'1': 'MULTI', '2': 1},
    {'1': 'TEXTURE', '2': 2},
    {'1': 'VECTOR', '2': 3},
    {'1': 'LASER', '2': 4},
    {'1': 'POLY', '2': 5},
    {'1': 'DATA', '2': 6},
    {'1': 'MATERIAL', '2': 7},
    {'1': 'COLOR', '2': 9},
    {'1': 'CLOCK', '2': 10},
  ],
};

/// Descriptor for `ChannelProtocol`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelProtocolDescriptor = $convert.base64Decode(
    'Cg9DaGFubmVsUHJvdG9jb2wSCgoGU0lOR0xFEAASCQoFTVVMVEkQARILCgdURVhUVVJFEAISCg'
    'oGVkVDVE9SEAMSCQoFTEFTRVIQBBIICgRQT0xZEAUSCAoEREFUQRAGEgwKCE1BVEVSSUFMEAcS'
    'CQoFQ09MT1IQCRIJCgVDTE9DSxAK');

@$core.Deprecated('Use addNodeRequestDescriptor instead')
const AddNodeRequest$json = {
  '1': 'AddNodeRequest',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.nodes.Node.NodeType', '10': 'type'},
    {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.NodePosition', '10': 'position'},
    {'1': 'parent', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
  ],
  '8': [
    {'1': '_parent'},
  ],
};

/// Descriptor for `AddNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addNodeRequestDescriptor = $convert.base64Decode(
    'Cg5BZGROb2RlUmVxdWVzdBIuCgR0eXBlGAEgASgOMhoubWl6ZXIubm9kZXMuTm9kZS5Ob2RlVH'
    'lwZVIEdHlwZRI1Cghwb3NpdGlvbhgCIAEoCzIZLm1pemVyLm5vZGVzLk5vZGVQb3NpdGlvblII'
    'cG9zaXRpb24SGwoGcGFyZW50GAMgASgJSABSBnBhcmVudIgBAUIJCgdfcGFyZW50');

@$core.Deprecated('Use duplicateNodeRequestDescriptor instead')
const DuplicateNodeRequest$json = {
  '1': 'DuplicateNodeRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'parent', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
  ],
  '8': [
    {'1': '_parent'},
  ],
};

/// Descriptor for `DuplicateNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List duplicateNodeRequestDescriptor = $convert.base64Decode(
    'ChREdXBsaWNhdGVOb2RlUmVxdWVzdBISCgRwYXRoGAEgASgJUgRwYXRoEhsKBnBhcmVudBgCIA'
    'EoCUgAUgZwYXJlbnSIAQFCCQoHX3BhcmVudA==');

@$core.Deprecated('Use writeControlDescriptor instead')
const WriteControl$json = {
  '1': 'WriteControl',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'port', '3': 2, '4': 1, '5': 9, '10': 'port'},
    {'1': 'value', '3': 3, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `WriteControl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeControlDescriptor = $convert.base64Decode(
    'CgxXcml0ZUNvbnRyb2wSEgoEcGF0aBgBIAEoCVIEcGF0aBISCgRwb3J0GAIgASgJUgRwb3J0Eh'
    'QKBXZhbHVlGAMgASgBUgV2YWx1ZQ==');

@$core.Deprecated('Use updateNodeSettingRequestDescriptor instead')
const UpdateNodeSettingRequest$json = {
  '1': 'UpdateNodeSettingRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'setting', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting', '10': 'setting'},
  ],
};

/// Descriptor for `UpdateNodeSettingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNodeSettingRequestDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVOb2RlU2V0dGluZ1JlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aBIyCgdzZXR0aW'
    '5nGAIgASgLMhgubWl6ZXIubm9kZXMuTm9kZVNldHRpbmdSB3NldHRpbmc=');

@$core.Deprecated('Use moveNodeRequestDescriptor instead')
const MoveNodeRequest$json = {
  '1': 'MoveNodeRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.NodePosition', '10': 'position'},
  ],
};

/// Descriptor for `MoveNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveNodeRequestDescriptor = $convert.base64Decode(
    'Cg9Nb3ZlTm9kZVJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aBI1Cghwb3NpdGlvbhgCIAEoCz'
    'IZLm1pemVyLm5vZGVzLk5vZGVQb3NpdGlvblIIcG9zaXRpb24=');

@$core.Deprecated('Use showNodeRequestDescriptor instead')
const ShowNodeRequest$json = {
  '1': 'ShowNodeRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.NodePosition', '10': 'position'},
    {'1': 'parent', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
  ],
  '8': [
    {'1': '_parent'},
  ],
};

/// Descriptor for `ShowNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List showNodeRequestDescriptor = $convert.base64Decode(
    'Cg9TaG93Tm9kZVJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aBI1Cghwb3NpdGlvbhgCIAEoCz'
    'IZLm1pemVyLm5vZGVzLk5vZGVQb3NpdGlvblIIcG9zaXRpb24SGwoGcGFyZW50GAMgASgJSABS'
    'BnBhcmVudIgBAUIJCgdfcGFyZW50');

@$core.Deprecated('Use renameNodeRequestDescriptor instead')
const RenameNodeRequest$json = {
  '1': 'RenameNodeRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'new_name', '3': 2, '4': 1, '5': 9, '10': 'newName'},
  ],
};

/// Descriptor for `RenameNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renameNodeRequestDescriptor = $convert.base64Decode(
    'ChFSZW5hbWVOb2RlUmVxdWVzdBISCgRwYXRoGAEgASgJUgRwYXRoEhkKCG5ld19uYW1lGAIgAS'
    'gJUgduZXdOYW1l');

@$core.Deprecated('Use groupNodesRequestDescriptor instead')
const GroupNodesRequest$json = {
  '1': 'GroupNodesRequest',
  '2': [
    {'1': 'nodes', '3': 1, '4': 3, '5': 9, '10': 'nodes'},
    {'1': 'parent', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
  ],
  '8': [
    {'1': '_parent'},
  ],
};

/// Descriptor for `GroupNodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupNodesRequestDescriptor = $convert.base64Decode(
    'ChFHcm91cE5vZGVzUmVxdWVzdBIUCgVub2RlcxgBIAMoCVIFbm9kZXMSGwoGcGFyZW50GAIgAS'
    'gJSABSBnBhcmVudIgBAUIJCgdfcGFyZW50');

@$core.Deprecated('Use deleteNodeRequestDescriptor instead')
const DeleteNodeRequest$json = {
  '1': 'DeleteNodeRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `DeleteNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteNodeRequestDescriptor = $convert.base64Decode(
    'ChFEZWxldGVOb2RlUmVxdWVzdBISCgRwYXRoGAEgASgJUgRwYXRo');

@$core.Deprecated('Use hideNodeRequestDescriptor instead')
const HideNodeRequest$json = {
  '1': 'HideNodeRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `HideNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hideNodeRequestDescriptor = $convert.base64Decode(
    'Cg9IaWRlTm9kZVJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aA==');

@$core.Deprecated('Use nodesDescriptor instead')
const Nodes$json = {
  '1': 'Nodes',
  '2': [
    {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.Node', '10': 'nodes'},
    {'1': 'channels', '3': 2, '4': 3, '5': 11, '6': '.mizer.nodes.NodeConnection', '10': 'channels'},
    {'1': 'all_nodes', '3': 3, '4': 3, '5': 11, '6': '.mizer.nodes.Node', '10': 'allNodes'},
  ],
};

/// Descriptor for `Nodes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodesDescriptor = $convert.base64Decode(
    'CgVOb2RlcxInCgVub2RlcxgBIAMoCzIRLm1pemVyLm5vZGVzLk5vZGVSBW5vZGVzEjcKCGNoYW'
    '5uZWxzGAIgAygLMhsubWl6ZXIubm9kZXMuTm9kZUNvbm5lY3Rpb25SCGNoYW5uZWxzEi4KCWFs'
    'bF9ub2RlcxgDIAMoCzIRLm1pemVyLm5vZGVzLk5vZGVSCGFsbE5vZGVz');

@$core.Deprecated('Use availableNodesDescriptor instead')
const AvailableNodes$json = {
  '1': 'AvailableNodes',
  '2': [
    {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.AvailableNode', '10': 'nodes'},
  ],
};

/// Descriptor for `AvailableNodes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List availableNodesDescriptor = $convert.base64Decode(
    'Cg5BdmFpbGFibGVOb2RlcxIwCgVub2RlcxgBIAMoCzIaLm1pemVyLm5vZGVzLkF2YWlsYWJsZU'
    '5vZGVSBW5vZGVz');

@$core.Deprecated('Use availableNodeDescriptor instead')
const AvailableNode$json = {
  '1': 'AvailableNode',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.nodes.Node.NodeType', '10': 'type'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'category', '3': 3, '4': 1, '5': 14, '6': '.mizer.nodes.NodeCategory', '10': 'category'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'description', '17': true},
  ],
  '8': [
    {'1': '_description'},
  ],
};

/// Descriptor for `AvailableNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List availableNodeDescriptor = $convert.base64Decode(
    'Cg1BdmFpbGFibGVOb2RlEi4KBHR5cGUYASABKA4yGi5taXplci5ub2Rlcy5Ob2RlLk5vZGVUeX'
    'BlUgR0eXBlEhIKBG5hbWUYAiABKAlSBG5hbWUSNQoIY2F0ZWdvcnkYAyABKA4yGS5taXplci5u'
    'b2Rlcy5Ob2RlQ2F0ZWdvcnlSCGNhdGVnb3J5EiUKC2Rlc2NyaXB0aW9uGAQgASgJSABSC2Rlc2'
    'NyaXB0aW9uiAEBQg4KDF9kZXNjcmlwdGlvbg==');

@$core.Deprecated('Use nodeConnectionDescriptor instead')
const NodeConnection$json = {
  '1': 'NodeConnection',
  '2': [
    {'1': 'target_node', '3': 1, '4': 1, '5': 9, '10': 'targetNode'},
    {'1': 'target_port', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.Port', '10': 'targetPort'},
    {'1': 'source_node', '3': 3, '4': 1, '5': 9, '10': 'sourceNode'},
    {'1': 'source_port', '3': 4, '4': 1, '5': 11, '6': '.mizer.nodes.Port', '10': 'sourcePort'},
    {'1': 'protocol', '3': 5, '4': 1, '5': 14, '6': '.mizer.nodes.ChannelProtocol', '10': 'protocol'},
  ],
};

/// Descriptor for `NodeConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeConnectionDescriptor = $convert.base64Decode(
    'Cg5Ob2RlQ29ubmVjdGlvbhIfCgt0YXJnZXRfbm9kZRgBIAEoCVIKdGFyZ2V0Tm9kZRIyCgt0YX'
    'JnZXRfcG9ydBgCIAEoCzIRLm1pemVyLm5vZGVzLlBvcnRSCnRhcmdldFBvcnQSHwoLc291cmNl'
    'X25vZGUYAyABKAlSCnNvdXJjZU5vZGUSMgoLc291cmNlX3BvcnQYBCABKAsyES5taXplci5ub2'
    'Rlcy5Qb3J0Ugpzb3VyY2VQb3J0EjgKCHByb3RvY29sGAUgASgOMhwubWl6ZXIubm9kZXMuQ2hh'
    'bm5lbFByb3RvY29sUghwcm90b2NvbA==');

@$core.Deprecated('Use nodeDescriptor instead')
const Node$json = {
  '1': 'Node',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.nodes.Node.NodeType', '10': 'type'},
    {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    {'1': 'inputs', '3': 3, '4': 3, '5': 11, '6': '.mizer.nodes.Port', '10': 'inputs'},
    {'1': 'outputs', '3': 4, '4': 3, '5': 11, '6': '.mizer.nodes.Port', '10': 'outputs'},
    {'1': 'designer', '3': 5, '4': 1, '5': 11, '6': '.mizer.nodes.NodeDesigner', '10': 'designer'},
    {'1': 'preview', '3': 6, '4': 1, '5': 14, '6': '.mizer.nodes.Node.NodePreviewType', '10': 'preview'},
    {'1': 'config', '3': 7, '4': 1, '5': 11, '6': '.mizer.nodes.NodeConfig', '10': 'config'},
    {'1': 'settings', '3': 8, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting', '10': 'settings'},
    {'1': 'details', '3': 9, '4': 1, '5': 11, '6': '.mizer.nodes.NodeDetails', '10': 'details'},
  ],
  '4': [Node_NodeType$json, Node_NodePreviewType$json],
};

@$core.Deprecated('Use nodeDescriptor instead')
const Node_NodeType$json = {
  '1': 'NodeType',
  '2': [
    {'1': 'FADER', '2': 0},
    {'1': 'BUTTON', '2': 1},
    {'1': 'OSCILLATOR', '2': 2},
    {'1': 'CLOCK', '2': 3},
    {'1': 'SCRIPT', '2': 4},
    {'1': 'ENVELOPE', '2': 5},
    {'1': 'STEP_SEQUENCER', '2': 6},
    {'1': 'SELECT', '2': 7},
    {'1': 'MERGE', '2': 8},
    {'1': 'THRESHOLD', '2': 9},
    {'1': 'DMX_OUTPUT', '2': 10},
    {'1': 'OSC_INPUT', '2': 11},
    {'1': 'OSC_OUTPUT', '2': 12},
    {'1': 'MIDI_INPUT', '2': 13},
    {'1': 'MIDI_OUTPUT', '2': 14},
    {'1': 'SEQUENCER', '2': 15},
    {'1': 'FIXTURE', '2': 16},
    {'1': 'PROGRAMMER', '2': 17},
    {'1': 'GROUP', '2': 18},
    {'1': 'PRESET', '2': 19},
    {'1': 'VIDEO_FILE', '2': 20},
    {'1': 'VIDEO_OUTPUT', '2': 21},
    {'1': 'VIDEO_HSV', '2': 23},
    {'1': 'VIDEO_TRANSFORM', '2': 24},
    {'1': 'VIDEO_MIXER', '2': 25},
    {'1': 'VIDEO_RGB', '2': 26},
    {'1': 'VIDEO_RGB_SPLIT', '2': 27},
    {'1': 'PIXEL_TO_DMX', '2': 30},
    {'1': 'PIXEL_PATTERN', '2': 31},
    {'1': 'OPC_OUTPUT', '2': 32},
    {'1': 'LASER', '2': 40},
    {'1': 'ILDA_FILE', '2': 41},
    {'1': 'GAMEPAD', '2': 45},
    {'1': 'COLOR_RGB', '2': 50},
    {'1': 'COLOR_HSV', '2': 51},
    {'1': 'COLOR_CONSTANT', '2': 52},
    {'1': 'COLOR_BRIGHTNESS', '2': 53},
    {'1': 'ENCODER', '2': 55},
    {'1': 'MATH', '2': 56},
    {'1': 'DATA_TO_NUMBER', '2': 57},
    {'1': 'NUMBER_TO_DATA', '2': 58},
    {'1': 'VALUE', '2': 59},
    {'1': 'EXTRACT', '2': 60},
    {'1': 'MQTT_INPUT', '2': 61},
    {'1': 'MQTT_OUTPUT', '2': 62},
    {'1': 'PLAN_SCREEN', '2': 63},
    {'1': 'DELAY', '2': 64},
    {'1': 'RAMP', '2': 65},
    {'1': 'NOISE', '2': 66},
    {'1': 'LABEL', '2': 67},
    {'1': 'TRANSPORT', '2': 68},
    {'1': 'G13INPUT', '2': 69},
    {'1': 'G13OUTPUT', '2': 70},
    {'1': 'CONSTANT_NUMBER', '2': 71},
    {'1': 'CONDITIONAL', '2': 72},
    {'1': 'TIMECODE_CONTROL', '2': 73},
    {'1': 'TIMECODE_OUTPUT', '2': 74},
    {'1': 'AUDIO_FILE', '2': 75},
    {'1': 'AUDIO_OUTPUT', '2': 76},
    {'1': 'AUDIO_VOLUME', '2': 77},
    {'1': 'AUDIO_INPUT', '2': 78},
    {'1': 'AUDIO_MIX', '2': 79},
    {'1': 'AUDIO_METER', '2': 80},
    {'1': 'TEMPLATE', '2': 81},
    {'1': 'WEBCAM', '2': 82},
    {'1': 'TEXTURE_BORDER', '2': 83},
    {'1': 'VIDEO_TEXT', '2': 84},
    {'1': 'BEATS', '2': 85},
    {'1': 'PRO_DJ_LINK_CLOCK', '2': 86},
    {'1': 'PIONEER_CDJ', '2': 87},
    {'1': 'NDI_OUTPUT', '2': 88},
    {'1': 'CONTAINER', '2': 100},
  ],
};

@$core.Deprecated('Use nodeDescriptor instead')
const Node_NodePreviewType$json = {
  '1': 'NodePreviewType',
  '2': [
    {'1': 'NONE', '2': 0},
    {'1': 'HISTORY', '2': 1},
    {'1': 'WAVEFORM', '2': 2},
    {'1': 'MULTIPLE', '2': 3},
    {'1': 'TEXTURE', '2': 4},
    {'1': 'TIMECODE', '2': 5},
    {'1': 'DATA', '2': 6},
    {'1': 'COLOR', '2': 7},
  ],
};

/// Descriptor for `Node`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDescriptor = $convert.base64Decode(
    'CgROb2RlEi4KBHR5cGUYASABKA4yGi5taXplci5ub2Rlcy5Ob2RlLk5vZGVUeXBlUgR0eXBlEh'
    'IKBHBhdGgYAiABKAlSBHBhdGgSKQoGaW5wdXRzGAMgAygLMhEubWl6ZXIubm9kZXMuUG9ydFIG'
    'aW5wdXRzEisKB291dHB1dHMYBCADKAsyES5taXplci5ub2Rlcy5Qb3J0UgdvdXRwdXRzEjUKCG'
    'Rlc2lnbmVyGAUgASgLMhkubWl6ZXIubm9kZXMuTm9kZURlc2lnbmVyUghkZXNpZ25lchI7Cgdw'
    'cmV2aWV3GAYgASgOMiEubWl6ZXIubm9kZXMuTm9kZS5Ob2RlUHJldmlld1R5cGVSB3ByZXZpZX'
    'cSLwoGY29uZmlnGAcgASgLMhcubWl6ZXIubm9kZXMuTm9kZUNvbmZpZ1IGY29uZmlnEjQKCHNl'
    'dHRpbmdzGAggAygLMhgubWl6ZXIubm9kZXMuTm9kZVNldHRpbmdSCHNldHRpbmdzEjIKB2RldG'
    'FpbHMYCSABKAsyGC5taXplci5ub2Rlcy5Ob2RlRGV0YWlsc1IHZGV0YWlscyLoCAoITm9kZVR5'
    'cGUSCQoFRkFERVIQABIKCgZCVVRUT04QARIOCgpPU0NJTExBVE9SEAISCQoFQ0xPQ0sQAxIKCg'
    'ZTQ1JJUFQQBBIMCghFTlZFTE9QRRAFEhIKDlNURVBfU0VRVUVOQ0VSEAYSCgoGU0VMRUNUEAcS'
    'CQoFTUVSR0UQCBINCglUSFJFU0hPTEQQCRIOCgpETVhfT1VUUFVUEAoSDQoJT1NDX0lOUFVUEA'
    'sSDgoKT1NDX09VVFBVVBAMEg4KCk1JRElfSU5QVVQQDRIPCgtNSURJX09VVFBVVBAOEg0KCVNF'
    'UVVFTkNFUhAPEgsKB0ZJWFRVUkUQEBIOCgpQUk9HUkFNTUVSEBESCQoFR1JPVVAQEhIKCgZQUk'
    'VTRVQQExIOCgpWSURFT19GSUxFEBQSEAoMVklERU9fT1VUUFVUEBUSDQoJVklERU9fSFNWEBcS'
    'EwoPVklERU9fVFJBTlNGT1JNEBgSDwoLVklERU9fTUlYRVIQGRINCglWSURFT19SR0IQGhITCg'
    '9WSURFT19SR0JfU1BMSVQQGxIQCgxQSVhFTF9UT19ETVgQHhIRCg1QSVhFTF9QQVRURVJOEB8S'
    'DgoKT1BDX09VVFBVVBAgEgkKBUxBU0VSECgSDQoJSUxEQV9GSUxFECkSCwoHR0FNRVBBRBAtEg'
    '0KCUNPTE9SX1JHQhAyEg0KCUNPTE9SX0hTVhAzEhIKDkNPTE9SX0NPTlNUQU5UEDQSFAoQQ09M'
    'T1JfQlJJR0hUTkVTUxA1EgsKB0VOQ09ERVIQNxIICgRNQVRIEDgSEgoOREFUQV9UT19OVU1CRV'
    'IQORISCg5OVU1CRVJfVE9fREFUQRA6EgkKBVZBTFVFEDsSCwoHRVhUUkFDVBA8Eg4KCk1RVFRf'
    'SU5QVVQQPRIPCgtNUVRUX09VVFBVVBA+Eg8KC1BMQU5fU0NSRUVOED8SCQoFREVMQVkQQBIICg'
    'RSQU1QEEESCQoFTk9JU0UQQhIJCgVMQUJFTBBDEg0KCVRSQU5TUE9SVBBEEgwKCEcxM0lOUFVU'
    'EEUSDQoJRzEzT1VUUFVUEEYSEwoPQ09OU1RBTlRfTlVNQkVSEEcSDwoLQ09ORElUSU9OQUwQSB'
    'IUChBUSU1FQ09ERV9DT05UUk9MEEkSEwoPVElNRUNPREVfT1VUUFVUEEoSDgoKQVVESU9fRklM'
    'RRBLEhAKDEFVRElPX09VVFBVVBBMEhAKDEFVRElPX1ZPTFVNRRBNEg8KC0FVRElPX0lOUFVUEE'
    '4SDQoJQVVESU9fTUlYEE8SDwoLQVVESU9fTUVURVIQUBIMCghURU1QTEFURRBREgoKBldFQkNB'
    'TRBSEhIKDlRFWFRVUkVfQk9SREVSEFMSDgoKVklERU9fVEVYVBBUEgkKBUJFQVRTEFUSFQoRUF'
    'JPX0RKX0xJTktfQ0xPQ0sQVhIPCgtQSU9ORUVSX0NEShBXEg4KCk5ESV9PVVRQVVQQWBINCglD'
    'T05UQUlORVIQZCJ0Cg9Ob2RlUHJldmlld1R5cGUSCAoETk9ORRAAEgsKB0hJU1RPUlkQARIMCg'
    'hXQVZFRk9STRACEgwKCE1VTFRJUExFEAMSCwoHVEVYVFVSRRAEEgwKCFRJTUVDT0RFEAUSCAoE'
    'REFUQRAGEgkKBUNPTE9SEAc=');

@$core.Deprecated('Use nodeDetailsDescriptor instead')
const NodeDetails$json = {
  '1': 'NodeDetails',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'category', '3': 2, '4': 1, '5': 14, '6': '.mizer.nodes.NodeCategory', '10': 'category'},
  ],
};

/// Descriptor for `NodeDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDetailsDescriptor = $convert.base64Decode(
    'CgtOb2RlRGV0YWlscxISCgRuYW1lGAEgASgJUgRuYW1lEjUKCGNhdGVnb3J5GAIgASgOMhkubW'
    'l6ZXIubm9kZXMuTm9kZUNhdGVnb3J5UghjYXRlZ29yeQ==');

@$core.Deprecated('Use nodeConfigDescriptor instead')
const NodeConfig$json = {
  '1': 'NodeConfig',
  '2': [
    {'1': 'container_config', '3': 45, '4': 1, '5': 11, '6': '.mizer.nodes.ContainerNodeConfig', '9': 0, '10': 'containerConfig'},
  ],
  '8': [
    {'1': 'type'},
  ],
};

/// Descriptor for `NodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeConfigDescriptor = $convert.base64Decode(
    'CgpOb2RlQ29uZmlnEk0KEGNvbnRhaW5lcl9jb25maWcYLSABKAsyIC5taXplci5ub2Rlcy5Db2'
    '50YWluZXJOb2RlQ29uZmlnSABSD2NvbnRhaW5lckNvbmZpZ0IGCgR0eXBl');

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting$json = {
  '1': 'NodeSetting',
  '2': [
    {'1': 'label', '3': 1, '4': 1, '5': 9, '10': 'label'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'disabled', '3': 3, '4': 1, '5': 8, '10': 'disabled'},
    {'1': 'text', '3': 4, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.TextValue', '9': 0, '10': 'text'},
    {'1': 'float', '3': 5, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.FloatValue', '9': 0, '10': 'float'},
    {'1': 'int', '3': 6, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.IntValue', '9': 0, '10': 'int'},
    {'1': 'bool', '3': 7, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.BoolValue', '9': 0, '10': 'bool'},
    {'1': 'select', '3': 8, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.SelectValue', '9': 0, '10': 'select'},
    {'1': 'enum', '3': 9, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.EnumValue', '9': 0, '10': 'enum'},
    {'1': 'id', '3': 10, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.IdValue', '9': 0, '10': 'id'},
    {'1': 'spline', '3': 11, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.SplineValue', '9': 0, '10': 'spline'},
    {'1': 'media', '3': 12, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.MediaValue', '9': 0, '10': 'media'},
    {'1': 'uint', '3': 13, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.UintValue', '9': 0, '10': 'uint'},
    {'1': 'step_sequencer', '3': 14, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.StepSequencerValue', '9': 0, '10': 'stepSequencer'},
  ],
  '3': [NodeSetting_TextValue$json, NodeSetting_FloatValue$json, NodeSetting_IntValue$json, NodeSetting_UintValue$json, NodeSetting_BoolValue$json, NodeSetting_SelectValue$json, NodeSetting_SelectVariant$json, NodeSetting_EnumValue$json, NodeSetting_EnumVariant$json, NodeSetting_IdValue$json, NodeSetting_IdVariant$json, NodeSetting_SplineValue$json, NodeSetting_MediaValue$json, NodeSetting_StepSequencerValue$json],
  '8': [
    {'1': 'value'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_TextValue$json = {
  '1': 'TextValue',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    {'1': 'multiline', '3': 2, '4': 1, '5': 8, '10': 'multiline'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_FloatValue$json = {
  '1': 'FloatValue',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
    {'1': 'min', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'min', '17': true},
    {'1': 'min_hint', '3': 3, '4': 1, '5': 1, '9': 1, '10': 'minHint', '17': true},
    {'1': 'max', '3': 4, '4': 1, '5': 1, '9': 2, '10': 'max', '17': true},
    {'1': 'max_hint', '3': 5, '4': 1, '5': 1, '9': 3, '10': 'maxHint', '17': true},
  ],
  '8': [
    {'1': '_min'},
    {'1': '_min_hint'},
    {'1': '_max'},
    {'1': '_max_hint'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_IntValue$json = {
  '1': 'IntValue',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 5, '10': 'value'},
    {'1': 'min', '3': 2, '4': 1, '5': 5, '9': 0, '10': 'min', '17': true},
    {'1': 'min_hint', '3': 3, '4': 1, '5': 5, '9': 1, '10': 'minHint', '17': true},
    {'1': 'max', '3': 4, '4': 1, '5': 5, '9': 2, '10': 'max', '17': true},
    {'1': 'max_hint', '3': 5, '4': 1, '5': 5, '9': 3, '10': 'maxHint', '17': true},
  ],
  '8': [
    {'1': '_min'},
    {'1': '_min_hint'},
    {'1': '_max'},
    {'1': '_max_hint'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_UintValue$json = {
  '1': 'UintValue',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
    {'1': 'min', '3': 2, '4': 1, '5': 13, '9': 0, '10': 'min', '17': true},
    {'1': 'min_hint', '3': 3, '4': 1, '5': 13, '9': 1, '10': 'minHint', '17': true},
    {'1': 'max', '3': 4, '4': 1, '5': 13, '9': 2, '10': 'max', '17': true},
    {'1': 'max_hint', '3': 5, '4': 1, '5': 13, '9': 3, '10': 'maxHint', '17': true},
  ],
  '8': [
    {'1': '_min'},
    {'1': '_min_hint'},
    {'1': '_max'},
    {'1': '_max_hint'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_BoolValue$json = {
  '1': 'BoolValue',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 8, '10': 'value'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_SelectValue$json = {
  '1': 'SelectValue',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    {'1': 'variants', '3': 2, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting.SelectVariant', '10': 'variants'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_SelectVariant$json = {
  '1': 'SelectVariant',
  '2': [
    {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.SelectVariant.SelectGroup', '9': 0, '10': 'group'},
    {'1': 'item', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.SelectVariant.SelectItem', '9': 0, '10': 'item'},
  ],
  '3': [NodeSetting_SelectVariant_SelectGroup$json, NodeSetting_SelectVariant_SelectItem$json],
  '8': [
    {'1': 'variant'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_SelectVariant_SelectGroup$json = {
  '1': 'SelectGroup',
  '2': [
    {'1': 'label', '3': 1, '4': 1, '5': 9, '10': 'label'},
    {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting.SelectVariant', '10': 'items'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_SelectVariant_SelectItem$json = {
  '1': 'SelectItem',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_EnumValue$json = {
  '1': 'EnumValue',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
    {'1': 'variants', '3': 2, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting.EnumVariant', '10': 'variants'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_EnumVariant$json = {
  '1': 'EnumVariant',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_IdValue$json = {
  '1': 'IdValue',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
    {'1': 'variants', '3': 2, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting.IdVariant', '10': 'variants'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_IdVariant$json = {
  '1': 'IdVariant',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_SplineValue$json = {
  '1': 'SplineValue',
  '2': [
    {'1': 'steps', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting.SplineValue.SplineStep', '10': 'steps'},
  ],
  '3': [NodeSetting_SplineValue_SplineStep$json],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_SplineValue_SplineStep$json = {
  '1': 'SplineStep',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 1, '10': 'y'},
    {'1': 'c0a', '3': 3, '4': 1, '5': 1, '10': 'c0a'},
    {'1': 'c0b', '3': 4, '4': 1, '5': 1, '10': 'c0b'},
    {'1': 'c1a', '3': 5, '4': 1, '5': 1, '10': 'c1a'},
    {'1': 'c1b', '3': 6, '4': 1, '5': 1, '10': 'c1b'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_MediaValue$json = {
  '1': 'MediaValue',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    {'1': 'allowed_types', '3': 2, '4': 3, '5': 14, '6': '.mizer.media.MediaType', '10': 'allowedTypes'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_StepSequencerValue$json = {
  '1': 'StepSequencerValue',
  '2': [
    {'1': 'steps', '3': 1, '4': 3, '5': 8, '10': 'steps'},
  ],
};

/// Descriptor for `NodeSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeSettingDescriptor = $convert.base64Decode(
    'CgtOb2RlU2V0dGluZxIUCgVsYWJlbBgBIAEoCVIFbGFiZWwSIAoLZGVzY3JpcHRpb24YAiABKA'
    'lSC2Rlc2NyaXB0aW9uEhoKCGRpc2FibGVkGAMgASgIUghkaXNhYmxlZBI4CgR0ZXh0GAQgASgL'
    'MiIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuVGV4dFZhbHVlSABSBHRleHQSOwoFZmxvYXQYBS'
    'ABKAsyIy5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5GbG9hdFZhbHVlSABSBWZsb2F0EjUKA2lu'
    'dBgGIAEoCzIhLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLkludFZhbHVlSABSA2ludBI4CgRib2'
    '9sGAcgASgLMiIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuQm9vbFZhbHVlSABSBGJvb2wSPgoG'
    'c2VsZWN0GAggASgLMiQubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuU2VsZWN0VmFsdWVIAFIGc2'
    'VsZWN0EjgKBGVudW0YCSABKAsyIi5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5FbnVtVmFsdWVI'
    'AFIEZW51bRIyCgJpZBgKIAEoCzIgLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLklkVmFsdWVIAF'
    'ICaWQSPgoGc3BsaW5lGAsgASgLMiQubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuU3BsaW5lVmFs'
    'dWVIAFIGc3BsaW5lEjsKBW1lZGlhGAwgASgLMiMubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuTW'
    'VkaWFWYWx1ZUgAUgVtZWRpYRI4CgR1aW50GA0gASgLMiIubWl6ZXIubm9kZXMuTm9kZVNldHRp'
    'bmcuVWludFZhbHVlSABSBHVpbnQSVAoOc3RlcF9zZXF1ZW5jZXIYDiABKAsyKy5taXplci5ub2'
    'Rlcy5Ob2RlU2V0dGluZy5TdGVwU2VxdWVuY2VyVmFsdWVIAFINc3RlcFNlcXVlbmNlcho/CglU'
    'ZXh0VmFsdWUSFAoFdmFsdWUYASABKAlSBXZhbHVlEhwKCW11bHRpbGluZRgCIAEoCFIJbXVsdG'
    'lsaW5lGroBCgpGbG9hdFZhbHVlEhQKBXZhbHVlGAEgASgBUgV2YWx1ZRIVCgNtaW4YAiABKAFI'
    'AFIDbWluiAEBEh4KCG1pbl9oaW50GAMgASgBSAFSB21pbkhpbnSIAQESFQoDbWF4GAQgASgBSA'
    'JSA21heIgBARIeCghtYXhfaGludBgFIAEoAUgDUgdtYXhIaW50iAEBQgYKBF9taW5CCwoJX21p'
    'bl9oaW50QgYKBF9tYXhCCwoJX21heF9oaW50GrgBCghJbnRWYWx1ZRIUCgV2YWx1ZRgBIAEoBV'
    'IFdmFsdWUSFQoDbWluGAIgASgFSABSA21pbogBARIeCghtaW5faGludBgDIAEoBUgBUgdtaW5I'
    'aW50iAEBEhUKA21heBgEIAEoBUgCUgNtYXiIAQESHgoIbWF4X2hpbnQYBSABKAVIA1IHbWF4SG'
    'ludIgBAUIGCgRfbWluQgsKCV9taW5faGludEIGCgRfbWF4QgsKCV9tYXhfaGludBq5AQoJVWlu'
    'dFZhbHVlEhQKBXZhbHVlGAEgASgNUgV2YWx1ZRIVCgNtaW4YAiABKA1IAFIDbWluiAEBEh4KCG'
    '1pbl9oaW50GAMgASgNSAFSB21pbkhpbnSIAQESFQoDbWF4GAQgASgNSAJSA21heIgBARIeCght'
    'YXhfaGludBgFIAEoDUgDUgdtYXhIaW50iAEBQgYKBF9taW5CCwoJX21pbl9oaW50QgYKBF9tYX'
    'hCCwoJX21heF9oaW50GiEKCUJvb2xWYWx1ZRIUCgV2YWx1ZRgBIAEoCFIFdmFsdWUaZwoLU2Vs'
    'ZWN0VmFsdWUSFAoFdmFsdWUYASABKAlSBXZhbHVlEkIKCHZhcmlhbnRzGAIgAygLMiYubWl6ZX'
    'Iubm9kZXMuTm9kZVNldHRpbmcuU2VsZWN0VmFyaWFudFIIdmFyaWFudHMazAIKDVNlbGVjdFZh'
    'cmlhbnQSSgoFZ3JvdXAYASABKAsyMi5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5TZWxlY3RWYX'
    'JpYW50LlNlbGVjdEdyb3VwSABSBWdyb3VwEkcKBGl0ZW0YAiABKAsyMS5taXplci5ub2Rlcy5O'
    'b2RlU2V0dGluZy5TZWxlY3RWYXJpYW50LlNlbGVjdEl0ZW1IAFIEaXRlbRphCgtTZWxlY3RHcm'
    '91cBIUCgVsYWJlbBgBIAEoCVIFbGFiZWwSPAoFaXRlbXMYAiADKAsyJi5taXplci5ub2Rlcy5O'
    'b2RlU2V0dGluZy5TZWxlY3RWYXJpYW50UgVpdGVtcxo4CgpTZWxlY3RJdGVtEhQKBXZhbHVlGA'
    'EgASgJUgV2YWx1ZRIUCgVsYWJlbBgCIAEoCVIFbGFiZWxCCQoHdmFyaWFudBpjCglFbnVtVmFs'
    'dWUSFAoFdmFsdWUYASABKA1SBXZhbHVlEkAKCHZhcmlhbnRzGAIgAygLMiQubWl6ZXIubm9kZX'
    'MuTm9kZVNldHRpbmcuRW51bVZhcmlhbnRSCHZhcmlhbnRzGjkKC0VudW1WYXJpYW50EhQKBXZh'
    'bHVlGAEgASgNUgV2YWx1ZRIUCgVsYWJlbBgCIAEoCVIFbGFiZWwaXwoHSWRWYWx1ZRIUCgV2YW'
    'x1ZRgBIAEoDVIFdmFsdWUSPgoIdmFyaWFudHMYAiADKAsyIi5taXplci5ub2Rlcy5Ob2RlU2V0'
    'dGluZy5JZFZhcmlhbnRSCHZhcmlhbnRzGjcKCUlkVmFyaWFudBIUCgV2YWx1ZRgBIAEoDVIFdm'
    'FsdWUSFAoFbGFiZWwYAiABKAlSBWxhYmVsGsYBCgtTcGxpbmVWYWx1ZRJFCgVzdGVwcxgBIAMo'
    'CzIvLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLlNwbGluZVZhbHVlLlNwbGluZVN0ZXBSBXN0ZX'
    'BzGnAKClNwbGluZVN0ZXASDAoBeBgBIAEoAVIBeBIMCgF5GAIgASgBUgF5EhAKA2MwYRgDIAEo'
    'AVIDYzBhEhAKA2MwYhgEIAEoAVIDYzBiEhAKA2MxYRgFIAEoAVIDYzFhEhAKA2MxYhgGIAEoAV'
    'IDYzFiGl8KCk1lZGlhVmFsdWUSFAoFdmFsdWUYASABKAlSBXZhbHVlEjsKDWFsbG93ZWRfdHlw'
    'ZXMYAiADKA4yFi5taXplci5tZWRpYS5NZWRpYVR5cGVSDGFsbG93ZWRUeXBlcxoqChJTdGVwU2'
    'VxdWVuY2VyVmFsdWUSFAoFc3RlcHMYASADKAhSBXN0ZXBzQgcKBXZhbHVl');

@$core.Deprecated('Use midiNodeConfigDescriptor instead')
const MidiNodeConfig$json = {
  '1': 'MidiNodeConfig',
  '2': [
    {'1': 'device', '3': 1, '4': 1, '5': 9, '10': 'device'},
    {'1': 'note_binding', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.MidiNodeConfig.NoteBinding', '9': 0, '10': 'noteBinding'},
    {'1': 'control_binding', '3': 3, '4': 1, '5': 11, '6': '.mizer.nodes.MidiNodeConfig.ControlBinding', '9': 0, '10': 'controlBinding'},
  ],
  '3': [MidiNodeConfig_NoteBinding$json, MidiNodeConfig_ControlBinding$json],
  '8': [
    {'1': 'binding'},
  ],
};

@$core.Deprecated('Use midiNodeConfigDescriptor instead')
const MidiNodeConfig_NoteBinding$json = {
  '1': 'NoteBinding',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 13, '10': 'channel'},
    {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.mizer.nodes.MidiNodeConfig.NoteBinding.MidiType', '10': 'type'},
    {'1': 'port', '3': 3, '4': 1, '5': 13, '10': 'port'},
    {'1': 'range_from', '3': 4, '4': 1, '5': 13, '10': 'rangeFrom'},
    {'1': 'range_to', '3': 5, '4': 1, '5': 13, '10': 'rangeTo'},
  ],
  '4': [MidiNodeConfig_NoteBinding_MidiType$json],
};

@$core.Deprecated('Use midiNodeConfigDescriptor instead')
const MidiNodeConfig_NoteBinding_MidiType$json = {
  '1': 'MidiType',
  '2': [
    {'1': 'CC', '2': 0},
    {'1': 'NOTE', '2': 1},
  ],
};

@$core.Deprecated('Use midiNodeConfigDescriptor instead')
const MidiNodeConfig_ControlBinding$json = {
  '1': 'ControlBinding',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 9, '10': 'page'},
    {'1': 'control', '3': 2, '4': 1, '5': 9, '10': 'control'},
  ],
};

/// Descriptor for `MidiNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiNodeConfigDescriptor = $convert.base64Decode(
    'Cg5NaWRpTm9kZUNvbmZpZxIWCgZkZXZpY2UYASABKAlSBmRldmljZRJMCgxub3RlX2JpbmRpbm'
    'cYAiABKAsyJy5taXplci5ub2Rlcy5NaWRpTm9kZUNvbmZpZy5Ob3RlQmluZGluZ0gAUgtub3Rl'
    'QmluZGluZxJVCg9jb250cm9sX2JpbmRpbmcYAyABKAsyKi5taXplci5ub2Rlcy5NaWRpTm9kZU'
    'NvbmZpZy5Db250cm9sQmluZGluZ0gAUg5jb250cm9sQmluZGluZxrZAQoLTm90ZUJpbmRpbmcS'
    'GAoHY2hhbm5lbBgBIAEoDVIHY2hhbm5lbBJECgR0eXBlGAIgASgOMjAubWl6ZXIubm9kZXMuTW'
    'lkaU5vZGVDb25maWcuTm90ZUJpbmRpbmcuTWlkaVR5cGVSBHR5cGUSEgoEcG9ydBgDIAEoDVIE'
    'cG9ydBIdCgpyYW5nZV9mcm9tGAQgASgNUglyYW5nZUZyb20SGQoIcmFuZ2VfdG8YBSABKA1SB3'
    'JhbmdlVG8iHAoITWlkaVR5cGUSBgoCQ0MQABIICgROT1RFEAEaPgoOQ29udHJvbEJpbmRpbmcS'
    'EgoEcGFnZRgBIAEoCVIEcGFnZRIYCgdjb250cm9sGAIgASgJUgdjb250cm9sQgkKB2JpbmRpbm'
    'c=');

@$core.Deprecated('Use containerNodeConfigDescriptor instead')
const ContainerNodeConfig$json = {
  '1': 'ContainerNodeConfig',
  '2': [
    {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.Node', '10': 'nodes'},
  ],
};

/// Descriptor for `ContainerNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List containerNodeConfigDescriptor = $convert.base64Decode(
    'ChNDb250YWluZXJOb2RlQ29uZmlnEicKBW5vZGVzGAEgAygLMhEubWl6ZXIubm9kZXMuTm9kZV'
    'IFbm9kZXM=');

@$core.Deprecated('Use nodePositionDescriptor instead')
const NodePosition$json = {
  '1': 'NodePosition',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 1, '10': 'y'},
  ],
};

/// Descriptor for `NodePosition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodePositionDescriptor = $convert.base64Decode(
    'CgxOb2RlUG9zaXRpb24SDAoBeBgBIAEoAVIBeBIMCgF5GAIgASgBUgF5');

@$core.Deprecated('Use nodeDesignerDescriptor instead')
const NodeDesigner$json = {
  '1': 'NodeDesigner',
  '2': [
    {'1': 'position', '3': 1, '4': 1, '5': 11, '6': '.mizer.nodes.NodePosition', '10': 'position'},
    {'1': 'scale', '3': 2, '4': 1, '5': 1, '10': 'scale'},
    {'1': 'hidden', '3': 3, '4': 1, '5': 8, '10': 'hidden'},
  ],
};

/// Descriptor for `NodeDesigner`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDesignerDescriptor = $convert.base64Decode(
    'CgxOb2RlRGVzaWduZXISNQoIcG9zaXRpb24YASABKAsyGS5taXplci5ub2Rlcy5Ob2RlUG9zaX'
    'Rpb25SCHBvc2l0aW9uEhQKBXNjYWxlGAIgASgBUgVzY2FsZRIWCgZoaWRkZW4YAyABKAhSBmhp'
    'ZGRlbg==');

@$core.Deprecated('Use portDescriptor instead')
const Port$json = {
  '1': 'Port',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'protocol', '3': 2, '4': 1, '5': 14, '6': '.mizer.nodes.ChannelProtocol', '10': 'protocol'},
    {'1': 'multiple', '3': 3, '4': 1, '5': 8, '10': 'multiple'},
  ],
};

/// Descriptor for `Port`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portDescriptor = $convert.base64Decode(
    'CgRQb3J0EhIKBG5hbWUYASABKAlSBG5hbWUSOAoIcHJvdG9jb2wYAiABKA4yHC5taXplci5ub2'
    'Rlcy5DaGFubmVsUHJvdG9jb2xSCHByb3RvY29sEhoKCG11bHRpcGxlGAMgASgIUghtdWx0aXBs'
    'ZQ==');

