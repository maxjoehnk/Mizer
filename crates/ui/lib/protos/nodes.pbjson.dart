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
    {'1': 'NODE_CATEGORY_VECTOR', '2': 11},
    {'1': 'NODE_CATEGORY_FIXTURES', '2': 12},
    {'1': 'NODE_CATEGORY_UI', '2': 13},
  ],
};

/// Descriptor for `NodeCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List nodeCategoryDescriptor = $convert.base64Decode(
    'CgxOb2RlQ2F0ZWdvcnkSFgoSTk9ERV9DQVRFR09SWV9OT05FEAASGgoWTk9ERV9DQVRFR09SWV'
    '9TVEFOREFSRBABEh0KGU5PREVfQ0FURUdPUllfQ09OTkVDVElPTlMQAhIdChlOT0RFX0NBVEVH'
    'T1JZX0NPTlZFUlNJT05TEAMSGgoWTk9ERV9DQVRFR09SWV9DT05UUk9MUxAEEhYKEk5PREVfQ0'
    'FURUdPUllfREFUQRAFEhcKE05PREVfQ0FURUdPUllfQ09MT1IQBhIXChNOT0RFX0NBVEVHT1JZ'
    'X0FVRElPEAcSFwoTTk9ERV9DQVRFR09SWV9WSURFTxAIEhcKE05PREVfQ0FURUdPUllfTEFTRV'
    'IQCRIXChNOT0RFX0NBVEVHT1JZX1BJWEVMEAoSGAoUTk9ERV9DQVRFR09SWV9WRUNUT1IQCxIa'
    'ChZOT0RFX0NBVEVHT1JZX0ZJWFRVUkVTEAwSFAoQTk9ERV9DQVRFR09SWV9VSRAN');

@$core.Deprecated('Use nodeColorDescriptor instead')
const NodeColor$json = {
  '1': 'NodeColor',
  '2': [
    {'1': 'NODE_COLOR_NONE', '2': 0},
    {'1': 'NODE_COLOR_GREY', '2': 1},
    {'1': 'NODE_COLOR_RED', '2': 2},
    {'1': 'NODE_COLOR_DEEP_ORANGE', '2': 3},
    {'1': 'NODE_COLOR_ORANGE', '2': 4},
    {'1': 'NODE_COLOR_AMBER', '2': 5},
    {'1': 'NODE_COLOR_YELLOW', '2': 6},
    {'1': 'NODE_COLOR_LIME', '2': 7},
    {'1': 'NODE_COLOR_LIGHT_GREEN', '2': 8},
    {'1': 'NODE_COLOR_GREEN', '2': 9},
    {'1': 'NODE_COLOR_TEAL', '2': 10},
    {'1': 'NODE_COLOR_CYAN', '2': 11},
    {'1': 'NODE_COLOR_LIGHT_BLUE', '2': 12},
    {'1': 'NODE_COLOR_BLUE', '2': 13},
    {'1': 'NODE_COLOR_INDIGO', '2': 14},
    {'1': 'NODE_COLOR_PURPLE', '2': 15},
    {'1': 'NODE_COLOR_DEEP_PURPLE', '2': 16},
    {'1': 'NODE_COLOR_PINK', '2': 17},
    {'1': 'NODE_COLOR_BLUE_GREY', '2': 18},
    {'1': 'NODE_COLOR_BROWN', '2': 19},
  ],
};

