///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use channelProtocolDescriptor instead')
const ChannelProtocol$json = const {
  '1': 'ChannelProtocol',
  '2': const [
    const {'1': 'SINGLE', '2': 0},
    const {'1': 'MULTI', '2': 1},
    const {'1': 'COLOR', '2': 9},
    const {'1': 'TEXTURE', '2': 2},
    const {'1': 'VECTOR', '2': 3},
    const {'1': 'LASER', '2': 4},
    const {'1': 'POLY', '2': 5},
    const {'1': 'DATA', '2': 6},
    const {'1': 'MATERIAL', '2': 7},
    const {'1': 'GST', '2': 8},
    const {'1': 'CLOCK', '2': 10},
  ],
};

/// Descriptor for `ChannelProtocol`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelProtocolDescriptor = $convert.base64Decode('Cg9DaGFubmVsUHJvdG9jb2wSCgoGU0lOR0xFEAASCQoFTVVMVEkQARIJCgVDT0xPUhAJEgsKB1RFWFRVUkUQAhIKCgZWRUNUT1IQAxIJCgVMQVNFUhAEEggKBFBPTFkQBRIICgREQVRBEAYSDAoITUFURVJJQUwQBxIHCgNHU1QQCBIJCgVDTE9DSxAK');
@$core.Deprecated('Use addNodeRequestDescriptor instead')
const AddNodeRequest$json = const {
  '1': 'AddNodeRequest',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.nodes.Node.NodeType', '10': 'type'},
    const {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.NodePosition', '10': 'position'},
    const {'1': 'parent', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
  ],
  '8': const [
    const {'1': '_parent'},
  ],
};

/// Descriptor for `AddNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addNodeRequestDescriptor = $convert.base64Decode('Cg5BZGROb2RlUmVxdWVzdBIuCgR0eXBlGAEgASgOMhoubWl6ZXIubm9kZXMuTm9kZS5Ob2RlVHlwZVIEdHlwZRI1Cghwb3NpdGlvbhgCIAEoCzIZLm1pemVyLm5vZGVzLk5vZGVQb3NpdGlvblIIcG9zaXRpb24SGwoGcGFyZW50GAMgASgJSABSBnBhcmVudIgBAUIJCgdfcGFyZW50');
@$core.Deprecated('Use duplicateNodeRequestDescriptor instead')
const DuplicateNodeRequest$json = const {
  '1': 'DuplicateNodeRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'parent', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
  ],
  '8': const [
    const {'1': '_parent'},
  ],
};

/// Descriptor for `DuplicateNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List duplicateNodeRequestDescriptor = $convert.base64Decode('ChREdXBsaWNhdGVOb2RlUmVxdWVzdBISCgRwYXRoGAEgASgJUgRwYXRoEhsKBnBhcmVudBgCIAEoCUgAUgZwYXJlbnSIAQFCCQoHX3BhcmVudA==');
@$core.Deprecated('Use nodesRequestDescriptor instead')
const NodesRequest$json = const {
  '1': 'NodesRequest',
};

/// Descriptor for `NodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodesRequestDescriptor = $convert.base64Decode('CgxOb2Rlc1JlcXVlc3Q=');
@$core.Deprecated('Use writeControlDescriptor instead')
const WriteControl$json = const {
  '1': 'WriteControl',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'port', '3': 2, '4': 1, '5': 9, '10': 'port'},
    const {'1': 'value', '3': 3, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `WriteControl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeControlDescriptor = $convert.base64Decode('CgxXcml0ZUNvbnRyb2wSEgoEcGF0aBgBIAEoCVIEcGF0aBISCgRwb3J0GAIgASgJUgRwb3J0EhQKBXZhbHVlGAMgASgBUgV2YWx1ZQ==');
@$core.Deprecated('Use writeResponseDescriptor instead')
const WriteResponse$json = const {
  '1': 'WriteResponse',
};

/// Descriptor for `WriteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeResponseDescriptor = $convert.base64Decode('Cg1Xcml0ZVJlc3BvbnNl');
@$core.Deprecated('Use updateNodeConfigRequestDescriptor instead')
const UpdateNodeConfigRequest$json = const {
  '1': 'UpdateNodeConfigRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'config', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.NodeConfig', '10': 'config'},
  ],
};

/// Descriptor for `UpdateNodeConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNodeConfigRequestDescriptor = $convert.base64Decode('ChdVcGRhdGVOb2RlQ29uZmlnUmVxdWVzdBISCgRwYXRoGAEgASgJUgRwYXRoEi8KBmNvbmZpZxgCIAEoCzIXLm1pemVyLm5vZGVzLk5vZGVDb25maWdSBmNvbmZpZw==');
@$core.Deprecated('Use updateNodeConfigResponseDescriptor instead')
const UpdateNodeConfigResponse$json = const {
  '1': 'UpdateNodeConfigResponse',
};

/// Descriptor for `UpdateNodeConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNodeConfigResponseDescriptor = $convert.base64Decode('ChhVcGRhdGVOb2RlQ29uZmlnUmVzcG9uc2U=');
@$core.Deprecated('Use moveNodeRequestDescriptor instead')
const MoveNodeRequest$json = const {
  '1': 'MoveNodeRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.NodePosition', '10': 'position'},
  ],
};

/// Descriptor for `MoveNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveNodeRequestDescriptor = $convert.base64Decode('Cg9Nb3ZlTm9kZVJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aBI1Cghwb3NpdGlvbhgCIAEoCzIZLm1pemVyLm5vZGVzLk5vZGVQb3NpdGlvblIIcG9zaXRpb24=');
@$core.Deprecated('Use moveNodeResponseDescriptor instead')
const MoveNodeResponse$json = const {
  '1': 'MoveNodeResponse',
};

/// Descriptor for `MoveNodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveNodeResponseDescriptor = $convert.base64Decode('ChBNb3ZlTm9kZVJlc3BvbnNl');
@$core.Deprecated('Use showNodeRequestDescriptor instead')
const ShowNodeRequest$json = const {
  '1': 'ShowNodeRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.NodePosition', '10': 'position'},
    const {'1': 'parent', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
  ],
  '8': const [
    const {'1': '_parent'},
  ],
};

/// Descriptor for `ShowNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List showNodeRequestDescriptor = $convert.base64Decode('Cg9TaG93Tm9kZVJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aBI1Cghwb3NpdGlvbhgCIAEoCzIZLm1pemVyLm5vZGVzLk5vZGVQb3NpdGlvblIIcG9zaXRpb24SGwoGcGFyZW50GAMgASgJSABSBnBhcmVudIgBAUIJCgdfcGFyZW50');
@$core.Deprecated('Use showNodeResponseDescriptor instead')
const ShowNodeResponse$json = const {
  '1': 'ShowNodeResponse',
};

/// Descriptor for `ShowNodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List showNodeResponseDescriptor = $convert.base64Decode('ChBTaG93Tm9kZVJlc3BvbnNl');
@$core.Deprecated('Use renameNodeRequestDescriptor instead')
const RenameNodeRequest$json = const {
  '1': 'RenameNodeRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'new_name', '3': 2, '4': 1, '5': 9, '10': 'newName'},
  ],
};

/// Descriptor for `RenameNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renameNodeRequestDescriptor = $convert.base64Decode('ChFSZW5hbWVOb2RlUmVxdWVzdBISCgRwYXRoGAEgASgJUgRwYXRoEhkKCG5ld19uYW1lGAIgASgJUgduZXdOYW1l');
@$core.Deprecated('Use renameNodeResponseDescriptor instead')
const RenameNodeResponse$json = const {
  '1': 'RenameNodeResponse',
};

