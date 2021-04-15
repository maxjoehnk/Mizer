///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const ChannelProtocol$json = const {
  '1': 'ChannelProtocol',
  '2': const [
    const {'1': 'Single', '2': 0},
    const {'1': 'Multi', '2': 1},
    const {'1': 'Texture', '2': 2},
    const {'1': 'Vector', '2': 3},
    const {'1': 'Laser', '2': 4},
    const {'1': 'Poly', '2': 5},
    const {'1': 'Data', '2': 6},
    const {'1': 'Material', '2': 7},
    const {'1': 'Gst', '2': 8},
  ],
};

const AddNodeRequest$json = const {
  '1': 'AddNodeRequest',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.Node.NodeType', '10': 'type'},
    const {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.NodePosition', '10': 'position'},
  ],
};

const NodesRequest$json = const {
  '1': 'NodesRequest',
};

const WriteControl$json = const {
  '1': 'WriteControl',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'port', '3': 2, '4': 1, '5': 9, '10': 'port'},
    const {'1': 'value', '3': 3, '4': 1, '5': 1, '10': 'value'},
  ],
};

const WriteResponse$json = const {
  '1': 'WriteResponse',
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
    const {'1': 'targetNode', '3': 1, '4': 1, '5': 9, '10': 'targetNode'},
    const {'1': 'targetPort', '3': 2, '4': 1, '5': 11, '6': '.mizer.Port', '10': 'targetPort'},
    const {'1': 'sourceNode', '3': 3, '4': 1, '5': 9, '10': 'sourceNode'},
    const {'1': 'sourcePort', '3': 4, '4': 1, '5': 11, '6': '.mizer.Port', '10': 'sourcePort'},
    const {'1': 'protocol', '3': 5, '4': 1, '5': 14, '6': '.mizer.ChannelProtocol', '10': 'protocol'},
  ],
};

const Node$json = const {
  '1': 'Node',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.mizer.Node.NodeType', '10': 'type'},
    const {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    const {'1': 'inputs', '3': 3, '4': 3, '5': 11, '6': '.mizer.Port', '10': 'inputs'},
    const {'1': 'outputs', '3': 4, '4': 3, '5': 11, '6': '.mizer.Port', '10': 'outputs'},
    const {'1': 'designer', '3': 5, '4': 1, '5': 11, '6': '.mizer.NodeDesigner', '10': 'designer'},
    const {'1': 'oscillatorConfig', '3': 6, '4': 1, '5': 11, '6': '.mizer.OscillatorNodeConfig', '9': 0, '10': 'oscillatorConfig'},
    const {'1': 'scriptingConfig', '3': 7, '4': 1, '5': 11, '6': '.mizer.ScriptingNodeConfig', '9': 0, '10': 'scriptingConfig'},
    const {'1': 'sequenceConfig', '3': 8, '4': 1, '5': 11, '6': '.mizer.SequenceNodeConfig', '9': 0, '10': 'sequenceConfig'},
    const {'1': 'clockConfig', '3': 9, '4': 1, '5': 11, '6': '.mizer.ClockNodeConfig', '9': 0, '10': 'clockConfig'},
    const {'1': 'fixtureConfig', '3': 10, '4': 1, '5': 11, '6': '.mizer.FixtureNodeConfig', '9': 0, '10': 'fixtureConfig'},
    const {'1': 'buttonConfig', '3': 11, '4': 1, '5': 11, '6': '.mizer.InputNodeConfig', '9': 0, '10': 'buttonConfig'},
    const {'1': 'faderConfig', '3': 12, '4': 1, '5': 11, '6': '.mizer.InputNodeConfig', '9': 0, '10': 'faderConfig'},
    const {'1': 'ildaFileConfig', '3': 15, '4': 1, '5': 11, '6': '.mizer.IldaFileNodeConfig', '9': 0, '10': 'ildaFileConfig'},
    const {'1': 'laserConfig', '3': 16, '4': 1, '5': 11, '6': '.mizer.LaserNodeConfig', '9': 0, '10': 'laserConfig'},
    const {'1': 'pixelPatternConfig', '3': 17, '4': 1, '5': 11, '6': '.mizer.PixelPatternNodeConfig', '9': 0, '10': 'pixelPatternConfig'},
    const {'1': 'pixelDmxConfig', '3': 18, '4': 1, '5': 11, '6': '.mizer.PixelDmxNodeConfig', '9': 0, '10': 'pixelDmxConfig'},
    const {'1': 'dmxOutputConfig', '3': 19, '4': 1, '5': 11, '6': '.mizer.DmxOutputNodeConfig', '9': 0, '10': 'dmxOutputConfig'},
    const {'1': 'midiInputConfig', '3': 20, '4': 1, '5': 11, '6': '.mizer.MidiInputNodeConfig', '9': 0, '10': 'midiInputConfig'},
    const {'1': 'midiOutputConfig', '3': 21, '4': 1, '5': 11, '6': '.mizer.MidiOutputNodeConfig', '9': 0, '10': 'midiOutputConfig'},
    const {'1': 'opcOutputConfig', '3': 22, '4': 1, '5': 11, '6': '.mizer.OpcOutputNodeConfig', '9': 0, '10': 'opcOutputConfig'},
    const {'1': 'oscInputConfig', '3': 23, '4': 1, '5': 11, '6': '.mizer.OscNodeConfig', '9': 0, '10': 'oscInputConfig'},
    const {'1': 'oscOutputConfig', '3': 24, '4': 1, '5': 11, '6': '.mizer.OscNodeConfig', '9': 0, '10': 'oscOutputConfig'},
    const {'1': 'videoColorBalanceConfig', '3': 25, '4': 1, '5': 11, '6': '.mizer.VideoColorBalanceNodeConfig', '9': 0, '10': 'videoColorBalanceConfig'},
    const {'1': 'videoEffectConfig', '3': 26, '4': 1, '5': 11, '6': '.mizer.VideoEffectNodeConfig', '9': 0, '10': 'videoEffectConfig'},
    const {'1': 'videoFileConfig', '3': 27, '4': 1, '5': 11, '6': '.mizer.VideoFileNodeConfig', '9': 0, '10': 'videoFileConfig'},
    const {'1': 'videoOutputConfig', '3': 28, '4': 1, '5': 11, '6': '.mizer.VideoOutputNodeConfig', '9': 0, '10': 'videoOutputConfig'},
    const {'1': 'videoTransformConfig', '3': 29, '4': 1, '5': 11, '6': '.mizer.VideoTransformNodeConfig', '9': 0, '10': 'videoTransformConfig'},
  ],
  '4': const [Node_NodeType$json],
  '8': const [
    const {'1': 'NodeConfig'},
  ],
};

