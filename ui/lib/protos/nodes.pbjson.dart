///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

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
  ],
};

/// Descriptor for `ChannelProtocol`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelProtocolDescriptor = $convert.base64Decode('Cg9DaGFubmVsUHJvdG9jb2wSCgoGU0lOR0xFEAASCQoFTVVMVEkQARIJCgVDT0xPUhAJEgsKB1RFWFRVUkUQAhIKCgZWRUNUT1IQAxIJCgVMQVNFUhAEEggKBFBPTFkQBRIICgREQVRBEAYSDAoITUFURVJJQUwQBxIHCgNHU1QQCA==');
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
    const {'1': 'targetNode', '3': 1, '4': 1, '5': 9, '10': 'targetNode'},
    const {'1': 'targetPort', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.Port', '10': 'targetPort'},
    const {'1': 'sourceNode', '3': 3, '4': 1, '5': 9, '10': 'sourceNode'},
    const {'1': 'sourcePort', '3': 4, '4': 1, '5': 11, '6': '.mizer.nodes.Port', '10': 'sourcePort'},
    const {'1': 'protocol', '3': 5, '4': 1, '5': 14, '6': '.mizer.nodes.ChannelProtocol', '10': 'protocol'},
  ],
};

/// Descriptor for `NodeConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeConnectionDescriptor = $convert.base64Decode('Cg5Ob2RlQ29ubmVjdGlvbhIeCgp0YXJnZXROb2RlGAEgASgJUgp0YXJnZXROb2RlEjEKCnRhcmdldFBvcnQYAiABKAsyES5taXplci5ub2Rlcy5Qb3J0Ugp0YXJnZXRQb3J0Eh4KCnNvdXJjZU5vZGUYAyABKAlSCnNvdXJjZU5vZGUSMQoKc291cmNlUG9ydBgEIAEoCzIRLm1pemVyLm5vZGVzLlBvcnRSCnNvdXJjZVBvcnQSOAoIcHJvdG9jb2wYBSABKA4yHC5taXplci5ub2Rlcy5DaGFubmVsUHJvdG9jb2xSCHByb3RvY29s');
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
    const {'1': 'Fader', '2': 0},
    const {'1': 'Button', '2': 1},
    const {'1': 'Oscillator', '2': 2},
    const {'1': 'Clock', '2': 3},
    const {'1': 'Script', '2': 4},
    const {'1': 'Envelope', '2': 5},
    const {'1': 'Sequence', '2': 6},
    const {'1': 'Select', '2': 7},
    const {'1': 'Merge', '2': 8},
    const {'1': 'Threshold', '2': 9},
    const {'1': 'DmxOutput', '2': 10},
    const {'1': 'OscInput', '2': 11},
    const {'1': 'OscOutput', '2': 12},
    const {'1': 'MidiInput', '2': 13},
    const {'1': 'MidiOutput', '2': 14},
    const {'1': 'Sequencer', '2': 15},
    const {'1': 'Fixture', '2': 16},
    const {'1': 'Programmer', '2': 17},
    const {'1': 'Group', '2': 18},
    const {'1': 'Preset', '2': 19},
    const {'1': 'VideoFile', '2': 20},
    const {'1': 'VideoOutput', '2': 21},
    const {'1': 'VideoEffect', '2': 22},
    const {'1': 'VideoColorBalance', '2': 23},
    const {'1': 'VideoTransform', '2': 24},
    const {'1': 'PixelToDmx', '2': 30},
    const {'1': 'PixelPattern', '2': 31},
    const {'1': 'OpcOutput', '2': 32},
    const {'1': 'Laser', '2': 40},
    const {'1': 'IldaFile', '2': 41},
    const {'1': 'Gamepad', '2': 45},
    const {'1': 'ColorRgb', '2': 50},
    const {'1': 'ColorHsv', '2': 51},
    const {'1': 'Container', '2': 100},
    const {'1': 'Encoder', '2': 55},
    const {'1': 'Math', '2': 56},
    const {'1': 'DataToNumber', '2': 57},
    const {'1': 'NumberToData', '2': 58},
    const {'1': 'Value', '2': 59},
    const {'1': 'MqttInput', '2': 60},
    const {'1': 'MqttOutput', '2': 61},
    const {'1': 'PlanScreen', '2': 62},
    const {'1': 'Delay', '2': 63},
    const {'1': 'Ramp', '2': 64},
    const {'1': 'Noise', '2': 65},
    const {'1': 'Label', '2': 66},
    const {'1': 'Transport', '2': 67},
    const {'1': 'G13Input', '2': 68},
    const {'1': 'G13Output', '2': 69},
    const {'1': 'ConstantNumber', '2': 70},
    const {'1': 'Conditional', '2': 71},
  ],
};

@$core.Deprecated('Use nodeDescriptor instead')
const Node_NodePreviewType$json = const {
  '1': 'NodePreviewType',
  '2': const [
    const {'1': 'History', '2': 0},
    const {'1': 'Waveform', '2': 1},
    const {'1': 'Multiple', '2': 2},
    const {'1': 'Texture', '2': 3},
    const {'1': 'None', '2': 4},
  ],
};

