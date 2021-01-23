///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const ChannelProtocol$json = const {
  '1': 'ChannelProtocol',
  '2': const [
    const {'1': 'Dmx', '2': 0},
    const {'1': 'Numeric', '2': 1},
    const {'1': 'Trigger', '2': 2},
    const {'1': 'Clock', '2': 3},
    const {'1': 'Video', '2': 4},
    const {'1': 'Color', '2': 5},
    const {'1': 'Vector', '2': 6},
    const {'1': 'Text', '2': 7},
    const {'1': 'Midi', '2': 8},
    const {'1': 'Timecode', '2': 9},
    const {'1': 'Boolean', '2': 10},
    const {'1': 'Select', '2': 11},
    const {'1': 'Pixels', '2': 12},
  ],
};

const NodesRequest$json = const {
  '1': 'NodesRequest',
};

const Nodes$json = const {
  '1': 'Nodes',
  '2': const [
    const {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.mizer.Node', '10': 'nodes'},
    const {'1': 'channels', '3': 2, '4': 3, '5': 11, '6': '.mizer.NodeConnection', '10': 'channels'},
  ],
};

const NodeConnection$json = const {
  '1': 'NodeConnection',
  '2': const [
    const {'1': 'inputNode', '3': 1, '4': 1, '5': 9, '10': 'inputNode'},
    const {'1': 'inputPort', '3': 2, '4': 1, '5': 11, '6': '.mizer.Port', '10': 'inputPort'},
    const {'1': 'outputNode', '3': 3, '4': 1, '5': 9, '10': 'outputNode'},
    const {'1': 'outputPort', '3': 4, '4': 1, '5': 11, '6': '.mizer.Port', '10': 'outputPort'},
    const {'1': 'protocol', '3': 5, '4': 1, '5': 14, '6': '.mizer.ChannelProtocol', '10': 'protocol'},
  ],
};

const Node$json = const {
  '1': 'Node',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.Node.NodeType', '10': 'type'},
    const {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'inputs', '3': 4, '4': 3, '5': 11, '6': '.mizer.Port', '10': 'inputs'},
    const {'1': 'outputs', '3': 5, '4': 3, '5': 11, '6': '.mizer.Port', '10': 'outputs'},
    const {'1': 'properties', '3': 7, '4': 3, '5': 11, '6': '.mizer.Node.PropertiesEntry', '10': 'properties'},
  ],
  '3': const [Node_PropertiesEntry$json],
  '4': const [Node_NodeType$json],
};

const Node_PropertiesEntry$json = const {
  '1': 'PropertiesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
  '7': const {'7': true},
};

const Node_NodeType$json = const {
  '1': 'NodeType',
  '2': const [
    const {'1': 'Fader', '2': 0},
    const {'1': 'ConvertToDmx', '2': 1},
    const {'1': 'ArtnetOutput', '2': 2},
    const {'1': 'SacnOutput', '2': 3},
    const {'1': 'Oscillator', '2': 4},
    const {'1': 'Clock', '2': 5},
    const {'1': 'OscInput', '2': 6},
    const {'1': 'VideoFile', '2': 7},
    const {'1': 'VideoOutput', '2': 8},
    const {'1': 'VideoEffect', '2': 9},
    const {'1': 'VideoColorBalance', '2': 10},
    const {'1': 'VideoTransform', '2': 11},
    const {'1': 'Script', '2': 12},
    const {'1': 'PixelToDmx', '2': 13},
    const {'1': 'PixelPattern', '2': 14},
    const {'1': 'OpcOutput', '2': 15},
    const {'1': 'Fixture', '2': 16},
    const {'1': 'Sequence', '2': 17},
  ],
};

const Port$json = const {
  '1': 'Port',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'protocol', '3': 2, '4': 1, '5': 14, '6': '.mizer.ChannelProtocol', '10': 'protocol'},
  ],
};

