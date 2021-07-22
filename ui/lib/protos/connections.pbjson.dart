///
//  Generated code. Do not modify.
//  source: connections.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const MonitorDmxRequest$json = const {
  '1': 'MonitorDmxRequest',
  '2': const [
    const {'1': 'outputId', '3': 1, '4': 1, '5': 9, '10': 'outputId'},
  ],
};

const MonitorDmxResponse$json = const {
  '1': 'MonitorDmxResponse',
  '2': const [
    const {'1': 'universes', '3': 1, '4': 3, '5': 11, '6': '.mizer.MonitorDmxUniverse', '10': 'universes'},
  ],
};

const MonitorDmxUniverse$json = const {
  '1': 'MonitorDmxUniverse',
  '2': const [
    const {'1': 'universe', '3': 1, '4': 1, '5': 13, '10': 'universe'},
    const {'1': 'channels', '3': 2, '4': 1, '5': 12, '10': 'channels'},
  ],
};

const GetConnectionsRequest$json = const {
  '1': 'GetConnectionsRequest',
};

const Connections$json = const {
  '1': 'Connections',
  '2': const [
    const {'1': 'connections', '3': 1, '4': 3, '5': 11, '6': '.mizer.Connection', '10': 'connections'},
  ],
};

const Connection$json = const {
  '1': 'Connection',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'dmx', '3': 10, '4': 1, '5': 11, '6': '.mizer.DmxConnection', '9': 0, '10': 'dmx'},
    const {'1': 'midi', '3': 11, '4': 1, '5': 11, '6': '.mizer.MidiConnection', '9': 0, '10': 'midi'},
    const {'1': 'osc', '3': 12, '4': 1, '5': 11, '6': '.mizer.OscConnection', '9': 0, '10': 'osc'},
    const {'1': 'proDJLink', '3': 13, '4': 1, '5': 11, '6': '.mizer.ProDjLinkConnection', '9': 0, '10': 'proDJLink'},
    const {'1': 'helios', '3': 14, '4': 1, '5': 11, '6': '.mizer.HeliosConnection', '9': 0, '10': 'helios'},
  ],
  '8': const [
    const {'1': 'connection'},
  ],
};

const DmxConnection$json = const {
  '1': 'DmxConnection',
  '2': const [
    const {'1': 'outputId', '3': 1, '4': 1, '5': 9, '10': 'outputId'},
  ],
};

const HeliosConnection$json = const {
  '1': 'HeliosConnection',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'firmware', '3': 2, '4': 1, '5': 9, '10': 'firmware'},
  ],
};

const MidiConnection$json = const {
  '1': 'MidiConnection',
};

const OscConnection$json = const {
  '1': 'OscConnection',
  '2': const [
    const {'1': 'input_port', '3': 1, '4': 1, '5': 13, '10': 'inputPort'},
    const {'1': 'output_port', '3': 2, '4': 1, '5': 13, '10': 'outputPort'},
    const {'1': 'output_address', '3': 3, '4': 1, '5': 9, '10': 'outputAddress'},
  ],
};

const ProDjLinkConnection$json = const {
  '1': 'ProDjLinkConnection',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'model', '3': 2, '4': 1, '5': 9, '10': 'model'},
    const {'1': 'playerNumber', '3': 3, '4': 1, '5': 13, '10': 'playerNumber'},
    const {'1': 'playback', '3': 5, '4': 1, '5': 11, '6': '.mizer.CdjPlayback', '10': 'playback'},
  ],
};

const CdjPlayback$json = const {
  '1': 'CdjPlayback',
  '2': const [
    const {'1': 'live', '3': 1, '4': 1, '5': 8, '10': 'live'},
    const {'1': 'bpm', '3': 2, '4': 1, '5': 1, '10': 'bpm'},
    const {'1': 'frame', '3': 3, '4': 1, '5': 13, '10': 'frame'},
    const {'1': 'playback', '3': 4, '4': 1, '5': 14, '6': '.mizer.CdjPlayback.State', '10': 'playback'},
    const {'1': 'track', '3': 5, '4': 1, '5': 11, '6': '.mizer.CdjPlayback.Track', '10': 'track'},
  ],
  '3': const [CdjPlayback_Track$json],
  '4': const [CdjPlayback_State$json],
};

const CdjPlayback_Track$json = const {
  '1': 'Track',
  '2': const [
    const {'1': 'artist', '3': 1, '4': 1, '5': 9, '10': 'artist'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
  ],
};

const CdjPlayback_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'Loading', '2': 0},
    const {'1': 'Playing', '2': 1},
    const {'1': 'Cued', '2': 2},
    const {'1': 'Cueing', '2': 3},
  ],
};