/// Descriptor for `Node`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDescriptor = $convert.base64Decode('CgROb2RlEi4KBHR5cGUYASABKA4yGi5taXplci5ub2Rlcy5Ob2RlLk5vZGVUeXBlUgR0eXBlEhIKBHBhdGgYAiABKAlSBHBhdGgSKQoGaW5wdXRzGAMgAygLMhEubWl6ZXIubm9kZXMuUG9ydFIGaW5wdXRzEisKB291dHB1dHMYBCADKAsyES5taXplci5ub2Rlcy5Qb3J0UgdvdXRwdXRzEjUKCGRlc2lnbmVyGAUgASgLMhkubWl6ZXIubm9kZXMuTm9kZURlc2lnbmVyUghkZXNpZ25lchI7CgdwcmV2aWV3GAYgASgOMiEubWl6ZXIubm9kZXMuTm9kZS5Ob2RlUHJldmlld1R5cGVSB3ByZXZpZXcSLwoGY29uZmlnGAcgASgLMhcubWl6ZXIubm9kZXMuTm9kZUNvbmZpZ1IGY29uZmlnIucFCghOb2RlVHlwZRIJCgVGYWRlchAAEgoKBkJ1dHRvbhABEg4KCk9zY2lsbGF0b3IQAhIJCgVDbG9jaxADEgoKBlNjcmlwdBAEEgwKCEVudmVsb3BlEAUSDAoIU2VxdWVuY2UQBhIKCgZTZWxlY3QQBxIJCgVNZXJnZRAIEg0KCVRocmVzaG9sZBAJEg0KCURteE91dHB1dBAKEgwKCE9zY0lucHV0EAsSDQoJT3NjT3V0cHV0EAwSDQoJTWlkaUlucHV0EA0SDgoKTWlkaU91dHB1dBAOEg0KCVNlcXVlbmNlchAPEgsKB0ZpeHR1cmUQEBIOCgpQcm9ncmFtbWVyEBESCQoFR3JvdXAQEhIKCgZQcmVzZXQQExINCglWaWRlb0ZpbGUQFBIPCgtWaWRlb091dHB1dBAVEg8KC1ZpZGVvRWZmZWN0EBYSFQoRVmlkZW9Db2xvckJhbGFuY2UQFxISCg5WaWRlb1RyYW5zZm9ybRAYEg4KClBpeGVsVG9EbXgQHhIQCgxQaXhlbFBhdHRlcm4QHxINCglPcGNPdXRwdXQQIBIJCgVMYXNlchAoEgwKCElsZGFGaWxlECkSCwoHR2FtZXBhZBAtEgwKCENvbG9yUmdiEDISDAoIQ29sb3JIc3YQMxINCglDb250YWluZXIQZBILCgdFbmNvZGVyEDcSCAoETWF0aBA4EhAKDERhdGFUb051bWJlchA5EhAKDE51bWJlclRvRGF0YRA6EgkKBVZhbHVlEDsSDQoJTXF0dElucHV0EDwSDgoKTXF0dE91dHB1dBA9Eg4KClBsYW5TY3JlZW4QPhIJCgVEZWxheRA/EggKBFJhbXAQQBIJCgVOb2lzZRBBEgkKBUxhYmVsEEISDQoJVHJhbnNwb3J0EEMSDAoIRzEzSW5wdXQQRBINCglHMTNPdXRwdXQQRRISCg5Db25zdGFudE51bWJlchBGEg8KC0NvbmRpdGlvbmFsEEciUQoPTm9kZVByZXZpZXdUeXBlEgsKB0hpc3RvcnkQABIMCghXYXZlZm9ybRABEgwKCE11bHRpcGxlEAISCwoHVGV4dHVyZRADEggKBE5vbmUQBA==');
@$core.Deprecated('Use nodeConfigDescriptor instead')
const NodeConfig$json = const {
  '1': 'NodeConfig',
  '2': const [
    const {'1': 'oscillatorConfig', '3': 10, '4': 1, '5': 11, '6': '.mizer.nodes.OscillatorNodeConfig', '9': 0, '10': 'oscillatorConfig'},
    const {'1': 'scriptingConfig', '3': 11, '4': 1, '5': 11, '6': '.mizer.nodes.ScriptingNodeConfig', '9': 0, '10': 'scriptingConfig'},
    const {'1': 'sequenceConfig', '3': 12, '4': 1, '5': 11, '6': '.mizer.nodes.SequenceNodeConfig', '9': 0, '10': 'sequenceConfig'},
    const {'1': 'clockConfig', '3': 13, '4': 1, '5': 11, '6': '.mizer.nodes.ClockNodeConfig', '9': 0, '10': 'clockConfig'},
    const {'1': 'fixtureConfig', '3': 14, '4': 1, '5': 11, '6': '.mizer.nodes.FixtureNodeConfig', '9': 0, '10': 'fixtureConfig'},
    const {'1': 'buttonConfig', '3': 15, '4': 1, '5': 11, '6': '.mizer.nodes.ButtonNodeConfig', '9': 0, '10': 'buttonConfig'},
    const {'1': 'faderConfig', '3': 16, '4': 1, '5': 11, '6': '.mizer.nodes.FaderNodeConfig', '9': 0, '10': 'faderConfig'},
    const {'1': 'ildaFileConfig', '3': 17, '4': 1, '5': 11, '6': '.mizer.nodes.IldaFileNodeConfig', '9': 0, '10': 'ildaFileConfig'},
    const {'1': 'laserConfig', '3': 18, '4': 1, '5': 11, '6': '.mizer.nodes.LaserNodeConfig', '9': 0, '10': 'laserConfig'},
    const {'1': 'pixelPatternConfig', '3': 19, '4': 1, '5': 11, '6': '.mizer.nodes.PixelPatternNodeConfig', '9': 0, '10': 'pixelPatternConfig'},
    const {'1': 'pixelDmxConfig', '3': 20, '4': 1, '5': 11, '6': '.mizer.nodes.PixelDmxNodeConfig', '9': 0, '10': 'pixelDmxConfig'},
    const {'1': 'dmxOutputConfig', '3': 21, '4': 1, '5': 11, '6': '.mizer.nodes.DmxOutputNodeConfig', '9': 0, '10': 'dmxOutputConfig'},
    const {'1': 'midiInputConfig', '3': 22, '4': 1, '5': 11, '6': '.mizer.nodes.MidiNodeConfig', '9': 0, '10': 'midiInputConfig'},
    const {'1': 'midiOutputConfig', '3': 23, '4': 1, '5': 11, '6': '.mizer.nodes.MidiNodeConfig', '9': 0, '10': 'midiOutputConfig'},
    const {'1': 'opcOutputConfig', '3': 24, '4': 1, '5': 11, '6': '.mizer.nodes.OpcOutputNodeConfig', '9': 0, '10': 'opcOutputConfig'},
    const {'1': 'oscInputConfig', '3': 25, '4': 1, '5': 11, '6': '.mizer.nodes.OscNodeConfig', '9': 0, '10': 'oscInputConfig'},
    const {'1': 'oscOutputConfig', '3': 26, '4': 1, '5': 11, '6': '.mizer.nodes.OscNodeConfig', '9': 0, '10': 'oscOutputConfig'},
    const {'1': 'videoColorBalanceConfig', '3': 27, '4': 1, '5': 11, '6': '.mizer.nodes.VideoColorBalanceNodeConfig', '9': 0, '10': 'videoColorBalanceConfig'},
    const {'1': 'videoEffectConfig', '3': 28, '4': 1, '5': 11, '6': '.mizer.nodes.VideoEffectNodeConfig', '9': 0, '10': 'videoEffectConfig'},
    const {'1': 'videoFileConfig', '3': 29, '4': 1, '5': 11, '6': '.mizer.nodes.VideoFileNodeConfig', '9': 0, '10': 'videoFileConfig'},
    const {'1': 'videoOutputConfig', '3': 30, '4': 1, '5': 11, '6': '.mizer.nodes.VideoOutputNodeConfig', '9': 0, '10': 'videoOutputConfig'},
    const {'1': 'videoTransformConfig', '3': 31, '4': 1, '5': 11, '6': '.mizer.nodes.VideoTransformNodeConfig', '9': 0, '10': 'videoTransformConfig'},
    const {'1': 'selectConfig', '3': 32, '4': 1, '5': 11, '6': '.mizer.nodes.SelectNodeConfig', '9': 0, '10': 'selectConfig'},
    const {'1': 'mergeConfig', '3': 33, '4': 1, '5': 11, '6': '.mizer.nodes.MergeNodeConfig', '9': 0, '10': 'mergeConfig'},
    const {'1': 'envelopeConfig', '3': 34, '4': 1, '5': 11, '6': '.mizer.nodes.EnvelopeNodeConfig', '9': 0, '10': 'envelopeConfig'},
    const {'1': 'sequencerConfig', '3': 35, '4': 1, '5': 11, '6': '.mizer.nodes.SequencerNodeConfig', '9': 0, '10': 'sequencerConfig'},
    const {'1': 'programmerConfig', '3': 36, '4': 1, '5': 11, '6': '.mizer.nodes.ProgrammerNodeConfig', '9': 0, '10': 'programmerConfig'},
    const {'1': 'groupConfig', '3': 37, '4': 1, '5': 11, '6': '.mizer.nodes.GroupNodeConfig', '9': 0, '10': 'groupConfig'},
    const {'1': 'presetConfig', '3': 38, '4': 1, '5': 11, '6': '.mizer.nodes.PresetNodeConfig', '9': 0, '10': 'presetConfig'},
    const {'1': 'colorRgbConfig', '3': 40, '4': 1, '5': 11, '6': '.mizer.nodes.ColorRgbNodeConfig', '9': 0, '10': 'colorRgbConfig'},
    const {'1': 'colorHsvConfig', '3': 41, '4': 1, '5': 11, '6': '.mizer.nodes.ColorHsvNodeConfig', '9': 0, '10': 'colorHsvConfig'},
    const {'1': 'gamepadNodeConfig', '3': 42, '4': 1, '5': 11, '6': '.mizer.nodes.GamepadNodeConfig', '9': 0, '10': 'gamepadNodeConfig'},
    const {'1': 'thresholdConfig', '3': 43, '4': 1, '5': 11, '6': '.mizer.nodes.ThresholdNodeConfig', '9': 0, '10': 'thresholdConfig'},
    const {'1': 'encoderConfig', '3': 44, '4': 1, '5': 11, '6': '.mizer.nodes.EncoderNodeConfig', '9': 0, '10': 'encoderConfig'},
    const {'1': 'containerConfig', '3': 45, '4': 1, '5': 11, '6': '.mizer.nodes.ContainerNodeConfig', '9': 0, '10': 'containerConfig'},
    const {'1': 'mathConfig', '3': 46, '4': 1, '5': 11, '6': '.mizer.nodes.MathNodeConfig', '9': 0, '10': 'mathConfig'},
    const {'1': 'mqttInputConfig', '3': 47, '4': 1, '5': 11, '6': '.mizer.nodes.MqttInputNodeConfig', '9': 0, '10': 'mqttInputConfig'},
    const {'1': 'mqttOutputConfig', '3': 48, '4': 1, '5': 11, '6': '.mizer.nodes.MqttOutputNodeConfig', '9': 0, '10': 'mqttOutputConfig'},
    const {'1': 'numberToDataConfig', '3': 49, '4': 1, '5': 11, '6': '.mizer.nodes.NumberToDataNodeConfig', '9': 0, '10': 'numberToDataConfig'},
    const {'1': 'dataToNumberConfig', '3': 50, '4': 1, '5': 11, '6': '.mizer.nodes.DataToNumberNodeConfig', '9': 0, '10': 'dataToNumberConfig'},
    const {'1': 'valueConfig', '3': 51, '4': 1, '5': 11, '6': '.mizer.nodes.ValueNodeConfig', '9': 0, '10': 'valueConfig'},
    const {'1': 'planScreenConfig', '3': 52, '4': 1, '5': 11, '6': '.mizer.nodes.PlanScreenNodeConfig', '9': 0, '10': 'planScreenConfig'},
    const {'1': 'delayConfig', '3': 53, '4': 1, '5': 11, '6': '.mizer.nodes.DelayNodeConfig', '9': 0, '10': 'delayConfig'},
    const {'1': 'rampConfig', '3': 54, '4': 1, '5': 11, '6': '.mizer.nodes.RampNodeConfig', '9': 0, '10': 'rampConfig'},
    const {'1': 'noiseConfig', '3': 55, '4': 1, '5': 11, '6': '.mizer.nodes.NoiseNodeConfig', '9': 0, '10': 'noiseConfig'},
    const {'1': 'labelConfig', '3': 56, '4': 1, '5': 11, '6': '.mizer.nodes.LabelNodeConfig', '9': 0, '10': 'labelConfig'},
    const {'1': 'transportConfig', '3': 57, '4': 1, '5': 11, '6': '.mizer.nodes.TransportNodeConfig', '9': 0, '10': 'transportConfig'},
    const {'1': 'g13InputConfig', '3': 58, '4': 1, '5': 11, '6': '.mizer.nodes.G13InputNodeConfig', '9': 0, '10': 'g13InputConfig'},
    const {'1': 'g13OutputConfig', '3': 59, '4': 1, '5': 11, '6': '.mizer.nodes.G13OutputNodeConfig', '9': 0, '10': 'g13OutputConfig'},
    const {'1': 'constantNumberConfig', '3': 60, '4': 1, '5': 11, '6': '.mizer.nodes.ConstantNumberNodeConfig', '9': 0, '10': 'constantNumberConfig'},
    const {'1': 'conditionalConfig', '3': 61, '4': 1, '5': 11, '6': '.mizer.nodes.ConditionalNodeConfig', '9': 0, '10': 'conditionalConfig'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `NodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeConfigDescriptor = $convert.base64Decode('CgpOb2RlQ29uZmlnEk8KEG9zY2lsbGF0b3JDb25maWcYCiABKAsyIS5taXplci5ub2Rlcy5Pc2NpbGxhdG9yTm9kZUNvbmZpZ0gAUhBvc2NpbGxhdG9yQ29uZmlnEkwKD3NjcmlwdGluZ0NvbmZpZxgLIAEoCzIgLm1pemVyLm5vZGVzLlNjcmlwdGluZ05vZGVDb25maWdIAFIPc2NyaXB0aW5nQ29uZmlnEkkKDnNlcXVlbmNlQ29uZmlnGAwgASgLMh8ubWl6ZXIubm9kZXMuU2VxdWVuY2VOb2RlQ29uZmlnSABSDnNlcXVlbmNlQ29uZmlnEkAKC2Nsb2NrQ29uZmlnGA0gASgLMhwubWl6ZXIubm9kZXMuQ2xvY2tOb2RlQ29uZmlnSABSC2Nsb2NrQ29uZmlnEkYKDWZpeHR1cmVDb25maWcYDiABKAsyHi5taXplci5ub2Rlcy5GaXh0dXJlTm9kZUNvbmZpZ0gAUg1maXh0dXJlQ29uZmlnEkMKDGJ1dHRvbkNvbmZpZxgPIAEoCzIdLm1pemVyLm5vZGVzLkJ1dHRvbk5vZGVDb25maWdIAFIMYnV0dG9uQ29uZmlnEkAKC2ZhZGVyQ29uZmlnGBAgASgLMhwubWl6ZXIubm9kZXMuRmFkZXJOb2RlQ29uZmlnSABSC2ZhZGVyQ29uZmlnEkkKDmlsZGFGaWxlQ29uZmlnGBEgASgLMh8ubWl6ZXIubm9kZXMuSWxkYUZpbGVOb2RlQ29uZmlnSABSDmlsZGFGaWxlQ29uZmlnEkAKC2xhc2VyQ29uZmlnGBIgASgLMhwubWl6ZXIubm9kZXMuTGFzZXJOb2RlQ29uZmlnSABSC2xhc2VyQ29uZmlnElUKEnBpeGVsUGF0dGVybkNvbmZpZxgTIAEoCzIjLm1pemVyLm5vZGVzLlBpeGVsUGF0dGVybk5vZGVDb25maWdIAFIScGl4ZWxQYXR0ZXJuQ29uZmlnEkkKDnBpeGVsRG14Q29uZmlnGBQgASgLMh8ubWl6ZXIubm9kZXMuUGl4ZWxEbXhOb2RlQ29uZmlnSABSDnBpeGVsRG14Q29uZmlnEkwKD2RteE91dHB1dENvbmZpZxgVIAEoCzIgLm1pemVyLm5vZGVzLkRteE91dHB1dE5vZGVDb25maWdIAFIPZG14T3V0cHV0Q29uZmlnEkcKD21pZGlJbnB1dENvbmZpZxgWIAEoCzIbLm1pemVyLm5vZGVzLk1pZGlOb2RlQ29uZmlnSABSD21pZGlJbnB1dENvbmZpZxJJChBtaWRpT3V0cHV0Q29uZmlnGBcgASgLMhsubWl6ZXIubm9kZXMuTWlkaU5vZGVDb25maWdIAFIQbWlkaU91dHB1dENvbmZpZxJMCg9vcGNPdXRwdXRDb25maWcYGCABKAsyIC5taXplci5ub2Rlcy5PcGNPdXRwdXROb2RlQ29uZmlnSABSD29wY091dHB1dENvbmZpZxJECg5vc2NJbnB1dENvbmZpZxgZIAEoCzIaLm1pemVyLm5vZGVzLk9zY05vZGVDb25maWdIAFIOb3NjSW5wdXRDb25maWcSRgoPb3NjT3V0cHV0Q29uZmlnGBogASgLMhoubWl6ZXIubm9kZXMuT3NjTm9kZUNvbmZpZ0gAUg9vc2NPdXRwdXRDb25maWcSZAoXdmlkZW9Db2xvckJhbGFuY2VDb25maWcYGyABKAsyKC5taXplci5ub2Rlcy5WaWRlb0NvbG9yQmFsYW5jZU5vZGVDb25maWdIAFIXdmlkZW9Db2xvckJhbGFuY2VDb25maWcSUgoRdmlkZW9FZmZlY3RDb25maWcYHCABKAsyIi5taXplci5ub2Rlcy5WaWRlb0VmZmVjdE5vZGVDb25maWdIAFIRdmlkZW9FZmZlY3RDb25maWcSTAoPdmlkZW9GaWxlQ29uZmlnGB0gASgLMiAubWl6ZXIubm9kZXMuVmlkZW9GaWxlTm9kZUNvbmZpZ0gAUg92aWRlb0ZpbGVDb25maWcSUgoRdmlkZW9PdXRwdXRDb25maWcYHiABKAsyIi5taXplci5ub2Rlcy5WaWRlb091dHB1dE5vZGVDb25maWdIAFIRdmlkZW9PdXRwdXRDb25maWcSWwoUdmlkZW9UcmFuc2Zvcm1Db25maWcYHyABKAsyJS5taXplci5ub2Rlcy5WaWRlb1RyYW5zZm9ybU5vZGVDb25maWdIAFIUdmlkZW9UcmFuc2Zvcm1Db25maWcSQwoMc2VsZWN0Q29uZmlnGCAgASgLMh0ubWl6ZXIubm9kZXMuU2VsZWN0Tm9kZUNvbmZpZ0gAUgxzZWxlY3RDb25maWcSQAoLbWVyZ2VDb25maWcYISABKAsyHC5taXplci5ub2Rlcy5NZXJnZU5vZGVDb25maWdIAFILbWVyZ2VDb25maWcSSQoOZW52ZWxvcGVDb25maWcYIiABKAsyHy5taXplci5ub2Rlcy5FbnZlbG9wZU5vZGVDb25maWdIAFIOZW52ZWxvcGVDb25maWcSTAoPc2VxdWVuY2VyQ29uZmlnGCMgASgLMiAubWl6ZXIubm9kZXMuU2VxdWVuY2VyTm9kZUNvbmZpZ0gAUg9zZXF1ZW5jZXJDb25maWcSTwoQcHJvZ3JhbW1lckNvbmZpZxgkIAEoCzIhLm1pemVyLm5vZGVzLlByb2dyYW1tZXJOb2RlQ29uZmlnSABSEHByb2dyYW1tZXJDb25maWcSQAoLZ3JvdXBDb25maWcYJSABKAsyHC5taXplci5ub2Rlcy5Hcm91cE5vZGVDb25maWdIAFILZ3JvdXBDb25maWcSQwoMcHJlc2V0Q29uZmlnGCYgASgLMh0ubWl6ZXIubm9kZXMuUHJlc2V0Tm9kZUNvbmZpZ0gAUgxwcmVzZXRDb25maWcSSQoOY29sb3JSZ2JDb25maWcYKCABKAsyHy5taXplci5ub2Rlcy5Db2xvclJnYk5vZGVDb25maWdIAFIOY29sb3JSZ2JDb25maWcSSQoOY29sb3JIc3ZDb25maWcYKSABKAsyHy5taXplci5ub2Rlcy5Db2xvckhzdk5vZGVDb25maWdIAFIOY29sb3JIc3ZDb25maWcSTgoRZ2FtZXBhZE5vZGVDb25maWcYKiABKAsyHi5taXplci5ub2Rlcy5HYW1lcGFkTm9kZUNvbmZpZ0gAUhFnYW1lcGFkTm9kZUNvbmZpZxJMCg90aHJlc2hvbGRDb25maWcYKyABKAsyIC5taXplci5ub2Rlcy5UaHJlc2hvbGROb2RlQ29uZmlnSABSD3RocmVzaG9sZENvbmZpZxJGCg1lbmNvZGVyQ29uZmlnGCwgASgLMh4ubWl6ZXIubm9kZXMuRW5jb2Rlck5vZGVDb25maWdIAFINZW5jb2RlckNvbmZpZxJMCg9jb250YWluZXJDb25maWcYLSABKAsyIC5taXplci5ub2Rlcy5Db250YWluZXJOb2RlQ29uZmlnSABSD2NvbnRhaW5lckNvbmZpZxI9CgptYXRoQ29uZmlnGC4gASgLMhsubWl6ZXIubm9kZXMuTWF0aE5vZGVDb25maWdIAFIKbWF0aENvbmZpZxJMCg9tcXR0SW5wdXRDb25maWcYLyABKAsyIC5taXplci5ub2Rlcy5NcXR0SW5wdXROb2RlQ29uZmlnSABSD21xdHRJbnB1dENvbmZpZxJPChBtcXR0T3V0cHV0Q29uZmlnGDAgASgLMiEubWl6ZXIubm9kZXMuTXF0dE91dHB1dE5vZGVDb25maWdIAFIQbXF0dE91dHB1dENvbmZpZxJVChJudW1iZXJUb0RhdGFDb25maWcYMSABKAsyIy5taXplci5ub2Rlcy5OdW1iZXJUb0RhdGFOb2RlQ29uZmlnSABSEm51bWJlclRvRGF0YUNvbmZpZxJVChJkYXRhVG9OdW1iZXJDb25maWcYMiABKAsyIy5taXplci5ub2Rlcy5EYXRhVG9OdW1iZXJOb2RlQ29uZmlnSABSEmRhdGFUb051bWJlckNvbmZpZxJACgt2YWx1ZUNvbmZpZxgzIAEoCzIcLm1pemVyLm5vZGVzLlZhbHVlTm9kZUNvbmZpZ0gAUgt2YWx1ZUNvbmZpZxJPChBwbGFuU2NyZWVuQ29uZmlnGDQgASgLMiEubWl6ZXIubm9kZXMuUGxhblNjcmVlbk5vZGVDb25maWdIAFIQcGxhblNjcmVlbkNvbmZpZxJACgtkZWxheUNvbmZpZxg1IAEoCzIcLm1pemVyLm5vZGVzLkRlbGF5Tm9kZUNvbmZpZ0gAUgtkZWxheUNvbmZpZxI9CgpyYW1wQ29uZmlnGDYgASgLMhsubWl6ZXIubm9kZXMuUmFtcE5vZGVDb25maWdIAFIKcmFtcENvbmZpZxJACgtub2lzZUNvbmZpZxg3IAEoCzIcLm1pemVyLm5vZGVzLk5vaXNlTm9kZUNvbmZpZ0gAUgtub2lzZUNvbmZpZxJACgtsYWJlbENvbmZpZxg4IAEoCzIcLm1pemVyLm5vZGVzLkxhYmVsTm9kZUNvbmZpZ0gAUgtsYWJlbENvbmZpZxJMCg90cmFuc3BvcnRDb25maWcYOSABKAsyIC5taXplci5ub2Rlcy5UcmFuc3BvcnROb2RlQ29uZmlnSABSD3RyYW5zcG9ydENvbmZpZxJJCg5nMTNJbnB1dENvbmZpZxg6IAEoCzIfLm1pemVyLm5vZGVzLkcxM0lucHV0Tm9kZUNvbmZpZ0gAUg5nMTNJbnB1dENvbmZpZxJMCg9nMTNPdXRwdXRDb25maWcYOyABKAsyIC5taXplci5ub2Rlcy5HMTNPdXRwdXROb2RlQ29uZmlnSABSD2cxM091dHB1dENvbmZpZxJbChRjb25zdGFudE51bWJlckNvbmZpZxg8IAEoCzIlLm1pemVyLm5vZGVzLkNvbnN0YW50TnVtYmVyTm9kZUNvbmZpZ0gAUhRjb25zdGFudE51bWJlckNvbmZpZxJSChFjb25kaXRpb25hbENvbmZpZxg9IAEoCzIiLm1pemVyLm5vZGVzLkNvbmRpdGlvbmFsTm9kZUNvbmZpZ0gAUhFjb25kaXRpb25hbENvbmZpZ0IGCgR0eXBl');
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
    const {'1': 'Square', '2': 0},
    const {'1': 'Sine', '2': 1},
    const {'1': 'Saw', '2': 2},
    const {'1': 'Triangle', '2': 3},
  ],
};

/// Descriptor for `OscillatorNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List oscillatorNodeConfigDescriptor = $convert.base64Decode('ChRPc2NpbGxhdG9yTm9kZUNvbmZpZxJECgR0eXBlGAEgASgOMjAubWl6ZXIubm9kZXMuT3NjaWxsYXRvck5vZGVDb25maWcuT3NjaWxsYXRvclR5cGVSBHR5cGUSFAoFcmF0aW8YAiABKAFSBXJhdGlvEhAKA21heBgDIAEoAVIDbWF4EhAKA21pbhgEIAEoAVIDbWluEhYKBm9mZnNldBgFIAEoAVIGb2Zmc2V0EhgKB3JldmVyc2UYBiABKAhSB3JldmVyc2UiPQoOT3NjaWxsYXRvclR5cGUSCgoGU3F1YXJlEAASCAoEU2luZRABEgcKA1NhdxACEgwKCFRyaWFuZ2xlEAM=');
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
};

/// Descriptor for `GroupNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupNodeConfigDescriptor = $convert.base64Decode('Cg9Hcm91cE5vZGVDb25maWc=');
@$core.Deprecated('Use presetNodeConfigDescriptor instead')
const PresetNodeConfig$json = const {
  '1': 'PresetNodeConfig',
};

/// Descriptor for `PresetNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List presetNodeConfigDescriptor = $convert.base64Decode('ChBQcmVzZXROb2RlQ29uZmln');
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
    const {'1': 'LeftStickX', '2': 0},
    const {'1': 'LeftStickY', '2': 1},
    const {'1': 'RightStickX', '2': 2},
    const {'1': 'RightStickY', '2': 3},
    const {'1': 'LeftTrigger', '2': 4},
    const {'1': 'RightTrigger', '2': 5},
    const {'1': 'LeftShoulder', '2': 6},
    const {'1': 'RightShoulder', '2': 7},
    const {'1': 'South', '2': 8},
    const {'1': 'East', '2': 9},
    const {'1': 'North', '2': 10},
    const {'1': 'West', '2': 11},
    const {'1': 'Select', '2': 12},
    const {'1': 'Start', '2': 13},
    const {'1': 'DpadUp', '2': 14},
    const {'1': 'DpadDown', '2': 15},
    const {'1': 'DpadLeft', '2': 16},
    const {'1': 'DpadRight', '2': 17},
    const {'1': 'LeftStick', '2': 18},
    const {'1': 'RightStick', '2': 19},
  ],
};