const Node_NodeType$json = const {
  '1': 'NodeType',
  '2': const [
    const {'1': 'Fader', '2': 0},
    const {'1': 'Button', '2': 1},
    const {'1': 'Oscillator', '2': 2},
    const {'1': 'Clock', '2': 3},
    const {'1': 'Script', '2': 4},
    const {'1': 'Fixture', '2': 6},
    const {'1': 'Sequence', '2': 7},
    const {'1': 'DmxOutput', '2': 11},
    const {'1': 'OscInput', '2': 12},
    const {'1': 'OscOutput', '2': 13},
    const {'1': 'MidiInput', '2': 14},
    const {'1': 'MidiOutput', '2': 15},
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
  ],
};

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

const OscillatorNodeConfig_OscillatorType$json = const {
  '1': 'OscillatorType',
  '2': const [
    const {'1': 'Square', '2': 0},
    const {'1': 'Sine', '2': 1},
    const {'1': 'Saw', '2': 2},
    const {'1': 'Triangle', '2': 3},
  ],
};

const ScriptingNodeConfig$json = const {
  '1': 'ScriptingNodeConfig',
  '2': const [
    const {'1': 'script', '3': 1, '4': 1, '5': 9, '10': 'script'},
  ],
};

const SequenceNodeConfig$json = const {
  '1': 'SequenceNodeConfig',
  '2': const [
    const {'1': 'steps', '3': 1, '4': 3, '5': 11, '6': '.mizer.SequenceNodeConfig.SequenceStep', '10': 'steps'},
  ],
  '3': const [SequenceNodeConfig_SequenceStep$json],
};

const SequenceNodeConfig_SequenceStep$json = const {
  '1': 'SequenceStep',
  '2': const [
    const {'1': 'tick', '3': 1, '4': 1, '5': 1, '10': 'tick'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'hold', '3': 3, '4': 1, '5': 8, '10': 'hold'},
  ],
};

const ClockNodeConfig$json = const {
  '1': 'ClockNodeConfig',
  '2': const [
    const {'1': 'speed', '3': 1, '4': 1, '5': 1, '10': 'speed'},
  ],
};

const FixtureNodeConfig$json = const {
  '1': 'FixtureNodeConfig',
  '2': const [
    const {'1': 'fixture_id', '3': 1, '4': 1, '5': 13, '10': 'fixtureId'},
  ],
};

const InputNodeConfig$json = const {
  '1': 'InputNodeConfig',
};