/// Descriptor for `NodeColor`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List nodeColorDescriptor = $convert.base64Decode(
    'CglOb2RlQ29sb3ISEwoPTk9ERV9DT0xPUl9OT05FEAASEwoPTk9ERV9DT0xPUl9HUkVZEAESEg'
    'oOTk9ERV9DT0xPUl9SRUQQAhIaChZOT0RFX0NPTE9SX0RFRVBfT1JBTkdFEAMSFQoRTk9ERV9D'
    'T0xPUl9PUkFOR0UQBBIUChBOT0RFX0NPTE9SX0FNQkVSEAUSFQoRTk9ERV9DT0xPUl9ZRUxMT1'
    'cQBhITCg9OT0RFX0NPTE9SX0xJTUUQBxIaChZOT0RFX0NPTE9SX0xJR0hUX0dSRUVOEAgSFAoQ'
    'Tk9ERV9DT0xPUl9HUkVFThAJEhMKD05PREVfQ09MT1JfVEVBTBAKEhMKD05PREVfQ09MT1JfQ1'
    'lBThALEhkKFU5PREVfQ09MT1JfTElHSFRfQkxVRRAMEhMKD05PREVfQ09MT1JfQkxVRRANEhUK'
    'EU5PREVfQ09MT1JfSU5ESUdPEA4SFQoRTk9ERV9DT0xPUl9QVVJQTEUQDxIaChZOT0RFX0NPTE'
    '9SX0RFRVBfUFVSUExFEBASEwoPTk9ERV9DT0xPUl9QSU5LEBESGAoUTk9ERV9DT0xPUl9CTFVF'
    'X0dSRVkQEhIUChBOT0RFX0NPTE9SX0JST1dOEBM=');

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
    {'1': 'TEXT', '2': 11},
  ],
};

/// Descriptor for `ChannelProtocol`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelProtocolDescriptor = $convert.base64Decode(
    'Cg9DaGFubmVsUHJvdG9jb2wSCgoGU0lOR0xFEAASCQoFTVVMVEkQARILCgdURVhUVVJFEAISCg'
    'oGVkVDVE9SEAMSCQoFTEFTRVIQBBIICgRQT0xZEAUSCAoEREFUQRAGEgwKCE1BVEVSSUFMEAcS'
    'CQoFQ09MT1IQCRIJCgVDTE9DSxAKEggKBFRFWFQQCw==');

@$core.Deprecated('Use addNodeRequestDescriptor instead')
const AddNodeRequest$json = {
  '1': 'AddNodeRequest',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.NodePosition', '10': 'position'},
    {'1': 'parent', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
    {'1': 'template', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'template', '17': true},
  ],
  '8': [
    {'1': '_parent'},
    {'1': '_template'},
  ],
};

/// Descriptor for `AddNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addNodeRequestDescriptor = $convert.base64Decode(
    'Cg5BZGROb2RlUmVxdWVzdBISCgR0eXBlGAEgASgJUgR0eXBlEjUKCHBvc2l0aW9uGAIgASgLMh'
    'kubWl6ZXIubm9kZXMuTm9kZVBvc2l0aW9uUghwb3NpdGlvbhIbCgZwYXJlbnQYAyABKAlIAFIG'
    'cGFyZW50iAEBEh8KCHRlbXBsYXRlGAQgASgJSAFSCHRlbXBsYXRliAEBQgkKB19wYXJlbnRCCw'
    'oJX3RlbXBsYXRl');

@$core.Deprecated('Use duplicateNodesRequestDescriptor instead')
const DuplicateNodesRequest$json = {
  '1': 'DuplicateNodesRequest',
  '2': [
    {'1': 'paths', '3': 1, '4': 3, '5': 9, '10': 'paths'},
    {'1': 'parent', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
  ],
  '8': [
    {'1': '_parent'},
  ],
};

/// Descriptor for `DuplicateNodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List duplicateNodesRequestDescriptor = $convert.base64Decode(
    'ChVEdXBsaWNhdGVOb2Rlc1JlcXVlc3QSFAoFcGF0aHMYASADKAlSBXBhdGhzEhsKBnBhcmVudB'
    'gCIAEoCUgAUgZwYXJlbnSIAQFCCQoHX3BhcmVudA==');

@$core.Deprecated('Use disconnectPortRequestDescriptor instead')
const DisconnectPortRequest$json = {
  '1': 'DisconnectPortRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'port', '3': 2, '4': 1, '5': 9, '10': 'port'},
  ],
};

/// Descriptor for `DisconnectPortRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectPortRequestDescriptor = $convert.base64Decode(
    'ChVEaXNjb25uZWN0UG9ydFJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aBISCgRwb3J0GAIgAS'
    'gJUgRwb3J0');

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

