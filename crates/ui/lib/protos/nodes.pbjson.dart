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
    const {'1': 'NODE_CATEGORY_VECTOR', '2': 11},
    const {'1': 'NODE_CATEGORY_FIXTURES', '2': 12},
    const {'1': 'NODE_CATEGORY_UI', '2': 13},
  ],
};

/// Descriptor for `NodeCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List nodeCategoryDescriptor = $convert.base64Decode('CgxOb2RlQ2F0ZWdvcnkSFgoSTk9ERV9DQVRFR09SWV9OT05FEAASGgoWTk9ERV9DQVRFR09SWV9TVEFOREFSRBABEh0KGU5PREVfQ0FURUdPUllfQ09OTkVDVElPTlMQAhIdChlOT0RFX0NBVEVHT1JZX0NPTlZFUlNJT05TEAMSGgoWTk9ERV9DQVRFR09SWV9DT05UUk9MUxAEEhYKEk5PREVfQ0FURUdPUllfREFUQRAFEhcKE05PREVfQ0FURUdPUllfQ09MT1IQBhIXChNOT0RFX0NBVEVHT1JZX0FVRElPEAcSFwoTTk9ERV9DQVRFR09SWV9WSURFTxAIEhcKE05PREVfQ0FURUdPUllfTEFTRVIQCRIXChNOT0RFX0NBVEVHT1JZX1BJWEVMEAoSGAoUTk9ERV9DQVRFR09SWV9WRUNUT1IQCxIaChZOT0RFX0NBVEVHT1JZX0ZJWFRVUkVTEAwSFAoQTk9ERV9DQVRFR09SWV9VSRAN');
@$core.Deprecated('Use nodeColorDescriptor instead')
const NodeColor$json = const {
  '1': 'NodeColor',
  '2': const [
    const {'1': 'NODE_COLOR_NONE', '2': 0},
    const {'1': 'NODE_COLOR_GREY', '2': 1},
    const {'1': 'NODE_COLOR_RED', '2': 2},
    const {'1': 'NODE_COLOR_DEEP_ORANGE', '2': 3},
    const {'1': 'NODE_COLOR_ORANGE', '2': 4},
    const {'1': 'NODE_COLOR_AMBER', '2': 5},
    const {'1': 'NODE_COLOR_YELLOW', '2': 6},
    const {'1': 'NODE_COLOR_LIME', '2': 7},
    const {'1': 'NODE_COLOR_LIGHT_GREEN', '2': 8},
    const {'1': 'NODE_COLOR_GREEN', '2': 9},
    const {'1': 'NODE_COLOR_TEAL', '2': 10},
    const {'1': 'NODE_COLOR_CYAN', '2': 11},
    const {'1': 'NODE_COLOR_LIGHT_BLUE', '2': 12},
    const {'1': 'NODE_COLOR_BLUE', '2': 13},
    const {'1': 'NODE_COLOR_INDIGO', '2': 14},
    const {'1': 'NODE_COLOR_PURPLE', '2': 15},
    const {'1': 'NODE_COLOR_DEEP_PURPLE', '2': 16},
    const {'1': 'NODE_COLOR_PINK', '2': 17},
    const {'1': 'NODE_COLOR_BLUE_GREY', '2': 18},
    const {'1': 'NODE_COLOR_BROWN', '2': 19},
  ],
};

/// Descriptor for `NodeColor`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List nodeColorDescriptor = $convert.base64Decode('CglOb2RlQ29sb3ISEwoPTk9ERV9DT0xPUl9OT05FEAASEwoPTk9ERV9DT0xPUl9HUkVZEAESEgoOTk9ERV9DT0xPUl9SRUQQAhIaChZOT0RFX0NPTE9SX0RFRVBfT1JBTkdFEAMSFQoRTk9ERV9DT0xPUl9PUkFOR0UQBBIUChBOT0RFX0NPTE9SX0FNQkVSEAUSFQoRTk9ERV9DT0xPUl9ZRUxMT1cQBhITCg9OT0RFX0NPTE9SX0xJTUUQBxIaChZOT0RFX0NPTE9SX0xJR0hUX0dSRUVOEAgSFAoQTk9ERV9DT0xPUl9HUkVFThAJEhMKD05PREVfQ09MT1JfVEVBTBAKEhMKD05PREVfQ09MT1JfQ1lBThALEhkKFU5PREVfQ09MT1JfTElHSFRfQkxVRRAMEhMKD05PREVfQ09MT1JfQkxVRRANEhUKEU5PREVfQ09MT1JfSU5ESUdPEA4SFQoRTk9ERV9DT0xPUl9QVVJQTEUQDxIaChZOT0RFX0NPTE9SX0RFRVBfUFVSUExFEBASEwoPTk9ERV9DT0xPUl9QSU5LEBESGAoUTk9ERV9DT0xPUl9CTFVFX0dSRVkQEhIUChBOT0RFX0NPTE9SX0JST1dOEBM=');
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
    const {'1': 'COLOR', '2': 9},
    const {'1': 'CLOCK', '2': 10},
    const {'1': 'TEXT', '2': 11},
  ],
};

