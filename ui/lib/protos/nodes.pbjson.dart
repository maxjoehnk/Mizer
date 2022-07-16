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
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.Node.NodeType', '10': 'type'},
    const {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.NodePosition', '10': 'position'},
    const {'1': 'parent', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
  ],
  '8': const [
    const {'1': '_parent'},
  ],
};

/// Descriptor for `AddNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addNodeRequestDescriptor = $convert.base64Decode('Cg5BZGROb2RlUmVxdWVzdBIoCgR0eXBlGAEgASgOMhQubWl6ZXIuTm9kZS5Ob2RlVHlwZVIEdHlwZRIvCghwb3NpdGlvbhgCIAEoCzITLm1pemVyLk5vZGVQb3NpdGlvblIIcG9zaXRpb24SGwoGcGFyZW50GAMgASgJSABSBnBhcmVudIgBAUIJCgdfcGFyZW50');
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
    const {'1': 'config', '3': 2, '4': 1, '5': 11, '6': '.mizer.NodeConfig', '10': 'config'},
  ],
};

/// Descriptor for `UpdateNodeConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNodeConfigRequestDescriptor = $convert.base64Decode('ChdVcGRhdGVOb2RlQ29uZmlnUmVxdWVzdBISCgRwYXRoGAEgASgJUgRwYXRoEikKBmNvbmZpZxgCIAEoCzIRLm1pemVyLk5vZGVDb25maWdSBmNvbmZpZw==');
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
    const {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.NodePosition', '10': 'position'},
  ],
};

/// Descriptor for `MoveNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveNodeRequestDescriptor = $convert.base64Decode('Cg9Nb3ZlTm9kZVJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aBIvCghwb3NpdGlvbhgCIAEoCzITLm1pemVyLk5vZGVQb3NpdGlvblIIcG9zaXRpb24=');
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
    const {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.NodePosition', '10': 'position'},
    const {'1': 'parent', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
  ],
  '8': const [
    const {'1': '_parent'},
  ],
};

/// Descriptor for `ShowNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List showNodeRequestDescriptor = $convert.base64Decode('Cg9TaG93Tm9kZVJlcXVlc3QSEgoEcGF0aBgBIAEoCVIEcGF0aBIvCghwb3NpdGlvbhgCIAEoCzITLm1pemVyLk5vZGVQb3NpdGlvblIIcG9zaXRpb24SGwoGcGFyZW50GAMgASgJSABSBnBhcmVudIgBAUIJCgdfcGFyZW50');
@$core.Deprecated('Use showNodeResponseDescriptor instead')
const ShowNodeResponse$json = const {
  '1': 'ShowNodeResponse',
};

/// Descriptor for `ShowNodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List showNodeResponseDescriptor = $convert.base64Decode('ChBTaG93Tm9kZVJlc3BvbnNl');
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
    const {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.Node', '10': 'nodes'},
    const {'1': 'channels', '3': 2, '4': 3, '5': 11, '6': '.mizer.NodeConnection', '10': 'channels'},
    const {'1': 'all_nodes', '3': 3, '4': 3, '5': 11, '6': '.mizer.Node', '10': 'allNodes'},
  ],
};

/// Descriptor for `Nodes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodesDescriptor = $convert.base64Decode('CgVOb2RlcxIhCgVub2RlcxgBIAMoCzILLm1pemVyLk5vZGVSBW5vZGVzEjEKCGNoYW5uZWxzGAIgAygLMhUubWl6ZXIuTm9kZUNvbm5lY3Rpb25SCGNoYW5uZWxzEigKCWFsbF9ub2RlcxgDIAMoCzILLm1pemVyLk5vZGVSCGFsbE5vZGVz');
@$core.Deprecated('Use nodeConnectionDescriptor instead')
const NodeConnection$json = const {
  '1': 'NodeConnection',
  '2': const [
    const {'1': 'targetNode', '3': 1, '4': 1, '5': 9, '10': 'targetNode'},
    const {'1': 'targetPort', '3': 2, '4': 1, '5': 11, '6': '.mizer.Port', '10': 'targetPort'},
    const {'1': 'sourceNode', '3': 3, '4': 1, '5': 9, '10': 'sourceNode'},
    const {'1': 'sourcePort', '3': 4, '4': 1, '5': 11, '6': '.mizer.Port', '10': 'sourcePort'},
    const {'1': 'protocol', '3': 5, '4': 1, '5': 14, '6': '.mizer.ChannelProtocol', '10': 'protocol'},
  ],
};