/// Descriptor for `GamepadNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gamepadNodeConfigDescriptor = $convert.base64Decode('ChFHYW1lcGFkTm9kZUNvbmZpZxIbCglkZXZpY2VfaWQYASABKAlSCGRldmljZUlkEkAKB2NvbnRyb2wYAiABKA4yJi5taXplci5ub2Rlcy5HYW1lcGFkTm9kZUNvbmZpZy5Db250cm9sUgdjb250cm9sIqoCCgdDb250cm9sEg4KCkxlZnRTdGlja1gQABIOCgpMZWZ0U3RpY2tZEAESDwoLUmlnaHRTdGlja1gQAhIPCgtSaWdodFN0aWNrWRADEg8KC0xlZnRUcmlnZ2VyEAQSEAoMUmlnaHRUcmlnZ2VyEAUSEAoMTGVmdFNob3VsZGVyEAYSEQoNUmlnaHRTaG91bGRlchAHEgkKBVNvdXRoEAgSCAoERWFzdBAJEgkKBU5vcnRoEAoSCAoEV2VzdBALEgoKBlNlbGVjdBAMEgkKBVN0YXJ0EA0SCgoGRHBhZFVwEA4SDAoIRHBhZERvd24QDxIMCghEcGFkTGVmdBAQEg0KCURwYWRSaWdodBAREg0KCUxlZnRTdGljaxASEg4KClJpZ2h0U3RpY2sQEw==');
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
    const {'1': 'RgbIterate', '2': 0},
    const {'1': 'RgbSnake', '2': 1},
  ],
};