/// Descriptor for `ChannelProtocol`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelProtocolDescriptor = $convert.base64Decode('Cg9DaGFubmVsUHJvdG9jb2wSCgoGU0lOR0xFEAASCQoFTVVMVEkQARILCgdURVhUVVJFEAISCgoGVkVDVE9SEAMSCQoFTEFTRVIQBBIICgRQT0xZEAUSCAoEREFUQRAGEgwKCE1BVEVSSUFMEAcSCQoFQ09MT1IQCRIJCgVDTE9DSxAKEggKBFRFWFQQCw==');
@$core.Deprecated('Use addNodeRequestDescriptor instead')
const AddNodeRequest$json = const {
  '1': 'AddNodeRequest',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.nodes.NodePosition', '10': 'position'},
    const {'1': 'parent', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
    const {'1': 'template', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'template', '17': true},
  ],
  '8': const [
    const {'1': '_parent'},
    const {'1': '_template'},
  ],
};

/// Descriptor for `AddNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addNodeRequestDescriptor = $convert.base64Decode('Cg5BZGROb2RlUmVxdWVzdBISCgR0eXBlGAEgASgJUgR0eXBlEjUKCHBvc2l0aW9uGAIgASgLMhkubWl6ZXIubm9kZXMuTm9kZVBvc2l0aW9uUghwb3NpdGlvbhIbCgZwYXJlbnQYAyABKAlIAFIGcGFyZW50iAEBEh8KCHRlbXBsYXRlGAQgASgJSAFSCHRlbXBsYXRliAEBQgkKB19wYXJlbnRCCwoJX3RlbXBsYXRl');
@$core.Deprecated('Use addCommentRequestDescriptor instead')
const AddCommentRequest$json = const {
  '1': 'AddCommentRequest',
  '2': const [
    const {'1': 'position', '3': 1, '4': 1, '5': 11, '6': '.mizer.nodes.NodePosition', '10': 'position'},
    const {'1': 'width', '3': 2, '4': 1, '5': 1, '10': 'width'},
    const {'1': 'height', '3': 3, '4': 1, '5': 1, '10': 'height'},
    const {'1': 'parent', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
  ],
  '8': const [
    const {'1': '_parent'},
  ],
};

/// Descriptor for `AddCommentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addCommentRequestDescriptor = $convert.base64Decode('ChFBZGRDb21tZW50UmVxdWVzdBI1Cghwb3NpdGlvbhgBIAEoCzIZLm1pemVyLm5vZGVzLk5vZGVQb3NpdGlvblIIcG9zaXRpb24SFAoFd2lkdGgYAiABKAFSBXdpZHRoEhYKBmhlaWdodBgDIAEoAVIGaGVpZ2h0EhsKBnBhcmVudBgEIAEoCUgAUgZwYXJlbnSIAQFCCQoHX3BhcmVudA==');
@$core.Deprecated('Use updateCommentRequestDescriptor instead')
const UpdateCommentRequest$json = const {
  '1': 'UpdateCommentRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'color', '3': 2, '4': 1, '5': 14, '6': '.mizer.nodes.NodeColor', '9': 0, '10': 'color', '17': true},
    const {'1': 'label', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'label', '17': true},
    const {'1': 'show_background', '3': 4, '4': 1, '5': 8, '9': 2, '10': 'showBackground', '17': true},
    const {'1': 'show_border', '3': 5, '4': 1, '5': 8, '9': 3, '10': 'showBorder', '17': true},
  ],
  '8': const [
    const {'1': '_color'},
    const {'1': '_label'},
    const {'1': '_show_background'},
    const {'1': '_show_border'},
  ],
};

