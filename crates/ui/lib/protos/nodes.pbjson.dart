///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use nodeCategoryDescriptor instead')
const NodeCategory$json = const {
  '1': 'NodeCategory',
  '2': const [
    const {'1': 'NODE_CATEGORY_NONE', '2': 0},
    const {'1': 'NODE_CATEGORY_STANDARD', '2': 1},
    const {'1': 'NODE_CATEGORY_CONNECTIONS', '2': 2},
    const {'1': 'NODE_CATEGORY_CONVERSIONS', '2': 3},
    const {'1': 'NODE_CATEGORY_CONTROLS', '2': 4},
    const {'1': 'NODE_CATEGORY_DATA', '2': 5},
    const {'1': 'NODE_CATEGORY_COLOR', '2': 6},
    const {'1': 'NODE_CATEGORY_AUDIO', '2': 7},
    const {'1': 'NODE_CATEGORY_VIDEO', '2': 8},
    const {'1': 'NODE_CATEGORY_LASER', '2': 9},
    const {'1': 'NODE_CATEGORY_PIXEL', '2': 10},
  ],
};

/// Descriptor for `NodeCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List nodeCategoryDescriptor = $convert.base64Decode('CgxOb2RlQ2F0ZWdvcnkSFgoSTk9ERV9DQVRFR09SWV9OT05FEAASGgoWTk9ERV9DQVRFR09SWV9TVEFOREFSRBABEh0KGU5PREVfQ0FURUdPUllfQ09OTkVDVElPTlMQAhIdChlOT0RFX0NBVEVHT1JZX0NPTlZFUlNJT05TEAMSGgoWTk9ERV9DQVRFR09SWV9DT05UUk9MUxAEEhYKEk5PREVfQ0FURUdPUllfREFUQRAFEhcKE05PREVfQ0FURUdPUllfQ09MT1IQBhIXChNOT0RFX0NBVEVHT1JZX0FVRElPEAcSFwoTTk9ERV9DQVRFR09SWV9WSURFTxAIEhcKE05PREVfQ0FURUdPUllfTEFTRVIQCRIXChNOT0RFX0NBVEVHT1JZX1BJWEVMEAo=');
@$core.Deprecated('Use channelProtocolDescriptor instead')
const ChannelProtocol$json = const {
  '1': 'ChannelProtocol',
  '2': const [
    const {'1': 'SINGLE', '2': 0},
    const {'1': 'MULTI', '2': 1},
    const {'1': 'TEXTURE', '2': 2},
    const {'1': 'VECTOR', '2': 3},
    const {'1': 'LASER', '2': 4},
    const {'1': 'POLY', '2': 5},
    const {'1': 'DATA', '2': 6},
    const {'1': 'MATERIAL', '2': 7},
    const {'1': 'POSITION', '2': 8},
    const {'1': 'COLOR', '2': 9},
    const {'1': 'CLOCK', '2': 10},
  ],
};

/// Descriptor for `ChannelProtocol`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelProtocolDescriptor = $convert.base64Decode('Cg9DaGFubmVsUHJvdG9jb2wSCgoGU0lOR0xFEAASCQoFTVVMVEkQARILCgdURVhUVVJFEAISCgoGVkVDVE9SEAMSCQoFTEFTRVIQBBIICgRQT0xZEAUSCAoEREFUQRAGEgwKCE1BVEVSSUFMEAcSDAoIUE9TSVRJT04QCBIJCgVDT0xPUhAJEgkKBUNMT0NLEAo=');
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
@$core.Deprecated('Use updateNodeSettingRequestDescriptor instead')
const UpdateNodeSettingRequest$json = const {
  '1': 'UpdateNodeSettingRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'setting', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting', '10': 'setting'},
  ],
};