/// Descriptor for `RenameNodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renameNodeResponseDescriptor = $convert.base64Decode('ChJSZW5hbWVOb2RlUmVzcG9uc2U=');
@$core.Deprecated('Use groupNodesRequestDescriptor instead')
const GroupNodesRequest$json = const {
  '1': 'GroupNodesRequest',
  '2': const [
    const {'1': 'nodes', '3': 1, '4': 3, '5': 9, '10': 'nodes'},
    const {'1': 'parent', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
  ],
  '8': const [
    const {'1': '_parent'},
  ],
};

/// Descriptor for `GroupNodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupNodesRequestDescriptor = $convert.base64Decode('ChFHcm91cE5vZGVzUmVxdWVzdBIUCgVub2RlcxgBIAMoCVIFbm9kZXMSGwoGcGFyZW50GAIgASgJSABSBnBhcmVudIgBAUIJCgdfcGFyZW50');
@$core.Deprecated('Use groupNodesResponseDescriptor instead')
const GroupNodesResponse$json = const {
  '1': 'GroupNodesResponse',
};

/// Descriptor for `GroupNodesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupNodesResponseDescriptor = $convert.base64Decode('ChJHcm91cE5vZGVzUmVzcG9uc2U=');
@$core.Deprecated('Use deleteNodeRequestDescriptor instead')
const DeleteNodeRequest$json = const {
  '1': 'DeleteNodeRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `DeleteNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteNodeRequestDescriptor = $convert.base64Decode('ChFEZWxldGVOb2RlUmVxdWVzdBISCgRwYXRoGAEgASgJUgRwYXRo');
@$core.Deprecated('Use deleteNodeResponseDescriptor instead')
const DeleteNodeResponse$json = const {
  '1': 'DeleteNodeResponse',
};

/// Descriptor for `DeleteNodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteNodeResponseDescriptor = $convert.base64Decode('ChJEZWxldGVOb2RlUmVzcG9uc2U=');
@$core.Deprecated('Use hideNodeRequestDescriptor instead')
const HideNodeRequest$json = const {
  '1': 'HideNodeRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `HideNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hideNodeRequestDescriptor = $convert.base64Decode('Cg9IaWRlTm9kZVJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aA==');
@$core.Deprecated('Use hideNodeResponseDescriptor instead')
const HideNodeResponse$json = const {
  '1': 'HideNodeResponse',
};

/// Descriptor for `HideNodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hideNodeResponseDescriptor = $convert.base64Decode('ChBIaWRlTm9kZVJlc3BvbnNl');
@$core.Deprecated('Use nodesDescriptor instead')
const Nodes$json = const {
  '1': 'Nodes',
  '2': const [
    const {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.Node', '10': 'nodes'},
    const {'1': 'channels', '3': 2, '4': 3, '5': 11, '6': '.mizer.nodes.NodeConnection', '10': 'channels'},
    const {'1': 'all_nodes', '3': 3, '4': 3, '5': 11, '6': '.mizer.nodes.Node', '10': 'allNodes'},
  ],
};

/// Descriptor for `Nodes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodesDescriptor = $convert.base64Decode('CgVOb2RlcxInCgVub2RlcxgBIAMoCzIRLm1pemVyLm5vZGVzLk5vZGVSBW5vZGVzEjcKCGNoYW5uZWxzGAIgAygLMhsubWl6ZXIubm9kZXMuTm9kZUNvbm5lY3Rpb25SCGNoYW5uZWxzEi4KCWFsbF9ub2RlcxgDIAMoCzIRLm1pemVyLm5vZGVzLk5vZGVSCGFsbE5vZGVz');
@$core.Deprecated('Use nodeConnectionDescriptor instead')
const NodeConnection$json = const {
  '1': 'NodeConnection',
  '2': const [
    const {'1': 'target_node', '3': 1, '4': 1, '5': 9, '10': 'targetNode'},
    const {'1': 'target_port', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.Port', '10': 'targetPort'},
    const {'1': 'source_node', '3': 3, '4': 1, '5': 9, '10': 'sourceNode'},
    const {'1': 'source_port', '3': 4, '4': 1, '5': 11, '6': '.mizer.nodes.Port', '10': 'sourcePort'},
    const {'1': 'protocol', '3': 5, '4': 1, '5': 14, '6': '.mizer.nodes.ChannelProtocol', '10': 'protocol'},
  ],
};

/// Descriptor for `NodeConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeConnectionDescriptor = $convert.base64Decode('Cg5Ob2RlQ29ubmVjdGlvbhIfCgt0YXJnZXRfbm9kZRgBIAEoCVIKdGFyZ2V0Tm9kZRIyCgt0YXJnZXRfcG9ydBgCIAEoCzIRLm1pemVyLm5vZGVzLlBvcnRSCnRhcmdldFBvcnQSHwoLc291cmNlX25vZGUYAyABKAlSCnNvdXJjZU5vZGUSMgoLc291cmNlX3BvcnQYBCABKAsyES5taXplci5ub2Rlcy5Qb3J0Ugpzb3VyY2VQb3J0EjgKCHByb3RvY29sGAUgASgOMhwubWl6ZXIubm9kZXMuQ2hhbm5lbFByb3RvY29sUghwcm90b2NvbA==');
@$core.Deprecated('Use nodeDescriptor instead')
const Node$json = const {
  '1': 'Node',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.nodes.Node.NodeType', '10': 'type'},
    const {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'inputs', '3': 3, '4': 3, '5': 11, '6': '.mizer.nodes.Port', '10': 'inputs'},
    const {'1': 'outputs', '3': 4, '4': 3, '5': 11, '6': '.mizer.nodes.Port', '10': 'outputs'},
    const {'1': 'designer', '3': 5, '4': 1, '5': 11, '6': '.mizer.nodes.NodeDesigner', '10': 'designer'},
    const {'1': 'preview', '3': 6, '4': 1, '5': 14, '6': '.mizer.nodes.Node.NodePreviewType', '10': 'preview'},
    const {'1': 'config', '3': 7, '4': 1, '5': 11, '6': '.mizer.nodes.NodeConfig', '10': 'config'},
  ],
  '4': const [Node_NodeType$json, Node_NodePreviewType$json],
};

@$core.Deprecated('Use nodeDescriptor instead')
const Node_NodeType$json = const {
  '1': 'NodeType',
  '2': const [
    const {'1': 'FADER', '2': 0},
    const {'1': 'BUTTON', '2': 1},
    const {'1': 'OSCILLATOR', '2': 2},
    const {'1': 'CLOCK', '2': 3},
    const {'1': 'SCRIPT', '2': 4},
    const {'1': 'ENVELOPE', '2': 5},
    const {'1': 'SEQUENCE', '2': 6},
    const {'1': 'SELECT', '2': 7},
    const {'1': 'MERGE', '2': 8},
    const {'1': 'THRESHOLD', '2': 9},
    const {'1': 'DMX_OUTPUT', '2': 10},
    const {'1': 'OSC_INPUT', '2': 11},
    const {'1': 'OSC_OUTPUT', '2': 12},
    const {'1': 'MIDI_INPUT', '2': 13},
    const {'1': 'MIDI_OUTPUT', '2': 14},
    const {'1': 'SEQUENCER', '2': 15},
    const {'1': 'FIXTURE', '2': 16},
    const {'1': 'PROGRAMMER', '2': 17},
    const {'1': 'GROUP', '2': 18},
    const {'1': 'PRESET', '2': 19},
    const {'1': 'VIDEO_FILE', '2': 20},
    const {'1': 'VIDEO_OUTPUT', '2': 21},
    const {'1': 'VIDEO_EFFECT', '2': 22},
    const {'1': 'VIDEO_COLOR_BALANCE', '2': 23},
    const {'1': 'VIDEO_TRANSFORM', '2': 24},
    const {'1': 'PIXEL_TO_DMX', '2': 30},
    const {'1': 'PIXEL_PATTERN', '2': 31},
    const {'1': 'OPC_OUTPUT', '2': 32},
    const {'1': 'LASER', '2': 40},
    const {'1': 'ILDA_FILE', '2': 41},
    const {'1': 'GAMEPAD', '2': 45},
    const {'1': 'COLOR_RGB', '2': 50},
    const {'1': 'COLOR_HSV', '2': 51},
    const {'1': 'COLOR_CONSTANT', '2': 52},
    const {'1': 'COLOR_BRIGHTNESS', '2': 53},
    const {'1': 'ENCODER', '2': 55},
    const {'1': 'MATH', '2': 56},
    const {'1': 'DATA_TO_NUMBER', '2': 57},
    const {'1': 'NUMBER_TO_DATA', '2': 58},
    const {'1': 'VALUE', '2': 59},
    const {'1': 'EXTRACT', '2': 60},
    const {'1': 'MQTT_INPUT', '2': 61},
    const {'1': 'MQTT_OUTPUT', '2': 62},
    const {'1': 'PLAN_SCREEN', '2': 63},
    const {'1': 'DELAY', '2': 64},
    const {'1': 'RAMP', '2': 65},
    const {'1': 'NOISE', '2': 66},
    const {'1': 'LABEL', '2': 67},
    const {'1': 'TRANSPORT', '2': 68},
    const {'1': 'G13INPUT', '2': 69},
    const {'1': 'G13OUTPUT', '2': 70},
    const {'1': 'CONSTANT_NUMBER', '2': 71},
    const {'1': 'CONDITIONAL', '2': 72},
    const {'1': 'TIMECODE_CONTROL', '2': 73},
    const {'1': 'TIMECODE_OUTPUT', '2': 74},
    const {'1': 'AUDIO_FILE', '2': 75},
    const {'1': 'AUDIO_OUTPUT', '2': 76},
    const {'1': 'AUDIO_VOLUME', '2': 77},
    const {'1': 'AUDIO_INPUT', '2': 78},
    const {'1': 'AUDIO_MIX', '2': 79},
    const {'1': 'AUDIO_METER', '2': 80},
    const {'1': 'TEMPLATE', '2': 81},
    const {'1': 'CONTAINER', '2': 100},
  ],
};

@$core.Deprecated('Use nodeDescriptor instead')
const Node_NodePreviewType$json = const {
  '1': 'NodePreviewType',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'HISTORY', '2': 1},
    const {'1': 'WAVEFORM', '2': 2},
    const {'1': 'MULTIPLE', '2': 3},
    const {'1': 'TEXTURE', '2': 4},
    const {'1': 'TIMECODE', '2': 5},
    const {'1': 'DATA', '2': 6},
    const {'1': 'COLOR', '2': 7},
  ],
};

/// Descriptor for `Node`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDescriptor = $convert.base64Decode('CgROb2RlEi4KBHR5cGUYASABKA4yGi5taXplci5ub2Rlcy5Ob2RlLk5vZGVUeXBlUgR0eXBlEhIKBHBhdGgYAiABKAlSBHBhdGgSKQoGaW5wdXRzGAMgAygLMhEubWl6ZXIubm9kZXMuUG9ydFIGaW5wdXRzEisKB291dHB1dHMYBCADKAsyES5taXplci5ub2Rlcy5Qb3J0UgdvdXRwdXRzEjUKCGRlc2lnbmVyGAUgASgLMhkubWl6ZXIubm9kZXMuTm9kZURlc2lnbmVyUghkZXNpZ25lchI7CgdwcmV2aWV3GAYgASgOMiEubWl6ZXIubm9kZXMuTm9kZS5Ob2RlUHJldmlld1R5cGVSB3ByZXZpZXcSLwoGY29uZmlnGAcgASgLMhcubWl6ZXIubm9kZXMuTm9kZUNvbmZpZ1IGY29uZmlnItYHCghOb2RlVHlwZRIJCgVGQURFUhAAEgoKBkJVVFRPThABEg4KCk9TQ0lMTEFUT1IQAhIJCgVDTE9DSxADEgoKBlNDUklQVBAEEgwKCEVOVkVMT1BFEAUSDAoIU0VRVUVOQ0UQBhIKCgZTRUxFQ1QQBxIJCgVNRVJHRRAIEg0KCVRIUkVTSE9MRBAJEg4KCkRNWF9PVVRQVVQQChINCglPU0NfSU5QVVQQCxIOCgpPU0NfT1VUUFVUEAwSDgoKTUlESV9JTlBVVBANEg8KC01JRElfT1VUUFVUEA4SDQoJU0VRVUVOQ0VSEA8SCwoHRklYVFVSRRAQEg4KClBST0dSQU1NRVIQERIJCgVHUk9VUBASEgoKBlBSRVNFVBATEg4KClZJREVPX0ZJTEUQFBIQCgxWSURFT19PVVRQVVQQFRIQCgxWSURFT19FRkZFQ1QQFhIXChNWSURFT19DT0xPUl9CQUxBTkNFEBcSEwoPVklERU9fVFJBTlNGT1JNEBgSEAoMUElYRUxfVE9fRE1YEB4SEQoNUElYRUxfUEFUVEVSThAfEg4KCk9QQ19PVVRQVVQQIBIJCgVMQVNFUhAoEg0KCUlMREFfRklMRRApEgsKB0dBTUVQQUQQLRINCglDT0xPUl9SR0IQMhINCglDT0xPUl9IU1YQMxISCg5DT0xPUl9DT05TVEFOVBA0EhQKEENPTE9SX0JSSUdIVE5FU1MQNRILCgdFTkNPREVSEDcSCAoETUFUSBA4EhIKDkRBVEFfVE9fTlVNQkVSEDkSEgoOTlVNQkVSX1RPX0RBVEEQOhIJCgVWQUxVRRA7EgsKB0VYVFJBQ1QQPBIOCgpNUVRUX0lOUFVUED0SDwoLTVFUVF9PVVRQVVQQPhIPCgtQTEFOX1NDUkVFThA/EgkKBURFTEFZEEASCAoEUkFNUBBBEgkKBU5PSVNFEEISCQoFTEFCRUwQQxINCglUUkFOU1BPUlQQRBIMCghHMTNJTlBVVBBFEg0KCUcxM09VVFBVVBBGEhMKD0NPTlNUQU5UX05VTUJFUhBHEg8KC0NPTkRJVElPTkFMEEgSFAoQVElNRUNPREVfQ09OVFJPTBBJEhMKD1RJTUVDT0RFX09VVFBVVBBKEg4KCkFVRElPX0ZJTEUQSxIQCgxBVURJT19PVVRQVVQQTBIQCgxBVURJT19WT0xVTUUQTRIPCgtBVURJT19JTlBVVBBOEg0KCUFVRElPX01JWBBPEg8KC0FVRElPX01FVEVSEFASDAoIVEVNUExBVEUQURINCglDT05UQUlORVIQZCJ0Cg9Ob2RlUHJldmlld1R5cGUSCAoETk9ORRAAEgsKB0hJU1RPUlkQARIMCghXQVZFRk9STRACEgwKCE1VTFRJUExFEAMSCwoHVEVYVFVSRRAEEgwKCFRJTUVDT0RFEAUSCAoEREFUQRAGEgkKBUNPTE9SEAc=');
@$core.Deprecated('Use nodeConfigDescriptor instead')
const NodeConfig$json = const {
  '1': 'NodeConfig',
  '2': const [
    const {'1': 'oscillator_config', '3': 10, '4': 1, '5': 11, '6': '.mizer.nodes.OscillatorNodeConfig', '9': 0, '10': 'oscillatorConfig'},
    const {'1': 'scripting_config', '3': 11, '4': 1, '5': 11, '6': '.mizer.nodes.ScriptingNodeConfig', '9': 0, '10': 'scriptingConfig'},
    const {'1': 'sequence_config', '3': 12, '4': 1, '5': 11, '6': '.mizer.nodes.SequenceNodeConfig', '9': 0, '10': 'sequenceConfig'},
    const {'1': 'clock_config', '3': 13, '4': 1, '5': 11, '6': '.mizer.nodes.ClockNodeConfig', '9': 0, '10': 'clockConfig'},
    const {'1': 'fixture_config', '3': 14, '4': 1, '5': 11, '6': '.mizer.nodes.FixtureNodeConfig', '9': 0, '10': 'fixtureConfig'},
    const {'1': 'button_config', '3': 15, '4': 1, '5': 11, '6': '.mizer.nodes.ButtonNodeConfig', '9': 0, '10': 'buttonConfig'},
    const {'1': 'fader_config', '3': 16, '4': 1, '5': 11, '6': '.mizer.nodes.FaderNodeConfig', '9': 0, '10': 'faderConfig'},
    const {'1': 'ilda_file_config', '3': 17, '4': 1, '5': 11, '6': '.mizer.nodes.IldaFileNodeConfig', '9': 0, '10': 'ildaFileConfig'},
    const {'1': 'laser_config', '3': 18, '4': 1, '5': 11, '6': '.mizer.nodes.LaserNodeConfig', '9': 0, '10': 'laserConfig'},
    const {'1': 'pixel_pattern_config', '3': 19, '4': 1, '5': 11, '6': '.mizer.nodes.PixelPatternNodeConfig', '9': 0, '10': 'pixelPatternConfig'},
    const {'1': 'pixel_dmx_config', '3': 20, '4': 1, '5': 11, '6': '.mizer.nodes.PixelDmxNodeConfig', '9': 0, '10': 'pixelDmxConfig'},
    const {'1': 'dmx_output_config', '3': 21, '4': 1, '5': 11, '6': '.mizer.nodes.DmxOutputNodeConfig', '9': 0, '10': 'dmxOutputConfig'},
    const {'1': 'midi_input_config', '3': 22, '4': 1, '5': 11, '6': '.mizer.nodes.MidiNodeConfig', '9': 0, '10': 'midiInputConfig'},
    const {'1': 'midi_output_config', '3': 23, '4': 1, '5': 11, '6': '.mizer.nodes.MidiNodeConfig', '9': 0, '10': 'midiOutputConfig'},
    const {'1': 'opc_output_config', '3': 24, '4': 1, '5': 11, '6': '.mizer.nodes.OpcOutputNodeConfig', '9': 0, '10': 'opcOutputConfig'},
    const {'1': 'osc_input_config', '3': 25, '4': 1, '5': 11, '6': '.mizer.nodes.OscNodeConfig', '9': 0, '10': 'oscInputConfig'},
    const {'1': 'osc_output_config', '3': 26, '4': 1, '5': 11, '6': '.mizer.nodes.OscNodeConfig', '9': 0, '10': 'oscOutputConfig'},
    const {'1': 'video_color_balance_config', '3': 27, '4': 1, '5': 11, '6': '.mizer.nodes.VideoColorBalanceNodeConfig', '9': 0, '10': 'videoColorBalanceConfig'},
    const {'1': 'video_effect_config', '3': 28, '4': 1, '5': 11, '6': '.mizer.nodes.VideoEffectNodeConfig', '9': 0, '10': 'videoEffectConfig'},
    const {'1': 'video_file_config', '3': 29, '4': 1, '5': 11, '6': '.mizer.nodes.VideoFileNodeConfig', '9': 0, '10': 'videoFileConfig'},
    const {'1': 'video_output_config', '3': 30, '4': 1, '5': 11, '6': '.mizer.nodes.VideoOutputNodeConfig', '9': 0, '10': 'videoOutputConfig'},
    const {'1': 'video_transform_config', '3': 31, '4': 1, '5': 11, '6': '.mizer.nodes.VideoTransformNodeConfig', '9': 0, '10': 'videoTransformConfig'},
    const {'1': 'select_config', '3': 32, '4': 1, '5': 11, '6': '.mizer.nodes.SelectNodeConfig', '9': 0, '10': 'selectConfig'},
    const {'1': 'merge_config', '3': 33, '4': 1, '5': 11, '6': '.mizer.nodes.MergeNodeConfig', '9': 0, '10': 'mergeConfig'},
    const {'1': 'envelope_config', '3': 34, '4': 1, '5': 11, '6': '.mizer.nodes.EnvelopeNodeConfig', '9': 0, '10': 'envelopeConfig'},
    const {'1': 'sequencer_config', '3': 35, '4': 1, '5': 11, '6': '.mizer.nodes.SequencerNodeConfig', '9': 0, '10': 'sequencerConfig'},
    const {'1': 'programmer_config', '3': 36, '4': 1, '5': 11, '6': '.mizer.nodes.ProgrammerNodeConfig', '9': 0, '10': 'programmerConfig'},
    const {'1': 'group_config', '3': 37, '4': 1, '5': 11, '6': '.mizer.nodes.GroupNodeConfig', '9': 0, '10': 'groupConfig'},
    const {'1': 'preset_config', '3': 38, '4': 1, '5': 11, '6': '.mizer.nodes.PresetNodeConfig', '9': 0, '10': 'presetConfig'},
    const {'1': 'color_rgb_config', '3': 40, '4': 1, '5': 11, '6': '.mizer.nodes.ColorRgbNodeConfig', '9': 0, '10': 'colorRgbConfig'},
    const {'1': 'color_hsv_config', '3': 41, '4': 1, '5': 11, '6': '.mizer.nodes.ColorHsvNodeConfig', '9': 0, '10': 'colorHsvConfig'},
    const {'1': 'gamepad_node_config', '3': 42, '4': 1, '5': 11, '6': '.mizer.nodes.GamepadNodeConfig', '9': 0, '10': 'gamepadNodeConfig'},
    const {'1': 'threshold_config', '3': 43, '4': 1, '5': 11, '6': '.mizer.nodes.ThresholdNodeConfig', '9': 0, '10': 'thresholdConfig'},
    const {'1': 'encoder_config', '3': 44, '4': 1, '5': 11, '6': '.mizer.nodes.EncoderNodeConfig', '9': 0, '10': 'encoderConfig'},
    const {'1': 'container_config', '3': 45, '4': 1, '5': 11, '6': '.mizer.nodes.ContainerNodeConfig', '9': 0, '10': 'containerConfig'},
    const {'1': 'math_config', '3': 46, '4': 1, '5': 11, '6': '.mizer.nodes.MathNodeConfig', '9': 0, '10': 'mathConfig'},
    const {'1': 'mqtt_input_config', '3': 47, '4': 1, '5': 11, '6': '.mizer.nodes.MqttInputNodeConfig', '9': 0, '10': 'mqttInputConfig'},
    const {'1': 'mqtt_output_config', '3': 48, '4': 1, '5': 11, '6': '.mizer.nodes.MqttOutputNodeConfig', '9': 0, '10': 'mqttOutputConfig'},
    const {'1': 'number_to_data_config', '3': 49, '4': 1, '5': 11, '6': '.mizer.nodes.NumberToDataNodeConfig', '9': 0, '10': 'numberToDataConfig'},
    const {'1': 'data_to_number_config', '3': 50, '4': 1, '5': 11, '6': '.mizer.nodes.DataToNumberNodeConfig', '9': 0, '10': 'dataToNumberConfig'},
    const {'1': 'value_config', '3': 51, '4': 1, '5': 11, '6': '.mizer.nodes.ValueNodeConfig', '9': 0, '10': 'valueConfig'},
    const {'1': 'extract_config', '3': 52, '4': 1, '5': 11, '6': '.mizer.nodes.ExtractNodeConfig', '9': 0, '10': 'extractConfig'},
    const {'1': 'plan_screen_config', '3': 53, '4': 1, '5': 11, '6': '.mizer.nodes.PlanScreenNodeConfig', '9': 0, '10': 'planScreenConfig'},
    const {'1': 'delay_config', '3': 54, '4': 1, '5': 11, '6': '.mizer.nodes.DelayNodeConfig', '9': 0, '10': 'delayConfig'},
    const {'1': 'ramp_config', '3': 55, '4': 1, '5': 11, '6': '.mizer.nodes.RampNodeConfig', '9': 0, '10': 'rampConfig'},
    const {'1': 'noise_config', '3': 56, '4': 1, '5': 11, '6': '.mizer.nodes.NoiseNodeConfig', '9': 0, '10': 'noiseConfig'},
    const {'1': 'label_config', '3': 57, '4': 1, '5': 11, '6': '.mizer.nodes.LabelNodeConfig', '9': 0, '10': 'labelConfig'},
    const {'1': 'transport_config', '3': 58, '4': 1, '5': 11, '6': '.mizer.nodes.TransportNodeConfig', '9': 0, '10': 'transportConfig'},
    const {'1': 'g13_input_config', '3': 59, '4': 1, '5': 11, '6': '.mizer.nodes.G13InputNodeConfig', '9': 0, '10': 'g13InputConfig'},
    const {'1': 'g13_output_config', '3': 60, '4': 1, '5': 11, '6': '.mizer.nodes.G13OutputNodeConfig', '9': 0, '10': 'g13OutputConfig'},
    const {'1': 'constant_number_config', '3': 61, '4': 1, '5': 11, '6': '.mizer.nodes.ConstantNumberNodeConfig', '9': 0, '10': 'constantNumberConfig'},
    const {'1': 'conditional_config', '3': 62, '4': 1, '5': 11, '6': '.mizer.nodes.ConditionalNodeConfig', '9': 0, '10': 'conditionalConfig'},
    const {'1': 'timecode_control_config', '3': 63, '4': 1, '5': 11, '6': '.mizer.nodes.TimecodeControlNodeConfig', '9': 0, '10': 'timecodeControlConfig'},
    const {'1': 'timecode_output_config', '3': 64, '4': 1, '5': 11, '6': '.mizer.nodes.TimecodeOutputNodeConfig', '9': 0, '10': 'timecodeOutputConfig'},
    const {'1': 'audio_file_config', '3': 65, '4': 1, '5': 11, '6': '.mizer.nodes.AudioFileNodeConfig', '9': 0, '10': 'audioFileConfig'},
    const {'1': 'audio_output_config', '3': 66, '4': 1, '5': 11, '6': '.mizer.nodes.AudioOutputNodeConfig', '9': 0, '10': 'audioOutputConfig'},
    const {'1': 'audio_volume_config', '3': 67, '4': 1, '5': 11, '6': '.mizer.nodes.AudioVolumeNodeConfig', '9': 0, '10': 'audioVolumeConfig'},
    const {'1': 'audio_input_config', '3': 68, '4': 1, '5': 11, '6': '.mizer.nodes.AudioInputNodeConfig', '9': 0, '10': 'audioInputConfig'},
    const {'1': 'audio_mix_config', '3': 69, '4': 1, '5': 11, '6': '.mizer.nodes.AudioMixNodeConfig', '9': 0, '10': 'audioMixConfig'},
    const {'1': 'audio_meter_config', '3': 70, '4': 1, '5': 11, '6': '.mizer.nodes.AudioMeterNodeConfig', '9': 0, '10': 'audioMeterConfig'},
    const {'1': 'template_config', '3': 71, '4': 1, '5': 11, '6': '.mizer.nodes.TemplateNodeConfig', '9': 0, '10': 'templateConfig'},
    const {'1': 'color_constant_config', '3': 72, '4': 1, '5': 11, '6': '.mizer.nodes.ColorConstantNodeConfig', '9': 0, '10': 'colorConstantConfig'},
    const {'1': 'color_brightness_config', '3': 73, '4': 1, '5': 11, '6': '.mizer.nodes.ColorBrightnessNodeConfig', '9': 0, '10': 'colorBrightnessConfig'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `NodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeConfigDescriptor = $convert.base64Decode('CgpOb2RlQ29uZmlnElAKEW9zY2lsbGF0b3JfY29uZmlnGAogASgLMiEubWl6ZXIubm9kZXMuT3NjaWxsYXRvck5vZGVDb25maWdIAFIQb3NjaWxsYXRvckNvbmZpZxJNChBzY3JpcHRpbmdfY29uZmlnGAsgASgLMiAubWl6ZXIubm9kZXMuU2NyaXB0aW5nTm9kZUNvbmZpZ0gAUg9zY3JpcHRpbmdDb25maWcSSgoPc2VxdWVuY2VfY29uZmlnGAwgASgLMh8ubWl6ZXIubm9kZXMuU2VxdWVuY2VOb2RlQ29uZmlnSABSDnNlcXVlbmNlQ29uZmlnEkEKDGNsb2NrX2NvbmZpZxgNIAEoCzIcLm1pemVyLm5vZGVzLkNsb2NrTm9kZUNvbmZpZ0gAUgtjbG9ja0NvbmZpZxJHCg5maXh0dXJlX2NvbmZpZxgOIAEoCzIeLm1pemVyLm5vZGVzLkZpeHR1cmVOb2RlQ29uZmlnSABSDWZpeHR1cmVDb25maWcSRAoNYnV0dG9uX2NvbmZpZxgPIAEoCzIdLm1pemVyLm5vZGVzLkJ1dHRvbk5vZGVDb25maWdIAFIMYnV0dG9uQ29uZmlnEkEKDGZhZGVyX2NvbmZpZxgQIAEoCzIcLm1pemVyLm5vZGVzLkZhZGVyTm9kZUNvbmZpZ0gAUgtmYWRlckNvbmZpZxJLChBpbGRhX2ZpbGVfY29uZmlnGBEgASgLMh8ubWl6ZXIubm9kZXMuSWxkYUZpbGVOb2RlQ29uZmlnSABSDmlsZGFGaWxlQ29uZmlnEkEKDGxhc2VyX2NvbmZpZxgSIAEoCzIcLm1pemVyLm5vZGVzLkxhc2VyTm9kZUNvbmZpZ0gAUgtsYXNlckNvbmZpZxJXChRwaXhlbF9wYXR0ZXJuX2NvbmZpZxgTIAEoCzIjLm1pemVyLm5vZGVzLlBpeGVsUGF0dGVybk5vZGVDb25maWdIAFIScGl4ZWxQYXR0ZXJuQ29uZmlnEksKEHBpeGVsX2RteF9jb25maWcYFCABKAsyHy5taXplci5ub2Rlcy5QaXhlbERteE5vZGVDb25maWdIAFIOcGl4ZWxEbXhDb25maWcSTgoRZG14X291dHB1dF9jb25maWcYFSABKAsyIC5taXplci5ub2Rlcy5EbXhPdXRwdXROb2RlQ29uZmlnSABSD2RteE91dHB1dENvbmZpZxJJChFtaWRpX2lucHV0X2NvbmZpZxgWIAEoCzIbLm1pemVyLm5vZGVzLk1pZGlOb2RlQ29uZmlnSABSD21pZGlJbnB1dENvbmZpZxJLChJtaWRpX291dHB1dF9jb25maWcYFyABKAsyGy5taXplci5ub2Rlcy5NaWRpTm9kZUNvbmZpZ0gAUhBtaWRpT3V0cHV0Q29uZmlnEk4KEW9wY19vdXRwdXRfY29uZmlnGBggASgLMiAubWl6ZXIubm9kZXMuT3BjT3V0cHV0Tm9kZUNvbmZpZ0gAUg9vcGNPdXRwdXRDb25maWcSRgoQb3NjX2lucHV0X2NvbmZpZxgZIAEoCzIaLm1pemVyLm5vZGVzLk9zY05vZGVDb25maWdIAFIOb3NjSW5wdXRDb25maWcSSAoRb3NjX291dHB1dF9jb25maWcYGiABKAsyGi5taXplci5ub2Rlcy5Pc2NOb2RlQ29uZmlnSABSD29zY091dHB1dENvbmZpZxJnChp2aWRlb19jb2xvcl9iYWxhbmNlX2NvbmZpZxgbIAEoCzIoLm1pemVyLm5vZGVzLlZpZGVvQ29sb3JCYWxhbmNlTm9kZUNvbmZpZ0gAUhd2aWRlb0NvbG9yQmFsYW5jZUNvbmZpZxJUChN2aWRlb19lZmZlY3RfY29uZmlnGBwgASgLMiIubWl6ZXIubm9kZXMuVmlkZW9FZmZlY3ROb2RlQ29uZmlnSABSEXZpZGVvRWZmZWN0Q29uZmlnEk4KEXZpZGVvX2ZpbGVfY29uZmlnGB0gASgLMiAubWl6ZXIubm9kZXMuVmlkZW9GaWxlTm9kZUNvbmZpZ0gAUg92aWRlb0ZpbGVDb25maWcSVAoTdmlkZW9fb3V0cHV0X2NvbmZpZxgeIAEoCzIiLm1pemVyLm5vZGVzLlZpZGVvT3V0cHV0Tm9kZUNvbmZpZ0gAUhF2aWRlb091dHB1dENvbmZpZxJdChZ2aWRlb190cmFuc2Zvcm1fY29uZmlnGB8gASgLMiUubWl6ZXIubm9kZXMuVmlkZW9UcmFuc2Zvcm1Ob2RlQ29uZmlnSABSFHZpZGVvVHJhbnNmb3JtQ29uZmlnEkQKDXNlbGVjdF9jb25maWcYICABKAsyHS5taXplci5ub2Rlcy5TZWxlY3ROb2RlQ29uZmlnSABSDHNlbGVjdENvbmZpZxJBCgxtZXJnZV9jb25maWcYISABKAsyHC5taXplci5ub2Rlcy5NZXJnZU5vZGVDb25maWdIAFILbWVyZ2VDb25maWcSSgoPZW52ZWxvcGVfY29uZmlnGCIgASgLMh8ubWl6ZXIubm9kZXMuRW52ZWxvcGVOb2RlQ29uZmlnSABSDmVudmVsb3BlQ29uZmlnEk0KEHNlcXVlbmNlcl9jb25maWcYIyABKAsyIC5taXplci5ub2Rlcy5TZXF1ZW5jZXJOb2RlQ29uZmlnSABSD3NlcXVlbmNlckNvbmZpZxJQChFwcm9ncmFtbWVyX2NvbmZpZxgkIAEoCzIhLm1pemVyLm5vZGVzLlByb2dyYW1tZXJOb2RlQ29uZmlnSABSEHByb2dyYW1tZXJDb25maWcSQQoMZ3JvdXBfY29uZmlnGCUgASgLMhwubWl6ZXIubm9kZXMuR3JvdXBOb2RlQ29uZmlnSABSC2dyb3VwQ29uZmlnEkQKDXByZXNldF9jb25maWcYJiABKAsyHS5taXplci5ub2Rlcy5QcmVzZXROb2RlQ29uZmlnSABSDHByZXNldENvbmZpZxJLChBjb2xvcl9yZ2JfY29uZmlnGCggASgLMh8ubWl6ZXIubm9kZXMuQ29sb3JSZ2JOb2RlQ29uZmlnSABSDmNvbG9yUmdiQ29uZmlnEksKEGNvbG9yX2hzdl9jb25maWcYKSABKAsyHy5taXplci5ub2Rlcy5Db2xvckhzdk5vZGVDb25maWdIAFIOY29sb3JIc3ZDb25maWcSUAoTZ2FtZXBhZF9ub2RlX2NvbmZpZxgqIAEoCzIeLm1pemVyLm5vZGVzLkdhbWVwYWROb2RlQ29uZmlnSABSEWdhbWVwYWROb2RlQ29uZmlnEk0KEHRocmVzaG9sZF9jb25maWcYKyABKAsyIC5taXplci5ub2Rlcy5UaHJlc2hvbGROb2RlQ29uZmlnSABSD3RocmVzaG9sZENvbmZpZxJHCg5lbmNvZGVyX2NvbmZpZxgsIAEoCzIeLm1pemVyLm5vZGVzLkVuY29kZXJOb2RlQ29uZmlnSABSDWVuY29kZXJDb25maWcSTQoQY29udGFpbmVyX2NvbmZpZxgtIAEoCzIgLm1pemVyLm5vZGVzLkNvbnRhaW5lck5vZGVDb25maWdIAFIPY29udGFpbmVyQ29uZmlnEj4KC21hdGhfY29uZmlnGC4gASgLMhsubWl6ZXIubm9kZXMuTWF0aE5vZGVDb25maWdIAFIKbWF0aENvbmZpZxJOChFtcXR0X2lucHV0X2NvbmZpZxgvIAEoCzIgLm1pemVyLm5vZGVzLk1xdHRJbnB1dE5vZGVDb25maWdIAFIPbXF0dElucHV0Q29uZmlnElEKEm1xdHRfb3V0cHV0X2NvbmZpZxgwIAEoCzIhLm1pemVyLm5vZGVzLk1xdHRPdXRwdXROb2RlQ29uZmlnSABSEG1xdHRPdXRwdXRDb25maWcSWAoVbnVtYmVyX3RvX2RhdGFfY29uZmlnGDEgASgLMiMubWl6ZXIubm9kZXMuTnVtYmVyVG9EYXRhTm9kZUNvbmZpZ0gAUhJudW1iZXJUb0RhdGFDb25maWcSWAoVZGF0YV90b19udW1iZXJfY29uZmlnGDIgASgLMiMubWl6ZXIubm9kZXMuRGF0YVRvTnVtYmVyTm9kZUNvbmZpZ0gAUhJkYXRhVG9OdW1iZXJDb25maWcSQQoMdmFsdWVfY29uZmlnGDMgASgLMhwubWl6ZXIubm9kZXMuVmFsdWVOb2RlQ29uZmlnSABSC3ZhbHVlQ29uZmlnEkcKDmV4dHJhY3RfY29uZmlnGDQgASgLMh4ubWl6ZXIubm9kZXMuRXh0cmFjdE5vZGVDb25maWdIAFINZXh0cmFjdENvbmZpZxJRChJwbGFuX3NjcmVlbl9jb25maWcYNSABKAsyIS5taXplci5ub2Rlcy5QbGFuU2NyZWVuTm9kZUNvbmZpZ0gAUhBwbGFuU2NyZWVuQ29uZmlnEkEKDGRlbGF5X2NvbmZpZxg2IAEoCzIcLm1pemVyLm5vZGVzLkRlbGF5Tm9kZUNvbmZpZ0gAUgtkZWxheUNvbmZpZxI+CgtyYW1wX2NvbmZpZxg3IAEoCzIbLm1pemVyLm5vZGVzLlJhbXBOb2RlQ29uZmlnSABSCnJhbXBDb25maWcSQQoMbm9pc2VfY29uZmlnGDggASgLMhwubWl6ZXIubm9kZXMuTm9pc2VOb2RlQ29uZmlnSABSC25vaXNlQ29uZmlnEkEKDGxhYmVsX2NvbmZpZxg5IAEoCzIcLm1pemVyLm5vZGVzLkxhYmVsTm9kZUNvbmZpZ0gAUgtsYWJlbENvbmZpZxJNChB0cmFuc3BvcnRfY29uZmlnGDogASgLMiAubWl6ZXIubm9kZXMuVHJhbnNwb3J0Tm9kZUNvbmZpZ0gAUg90cmFuc3BvcnRDb25maWcSSwoQZzEzX2lucHV0X2NvbmZpZxg7IAEoCzIfLm1pemVyLm5vZGVzLkcxM0lucHV0Tm9kZUNvbmZpZ0gAUg5nMTNJbnB1dENvbmZpZxJOChFnMTNfb3V0cHV0X2NvbmZpZxg8IAEoCzIgLm1pemVyLm5vZGVzLkcxM091dHB1dE5vZGVDb25maWdIAFIPZzEzT3V0cHV0Q29uZmlnEl0KFmNvbnN0YW50X251bWJlcl9jb25maWcYPSABKAsyJS5taXplci5ub2Rlcy5Db25zdGFudE51bWJlck5vZGVDb25maWdIAFIUY29uc3RhbnROdW1iZXJDb25maWcSUwoSY29uZGl0aW9uYWxfY29uZmlnGD4gASgLMiIubWl6ZXIubm9kZXMuQ29uZGl0aW9uYWxOb2RlQ29uZmlnSABSEWNvbmRpdGlvbmFsQ29uZmlnEmAKF3RpbWVjb2RlX2NvbnRyb2xfY29uZmlnGD8gASgLMiYubWl6ZXIubm9kZXMuVGltZWNvZGVDb250cm9sTm9kZUNvbmZpZ0gAUhV0aW1lY29kZUNvbnRyb2xDb25maWcSXQoWdGltZWNvZGVfb3V0cHV0X2NvbmZpZxhAIAEoCzIlLm1pemVyLm5vZGVzLlRpbWVjb2RlT3V0cHV0Tm9kZUNvbmZpZ0gAUhR0aW1lY29kZU91dHB1dENvbmZpZxJOChFhdWRpb19maWxlX2NvbmZpZxhBIAEoCzIgLm1pemVyLm5vZGVzLkF1ZGlvRmlsZU5vZGVDb25maWdIAFIPYXVkaW9GaWxlQ29uZmlnElQKE2F1ZGlvX291dHB1dF9jb25maWcYQiABKAsyIi5taXplci5ub2Rlcy5BdWRpb091dHB1dE5vZGVDb25maWdIAFIRYXVkaW9PdXRwdXRDb25maWcSVAoTYXVkaW9fdm9sdW1lX2NvbmZpZxhDIAEoCzIiLm1pemVyLm5vZGVzLkF1ZGlvVm9sdW1lTm9kZUNvbmZpZ0gAUhFhdWRpb1ZvbHVtZUNvbmZpZxJRChJhdWRpb19pbnB1dF9jb25maWcYRCABKAsyIS5taXplci5ub2Rlcy5BdWRpb0lucHV0Tm9kZUNvbmZpZ0gAUhBhdWRpb0lucHV0Q29uZmlnEksKEGF1ZGlvX21peF9jb25maWcYRSABKAsyHy5taXplci5ub2Rlcy5BdWRpb01peE5vZGVDb25maWdIAFIOYXVkaW9NaXhDb25maWcSUQoSYXVkaW9fbWV0ZXJfY29uZmlnGEYgASgLMiEubWl6ZXIubm9kZXMuQXVkaW9NZXRlck5vZGVDb25maWdIAFIQYXVkaW9NZXRlckNvbmZpZxJKCg90ZW1wbGF0ZV9jb25maWcYRyABKAsyHy5taXplci5ub2Rlcy5UZW1wbGF0ZU5vZGVDb25maWdIAFIOdGVtcGxhdGVDb25maWcSWgoVY29sb3JfY29uc3RhbnRfY29uZmlnGEggASgLMiQubWl6ZXIubm9kZXMuQ29sb3JDb25zdGFudE5vZGVDb25maWdIAFITY29sb3JDb25zdGFudENvbmZpZxJgChdjb2xvcl9icmlnaHRuZXNzX2NvbmZpZxhJIAEoCzImLm1pemVyLm5vZGVzLkNvbG9yQnJpZ2h0bmVzc05vZGVDb25maWdIAFIVY29sb3JCcmlnaHRuZXNzQ29uZmlnQgYKBHR5cGU=');
@$core.Deprecated('Use oscillatorNodeConfigDescriptor instead')
const OscillatorNodeConfig$json = const {
  '1': 'OscillatorNodeConfig',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.nodes.OscillatorNodeConfig.OscillatorType', '10': 'type'},
    const {'1': 'ratio', '3': 2, '4': 1, '5': 1, '10': 'ratio'},
    const {'1': 'max', '3': 3, '4': 1, '5': 1, '10': 'max'},
    const {'1': 'min', '3': 4, '4': 1, '5': 1, '10': 'min'},
    const {'1': 'offset', '3': 5, '4': 1, '5': 1, '10': 'offset'},
    const {'1': 'reverse', '3': 6, '4': 1, '5': 8, '10': 'reverse'},
  ],
  '4': const [OscillatorNodeConfig_OscillatorType$json],
};

@$core.Deprecated('Use oscillatorNodeConfigDescriptor instead')
const OscillatorNodeConfig_OscillatorType$json = const {
  '1': 'OscillatorType',
  '2': const [
    const {'1': 'SQUARE', '2': 0},
    const {'1': 'SINE', '2': 1},
    const {'1': 'SAW', '2': 2},
    const {'1': 'TRIANGLE', '2': 3},
  ],
};

/// Descriptor for `OscillatorNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List oscillatorNodeConfigDescriptor = $convert.base64Decode('ChRPc2NpbGxhdG9yTm9kZUNvbmZpZxJECgR0eXBlGAEgASgOMjAubWl6ZXIubm9kZXMuT3NjaWxsYXRvck5vZGVDb25maWcuT3NjaWxsYXRvclR5cGVSBHR5cGUSFAoFcmF0aW8YAiABKAFSBXJhdGlvEhAKA21heBgDIAEoAVIDbWF4EhAKA21pbhgEIAEoAVIDbWluEhYKBm9mZnNldBgFIAEoAVIGb2Zmc2V0EhgKB3JldmVyc2UYBiABKAhSB3JldmVyc2UiPQoOT3NjaWxsYXRvclR5cGUSCgoGU1FVQVJFEAASCAoEU0lORRABEgcKA1NBVxACEgwKCFRSSUFOR0xFEAM=');
@$core.Deprecated('Use scriptingNodeConfigDescriptor instead')
const ScriptingNodeConfig$json = const {
  '1': 'ScriptingNodeConfig',
  '2': const [
    const {'1': 'script', '3': 1, '4': 1, '5': 9, '10': 'script'},
  ],
};

/// Descriptor for `ScriptingNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scriptingNodeConfigDescriptor = $convert.base64Decode('ChNTY3JpcHRpbmdOb2RlQ29uZmlnEhYKBnNjcmlwdBgBIAEoCVIGc2NyaXB0');
@$core.Deprecated('Use sequenceNodeConfigDescriptor instead')
const SequenceNodeConfig$json = const {
  '1': 'SequenceNodeConfig',
  '2': const [
    const {'1': 'steps', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.SequenceNodeConfig.SequenceStep', '10': 'steps'},
  ],
  '3': const [SequenceNodeConfig_SequenceStep$json],
};

@$core.Deprecated('Use sequenceNodeConfigDescriptor instead')
const SequenceNodeConfig_SequenceStep$json = const {
  '1': 'SequenceStep',
  '2': const [
    const {'1': 'tick', '3': 1, '4': 1, '5': 1, '10': 'tick'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'hold', '3': 3, '4': 1, '5': 8, '10': 'hold'},
  ],
};

/// Descriptor for `SequenceNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceNodeConfigDescriptor = $convert.base64Decode('ChJTZXF1ZW5jZU5vZGVDb25maWcSQgoFc3RlcHMYASADKAsyLC5taXplci5ub2Rlcy5TZXF1ZW5jZU5vZGVDb25maWcuU2VxdWVuY2VTdGVwUgVzdGVwcxpMCgxTZXF1ZW5jZVN0ZXASEgoEdGljaxgBIAEoAVIEdGljaxIUCgV2YWx1ZRgCIAEoAVIFdmFsdWUSEgoEaG9sZBgDIAEoCFIEaG9sZA==');
@$core.Deprecated('Use programmerNodeConfigDescriptor instead')
const ProgrammerNodeConfig$json = const {
  '1': 'ProgrammerNodeConfig',
};

/// Descriptor for `ProgrammerNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List programmerNodeConfigDescriptor = $convert.base64Decode('ChRQcm9ncmFtbWVyTm9kZUNvbmZpZw==');
@$core.Deprecated('Use groupNodeConfigDescriptor instead')
const GroupNodeConfig$json = const {
  '1': 'GroupNodeConfig',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 13, '10': 'groupId'},
  ],
};

/// Descriptor for `GroupNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupNodeConfigDescriptor = $convert.base64Decode('Cg9Hcm91cE5vZGVDb25maWcSGQoIZ3JvdXBfaWQYASABKA1SB2dyb3VwSWQ=');
@$core.Deprecated('Use presetNodeConfigDescriptor instead')
const PresetNodeConfig$json = const {
  '1': 'PresetNodeConfig',
  '2': const [
    const {'1': 'preset_id', '3': 1, '4': 1, '5': 11, '6': '.mizer.programmer.PresetId', '10': 'presetId'},
  ],
};

/// Descriptor for `PresetNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List presetNodeConfigDescriptor = $convert.base64Decode('ChBQcmVzZXROb2RlQ29uZmlnEjcKCXByZXNldF9pZBgBIAEoCzIaLm1pemVyLnByb2dyYW1tZXIuUHJlc2V0SWRSCHByZXNldElk');
@$core.Deprecated('Use envelopeNodeConfigDescriptor instead')
const EnvelopeNodeConfig$json = const {
  '1': 'EnvelopeNodeConfig',
  '2': const [
    const {'1': 'attack', '3': 1, '4': 1, '5': 1, '10': 'attack'},
    const {'1': 'decay', '3': 2, '4': 1, '5': 1, '10': 'decay'},
    const {'1': 'sustain', '3': 3, '4': 1, '5': 1, '10': 'sustain'},
    const {'1': 'release', '3': 4, '4': 1, '5': 1, '10': 'release'},
  ],
};

/// Descriptor for `EnvelopeNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List envelopeNodeConfigDescriptor = $convert.base64Decode('ChJFbnZlbG9wZU5vZGVDb25maWcSFgoGYXR0YWNrGAEgASgBUgZhdHRhY2sSFAoFZGVjYXkYAiABKAFSBWRlY2F5EhgKB3N1c3RhaW4YAyABKAFSB3N1c3RhaW4SGAoHcmVsZWFzZRgEIAEoAVIHcmVsZWFzZQ==');
@$core.Deprecated('Use clockNodeConfigDescriptor instead')
const ClockNodeConfig$json = const {
  '1': 'ClockNodeConfig',
  '2': const [
    const {'1': 'speed', '3': 1, '4': 1, '5': 1, '10': 'speed'},
  ],
};

/// Descriptor for `ClockNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clockNodeConfigDescriptor = $convert.base64Decode('Cg9DbG9ja05vZGVDb25maWcSFAoFc3BlZWQYASABKAFSBXNwZWVk');
@$core.Deprecated('Use fixtureNodeConfigDescriptor instead')
const FixtureNodeConfig$json = const {
  '1': 'FixtureNodeConfig',
  '2': const [
    const {'1': 'fixture_id', '3': 1, '4': 1, '5': 13, '10': 'fixtureId'},
  ],
};

/// Descriptor for `FixtureNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fixtureNodeConfigDescriptor = $convert.base64Decode('ChFGaXh0dXJlTm9kZUNvbmZpZxIdCgpmaXh0dXJlX2lkGAEgASgNUglmaXh0dXJlSWQ=');
@$core.Deprecated('Use sequencerNodeConfigDescriptor instead')
const SequencerNodeConfig$json = const {
  '1': 'SequencerNodeConfig',
  '2': const [
    const {'1': 'sequence_id', '3': 1, '4': 1, '5': 13, '10': 'sequenceId'},
  ],
};

/// Descriptor for `SequencerNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequencerNodeConfigDescriptor = $convert.base64Decode('ChNTZXF1ZW5jZXJOb2RlQ29uZmlnEh8KC3NlcXVlbmNlX2lkGAEgASgNUgpzZXF1ZW5jZUlk');
@$core.Deprecated('Use buttonNodeConfigDescriptor instead')
const ButtonNodeConfig$json = const {
  '1': 'ButtonNodeConfig',
  '2': const [
    const {'1': 'toggle', '3': 1, '4': 1, '5': 8, '10': 'toggle'},
  ],
};

/// Descriptor for `ButtonNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buttonNodeConfigDescriptor = $convert.base64Decode('ChBCdXR0b25Ob2RlQ29uZmlnEhYKBnRvZ2dsZRgBIAEoCFIGdG9nZ2xl');
@$core.Deprecated('Use faderNodeConfigDescriptor instead')
const FaderNodeConfig$json = const {
  '1': 'FaderNodeConfig',
};

/// Descriptor for `FaderNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List faderNodeConfigDescriptor = $convert.base64Decode('Cg9GYWRlck5vZGVDb25maWc=');
@$core.Deprecated('Use ildaFileNodeConfigDescriptor instead')
const IldaFileNodeConfig$json = const {
  '1': 'IldaFileNodeConfig',
  '2': const [
    const {'1': 'file', '3': 1, '4': 1, '5': 9, '10': 'file'},
  ],
};

/// Descriptor for `IldaFileNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ildaFileNodeConfigDescriptor = $convert.base64Decode('ChJJbGRhRmlsZU5vZGVDb25maWcSEgoEZmlsZRgBIAEoCVIEZmlsZQ==');
@$core.Deprecated('Use laserNodeConfigDescriptor instead')
const LaserNodeConfig$json = const {
  '1': 'LaserNodeConfig',
  '2': const [
    const {'1': 'device_id', '3': 1, '4': 1, '5': 9, '10': 'deviceId'},
  ],
};

/// Descriptor for `LaserNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List laserNodeConfigDescriptor = $convert.base64Decode('Cg9MYXNlck5vZGVDb25maWcSGwoJZGV2aWNlX2lkGAEgASgJUghkZXZpY2VJZA==');
@$core.Deprecated('Use gamepadNodeConfigDescriptor instead')
const GamepadNodeConfig$json = const {
  '1': 'GamepadNodeConfig',
  '2': const [
    const {'1': 'device_id', '3': 1, '4': 1, '5': 9, '10': 'deviceId'},
    const {'1': 'control', '3': 2, '4': 1, '5': 14, '6': '.mizer.nodes.GamepadNodeConfig.Control', '10': 'control'},
  ],
  '4': const [GamepadNodeConfig_Control$json],
};

@$core.Deprecated('Use gamepadNodeConfigDescriptor instead')
const GamepadNodeConfig_Control$json = const {
  '1': 'Control',
  '2': const [
    const {'1': 'LEFT_STICK_X', '2': 0},
    const {'1': 'LEFT_STICK_Y', '2': 1},
    const {'1': 'RIGHT_STICK_X', '2': 2},
    const {'1': 'RIGHT_STICK_Y', '2': 3},
    const {'1': 'LEFT_TRIGGER', '2': 4},
    const {'1': 'RIGHT_TRIGGER', '2': 5},
    const {'1': 'LEFT_SHOULDER', '2': 6},
    const {'1': 'RIGHT_SHOULDER', '2': 7},
    const {'1': 'SOUTH', '2': 8},
    const {'1': 'EAST', '2': 9},
    const {'1': 'NORTH', '2': 10},
    const {'1': 'WEST', '2': 11},
    const {'1': 'SELECT', '2': 12},
    const {'1': 'START', '2': 13},
    const {'1': 'MODE', '2': 14},
    const {'1': 'DPAD_UP', '2': 15},
    const {'1': 'DPAD_DOWN', '2': 16},
    const {'1': 'DPAD_LEFT', '2': 17},
    const {'1': 'DPAD_RIGHT', '2': 18},
    const {'1': 'LEFT_STICK', '2': 19},
    const {'1': 'RIGHT_STICK', '2': 20},
  ],
};

/// Descriptor for `GamepadNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gamepadNodeConfigDescriptor = $convert.base64Decode('ChFHYW1lcGFkTm9kZUNvbmZpZxIbCglkZXZpY2VfaWQYASABKAlSCGRldmljZUlkEkAKB2NvbnRyb2wYAiABKA4yJi5taXplci5ub2Rlcy5HYW1lcGFkTm9kZUNvbmZpZy5Db250cm9sUgdjb250cm9sIsYCCgdDb250cm9sEhAKDExFRlRfU1RJQ0tfWBAAEhAKDExFRlRfU1RJQ0tfWRABEhEKDVJJR0hUX1NUSUNLX1gQAhIRCg1SSUdIVF9TVElDS19ZEAMSEAoMTEVGVF9UUklHR0VSEAQSEQoNUklHSFRfVFJJR0dFUhAFEhEKDUxFRlRfU0hPVUxERVIQBhISCg5SSUdIVF9TSE9VTERFUhAHEgkKBVNPVVRIEAgSCAoERUFTVBAJEgkKBU5PUlRIEAoSCAoEV0VTVBALEgoKBlNFTEVDVBAMEgkKBVNUQVJUEA0SCAoETU9ERRAOEgsKB0RQQURfVVAQDxINCglEUEFEX0RPV04QEBINCglEUEFEX0xFRlQQERIOCgpEUEFEX1JJR0hUEBISDgoKTEVGVF9TVElDSxATEg8KC1JJR0hUX1NUSUNLEBQ=');
@$core.Deprecated('Use pixelPatternNodeConfigDescriptor instead')
const PixelPatternNodeConfig$json = const {
  '1': 'PixelPatternNodeConfig',
  '2': const [
    const {'1': 'pattern', '3': 1, '4': 1, '5': 14, '6': '.mizer.nodes.PixelPatternNodeConfig.Pattern', '10': 'pattern'},
  ],
  '4': const [PixelPatternNodeConfig_Pattern$json],
};

@$core.Deprecated('Use pixelPatternNodeConfigDescriptor instead')
const PixelPatternNodeConfig_Pattern$json = const {
  '1': 'Pattern',
  '2': const [
    const {'1': 'RGB_ITERATE', '2': 0},
    const {'1': 'SWIRL', '2': 1},
  ],
};

/// Descriptor for `PixelPatternNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pixelPatternNodeConfigDescriptor = $convert.base64Decode('ChZQaXhlbFBhdHRlcm5Ob2RlQ29uZmlnEkUKB3BhdHRlcm4YASABKA4yKy5taXplci5ub2Rlcy5QaXhlbFBhdHRlcm5Ob2RlQ29uZmlnLlBhdHRlcm5SB3BhdHRlcm4iJQoHUGF0dGVybhIPCgtSR0JfSVRFUkFURRAAEgkKBVNXSVJMEAE=');
@$core.Deprecated('Use pixelDmxNodeConfigDescriptor instead')
const PixelDmxNodeConfig$json = const {
  '1': 'PixelDmxNodeConfig',
  '2': const [
    const {'1': 'width', '3': 1, '4': 1, '5': 4, '10': 'width'},
    const {'1': 'height', '3': 2, '4': 1, '5': 4, '10': 'height'},
    const {'1': 'start_universe', '3': 3, '4': 1, '5': 13, '10': 'startUniverse'},
    const {'1': 'output', '3': 4, '4': 1, '5': 9, '10': 'output'},
  ],
};

/// Descriptor for `PixelDmxNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pixelDmxNodeConfigDescriptor = $convert.base64Decode('ChJQaXhlbERteE5vZGVDb25maWcSFAoFd2lkdGgYASABKARSBXdpZHRoEhYKBmhlaWdodBgCIAEoBFIGaGVpZ2h0EiUKDnN0YXJ0X3VuaXZlcnNlGAMgASgNUg1zdGFydFVuaXZlcnNlEhYKBm91dHB1dBgEIAEoCVIGb3V0cHV0');
@$core.Deprecated('Use dmxOutputNodeConfigDescriptor instead')
const DmxOutputNodeConfig$json = const {
  '1': 'DmxOutputNodeConfig',
  '2': const [
    const {'1': 'output', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'output', '17': true},
    const {'1': 'universe', '3': 2, '4': 1, '5': 13, '10': 'universe'},
    const {'1': 'channel', '3': 3, '4': 1, '5': 13, '10': 'channel'},
  ],
  '8': const [
    const {'1': '_output'},
  ],
};

/// Descriptor for `DmxOutputNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dmxOutputNodeConfigDescriptor = $convert.base64Decode('ChNEbXhPdXRwdXROb2RlQ29uZmlnEhsKBm91dHB1dBgBIAEoCUgAUgZvdXRwdXSIAQESGgoIdW5pdmVyc2UYAiABKA1SCHVuaXZlcnNlEhgKB2NoYW5uZWwYAyABKA1SB2NoYW5uZWxCCQoHX291dHB1dA==');
@$core.Deprecated('Use midiNodeConfigDescriptor instead')
const MidiNodeConfig$json = const {
  '1': 'MidiNodeConfig',
  '2': const [
    const {'1': 'device', '3': 1, '4': 1, '5': 9, '10': 'device'},
    const {'1': 'note_binding', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.MidiNodeConfig.NoteBinding', '9': 0, '10': 'noteBinding'},
    const {'1': 'control_binding', '3': 3, '4': 1, '5': 11, '6': '.mizer.nodes.MidiNodeConfig.ControlBinding', '9': 0, '10': 'controlBinding'},
  ],
  '3': const [MidiNodeConfig_NoteBinding$json, MidiNodeConfig_ControlBinding$json],
  '8': const [
    const {'1': 'binding'},
  ],
};

@$core.Deprecated('Use midiNodeConfigDescriptor instead')
const MidiNodeConfig_NoteBinding$json = const {
  '1': 'NoteBinding',
  '2': const [
    const {'1': 'channel', '3': 1, '4': 1, '5': 13, '10': 'channel'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.mizer.nodes.MidiNodeConfig.NoteBinding.MidiType', '10': 'type'},
    const {'1': 'port', '3': 3, '4': 1, '5': 13, '10': 'port'},
    const {'1': 'range_from', '3': 4, '4': 1, '5': 13, '10': 'rangeFrom'},
    const {'1': 'range_to', '3': 5, '4': 1, '5': 13, '10': 'rangeTo'},
  ],
  '4': const [MidiNodeConfig_NoteBinding_MidiType$json],
};

@$core.Deprecated('Use midiNodeConfigDescriptor instead')
const MidiNodeConfig_NoteBinding_MidiType$json = const {
  '1': 'MidiType',
  '2': const [
    const {'1': 'CC', '2': 0},
    const {'1': 'NOTE', '2': 1},
  ],
};

@$core.Deprecated('Use midiNodeConfigDescriptor instead')
const MidiNodeConfig_ControlBinding$json = const {
  '1': 'ControlBinding',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 9, '10': 'page'},
    const {'1': 'control', '3': 2, '4': 1, '5': 9, '10': 'control'},
  ],
};

/// Descriptor for `MidiNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiNodeConfigDescriptor = $convert.base64Decode('Cg5NaWRpTm9kZUNvbmZpZxIWCgZkZXZpY2UYASABKAlSBmRldmljZRJMCgxub3RlX2JpbmRpbmcYAiABKAsyJy5taXplci5ub2Rlcy5NaWRpTm9kZUNvbmZpZy5Ob3RlQmluZGluZ0gAUgtub3RlQmluZGluZxJVCg9jb250cm9sX2JpbmRpbmcYAyABKAsyKi5taXplci5ub2Rlcy5NaWRpTm9kZUNvbmZpZy5Db250cm9sQmluZGluZ0gAUg5jb250cm9sQmluZGluZxrZAQoLTm90ZUJpbmRpbmcSGAoHY2hhbm5lbBgBIAEoDVIHY2hhbm5lbBJECgR0eXBlGAIgASgOMjAubWl6ZXIubm9kZXMuTWlkaU5vZGVDb25maWcuTm90ZUJpbmRpbmcuTWlkaVR5cGVSBHR5cGUSEgoEcG9ydBgDIAEoDVIEcG9ydBIdCgpyYW5nZV9mcm9tGAQgASgNUglyYW5nZUZyb20SGQoIcmFuZ2VfdG8YBSABKA1SB3JhbmdlVG8iHAoITWlkaVR5cGUSBgoCQ0MQABIICgROT1RFEAEaPgoOQ29udHJvbEJpbmRpbmcSEgoEcGFnZRgBIAEoCVIEcGFnZRIYCgdjb250cm9sGAIgASgJUgdjb250cm9sQgkKB2JpbmRpbmc=');
@$core.Deprecated('Use opcOutputNodeConfigDescriptor instead')
const OpcOutputNodeConfig$json = const {
  '1': 'OpcOutputNodeConfig',
  '2': const [
    const {'1': 'host', '3': 1, '4': 1, '5': 9, '10': 'host'},
    const {'1': 'port', '3': 2, '4': 1, '5': 13, '10': 'port'},
    const {'1': 'width', '3': 3, '4': 1, '5': 4, '10': 'width'},
    const {'1': 'height', '3': 4, '4': 1, '5': 4, '10': 'height'},
  ],
};

/// Descriptor for `OpcOutputNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List opcOutputNodeConfigDescriptor = $convert.base64Decode('ChNPcGNPdXRwdXROb2RlQ29uZmlnEhIKBGhvc3QYASABKAlSBGhvc3QSEgoEcG9ydBgCIAEoDVIEcG9ydBIUCgV3aWR0aBgDIAEoBFIFd2lkdGgSFgoGaGVpZ2h0GAQgASgEUgZoZWlnaHQ=');
@$core.Deprecated('Use oscNodeConfigDescriptor instead')
const OscNodeConfig$json = const {
  '1': 'OscNodeConfig',
  '2': const [
    const {'1': 'connection', '3': 1, '4': 1, '5': 9, '10': 'connection'},
    const {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'argument_type', '3': 3, '4': 1, '5': 14, '6': '.mizer.nodes.OscNodeConfig.ArgumentType', '10': 'argumentType'},
    const {'1': 'only_emit_changes', '3': 4, '4': 1, '5': 8, '10': 'onlyEmitChanges'},
  ],
  '4': const [OscNodeConfig_ArgumentType$json],
};

@$core.Deprecated('Use oscNodeConfigDescriptor instead')
const OscNodeConfig_ArgumentType$json = const {
  '1': 'ArgumentType',
  '2': const [
    const {'1': 'INT', '2': 0},
    const {'1': 'FLOAT', '2': 1},
    const {'1': 'LONG', '2': 2},
    const {'1': 'DOUBLE', '2': 3},
    const {'1': 'BOOL', '2': 4},
    const {'1': 'COLOR', '2': 5},
  ],
};

/// Descriptor for `OscNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List oscNodeConfigDescriptor = $convert.base64Decode('Cg1Pc2NOb2RlQ29uZmlnEh4KCmNvbm5lY3Rpb24YASABKAlSCmNvbm5lY3Rpb24SEgoEcGF0aBgCIAEoCVIEcGF0aBJMCg1hcmd1bWVudF90eXBlGAMgASgOMicubWl6ZXIubm9kZXMuT3NjTm9kZUNvbmZpZy5Bcmd1bWVudFR5cGVSDGFyZ3VtZW50VHlwZRIqChFvbmx5X2VtaXRfY2hhbmdlcxgEIAEoCFIPb25seUVtaXRDaGFuZ2VzIk0KDEFyZ3VtZW50VHlwZRIHCgNJTlQQABIJCgVGTE9BVBABEggKBExPTkcQAhIKCgZET1VCTEUQAxIICgRCT09MEAQSCQoFQ09MT1IQBQ==');
@$core.Deprecated('Use videoColorBalanceNodeConfigDescriptor instead')
const VideoColorBalanceNodeConfig$json = const {
  '1': 'VideoColorBalanceNodeConfig',
};

/// Descriptor for `VideoColorBalanceNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoColorBalanceNodeConfigDescriptor = $convert.base64Decode('ChtWaWRlb0NvbG9yQmFsYW5jZU5vZGVDb25maWc=');
@$core.Deprecated('Use videoEffectNodeConfigDescriptor instead')
const VideoEffectNodeConfig$json = const {
  '1': 'VideoEffectNodeConfig',
};

/// Descriptor for `VideoEffectNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoEffectNodeConfigDescriptor = $convert.base64Decode('ChVWaWRlb0VmZmVjdE5vZGVDb25maWc=');
@$core.Deprecated('Use videoFileNodeConfigDescriptor instead')
const VideoFileNodeConfig$json = const {
  '1': 'VideoFileNodeConfig',
  '2': const [
    const {'1': 'file', '3': 1, '4': 1, '5': 9, '10': 'file'},
  ],
};

/// Descriptor for `VideoFileNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoFileNodeConfigDescriptor = $convert.base64Decode('ChNWaWRlb0ZpbGVOb2RlQ29uZmlnEhIKBGZpbGUYASABKAlSBGZpbGU=');
@$core.Deprecated('Use videoOutputNodeConfigDescriptor instead')
const VideoOutputNodeConfig$json = const {
  '1': 'VideoOutputNodeConfig',
};

/// Descriptor for `VideoOutputNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoOutputNodeConfigDescriptor = $convert.base64Decode('ChVWaWRlb091dHB1dE5vZGVDb25maWc=');
@$core.Deprecated('Use videoTransformNodeConfigDescriptor instead')
const VideoTransformNodeConfig$json = const {
  '1': 'VideoTransformNodeConfig',
};

/// Descriptor for `VideoTransformNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoTransformNodeConfigDescriptor = $convert.base64Decode('ChhWaWRlb1RyYW5zZm9ybU5vZGVDb25maWc=');
@$core.Deprecated('Use selectNodeConfigDescriptor instead')
const SelectNodeConfig$json = const {
  '1': 'SelectNodeConfig',
};

/// Descriptor for `SelectNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List selectNodeConfigDescriptor = $convert.base64Decode('ChBTZWxlY3ROb2RlQ29uZmln');
@$core.Deprecated('Use mergeNodeConfigDescriptor instead')
const MergeNodeConfig$json = const {
  '1': 'MergeNodeConfig',
  '2': const [
    const {'1': 'mode', '3': 1, '4': 1, '5': 14, '6': '.mizer.nodes.MergeNodeConfig.MergeMode', '10': 'mode'},
  ],
  '4': const [MergeNodeConfig_MergeMode$json],
};

@$core.Deprecated('Use mergeNodeConfigDescriptor instead')
const MergeNodeConfig_MergeMode$json = const {
  '1': 'MergeMode',
  '2': const [
    const {'1': 'LATEST', '2': 0},
    const {'1': 'HIGHEST', '2': 1},
    const {'1': 'LOWEST', '2': 2},
  ],
};

/// Descriptor for `MergeNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mergeNodeConfigDescriptor = $convert.base64Decode('Cg9NZXJnZU5vZGVDb25maWcSOgoEbW9kZRgBIAEoDjImLm1pemVyLm5vZGVzLk1lcmdlTm9kZUNvbmZpZy5NZXJnZU1vZGVSBG1vZGUiMAoJTWVyZ2VNb2RlEgoKBkxBVEVTVBAAEgsKB0hJR0hFU1QQARIKCgZMT1dFU1QQAg==');
@$core.Deprecated('Use thresholdNodeConfigDescriptor instead')
const ThresholdNodeConfig$json = const {
  '1': 'ThresholdNodeConfig',
  '2': const [
    const {'1': 'lower_threshold', '3': 1, '4': 1, '5': 1, '10': 'lowerThreshold'},
    const {'1': 'upper_threshold', '3': 2, '4': 1, '5': 1, '10': 'upperThreshold'},
    const {'1': 'active_value', '3': 3, '4': 1, '5': 1, '10': 'activeValue'},
    const {'1': 'inactive_value', '3': 4, '4': 1, '5': 1, '10': 'inactiveValue'},
  ],
};

/// Descriptor for `ThresholdNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List thresholdNodeConfigDescriptor = $convert.base64Decode('ChNUaHJlc2hvbGROb2RlQ29uZmlnEicKD2xvd2VyX3RocmVzaG9sZBgBIAEoAVIObG93ZXJUaHJlc2hvbGQSJwoPdXBwZXJfdGhyZXNob2xkGAIgASgBUg51cHBlclRocmVzaG9sZBIhCgxhY3RpdmVfdmFsdWUYAyABKAFSC2FjdGl2ZVZhbHVlEiUKDmluYWN0aXZlX3ZhbHVlGAQgASgBUg1pbmFjdGl2ZVZhbHVl');
@$core.Deprecated('Use encoderNodeConfigDescriptor instead')
const EncoderNodeConfig$json = const {
  '1': 'EncoderNodeConfig',
  '2': const [
    const {'1': 'hold_rate', '3': 1, '4': 1, '5': 1, '10': 'holdRate'},
    const {'1': 'hold', '3': 2, '4': 1, '5': 8, '10': 'hold'},
  ],
};

/// Descriptor for `EncoderNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List encoderNodeConfigDescriptor = $convert.base64Decode('ChFFbmNvZGVyTm9kZUNvbmZpZxIbCglob2xkX3JhdGUYASABKAFSCGhvbGRSYXRlEhIKBGhvbGQYAiABKAhSBGhvbGQ=');
@$core.Deprecated('Use colorRgbNodeConfigDescriptor instead')
const ColorRgbNodeConfig$json = const {
  '1': 'ColorRgbNodeConfig',
};

/// Descriptor for `ColorRgbNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List colorRgbNodeConfigDescriptor = $convert.base64Decode('ChJDb2xvclJnYk5vZGVDb25maWc=');
@$core.Deprecated('Use colorHsvNodeConfigDescriptor instead')
const ColorHsvNodeConfig$json = const {
  '1': 'ColorHsvNodeConfig',
};

/// Descriptor for `ColorHsvNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List colorHsvNodeConfigDescriptor = $convert.base64Decode('ChJDb2xvckhzdk5vZGVDb25maWc=');
@$core.Deprecated('Use colorConstantNodeConfigDescriptor instead')
const ColorConstantNodeConfig$json = const {
  '1': 'ColorConstantNodeConfig',
  '2': const [
    const {'1': 'rgb', '3': 1, '4': 1, '5': 11, '6': '.mizer.nodes.ColorConstantNodeConfig.RgbColor', '9': 0, '10': 'rgb'},
    const {'1': 'hsv', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.ColorConstantNodeConfig.HsvColor', '9': 0, '10': 'hsv'},
  ],
  '3': const [ColorConstantNodeConfig_RgbColor$json, ColorConstantNodeConfig_HsvColor$json],
  '8': const [
    const {'1': 'color'},
  ],
};

@$core.Deprecated('Use colorConstantNodeConfigDescriptor instead')
const ColorConstantNodeConfig_RgbColor$json = const {
  '1': 'RgbColor',
  '2': const [
    const {'1': 'red', '3': 1, '4': 1, '5': 1, '10': 'red'},
    const {'1': 'green', '3': 2, '4': 1, '5': 1, '10': 'green'},
    const {'1': 'blue', '3': 3, '4': 1, '5': 1, '10': 'blue'},
  ],
};

@$core.Deprecated('Use colorConstantNodeConfigDescriptor instead')
const ColorConstantNodeConfig_HsvColor$json = const {
  '1': 'HsvColor',
  '2': const [
    const {'1': 'hue', '3': 1, '4': 1, '5': 1, '10': 'hue'},
    const {'1': 'saturation', '3': 2, '4': 1, '5': 1, '10': 'saturation'},
    const {'1': 'value', '3': 3, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `ColorConstantNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List colorConstantNodeConfigDescriptor = $convert.base64Decode('ChdDb2xvckNvbnN0YW50Tm9kZUNvbmZpZxJBCgNyZ2IYASABKAsyLS5taXplci5ub2Rlcy5Db2xvckNvbnN0YW50Tm9kZUNvbmZpZy5SZ2JDb2xvckgAUgNyZ2ISQQoDaHN2GAIgASgLMi0ubWl6ZXIubm9kZXMuQ29sb3JDb25zdGFudE5vZGVDb25maWcuSHN2Q29sb3JIAFIDaHN2GkYKCFJnYkNvbG9yEhAKA3JlZBgBIAEoAVIDcmVkEhQKBWdyZWVuGAIgASgBUgVncmVlbhISCgRibHVlGAMgASgBUgRibHVlGlIKCEhzdkNvbG9yEhAKA2h1ZRgBIAEoAVIDaHVlEh4KCnNhdHVyYXRpb24YAiABKAFSCnNhdHVyYXRpb24SFAoFdmFsdWUYAyABKAFSBXZhbHVlQgcKBWNvbG9y');
@$core.Deprecated('Use colorBrightnessNodeConfigDescriptor instead')
const ColorBrightnessNodeConfig$json = const {
  '1': 'ColorBrightnessNodeConfig',
};

/// Descriptor for `ColorBrightnessNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List colorBrightnessNodeConfigDescriptor = $convert.base64Decode('ChlDb2xvckJyaWdodG5lc3NOb2RlQ29uZmln');
@$core.Deprecated('Use containerNodeConfigDescriptor instead')
const ContainerNodeConfig$json = const {
  '1': 'ContainerNodeConfig',
  '2': const [
    const {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.Node', '10': 'nodes'},
  ],
};

/// Descriptor for `ContainerNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List containerNodeConfigDescriptor = $convert.base64Decode('ChNDb250YWluZXJOb2RlQ29uZmlnEicKBW5vZGVzGAEgAygLMhEubWl6ZXIubm9kZXMuTm9kZVIFbm9kZXM=');
@$core.Deprecated('Use mathNodeConfigDescriptor instead')
const MathNodeConfig$json = const {
  '1': 'MathNodeConfig',
  '2': const [
    const {'1': 'mode', '3': 1, '4': 1, '5': 14, '6': '.mizer.nodes.MathNodeConfig.Mode', '10': 'mode'},
  ],
  '4': const [MathNodeConfig_Mode$json],
};

@$core.Deprecated('Use mathNodeConfigDescriptor instead')
const MathNodeConfig_Mode$json = const {
  '1': 'Mode',
  '2': const [
    const {'1': 'ADDITION', '2': 0},
    const {'1': 'SUBTRACTION', '2': 1},
    const {'1': 'MULTIPLICATION', '2': 2},
    const {'1': 'DIVISION', '2': 3},
    const {'1': 'INVERT', '2': 4},
    const {'1': 'SINE', '2': 5},
    const {'1': 'COSINE', '2': 6},
    const {'1': 'TANGENT', '2': 7},
  ],
};

/// Descriptor for `MathNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mathNodeConfigDescriptor = $convert.base64Decode('Cg5NYXRoTm9kZUNvbmZpZxI0CgRtb2RlGAEgASgOMiAubWl6ZXIubm9kZXMuTWF0aE5vZGVDb25maWcuTW9kZVIEbW9kZSJ2CgRNb2RlEgwKCEFERElUSU9OEAASDwoLU1VCVFJBQ1RJT04QARISCg5NVUxUSVBMSUNBVElPThACEgwKCERJVklTSU9OEAMSCgoGSU5WRVJUEAQSCAoEU0lORRAFEgoKBkNPU0lORRAGEgsKB1RBTkdFTlQQBw==');
@$core.Deprecated('Use mqttInputNodeConfigDescriptor instead')
const MqttInputNodeConfig$json = const {
  '1': 'MqttInputNodeConfig',
  '2': const [
    const {'1': 'connection', '3': 1, '4': 1, '5': 9, '10': 'connection'},
    const {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `MqttInputNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mqttInputNodeConfigDescriptor = $convert.base64Decode('ChNNcXR0SW5wdXROb2RlQ29uZmlnEh4KCmNvbm5lY3Rpb24YASABKAlSCmNvbm5lY3Rpb24SEgoEcGF0aBgCIAEoCVIEcGF0aA==');
@$core.Deprecated('Use mqttOutputNodeConfigDescriptor instead')
const MqttOutputNodeConfig$json = const {
  '1': 'MqttOutputNodeConfig',
  '2': const [
    const {'1': 'connection', '3': 1, '4': 1, '5': 9, '10': 'connection'},
    const {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'retain', '3': 3, '4': 1, '5': 8, '10': 'retain'},
  ],
};

/// Descriptor for `MqttOutputNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mqttOutputNodeConfigDescriptor = $convert.base64Decode('ChRNcXR0T3V0cHV0Tm9kZUNvbmZpZxIeCgpjb25uZWN0aW9uGAEgASgJUgpjb25uZWN0aW9uEhIKBHBhdGgYAiABKAlSBHBhdGgSFgoGcmV0YWluGAMgASgIUgZyZXRhaW4=');
@$core.Deprecated('Use numberToDataNodeConfigDescriptor instead')
const NumberToDataNodeConfig$json = const {
  '1': 'NumberToDataNodeConfig',
};

/// Descriptor for `NumberToDataNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List numberToDataNodeConfigDescriptor = $convert.base64Decode('ChZOdW1iZXJUb0RhdGFOb2RlQ29uZmln');
@$core.Deprecated('Use dataToNumberNodeConfigDescriptor instead')
const DataToNumberNodeConfig$json = const {
  '1': 'DataToNumberNodeConfig',
};

/// Descriptor for `DataToNumberNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataToNumberNodeConfigDescriptor = $convert.base64Decode('ChZEYXRhVG9OdW1iZXJOb2RlQ29uZmln');
@$core.Deprecated('Use valueNodeConfigDescriptor instead')
const ValueNodeConfig$json = const {
  '1': 'ValueNodeConfig',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `ValueNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List valueNodeConfigDescriptor = $convert.base64Decode('Cg9WYWx1ZU5vZGVDb25maWcSFAoFdmFsdWUYASABKAlSBXZhbHVl');
@$core.Deprecated('Use extractNodeConfigDescriptor instead')
const ExtractNodeConfig$json = const {
  '1': 'ExtractNodeConfig',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `ExtractNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extractNodeConfigDescriptor = $convert.base64Decode('ChFFeHRyYWN0Tm9kZUNvbmZpZxISCgRwYXRoGAEgASgJUgRwYXRo');
@$core.Deprecated('Use templateNodeConfigDescriptor instead')
const TemplateNodeConfig$json = const {
  '1': 'TemplateNodeConfig',
  '2': const [
    const {'1': 'template', '3': 1, '4': 1, '5': 9, '10': 'template'},
  ],
};

/// Descriptor for `TemplateNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List templateNodeConfigDescriptor = $convert.base64Decode('ChJUZW1wbGF0ZU5vZGVDb25maWcSGgoIdGVtcGxhdGUYASABKAlSCHRlbXBsYXRl');
@$core.Deprecated('Use planScreenNodeConfigDescriptor instead')
const PlanScreenNodeConfig$json = const {
  '1': 'PlanScreenNodeConfig',
  '2': const [
    const {'1': 'plan_id', '3': 1, '4': 1, '5': 9, '10': 'planId'},
    const {'1': 'screen_id', '3': 2, '4': 1, '5': 13, '10': 'screenId'},
  ],
};

/// Descriptor for `PlanScreenNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List planScreenNodeConfigDescriptor = $convert.base64Decode('ChRQbGFuU2NyZWVuTm9kZUNvbmZpZxIXCgdwbGFuX2lkGAEgASgJUgZwbGFuSWQSGwoJc2NyZWVuX2lkGAIgASgNUghzY3JlZW5JZA==');
@$core.Deprecated('Use delayNodeConfigDescriptor instead')
const DelayNodeConfig$json = const {
  '1': 'DelayNodeConfig',
  '2': const [
    const {'1': 'buffer_size', '3': 1, '4': 1, '5': 13, '10': 'bufferSize'},
  ],
};

/// Descriptor for `DelayNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List delayNodeConfigDescriptor = $convert.base64Decode('Cg9EZWxheU5vZGVDb25maWcSHwoLYnVmZmVyX3NpemUYASABKA1SCmJ1ZmZlclNpemU=');
@$core.Deprecated('Use rampNodeConfigDescriptor instead')
const RampNodeConfig$json = const {
  '1': 'RampNodeConfig',
  '2': const [
    const {'1': 'steps', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.RampNodeConfig.RampStep', '10': 'steps'},
  ],
  '3': const [RampNodeConfig_RampStep$json],
};

@$core.Deprecated('Use rampNodeConfigDescriptor instead')
const RampNodeConfig_RampStep$json = const {
  '1': 'RampStep',
  '2': const [
    const {'1': 'x', '3': 1, '4': 1, '5': 1, '10': 'x'},
    const {'1': 'y', '3': 2, '4': 1, '5': 1, '10': 'y'},
    const {'1': 'c0a', '3': 3, '4': 1, '5': 1, '10': 'c0a'},
    const {'1': 'c0b', '3': 4, '4': 1, '5': 1, '10': 'c0b'},
    const {'1': 'c1a', '3': 5, '4': 1, '5': 1, '10': 'c1a'},
    const {'1': 'c1b', '3': 6, '4': 1, '5': 1, '10': 'c1b'},
  ],
};

/// Descriptor for `RampNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rampNodeConfigDescriptor = $convert.base64Decode('Cg5SYW1wTm9kZUNvbmZpZxI6CgVzdGVwcxgBIAMoCzIkLm1pemVyLm5vZGVzLlJhbXBOb2RlQ29uZmlnLlJhbXBTdGVwUgVzdGVwcxpuCghSYW1wU3RlcBIMCgF4GAEgASgBUgF4EgwKAXkYAiABKAFSAXkSEAoDYzBhGAMgASgBUgNjMGESEAoDYzBiGAQgASgBUgNjMGISEAoDYzFhGAUgASgBUgNjMWESEAoDYzFiGAYgASgBUgNjMWI=');
@$core.Deprecated('Use noiseNodeConfigDescriptor instead')
const NoiseNodeConfig$json = const {
  '1': 'NoiseNodeConfig',
  '2': const [
    const {'1': 'tick_rate', '3': 1, '4': 1, '5': 4, '10': 'tickRate'},
    const {'1': 'fade', '3': 2, '4': 1, '5': 8, '10': 'fade'},
  ],
};

/// Descriptor for `NoiseNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List noiseNodeConfigDescriptor = $convert.base64Decode('Cg9Ob2lzZU5vZGVDb25maWcSGwoJdGlja19yYXRlGAEgASgEUgh0aWNrUmF0ZRISCgRmYWRlGAIgASgIUgRmYWRl');
@$core.Deprecated('Use labelNodeConfigDescriptor instead')
const LabelNodeConfig$json = const {
  '1': 'LabelNodeConfig',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
  ],
};

/// Descriptor for `LabelNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List labelNodeConfigDescriptor = $convert.base64Decode('Cg9MYWJlbE5vZGVDb25maWcSEgoEdGV4dBgBIAEoCVIEdGV4dA==');
@$core.Deprecated('Use transportNodeConfigDescriptor instead')
const TransportNodeConfig$json = const {
  '1': 'TransportNodeConfig',
};

/// Descriptor for `TransportNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transportNodeConfigDescriptor = $convert.base64Decode('ChNUcmFuc3BvcnROb2RlQ29uZmln');
@$core.Deprecated('Use g13InputNodeConfigDescriptor instead')
const G13InputNodeConfig$json = const {
  '1': 'G13InputNodeConfig',
  '2': const [
    const {'1': 'device_id', '3': 1, '4': 1, '5': 9, '10': 'deviceId'},
    const {'1': 'key', '3': 2, '4': 1, '5': 14, '6': '.mizer.nodes.G13InputNodeConfig.Key', '10': 'key'},
  ],
  '4': const [G13InputNodeConfig_Key$json],
};

@$core.Deprecated('Use g13InputNodeConfigDescriptor instead')
const G13InputNodeConfig_Key$json = const {
  '1': 'Key',
  '2': const [
    const {'1': 'G1', '2': 0},
    const {'1': 'G2', '2': 1},
    const {'1': 'G3', '2': 2},
    const {'1': 'G4', '2': 3},
    const {'1': 'G5', '2': 4},
    const {'1': 'G6', '2': 5},
    const {'1': 'G7', '2': 6},
    const {'1': 'G8', '2': 7},
    const {'1': 'G9', '2': 8},
    const {'1': 'G10', '2': 9},
    const {'1': 'G11', '2': 10},
    const {'1': 'G12', '2': 11},
    const {'1': 'G13', '2': 12},
    const {'1': 'G14', '2': 13},
    const {'1': 'G15', '2': 14},
    const {'1': 'G16', '2': 15},
    const {'1': 'G17', '2': 16},
    const {'1': 'G18', '2': 17},
    const {'1': 'G19', '2': 18},
    const {'1': 'G20', '2': 19},
    const {'1': 'G21', '2': 20},
    const {'1': 'G22', '2': 21},
    const {'1': 'M1', '2': 22},
    const {'1': 'M2', '2': 23},
    const {'1': 'M3', '2': 24},
    const {'1': 'MR', '2': 25},
    const {'1': 'L1', '2': 26},
    const {'1': 'L2', '2': 27},
    const {'1': 'L3', '2': 28},
    const {'1': 'L4', '2': 29},
    const {'1': 'JOYSTICK_X', '2': 30},
    const {'1': 'JOYSTICK_Y', '2': 31},
    const {'1': 'JOYSTICK', '2': 32},
    const {'1': 'LEFT', '2': 33},
    const {'1': 'DOWN', '2': 34},
    const {'1': 'BD', '2': 35},
  ],
};

/// Descriptor for `G13InputNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List g13InputNodeConfigDescriptor = $convert.base64Decode('ChJHMTNJbnB1dE5vZGVDb25maWcSGwoJZGV2aWNlX2lkGAEgASgJUghkZXZpY2VJZBI1CgNrZXkYAiABKA4yIy5taXplci5ub2Rlcy5HMTNJbnB1dE5vZGVDb25maWcuS2V5UgNrZXkizAIKA0tleRIGCgJHMRAAEgYKAkcyEAESBgoCRzMQAhIGCgJHNBADEgYKAkc1EAQSBgoCRzYQBRIGCgJHNxAGEgYKAkc4EAcSBgoCRzkQCBIHCgNHMTAQCRIHCgNHMTEQChIHCgNHMTIQCxIHCgNHMTMQDBIHCgNHMTQQDRIHCgNHMTUQDhIHCgNHMTYQDxIHCgNHMTcQEBIHCgNHMTgQERIHCgNHMTkQEhIHCgNHMjAQExIHCgNHMjEQFBIHCgNHMjIQFRIGCgJNMRAWEgYKAk0yEBcSBgoCTTMQGBIGCgJNUhAZEgYKAkwxEBoSBgoCTDIQGxIGCgJMMxAcEgYKAkw0EB0SDgoKSk9ZU1RJQ0tfWBAeEg4KCkpPWVNUSUNLX1kQHxIMCghKT1lTVElDSxAgEggKBExFRlQQIRIICgRET1dOECISBgoCQkQQIw==');
@$core.Deprecated('Use g13OutputNodeConfigDescriptor instead')
const G13OutputNodeConfig$json = const {
  '1': 'G13OutputNodeConfig',
  '2': const [
    const {'1': 'device_id', '3': 1, '4': 1, '5': 9, '10': 'deviceId'},
  ],
};

/// Descriptor for `G13OutputNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List g13OutputNodeConfigDescriptor = $convert.base64Decode('ChNHMTNPdXRwdXROb2RlQ29uZmlnEhsKCWRldmljZV9pZBgBIAEoCVIIZGV2aWNlSWQ=');
@$core.Deprecated('Use constantNumberNodeConfigDescriptor instead')
const ConstantNumberNodeConfig$json = const {
  '1': 'ConstantNumberNodeConfig',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `ConstantNumberNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List constantNumberNodeConfigDescriptor = $convert.base64Decode('ChhDb25zdGFudE51bWJlck5vZGVDb25maWcSFAoFdmFsdWUYASABKAFSBXZhbHVl');
@$core.Deprecated('Use conditionalNodeConfigDescriptor instead')
const ConditionalNodeConfig$json = const {
  '1': 'ConditionalNodeConfig',
  '2': const [
    const {'1': 'threshold', '3': 1, '4': 1, '5': 1, '10': 'threshold'},
  ],
};

/// Descriptor for `ConditionalNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List conditionalNodeConfigDescriptor = $convert.base64Decode('ChVDb25kaXRpb25hbE5vZGVDb25maWcSHAoJdGhyZXNob2xkGAEgASgBUgl0aHJlc2hvbGQ=');
@$core.Deprecated('Use timecodeControlNodeConfigDescriptor instead')
const TimecodeControlNodeConfig$json = const {
  '1': 'TimecodeControlNodeConfig',
  '2': const [
    const {'1': 'timecode_id', '3': 1, '4': 1, '5': 13, '10': 'timecodeId'},
  ],
};

/// Descriptor for `TimecodeControlNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timecodeControlNodeConfigDescriptor = $convert.base64Decode('ChlUaW1lY29kZUNvbnRyb2xOb2RlQ29uZmlnEh8KC3RpbWVjb2RlX2lkGAEgASgNUgp0aW1lY29kZUlk');
@$core.Deprecated('Use timecodeOutputNodeConfigDescriptor instead')
const TimecodeOutputNodeConfig$json = const {
  '1': 'TimecodeOutputNodeConfig',
  '2': const [
    const {'1': 'control_id', '3': 1, '4': 1, '5': 13, '10': 'controlId'},
  ],
};

/// Descriptor for `TimecodeOutputNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timecodeOutputNodeConfigDescriptor = $convert.base64Decode('ChhUaW1lY29kZU91dHB1dE5vZGVDb25maWcSHQoKY29udHJvbF9pZBgBIAEoDVIJY29udHJvbElk');
@$core.Deprecated('Use audioFileNodeConfigDescriptor instead')
const AudioFileNodeConfig$json = const {
  '1': 'AudioFileNodeConfig',
  '2': const [
    const {'1': 'file', '3': 1, '4': 1, '5': 9, '10': 'file'},
    const {'1': 'playback_mode', '3': 2, '4': 1, '5': 14, '6': '.mizer.nodes.AudioFileNodeConfig.PlaybackMode', '10': 'playbackMode'},
  ],
  '4': const [AudioFileNodeConfig_PlaybackMode$json],
};

@$core.Deprecated('Use audioFileNodeConfigDescriptor instead')
const AudioFileNodeConfig_PlaybackMode$json = const {
  '1': 'PlaybackMode',
  '2': const [
    const {'1': 'ONE_SHOT', '2': 0},
    const {'1': 'LOOP', '2': 1},
    const {'1': 'PING_PONG', '2': 2},
  ],
};

/// Descriptor for `AudioFileNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioFileNodeConfigDescriptor = $convert.base64Decode('ChNBdWRpb0ZpbGVOb2RlQ29uZmlnEhIKBGZpbGUYASABKAlSBGZpbGUSUgoNcGxheWJhY2tfbW9kZRgCIAEoDjItLm1pemVyLm5vZGVzLkF1ZGlvRmlsZU5vZGVDb25maWcuUGxheWJhY2tNb2RlUgxwbGF5YmFja01vZGUiNQoMUGxheWJhY2tNb2RlEgwKCE9ORV9TSE9UEAASCAoETE9PUBABEg0KCVBJTkdfUE9ORxAC');
@$core.Deprecated('Use audioOutputNodeConfigDescriptor instead')
const AudioOutputNodeConfig$json = const {
  '1': 'AudioOutputNodeConfig',
};

/// Descriptor for `AudioOutputNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioOutputNodeConfigDescriptor = $convert.base64Decode('ChVBdWRpb091dHB1dE5vZGVDb25maWc=');
@$core.Deprecated('Use audioVolumeNodeConfigDescriptor instead')
const AudioVolumeNodeConfig$json = const {
  '1': 'AudioVolumeNodeConfig',
};

/// Descriptor for `AudioVolumeNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioVolumeNodeConfigDescriptor = $convert.base64Decode('ChVBdWRpb1ZvbHVtZU5vZGVDb25maWc=');
@$core.Deprecated('Use audioInputNodeConfigDescriptor instead')
const AudioInputNodeConfig$json = const {
  '1': 'AudioInputNodeConfig',
};

/// Descriptor for `AudioInputNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioInputNodeConfigDescriptor = $convert.base64Decode('ChRBdWRpb0lucHV0Tm9kZUNvbmZpZw==');
@$core.Deprecated('Use audioMixNodeConfigDescriptor instead')
const AudioMixNodeConfig$json = const {
  '1': 'AudioMixNodeConfig',
};

/// Descriptor for `AudioMixNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioMixNodeConfigDescriptor = $convert.base64Decode('ChJBdWRpb01peE5vZGVDb25maWc=');
@$core.Deprecated('Use audioMeterNodeConfigDescriptor instead')
const AudioMeterNodeConfig$json = const {
  '1': 'AudioMeterNodeConfig',
};

/// Descriptor for `AudioMeterNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioMeterNodeConfigDescriptor = $convert.base64Decode('ChRBdWRpb01ldGVyTm9kZUNvbmZpZw==');
@$core.Deprecated('Use nodePositionDescriptor instead')
const NodePosition$json = const {
  '1': 'NodePosition',
  '2': const [
    const {'1': 'x', '3': 1, '4': 1, '5': 1, '10': 'x'},
    const {'1': 'y', '3': 2, '4': 1, '5': 1, '10': 'y'},
  ],
};

/// Descriptor for `NodePosition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodePositionDescriptor = $convert.base64Decode('CgxOb2RlUG9zaXRpb24SDAoBeBgBIAEoAVIBeBIMCgF5GAIgASgBUgF5');
@$core.Deprecated('Use nodeDesignerDescriptor instead')
const NodeDesigner$json = const {
  '1': 'NodeDesigner',
  '2': const [
    const {'1': 'position', '3': 1, '4': 1, '5': 11, '6': '.mizer.nodes.NodePosition', '10': 'position'},
    const {'1': 'scale', '3': 2, '4': 1, '5': 1, '10': 'scale'},
    const {'1': 'hidden', '3': 3, '4': 1, '5': 8, '10': 'hidden'},
  ],
};

/// Descriptor for `NodeDesigner`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDesignerDescriptor = $convert.base64Decode('CgxOb2RlRGVzaWduZXISNQoIcG9zaXRpb24YASABKAsyGS5taXplci5ub2Rlcy5Ob2RlUG9zaXRpb25SCHBvc2l0aW9uEhQKBXNjYWxlGAIgASgBUgVzY2FsZRIWCgZoaWRkZW4YAyABKAhSBmhpZGRlbg==');
@$core.Deprecated('Use portDescriptor instead')
const Port$json = const {
  '1': 'Port',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'protocol', '3': 2, '4': 1, '5': 14, '6': '.mizer.nodes.ChannelProtocol', '10': 'protocol'},
    const {'1': 'multiple', '3': 3, '4': 1, '5': 8, '10': 'multiple'},
  ],
};

/// Descriptor for `Port`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portDescriptor = $convert.base64Decode('CgRQb3J0EhIKBG5hbWUYASABKAlSBG5hbWUSOAoIcHJvdG9jb2wYAiABKA4yHC5taXplci5ub2Rlcy5DaGFubmVsUHJvdG9jb2xSCHByb3RvY29sEhoKCG11bHRpcGxlGAMgASgIUghtdWx0aXBsZQ==');