/// Descriptor for `UpdateCommentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCommentRequestDescriptor = $convert.base64Decode('ChRVcGRhdGVDb21tZW50UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSMQoFY29sb3IYAiABKA4yFi5taXplci5ub2Rlcy5Ob2RlQ29sb3JIAFIFY29sb3KIAQESGQoFbGFiZWwYAyABKAlIAVIFbGFiZWyIAQESLAoPc2hvd19iYWNrZ3JvdW5kGAQgASgISAJSDnNob3dCYWNrZ3JvdW5kiAEBEiQKC3Nob3dfYm9yZGVyGAUgASgISANSCnNob3dCb3JkZXKIAQFCCAoGX2NvbG9yQggKBl9sYWJlbEISChBfc2hvd19iYWNrZ3JvdW5kQg4KDF9zaG93X2JvcmRlcg==');
@$core.Deprecated('Use duplicateNodesRequestDescriptor instead')
const DuplicateNodesRequest$json = const {
  '1': 'DuplicateNodesRequest',
  '2': const [
    const {'1': 'paths', '3': 1, '4': 3, '5': 9, '10': 'paths'},
    const {'1': 'parent', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
  ],
  '8': const [
    const {'1': '_parent'},
  ],
};

/// Descriptor for `DuplicateNodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List duplicateNodesRequestDescriptor = $convert.base64Decode('ChVEdXBsaWNhdGVOb2Rlc1JlcXVlc3QSFAoFcGF0aHMYASADKAlSBXBhdGhzEhsKBnBhcmVudBgCIAEoCUgAUgZwYXJlbnSIAQFCCQoHX3BhcmVudA==');
@$core.Deprecated('Use disconnectPortRequestDescriptor instead')
const DisconnectPortRequest$json = const {
  '1': 'DisconnectPortRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'port', '3': 2, '4': 1, '5': 9, '10': 'port'},
  ],
};

/// Descriptor for `DisconnectPortRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectPortRequestDescriptor = $convert.base64Decode('ChVEaXNjb25uZWN0UG9ydFJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aBISCgRwb3J0GAIgASgJUgRwb3J0');
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
@$core.Deprecated('Use updateNodeColorRequestDescriptor instead')
const UpdateNodeColorRequest$json = const {
  '1': 'UpdateNodeColorRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'color', '3': 2, '4': 1, '5': 14, '6': '.mizer.nodes.NodeColor', '9': 0, '10': 'color', '17': true},
  ],
  '8': const [
    const {'1': '_color'},
  ],
};