@$core.Deprecated('Use updateNodeColorRequestDescriptor instead')
const UpdateNodeColorRequest$json = {
  '1': 'UpdateNodeColorRequest',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'color', '3': 2, '4': 1, '5': 14, '6': '.mizer.nodes.NodeColor', '9': 0, '10': 'color', '17': true},
  ],
  '8': [
    {'1': '_color'},
  ],
};

/// Descriptor for `UpdateNodeColorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNodeColorRequestDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVOb2RlQ29sb3JSZXF1ZXN0EhIKBHBhdGgYASABKAlSBHBhdGgSMQoFY29sb3IYAi'
    'ABKA4yFi5taXplci5ub2Rlcy5Ob2RlQ29sb3JIAFIFY29sb3KIAQFCCAoGX2NvbG9y');

@$core.Deprecated('Use moveNodesRequestDescriptor instead')
const MoveNodesRequest$json = {
  '1': 'MoveNodesRequest',
  '2': [
    {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.MoveNodeRequest', '10': 'nodes'},
  ],
};

/// Descriptor for `MoveNodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveNodesRequestDescriptor = $convert.base64Decode(
    'ChBNb3ZlTm9kZXNSZXF1ZXN0EjIKBW5vZGVzGAEgAygLMhwubWl6ZXIubm9kZXMuTW92ZU5vZG'
    'VSZXF1ZXN0UgVub2Rlcw==');

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
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'category', '3': 3, '4': 1, '5': 14, '6': '.mizer.nodes.NodeCategory', '10': 'category'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'settings', '3': 5, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSettingDescription', '10': 'settings'},
    {'1': 'templates', '3': 6, '4': 3, '5': 11, '6': '.mizer.nodes.NodeTemplate', '10': 'templates'},
  ],
};

/// Descriptor for `AvailableNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List availableNodeDescriptor = $convert.base64Decode(
    'Cg1BdmFpbGFibGVOb2RlEhIKBHR5cGUYASABKAlSBHR5cGUSEgoEbmFtZRgCIAEoCVIEbmFtZR'
    'I1CghjYXRlZ29yeRgDIAEoDjIZLm1pemVyLm5vZGVzLk5vZGVDYXRlZ29yeVIIY2F0ZWdvcnkS'
    'IAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEj8KCHNldHRpbmdzGAUgAygLMiMubW'
    'l6ZXIubm9kZXMuTm9kZVNldHRpbmdEZXNjcmlwdGlvblIIc2V0dGluZ3MSNwoJdGVtcGxhdGVz'
    'GAYgAygLMhkubWl6ZXIubm9kZXMuTm9kZVRlbXBsYXRlUgl0ZW1wbGF0ZXM=');