/// Descriptor for `PixelPatternNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pixelPatternNodeConfigDescriptor = $convert.base64Decode('ChZQaXhlbFBhdHRlcm5Ob2RlQ29uZmlnEkUKB3BhdHRlcm4YASABKA4yKy5taXplci5ub2Rlcy5QaXhlbFBhdHRlcm5Ob2RlQ29uZmlnLlBhdHRlcm5SB3BhdHRlcm4iJwoHUGF0dGVybhIOCgpSZ2JJdGVyYXRlEAASDAoIUmdiU25ha2UQAQ==');
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
    const {'1': 'noteBinding', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.MidiNodeConfig.NoteBinding', '9': 0, '10': 'noteBinding'},
    const {'1': 'controlBinding', '3': 3, '4': 1, '5': 11, '6': '.mizer.nodes.MidiNodeConfig.ControlBinding', '9': 0, '10': 'controlBinding'},
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
    const {'1': 'rangeFrom', '3': 4, '4': 1, '5': 13, '10': 'rangeFrom'},
    const {'1': 'rangeTo', '3': 5, '4': 1, '5': 13, '10': 'rangeTo'},
  ],
  '4': const [MidiNodeConfig_NoteBinding_MidiType$json],
};

@$core.Deprecated('Use midiNodeConfigDescriptor instead')
const MidiNodeConfig_NoteBinding_MidiType$json = const {
  '1': 'MidiType',
  '2': const [
    const {'1': 'CC', '2': 0},
    const {'1': 'Note', '2': 1},
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
final $typed_data.Uint8List midiNodeConfigDescriptor = $convert.base64Decode('Cg5NaWRpTm9kZUNvbmZpZxIWCgZkZXZpY2UYASABKAlSBmRldmljZRJLCgtub3RlQmluZGluZxgCIAEoCzInLm1pemVyLm5vZGVzLk1pZGlOb2RlQ29uZmlnLk5vdGVCaW5kaW5nSABSC25vdGVCaW5kaW5nElQKDmNvbnRyb2xCaW5kaW5nGAMgASgLMioubWl6ZXIubm9kZXMuTWlkaU5vZGVDb25maWcuQ29udHJvbEJpbmRpbmdIAFIOY29udHJvbEJpbmRpbmca1wEKC05vdGVCaW5kaW5nEhgKB2NoYW5uZWwYASABKA1SB2NoYW5uZWwSRAoEdHlwZRgCIAEoDjIwLm1pemVyLm5vZGVzLk1pZGlOb2RlQ29uZmlnLk5vdGVCaW5kaW5nLk1pZGlUeXBlUgR0eXBlEhIKBHBvcnQYAyABKA1SBHBvcnQSHAoJcmFuZ2VGcm9tGAQgASgNUglyYW5nZUZyb20SGAoHcmFuZ2VUbxgFIAEoDVIHcmFuZ2VUbyIcCghNaWRpVHlwZRIGCgJDQxAAEggKBE5vdGUQARo+Cg5Db250cm9sQmluZGluZxISCgRwYWdlGAEgASgJUgRwYWdlEhgKB2NvbnRyb2wYAiABKAlSB2NvbnRyb2xCCQoHYmluZGluZw==');
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
    const {'1': 'argumentType', '3': 3, '4': 1, '5': 14, '6': '.mizer.nodes.OscNodeConfig.ArgumentType', '10': 'argumentType'},
    const {'1': 'onlyEmitChanges', '3': 4, '4': 1, '5': 8, '10': 'onlyEmitChanges'},
  ],
  '4': const [OscNodeConfig_ArgumentType$json],
};