/// Descriptor for `UpdateNodeColorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNodeColorRequestDescriptor = $convert.base64Decode('ChZVcGRhdGVOb2RlQ29sb3JSZXF1ZXN0EhIKBHBhdGgYASABKAlSBHBhdGgSMQoFY29sb3IYAiABKA4yFi5taXplci5ub2Rlcy5Ob2RlQ29sb3JIAFIFY29sb3KIAQFCCAoGX2NvbG9y');
@$core.Deprecated('Use moveNodesRequestDescriptor instead')
const MoveNodesRequest$json = const {
  '1': 'MoveNodesRequest',
  '2': const [
    const {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.MoveNodeRequest', '10': 'nodes'},
  ],
};

/// Descriptor for `MoveNodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveNodesRequestDescriptor = $convert.base64Decode('ChBNb3ZlTm9kZXNSZXF1ZXN0EjIKBW5vZGVzGAEgAygLMhwubWl6ZXIubm9kZXMuTW92ZU5vZGVSZXF1ZXN0UgVub2Rlcw==');
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
@$core.Deprecated('Use deleteNodeRequestDescriptor instead')
const DeleteNodeRequest$json = const {
  '1': 'DeleteNodeRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `DeleteNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteNodeRequestDescriptor = $convert.base64Decode('ChFEZWxldGVOb2RlUmVxdWVzdBISCgRwYXRoGAEgASgJUgRwYXRo');
@$core.Deprecated('Use hideNodeRequestDescriptor instead')
const HideNodeRequest$json = const {
  '1': 'HideNodeRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `HideNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hideNodeRequestDescriptor = $convert.base64Decode('Cg9IaWRlTm9kZVJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aA==');
@$core.Deprecated('Use nodesDescriptor instead')
const Nodes$json = const {
  '1': 'Nodes',
  '2': const [
    const {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.nodes.Node', '10': 'nodes'},
    const {'1': 'channels', '3': 2, '4': 3, '5': 11, '6': '.mizer.nodes.NodeConnection', '10': 'channels'},
    const {'1': 'all_nodes', '3': 3, '4': 3, '5': 11, '6': '.mizer.nodes.Node', '10': 'allNodes'},
    const {'1': 'comments', '3': 4, '4': 3, '5': 11, '6': '.mizer.nodes.NodeCommentArea', '10': 'comments'},
  ],
};

/// Descriptor for `Nodes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodesDescriptor = $convert.base64Decode('CgVOb2RlcxInCgVub2RlcxgBIAMoCzIRLm1pemVyLm5vZGVzLk5vZGVSBW5vZGVzEjcKCGNoYW5uZWxzGAIgAygLMhsubWl6ZXIubm9kZXMuTm9kZUNvbm5lY3Rpb25SCGNoYW5uZWxzEi4KCWFsbF9ub2RlcxgDIAMoCzIRLm1pemVyLm5vZGVzLk5vZGVSCGFsbE5vZGVzEjgKCGNvbW1lbnRzGAQgAygLMhwubWl6ZXIubm9kZXMuTm9kZUNvbW1lbnRBcmVhUghjb21tZW50cw==');
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
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'category', '3': 3, '4': 1, '5': 14, '6': '.mizer.nodes.NodeCategory', '10': 'category'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'settings', '3': 5, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSettingDescription', '10': 'settings'},
    const {'1': 'templates', '3': 6, '4': 3, '5': 11, '6': '.mizer.nodes.NodeTemplate', '10': 'templates'},
  ],
};

/// Descriptor for `AvailableNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List availableNodeDescriptor = $convert.base64Decode('Cg1BdmFpbGFibGVOb2RlEhIKBHR5cGUYASABKAlSBHR5cGUSEgoEbmFtZRgCIAEoCVIEbmFtZRI1CghjYXRlZ29yeRgDIAEoDjIZLm1pemVyLm5vZGVzLk5vZGVDYXRlZ29yeVIIY2F0ZWdvcnkSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEj8KCHNldHRpbmdzGAUgAygLMiMubWl6ZXIubm9kZXMuTm9kZVNldHRpbmdEZXNjcmlwdGlvblIIc2V0dGluZ3MSNwoJdGVtcGxhdGVzGAYgAygLMhkubWl6ZXIubm9kZXMuTm9kZVRlbXBsYXRlUgl0ZW1wbGF0ZXM=');
@$core.Deprecated('Use nodeSettingDescriptionDescriptor instead')
const NodeSettingDescription$json = const {
  '1': 'NodeSettingDescription',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `NodeSettingDescription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeSettingDescriptionDescriptor = $convert.base64Decode('ChZOb2RlU2V0dGluZ0Rlc2NyaXB0aW9uEhIKBG5hbWUYASABKAlSBG5hbWUSIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9u');
@$core.Deprecated('Use nodeTemplateDescriptor instead')
const NodeTemplate$json = const {
  '1': 'NodeTemplate',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'description', '17': true},
  ],
  '8': const [
    const {'1': '_description'},
  ],
};

/// Descriptor for `NodeTemplate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeTemplateDescriptor = $convert.base64Decode('CgxOb2RlVGVtcGxhdGUSEgoEbmFtZRgBIAEoCVIEbmFtZRIlCgtkZXNjcmlwdGlvbhgDIAEoCUgAUgtkZXNjcmlwdGlvbogBAUIOCgxfZGVzY3JpcHRpb24=');
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
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'inputs', '3': 3, '4': 3, '5': 11, '6': '.mizer.nodes.Port', '10': 'inputs'},
    const {'1': 'outputs', '3': 4, '4': 3, '5': 11, '6': '.mizer.nodes.Port', '10': 'outputs'},
    const {'1': 'designer', '3': 5, '4': 1, '5': 11, '6': '.mizer.nodes.NodeDesigner', '10': 'designer'},
    const {'1': 'preview', '3': 6, '4': 1, '5': 14, '6': '.mizer.nodes.Node.NodePreviewType', '10': 'preview'},
    const {'1': 'settings', '3': 7, '4': 3, '5': 11, '6': '.mizer.nodes.NodeSetting', '10': 'settings'},
    const {'1': 'details', '3': 8, '4': 1, '5': 11, '6': '.mizer.nodes.NodeDetails', '10': 'details'},
    const {'1': 'children', '3': 9, '4': 3, '5': 11, '6': '.mizer.nodes.Node', '10': 'children'},
  ],
  '4': const [Node_NodePreviewType$json],
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
final $typed_data.Uint8List nodeDescriptor = $convert.base64Decode('CgROb2RlEhIKBHR5cGUYASABKAlSBHR5cGUSEgoEcGF0aBgCIAEoCVIEcGF0aBIpCgZpbnB1dHMYAyADKAsyES5taXplci5ub2Rlcy5Qb3J0UgZpbnB1dHMSKwoHb3V0cHV0cxgEIAMoCzIRLm1pemVyLm5vZGVzLlBvcnRSB291dHB1dHMSNQoIZGVzaWduZXIYBSABKAsyGS5taXplci5ub2Rlcy5Ob2RlRGVzaWduZXJSCGRlc2lnbmVyEjsKB3ByZXZpZXcYBiABKA4yIS5taXplci5ub2Rlcy5Ob2RlLk5vZGVQcmV2aWV3VHlwZVIHcHJldmlldxI0CghzZXR0aW5ncxgHIAMoCzIYLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nUghzZXR0aW5ncxIyCgdkZXRhaWxzGAggASgLMhgubWl6ZXIubm9kZXMuTm9kZURldGFpbHNSB2RldGFpbHMSLQoIY2hpbGRyZW4YCSADKAsyES5taXplci5ub2Rlcy5Ob2RlUghjaGlsZHJlbiJ0Cg9Ob2RlUHJldmlld1R5cGUSCAoETk9ORRAAEgsKB0hJU1RPUlkQARIMCghXQVZFRk9STRACEgwKCE1VTFRJUExFEAMSCwoHVEVYVFVSRRAEEgwKCFRJTUVDT0RFEAUSCAoEREFUQRAGEgkKBUNPTE9SEAc=');
@$core.Deprecated('Use nodeDetailsDescriptor instead')
const NodeDetails$json = const {
  '1': 'NodeDetails',
  '2': const [
    const {'1': 'node_type_name', '3': 1, '4': 1, '5': 9, '10': 'nodeTypeName'},
    const {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'has_custom_name', '3': 3, '4': 1, '5': 8, '10': 'hasCustomName'},
    const {'1': 'category', '3': 4, '4': 1, '5': 14, '6': '.mizer.nodes.NodeCategory', '10': 'category'},
  ],
};

/// Descriptor for `NodeDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDetailsDescriptor = $convert.base64Decode('CgtOb2RlRGV0YWlscxIkCg5ub2RlX3R5cGVfbmFtZRgBIAEoCVIMbm9kZVR5cGVOYW1lEiEKDGRpc3BsYXlfbmFtZRgCIAEoCVILZGlzcGxheU5hbWUSJgoPaGFzX2N1c3RvbV9uYW1lGAMgASgIUg1oYXNDdXN0b21OYW1lEjUKCGNhdGVnb3J5GAQgASgOMhkubWl6ZXIubm9kZXMuTm9kZUNhdGVnb3J5UghjYXRlZ29yeQ==');
@$core.Deprecated('Use nodeSettingDescriptor instead')
const NodeSetting$json = const {
  '1': 'NodeSetting',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'label', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'label', '17': true},
    const {'1': 'category', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'category', '17': true},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'disabled', '3': 5, '4': 1, '5': 8, '10': 'disabled'},
    const {'1': 'text_value', '3': 6, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.TextValue', '9': 0, '10': 'textValue'},
    const {'1': 'float_value', '3': 7, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.FloatValue', '9': 0, '10': 'floatValue'},
    const {'1': 'int_value', '3': 8, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.IntValue', '9': 0, '10': 'intValue'},
    const {'1': 'bool_value', '3': 9, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.BoolValue', '9': 0, '10': 'boolValue'},
    const {'1': 'select_value', '3': 10, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.SelectValue', '9': 0, '10': 'selectValue'},
    const {'1': 'enum_value', '3': 11, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.EnumValue', '9': 0, '10': 'enumValue'},
    const {'1': 'id_value', '3': 12, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.IdValue', '9': 0, '10': 'idValue'},
    const {'1': 'spline_value', '3': 13, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.SplineValue', '9': 0, '10': 'splineValue'},
    const {'1': 'media_value', '3': 14, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.MediaValue', '9': 0, '10': 'mediaValue'},
    const {'1': 'uint_value', '3': 15, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.UintValue', '9': 0, '10': 'uintValue'},
    const {'1': 'step_sequencer_value', '3': 16, '4': 1, '5': 11, '6': '.mizer.nodes.NodeSetting.StepSequencerValue', '9': 0, '10': 'stepSequencerValue'},
  ],
  '3': const [NodeSetting_TextValue$json, NodeSetting_FloatValue$json, NodeSetting_IntValue$json, NodeSetting_UintValue$json, NodeSetting_BoolValue$json, NodeSetting_SelectValue$json, NodeSetting_SelectVariant$json, NodeSetting_EnumValue$json, NodeSetting_EnumVariant$json, NodeSetting_IdValue$json, NodeSetting_IdVariant$json, NodeSetting_SplineValue$json, NodeSetting_MediaValue$json, NodeSetting_StepSequencerValue$json],
  '8': const [
    const {'1': 'value'},
    const {'1': '_label'},
    const {'1': '_category'},
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
    const {'1': 'step_size', '3': 6, '4': 1, '5': 1, '9': 4, '10': 'stepSize', '17': true},
  ],
  '8': const [
    const {'1': '_min'},
    const {'1': '_min_hint'},
    const {'1': '_max'},
    const {'1': '_max_hint'},
    const {'1': '_step_size'},
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
    const {'1': 'step_size', '3': 6, '4': 1, '5': 5, '9': 4, '10': 'stepSize', '17': true},
  ],
  '8': const [
    const {'1': '_min'},
    const {'1': '_min_hint'},
    const {'1': '_max'},
    const {'1': '_max_hint'},
    const {'1': '_step_size'},
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
    const {'1': 'step_size', '3': 6, '4': 1, '5': 13, '9': 4, '10': 'stepSize', '17': true},
  ],
  '8': const [
    const {'1': '_min'},
    const {'1': '_min_hint'},
    const {'1': '_max'},
    const {'1': '_max_hint'},
    const {'1': '_step_size'},
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
final $typed_data.Uint8List nodeSettingDescriptor = $convert.base64Decode('CgtOb2RlU2V0dGluZxIOCgJpZBgBIAEoCVICaWQSGQoFbGFiZWwYAiABKAlIAVIFbGFiZWyIAQESHwoIY2F0ZWdvcnkYAyABKAlIAlIIY2F0ZWdvcnmIAQESIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEhoKCGRpc2FibGVkGAUgASgIUghkaXNhYmxlZBJDCgp0ZXh0X3ZhbHVlGAYgASgLMiIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuVGV4dFZhbHVlSABSCXRleHRWYWx1ZRJGCgtmbG9hdF92YWx1ZRgHIAEoCzIjLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLkZsb2F0VmFsdWVIAFIKZmxvYXRWYWx1ZRJACglpbnRfdmFsdWUYCCABKAsyIS5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5JbnRWYWx1ZUgAUghpbnRWYWx1ZRJDCgpib29sX3ZhbHVlGAkgASgLMiIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuQm9vbFZhbHVlSABSCWJvb2xWYWx1ZRJJCgxzZWxlY3RfdmFsdWUYCiABKAsyJC5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5TZWxlY3RWYWx1ZUgAUgtzZWxlY3RWYWx1ZRJDCgplbnVtX3ZhbHVlGAsgASgLMiIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuRW51bVZhbHVlSABSCWVudW1WYWx1ZRI9CghpZF92YWx1ZRgMIAEoCzIgLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLklkVmFsdWVIAFIHaWRWYWx1ZRJJCgxzcGxpbmVfdmFsdWUYDSABKAsyJC5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5TcGxpbmVWYWx1ZUgAUgtzcGxpbmVWYWx1ZRJGCgttZWRpYV92YWx1ZRgOIAEoCzIjLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLk1lZGlhVmFsdWVIAFIKbWVkaWFWYWx1ZRJDCgp1aW50X3ZhbHVlGA8gASgLMiIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuVWludFZhbHVlSABSCXVpbnRWYWx1ZRJfChRzdGVwX3NlcXVlbmNlcl92YWx1ZRgQIAEoCzIrLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLlN0ZXBTZXF1ZW5jZXJWYWx1ZUgAUhJzdGVwU2VxdWVuY2VyVmFsdWUaPwoJVGV4dFZhbHVlEhQKBXZhbHVlGAEgASgJUgV2YWx1ZRIcCgltdWx0aWxpbmUYAiABKAhSCW11bHRpbGluZRrqAQoKRmxvYXRWYWx1ZRIUCgV2YWx1ZRgBIAEoAVIFdmFsdWUSFQoDbWluGAIgASgBSABSA21pbogBARIeCghtaW5faGludBgDIAEoAUgBUgdtaW5IaW50iAEBEhUKA21heBgEIAEoAUgCUgNtYXiIAQESHgoIbWF4X2hpbnQYBSABKAFIA1IHbWF4SGludIgBARIgCglzdGVwX3NpemUYBiABKAFIBFIIc3RlcFNpemWIAQFCBgoEX21pbkILCglfbWluX2hpbnRCBgoEX21heEILCglfbWF4X2hpbnRCDAoKX3N0ZXBfc2l6ZRroAQoISW50VmFsdWUSFAoFdmFsdWUYASABKAVSBXZhbHVlEhUKA21pbhgCIAEoBUgAUgNtaW6IAQESHgoIbWluX2hpbnQYAyABKAVIAVIHbWluSGludIgBARIVCgNtYXgYBCABKAVIAlIDbWF4iAEBEh4KCG1heF9oaW50GAUgASgFSANSB21heEhpbnSIAQESIAoJc3RlcF9zaXplGAYgASgFSARSCHN0ZXBTaXpliAEBQgYKBF9taW5CCwoJX21pbl9oaW50QgYKBF9tYXhCCwoJX21heF9oaW50QgwKCl9zdGVwX3NpemUa6QEKCVVpbnRWYWx1ZRIUCgV2YWx1ZRgBIAEoDVIFdmFsdWUSFQoDbWluGAIgASgNSABSA21pbogBARIeCghtaW5faGludBgDIAEoDUgBUgdtaW5IaW50iAEBEhUKA21heBgEIAEoDUgCUgNtYXiIAQESHgoIbWF4X2hpbnQYBSABKA1IA1IHbWF4SGludIgBARIgCglzdGVwX3NpemUYBiABKA1IBFIIc3RlcFNpemWIAQFCBgoEX21pbkILCglfbWluX2hpbnRCBgoEX21heEILCglfbWF4X2hpbnRCDAoKX3N0ZXBfc2l6ZRohCglCb29sVmFsdWUSFAoFdmFsdWUYASABKAhSBXZhbHVlGmcKC1NlbGVjdFZhbHVlEhQKBXZhbHVlGAEgASgJUgV2YWx1ZRJCCgh2YXJpYW50cxgCIAMoCzImLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLlNlbGVjdFZhcmlhbnRSCHZhcmlhbnRzGswCCg1TZWxlY3RWYXJpYW50EkoKBWdyb3VwGAEgASgLMjIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuU2VsZWN0VmFyaWFudC5TZWxlY3RHcm91cEgAUgVncm91cBJHCgRpdGVtGAIgASgLMjEubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuU2VsZWN0VmFyaWFudC5TZWxlY3RJdGVtSABSBGl0ZW0aYQoLU2VsZWN0R3JvdXASFAoFbGFiZWwYASABKAlSBWxhYmVsEjwKBWl0ZW1zGAIgAygLMiYubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuU2VsZWN0VmFyaWFudFIFaXRlbXMaOAoKU2VsZWN0SXRlbRIUCgV2YWx1ZRgBIAEoCVIFdmFsdWUSFAoFbGFiZWwYAiABKAlSBWxhYmVsQgkKB3ZhcmlhbnQaYwoJRW51bVZhbHVlEhQKBXZhbHVlGAEgASgNUgV2YWx1ZRJACgh2YXJpYW50cxgCIAMoCzIkLm1pemVyLm5vZGVzLk5vZGVTZXR0aW5nLkVudW1WYXJpYW50Ugh2YXJpYW50cxo5CgtFbnVtVmFyaWFudBIUCgV2YWx1ZRgBIAEoDVIFdmFsdWUSFAoFbGFiZWwYAiABKAlSBWxhYmVsGl8KB0lkVmFsdWUSFAoFdmFsdWUYASABKA1SBXZhbHVlEj4KCHZhcmlhbnRzGAIgAygLMiIubWl6ZXIubm9kZXMuTm9kZVNldHRpbmcuSWRWYXJpYW50Ugh2YXJpYW50cxo3CglJZFZhcmlhbnQSFAoFdmFsdWUYASABKA1SBXZhbHVlEhQKBWxhYmVsGAIgASgJUgVsYWJlbBrGAQoLU3BsaW5lVmFsdWUSRQoFc3RlcHMYASADKAsyLy5taXplci5ub2Rlcy5Ob2RlU2V0dGluZy5TcGxpbmVWYWx1ZS5TcGxpbmVTdGVwUgVzdGVwcxpwCgpTcGxpbmVTdGVwEgwKAXgYASABKAFSAXgSDAoBeRgCIAEoAVIBeRIQCgNjMGEYAyABKAFSA2MwYRIQCgNjMGIYBCABKAFSA2MwYhIQCgNjMWEYBSABKAFSA2MxYRIQCgNjMWIYBiABKAFSA2MxYhpfCgpNZWRpYVZhbHVlEhQKBXZhbHVlGAEgASgJUgV2YWx1ZRI7Cg1hbGxvd2VkX3R5cGVzGAIgAygOMhYubWl6ZXIubWVkaWEuTWVkaWFUeXBlUgxhbGxvd2VkVHlwZXMaKgoSU3RlcFNlcXVlbmNlclZhbHVlEhQKBXN0ZXBzGAEgAygIUgVzdGVwc0IHCgV2YWx1ZUIICgZfbGFiZWxCCwoJX2NhdGVnb3J5');
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
    const {'1': 'color', '3': 4, '4': 1, '5': 14, '6': '.mizer.nodes.NodeColor', '9': 0, '10': 'color', '17': true},
  ],
  '8': const [
    const {'1': '_color'},
  ],
};

/// Descriptor for `NodeDesigner`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDesignerDescriptor = $convert.base64Decode('CgxOb2RlRGVzaWduZXISNQoIcG9zaXRpb24YASABKAsyGS5taXplci5ub2Rlcy5Ob2RlUG9zaXRpb25SCHBvc2l0aW9uEhQKBXNjYWxlGAIgASgBUgVzY2FsZRIWCgZoaWRkZW4YAyABKAhSBmhpZGRlbhIxCgVjb2xvchgEIAEoDjIWLm1pemVyLm5vZGVzLk5vZGVDb2xvckgAUgVjb2xvcogBAUIICgZfY29sb3I=');
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
@$core.Deprecated('Use nodeCommentAreaDescriptor instead')
const NodeCommentArea$json = const {
  '1': 'NodeCommentArea',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'width', '3': 2, '4': 1, '5': 1, '10': 'width'},
    const {'1': 'height', '3': 3, '4': 1, '5': 1, '10': 'height'},
    const {'1': 'designer', '3': 4, '4': 1, '5': 11, '6': '.mizer.nodes.NodeDesigner', '10': 'designer'},
    const {'1': 'label', '3': 5, '4': 1, '5': 9, '9': 0, '10': 'label', '17': true},
    const {'1': 'show_background', '3': 6, '4': 1, '5': 8, '10': 'showBackground'},
    const {'1': 'show_border', '3': 7, '4': 1, '5': 8, '10': 'showBorder'},
    const {'1': 'parent', '3': 8, '4': 1, '5': 9, '9': 1, '10': 'parent', '17': true},
  ],
  '8': const [
    const {'1': '_label'},
    const {'1': '_parent'},
  ],
};

/// Descriptor for `NodeCommentArea`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeCommentAreaDescriptor = $convert.base64Decode('Cg9Ob2RlQ29tbWVudEFyZWESDgoCaWQYASABKAlSAmlkEhQKBXdpZHRoGAIgASgBUgV3aWR0aBIWCgZoZWlnaHQYAyABKAFSBmhlaWdodBI1CghkZXNpZ25lchgEIAEoCzIZLm1pemVyLm5vZGVzLk5vZGVEZXNpZ25lclIIZGVzaWduZXISGQoFbGFiZWwYBSABKAlIAFIFbGFiZWyIAQESJwoPc2hvd19iYWNrZ3JvdW5kGAYgASgIUg5zaG93QmFja2dyb3VuZBIfCgtzaG93X2JvcmRlchgHIAEoCFIKc2hvd0JvcmRlchIbCgZwYXJlbnQYCCABKAlIAVIGcGFyZW50iAEBQggKBl9sYWJlbEIJCgdfcGFyZW50');