const IldaFileNodeConfig$json = const {
  '1': 'IldaFileNodeConfig',
  '2': const [
    const {'1': 'file', '3': 1, '4': 1, '5': 9, '10': 'file'},
  ],
};

const LaserNodeConfig$json = const {
  '1': 'LaserNodeConfig',
  '2': const [
    const {'1': 'device_id', '3': 1, '4': 1, '5': 9, '10': 'deviceId'},
  ],
};

const PixelPatternNodeConfig$json = const {
  '1': 'PixelPatternNodeConfig',
  '2': const [
    const {'1': 'pattern', '3': 1, '4': 1, '5': 14, '6': '.mizer.PixelPatternNodeConfig.Pattern', '10': 'pattern'},
  ],
  '4': const [PixelPatternNodeConfig_Pattern$json],
};

const PixelPatternNodeConfig_Pattern$json = const {
  '1': 'Pattern',
  '2': const [
    const {'1': 'RgbIterate', '2': 0},
    const {'1': 'RgbSnake', '2': 1},
  ],
};

const PixelDmxNodeConfig$json = const {
  '1': 'PixelDmxNodeConfig',
  '2': const [
    const {'1': 'width', '3': 1, '4': 1, '5': 4, '10': 'width'},
    const {'1': 'height', '3': 2, '4': 1, '5': 4, '10': 'height'},
    const {'1': 'start_universe', '3': 3, '4': 1, '5': 13, '10': 'startUniverse'},
    const {'1': 'output', '3': 4, '4': 1, '5': 9, '10': 'output'},
  ],
};

const DmxOutputNodeConfig$json = const {
  '1': 'DmxOutputNodeConfig',
  '2': const [
    const {'1': 'output', '3': 1, '4': 1, '5': 9, '10': 'output'},
    const {'1': 'universe', '3': 2, '4': 1, '5': 13, '10': 'universe'},
    const {'1': 'channel', '3': 3, '4': 1, '5': 13, '10': 'channel'},
  ],
};

const MidiInputNodeConfig$json = const {
  '1': 'MidiInputNodeConfig',
};

const MidiOutputNodeConfig$json = const {
  '1': 'MidiOutputNodeConfig',
};

const OpcOutputNodeConfig$json = const {
  '1': 'OpcOutputNodeConfig',
  '2': const [
    const {'1': 'host', '3': 1, '4': 1, '5': 9, '10': 'host'},
    const {'1': 'port', '3': 2, '4': 1, '5': 13, '10': 'port'},
    const {'1': 'width', '3': 3, '4': 1, '5': 4, '10': 'width'},
    const {'1': 'height', '3': 4, '4': 1, '5': 4, '10': 'height'},
  ],
};

const OscNodeConfig$json = const {
  '1': 'OscNodeConfig',
  '2': const [
    const {'1': 'host', '3': 1, '4': 1, '5': 9, '10': 'host'},
    const {'1': 'port', '3': 2, '4': 1, '5': 13, '10': 'port'},
    const {'1': 'path', '3': 3, '4': 1, '5': 9, '10': 'path'},
  ],
};

const VideoColorBalanceNodeConfig$json = const {
  '1': 'VideoColorBalanceNodeConfig',
};

const VideoEffectNodeConfig$json = const {
  '1': 'VideoEffectNodeConfig',
};

const VideoFileNodeConfig$json = const {
  '1': 'VideoFileNodeConfig',
  '2': const [
    const {'1': 'file', '3': 1, '4': 1, '5': 9, '10': 'file'},
  ],
};

const VideoOutputNodeConfig$json = const {
  '1': 'VideoOutputNodeConfig',
};

const VideoTransformNodeConfig$json = const {
  '1': 'VideoTransformNodeConfig',
};

const NodePosition$json = const {
  '1': 'NodePosition',
  '2': const [
    const {'1': 'x', '3': 1, '4': 1, '5': 1, '10': 'x'},
    const {'1': 'y', '3': 2, '4': 1, '5': 1, '10': 'y'},
  ],
};

const NodeDesigner$json = const {
  '1': 'NodeDesigner',
  '2': const [
    const {'1': 'position', '3': 1, '4': 1, '5': 11, '6': '.mizer.NodePosition', '10': 'position'},
    const {'1': 'scale', '3': 2, '4': 1, '5': 1, '10': 'scale'},
  ],
};

const Port$json = const {
  '1': 'Port',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'protocol', '3': 2, '4': 1, '5': 14, '6': '.mizer.ChannelProtocol', '10': 'protocol'},
  ],
};