/// Descriptor for `NodeConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeConnectionDescriptor = $convert.base64Decode('Cg5Ob2RlQ29ubmVjdGlvbhIeCgp0YXJnZXROb2RlGAEgASgJUgp0YXJnZXROb2RlEisKCnRhcmdldFBvcnQYAiABKAsyCy5taXplci5Qb3J0Ugp0YXJnZXRQb3J0Eh4KCnNvdXJjZU5vZGUYAyABKAlSCnNvdXJjZU5vZGUSKwoKc291cmNlUG9ydBgEIAEoCzILLm1pemVyLlBvcnRSCnNvdXJjZVBvcnQSMgoIcHJvdG9jb2wYBSABKA4yFi5taXplci5DaGFubmVsUHJvdG9jb2xSCHByb3RvY29s');
@$core.Deprecated('Use nodeDescriptor instead')
const Node$json = const {
  '1': 'Node',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.Node.NodeType', '10': 'type'},
    const {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'inputs', '3': 3, '4': 3, '5': 11, '6': '.mizer.Port', '10': 'inputs'},
    const {'1': 'outputs', '3': 4, '4': 3, '5': 11, '6': '.mizer.Port', '10': 'outputs'},
    const {'1': 'designer', '3': 5, '4': 1, '5': 11, '6': '.mizer.NodeDesigner', '10': 'designer'},
    const {'1': 'preview', '3': 6, '4': 1, '5': 14, '6': '.mizer.Node.NodePreviewType', '10': 'preview'},
    const {'1': 'config', '3': 7, '4': 1, '5': 11, '6': '.mizer.NodeConfig', '10': 'config'},
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
final $typed_data.Uint8List nodeDescriptor = $convert.base64Decode('CgROb2RlEigKBHR5cGUYASABKA4yFC5taXplci5Ob2RlLk5vZGVUeXBlUgR0eXBlEhIKBHBhdGgYAiABKAlSBHBhdGgSIwoGaW5wdXRzGAMgAygLMgsubWl6ZXIuUG9ydFIGaW5wdXRzEiUKB291dHB1dHMYBCADKAsyCy5taXplci5Qb3J0UgdvdXRwdXRzEi8KCGRlc2lnbmVyGAUgASgLMhMubWl6ZXIuTm9kZURlc2lnbmVyUghkZXNpZ25lchI1CgdwcmV2aWV3GAYgASgOMhsubWl6ZXIuTm9kZS5Ob2RlUHJldmlld1R5cGVSB3ByZXZpZXcSKQoGY29uZmlnGAcgASgLMhEubWl6ZXIuTm9kZUNvbmZpZ1IGY29uZmlnIo0ECghOb2RlVHlwZRIJCgVGYWRlchAAEgoKBkJ1dHRvbhABEg4KCk9zY2lsbGF0b3IQAhIJCgVDbG9jaxADEgoKBlNjcmlwdBAEEgwKCEVudmVsb3BlEAUSDAoIU2VxdWVuY2UQBhIKCgZTZWxlY3QQBxIJCgVNZXJnZRAIEg0KCVRocmVzaG9sZBAJEg0KCURteE91dHB1dBAKEgwKCE9zY0lucHV0EAsSDQoJT3NjT3V0cHV0EAwSDQoJTWlkaUlucHV0EA0SDgoKTWlkaU91dHB1dBAOEg0KCVNlcXVlbmNlchAPEgsKB0ZpeHR1cmUQEBIOCgpQcm9ncmFtbWVyEBESCQoFR3JvdXAQEhIKCgZQcmVzZXQQExINCglWaWRlb0ZpbGUQFBIPCgtWaWRlb091dHB1dBAVEg8KC1ZpZGVvRWZmZWN0EBYSFQoRVmlkZW9Db2xvckJhbGFuY2UQFxISCg5WaWRlb1RyYW5zZm9ybRAYEg4KClBpeGVsVG9EbXgQHhIQCgxQaXhlbFBhdHRlcm4QHxINCglPcGNPdXRwdXQQIBIJCgVMYXNlchAoEgwKCElsZGFGaWxlECkSCwoHR2FtZXBhZBAtEgwKCENvbG9yUmdiEDISDAoIQ29sb3JIc3YQMxINCglDb250YWluZXIQZBILCgdFbmNvZGVyEDcSCAoETWF0aBA4IlEKD05vZGVQcmV2aWV3VHlwZRILCgdIaXN0b3J5EAASDAoIV2F2ZWZvcm0QARIMCghNdWx0aXBsZRACEgsKB1RleHR1cmUQAxIICgROb25lEAQ=');
@$core.Deprecated('Use nodeConfigDescriptor instead')
const NodeConfig$json = const {
  '1': 'NodeConfig',
  '2': const [
    const {'1': 'oscillatorConfig', '3': 10, '4': 1, '5': 11, '6': '.mizer.OscillatorNodeConfig', '9': 0, '10': 'oscillatorConfig'},
    const {'1': 'scriptingConfig', '3': 11, '4': 1, '5': 11, '6': '.mizer.ScriptingNodeConfig', '9': 0, '10': 'scriptingConfig'},
    const {'1': 'sequenceConfig', '3': 12, '4': 1, '5': 11, '6': '.mizer.SequenceNodeConfig', '9': 0, '10': 'sequenceConfig'},
    const {'1': 'clockConfig', '3': 13, '4': 1, '5': 11, '6': '.mizer.ClockNodeConfig', '9': 0, '10': 'clockConfig'},
    const {'1': 'fixtureConfig', '3': 14, '4': 1, '5': 11, '6': '.mizer.FixtureNodeConfig', '9': 0, '10': 'fixtureConfig'},
    const {'1': 'buttonConfig', '3': 15, '4': 1, '5': 11, '6': '.mizer.ButtonNodeConfig', '9': 0, '10': 'buttonConfig'},
    const {'1': 'faderConfig', '3': 16, '4': 1, '5': 11, '6': '.mizer.FaderNodeConfig', '9': 0, '10': 'faderConfig'},
    const {'1': 'ildaFileConfig', '3': 17, '4': 1, '5': 11, '6': '.mizer.IldaFileNodeConfig', '9': 0, '10': 'ildaFileConfig'},
    const {'1': 'laserConfig', '3': 18, '4': 1, '5': 11, '6': '.mizer.LaserNodeConfig', '9': 0, '10': 'laserConfig'},
    const {'1': 'pixelPatternConfig', '3': 19, '4': 1, '5': 11, '6': '.mizer.PixelPatternNodeConfig', '9': 0, '10': 'pixelPatternConfig'},
    const {'1': 'pixelDmxConfig', '3': 20, '4': 1, '5': 11, '6': '.mizer.PixelDmxNodeConfig', '9': 0, '10': 'pixelDmxConfig'},
    const {'1': 'dmxOutputConfig', '3': 21, '4': 1, '5': 11, '6': '.mizer.DmxOutputNodeConfig', '9': 0, '10': 'dmxOutputConfig'},
    const {'1': 'midiInputConfig', '3': 22, '4': 1, '5': 11, '6': '.mizer.MidiNodeConfig', '9': 0, '10': 'midiInputConfig'},
    const {'1': 'midiOutputConfig', '3': 23, '4': 1, '5': 11, '6': '.mizer.MidiNodeConfig', '9': 0, '10': 'midiOutputConfig'},
    const {'1': 'opcOutputConfig', '3': 24, '4': 1, '5': 11, '6': '.mizer.OpcOutputNodeConfig', '9': 0, '10': 'opcOutputConfig'},
    const {'1': 'oscInputConfig', '3': 25, '4': 1, '5': 11, '6': '.mizer.OscNodeConfig', '9': 0, '10': 'oscInputConfig'},
    const {'1': 'oscOutputConfig', '3': 26, '4': 1, '5': 11, '6': '.mizer.OscNodeConfig', '9': 0, '10': 'oscOutputConfig'},
    const {'1': 'videoColorBalanceConfig', '3': 27, '4': 1, '5': 11, '6': '.mizer.VideoColorBalanceNodeConfig', '9': 0, '10': 'videoColorBalanceConfig'},
    const {'1': 'videoEffectConfig', '3': 28, '4': 1, '5': 11, '6': '.mizer.VideoEffectNodeConfig', '9': 0, '10': 'videoEffectConfig'},
    const {'1': 'videoFileConfig', '3': 29, '4': 1, '5': 11, '6': '.mizer.VideoFileNodeConfig', '9': 0, '10': 'videoFileConfig'},
    const {'1': 'videoOutputConfig', '3': 30, '4': 1, '5': 11, '6': '.mizer.VideoOutputNodeConfig', '9': 0, '10': 'videoOutputConfig'},
    const {'1': 'videoTransformConfig', '3': 31, '4': 1, '5': 11, '6': '.mizer.VideoTransformNodeConfig', '9': 0, '10': 'videoTransformConfig'},
    const {'1': 'selectConfig', '3': 32, '4': 1, '5': 11, '6': '.mizer.SelectNodeConfig', '9': 0, '10': 'selectConfig'},
    const {'1': 'mergeConfig', '3': 33, '4': 1, '5': 11, '6': '.mizer.MergeNodeConfig', '9': 0, '10': 'mergeConfig'},
    const {'1': 'envelopeConfig', '3': 34, '4': 1, '5': 11, '6': '.mizer.EnvelopeNodeConfig', '9': 0, '10': 'envelopeConfig'},
    const {'1': 'sequencerConfig', '3': 35, '4': 1, '5': 11, '6': '.mizer.SequencerNodeConfig', '9': 0, '10': 'sequencerConfig'},
    const {'1': 'programmerConfig', '3': 36, '4': 1, '5': 11, '6': '.mizer.ProgrammerNodeConfig', '9': 0, '10': 'programmerConfig'},
    const {'1': 'groupConfig', '3': 37, '4': 1, '5': 11, '6': '.mizer.GroupNodeConfig', '9': 0, '10': 'groupConfig'},
    const {'1': 'presetConfig', '3': 38, '4': 1, '5': 11, '6': '.mizer.PresetNodeConfig', '9': 0, '10': 'presetConfig'},
    const {'1': 'colorRgbConfig', '3': 40, '4': 1, '5': 11, '6': '.mizer.ColorRgbNodeConfig', '9': 0, '10': 'colorRgbConfig'},
    const {'1': 'colorHsvConfig', '3': 41, '4': 1, '5': 11, '6': '.mizer.ColorHsvNodeConfig', '9': 0, '10': 'colorHsvConfig'},
    const {'1': 'gamepadNodeConfig', '3': 42, '4': 1, '5': 11, '6': '.mizer.GamepadNodeConfig', '9': 0, '10': 'gamepadNodeConfig'},
    const {'1': 'thresholdConfig', '3': 43, '4': 1, '5': 11, '6': '.mizer.ThresholdNodeConfig', '9': 0, '10': 'thresholdConfig'},
    const {'1': 'encoderConfig', '3': 44, '4': 1, '5': 11, '6': '.mizer.EncoderNodeConfig', '9': 0, '10': 'encoderConfig'},
    const {'1': 'containerConfig', '3': 45, '4': 1, '5': 11, '6': '.mizer.ContainerNodeConfig', '9': 0, '10': 'containerConfig'},
    const {'1': 'mathConfig', '3': 46, '4': 1, '5': 11, '6': '.mizer.MathNodeConfig', '9': 0, '10': 'mathConfig'},
  ],
  '8': const [
    const {'1': 'type'},
  ],
};

/// Descriptor for `NodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeConfigDescriptor = $convert.base64Decode('CgpOb2RlQ29uZmlnEkkKEG9zY2lsbGF0b3JDb25maWcYCiABKAsyGy5taXplci5Pc2NpbGxhdG9yTm9kZUNvbmZpZ0gAUhBvc2NpbGxhdG9yQ29uZmlnEkYKD3NjcmlwdGluZ0NvbmZpZxgLIAEoCzIaLm1pemVyLlNjcmlwdGluZ05vZGVDb25maWdIAFIPc2NyaXB0aW5nQ29uZmlnEkMKDnNlcXVlbmNlQ29uZmlnGAwgASgLMhkubWl6ZXIuU2VxdWVuY2VOb2RlQ29uZmlnSABSDnNlcXVlbmNlQ29uZmlnEjoKC2Nsb2NrQ29uZmlnGA0gASgLMhYubWl6ZXIuQ2xvY2tOb2RlQ29uZmlnSABSC2Nsb2NrQ29uZmlnEkAKDWZpeHR1cmVDb25maWcYDiABKAsyGC5taXplci5GaXh0dXJlTm9kZUNvbmZpZ0gAUg1maXh0dXJlQ29uZmlnEj0KDGJ1dHRvbkNvbmZpZxgPIAEoCzIXLm1pemVyLkJ1dHRvbk5vZGVDb25maWdIAFIMYnV0dG9uQ29uZmlnEjoKC2ZhZGVyQ29uZmlnGBAgASgLMhYubWl6ZXIuRmFkZXJOb2RlQ29uZmlnSABSC2ZhZGVyQ29uZmlnEkMKDmlsZGFGaWxlQ29uZmlnGBEgASgLMhkubWl6ZXIuSWxkYUZpbGVOb2RlQ29uZmlnSABSDmlsZGFGaWxlQ29uZmlnEjoKC2xhc2VyQ29uZmlnGBIgASgLMhYubWl6ZXIuTGFzZXJOb2RlQ29uZmlnSABSC2xhc2VyQ29uZmlnEk8KEnBpeGVsUGF0dGVybkNvbmZpZxgTIAEoCzIdLm1pemVyLlBpeGVsUGF0dGVybk5vZGVDb25maWdIAFIScGl4ZWxQYXR0ZXJuQ29uZmlnEkMKDnBpeGVsRG14Q29uZmlnGBQgASgLMhkubWl6ZXIuUGl4ZWxEbXhOb2RlQ29uZmlnSABSDnBpeGVsRG14Q29uZmlnEkYKD2RteE91dHB1dENvbmZpZxgVIAEoCzIaLm1pemVyLkRteE91dHB1dE5vZGVDb25maWdIAFIPZG14T3V0cHV0Q29uZmlnEkEKD21pZGlJbnB1dENvbmZpZxgWIAEoCzIVLm1pemVyLk1pZGlOb2RlQ29uZmlnSABSD21pZGlJbnB1dENvbmZpZxJDChBtaWRpT3V0cHV0Q29uZmlnGBcgASgLMhUubWl6ZXIuTWlkaU5vZGVDb25maWdIAFIQbWlkaU91dHB1dENvbmZpZxJGCg9vcGNPdXRwdXRDb25maWcYGCABKAsyGi5taXplci5PcGNPdXRwdXROb2RlQ29uZmlnSABSD29wY091dHB1dENvbmZpZxI+Cg5vc2NJbnB1dENvbmZpZxgZIAEoCzIULm1pemVyLk9zY05vZGVDb25maWdIAFIOb3NjSW5wdXRDb25maWcSQAoPb3NjT3V0cHV0Q29uZmlnGBogASgLMhQubWl6ZXIuT3NjTm9kZUNvbmZpZ0gAUg9vc2NPdXRwdXRDb25maWcSXgoXdmlkZW9Db2xvckJhbGFuY2VDb25maWcYGyABKAsyIi5taXplci5WaWRlb0NvbG9yQmFsYW5jZU5vZGVDb25maWdIAFIXdmlkZW9Db2xvckJhbGFuY2VDb25maWcSTAoRdmlkZW9FZmZlY3RDb25maWcYHCABKAsyHC5taXplci5WaWRlb0VmZmVjdE5vZGVDb25maWdIAFIRdmlkZW9FZmZlY3RDb25maWcSRgoPdmlkZW9GaWxlQ29uZmlnGB0gASgLMhoubWl6ZXIuVmlkZW9GaWxlTm9kZUNvbmZpZ0gAUg92aWRlb0ZpbGVDb25maWcSTAoRdmlkZW9PdXRwdXRDb25maWcYHiABKAsyHC5taXplci5WaWRlb091dHB1dE5vZGVDb25maWdIAFIRdmlkZW9PdXRwdXRDb25maWcSVQoUdmlkZW9UcmFuc2Zvcm1Db25maWcYHyABKAsyHy5taXplci5WaWRlb1RyYW5zZm9ybU5vZGVDb25maWdIAFIUdmlkZW9UcmFuc2Zvcm1Db25maWcSPQoMc2VsZWN0Q29uZmlnGCAgASgLMhcubWl6ZXIuU2VsZWN0Tm9kZUNvbmZpZ0gAUgxzZWxlY3RDb25maWcSOgoLbWVyZ2VDb25maWcYISABKAsyFi5taXplci5NZXJnZU5vZGVDb25maWdIAFILbWVyZ2VDb25maWcSQwoOZW52ZWxvcGVDb25maWcYIiABKAsyGS5taXplci5FbnZlbG9wZU5vZGVDb25maWdIAFIOZW52ZWxvcGVDb25maWcSRgoPc2VxdWVuY2VyQ29uZmlnGCMgASgLMhoubWl6ZXIuU2VxdWVuY2VyTm9kZUNvbmZpZ0gAUg9zZXF1ZW5jZXJDb25maWcSSQoQcHJvZ3JhbW1lckNvbmZpZxgkIAEoCzIbLm1pemVyLlByb2dyYW1tZXJOb2RlQ29uZmlnSABSEHByb2dyYW1tZXJDb25maWcSOgoLZ3JvdXBDb25maWcYJSABKAsyFi5taXplci5Hcm91cE5vZGVDb25maWdIAFILZ3JvdXBDb25maWcSPQoMcHJlc2V0Q29uZmlnGCYgASgLMhcubWl6ZXIuUHJlc2V0Tm9kZUNvbmZpZ0gAUgxwcmVzZXRDb25maWcSQwoOY29sb3JSZ2JDb25maWcYKCABKAsyGS5taXplci5Db2xvclJnYk5vZGVDb25maWdIAFIOY29sb3JSZ2JDb25maWcSQwoOY29sb3JIc3ZDb25maWcYKSABKAsyGS5taXplci5Db2xvckhzdk5vZGVDb25maWdIAFIOY29sb3JIc3ZDb25maWcSSAoRZ2FtZXBhZE5vZGVDb25maWcYKiABKAsyGC5taXplci5HYW1lcGFkTm9kZUNvbmZpZ0gAUhFnYW1lcGFkTm9kZUNvbmZpZxJGCg90aHJlc2hvbGRDb25maWcYKyABKAsyGi5taXplci5UaHJlc2hvbGROb2RlQ29uZmlnSABSD3RocmVzaG9sZENvbmZpZxJACg1lbmNvZGVyQ29uZmlnGCwgASgLMhgubWl6ZXIuRW5jb2Rlck5vZGVDb25maWdIAFINZW5jb2RlckNvbmZpZxJGCg9jb250YWluZXJDb25maWcYLSABKAsyGi5taXplci5Db250YWluZXJOb2RlQ29uZmlnSABSD2NvbnRhaW5lckNvbmZpZxI3CgptYXRoQ29uZmlnGC4gASgLMhUubWl6ZXIuTWF0aE5vZGVDb25maWdIAFIKbWF0aENvbmZpZ0IGCgR0eXBl');
@$core.Deprecated('Use oscillatorNodeConfigDescriptor instead')
const OscillatorNodeConfig$json = const {
  '1': 'OscillatorNodeConfig',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.OscillatorNodeConfig.OscillatorType', '10': 'type'},
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
final $typed_data.Uint8List oscillatorNodeConfigDescriptor = $convert.base64Decode('ChRPc2NpbGxhdG9yTm9kZUNvbmZpZxI+CgR0eXBlGAEgASgOMioubWl6ZXIuT3NjaWxsYXRvck5vZGVDb25maWcuT3NjaWxsYXRvclR5cGVSBHR5cGUSFAoFcmF0aW8YAiABKAFSBXJhdGlvEhAKA21heBgDIAEoAVIDbWF4EhAKA21pbhgEIAEoAVIDbWluEhYKBm9mZnNldBgFIAEoAVIGb2Zmc2V0EhgKB3JldmVyc2UYBiABKAhSB3JldmVyc2UiPQoOT3NjaWxsYXRvclR5cGUSCgoGU3F1YXJlEAASCAoEU2luZRABEgcKA1NhdxACEgwKCFRyaWFuZ2xlEAM=');
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
    const {'1': 'steps', '3': 1, '4': 3, '5': 11, '6': '.mizer.SequenceNodeConfig.SequenceStep', '10': 'steps'},
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
final $typed_data.Uint8List sequenceNodeConfigDescriptor = $convert.base64Decode('ChJTZXF1ZW5jZU5vZGVDb25maWcSPAoFc3RlcHMYASADKAsyJi5taXplci5TZXF1ZW5jZU5vZGVDb25maWcuU2VxdWVuY2VTdGVwUgVzdGVwcxpMCgxTZXF1ZW5jZVN0ZXASEgoEdGljaxgBIAEoAVIEdGljaxIUCgV2YWx1ZRgCIAEoAVIFdmFsdWUSEgoEaG9sZBgDIAEoCFIEaG9sZA==');
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
    const {'1': 'control', '3': 2, '4': 1, '5': 14, '6': '.mizer.GamepadNodeConfig.Control', '10': 'control'},
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
final $typed_data.Uint8List gamepadNodeConfigDescriptor = $convert.base64Decode('ChFHYW1lcGFkTm9kZUNvbmZpZxIbCglkZXZpY2VfaWQYASABKAlSCGRldmljZUlkEjoKB2NvbnRyb2wYAiABKA4yIC5taXplci5HYW1lcGFkTm9kZUNvbmZpZy5Db250cm9sUgdjb250cm9sIqoCCgdDb250cm9sEg4KCkxlZnRTdGlja1gQABIOCgpMZWZ0U3RpY2tZEAESDwoLUmlnaHRTdGlja1gQAhIPCgtSaWdodFN0aWNrWRADEg8KC0xlZnRUcmlnZ2VyEAQSEAoMUmlnaHRUcmlnZ2VyEAUSEAoMTGVmdFNob3VsZGVyEAYSEQoNUmlnaHRTaG91bGRlchAHEgkKBVNvdXRoEAgSCAoERWFzdBAJEgkKBU5vcnRoEAoSCAoEV2VzdBALEgoKBlNlbGVjdBAMEgkKBVN0YXJ0EA0SCgoGRHBhZFVwEA4SDAoIRHBhZERvd24QDxIMCghEcGFkTGVmdBAQEg0KCURwYWRSaWdodBAREg0KCUxlZnRTdGljaxASEg4KClJpZ2h0U3RpY2sQEw==');
@$core.Deprecated('Use pixelPatternNodeConfigDescriptor instead')
const PixelPatternNodeConfig$json = const {
  '1': 'PixelPatternNodeConfig',
  '2': const [
    const {'1': 'pattern', '3': 1, '4': 1, '5': 14, '6': '.mizer.PixelPatternNodeConfig.Pattern', '10': 'pattern'},
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
final $typed_data.Uint8List pixelPatternNodeConfigDescriptor = $convert.base64Decode('ChZQaXhlbFBhdHRlcm5Ob2RlQ29uZmlnEj8KB3BhdHRlcm4YASABKA4yJS5taXplci5QaXhlbFBhdHRlcm5Ob2RlQ29uZmlnLlBhdHRlcm5SB3BhdHRlcm4iJwoHUGF0dGVybhIOCgpSZ2JJdGVyYXRlEAASDAoIUmdiU25ha2UQAQ==');
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
    const {'1': 'noteBinding', '3': 2, '4': 1, '5': 11, '6': '.mizer.MidiNodeConfig.NoteBinding', '9': 0, '10': 'noteBinding'},
    const {'1': 'controlBinding', '3': 3, '4': 1, '5': 11, '6': '.mizer.MidiNodeConfig.ControlBinding', '9': 0, '10': 'controlBinding'},
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
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.mizer.MidiNodeConfig.NoteBinding.MidiType', '10': 'type'},
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
final $typed_data.Uint8List midiNodeConfigDescriptor = $convert.base64Decode('Cg5NaWRpTm9kZUNvbmZpZxIWCgZkZXZpY2UYASABKAlSBmRldmljZRJFCgtub3RlQmluZGluZxgCIAEoCzIhLm1pemVyLk1pZGlOb2RlQ29uZmlnLk5vdGVCaW5kaW5nSABSC25vdGVCaW5kaW5nEk4KDmNvbnRyb2xCaW5kaW5nGAMgASgLMiQubWl6ZXIuTWlkaU5vZGVDb25maWcuQ29udHJvbEJpbmRpbmdIAFIOY29udHJvbEJpbmRpbmca0QEKC05vdGVCaW5kaW5nEhgKB2NoYW5uZWwYASABKA1SB2NoYW5uZWwSPgoEdHlwZRgCIAEoDjIqLm1pemVyLk1pZGlOb2RlQ29uZmlnLk5vdGVCaW5kaW5nLk1pZGlUeXBlUgR0eXBlEhIKBHBvcnQYAyABKA1SBHBvcnQSHAoJcmFuZ2VGcm9tGAQgASgNUglyYW5nZUZyb20SGAoHcmFuZ2VUbxgFIAEoDVIHcmFuZ2VUbyIcCghNaWRpVHlwZRIGCgJDQxAAEggKBE5vdGUQARo+Cg5Db250cm9sQmluZGluZxISCgRwYWdlGAEgASgJUgRwYWdlEhgKB2NvbnRyb2wYAiABKAlSB2NvbnRyb2xCCQoHYmluZGluZw==');
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
    const {'1': 'host', '3': 1, '4': 1, '5': 9, '10': 'host'},
    const {'1': 'port', '3': 2, '4': 1, '5': 13, '10': 'port'},
    const {'1': 'path', '3': 3, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'argumentType', '3': 4, '4': 1, '5': 14, '6': '.mizer.OscNodeConfig.ArgumentType', '10': 'argumentType'},
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
final $typed_data.Uint8List oscNodeConfigDescriptor = $convert.base64Decode('Cg1Pc2NOb2RlQ29uZmlnEhIKBGhvc3QYASABKAlSBGhvc3QSEgoEcG9ydBgCIAEoDVIEcG9ydBISCgRwYXRoGAMgASgJUgRwYXRoEkUKDGFyZ3VtZW50VHlwZRgEIAEoDjIhLm1pemVyLk9zY05vZGVDb25maWcuQXJndW1lbnRUeXBlUgxhcmd1bWVudFR5cGUiTQoMQXJndW1lbnRUeXBlEgcKA0ludBAAEgkKBUZsb2F0EAESCAoETG9uZxACEgoKBkRvdWJsZRADEggKBEJvb2wQBBIJCgVDb2xvchAF');
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
    const {'1': 'mode', '3': 1, '4': 1, '5': 14, '6': '.mizer.MergeNodeConfig.MergeMode', '10': 'mode'},
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
final $typed_data.Uint8List mergeNodeConfigDescriptor = $convert.base64Decode('Cg9NZXJnZU5vZGVDb25maWcSNAoEbW9kZRgBIAEoDjIgLm1pemVyLk1lcmdlTm9kZUNvbmZpZy5NZXJnZU1vZGVSBG1vZGUiMAoJTWVyZ2VNb2RlEgoKBkxhdGVzdBAAEgsKB0hpZ2hlc3QQARIKCgZMb3dlc3QQAg==');
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
    const {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.Node', '10': 'nodes'},
  ],
};

/// Descriptor for `ContainerNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List containerNodeConfigDescriptor = $convert.base64Decode('ChNDb250YWluZXJOb2RlQ29uZmlnEiEKBW5vZGVzGAEgAygLMgsubWl6ZXIuTm9kZVIFbm9kZXM=');
@$core.Deprecated('Use mathNodeConfigDescriptor instead')
const MathNodeConfig$json = const {
  '1': 'MathNodeConfig',
  '2': const [
    const {'1': 'mode', '3': 1, '4': 1, '5': 14, '6': '.mizer.MathNodeConfig.Mode', '10': 'mode'},
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
  ],
};

/// Descriptor for `MathNodeConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mathNodeConfigDescriptor = $convert.base64Decode('Cg5NYXRoTm9kZUNvbmZpZxIuCgRtb2RlGAEgASgOMhoubWl6ZXIuTWF0aE5vZGVDb25maWcuTW9kZVIEbW9kZSJHCgRNb2RlEgwKCEFkZGl0aW9uEAASDwoLU3VidHJhY3Rpb24QARISCg5NdWx0aXBsaWNhdGlvbhACEgwKCERpdmlzaW9uEAM=');
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
    const {'1': 'position', '3': 1, '4': 1, '5': 11, '6': '.mizer.NodePosition', '10': 'position'},
    const {'1': 'scale', '3': 2, '4': 1, '5': 1, '10': 'scale'},
    const {'1': 'hidden', '3': 3, '4': 1, '5': 8, '10': 'hidden'},
  ],
};

/// Descriptor for `NodeDesigner`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDesignerDescriptor = $convert.base64Decode('CgxOb2RlRGVzaWduZXISLwoIcG9zaXRpb24YASABKAsyEy5taXplci5Ob2RlUG9zaXRpb25SCHBvc2l0aW9uEhQKBXNjYWxlGAIgASgBUgVzY2FsZRIWCgZoaWRkZW4YAyABKAhSBmhpZGRlbg==');
@$core.Deprecated('Use portDescriptor instead')
const Port$json = const {
  '1': 'Port',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'protocol', '3': 2, '4': 1, '5': 14, '6': '.mizer.ChannelProtocol', '10': 'protocol'},
  ],
};

/// Descriptor for `Port`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portDescriptor = $convert.base64Decode('CgRQb3J0EhIKBG5hbWUYASABKAlSBG5hbWUSMgoIcHJvdG9jb2wYAiABKA4yFi5taXplci5DaGFubmVsUHJvdG9jb2xSCHByb3RvY29s');