@$core.Deprecated('Use oscNodeConfigDescriptor instead')
const OscNodeConfig_ArgumentType$json = const {
  '1': 'ArgumentType',
  '2': const [
    const {'1': 'Int', '2': 0},
    const {'1': 'Float', '2': 1},
    const {'1': 'Long', '2': 2},
    const {'1': 'Double', '2': 3},
    const {'1': 'Bool', '2': 4},
    const {'1': 'Color', '2': 5},
  ],
};

/// Descriptor for `OscNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List oscNodeConfigDescriptor = $convert.base64Decode('Cg1Pc2NOb2RlQ29uZmlnEh4KCmNvbm5lY3Rpb24YASABKAlSCmNvbm5lY3Rpb24SEgoEcGF0aBgCIAEoCVIEcGF0aBJLCgxhcmd1bWVudFR5cGUYAyABKA4yJy5taXplci5ub2Rlcy5Pc2NOb2RlQ29uZmlnLkFyZ3VtZW50VHlwZVIMYXJndW1lbnRUeXBlEigKD29ubHlFbWl0Q2hhbmdlcxgEIAEoCFIPb25seUVtaXRDaGFuZ2VzIk0KDEFyZ3VtZW50VHlwZRIHCgNJbnQQABIJCgVGbG9hdBABEggKBExvbmcQAhIKCgZEb3VibGUQAxIICgRCb29sEAQSCQoFQ29sb3IQBQ==');
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
    const {'1': 'Latest', '2': 0},
    const {'1': 'Highest', '2': 1},
    const {'1': 'Lowest', '2': 2},
  ],
};