/// Descriptor for `UpdateNodeSettingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNodeSettingRequestDescriptor = $convert.base64Decode('ChhVcGRhdGVOb2RlU2V0dGluZ1JlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aBIyCgdzZXR0aW5nGAIgASgLMhgubWl6ZXIubm9kZXMuTm9kZVNldHRpbmdSB3NldHRpbmc=');
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
@$core.Deprecated('Use availableNodesDescriptor instead')
const AvailableNodes$json = const {
  '1': 'AvailableNodes',
  '2': const [
    const {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.AvailableNode', '10': 'nodes'},
  ],
};

/// Descriptor for `AvailableNodes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List availableNodesDescriptor = $convert.base64Decode('Cg5BdmFpbGFibGVOb2RlcxIwCgVub2RlcxgBIAMoCzIaLm1pemVyLm5vZGVzLkF2YWlsYWJsZU5vZGVSBW5vZGVz');
@$core.Deprecated('Use availableNodeDescriptor instead')
const AvailableNode$json = const {
  '1': 'AvailableNode',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.nodes.Node.NodeType', '10': 'type'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'category', '3': 3, '4': 1, '5': 14, '6': '.mizer.nodes.NodeCategory', '10': 'category'},
  ],
};

/// Descriptor for `AvailableNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List availableNodeDescriptor = $convert.base64Decode('Cg1BdmFpbGFibGVOb2RlEi4KBHR5cGUYASABKA4yGi5taXplci5ub2Rlcy5Ob2RlLk5vZGVUeXBlUgR0eXBlEhIKBG5hbWUYAiABKAlSBG5hbWUSNQoIY2F0ZWdvcnkYAyABKA4yGS5taXplci5ub2Rlcy5Ob2RlQ2F0ZWdvcnlSCGNhdGVnb3J5');
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
    const {'1': 'settings', '3': 8, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting', '10': 'settings'},
    const {'1': 'details', '3': 9, '4': 1, '5': 11, '6': '.mizer.nodes.NodeDetails', '10': 'details'},
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
    const {'1': 'STEP_SEQUENCER', '2': 6},
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
    const {'1': 'VIDEO_HSV', '2': 23},
    const {'1': 'VIDEO_TRANSFORM', '2': 24},
    const {'1': 'VIDEO_MIXER', '2': 25},
    const {'1': 'VIDEO_RGB', '2': 26},
    const {'1': 'VIDEO_RGB_SPLIT', '2': 27},
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
    const {'1': 'WEBCAM', '2': 82},
    const {'1': 'TEXTURE_BORDER', '2': 83},
    const {'1': 'VIDEO_TEXT', '2': 84},
    const {'1': 'BEATS', '2': 85},
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
final $typed_data.Uint8List nodeDescriptor = $convert.base64Decode('CgROb2RlEi4KBHR5cGUYASABKA4yGi5taXplci5ub2Rlcy5Ob2RlLk5vZGVUeXBlUgR0eXBlEhIKBHBhdGgYAiABKAlSBHBhdGgSKQoGaW5wdXRzGAMgAygLMhEubWl6ZXIubm9kZXMuUG9ydFIGaW5wdXRzEisKB291dHB1dHMYBCADKAsyES5taXplci5ub2Rlcy5Qb3J0UgdvdXRwdXRzEjUKCGRlc2lnbmVyGAUgASgLMhkubWl6ZXIubm9kZXMuTm9kZURlc2lnbmVyUghkZXNpZ25lchI7CgdwcmV2aWV3GAYgASgOMiEubWl6ZXIubm9kZXMuTm9kZS5Ob2RlUHJldmlld1R5cGVSB3ByZXZpZXcSLwoGY29uZmlnGAcgASgLMhcubWl6ZXIubm9kZXMuTm9kZUNvbmZpZ1IGY29uZmlnEjQKCHNldHRpbmdzGAggAygLMhgubWl6ZXIubm9kZXMuTm9kZVNldHRpbmdSCHNldHRpbmdzEjIKB2RldGFpbHMYCSABKAsyGC5taXplci5ub2Rlcy5Ob2RlRGV0YWlsc1IHZGV0YWlscyKwCAoITm9kZVR5cGUSCQoFRkFERVIQABIKCgZCVVRUT04QARIOCgpPU0NJTExBVE9SEAISCQoFQ0xPQ0sQAxIKCgZTQ1JJUFQQBBIMCghFTlZFTE9QRRAFEhIKDlNURVBfU0VRVUVOQ0VSEAYSCgoGU0VMRUNUEAcSCQoFTUVSR0UQCBINCglUSFJFU0hPTEQQCRIOCgpETVhfT1VUUFVUEAoSDQoJT1NDX0lOUFVUEAsSDgoKT1NDX09VVFBVVBAMEg4KCk1JRElfSU5QVVQQDRIPCgtNSURJX09VVFBVVBAOEg0KCVNFUVVFTkNFUhAPEgsKB0ZJWFRVUkUQEBIOCgpQUk9HUkFNTUVSEBESCQoFR1JPVVAQEhIKCgZQUkVTRVQQExIOCgpWSURFT19GSUxFEBQSEAoMVklERU9fT1VUUFVUEBUSDQoJVklERU9fSFNWEBcSEwoPVklERU9fVFJBTlNGT1JNEBgSDwoLVklERU9fTUlYRVIQGRINCglWSURFT19SR0IQGhITCg9WSURFT19SR0JfU1BMSVQQGxIQCgxQSVhFTF9UT19ETVgQHhIRCg1QSVhFTF9QQVRURVJOEB8SDgoKT1BDX09VVFBVVBAgEgkKBUxBU0VSECgSDQoJSUxEQV9GSUxFECkSCwoHR0FNRVBBRBAtEg0KCUNPTE9SX1JHQhAyEg0KCUNPTE9SX0hTVhAzEhIKDkNPTE9SX0NPTlNUQU5UEDQSFAoQQ09MT1JfQlJJR0hUTkVTUxA1EgsKB0VOQ09ERVIQNxIICgRNQVRIEDgSEgoOREFUQV9UT19OVU1CRVIQORISCg5OVU1CRVJfVE9fREFUQRA6EgkKBVZBTFVFEDsSCwoHRVhUUkFDVBA8Eg4KCk1RVFRfSU5QVVQQPRIPCgtNUVRUX09VVFBVVBA+Eg8KC1BMQU5fU0NSRUVOED8SCQoFREVMQVkQQBIICgRSQU1QEEESCQoFTk9JU0UQQhIJCgVMQUJFTBBDEg0KCVRSQU5TUE9SVBBEEgwKCEcxM0lOUFVUEEUSDQoJRzEzT1VUUFVUEEYSEwoPQ09OU1RBTlRfTlVNQkVSEEcSDwoLQ09ORElUSU9OQUwQSBIUChBUSU1FQ09ERV9DT05UUk9MEEkSEwoPVElNRUNPREVfT1VUUFVUEEoSDgoKQVVESU9fRklMRRBLEhAKDEFVRElPX09VVFBVVBBMEhAKDEFVRElPX1ZPTFVNRRBNEg8KC0FVRElPX0lOUFVUEE4SDQoJQVVESU9fTUlYEE8SDwoLQVVESU9fTUVURVIQUBIMCghURU1QTEFURRBREgoKBldFQkNBTRBSEhIKDlRFWFRVUkVfQk9SREVSEFMSDgoKVklERU9fVEVYVBBUEgkKBUJFQVRTEFUSDQoJQ09OVEFJTkVSEGQidAoPTm9kZVByZXZpZXdUeXBlEggKBE5PTkUQABILCgdISVNUT1JZEAESDAoIV0FWRUZPUk0QAhIMCghNVUxUSVBMRRADEgsKB1RFWFRVUkUQBBIMCghUSU1FQ09ERRAFEggKBERBVEEQBhIJCgVDT0xPUhAH');
@$core.Deprecated('Use nodeDetailsDescriptor instead')
const NodeDetails$json = const {
  '1': 'NodeDetails',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'category', '3': 2, '4': 1, '5': 14, '6': '.mizer.nodes.NodeCategory', '10': 'category'},
  ],
};