@$core.Deprecated('Use nodeSettingDescriptionDescriptor instead')
const NodeSettingDescription$json = {
  '1': 'NodeSettingDescription',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `NodeSettingDescription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeSettingDescriptionDescriptor = $convert.base64Decode(
    'ChZOb2RlU2V0dGluZ0Rlc2NyaXB0aW9uEhIKBG5hbWUYASABKAlSBG5hbWUSIAoLZGVzY3JpcH'
    'Rpb24YAiABKAlSC2Rlc2NyaXB0aW9u');

@$core.Deprecated('Use nodeTemplateDescriptor instead')
const NodeTemplate$json = {
  '1': 'NodeTemplate',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'description', '17': true},
  ],
  '8': [
    {'1': '_description'},
  ],
};

/// Descriptor for `NodeTemplate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeTemplateDescriptor = $convert.base64Decode(
    'CgxOb2RlVGVtcGxhdGUSEgoEbmFtZRgBIAEoCVIEbmFtZRIlCgtkZXNjcmlwdGlvbhgDIAEoCU'
    'gAUgtkZXNjcmlwdGlvbogBAUIOCgxfZGVzY3JpcHRpb24=');

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
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    {'1': 'inputs', '3': 3, '4': 3, '5': 11, '6': '.mizer.nodes.Port', '10': 'inputs'},
    {'1': 'outputs', '3': 4, '4': 3, '5': 11, '6': '.mizer.nodes.Port', '10': 'outputs'},
    {'1': 'designer', '3': 5, '4': 1, '5': 11, '6': '.mizer.nodes.NodeDesigner', '10': 'designer'},
    {'1': 'preview', '3': 6, '4': 1, '5': 14, '6': '.mizer.nodes.Node.NodePreviewType', '10': 'preview'},
    {'1': 'settings', '3': 7, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting', '10': 'settings'},
    {'1': 'details', '3': 8, '4': 1, '5': 11, '6': '.mizer.nodes.NodeDetails', '10': 'details'},
    {'1': 'children', '3': 9, '4': 3, '5': 11, '6': '.mizer.nodes.Node', '10': 'children'},
  ],
  '4': [Node_NodePreviewType$json],
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
    'CgROb2RlEhIKBHR5cGUYASABKAlSBHR5cGUSEgoEcGF0aBgCIAEoCVIEcGF0aBIpCgZpbnB1dH'
    'MYAyADKAsyES5taXplci5ub2Rlcy5Qb3J0UgZpbnB1dHMSKwoHb3V0cHV0cxgEIAMoCzIRLm1p'
    'emVyLm5vZGVzLlBvcnRSB291dHB1dHMSNQoIZGVzaWduZXIYBSABKAsyGS5taXplci5ub2Rlcy'
    '5Ob2RlRGVzaWduZXJSCGRlc2lnbmVyEjsKB3ByZXZpZXcYBiABKA4yIS5taXplci5ub2Rlcy5O'
    'b2RlLk5vZGVQcmV2aWV3VHlwZVIHcHJldmlldxI0CghzZXR0aW5ncxgHIAMoCzIYLm1pemVyLm'
    '5vZGVzLk5vZGVTZXR0aW5nUghzZXR0aW5ncxIyCgdkZXRhaWxzGAggASgLMhgubWl6ZXIubm9k'
    'ZXMuTm9kZURldGFpbHNSB2RldGFpbHMSLQoIY2hpbGRyZW4YCSADKAsyES5taXplci5ub2Rlcy'
    '5Ob2RlUghjaGlsZHJlbiJ0Cg9Ob2RlUHJldmlld1R5cGUSCAoETk9ORRAAEgsKB0hJU1RPUlkQ'
    'ARIMCghXQVZFRk9STRACEgwKCE1VTFRJUExFEAMSCwoHVEVYVFVSRRAEEgwKCFRJTUVDT0RFEA'
    'USCAoEREFUQRAGEgkKBUNPTE9SEAc=');

@$core.Deprecated('Use nodeDetailsDescriptor instead')
const NodeDetails$json = {
  '1': 'NodeDetails',
  '2': [
    {'1': 'node_type_name', '3': 1, '4': 1, '5': 9, '10': 'nodeTypeName'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'has_custom_name', '3': 3, '4': 1, '5': 8, '10': 'hasCustomName'},
    {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.mizer.nodes.NodeCategory', '10': 'category'},
  ],
};

/// Descriptor for `NodeDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDetailsDescriptor = $convert.base64Decode(
    'CgtOb2RlRGV0YWlscxIkCg5ub2RlX3R5cGVfbmFtZRgBIAEoCVIMbm9kZVR5cGVOYW1lEiEKDG'
    'Rpc3BsYXlfbmFtZRgCIAEoCVILZGlzcGxheU5hbWUSJgoPaGFzX2N1c3RvbV9uYW1lGAMgASgI'
    'Ug1oYXNDdXN0b21OYW1lEjUKCGNhdGVnb3J5GAQgASgOMhkubWl6ZXIubm9kZXMuTm9kZUNhdG'
    'Vnb3J5UghjYXRlZ29yeQ==');