/// Descriptor for `MergeNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mergeNodeConfigDescriptor = $convert.base64Decode('Cg9NZXJnZU5vZGVDb25maWcSOgoEbW9kZRgBIAEoDjImLm1pemVyLm5vZGVzLk1lcmdlTm9kZUNvbmZpZy5NZXJnZU1vZGVSBG1vZGUiMAoJTWVyZ2VNb2RlEgoKBkxhdGVzdBAAEgsKB0hpZ2hlc3QQARIKCgZMb3dlc3QQAg==');
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
  ],
};

/// Descriptor for `EncoderNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List encoderNodeConfigDescriptor = $convert.base64Decode('ChFFbmNvZGVyTm9kZUNvbmZpZxIbCglob2xkX3JhdGUYASABKAFSCGhvbGRSYXRl');
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
    const {'1': 'Addition', '2': 0},
    const {'1': 'Subtraction', '2': 1},
    const {'1': 'Multiplication', '2': 2},
    const {'1': 'Division', '2': 3},
    const {'1': 'Invert', '2': 4},
    const {'1': 'Sine', '2': 5},
    const {'1': 'Cosine', '2': 6},
    const {'1': 'Tangent', '2': 7},
  ],
};

/// Descriptor for `MathNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mathNodeConfigDescriptor = $convert.base64Decode('Cg5NYXRoTm9kZUNvbmZpZxI0CgRtb2RlGAEgASgOMiAubWl6ZXIubm9kZXMuTWF0aE5vZGVDb25maWcuTW9kZVIEbW9kZSJ2CgRNb2RlEgwKCEFkZGl0aW9uEAASDwoLU3VidHJhY3Rpb24QARISCg5NdWx0aXBsaWNhdGlvbhACEgwKCERpdmlzaW9uEAMSCgoGSW52ZXJ0EAQSCAoEU2luZRAFEgoKBkNvc2luZRAGEgsKB1RhbmdlbnQQBw==');
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
  ],
};