/// Descriptor for `NodeDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDetailsDescriptor = $convert.base64Decode('CgtOb2RlRGV0YWlscxISCgRuYW1lGAEgASgJUgRuYW1lEjUKCGNhdGVnb3J5GAIgASgOMhkubWl6ZXIubm9kZXMuTm9kZUNhdGVnb3J5UghjYXRlZ29yeQ==');
@$core.Deprecated('Use nodeConfigDescriptor instead')
const NodeConfig$json = const {
  '1': 'NodeConfig',
  '2': const [
    const {'1': 'container_config', '3': 45, '4': 1, '5': 11, '6': '.mizer.nodes.ContainerNodeConfig', '9': 0, '10': 'containerConfig'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `NodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeConfigDescriptor = $convert.base64Decode('CgpOb2RlQ29uZmlnEk0KEGNvbnRhaW5lcl9jb25maWcYLSABKAsyIC5taXplci5ub2Rlcy5Db250YWluZXJOb2RlQ29uZmlnSABSD2NvbnRhaW5lckNvbmZpZ0IGCgR0eXBl');
@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting$json = const {
  '1': 'NodeSetting',
  '2': const [
    const {'1': 'label', '3': 1, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'disabled', '3': 3, '4': 1, '5': 8, '10': 'disabled'},
    const {'1': 'text', '3': 4, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.TextValue', '9': 0, '10': 'text'},
    const {'1': 'float', '3': 5, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.FloatValue', '9': 0, '10': 'float'},
    const {'1': 'int', '3': 6, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.IntValue', '9': 0, '10': 'int'},
    const {'1': 'bool', '3': 7, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.BoolValue', '9': 0, '10': 'bool'},
    const {'1': 'select', '3': 8, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.SelectValue', '9': 0, '10': 'select'},
    const {'1': 'enum', '3': 9, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.EnumValue', '9': 0, '10': 'enum'},
    const {'1': 'id', '3': 10, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.IdValue', '9': 0, '10': 'id'},
    const {'1': 'spline', '3': 11, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.SplineValue', '9': 0, '10': 'spline'},
    const {'1': 'media', '3': 12, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.MediaValue', '9': 0, '10': 'media'},
    const {'1': 'uint', '3': 13, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.UintValue', '9': 0, '10': 'uint'},
    const {'1': 'step_sequencer', '3': 14, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.StepSequencerValue', '9': 0, '10': 'stepSequencer'},
  ],
  '3': const [NodeSetting_TextValue$json, NodeSetting_FloatValue$json, NodeSetting_IntValue$json, NodeSetting_UintValue$json, NodeSetting_BoolValue$json, NodeSetting_SelectValue$json, NodeSetting_SelectVariant$json, NodeSetting_EnumValue$json, NodeSetting_EnumVariant$json, NodeSetting_IdValue$json, NodeSetting_IdVariant$json, NodeSetting_SplineValue$json, NodeSetting_MediaValue$json, NodeSetting_StepSequencerValue$json],
  '8': const [
    const {'1': 'value'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_TextValue$json = const {
  '1': 'TextValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    const {'1': 'multiline', '3': 2, '4': 1, '5': 8, '10': 'multiline'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_FloatValue$json = const {
  '1': 'FloatValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'min', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'min', '17': true},
    const {'1': 'min_hint', '3': 3, '4': 1, '5': 1, '9': 1, '10': 'minHint', '17': true},
    const {'1': 'max', '3': 4, '4': 1, '5': 1, '9': 2, '10': 'max', '17': true},
    const {'1': 'max_hint', '3': 5, '4': 1, '5': 1, '9': 3, '10': 'maxHint', '17': true},
  ],
  '8': const [
    const {'1': '_min'},
    const {'1': '_min_hint'},
    const {'1': '_max'},
    const {'1': '_max_hint'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_IntValue$json = const {
  '1': 'IntValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 5, '10': 'value'},
    const {'1': 'min', '3': 2, '4': 1, '5': 5, '9': 0, '10': 'min', '17': true},
    const {'1': 'min_hint', '3': 3, '4': 1, '5': 5, '9': 1, '10': 'minHint', '17': true},
    const {'1': 'max', '3': 4, '4': 1, '5': 5, '9': 2, '10': 'max', '17': true},
    const {'1': 'max_hint', '3': 5, '4': 1, '5': 5, '9': 3, '10': 'maxHint', '17': true},
  ],
  '8': const [
    const {'1': '_min'},
    const {'1': '_min_hint'},
    const {'1': '_max'},
    const {'1': '_max_hint'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_UintValue$json = const {
  '1': 'UintValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
    const {'1': 'min', '3': 2, '4': 1, '5': 13, '9': 0, '10': 'min', '17': true},
    const {'1': 'min_hint', '3': 3, '4': 1, '5': 13, '9': 1, '10': 'minHint', '17': true},
    const {'1': 'max', '3': 4, '4': 1, '5': 13, '9': 2, '10': 'max', '17': true},
    const {'1': 'max_hint', '3': 5, '4': 1, '5': 13, '9': 3, '10': 'maxHint', '17': true},
  ],
  '8': const [
    const {'1': '_min'},
    const {'1': '_min_hint'},
    const {'1': '_max'},
    const {'1': '_max_hint'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_BoolValue$json = const {
  '1': 'BoolValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 8, '10': 'value'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_SelectValue$json = const {
  '1': 'SelectValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    const {'1': 'variants', '3': 2, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting.SelectVariant', '10': 'variants'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_SelectVariant$json = const {
  '1': 'SelectVariant',
  '2': const [
    const {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.SelectVariant.SelectGroup', '9': 0, '10': 'group'},
    const {'1': 'item', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.SelectVariant.SelectItem', '9': 0, '10': 'item'},
  ],
  '3': const [NodeSetting_SelectVariant_SelectGroup$json, NodeSetting_SelectVariant_SelectItem$json],
  '8': const [
    const {'1': 'variant'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_SelectVariant_SelectGroup$json = const {
  '1': 'SelectGroup',
  '2': const [
    const {'1': 'label', '3': 1, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting.SelectVariant', '10': 'items'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_SelectVariant_SelectItem$json = const {
  '1': 'SelectItem',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    const {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_EnumValue$json = const {
  '1': 'EnumValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
    const {'1': 'variants', '3': 2, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting.EnumVariant', '10': 'variants'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_EnumVariant$json = const {
  '1': 'EnumVariant',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
    const {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_IdValue$json = const {
  '1': 'IdValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
    const {'1': 'variants', '3': 2, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting.IdVariant', '10': 'variants'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_IdVariant$json = const {
  '1': 'IdVariant',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
    const {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_SplineValue$json = const {
  '1': 'SplineValue',
  '2': const [
    const {'1': 'steps', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting.SplineValue.SplineStep', '10': 'steps'},
  ],
  '3': const [NodeSetting_SplineValue_SplineStep$json],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_SplineValue_SplineStep$json = const {
  '1': 'SplineStep',
  '2': const [
    const {'1': 'x', '3': 1, '4': 1, '5': 1, '10': 'x'},
    const {'1': 'y', '3': 2, '4': 1, '5': 1, '10': 'y'},
    const {'1': 'c0a', '3': 3, '4': 1, '5': 1, '10': 'c0a'},
    const {'1': 'c0b', '3': 4, '4': 1, '5': 1, '10': 'c0b'},
    const {'1': 'c1a', '3': 5, '4': 1, '5': 1, '10': 'c1a'},
    const {'1': 'c1b', '3': 6, '4': 1, '5': 1, '10': 'c1b'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_MediaValue$json = const {
  '1': 'MediaValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    const {'1': 'allowed_types', '3': 2, '4': 3, '5': 14, '6': '.mizer.media.MediaType', '10': 'allowedTypes'},
  ],
};

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting_StepSequencerValue$json = const {
  '1': 'StepSequencerValue',
  '2': const [
    const {'1': 'steps', '3': 1, '4': 3, '5': 8, '10': 'steps'},
  ],
};

/// Descriptor for `NodeSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeSettingDescriptor = $convert.base64Decode('CgtOb2RlU2V0dGluZxIUCgVsYWJlbBgBIAEoCVIFbGFiZWwSIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uEhoKCGRpc2FibGVkGAMgASgIUghkaXNhYmxlZBI4CgR0ZXh0GAQgASgLMiIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuVGV4dFZhbHVlSABSBHRleHQSOwoFZmxvYXQYBSABKAsyIy5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5GbG9hdFZhbHVlSABSBWZsb2F0EjUKA2ludBgGIAEoCzIhLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLkludFZhbHVlSABSA2ludBI4CgRib29sGAcgASgLMiIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuQm9vbFZhbHVlSABSBGJvb2wSPgoGc2VsZWN0GAggASgLMiQubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuU2VsZWN0VmFsdWVIAFIGc2VsZWN0EjgKBGVudW0YCSABKAsyIi5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5FbnVtVmFsdWVIAFIEZW51bRIyCgJpZBgKIAEoCzIgLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLklkVmFsdWVIAFICaWQSPgoGc3BsaW5lGAsgASgLMiQubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuU3BsaW5lVmFsdWVIAFIGc3BsaW5lEjsKBW1lZGlhGAwgASgLMiMubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuTWVkaWFWYWx1ZUgAUgVtZWRpYRI4CgR1aW50GA0gASgLMiIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuVWludFZhbHVlSABSBHVpbnQSVAoOc3RlcF9zZXF1ZW5jZXIYDiABKAsyKy5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5TdGVwU2VxdWVuY2VyVmFsdWVIAFINc3RlcFNlcXVlbmNlcho/CglUZXh0VmFsdWUSFAoFdmFsdWUYASABKAlSBXZhbHVlEhwKCW11bHRpbGluZRgCIAEoCFIJbXVsdGlsaW5lGroBCgpGbG9hdFZhbHVlEhQKBXZhbHVlGAEgASgBUgV2YWx1ZRIVCgNtaW4YAiABKAFIAFIDbWluiAEBEh4KCG1pbl9oaW50GAMgASgBSAFSB21pbkhpbnSIAQESFQoDbWF4GAQgASgBSAJSA21heIgBARIeCghtYXhfaGludBgFIAEoAUgDUgdtYXhIaW50iAEBQgYKBF9taW5CCwoJX21pbl9oaW50QgYKBF9tYXhCCwoJX21heF9oaW50GrgBCghJbnRWYWx1ZRIUCgV2YWx1ZRgBIAEoBVIFdmFsdWUSFQoDbWluGAIgASgFSABSA21pbogBARIeCghtaW5faGludBgDIAEoBUgBUgdtaW5IaW50iAEBEhUKA21heBgEIAEoBUgCUgNtYXiIAQESHgoIbWF4X2hpbnQYBSABKAVIA1IHbWF4SGludIgBAUIGCgRfbWluQgsKCV9taW5faGludEIGCgRfbWF4QgsKCV9tYXhfaGludBq5AQoJVWludFZhbHVlEhQKBXZhbHVlGAEgASgNUgV2YWx1ZRIVCgNtaW4YAiABKA1IAFIDbWluiAEBEh4KCG1pbl9oaW50GAMgASgNSAFSB21pbkhpbnSIAQESFQoDbWF4GAQgASgNSAJSA21heIgBARIeCghtYXhfaGludBgFIAEoDUgDUgdtYXhIaW50iAEBQgYKBF9taW5CCwoJX21pbl9oaW50QgYKBF9tYXhCCwoJX21heF9oaW50GiEKCUJvb2xWYWx1ZRIUCgV2YWx1ZRgBIAEoCFIFdmFsdWUaZwoLU2VsZWN0VmFsdWUSFAoFdmFsdWUYASABKAlSBXZhbHVlEkIKCHZhcmlhbnRzGAIgAygLMiYubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuU2VsZWN0VmFyaWFudFIIdmFyaWFudHMazAIKDVNlbGVjdFZhcmlhbnQSSgoFZ3JvdXAYASABKAsyMi5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5TZWxlY3RWYXJpYW50LlNlbGVjdEdyb3VwSABSBWdyb3VwEkcKBGl0ZW0YAiABKAsyMS5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5TZWxlY3RWYXJpYW50LlNlbGVjdEl0ZW1IAFIEaXRlbRphCgtTZWxlY3RHcm91cBIUCgVsYWJlbBgBIAEoCVIFbGFiZWwSPAoFaXRlbXMYAiADKAsyJi5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5TZWxlY3RWYXJpYW50UgVpdGVtcxo4CgpTZWxlY3RJdGVtEhQKBXZhbHVlGAEgASgJUgV2YWx1ZRIUCgVsYWJlbBgCIAEoCVIFbGFiZWxCCQoHdmFyaWFudBpjCglFbnVtVmFsdWUSFAoFdmFsdWUYASABKA1SBXZhbHVlEkAKCHZhcmlhbnRzGAIgAygLMiQubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuRW51bVZhcmlhbnRSCHZhcmlhbnRzGjkKC0VudW1WYXJpYW50EhQKBXZhbHVlGAEgASgNUgV2YWx1ZRIUCgVsYWJlbBgCIAEoCVIFbGFiZWwaXwoHSWRWYWx1ZRIUCgV2YWx1ZRgBIAEoDVIFdmFsdWUSPgoIdmFyaWFudHMYAiADKAsyIi5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5JZFZhcmlhbnRSCHZhcmlhbnRzGjcKCUlkVmFyaWFudBIUCgV2YWx1ZRgBIAEoDVIFdmFsdWUSFAoFbGFiZWwYAiABKAlSBWxhYmVsGsYBCgtTcGxpbmVWYWx1ZRJFCgVzdGVwcxgBIAMoCzIvLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLlNwbGluZVZhbHVlLlNwbGluZVN0ZXBSBXN0ZXBzGnAKClNwbGluZVN0ZXASDAoBeBgBIAEoAVIBeBIMCgF5GAIgASgBUgF5EhAKA2MwYRgDIAEoAVIDYzBhEhAKA2MwYhgEIAEoAVIDYzBiEhAKA2MxYRgFIAEoAVIDYzFhEhAKA2MxYhgGIAEoAVIDYzFiGl8KCk1lZGlhVmFsdWUSFAoFdmFsdWUYASABKAlSBXZhbHVlEjsKDWFsbG93ZWRfdHlwZXMYAiADKA4yFi5taXplci5tZWRpYS5NZWRpYVR5cGVSDGFsbG93ZWRUeXBlcxoqChJTdGVwU2VxdWVuY2VyVmFsdWUSFAoFc3RlcHMYASADKAhSBXN0ZXBzQgcKBXZhbHVl');
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
@$core.Deprecated('Use containerNodeConfigDescriptor instead')
const ContainerNodeConfig$json = const {
  '1': 'ContainerNodeConfig',
  '2': const [
    const {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.Node', '10': 'nodes'},
  ],
};

/// Descriptor for `ContainerNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List containerNodeConfigDescriptor = $convert.base64Decode('ChNDb250YWluZXJOb2RlQ29uZmlnEicKBW5vZGVzGAEgAygLMhEubWl6ZXIubm9kZXMuTm9kZVIFbm9kZXM=');
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