@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting$json = {
  '1': 'NodeSetting',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'label', '17': true},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'disabled', '3': 4, '4': 1, '5': 8, '10': 'disabled'},
    {'1': 'text_value', '3': 5, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.TextValue', '9': 0, '10': 'textValue'},
    {'1': 'float_value', '3': 6, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.FloatValue', '9': 0, '10': 'floatValue'},
    {'1': 'int_value', '3': 7, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.IntValue', '9': 0, '10': 'intValue'},
    {'1': 'bool_value', '3': 8, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.BoolValue', '9': 0, '10': 'boolValue'},
    {'1': 'select_value', '3': 9, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.SelectValue', '9': 0, '10': 'selectValue'},
    {'1': 'enum_value', '3': 10, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.EnumValue', '9': 0, '10': 'enumValue'},
    {'1': 'id_value', '3': 11, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.IdValue', '9': 0, '10': 'idValue'},
    {'1': 'spline_value', '3': 12, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.SplineValue', '9': 0, '10': 'splineValue'},
    {'1': 'media_value', '3': 13, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.MediaValue', '9': 0, '10': 'mediaValue'},
    {'1': 'uint_value', '3': 14, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.UintValue', '9': 0, '10': 'uintValue'},
    {'1': 'step_sequencer_value', '3': 15, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.StepSequencerValue', '9': 0, '10': 'stepSequencerValue'},
  ],
  '3': [NodeSetting_TextValue$json, NodeSetting_FloatValue$json, NodeSetting_IntValue$json, NodeSetting_UintValue$json, NodeSetting_BoolValue$json, NodeSetting_SelectValue$json, NodeSetting_SelectVariant$json, NodeSetting_EnumValue$json, NodeSetting_EnumVariant$json, NodeSetting_IdValue$json, NodeSetting_IdVariant$json, NodeSetting_SplineValue$json, NodeSetting_MediaValue$json, NodeSetting_StepSequencerValue$json],
  '8': [
    {'1': 'value'},
    {'1': '_label'},
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
    {'1': 'step_size', '3': 6, '4': 1, '5': 1, '9': 4, '10': 'stepSize', '17': true},
  ],
  '8': [
    {'1': '_min'},
    {'1': '_min_hint'},
    {'1': '_max'},
    {'1': '_max_hint'},
    {'1': '_step_size'},
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
    {'1': 'step_size', '3': 6, '4': 1, '5': 5, '9': 4, '10': 'stepSize', '17': true},
  ],
  '8': [
    {'1': '_min'},
    {'1': '_min_hint'},
    {'1': '_max'},
    {'1': '_max_hint'},
    {'1': '_step_size'},
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
    {'1': 'step_size', '3': 6, '4': 1, '5': 13, '9': 4, '10': 'stepSize', '17': true},
  ],
  '8': [
    {'1': '_min'},
    {'1': '_min_hint'},
    {'1': '_max'},
    {'1': '_max_hint'},
    {'1': '_step_size'},
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
    'CgtOb2RlU2V0dGluZxIOCgJpZBgBIAEoCVICaWQSGQoFbGFiZWwYAiABKAlIAVIFbGFiZWyIAQ'
    'ESIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhoKCGRpc2FibGVkGAQgASgIUghk'
    'aXNhYmxlZBJDCgp0ZXh0X3ZhbHVlGAUgASgLMiIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuVG'
    'V4dFZhbHVlSABSCXRleHRWYWx1ZRJGCgtmbG9hdF92YWx1ZRgGIAEoCzIjLm1pemVyLm5vZGVz'
    'Lk5vZGVTZXR0aW5nLkZsb2F0VmFsdWVIAFIKZmxvYXRWYWx1ZRJACglpbnRfdmFsdWUYByABKA'
    'syIS5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5JbnRWYWx1ZUgAUghpbnRWYWx1ZRJDCgpib29s'
    'X3ZhbHVlGAggASgLMiIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuQm9vbFZhbHVlSABSCWJvb2'
    'xWYWx1ZRJJCgxzZWxlY3RfdmFsdWUYCSABKAsyJC5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5T'
    'ZWxlY3RWYWx1ZUgAUgtzZWxlY3RWYWx1ZRJDCgplbnVtX3ZhbHVlGAogASgLMiIubWl6ZXIubm'
    '9kZXMuTm9kZVNldHRpbmcuRW51bVZhbHVlSABSCWVudW1WYWx1ZRI9CghpZF92YWx1ZRgLIAEo'
    'CzIgLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLklkVmFsdWVIAFIHaWRWYWx1ZRJJCgxzcGxpbm'
    'VfdmFsdWUYDCABKAsyJC5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5TcGxpbmVWYWx1ZUgAUgtz'
    'cGxpbmVWYWx1ZRJGCgttZWRpYV92YWx1ZRgNIAEoCzIjLm1pemVyLm5vZGVzLk5vZGVTZXR0aW'
    '5nLk1lZGlhVmFsdWVIAFIKbWVkaWFWYWx1ZRJDCgp1aW50X3ZhbHVlGA4gASgLMiIubWl6ZXIu'
    'bm9kZXMuTm9kZVNldHRpbmcuVWludFZhbHVlSABSCXVpbnRWYWx1ZRJfChRzdGVwX3NlcXVlbm'
    'Nlcl92YWx1ZRgPIAEoCzIrLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLlN0ZXBTZXF1ZW5jZXJW'
    'YWx1ZUgAUhJzdGVwU2VxdWVuY2VyVmFsdWUaPwoJVGV4dFZhbHVlEhQKBXZhbHVlGAEgASgJUg'
    'V2YWx1ZRIcCgltdWx0aWxpbmUYAiABKAhSCW11bHRpbGluZRrqAQoKRmxvYXRWYWx1ZRIUCgV2'
    'YWx1ZRgBIAEoAVIFdmFsdWUSFQoDbWluGAIgASgBSABSA21pbogBARIeCghtaW5faGludBgDIA'
    'EoAUgBUgdtaW5IaW50iAEBEhUKA21heBgEIAEoAUgCUgNtYXiIAQESHgoIbWF4X2hpbnQYBSAB'
    'KAFIA1IHbWF4SGludIgBARIgCglzdGVwX3NpemUYBiABKAFIBFIIc3RlcFNpemWIAQFCBgoEX2'
    '1pbkILCglfbWluX2hpbnRCBgoEX21heEILCglfbWF4X2hpbnRCDAoKX3N0ZXBfc2l6ZRroAQoI'
    'SW50VmFsdWUSFAoFdmFsdWUYASABKAVSBXZhbHVlEhUKA21pbhgCIAEoBUgAUgNtaW6IAQESHg'
    'oIbWluX2hpbnQYAyABKAVIAVIHbWluSGludIgBARIVCgNtYXgYBCABKAVIAlIDbWF4iAEBEh4K'
    'CG1heF9oaW50GAUgASgFSANSB21heEhpbnSIAQESIAoJc3RlcF9zaXplGAYgASgFSARSCHN0ZX'
    'BTaXpliAEBQgYKBF9taW5CCwoJX21pbl9oaW50QgYKBF9tYXhCCwoJX21heF9oaW50QgwKCl9z'
    'dGVwX3NpemUa6QEKCVVpbnRWYWx1ZRIUCgV2YWx1ZRgBIAEoDVIFdmFsdWUSFQoDbWluGAIgAS'
    'gNSABSA21pbogBARIeCghtaW5faGludBgDIAEoDUgBUgdtaW5IaW50iAEBEhUKA21heBgEIAEo'
    'DUgCUgNtYXiIAQESHgoIbWF4X2hpbnQYBSABKA1IA1IHbWF4SGludIgBARIgCglzdGVwX3Npem'
    'UYBiABKA1IBFIIc3RlcFNpemWIAQFCBgoEX21pbkILCglfbWluX2hpbnRCBgoEX21heEILCglf'
    'bWF4X2hpbnRCDAoKX3N0ZXBfc2l6ZRohCglCb29sVmFsdWUSFAoFdmFsdWUYASABKAhSBXZhbH'
    'VlGmcKC1NlbGVjdFZhbHVlEhQKBXZhbHVlGAEgASgJUgV2YWx1ZRJCCgh2YXJpYW50cxgCIAMo'
    'CzImLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLlNlbGVjdFZhcmlhbnRSCHZhcmlhbnRzGswCCg'
    '1TZWxlY3RWYXJpYW50EkoKBWdyb3VwGAEgASgLMjIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcu'
    'U2VsZWN0VmFyaWFudC5TZWxlY3RHcm91cEgAUgVncm91cBJHCgRpdGVtGAIgASgLMjEubWl6ZX'
    'Iubm9kZXMuTm9kZVNldHRpbmcuU2VsZWN0VmFyaWFudC5TZWxlY3RJdGVtSABSBGl0ZW0aYQoL'
    'U2VsZWN0R3JvdXASFAoFbGFiZWwYASABKAlSBWxhYmVsEjwKBWl0ZW1zGAIgAygLMiYubWl6ZX'
    'Iubm9kZXMuTm9kZVNldHRpbmcuU2VsZWN0VmFyaWFudFIFaXRlbXMaOAoKU2VsZWN0SXRlbRIU'
    'CgV2YWx1ZRgBIAEoCVIFdmFsdWUSFAoFbGFiZWwYAiABKAlSBWxhYmVsQgkKB3ZhcmlhbnQaYw'
    'oJRW51bVZhbHVlEhQKBXZhbHVlGAEgASgNUgV2YWx1ZRJACgh2YXJpYW50cxgCIAMoCzIkLm1p'
    'emVyLm5vZGVzLk5vZGVTZXR0aW5nLkVudW1WYXJpYW50Ugh2YXJpYW50cxo5CgtFbnVtVmFyaW'
    'FudBIUCgV2YWx1ZRgBIAEoDVIFdmFsdWUSFAoFbGFiZWwYAiABKAlSBWxhYmVsGl8KB0lkVmFs'
    'dWUSFAoFdmFsdWUYASABKA1SBXZhbHVlEj4KCHZhcmlhbnRzGAIgAygLMiIubWl6ZXIubm9kZX'
    'MuTm9kZVNldHRpbmcuSWRWYXJpYW50Ugh2YXJpYW50cxo3CglJZFZhcmlhbnQSFAoFdmFsdWUY'
    'ASABKA1SBXZhbHVlEhQKBWxhYmVsGAIgASgJUgVsYWJlbBrGAQoLU3BsaW5lVmFsdWUSRQoFc3'
    'RlcHMYASADKAsyLy5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5TcGxpbmVWYWx1ZS5TcGxpbmVT'
    'dGVwUgVzdGVwcxpwCgpTcGxpbmVTdGVwEgwKAXgYASABKAFSAXgSDAoBeRgCIAEoAVIBeRIQCg'
    'NjMGEYAyABKAFSA2MwYRIQCgNjMGIYBCABKAFSA2MwYhIQCgNjMWEYBSABKAFSA2MxYRIQCgNj'
    'MWIYBiABKAFSA2MxYhpfCgpNZWRpYVZhbHVlEhQKBXZhbHVlGAEgASgJUgV2YWx1ZRI7Cg1hbG'
    'xvd2VkX3R5cGVzGAIgAygOMhYubWl6ZXIubWVkaWEuTWVkaWFUeXBlUgxhbGxvd2VkVHlwZXMa'
    'KgoSU3RlcFNlcXVlbmNlclZhbHVlEhQKBXN0ZXBzGAEgAygIUgVzdGVwc0IHCgV2YWx1ZUIICg'
    'ZfbGFiZWw=');

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
    {'1': 'color', '3': 4, '4': 1, '5': 14, '6': '.mizer.nodes.NodeColor', '9': 0, '10': 'color', '17': true},
  ],
  '8': [
    {'1': '_color'},
  ],
};

/// Descriptor for `NodeDesigner`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDesignerDescriptor = $convert.base64Decode(
    'CgxOb2RlRGVzaWduZXISNQoIcG9zaXRpb24YASABKAsyGS5taXplci5ub2Rlcy5Ob2RlUG9zaX'
    'Rpb25SCHBvc2l0aW9uEhQKBXNjYWxlGAIgASgBUgVzY2FsZRIWCgZoaWRkZW4YAyABKAhSBmhp'
    'ZGRlbhIxCgVjb2xvchgEIAEoDjIWLm1pemVyLm5vZGVzLk5vZGVDb2xvckgAUgVjb2xvcogBAU'
    'IICgZfY29sb3I=');

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