/// Descriptor for `MqttOutputNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mqttOutputNodeConfigDescriptor = $convert.base64Decode('ChRNcXR0T3V0cHV0Tm9kZUNvbmZpZxIeCgpjb25uZWN0aW9uGAEgASgJUgpjb25uZWN0aW9uEhIKBHBhdGgYAiABKAlSBHBhdGg=');
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
    const {'1': 'JoystickX', '2': 30},
    const {'1': 'JoystickY', '2': 31},
    const {'1': 'Joystick', '2': 32},
    const {'1': 'Left', '2': 33},
    const {'1': 'Down', '2': 34},
    const {'1': 'BD', '2': 35},
  ],
};

/// Descriptor for `G13InputNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List g13InputNodeConfigDescriptor = $convert.base64Decode('ChJHMTNJbnB1dE5vZGVDb25maWcSGwoJZGV2aWNlX2lkGAEgASgJUghkZXZpY2VJZBI1CgNrZXkYAiABKA4yIy5taXplci5ub2Rlcy5HMTNJbnB1dE5vZGVDb25maWcuS2V5UgNrZXkiygIKA0tleRIGCgJHMRAAEgYKAkcyEAESBgoCRzMQAhIGCgJHNBADEgYKAkc1EAQSBgoCRzYQBRIGCgJHNxAGEgYKAkc4EAcSBgoCRzkQCBIHCgNHMTAQCRIHCgNHMTEQChIHCgNHMTIQCxIHCgNHMTMQDBIHCgNHMTQQDRIHCgNHMTUQDhIHCgNHMTYQDxIHCgNHMTcQEBIHCgNHMTgQERIHCgNHMTkQEhIHCgNHMjAQExIHCgNHMjEQFBIHCgNHMjIQFRIGCgJNMRAWEgYKAk0yEBcSBgoCTTMQGBIGCgJNUhAZEgYKAkwxEBoSBgoCTDIQGxIGCgJMMxAcEgYKAkw0EB0SDQoJSm95c3RpY2tYEB4SDQoJSm95c3RpY2tZEB8SDAoISm95c3RpY2sQIBIICgRMZWZ0ECESCAoERG93bhAiEgYKAkJEECM=');
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
